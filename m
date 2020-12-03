Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D872CCADF
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 01:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgLCAIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 19:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCAIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2020 19:08:46 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1670BC0613D6
        for <linux-pci@vger.kernel.org>; Wed,  2 Dec 2020 16:08:06 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id iq13so93937pjb.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Dec 2020 16:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEzbS1TJpZr1zlUaIzJZNjxvOX/ycdroxO9B6D39hfs=;
        b=XgE4hFlRnyVhoAVXKZpoORytuCszXHlvqvjFiWoMfDwKLHMBAJiLtfdxPUF1Ds0rUD
         hMy53TCCB3trdymTPnhD/EpvivzoOAAQAXZxETeYSC6+cHzGVMjT4trKGbcy7mVBPbhc
         EU9XgJtJIhJthGXtFVvljVzi3G5x0AhpPonp2pZCSVp8N7AtEqRR1TIcbgMo+e0jsZ0Z
         Hc665Mzj1QqTEsrYINBIu3TQZCrLkjHzzC62HS4Y70oidn18XQ6vsN8XwIZCJ0FsFltb
         h9glLD+E7xt4OobgWoc6JZBfXamL35QVqKIzdutURzOaZO1KrXt6o7P69HgMN+nPfgD4
         oNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEzbS1TJpZr1zlUaIzJZNjxvOX/ycdroxO9B6D39hfs=;
        b=WZalEgQDNg5Xdrc+V3XBhORT+f/CCLNRl0FHBa6g8pnl1M5gXRW+OwUGxgf2TGY8gr
         /y84E+Hy63qZNB8inE7iTb1nmCUB2gi4D+tSdOH4QKJ9BK97CK1t3HADGgbXbYfPvBDH
         PgoqARAiimyA+GbCgBtPJ02DYJbyDz153qxKWfypCp2Wozb66NIaifXgZ0LG9lKqnDhH
         wU9jWmBMcopgESSFLRu1HKejFBEHvyt6sWCkIyS+KleUWFasz92p4O5QoDYWRtvmUQgE
         6UExHKSX5Fmh7pIPSIVyIapUd5eomCLRmp9AMeZGeU4eWlMIBJtmdiETA+iUbZOZ4kKR
         mbzg==
X-Gm-Message-State: AOAM531iwa3tFp9i6rhwvN07xfx0Nru6fhG28iBg/Zd4vdBl7OHjf40F
        HCOoJfgvHw7qqJdZAytNi2wmMX26Q8xEM+lO+EKbwA==
X-Google-Smtp-Source: ABdhPJxh5zUiuI3zegBWmp1u5W+iEQWahGQXosx3cw1T/85XuGQ1Dy4mBr13tbY0tFMQnXyVMrg3wK85B+/nchXJ1Jw=
X-Received: by 2002:a17:90a:2e8c:: with SMTP id r12mr413591pjd.101.1606954085432;
 Wed, 02 Dec 2020 16:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com> <20201201213707.541432-3-samitolvanen@google.com>
In-Reply-To: <20201201213707.541432-3-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Dec 2020 16:07:54 -0800
Message-ID: <CAKwvOdmfbsTN6GtHwvkgJ=12mBhUzmAgSGtnvA-bRw4tYYZ+BQ@mail.gmail.com>
Subject: Re: [PATCH v8 02/16] kbuild: add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 1, 2020 at 1:37 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This change adds build system support for Clang's Link Time
> Optimization (LTO). With -flto, instead of ELF object files, Clang
> produces LLVM bitcode, which is compiled into native code at link
> time, allowing the final binary to be optimized globally. For more
> details, see:
>
>   https://llvm.org/docs/LinkTimeOptimization.html
>
> The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
> which defaults to LTO being disabled. To use LTO, the architecture
> must select ARCH_SUPPORTS_LTO_CLANG and support:
>
>   - compiling with Clang,
>   - compiling inline assembly with Clang's integrated assembler,
>   - and linking with LLD.
>
> While using full LTO results in the best runtime performance, the
> compilation is not scalable in time or memory. CONFIG_THINLTO
> enables ThinLTO, which allows parallel optimization and faster
> incremental builds. ThinLTO is used by default if the architecture
> also selects ARCH_SUPPORTS_THINLTO:
>
>   https://clang.llvm.org/docs/ThinLTO.html
>
> To enable LTO, LLVM tools must be used to handle bitcode files. The
> easiest way is to pass the LLVM=1 option to make:
>
>   $ make LLVM=1 defconfig
>   $ scripts/config -e LTO_CLANG
>   $ make LLVM=1
>
> Alternatively, at least the following LLVM tools must be used:
>
>   CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
>
> To prepare for LTO support with other compilers, common parts are
> gated behind the CONFIG_LTO option, and LTO can be disabled for
> specific files by filtering out CC_FLAGS_LTO.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
