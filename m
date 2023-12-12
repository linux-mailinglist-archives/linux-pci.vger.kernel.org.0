Return-Path: <linux-pci+bounces-818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C725B80F8F1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 22:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045401C20B33
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4F65A84;
	Tue, 12 Dec 2023 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5qoh//a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00765A76
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 21:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6007EC433C7;
	Tue, 12 Dec 2023 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702415633;
	bh=tauT790JYR3PZ/TO/wKD0l4rLxy3Kf6huHHpYxETRHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I5qoh//aHETk/oxGwUfbxR6EMBAR0v9w1LiBloOupPGVBiaSqHTj2xbJtIbv2sCk3
	 cy90EROxRwcQjMYEpSexJH7aU0fOrWBg8F/g23fxQwHsCEDSrv5ERu+27B7v8po/Tr
	 2pRKxQNT9mI/Z0dd6Ebqy8HaBwlBA4AZTCMOk4lpO0Rvz1XW1kplacSz6kilD3rAZs
	 0HJHff7XbVafzqZVmfpF0wi2yIJyTM0WfF3Tw1NKYAngkcvIgjbjGEDy2ygZwPHkOI
	 m2USydamyF2O0TlXBXl8XZpoczJ6DolNW8M0/wVeaHMmRCmETvpgmXHlya5xUKdBGV
	 QWn3Y1EY6u9uQ==
Date: Tue, 12 Dec 2023 15:13:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20231212211351.GA1020185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173617bee344b58a47edfa35744e8dd4026db434.camel@linux.intel.com>

On Mon, Dec 11, 2023 at 04:05:25PM -0700, Nirmal Patel wrote:
> On Tue, 2023-12-05 at 18:27 -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:
> > ...

> > > Currently Hotplug is controlled by _OSC in both host and Guest.
> > > In case of guest, it seems guest BIOS hasn't implemented _OSC
> > > since all the flags are set to 0 which is not the case in host.
> > 
> > I think you want pciehp to work on the VMD Root Ports in the
> > Guest, no matter what, on the assumption that any _OSC that
> > applies to host bridge A does not apply to the host bridge created
> > by the vmd driver.
> > 
> > If so, we should just revert 04b12ef163d1 ("PCI: vmd: Honor ACPI
> > _OSC on PCIe features").  Since host bridge B was not enumerated
> > via ACPI, the OS owns all those features under B by default, so
> > reverting 04b12ef163d1 would leave that state.
> > 
> > Obviously we'd have to first figure out another solution for the
> > AER message flood that 04b12ef163d1 resolved.
> 
> If we revert 04b12ef163d1, then VMD driver will still enable AER
> blindly which is a bug. So we need to find a way to make VMD driver
> aware of AER platform setting and use that information to enable or
> disable AER for its child devices.
> 
> There is a setting in BIOS that allows us to enable OS native AER
> support on the platform. This setting is located in EDK Menu ->
> Platform configuration -> system event log -> IIO error enabling ->
> OS native AER support.
> 
> This setting is assigned to VMD bridge by vmd_copy_host_bridge_flags
> in patch 04b12ef163d1. Without the patch 04b12ef163d1, VMD driver
> will enable AER even if platform has disabled OS native AER support
> as mentioned earlier. This will result in an AER flood mentioned in
> 04b12e f163d1 since there is no AER handlers. 
> 
> I believe the rate limit will not alone fix the issue rather will
> act as a work around.

I agree with this part.  A rate limit would not solve the problem of
an interrupt storm consuming the CPU.  That could be addressed by
switching to polling when the rate is high or possibly other ways.

> If VMD is aware of OS native AER support setting, then we will not
> see AER flooding issue.
> 
> Do you have any suggestion on how to make VMD driver aware of AER
> setting and keep it in sync with platform setting.

Well, this is the whole problem.  IIUC, you're saying we should use
_OSC to negotiate for AER control below the VMD bridge, but ignore
_OSC for hotplug control.

I don't see how to read the _OSC spec and decide which things apply
below a VMD bridge and which things don't.

But I think a proposal that "_OSC doesn't apply to any devices below a
VMD bridge," that *is* a pretty generic principle.  If we think that's
the right way to use _OSC, shouldn't the vmd driver be able to
configure AER for devices below the VMD bridge in any way it wants?

I'm not sure what "_OSC doesn't apply below a VMD" would mean for
things like firmware-first error logging below the VMD.  Maybe
firmware-first doesn't make sense below VMD anyway because firmware
and the OS have different ideas about the Segment for those devices?

Bjorn

