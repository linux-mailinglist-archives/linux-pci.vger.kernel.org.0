Return-Path: <linux-pci+bounces-12463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A50F965350
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 01:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAC3B21C5F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB151B5EDB;
	Thu, 29 Aug 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf/U8N6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A4156F41;
	Thu, 29 Aug 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973153; cv=none; b=oW9wu5N8dgVNPcFJwpab5HMa/lPztWb13NIs6csnOUP4QJ+H58yMqAUElFRPYrZl0o7++w/6kAJFpn6Mf0Ry05W1872LwxOgwqgx0iXOSsviMPBBgzPiu9UC40Ft6uY0h0pXI91gHKsBu1ZB+eh+Sxn2702SkOhgQX0UDw8u1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973153; c=relaxed/simple;
	bh=/PcuXPhR5JHXjlSBD42UFBik+2SOUe13X7fQXLHk1kY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=blc9C/h0E/XncWlwC3p0+LZ2ou+0/jhuW8FJfsAqfAcqsfuwsSyuortskA8YNOTuFZbylG8LE8UUXWy+M+4zjraRfRX+zFrlRKq1NWqxmmgKATyrJQOsNTC5/Mr61b9agCEegAlpl2Yfq+lEZPeC3HVgPQ/YzXd0IiFAy4iTqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf/U8N6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD80C4CEC1;
	Thu, 29 Aug 2024 23:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724973153;
	bh=/PcuXPhR5JHXjlSBD42UFBik+2SOUe13X7fQXLHk1kY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Vf/U8N6Nl87Sx/bUQNIu9UbCWUa4z2HJ/8nEOjR46BfB4bBnusWUDq7OpNrqzp2DY
	 N5eQvnhU8u5cP3pigdQ5+hDfzYWM5l++6O+BiTQlVMOcU3LOTwIg3zsfQEoiQgPzP+
	 XtgL8beWIAFCqLwWRSL3OC0li9rFiuBkmDHdjl1UnKwEh2qLxFCDHnbdUJT2SE/yrG
	 4Hjim6mb3kCmy6BVO3V9YxJ78b1kMab/ea2x/ptqozg12his6gL7xf2D0ZfgY1zGvr
	 8kQtrx/isC3cz67kGg4Adj8qxb7VBYNWuetkdvWbk/IIm4cVHPutQcbJa3ANdZvBL5
	 ihSWLACiRD44w==
Date: Thu, 29 Aug 2024 18:12:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Li, Gary" <Gary.Li@amd.com>
Subject: Re: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device
 ready
Message-ID: <20240829231231.GA80290@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab893fd1-6a90-4a39-963a-111dbdc9f720@amd.com>

On Wed, Aug 28, 2024 at 05:26:32PM -0500, Mario Limonciello wrote:
> On 8/28/2024 16:42, Bjorn Helgaas wrote:
> > On Wed, Aug 28, 2024 at 04:24:01PM -0500, Mario Limonciello wrote:
> > > On 8/27/2024 18:48, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > After a device reset, pci_dev_wait() waits for a device to become
> > > > completely ready by polling the PCI_COMMAND register.  The spec envisions
> > > > that software would instead poll for the device to stop responding to
> > > > config reads with Completions with Request Retry Status (RRS).
> > > > 
> > > > Polling PCI_COMMAND leads to hardware retries that are invisible to
> > > > software and the backoff between software retries doesn't work correctly.
> > > > 
> > > > Root Ports are not required to support the Configuration RRS Software
> > > > Visibility feature that prevents hardware retries and makes the RRS
> > > > Completions visible to software, so this series only uses it when available
> > > > and falls back to PCI_COMMAND polling when it's not.
> > > > 
> > > > This is completely untested and posted for comments.
> > > > 
> > > > Bjorn Helgaas (3):
> > > >     PCI: Wait for device readiness with Configuration RRS
> > > >     PCI: aardvark: Correct Configuration RRS checking
> > > >     PCI: Rename CRS Completion Status to RRS
> > > > 
> > > >    drivers/bcma/driver_pci_host.c             | 10 ++--
> > > >    drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
> > > >    drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
> > > >    drivers/pci/controller/pci-xgene.c         |  6 +-
> > > >    drivers/pci/controller/pcie-iproc.c        | 18 +++---
> > > >    drivers/pci/pci-bridge-emul.c              |  4 +-
> > > >    drivers/pci/pci.c                          | 41 +++++++++-----
> > > >    drivers/pci/pci.h                          | 11 +++-
> > > >    drivers/pci/probe.c                        | 33 +++++------
> > > >    include/linux/bcma/bcma_driver_pci.h       |  2 +-
> > > >    include/linux/pci.h                        |  1 +
> > > >    include/uapi/linux/pci_regs.h              |  6 +-
> > > >    12 files changed, 117 insertions(+), 97 deletions(-)
> > > 
> > > Although this looks like a useful series, I'm sorry to say but
> > > this doesn't solve the issue that Gary and I raised.  We double
> > > checked today and found that reading the vendor ID works just
> > > fine at this time.
> > 
> > Thanks for testing that.
> 
> Sure.
> 
> > > I think that we're still better off polling PCI_PM_CTRL to
> > > "wait" for D0 after the state change from D3cold.
> > 
> > Is there some spec justification for polling PCI_PM_CTRL?  I'm
> > dubious about doing that just because "it works" in this
> > situation, unless we have some better understanding about *why* it
> > works and whether all devices are supposed to work that way.
> 
> I mentioned this a little bit in my patch 3/5 in my submission.  The
> issue isn't "normal" D3cold exit that is fully settled down.  That
> takes ~6ms from measurements.  The issue is how long it takes for
> D3cold *entry* followed by *exit*.

I think we should have this conversation in the context of your series
(https://lore.kernel.org/r/20240823154023.360234-1-superm1@kernel.org)
because PCI_PM_CTRL questions are more relevant there, so I'll respond
there.

> When this issue occurs it's tied with a tight loop of runtime PM
> entry and exit happening in that short window.  That's why it can be
> tripped by unplugging a dock, waiting until ~approximately
> autosuspend delay and plugging it back in.  If you catch the right
> timing then the USB4 router is still on its way down to D3cold.
> 
> In terms of a way to match this problem to the spec, the closest I
> could think is PCI-PM spec.
> 
> But I do see in the PCI-PM spec that the delay for D0->D3hot should
> be 10ms.  In the Linux kernel implementation __pci_set_power_state()
> when called with D3cold calls pci_set_low_power_state() which does
> wait 10ms followed by using the platform to remove power.
> 
> I can't find any timing requirements for D3hot->D3cold transition
> though.
> 
> I would hypothesize that if we injected a longer delay on the "other
> end" for the D3cold transition entry it would solve this issue as
> well though.

