Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE912CB4B1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgLBFr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 00:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgLBFr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2020 00:47:27 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93277C0613D6
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 21:46:47 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m6so147843vkl.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 21:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIYg3wn3IiOAwIUjN3HHnL/xxZ7BzmV6ArGGQCieAHY=;
        b=bON2yGnfCiyS2deASK7lq7vUUxyZx+TcNqxyx0Y2lzXGXaJk2/GGL6wVTlpf746M17
         ewSfrj7S9dsZKHz9EXsFml/ZRzW3ibKt2hylTzUrhiQailV3BSYLijuRVIlNThE7Ss7H
         KnWN0tGzIrPrfvFAOAvf+8FI8ABAECA3BAv1o2Nf8hdcpJnE2U+4ENVHLDfsMJ2syTzS
         iaGmOfE/X9XwWP/ylcYRN5sQKiXL7/ZHlVEs4e0tCksSkzjQe+RVz9j9FQbs4OUZPc8T
         CR1MgHpyNAn/FzhGrLr7gcE7qYAYqX3l4Q2HISPXD2rjqVZX7wjj378ggI/rHdDvjDb8
         F84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIYg3wn3IiOAwIUjN3HHnL/xxZ7BzmV6ArGGQCieAHY=;
        b=oFa6oYQrRW7VKrYsbIpx2GuLNUZrWZcn5AURyxc/RLF+2q2/w+1W2eCwQfMLZC7a53
         iw+06zxsXlcbuzUiRz/lqMEufWy1t+ijDbRm8Ex2t3I67qjLoedCqhzZfxjHm8DJGuBp
         KmgwmW9R1dqKfQWBher+9uNZTo5bOp0iQ7MvP8M3dhbSIiQLp0rwIVZLXnx72iz1vpVN
         ZdKZFWDB1JrlujJf4m6P3Vsmizx2O2SDTPdU8VDptge5s3H5rGmW7rrzw/lBONoB+SUu
         /wfHHCj0k2jqIBRovgc2dXpnMk6acxWJdP0MMeS5ycOmU5JcHgwtNNGhYu6ReE58Mhbn
         B1Kg==
X-Gm-Message-State: AOAM532OmDT1kqWl3vNcv8cGmKVIDlzHReg+PigZGYb5WBKLmmA1tFTb
        eBRzPEJqGZpJ5N77iSQz8eSw0B6XazQ4ByOMLdCbcw==
X-Google-Smtp-Source: ABdhPJyfTarblbQWXQ2D0gqGJIM068ljJFblRKN2s+iu0HTYtaH2RdablEmO5KmOvdnbvJUKStvPOuGuLcyF9JZVZE8=
X-Received: by 2002:a1f:36d4:: with SMTP id d203mr580407vka.22.1606888005927;
 Tue, 01 Dec 2020 21:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201130120130.GF24563@willie-the-truck> <202012010929.3788AF5@keescook> <CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com>
In-Reply-To: <CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 1 Dec 2020 21:46:33 -0800
Message-ID: <CABCJKuf6=nqsUFYc5m91x_H44ojBjoE+BqZr81D8T6xRhWTiEg@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 1, 2020 at 6:43 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Dec 2, 2020 at 2:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 12:01:31PM +0000, Will Deacon wrote:
> > > Hi Sami,
> > >
> > > On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > > > This patch series adds support for building the kernel with Clang's
> > > > Link Time Optimization (LTO). In addition to performance, the primary
> > > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > > > be used in the kernel. Google has shipped millions of Pixel devices
> > > > running three major kernel versions with LTO+CFI since 2018.
> > > >
> > > > Most of the patches are build system changes for handling LLVM bitcode,
> > > > which Clang produces with LTO instead of ELF object files, postponing
> > > > ELF processing until a later stage, and ensuring initcall ordering.
> > > >
> > > > Note that v7 brings back arm64 support as Will has now staged the
> > > > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > > > on fixing the remaining objtool warnings [2].
> > >
> > > Sounds like you're going to post a v8, but that's the plan for merging
> > > that? The arm64 parts look pretty good to me now.
> >
> > I haven't seen Masahiro comment on this in a while, so given the review
> > history and its use (for years now) in Android, I will carry v8 (assuming
> > all is fine with it) it in -next unless there are objections.
>
>
> What I dislike about this implementation is
> it cannot drop any unreachable function/data.
> (and it is completely different from GCC LTO)
>
> This is not real LTO.

I'm not sure I understand your concern. LTO cannot drop functions or
data from vmlinux.o that may be referenced externally. However, with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, the linker certainly can drop
unused functions and data when linking vmlinux, and there's no reason
this option can't be used together with LTO. In fact, Pixel 3 does
enable this option, but in our experience, there isn't much unused
code or data to remove, so later devices no longer use it.

There's technically no reason why we couldn't postpone LTO until we
link vmlinux instead, and thus allow the linker to possibly remove
more unused code without the help of --gc-sections, but at least with
the current build process, that would involve performing the slow LTO
link step multiple times, which isn't worth it when we can get the
performance benefits (and CFI) already when linking vmlinux.o with
LTO.

Sami
