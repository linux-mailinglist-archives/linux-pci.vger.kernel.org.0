Return-Path: <linux-pci+bounces-4134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27723869C00
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925461F22535
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBB148316;
	Tue, 27 Feb 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtgT52/W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404C14830C;
	Tue, 27 Feb 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051137; cv=none; b=TkJsc/uimjj1YousJFqkIL1aQjdV9MVH0/Z0gByJ52D8yvNF93/hg0CYbYkoSitgI6G5tA3hRjd+YPXAbxnEYw6epy9EDBoDewJcFYxj++K34YJ8xmta3/ZDbgq9ZeNvYIp9krmelLmkQwfubNOZJA6pLubyUz9edPexehpqFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051137; c=relaxed/simple;
	bh=WnstNj4Jv5JxlwttlFifLGWHHhMSIWFpalhF/qq+++w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AIM5xzSVhUQZkXNSG+78wTsi+uM4+hT4t9ZiYl2xA4mxXCeaH8PYOKBg2nQkO7YcIUHPZ0xenlqxu2QOmeBUGPCQPlVrFGD6TvEboKKgJgNtYHpEQA3wmnGHycLsxTRLN+8okmxys9ra8A5zaZbC9cLaEbdZzQ/4h/KvnhrqsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtgT52/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C07C433C7;
	Tue, 27 Feb 2024 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051137;
	bh=WnstNj4Jv5JxlwttlFifLGWHHhMSIWFpalhF/qq+++w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DtgT52/W11i/a5EpXTJ/+VW1EfcZXMgMxIvoQd7vrb4F9TghmBpErfVTy8HnGSz+f
	 sPznOXkr9n/u2FQiAP603cYRhclxqAkYRCntbPf6wxb7KAdpBh+hwwrFNvN4yyvwoI
	 ZytSnE32mi/CkIV5DqJtc5GrOWc38JEvX3joXkihtm/aXEkE5rppks+qZTD2ao9f46
	 UjQhJzA75A1pj0HiTe5T3HaYaV7DjtFlttsz6AlogLWKgL+eX20GtIIHGPNGtEEBT4
	 M9JAmkrcbj729ByAe3wAzzDAbAy4vM/lfmD0uNEsUN/7A0oTY9lE2kk1xI5Xt54DvH
	 jdebnNFB0T0mA==
Date: Tue, 27 Feb 2024 10:25:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240227162535.GA239073@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227073057.GF2587@thinkpad>

On Tue, Feb 27, 2024 at 01:00:57PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 26, 2024 at 05:39:30PM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 22, 2024 at 09:36:29AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Feb 21, 2024 at 10:49:58AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Feb 20, 2024 at 04:02:40PM -0600, Bjorn Helgaas wrote:
> > > > > > On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > Currently, PCI core will enable D3 support for PCI bridges only when the
> > > > > > > following conditions are met:
> > > > > > 
> > > > > > Whenever I read "D3", I first have to figure out whether we're talking
> > > > > > about D3hot or D3cold.  Please save me the effort :)
> > > > > 
> > > > > Both actually, that's why I used "D3" as in the spec. I should've explicitly
> > > > > mentioned that in the commit message.
> > > > > 
> > > > > > > 1. Platform is ACPI based
> > > > > > > 2. Thunderbolt controller is used
> > > > > > > 3. pcie_port_pm=force passed in cmdline
> > > > > > 
> > > > > > Are these joined by "AND" or "OR"?  I guess probably "OR"?
> > > > > > 
> > > > > > "... all the following conditions are met" or "... one of the
> > > > > > following conditions is met" would clarify this.
> > > > > 
> > > > > Will use "one of the..."
> > > > > 
> > > > > > > While options 1 and 2 do not apply to most of the DT based
> > > > > > > platforms, option 3 will make the life harder for distro
> > > > > > > maintainers. Due to this, runtime PM is also not getting enabled
> > > > > > > for the bridges.
> > > > > > > 
> > > > > > > To fix this, let's make use of the "supports-d3" property [1] in
> > > > > > > the bridge DT nodes to enable D3 support for the capable
> > > > > > > bridges. This will also allow the capable bridges to support
> > > > > > > runtime PM, thereby conserving power.
> > > > > > 
> > > > > > Looks like "supports-d3" was added by
> > > > > > https://github.com/devicetree-org/dt-schema/commit/4548397d7522.
> > > > > > The commit log mentions "platform specific ways", which suggests maybe
> > > > > > this is D3cold, since D3hot should be supported via PMCSR without any
> > > > > > help from the platform.
> > > > > > 
> > > > > > So I *guess* this really means "platform provides some non-architected
> > > > > > way to put devices in D3cold and bring them back to D0"?
> > > > > 
> > > > > By reading the comments and git log of the pci_bridge_d3_possible()
> > > > > function in drivers/pci/pci.c, we can understand that some of the
> > > > > old bridges do not support both D3hot and D3cold. And to
> > > > > differentiate such bridges, platforms have to notify the OS using
> > > > > some ways.
> > > > > 
> > > > > ACPI has its own implementation [1] and DT uses "supports-d3"
> > > > > property.
> > > > > 
> > > > > And yes, in an ideal world PMCSR should be sufficient for D3hot, but
> > > > > you know the PCI vendors more than me ;)
> > > > 
> > > > So it sounds like this is supposed to cover two cases:
> > > > 
> > > >   1) D3hot doesn't work per spec.  This sounds like a hardware
> > > >      defect in the device that should be a quirk based on
> > > >      Vendor/Device ID, not something in DT.  I don't actually know if
> > > >      this is common, although there are several existing quirks that
> > > >      mention issues with D3.
> > > > 
> > > 
> > > I'd love to use quirks if we started from that. But right now, quirks are not
> > > used and there are multiple checks based on various factors [1], including
> > > relying on ACPI. So that's the reason I went with DT based approach.
> > > 
> > > If quirks has to be used now, then it has to be used for both ACPI and DT based
> > > platforms. For DT it won't be an issue since nobody bothered until now, but for
> > > ACPI, we need to add quirks for all the bridges in the wild which is not
> > > feasible.
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c#n3116
> > > 
> > > >   2) The platform doesn't support putting the bridge in D3cold and
> > > >      back to D0.  I don't understand this either because I assumed DT
> > > >      would describe *hardware*, and "supports-d3" might imply the
> > > >      presence of hardware power control, but doesn't tell us how to
> > > >      operate it, and it must be up to a native driver to know how to
> > > >      do it.
> > > 
> > > "supports-d3" implies that both D3hot and D3cold works as in the
> > > spec and the OS can handle it appropriately. If this is absent, then
> > > OS should not transition the bridge to any of the D3 states. I don't
> > > understand what is the confusion here. This is similar to what we
> > > already have for ACPI (whether or not it is correct is another
> > > topic).
> > 
> > What does "the OS can handle it appropriately" mean?  Whatever it
> > means, it sounds like a property of the OS, not a property of the
> > device.
> 
> "appropiately" means as per the PCIe spec.
>
> > I don't know what "D3cold works as in the spec" means, either.  The
> > spec says how D3cold affects internal device state, but it doesn't say
> > anything about how to put devices in D3cold or back in D0.
> > 
> > > > These are two vastly different scenarios, and I would really like to
> > > > untangle them so they aren't conflated.  I see that you're extending
> > > > platform_pci_bridge_d3(), which apparently has that conflation baked
> > > > into it already, but my personal experience is that this is really
> > > > hard to maintain.
> > > 
> > > I do agree that it is not in a good shape, but there is no better
> > > solution other than making use of the DT property. If you have any
> > > better idea, please suggest.
> > 
> > The longer this goes on the worse shape we are in because we're always
> > adding new special cases.
> > 
> > The fundamental problem I have is that "supports-d3" doesn't say
> > anything specific other than "current Linux can put the device in
> > D3hot or D3cold and get it back out again".  I think DT should tell us
> > characteristics of the device or the platform, e.g., "PMCSR doesn't
> > work to enter/leave D3hot on this device" or "regulator X controls
> > main power to the device to enter/leave D3cold".
> > 
> > But right now it sounds like a mixture of "PMCSR works correctly to
> > enter/leave D3hot" and "some unspecified software can control main
> > power to this device".
> > 
> > Putting devices in D3cold and back in D0 needs some kind of platform
> > support like ACPI methods or a native power management driver that
> > knows how to control power on a specific platform.  That's completely
> > different from D3hot, where the PCI spec tells us all we need to know.
> 
> Ok, I got the issue. TBH, I added the device tree property based on
> the existing quirks for the ACPI devices. But none of the DT based
> platforms I'm aware of (even the legacy Qcom MSM8996 chipset
> released in early 2016) doesn't have any issue with D3hot. But I'm
> just nervous to assume it is the case for all the DT based platforms
> in the wild.
> 
> But to proceed further, what is your preference? Should we ammend
> the DT property to make it explicit that the propery only focuses on
> the D3hot capability of the bridge and it works as per the spec
> (PMCSR) or bite the bullet and enable D3hot for all the non-ACPI
> platforms?
> 
> We can add quirks for the bridges later on if we happen to receive
> any bug report.

I would assume all devices support D3hot via PMCSR per spec.  We can
add quirks if we discover something that doesn't.

If we add annotations that "this device works correctly", we're
digging a hole for ourselves because it's impossible to remove those
annotations and they complicate all future maintenance.

Bjorn

