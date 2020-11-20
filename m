Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1392BBA66
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgKTXx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 18:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgKTXx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 18:53:59 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4095C061A04
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2020 15:53:58 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so9416205pfa.4
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2020 15:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9QmQzu0viMhe1+E2AuJjw4yABAqeWJl/tuV7zSeb+U=;
        b=mdmSYKuoJmPQiSSZKAXRHrhaYfKRSQA9hE/wfOsOCkhwS+3+67n+lejlrZY4HtZfn/
         a2ORoKHB2+RW61Vt9T9zrAHoM1RsQbsuWV47pPf93KFSlEHy1Tfio9hzAUE4BkPNXx+I
         YITKk0YEENSGCNohJ36jZOmfNM0ry/U9Rv8sczK8LJbtzspnCR2SDBjJ4zad2AR6UovQ
         Szo2WkElnVp3Pq1aFadmc5JzwZozrsYu/68ODALQuad6JmMLMpwoXKqfBusvVuclgTF+
         rSwKmAgZg2oXKzT79ocvKhy7QjjLbUii5XJDdT+bt/WFOVYQqnt9FCLWzuGSaXf0zzOP
         TH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9QmQzu0viMhe1+E2AuJjw4yABAqeWJl/tuV7zSeb+U=;
        b=EwqHJSUXK+kIOsI89Dk3J4E4QjHTkV7/P+ol5XiDRF+ZmvOJg+XEQIMLenLiIIax6z
         GrUmqVI9aBaZrkArVTL/dhUHA8QDRTA5njzMB+imVRqX2yABGKnVJmdozHB3i97g6bDg
         m8cL9WvlTAbPkODB1Lmb/9+KGCPJylY8T3XTxppUv+I7D6hsMFdj4doQ7YrJlbW2MU0l
         GOfplpGpGWr64Wu5x17oNYMWOB/MeiUaQSY/GSzsfZFfGW/uDpHWLY1YokUu+r0yJVZE
         4aPBvQf71M7ESal/k1P3Jw4V08dMjgXuNDVHIvDMVtEj6nzo+jBZ9b+Kdc2Jpw6O3Rt0
         mNcg==
X-Gm-Message-State: AOAM5306f8MabsSyudWDhdYz4+a7g4h+n9veFdfIEGtpwUpGeqI5oFr8
        7IrVMz33Mh2Tc1/OskveUSGbZXnzoZFLyKbZY8s2ig==
X-Google-Smtp-Source: ABdhPJy2DGSHmfFcAh4bM/VKta4IGQmsyfxYSHlfpKnMfeL7FrQ+44E3UgsHXg0jgCwAXeN0PaduNYVMcO8diBSDC4k=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr13286585pjj.101.1605916438104;
 Fri, 20 Nov 2020 15:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com>
 <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
 <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com> <CAMj1kXEoPEd6GzjL1XuxTPwitbR03BiBEXpAGtUytMj-h=vCkg@mail.gmail.com>
In-Reply-To: <CAMj1kXEoPEd6GzjL1XuxTPwitbR03BiBEXpAGtUytMj-h=vCkg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Nov 2020 15:53:45 -0800
Message-ID: <CAKwvOdmk1D0dLDOHEWX=jHpUxUT2JbwgnF62Qv3Rv=coNPadHg@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        PCI <linux-pci@vger.kernel.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 20, 2020 at 3:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 20 Nov 2020 at 21:19, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Nov 20, 2020 at 2:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > Thanks for continuing to drive this series Sami.  For the series,
> > > >
> > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > I did virtualized boot tests with the series applied to aarch64
> > > > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
> > > > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
> > > > please drop my tested by tag from the modified patches and I'll help
> > > > re-test.  Some minor feedback on the Kconfig change, but I'll post it
> > > > off of that patch.
> > > >
> > >
> > > When you say 'virtualized" do you mean QEMU on x86? Or actual
> > > virtualization on an AArch64 KVM host?
> >
> > aarch64 guest on x86_64 host.  If you have additional configurations
> > that are important to you, additional testing help would be
> > appreciated.
> >
>
> Could you run this on an actual phone? Or does Android already ship
> with this stuff?

By `this`, if you mean "the LTO series", it has been shipping on
Android phones for years now, I think it's even required in the latest
release.

If you mean "the LTO series + mainline" on a phone, well there's the
android-mainline of https://android.googlesource.com/kernel/common/,
in which this series was recently removed in order to facilitate
rebasing Android's patches on ToT-mainline until getting the series
landed upstream.  Bit of a chicken and the egg problem there.

If you mean "the LTO series + mainline + KVM" on a phone; I don't know
the precise state of aarch64 KVM and Android (Will or Marc would
know).  We did experiment recently with RockPI's for aach64 KVM, IIRC;
I think Android is tricky as it still requires A64+A32/T32 chipsets,
Alistair would know more.  Might be interesting to boot a virtualized
(or paravirtualized?) guest built with LTO in a host built with LTO
for sure, but I don't know if we have tried that yet (I think we did
try LTO guests of android kernels, but I think they were on the stock
RockPI host BSP image IIRC).

> > > The distinction is important here, given the potential impact of LTO
> > > on things that QEMU simply does not model when it runs in TCG mode on
> > > a foreign host architecture.

-- 
Thanks,
~Nick Desaulniers
