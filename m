Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3702EE7EE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbhAGVuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbhAGVuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 16:50:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D898235FD;
        Thu,  7 Jan 2021 21:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610056180;
        bh=NKZE6PdR9JztQJPwMPf2hFCSqm4ah1QPPW+bytfED/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QaGwjOMBN0itOGBb0VTuf1v7vh/+IomHQllnlDe49lzk69QEW+6IIyd2myU4+RjSH
         3V4bPXyqrN87NIkSAA6pc2lWF1AarAl7e84AADby/6K/HzvwzEMuAIC3LG/UYbUZlk
         lYUpThJo0iCpOh6CXHqK6lQaUc7KxfMSlUUmWJl5knkv1ssaSQBMB1m+Sn0HaQ/0bk
         72VHh8xo77DMO3wMMMofnN/SLV2uACiv5DbhgMNMjqrf+ebEwBHo+ScNOFulzfpXQr
         yMY56cVwUNcgBLrbAaSrBLRtbL3yB22/LwBF38iQ9YChAM81Xgk5A5Efp7tAbnPNhy
         AoPD1hgMoTQqg==
Received: by mail-ed1-f52.google.com with SMTP id y24so9161213edt.10;
        Thu, 07 Jan 2021 13:49:40 -0800 (PST)
X-Gm-Message-State: AOAM533utKy0cAjndIzCyazpPndjDz1z+6JFozuifmT6HsG1I2rgBfxB
        NxWlK5HFND29BFBtR8SAebrDder2+jaDyRM61Q==
X-Google-Smtp-Source: ABdhPJygWhHryn9+o20dWtEsL533MrDb5EZEc0hqSc5ZXSI1tgLSuOAdWKmgl9Xau3/1/fs5tggNXrspLlqNCJbzbUw=
X-Received: by 2002:a05:6402:ca2:: with SMTP id cn2mr3113970edb.137.1610056179212;
 Thu, 07 Jan 2021 13:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
In-Reply-To: <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 14:49:27 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKuAOCOtg-Qh1=CtQBQHu+kXqQnsees6F-gOCk3BedOzQ@mail.gmail.com>
Message-ID: <CAL_JsqKuAOCOtg-Qh1=CtQBQHu+kXqQnsees6F-gOCk3BedOzQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jon Masters <jcm@jonmasters.org>
Cc:     Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 7, 2021 at 2:06 PM Jon Masters <jcm@jonmasters.org> wrote:
>
> Hi will, everyone,
>
> On 1/7/21 1:14 PM, Will Deacon wrote:
>
> > On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
> >> Given that most arm64 platform's PCI implementations needs quirks
> >> to deal with problematic config accesses, this is a good place to
> >> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> >> standard SMC conduit designed to provide a simple PCI config
> >> accessor. This specification enhances the existing ACPI/PCI
> >> abstraction and expects power, config, etc functionality is handled
> >> by the platform. It also is very explicit that the resulting config
> >> space registers must behave as is specified by the pci specification.
> >>
> >> Lets hook the normal ACPI/PCI config path, and when we detect
> >> missing MADT data, attempt to probe the SMC conduit. If the conduit
> >> exists and responds for the requested segment number (provided by the
> >> ACPI namespace) attach a custom pci_ecam_ops which redirects
> >> all config read/write requests to the firmware.
> >>
> >> This patch is based on the Arm PCI Config space access document @
> >> https://developer.arm.com/documentation/den0115/latest
> >
> > Why does firmware need to be involved with this at all? Can't we just
> > quirk Linux when these broken designs show up in production? We'll need
> > to modify Linux _anyway_ when the firmware interface isn't implemented
> > correctly...
>
> I agree with Will on this. I think we want to find a way to address some
> of the non-compliance concerns through quirks in Linux. However...
>
> Several folks here (particularly Lorenzo) have diligently worked hard
> over the past few years - and pushed their patience - to accommodate
> hardware vendors with early "not quite compliant" systems. They've taken
> lots of quirks that frankly shouldn't continue to be necessary were it
> even remotely a priority in the vendor ecosystem to get a handle on
> addressing PCIe compliance once and for all. But, again frankly, it
> hasn't been enough of a priority to get this fixed. The third party IP
> vendors *need* to address this, and their customers *need* to push back.
>
> We can't keep having a situation in which kinda-sorta compliant stuff
> comes to market that would work out of the box but for whatever the
> quirk is this time around. There have been multiple OS releases for the
> past quite a few years on which this stuff could be tested prior to ever
> taping out a chip, and so it ought not to be possible to come to market
> now with an excuse that it wasn't tested. And yet here we still are. All
> these years and still the message isn't quite being received properly. I
> do know it takes time to make hardware, and some of it was designed
> years before and is still trickling down into these threads. But I also
> think there are cases where much more could have been done earlier.
>
> None of these vendors can possibly want this deep down. Their engineers
> almost certainly realize that just having compliant ECAM would mean that
> the hardware was infinitely more valuable being able to run out of the
> box software that much more easily. And it's not just ECAM. Inevitably,
> that is just the observable syndrome for worse issues, often with the
> ITS and forcing quirked systems to have lousy legacy interrupts, etc.
> Alas, this level of nuance is likely lost by the time it reaches upper
> management, where "Linux" is all the same to them. I would hope that can
> change. I would also remind them that if they want to run non-Linux
> OSes, they will also want to be actually compliant. The willingness of
> kind folks like Lorenzo and others here to entertain quirks is not
> necessarily something you will find in every part of the industry.
>
> But that all said, we have a situation in which there are still
> platforms out there that aren't fully compliant and something has to be
> done to support them because otherwise it's going to be even more ugly
> with vendor trees, distro hacks, and other stuff.
>
> Some of you in recent weeks have asked what I and others can do to help
> from the distro and standardization side of things. To do my part, I'm
> going to commit to reach out to assorted vendors and have a heart to
> heart with them about really, truly fully addressing their compliance
> issues. That includes Cadence, Synopsys, and others who need to stop
> shipping IP that requires quirks, as well as SoC vendors who need to do
> more to test their silicon with stock kernels prior to taping out. And I
> would like to involve the good folks here who are trying to navigate.

I agree with almost all this, but one issue on testing with stock
kernels. I've been on the other side of this though it's been a while
now. I've never seen much more than 'boot Linux' for pre Si testing.
I'd guess every platform did that (Calxeda's 64-bit chip did :)).
Maybe deeper pockets do more. Given the increased firmware that runs
before Linux nowadays that's probably only gotten harder. So while
testing with Linux is great, we still need to be specific about what's
compliant and not compliant. For example, stock linux can support
32-bit only accesses, but that's not what we'd consider passing. Maybe
Linux quirks need to be louder. Customers tend to not like seeing
error messages.

Rob
