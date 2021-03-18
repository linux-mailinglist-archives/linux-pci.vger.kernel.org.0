Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD98340D78
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 19:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhCRSpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhCRSpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 14:45:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58390C061762
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 11:45:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z7so6182325lfd.5
        for <linux-pci@vger.kernel.org>; Thu, 18 Mar 2021 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXJ1Kpw2oRWiOPlZvmgzPqNpjS+OST6GpCVGaYkcfjU=;
        b=KVhzG/Xt0d2tzVy7gn9DeiCmjSKqLb+wM+t8KT/0yYxikiuuU7zFmWYcGH7rBKFF2b
         AtHQOK1YfGzGRBG0KZ4thwg0+JZusdpXujSogBcYD6D0hMB/V73nccM2C6cWPSHOEUQU
         a1mayCuYUN57wUJaEJfG9UApRea4LPqYff1TlxP6DG3qTXu7cW9ElW4rVEx+PacKVcM4
         1ObbqRp1qWL2rwPmFRQgVM7VmPubsIbfCjOIIgk5xp14ryEBC3GPnUcfaEyo/ZkGvVMu
         jDzsbdtLYDpL+BtsNICkUJ0UHfPoPDJ1i7+u6wbVW+hhoK4xDwxigkc/8xNcpzwV8JYt
         uF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXJ1Kpw2oRWiOPlZvmgzPqNpjS+OST6GpCVGaYkcfjU=;
        b=fcG2nTUCuzg8ijohwND5gT0t+AqoVGSm3AFc9C4aEpjvEg9Lvw3ghPobTlbQjqYgso
         WSRynR5GICEdbOu6juzj5TZ/5RxLvk+TmVYr9SVSeByWJ+sHnDhIQFM4/PWyQaFnyUVU
         0K8mToZqkqFyHM7GkZCB9nUIgm+MuwOQWr9MjO5k8PyQ3HwITQ5fIvHdeuLOr34Tr5Mc
         9pCFpS2UxT8iU9Und6fmBEDqKEFHbIGDqaOVxeCALVDkzjHM/R/2RUnbRHw8N+JtEIAb
         +U3otHk6vF26erKSEymdO1Y8m224znfoRhVsaULB4vMMwmVNunZkpjpXm+ojadDhOPdI
         9H7Q==
X-Gm-Message-State: AOAM531Jn0CEV9ME+dQvEDbWg4YZ9a/sRDMDYubR5j9Qo76eNmRAgBJx
        rC/JE3cCChpaqZaSqgL/d/pw87P5pHUPhtbRWpE6cw==
X-Google-Smtp-Source: ABdhPJzI/cXQgUy2RSLmNuSxvjB8uEjk+GLf2aUWomqyxgvUmHefmj8Y6oB/C1sojY9blIJSTxDq0p15b1fs89u6VoM=
X-Received: by 2002:ac2:538e:: with SMTP id g14mr6055632lfh.543.1616093139630;
 Thu, 18 Mar 2021 11:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-11-samitolvanen@google.com> <CAKwvOdkn7MY+-9D0DQ-18OR=s1XmgPaP7VchCm6VV5kYuKSAkA@mail.gmail.com>
In-Reply-To: <CAKwvOdkn7MY+-9D0DQ-18OR=s1XmgPaP7VchCm6VV5kYuKSAkA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 11:45:28 -0700
Message-ID: <CAKwvOdk7wg-BoE=A0wN6Oz7ptK4y2_YHUBNTTc80CvWuY=nF3Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] lkdtm: use __va_function
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 11:43 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > To ensure we take the actual address of a function in kernel text, use
> > __va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
> > the address with a pointer to the CFI jump table, which is actually in
> > the module when compiled with CONFIG_LKDTM=m.
>
> Should patch 10 and 12 be reordered against one another? Otherwise it
> looks like 12 defines __va_function while 10 uses it?

Ah, nvm patch 3 defines a generic version, I see.

>
>
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/misc/lkdtm/usercopy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
> > index 109e8d4302c1..d173d6175c87 100644
> > --- a/drivers/misc/lkdtm/usercopy.c
> > +++ b/drivers/misc/lkdtm/usercopy.c
> > @@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
> >
> >         pr_info("attempting bad copy_to_user from kernel text: %px\n",
> >                 vm_mmap);
> > -       if (copy_to_user((void __user *)user_addr, vm_mmap,
> > +       if (copy_to_user((void __user *)user_addr, __va_function(vm_mmap),
> >                          unconst + PAGE_SIZE)) {
> >                 pr_warn("copy_to_user failed, but lacked Oops\n");
> >                 goto free_user;
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
