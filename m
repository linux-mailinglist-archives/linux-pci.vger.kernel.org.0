Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD4928E9CF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 03:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgJOBTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 21:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388267AbgJOBTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 21:19:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A8C05110A
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 15:54:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so594841pju.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2020 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q8SxKFJ37keEA3fcjeZ0MUjIlmAhyy2Ds4RMjo12YH0=;
        b=QpUrFNEHB+eD+KCRl2HFxnlSp1vyTwWjRHJ5V7CaCjVOqpSlZIknEXyWQPVpbQ+cM1
         3i42ZiG9dAhIxqD8odiXtSLMX3J6wsygKL5cMccgJlHcYjee0k8wg7sSqGzv5GnU6ZI3
         skUQeZ1p5r7C9RZcDY+bIpWwe/Uz2In5VWAfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q8SxKFJ37keEA3fcjeZ0MUjIlmAhyy2Ds4RMjo12YH0=;
        b=BWQ2b/N8enh4cbxZZE2+esTfMRxvVvZg9xJT7PN54QomrC7Fri+uvS51CP6FrUd+30
         4AiX2Ef3NR1DHsJsTIynadxJYvZHmIxGVYdTd/zFGhqevgs5wGiLqcWqMA2j9KKFSPIo
         rCiVjxLxkITh93O2Vz6NRN99PdDgEy0bJda0seHx597OQSkF/vGrVhK00QBX0gwxvSoO
         p49OJbFDYnHYeYtZ2Popnk3va52kfnffFxxdEUEfn3nfAWlU02Gobf2DlCuBFP+YTClu
         /TNljbsU/CTG7TosrT1dL7DFtioPt7gPl97CpDBVqFZiyW34Q9y/Enc9sKRXKJePL4FC
         EDow==
X-Gm-Message-State: AOAM53081FwqI7NG+06kXKDDFZxlJXOBtzjYnsm7lHCdBqer9jsAW45d
        NggGHDjLkA5PO5rQv/PPCrQgNg==
X-Google-Smtp-Source: ABdhPJwJ4ghnrKefm3Ds7OP+vaaqBOqNCgcbWcY/kWoZDzqVnqAP2a2SLXiCE9xOBsgOh/pHszIHUg==
X-Received: by 2002:a17:90a:cb91:: with SMTP id a17mr1300337pju.220.1602716041061;
        Wed, 14 Oct 2020 15:54:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm643943pjs.18.2020.10.14.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:54:00 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:53:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 16/25] init: lto: fix PREL32 relocations
Message-ID: <202010141552.9172003F6A@keescook>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013003203.4168817-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 05:31:54PM -0700, Sami Tolvanen wrote:
> With LTO, the compiler can rename static functions to avoid global
> naming collisions. As initcall functions are typically static,
> renaming can break references to them in inline assembly. This
> change adds a global stub with a stable name for each initcall to
> fix the issue when PREL32 relocations are used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

This is another independent improvement... this could land before the
other portions of the series.

-Kees

> ---
>  include/linux/init.h | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/init.h b/include/linux/init.h
> index af638cd6dd52..cea63f7e7705 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -209,26 +209,49 @@ extern bool initcall_debug;
>   */
>  #define __initcall_section(__sec, __iid)			\
>  	#__sec ".init.." #__iid
> +
> +/*
> + * With LTO, the compiler can rename static functions to avoid
> + * global naming collisions. We use a global stub function for
> + * initcalls to create a stable symbol name whose address can be
> + * taken in inline assembly when PREL32 relocations are used.
> + */
> +#define __initcall_stub(fn, __iid, id)				\
> +	__initcall_name(initstub, __iid, id)
> +
> +#define __define_initcall_stub(__stub, fn)			\
> +	int __init __stub(void);				\
> +	int __init __stub(void)					\
> +	{ 							\
> +		return fn();					\
> +	}							\
> +	__ADDRESSABLE(__stub)
>  #else
>  #define __initcall_section(__sec, __iid)			\
>  	#__sec ".init"
> +
> +#define __initcall_stub(fn, __iid, id)	fn
> +
> +#define __define_initcall_stub(__stub, fn)			\
> +	__ADDRESSABLE(fn)
>  #endif
>  
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> -#define ____define_initcall(fn, __name, __sec)			\
> -	__ADDRESSABLE(fn)					\
> +#define ____define_initcall(fn, __stub, __name, __sec)		\
> +	__define_initcall_stub(__stub, fn)			\
>  	asm(".section	\"" __sec "\", \"a\"		\n"	\
>  	    __stringify(__name) ":			\n"	\
> -	    ".long	" #fn " - .			\n"	\
> +	    ".long	" __stringify(__stub) " - .	\n"	\
>  	    ".previous					\n");
>  #else
> -#define ____define_initcall(fn, __name, __sec)			\
> +#define ____define_initcall(fn, __unused, __name, __sec)	\
>  	static initcall_t __name __used 			\
>  		__attribute__((__section__(__sec))) = fn;
>  #endif
>  
>  #define __unique_initcall(fn, id, __sec, __iid)			\
>  	____define_initcall(fn,					\
> +		__initcall_stub(fn, __iid, id),			\
>  		__initcall_name(initcall, __iid, id),		\
>  		__initcall_section(__sec, __iid))
>  
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

-- 
Kees Cook
