Return-Path: <linux-pci+bounces-39674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30973C1C12C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFD72340386
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8692334C08;
	Wed, 29 Oct 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNQeEbed"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822141EB9E3;
	Wed, 29 Oct 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755196; cv=none; b=VOmr7exqd4PhNcqrqx5ynAS6p29NWmtfvOMYi0iOl2w2Oi8SXGpzJSM0LKkH13dM6WRjRjG+QAnpBzH+pWBqk5sPXHRjXcXFtOueVRICeDRnYkeA+msAvCXmjTcW0YnXKZbCQlqki8ZMO3p8XedxYdlpIiNoBp0oCtut7LLjEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755196; c=relaxed/simple;
	bh=wELtySEeo9db8uxyOMgc0Q4pI1hleFdPzhwEcqjQAKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HWNUbsRIf6lPyx1nz+JeJRnM+iYgyF+zV6f54A7LoXVMFdeDHRzjiWVd7yE/gG9fMRqTRVXyX9sFKnvTGVpBrGn5btTVySirY/THiu1CNH9Tm0k9g2DewljpeMz+lzOM6Xcx7GSk1yKuzOlhMXJRSx8Iqrx/q3cJTDLABTST2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNQeEbed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E25C4CEF7;
	Wed, 29 Oct 2025 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761755196;
	bh=wELtySEeo9db8uxyOMgc0Q4pI1hleFdPzhwEcqjQAKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nNQeEbedZ/rb0FOdu2gxMiMcN5/Wtl3se9dzfrlWWlr7PDAiLjb2iyDZBymDKGOQA
	 /Bf6qayv2V/Sj96bvStIxqTGTPUVj2Kp7aCh6Qs1HTwpvzFoa528ELUCb/qt0cmcNN
	 IpdEtVJ/T0FgNcRigZBQCIUCXxBTcsRY+uIX0g8k6QKhbUBhkb0NBeTTRkHkKwrayD
	 CjRHu2pktrMdcxovl2bl3ggypdNDM6YbVie7pHYec2GzJNEUgJFuYT7PNt2xhPKJoB
	 Q38K/NSAWrKl4y69k2tpUFPlImC4aZFIaX1o238spVuWeTYGTjAwrDTtn2y6+kEKsa
	 dMwPWgg5bQObw==
Date: Wed, 29 Oct 2025 11:26:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
	"K, Kiran" <kiran.k@intel.com>,
	"Ben Ami, Golan" <golan.ben.ami@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Message-ID: <20251029162634.GA1565820@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44428a7c1e1d4565556335d6fb28919053da5d4d.camel@sipsolutions.net>

On Wed, Oct 29, 2025 at 11:38:31AM +0100, Johannes Berg wrote:
> On Tue, 2025-10-28 at 16:06 -0500, Bjorn Helgaas wrote:
> > > Obviously, we know the state of the device, but ... it _does_ require
> > > PCI removal *and* rescan, because the device completely falls off the
> > > bus and needs to be rediscovered. The drivers also fundamentally have to
> > > be unbound from it, since all state of the device (including BAR setup)
> > > is lost. I'm fairly certain that if you were to query even the device
> > > IDs after the reset, you'd see 0xFFFFFFFF, but in truth I don't fully
> > > understand how this works at the PCIe bus level.
> > 
> > It might be different for other buses, but the PCI core really doesn't
> > do anything to the device during removal or rescan.  It does turn off
> > power management interrupts from the device and the like, but I'm
> > pretty sure it doesn't reset the device or do anything to make it
> > start responding to PCI transactions again.
> 
> OK, fair. I have hit various weird issues with cached config space in
> the past (such as [1], which we never resolved), so I guess I'm possibly
> being ultra careful here in what I'm assuming or not.
> 
> [1] https://lore.kernel.org/linux-pci/20230605203519.bc4232207449.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid/
> 
> > Obviously remove and rescan reinitializes the *driver* because the PCI
> > core calls the driver .remove() method, reads the Vendor and Device
> > IDs, reads and if necessary programs the BARs, and calls the driver
> > .probe() method.
> 
> Right. So I guess in effect you're saying that device_reprobe() ought to
> be sufficient.
> 
> For WiFi, this code goes back to another issue we had (somewhat
> intentionally) where under certain circumstances during initialisation
> the firmware can do a product reset without the driver being aware, and
> then the driver just has to detect it by PCIe transactions failing with
> 0xFFFF'FFFF being read all the time. It's going to be hard to test this
> case now, but we can still test the product reset.

I think there are also some cases (maybe mostly embedded arm and
arm64?) where PCIe failures cause synchronous aborts or SError 
interrupts instead of just returning 0xFFFF'FFFF data.  Maybe nothing
you can do about that other than adding delay after initialization or
something.

> For BT detecting the error and initiation product reset, it does seem
> that doing (only) device_reprobe() for both functions is actually
> sufficient. I believe the FLR code in BT is broken though, so we're
> going to (re-)check all of this.
> 
> > I think it's really the PLDR that's making the difference here, not
> > the remove and rescan.  I guess you could experimentally read some
> > config registers after the PLDR and before the remove/rescan.
> 
> Yeah, just need to find real hardware with all the BIOS integration to
> run it ;-) (Most of our testing uses VMs.)
> 
> > Since you know the other device is dead already, I don't have a
> > problem with resetting the shared parts of the device, so you do need
> > some way to poke the other driver to reinit.  But I think using the
> > PCI core remove/rescan to do that makes it more complicated than
> > necessary and distracts from what's really happening.
> 
> Fair. I think the easiest way to achieve this is still device_reprobe()
> on the other device - eventually even if we tell the other driver then
> it still will simply call device_reprobe() on itself, so there's no big
> difference.

I hadn't heard of device_reprobe() until you pointed it out, but this
usage doesn't really seem to fit the intended purpose since the
probing critera haven't changed:

 * This function detaches the attached driver (if any) for the given
 * device and restarts the driver probing process.  It is intended
 * to use if probing criteria changed during a devices lifetime and
 * driver attachment should change accordingly.

But I definitely like it better than remove/rescan.  I suppose either
way results in udev remove/add events that are really spurious.  And
maybe PM artifacts like what you tripped over at [1] (although there
may still be a harmful PCI core race there).

Bjorn

