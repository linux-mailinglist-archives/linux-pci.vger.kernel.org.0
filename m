Return-Path: <linux-pci+bounces-33472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89582B1CC2C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA730165EDE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F9329AB1D;
	Wed,  6 Aug 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzWAfBgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269729A9C3;
	Wed,  6 Aug 2025 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506254; cv=none; b=Rg61rT1k8s0Sd5grn8JmrQ6m8rlcY6jDl+5on5PfIvgyniHS9vBiwhi7CfYyMNElP/A3IkUa+8gZ4lBacXq+pT2PXWpuuew31nJlD7IB6WxuIAvs9rbGYtj6Nij5WoNH5pFao/Cr1diNwKLWHcvSUHcNnm8Ov6zvA6btbvQI/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506254; c=relaxed/simple;
	bh=kEM5vhXrSGvpRyllOZTd+MbG9Yt0asgCP/TMhfdeB48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XS9UMRni9ei0mMABHuYFeivnPo14n+n+rV+LeZg8lCHdAzhMxZWg4nh+TkUoEvUKVYk1oERm6Jhmn/VjihV+sQEgFNYypWL7TPu0zkXj8G/4aq1TmOrDrkfRflaXs35EnaO2Tm6l9TC9WBIaIaje7CJQw4EeyRjPYXb/jZsmVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzWAfBgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD03C4CEE7;
	Wed,  6 Aug 2025 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754506253;
	bh=kEM5vhXrSGvpRyllOZTd+MbG9Yt0asgCP/TMhfdeB48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BzWAfBgnwZpfljD/W+CsHOSwzED3vJWVnHj6/SK/MH3U9Wv4RpRV6oxiCtte0LY3C
	 yJBDmwZa2u2+nad+38+KrVw//p1RFTwpzlU7WdtGoPifWOIgJA+zlfRF9eFPg3EuDw
	 k32XLonHhU5Iqy6hmeDzKf1ZidUwKDUQFOOZwUHxUegZrCMI/R0BjbAlxqN3T6FzHb
	 /T/EmUJBnHVcvpNmyCEJY7E0gMo3VQmTwucIVB33R1BsQAgWZkXO+NdrwR1YYnOia3
	 hPZVUp8e12wRkxTOrGJ0wU3xugkQafUNoTL0Sw3dtMIsWqKoP7q0Rlz9UIalcj+GRJ
	 PYgVcLbQYzrJg==
Date: Wed, 6 Aug 2025 13:50:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <20250806185051.GA10150@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzq_BV_fK9T4LK0ncZuufqp9E9+DUyFU3jKCnSCjN8n-w@mail.gmail.com>

On Wed, Aug 06, 2025 at 02:38:12PM -0400, Jim Quinlan wrote:
> On Wed, Aug 6, 2025 at 2:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Jun 13, 2025 at 06:08:43PM -0400, Jim Quinlan wrote:
> > > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> > > by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
> > > 7216 and its descendants -- have new HW that identifies error details.
> >
> > What's the long term plan for this?  This abort is a huge problem that
> > we're seeing across arm64 platforms.  Forcing a panic and reboot for
> > every uncorrectable error is pretty hard to deal with.
> 
> Are you referring to STB/CM systems, Rpi, or something else altogether?

Just in general.  I saw this recently with a Nuvoton NPCM8xx PCIe
controller.  I'm not an arm64 guy, but I've been told that these
aborts are basically unrecoverable from a kernel perspective.  For
some reason several PCIe controllers intended for arm64 seem to raise
aborts on PCIe errors.  At the moment, that means we can't recover
from errors like surprise unplugs and other things that *should* be
recoverable (perhaps at the cost of resetting or disabling a PCIe
device).

> > Is there a plan to someday recover from these aborts?  Or change the
> > hardware so it can at least be configured to return ~0 data after
> > logging the error in the hardware registers?
> 
> Some of our upcoming chips will have the ability to do nothing on
> errant PCIe writes and return 0xffffffff on errant PCIe reads.   But
> none of our STB/CM chips do this currently.   I've been asking for
> this behavior for years but I have limited influence on what happens
> in HW.

Fingers crossed for either that or some other way to make these things
recoverable.

> > > This simple handler determines if the PCIe controller was the
> > > cause of the abort and if so, prints out diagnostic info.
> > > Unfortunately, an abort still occurs.
> > >
> > > Care is taken to read the error registers only when the PCIe
> > > bridge is active and the PCIe registers are acceptable.
> > > Otherwise, a "die" event caused by something other than the PCIe
> > > could cause an abort if the PCIe "die" handler tried to access
> > > registers when the bridge is off.
> >
> > Checking whether the bridge is active is a "mostly-works"
> > situation since it's always racy.
> 
> I'm not sure I understand the "racy" comment.  If the PCIe bridge is
> off, we do not read the PCIe error registers.  In this case, PCIe is
> probably not the cause of the panic.   In the rare case the PCIe
> bridge is off  and it was the PCIe that caused the panic, nothing
> gets reported, and this is where we are without this commit.
> Perhaps this is what you mean by "mostly-works".  But this is the
> best that can be done with SW given our HW.

Right, my fault.  The error report registers don't look like standard
PCIe things, so I suppose they are on the host side, not the PCIe
side, so they're probably guaranteed to be accessible and non-racy
unless the bridge is in reset.

Bjorn

