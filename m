Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C9327F4EA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgI3WND (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbgI3WNC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 18:13:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE97C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 15:13:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i1so3569330edv.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5JyINSMzWB8voXWZyV8ASlSh5pqRDmgZFl229b53xc=;
        b=vIRIWKYp7RTSUGB8ntUgtpTfuIX9PNECXrtz7OF4WuzjxaB6ucqKe+labxFFw91k3e
         QxLYAkxotsyYRcimIeAn7Z8xictu3hpLg464s+yhLPGoBBznroXq6KWSnvggTT+OKc+4
         aDiohWxi2bv6qcv/jsb8X6MLhFKoc5VlhLVAgI9mvRP+ESLwvXgjzFulM/aycHPXZ43C
         1PZWgQU//0UlvKQQQTsVxdhKKn2R1cZHSse1ucxAjFxlIjoTBB5mxWh5AjLIfsBpQ8Qr
         kwHSrW70qM469yHzjDZCiyJ6JH0YYN8N5o79By5EDLYjMuAR2Pr4Z/ShSwy2ytzZ+9o+
         xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5JyINSMzWB8voXWZyV8ASlSh5pqRDmgZFl229b53xc=;
        b=DF01BdGsKjzkIO9ijJwJVHDxOOgMhZX++8d20ShYR2ZKTCghQwD15KmqVXrLqOCD7A
         6vU/+UYLwv2+om6uTbmfm95/LfUIH+qxnIgs3kBpQiMCs8D/aSY9O/o3Hk9DdW8Nuab7
         3cFKQdKYeR2gomU9KAIUWb1IApHlTLrzxHDsseMdCDv7v/i8ONYzzb6/ixjvYHpb1ojJ
         uQC+bUr7TzTsObaxizkiodiYpJRM9bbtBuURZikJ8KMu/xY7IsHSEV2fy9ouYPAFBHlS
         EDgkcaP0tB01ayPldXLF7+/7xDAPwdTkwKahfy4wargtAhzOWe7L5MAAAGQoZL8sAy99
         SW/w==
X-Gm-Message-State: AOAM531VMCCQ3Q8UgdDCpLGjPG0jGy16ykuV9YTKNyi44TO1qbPRiI6c
        0csYlmuEu/kSTXwG4JXGGH8W7jsqSKAMF6Gh4+lnSA==
X-Google-Smtp-Source: ABdhPJzjWahTDCS64Nwdg2Qz+9IkGNUdbgNKy/rFx3FC7CVjfHrBmMTaxElMCOz9QatJ5KolJbRCcmnwy3926ope18M=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr5304520edp.40.1601503980129;
 Wed, 30 Sep 2020 15:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com> <CAKwvOdnYBkUx9YpY9XLONbNYFD7JrOfGbRFQ8ZTf-sa2GTgQdQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnYBkUx9YpY9XLONbNYFD7JrOfGbRFQ8ZTf-sa2GTgQdQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 30 Sep 2020 15:12:49 -0700
Message-ID: <CABCJKufUU=s6GcRCRcmuKnANtyyKEBNJVuaPw416C1OPNgywEQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] Add support for Clang LTO
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 2:58 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 29, 2020 at 2:46 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is
> > to allow Clang's Control-Flow Integrity (CFI) to be used in the
> > kernel. Google has shipped millions of Pixel devices running three
> > major kernel versions with LTO+CFI since 2018.
> >
> > Most of the patches are build system changes for handling LLVM
> > bitcode, which Clang produces with LTO instead of ELF object files,
> > postponing ELF processing until a later stage, and ensuring initcall
> > ordering.
>
> Sami, thanks for continuing to drive the series. I encourage you to
> keep resending with fixes accumulated or dropped on a weekly cadence.
>
> The series worked well for me on arm64, but for x86_64 on mainline I
> saw a stream of new objtool warnings:
[...]

Objtool normally won't print out these warnings when run on vmlinux.o,
but we can't pass --vmlinux to objtool as that also implies noinstr
validation right now. I think we'd have to split that from --vmlinux
to avoid these. I can include a patch to add a --noinstr flag in v5.
Peter, any thoughts about this?

> I think those should be resolved before I provide any kind of tested
> by tag.  My other piece of feedback was that I like the default
> ThinLTO, but I think the help text in the Kconfig which is visible
> during menuconfig could be improved by informing the user the
> tradeoffs.  For example, if CONFIG_THINLTO is disabled, it should be
> noted that full LTO will be used instead.  Also, that full LTO may
> produce slightly better optimized binaries than ThinLTO, at the cost
> of not utilizing multiple cores when linking and thus significantly
> slower to link.
>
> Maybe explaining that setting it to "n" implies a full LTO build,
> which will be much slower to link but possibly slightly faster would
> be good?  It's not visible unless LTO_CLANG and ARCH_SUPPORTS_THINLTO
> is enabled, so I don't think you need to explain that THINLTO without
> those is *not* full LTO.  I'll leave the precise wording to you. WDYT?

Sure, sounds good. I'll update the help text in the next version.

> Also, when I look at your treewide DISABLE_LTO patch, I think "does
> that need to be a part of this series, or is it a cleanup that can
> stand on its own?"  I think it may be the latter?  Maybe it would help
> shed one more patch than to have to carry it to just send it?  Or did
> I miss something as to why it should remain a part of this series?

I suppose it could be stand-alone, but as these patches are also
disabling LTO by filtering out flags in some of the same files,
removing the unused DISABLE_LTO flags first would reduce confusion.
But I'm fine with sending it separately too if that's preferred.

Sami
