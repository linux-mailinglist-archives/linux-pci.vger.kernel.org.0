Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCC297660
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 20:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754262AbgJWSE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbgJWSEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 14:04:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F0C0613D2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 11:04:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i26so1516014pgl.5
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2CWJzY4MEDXxaHnxhlpdNlYwFX3Mo9zkPfuZorsI9Y=;
        b=H446iHuFmhIJ0PjfsWOZIKXkYAAiR/qMysy2kifq9bqj5rLg66KEEyAVqwEd6WbUps
         sED9acTBSiZNv81RCdLvgIloMgQLDb+aFM5BPO1vDUgmdb53vkLHOMlLeHPYF5J2GI/9
         Z+MbNrJoO74axniKTBHA3C1/D9nDIjz1K4lJHHNl2nRfv6LOv+lKtXlKdyYXYoGp5NB+
         7T7nAiEeuvoEbWogVAiqxDBfix5RG4KG371ZC7nDh6hwqBoQCAIdn40mLA4qNCiMwGEZ
         AovbwwbjEYw2V+/jU9UAf4YaXaxsLPa2O+0f0DuRvcHS0eEwto36FosnHGYs9K20Iwe3
         qTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2CWJzY4MEDXxaHnxhlpdNlYwFX3Mo9zkPfuZorsI9Y=;
        b=k8umgvPz8pQr3v6lGdkjB+WFKmcwUo6myZh1pb64vL71sguAi7+fdGkdW6CP0vouW5
         ztKgW0QGr0s0ANCQ4/wQ+nIPaMsyXh+FEgEAS3XsmTRvRBB16rwbnvRkzj4kfQHf/p7W
         /QwMJz+U9+WLcgGC6YeW/4zG9weHvZ+SN1cbcL8T9LycmsdUebzCNdLaKOfrtTWUCiZx
         u0ZRhj4iYWtpLc2OTZY9OeVYc47nPW7rTfVEcuRzl9lgVnNyUC7mgibcXbPhCdVsmz5q
         oB4rLsujNXR4tuG8piZxBzp4biFtIzspG4nC1QZkPwVI0k2kiAQ9vwKp8D7VTdzu1BVT
         PILg==
X-Gm-Message-State: AOAM5313X5sRINCAwY23P26/HssgzyKltfsad7lx0bOodHKcHu2XkoPm
        W/vf7tnXtFccu5GHai/dISAyEmUc76tI0pEIBx8kjg==
X-Google-Smtp-Source: ABdhPJwlSbFR06Dbf2v2Zs9Rk9xNmHPrLyORGSrOkf63VY1RitmJdrnqA+NYcyLnEJ0BT0Cjn2BIz92MfzdbNr+EW3s=
X-Received: by 2002:a63:70d:: with SMTP id 13mr3178657pgh.263.1603476294852;
 Fri, 23 Oct 2020 11:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net> <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble> <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net> <20201021093213.GV2651@hirez.programming.kicks-ass.net>
 <20201021212747.ofk74lugt4hhjdzg@treble> <20201022072553.GN2628@hirez.programming.kicks-ass.net>
 <20201023174822.GA2696347@google.com>
In-Reply-To: <20201023174822.GA2696347@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Oct 2020 11:04:43 -0700
Message-ID: <CAKwvOdnovKJCv05wHLY28ngqkoR-mU_xoyVmv0rNzWE1C=SNMg@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 10:48 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 09:25:53AM +0200, Peter Zijlstra wrote:
> > > There's a new linker flag for renaming duplicates:
> > >
> > >   https://sourceware.org/bugzilla/show_bug.cgi?id=26391
> > >
> > > But I guess that doesn't help us now.
> >
> > Well, depends a bit if clang can do it; we only need this for LTO builds
> > for now.
>
> LLD doesn't seem to support -z unique-symbol.

https://github.com/ClangBuiltLinux/linux/issues/1184
-- 
Thanks,
~Nick Desaulniers
