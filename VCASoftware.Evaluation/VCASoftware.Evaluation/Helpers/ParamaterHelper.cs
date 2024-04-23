namespace VCASoftware.Evaluation.Helpers;

public static class NullCheckHelper
{
    public static void NotNull(object value, string paramName)
    {
        if (value == null)
        {
            throw new ArgumentNullException(paramName);
        }
    }
}
