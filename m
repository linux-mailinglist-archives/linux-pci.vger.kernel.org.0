Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07E6207F15
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgFXWFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 18:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388445AbgFXWFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 18:05:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D3C061796
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 15:05:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so1871655pjd.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xltSa+pOLgf6vSXNCg3Iy8gwRMudEIRX75C87X2gOqg=;
        b=MgAD5KdkoqXJfDMbYByeG9yy1WHD48fSG3E81h/9u2g6EmmOWXUynVOutBJ7t4vwAB
         psHe+EScWfsNCT5NBNrD4GqWZP9tUl+Kpp9FOICNYptFXA/r3FSM00oRybctU7BcYLkc
         xYuC/5NF2tPShhkqyHcGrMMH1bG1eOdc5yVDaWWtA6Pacgr2HqQK7HSqkFcx8JuPz7+l
         Bh6GmKIzyu2FWzCTSTFxVBAp3kMrEdSubXvgyg8U9SuaeGoSsA+M/E/Cs06190t4Npt5
         nJfTobePwPdZokQYEfx1V+EhA02ju497XZgaKKA3UcFgUsazmRzB5B+R1GtnDyuhmE5I
         0efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xltSa+pOLgf6vSXNCg3Iy8gwRMudEIRX75C87X2gOqg=;
        b=e4OYzBlpSsalONfNOmbRefLP9MqNzSeix+bczi8OUR1IpAIYs1UwtJAJ1NqXKiPPod
         bfV96BNirjTZKuo2uOd2UHDG73sCzzuVGExiXETTn93L1bcxZ73Wfj75qSzk48KiHr4M
         rN+XSUqh7XKIRhwxZGMHXTQuWwLEmTGxoCAT7icE1k1MPKXzDsp1Z2KmmgKIMx0NL5or
         W/4yFVbRgSNWFsCYg2nElQQ2/64ZvpBEOxYlxVTb6IWWOCUyfqPxd1rBFArnI4nkFl2X
         ywPgHz+7t0/qqDP1S1XaMfWIX4CuDNcyp7AOuAqRVI1uS1HqWmj6ON74kU95hOcf0RKa
         g3ZQ==
X-Gm-Message-State: AOAM532rzc9IwOjDXxqYI1OpE1RFaT1PcGkS9aZ3OC3GoVVcVQrvPJds
        DFaj4B4QcmSHssMpNvUCaB5xdvIUWawkDbAFdkXUZQ==
X-Google-Smtp-Source: ABdhPJyHAGRnDa0sY6/O0q6u9SsVNEVG0+Kq/qe9woI291mBi0WzcIUCyrpkoCKrtdGX8Zo26zOr7JzSk6uu8KVpUDY=
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13mr19785027plr.119.1593036338270;
 Wed, 24 Jun 2020 15:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-13-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-13-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 15:05:26 -0700
Message-ID: <CAKwvOdkgXpxyV6UOpwh1O-_miu4O7pMDaSys=7BYg6jDZ-ox-A@mail.gmail.com>
Subject: Re: [PATCH 12/22] modpost: lto: strip .lto from module names
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With LTO, everything is compiled into LLVM bitcode, so we have to link
> each module into native code before modpost. Kbuild uses the .lto.o
> suffix for these files, which also ends up in module information. This
> change strips the unnecessary .lto suffix from the module name.
>
> Suggested-by: Bill Wendling <morbo@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/mod/modpost.c    | 16 +++++++---------
>  scripts/mod/modpost.h    |  9 +++++++++
>  scripts/mod/sumversion.c |  6 +++++-
>  3 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6aea65c65745..8352f8a1a138 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -17,7 +17,6 @@
>  #include <ctype.h>
>  #include <string.h>
>  #include <limits.h>
> -#include <stdbool.h>

It looks like `bool` is used in the function signatures of other
functions in this TU, I'm not the biggest fan of hoisting the includes
out of the .c source into the header (I'd keep it in both), but I
don't feel strongly enough to NACK.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>  #include <errno.h>
>  #include "modpost.h"
>  #include "../../include/linux/license.h"
> @@ -80,14 +79,6 @@ modpost_log(enum loglevel loglevel, const char *fmt, ...)
>                 exit(1);
>  }
>
> -static inline bool strends(const char *str, const char *postfix)
> -{
> -       if (strlen(str) < strlen(postfix))
> -               return false;
> -
> -       return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
> -}
> -
>  void *do_nofail(void *ptr, const char *expr)
>  {
>         if (!ptr)
> @@ -1975,6 +1966,10 @@ static char *remove_dot(char *s)
>                 size_t m = strspn(s + n + 1, "0123456789");
>                 if (m && (s[n + m] == '.' || s[n + m] == 0))
>                         s[n] = 0;
> +
> +               /* strip trailing .lto */
> +               if (strends(s, ".lto"))
> +                       s[strlen(s) - 4] = '\0';
>         }
>         return s;
>  }
> @@ -1998,6 +1993,9 @@ static void read_symbols(const char *modname)
>                 /* strip trailing .o */
>                 tmp = NOFAIL(strdup(modname));
>                 tmp[strlen(tmp) - 2] = '\0';
> +               /* strip trailing .lto */
> +               if (strends(tmp, ".lto"))
> +                       tmp[strlen(tmp) - 4] = '\0';
>                 mod = new_module(tmp);
>                 free(tmp);
>         }
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 3aa052722233..fab30d201f9e 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -2,6 +2,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> +#include <stdbool.h>
>  #include <string.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -180,6 +181,14 @@ static inline unsigned int get_secindex(const struct elf_info *info,
>         return info->symtab_shndx_start[sym - info->symtab_start];
>  }
>
> +static inline bool strends(const char *str, const char *postfix)
> +{
> +       if (strlen(str) < strlen(postfix))
> +               return false;
> +
> +       return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
> +}
> +
>  /* file2alias.c */
>  extern unsigned int cross_build;
>  void handle_moddevtable(struct module *mod, struct elf_info *info,
> diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
> index d587f40f1117..760e6baa7eda 100644
> --- a/scripts/mod/sumversion.c
> +++ b/scripts/mod/sumversion.c
> @@ -391,10 +391,14 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
>         struct md4_ctx md;
>         char *fname;
>         char filelist[PATH_MAX + 1];
> +       int postfix_len = 1;
> +
> +       if (strends(modname, ".lto.o"))
> +               postfix_len = 5;
>
>         /* objects for a module are listed in the first line of *.mod file. */
>         snprintf(filelist, sizeof(filelist), "%.*smod",
> -                (int)strlen(modname) - 1, modname);
> +                (int)strlen(modname) - postfix_len, modname);
>
>         buf = read_text_file(filelist);
>
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
