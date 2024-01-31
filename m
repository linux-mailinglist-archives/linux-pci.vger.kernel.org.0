Return-Path: <linux-pci+bounces-2899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFA844B30
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 23:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BF1F27F4D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138C383A4;
	Wed, 31 Jan 2024 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkdCyod1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405C83A1D3;
	Wed, 31 Jan 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741047; cv=none; b=s5jFTLatFxxkqYPK4J9PNjKsE+0J60mIJOtMA/w4c/Ax1Si58WmJWf5FQLmBuRZ1RsrwlS4UIpNRX/npyopDArRcghGFn8vSXSsC/v3g3tLj/GN2u5pU5CtDbW62pULb2iz1RTd/InCya1e6E/bWVvgGbpAPg977CdVtqGZdVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741047; c=relaxed/simple;
	bh=CDDV5nzO303GZ5Eq1xlfWVsb0CkQf/w57BtEmOpSHdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFsw+DTlrOgbEg0a+bEhCTh5RNEQGL0C986LVpL1qhG5PHVoppE2wU6w1T64YOwTFfspGSb5U5M5mY4xZdIKb5pOXSsExkhHKVfrYlvoyD0IIyUhLkuuzhgsZhKdqyAUfutkx/b3dM2xzcqOldZ5PiSaDpRECY/XoWuiQcXDU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkdCyod1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476C7C433F1;
	Wed, 31 Jan 2024 22:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706741046;
	bh=CDDV5nzO303GZ5Eq1xlfWVsb0CkQf/w57BtEmOpSHdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkdCyod12UwkHMoZFnHdOixtATV3t5zPDh5xlxIgMXeux28RVHIflE5+YqXj/rg+h
	 MMgsZA980RvF08seJZcLXNuJDf3Sek48tzM2qPuScpzmMv+5KWwK5LaXa57vRXIroP
	 wyfksOn4zDYGvT/bO4mMJUmfFI0XjKZAwkQdiuQ6dvj/9PtTG8j34GiNb9t2Bxepdv
	 Dq16Yt9VjalKAbOOobu357jmzicxGfgdpxnDcZb7z7fCvemOQGxVVD0V9usZ44HsxB
	 kYhjW6q6igVmUbbckNxIiKrgL6ArF+SdSkloWNyFtDLABN1z9L5WiujB+r95aEk8QB
	 pb3uKEe7KdK4Q==
Date: Wed, 31 Jan 2024 23:43:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Drake <drake@endlessos.org>,
	Vitalii Solomonov <solomonov.v@gmail.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <ZbrNLxHL03R66PxQ@x1-carbon>
References: <20240130095933.14158-1-jhp@endlessos.org>
 <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon>
 <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>

On Wed, Jan 31, 2024 at 07:08:12AM -0400, Daniel Drake wrote:
> On Wed, Jan 31, 2024 at 6:57 AM Niklas Cassel <cassel@kernel.org> wrote:
> > Unfortunately, we don't have any of these laptops that has a Tiger Lake
> > AHCI controller (with a disappearing drive), so until someone who does
> > debugs this, I think we are stuck at status quo.
> 
> I've asked for volunteers to help test things on those original bug
> reports (and may have one already) and would appreciate any suggested
> debugging approaches from those more experienced with SATA/AHCI. What
> would be your first few suggested debugging steps?
> 
> Non-LPM boot:
> ata1: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202100 irq 145
> ata2: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202180 irq 145
> ata2: SATA link down (SStatus 0 SControl 300)
> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
> LPM failed boot:
> ata1: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202100 irq 145
> ata2: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202180 irq 145
> ata1: SATA link down (SStatus 4 SControl 300)
> ata2: SATA link down (SStatus 4 SControl 300)
> 
> note SStatus=4 on both ports  (means "PHY in offline mode"?)

Hello Daniel, Vitalii,

The attachments that you uploaded to bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217114
namely dmesg_VMD_off and dmesg_VMD_on:

dmesg_VMD_off:[    1.020080] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
dmesg_VMD_off:[    1.020095] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
dmesg_VMD_off:[    1.020645] ata1: SATA max UDMA/133 abar m2048@0x80902000 port 0x80902100 irq 123 lpm-pol 0
dmesg_VMD_off:[    1.330090] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)


dmesg_VMD_on:[    0.973901] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
dmesg_VMD_on:[    0.973904] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
dmesg_VMD_on:[    0.974094] ata1: SATA max UDMA/133 abar m2048@0x82102000 port 0x82102100 irq 142 lpm-pol 0
dmesg_VMD_on:[    1.287221] ata1: SATA link down (SStatus 4 SControl 300)


I assume that both of these logs are from the same kernel binary.
Does this kernel binary have the Tiger Lake LPM enablement patch included?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=104ff59af73aba524e57ae0fef70121643ff270e

If so, since with Intel VMD turned off we can detect the SATA drive,
but with Intel VMD turned on we do not, which strongly suggests that
the problem is related to Intel VMD.



In libata we perform a reset of the port at boot, see:
libata-sata.c:sata_link_hardreset()
after writing to SControl, we call
libata-core.c:ata_wait_ready() that will poll for the port being ready
by calling the check_ready callback.
For AHCI, this callback funcion is set to:
libahci.c:ahci_check_ready().

A reset should take the device out of deep power state and should be
sufficient to establish a connection (and that also seems to be the
case when not using Intel VMD).

However, if you want to debug, I would start by adding prints to
libata-sata.c:sata_link_hardreset()
libata-core.c:ata_wait_ready()
libahci.c:ahci_check_ready().



Vitalii,

I noticed that the prints says "lpm-pol 0"
Do you have:
CONFIG_SATA_MOBILE_LPM_POLICY set to 0?

CONFIG_SATA_MOBILE_LPM_POLICY=0
means do not touch any settings set by firmware.

This means that this code:
https://github.com/torvalds/linux/blob/v6.8-rc2/drivers/ata/libata-eh.c#L3572-L3579
https://github.com/torvalds/linux/blob/v6.8-rc2/drivers/ata/libata-eh.c#L3067-L3072

will not call ata_eh_set_lpm(), which means that ahci_set_lpm() will not
be called, which means that sata_link_scr_lpm() will not be called.

While this shouldn't make a difference, and I didn't check the code
to see where "SATA link up" is printed, but possibly, when using VMD,
perhaps it is so quick to put the device to a deeper power state after
a reset, and with policy == 0, we will never send a ATA_LPM_WAKE_ONLY
that sets PxCMD.ICC to the active state (brings the device out of sleep).

Could you please try to set:
CONFIG_SATA_MOBILE_LPM_POLICY=3
and enable VMD again, and see if that makes you able to detect the SATA
drive even with VMD enabled.


Kind regards,
Niklas

