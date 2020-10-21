Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA41294F6B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443890AbgJUPBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443889AbgJUPBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 11:01:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3113C0613D4
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 08:01:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so2866898edb.12
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue8Kphmgd/J9kkCdXQ6cXg3jN2T1s1VI/S6KEmBFYtA=;
        b=tyuzf6egZNg0bmL3iIxfmvVeRFhdDnfbewBqqrw7rPk8s9ezG7HKGJBYpz7qsa0C3r
         S3ppY6TNQS3s3qJ+E8SkywVt7v3Zd2bQYG9iNKkQ5ry9p4dyQxrKaJYxT3chX6RHizyC
         +GySRMRyhkvGqRuGv8ic4+o/rQfFyDhJwmYxpx2ibC7icYfN3L7KTnwPZmkGNg6waxt+
         /v0DHK/ocGmaG3hiyKz3lBsjXZFDm/NNr/l8Dh1bRHfhbCLOJwWvukIO73RcCWW7x5gT
         F/vLxIv6fFnSA+AZM/O1jatbKn8McCq487pE+2ewPegXQiEjjWXHbjNbBW5V5tKGcGQh
         Pzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue8Kphmgd/J9kkCdXQ6cXg3jN2T1s1VI/S6KEmBFYtA=;
        b=ZuW+RLj1/CPBl0kYiGwR6lXiTEhrohcJwvT6WHAhBulX1jGjSQ9yiQxXcOEZPgRa31
         ZoVzpNBrk/kv2PkeZjd5z/Gdr9K4hrIfdx+VKev9T2cQwY0McPVsvrr+L32toNIGYXKu
         i3m1ItEwoQgtzssXqtq1N6BlviaVK8/lk0geE7s3Cjpx9QvrZcIWz0TQSJkCFHiWGlEY
         U5/TLnnqscWb0YQncoO5pm7lwVABUA9jvxPg9foUn5pPOaQPA3URmaiOhv7UIOCdQy7Z
         r+MmW7iB6NFnvsePRo7n7frvoKJwc0Y8CTZapaheaXBWhHDmcivayLotgUMrQXxLFUUi
         vSHQ==
X-Gm-Message-State: AOAM531Q8SY4BHOgDJX7Tya4VOi+sfN2p+BxtDAIrrBiObEIj4nrUnJA
        3Er6HfTo0R9rqPtHgrzVIONoAaNj+A465ge6AazevQ==
X-Google-Smtp-Source: ABdhPJxLbzy0h2+Icd7LIsy6zh10BR+u5qt0ykST0OUv8CPsJiNxNv60HEOhNh7tmnifd2hka1h/GcVQRH2ORVgJ1P0=
X-Received: by 2002:a05:6402:135a:: with SMTP id y26mr1563112edw.114.1603292509011;
 Wed, 21 Oct 2020 08:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com> <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net> <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble> <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 21 Oct 2020 08:01:38 -0700
Message-ID: <CABCJKuewXazmBpXz5irWgy+W537x1Lws5YAsFqMgo+Yio8iyRg@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Wed, Oct 21, 2020 at 1:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 20, 2020 at 12:24:37PM -0700, Sami Tolvanen wrote:
> > > > Building allyesconfig with this series and LTO enabled, I still see
> > > > the following objtool warnings for vmlinux.o, grouped by source file:
> > > >
> > > > arch/x86/entry/entry_64.S:
> > > > __switch_to_asm()+0x0: undefined stack state
> > > > .entry.text+0xffd: sibling call from callable instruction with
> > > > modified stack frame
> > > > .entry.text+0x48: stack state mismatch: cfa1=7-8 cfa2=-1+0
> > >
> > > Not sure what this one's about, there's no OBJECT_FILES_NON_STANDARD?
> >
> > Correct, because with LTO, we won't have an ELF binary to process
> > until we compile everything into vmlinux.o, and at that point we can
> > no longer skip individual object files.
>
> I think what Josh was trying to say is; this file is subject to objtool
> on a normal build and does not generate warnings. So why would it
> generate warnings when subject to objtool as result of a vmlinux run
> (due to LTO or otherwise).

Ah, right. It also doesn't generate warnings when I build defconfig
with LTO, so clearly something confuses objtool here.

Sami
