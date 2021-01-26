Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC2305BE6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 13:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbhA0Mpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 07:45:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S313045AbhAZWyh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 17:54:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E80792065C;
        Tue, 26 Jan 2021 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611701637;
        bh=90forB2cGb6Q0K0xI6+WurI9tm2KAuX6GVmEgXtvfyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Me+oMZH2WW/ar4X1gTYs4u+oK3haCRjuAP1NLtUeZ8ObrUwGpUl3n8wZzE1PHlQui
         1Hne7FVBUSOTElLsaCdCoDDo1OK7St+oFpUI42pWfAK4qUsC/6maGovC/ckaBnMa1F
         fJMXgl8WopCIouYXOWu8ffEYVdxXB10/8zQ+rv9WVA6gArdrpVbKfq+M4YULWDtpIC
         wpIXvGjq2phHuMMipiJxv/BGjXKW/29lluTTlzl8jHqtSB27mTIGrtv6r/OlAYY6L2
         tYJ8qyF+RtA8bVYcIKdVL/aYsEnUHZvIopj7Si6BO7d9qyHq8Wff547T5vRMdcD091
         GctZKz0wU4uCw==
Date:   Tue, 26 Jan 2021 22:53:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, vidyas@nvidia.com,
        treding@nvidia.com, Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        ebrower@nvidia.com
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210126225351.GA30941@willie-the-truck>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 11:08:31AM -0600, Vikram Sethi wrote:
> On 1/22/2021 1:48 PM, Will Deacon wrote:
> > On Fri, Jan 08, 2021 at 10:32:16AM +0000, Lorenzo Pieralisi wrote:
> >> On Thu, Jan 07, 2021 at 04:05:48PM -0500, Jon Masters wrote:
> >>> On 1/7/21 1:14 PM, Will Deacon wrote:
> >>>> On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
> >>>>> Given that most arm64 platform's PCI implementations needs quirks
> >>>>> to deal with problematic config accesses, this is a good place to
> >>>>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> >>>>> standard SMC conduit designed to provide a simple PCI config
> >>>>> accessor. This specification enhances the existing ACPI/PCI
> >>>>> abstraction and expects power, config, etc functionality is handled
> >>>>> by the platform. It also is very explicit that the resulting config
> >>>>> space registers must behave as is specified by the pci specification.
> >>>>>
> >>>>> Lets hook the normal ACPI/PCI config path, and when we detect
> >>>>> missing MADT data, attempt to probe the SMC conduit. If the conduit
> >>>>> exists and responds for the requested segment number (provided by the
> >>>>> ACPI namespace) attach a custom pci_ecam_ops which redirects
> >>>>> all config read/write requests to the firmware.
> >>>>>
> >>>>> This patch is based on the Arm PCI Config space access document @
> >>>>> https://developer.arm.com/documentation/den0115/latest
> >>>> Why does firmware need to be involved with this at all? Can't we just
> >>>> quirk Linux when these broken designs show up in production? We'll need
> >>>> to modify Linux _anyway_ when the firmware interface isn't implemented
> >>>> correctly...
> >>> I agree with Will on this. I think we want to find a way to address some
> >>> of the non-compliance concerns through quirks in Linux. However...
> >> I understand the concern and if you are asking me if this can be fixed
> >> in Linux it obviously can. The point is, at what cost for SW and
> >> maintenance - in Linux and other OSes, I think Jeremy summed it up
> >> pretty well:
> >>
> >> https://lore.kernel.org/linux-pci/61558f73-9ac8-69fe-34c1-2074dec5f18a@arm.com
> >>
> >> The issue here is that what we are asked to support on ARM64 ACPI is a
> >> moving target and the target carries PCI with it.
> >>
> >> This potentially means that all drivers in:
> >>
> >> drivers/pci/controller
> >>
> >> may require an MCFG quirk and to implement it we may have to:
> >>
> >> - Define new ACPI bindings (that may need AML and that's already a
> >>   showstopper for some OSes)
> >> - Require to manage clocks in the kernel (see link-up checks)
> >> - Handle PCI config space faults in the kernel
> >>
> >> Do we really want to do that ? I don't think so. Therefore we need
> >> to have a policy to define what constitutes a "reasonable" quirk and
> >> that's not objective I am afraid, however we slice it (there is no
> >> such a thing as eg 90% ECAM).
> > Without a doubt, I would much prefer to see these quirks and workarounds
> > in Linux than hidden behind a firmware interface. Every single time.
> 
> In that case, can you please comment on/apply Tegra194 ECAM quirk that was rejected
> 
> a year ago, and was the reason we worked with Samer/ARM to define this common
> 
> mechanism?
> 
> https://lkml.org/lkml/2020/1/3/395
> 
> The T194 ECAM is from widely used Root Port IP from a IP vendor. That is one reason so many
> 
> *existing* SOCs have ECAM quirks. ARM is only now working with the Root port IP vendors
> 
> to test ECAM, MSI etc, but the reality is there were deficiencies in industry IP that is widely
> 
> used. If this common quirk is not the way to go, then please apply the T194 specific quirk which was
> 
> NAK'd a year ago, or suggest how to improve that quirk.
> 
> The ECAM issue has been fixed on future Tegra chips and is validated preSilicon with BSA
> 
> tests, so it is not going to be a recurrent issue for us.

(aside: please fix your mail client not to add all these blank lines)

Personally, if a hundred lines of self-contained quirk code is all that is
needed to get your legacy IP running, then I would say we should merge it.
But I don't maintain the PCI subsystem, and I trust Bjorn and Lorenzo's
judgement as to what is the right thing to do when it concerns that code.
After all, they're the ones who end up having to look after this stuff long
after the hardware companies have stopped caring.

Will
