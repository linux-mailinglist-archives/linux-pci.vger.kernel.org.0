Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A733DE60
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 21:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbhCPUEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbhCPUEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 16:04:01 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCBFC061756
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 13:03:58 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id f1so8772493vsl.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPipVrGjrQxxmOVNuIBzPVnIBTu28PmDlzKg2GNjQ4w=;
        b=jLKEmdBUcOmVx8BH5FH0Ob7hA8LYXzgzXgnZMFC8OWxGFK5gLNFUvYq5UBkcaV/n41
         CSl9uXuZ7eDzrE2Fbe0XkoiYcR4AJrhOccfdB9QfenGbjAk0C9jdHjDf9BCcATIjVYYg
         owlni7aiSYTIvNMMwzfTN9SnEW+uBh/c1uegSZD6E9XDNabL1D08DeDVknFjQIudReZw
         C8dYJ63NTGSs0myOcXqDM3Y4Jfv73XY4JW683l+9vzY3GBTBtHxd1eG46i28rLBGgtdU
         pBOZB91O8b9qyb+3Glvu8Usyw/QlArRStp0AN1ymV9JeSR2HCQ23dAeQdVkjzQCDqhMF
         7org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPipVrGjrQxxmOVNuIBzPVnIBTu28PmDlzKg2GNjQ4w=;
        b=oTMbSpaGNM3G1OmOKloEaZNn+pv3ESjoToLJpAE67d3DSYQx6HOay6cibK38Ko+H8w
         n+njyIPDTno0Zw7xVpvbJhgx1q9zn+72Cl1gGVMll4tXFm3qyUUb5bFu+NG0AVThfz60
         hrj+ZlATGREcd8uhfgCVMT6wTxd9PoHEYK+cfMmnZvVJf7pO2FGt3DIPly4829YZri74
         3E/S9QI6WLbv76ATFYcIeLhMmW5v7BnwE/PEyLRLpeiNeYaBJuDXVT3Q5U5/SQKhAZxd
         ymMaQzQNrxXWN0CcHJzJRfyjrQirrMfjFjnzd8u9Pz954TKK9hTy9tp+hIfxtYGULfSO
         8Cqg==
X-Gm-Message-State: AOAM533SEUKsAVq3f11ZALUYi2gbenBWSZ1O0q3GfO0L/ADNAIz7zrlq
        zRyhcQ5lbPcWZoEilFzfXVp44vpK2nxKzZrNEsAJQw==
X-Google-Smtp-Source: ABdhPJw6NBRUZ2FvsaUUCbc1zBpRsZS9KPX4N/MlU3I48neHaroJmlDX4wAt9eD3uv9HshZ02/cu3wPksGKViLa1RVs=
X-Received: by 2002:a67:db98:: with SMTP id f24mr1041028vsk.13.1615925037456;
 Tue, 16 Mar 2021 13:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-5-samitolvanen@google.com> <202103111837.813997B4@keescook>
In-Reply-To: <202103111837.813997B4@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:03:45 -0700
Message-ID: <CABCJKucW8dwXzEK-NZEHyQzN1wu-sGOiOqXFfR=C-PHvsn1+Dg@mail.gmail.com>
Subject: Re: [PATCH 04/17] module: cfi: ensure __cfi_check alignment
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 6:39 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:06PM -0800, Sami Tolvanen wrote:
> > CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
> > aligned and at the beginning of the .text section. While Clang would
> > normally align the function correctly, it fails to do so for modules
> > with no executable code.
> >
> > This change ensures the correct __cfi_check() location and
> > alignment. It also discards the .eh_frame section, which Clang can
> > generate with certain sanitizers, such as CFI.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=46293
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  scripts/module.lds.S | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > index 168cd27e6122..552ddb084f76 100644
> > --- a/scripts/module.lds.S
> > +++ b/scripts/module.lds.S
> > @@ -3,10 +3,13 @@
> >   * Archs are free to supply their own linker scripts.  ld will
> >   * combine them automatically.
> >   */
> > +#include <asm/page.h>
> > +
> >  SECTIONS {
> >       /DISCARD/ : {
> >               *(.discard)
> >               *(.discard.*)
> > +             *(.eh_frame)
> >       }
> >
> >       __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> > @@ -40,7 +43,16 @@ SECTIONS {
> >               *(.rodata..L*)
> >       }
> >
> > -     .text : { *(.text .text.[0-9a-zA-Z_]*) }
> > +#ifdef CONFIG_CFI_CLANG
> > +     /*
> > +      * With CFI_CLANG, ensure __cfi_check is at the beginning of the
> > +      * .text section, and that the section is aligned to page size.
> > +      */
> > +     .text : ALIGN(PAGE_SIZE) {
> > +             *(.text.__cfi_check)
> > +             *(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
> > +     }
> > +#endif
>
> Whoops, I think this reverts to the default .text declaration when
> CONFIG_CFI_CLANG is unset.

Oops, thanks for pointing this out. I'll fix it in v2.

> I think the only thing that needs the ifdef is the ALIGN, yes? Perhaps
> something like this?
>
> #ifdef CONFIG_CFI_CLANG
> # define ALIGN_CFI ALIGN(PAGE_SIZE)
> #else
> # define ALIGN_CFI
> #endif
>
>         .text : ALIGN_CFI {
>                 *(.text.__cfi_check)
>                 *(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
>         }

Agreed, that looks better.

Sami
