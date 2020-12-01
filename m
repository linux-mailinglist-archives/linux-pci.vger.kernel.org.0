Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9522F2CACC5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgLATwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 14:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgLATwd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 14:52:33 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC6C0613D4
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 11:51:53 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so1844165pgk.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Dec 2020 11:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJhY8u/xgI3NwUsMsFhtkWUYc2YVhnaebCX5nl2Ru6Q=;
        b=MU1J+QtjrMYect596h5eTpeHLQFqd4jbXkWpVSHILQafJ7WMP2JUuLbw0ninWQShV1
         Eh1Oe/+AnHFQzAMXF+YolY5+IBS2Npa01AwORUkDKXWV9fN6mS0YrWE5aM6a3pZYPx6S
         JLerU25sXGp+vfE+oYX7kBAjMthNKxUcPBJv4x/QoiEHeCXBcp3zAnCtjXZmaSO6WA2s
         HCB+4snvQenMBOz4d/v8seIQWfzmgrh8oq6LB4iz4kseuvkRm/7U5F/adejklVLvC9oT
         HdfZ7iGJOuo4/PghZ//tjUdn1EGf0Y+yB9oLCUzML8c2pG3EpRP8Bmp/oVwP0eJ/gaA0
         55pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJhY8u/xgI3NwUsMsFhtkWUYc2YVhnaebCX5nl2Ru6Q=;
        b=XgfVcPtTbnn5qHXDnq4GLPDpSGHqvHo+0C95jdY8lIL15VxEaFt8OSIsQI5S1qZkwi
         mpHdb2keBkcqdWvXavrKV6XhWF5gGomN2pAOOe0gUwVa7S1C5FT3adXERMyAFsv2DzBF
         CcLdC8lrUEjGb088VjIv3MnAVfXldZ8DDUDiCBl3l6K6aTYOI6PoujlVboyESp6R742l
         FauOBupaAbAnqWgaLRcPZt3PCBlrFqXDJUaQ8fI5gbYd3um7hZ/urgt/T3iJgW/gBfbu
         FQbQ23KMXapWFtJ5dj+EG4CCu4fpqhpKOJajSuNtTYxbNZU6Flkp2ntNCYL41dm65cVX
         uOTA==
X-Gm-Message-State: AOAM530vfItKdOHw3VxB6u5y2aNu+J3AW+lAbMTw7nt/qUQJYBA9GpHL
        kDYv9EW/oiZ4N0iFjRjzmnSKYkpwS30LKzPYBPv0lw==
X-Google-Smtp-Source: ABdhPJx3Xdxr6ftEvN+BqvqUknUxbXtsaIoy9RJVA4UseQm3v6s7H1av1h3KcgjU/+t+wKVVMgBfbefs2TutGOwyb1w=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr3997304pfy.15.1606852312900; Tue, 01
 Dec 2020 11:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201130120130.GF24563@willie-the-truck> <202012010929.3788AF5@keescook>
In-Reply-To: <202012010929.3788AF5@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Dec 2020 11:51:41 -0800
Message-ID: <CAKwvOdkcfg9ae_NyctS+3E8Ka5XqHXXAMJ4aUYHiC=BSph9E2A@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Tue, Dec 1, 2020 at 9:31 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 30, 2020 at 12:01:31PM +0000, Will Deacon wrote:
> > Hi Sami,
> >
> > On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > > This patch series adds support for building the kernel with Clang's
> > > Link Time Optimization (LTO). In addition to performance, the primary
> > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > > be used in the kernel. Google has shipped millions of Pixel devices
> > > running three major kernel versions with LTO+CFI since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM bitcode,
> > > which Clang produces with LTO instead of ELF object files, postponing
> > > ELF processing until a later stage, and ensuring initcall ordering.
> > >
> > > Note that v7 brings back arm64 support as Will has now staged the
> > > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > > on fixing the remaining objtool warnings [2].
> >
> > Sounds like you're going to post a v8, but that's the plan for merging
> > that? The arm64 parts look pretty good to me now.
>
> I haven't seen Masahiro comment on this in a while, so given the review
> history and its use (for years now) in Android, I will carry v8 (assuming
> all is fine with it) it in -next unless there are objections.

I had some minor stylistic feedback on the Kconfig changes; I'm happy
for you to land the bulk of the changes and then I follow up with
patches to the Kconfig after.
-- 
Thanks,
~Nick Desaulniers
