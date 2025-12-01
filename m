Return-Path: <linux-pci+bounces-42345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB1C95DC8
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 07:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B93A101E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1210127B32D;
	Mon,  1 Dec 2025 06:33:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF6A1FE45D
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764570835; cv=none; b=XYusw7BAfds21LBPexYuyVEenDFyCxTghF9OrH96ANatomLVmHoLps1RuJ+bEHFGUA0yQtrHb9Ou6IrSwp0cGshG1F5lG+EVL5TqfuZ9CQF+dLyKfs7tm0jD6Qrij8gS9j5UgS/1J6WaSA0PbcRZwNnqKqlKtuscOgx/e7/P7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764570835; c=relaxed/simple;
	bh=JzWmrefEHSpDmqZ4qc66PvUyXB1AMB3lqcctqLcJEBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TAi2+tEQ1p4iUR+ef5EKOXlSaVBeFSl+noznVcZWEENpBBHWCqvRSu7v/VIW/OOaZSJd96OQD5f9ClWklF35u0ivqjRhsAAFQWRkh4arCQiQlVEx1yzC4WE7aabMmiWzmbEAeGW3rOz2S/JFMTMkRkYHJN9tIpWh72OkzgYi1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5258E92009C; Mon,  1 Dec 2025 07:33:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4B0F892009B;
	Mon,  1 Dec 2025 06:33:50 +0000 (GMT)
Date: Mon, 1 Dec 2025 06:33:50 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: ashishk@purestorage.com, Bjorn Helgaas <bhelgaas@google.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250815003538.7017-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2512010559060.36486@angie.orcam.me.uk>
References: <20250723191334.35277-1-mattc@purestorage.com> <20250815003538.7017-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-2058476832-1449621486-1764569904=:36486"
Content-ID: <alpine.DEB.2.21.2512010618290.36486@angie.orcam.me.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2058476832-1449621486-1764569904=:36486
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.2512010618291.36486@angie.orcam.me.uk>

On Thu, 14 Aug 2025, Matthew W Carlis wrote:

> > CESta: RxErr- BadTLP+ BadDLLP+ Rollover- Timeout- AdvNonFatalErr-
> 
> The information you sent is somewhat incomplete. I guess you probably won't be
> able to get any of the LTSSM state information unless one of the devices has an
> ltssm log you can dump, but I doubt either of them do.
> 
> When I see that BadTLP and BadDLLP are still set it makes me suspect that
> the hierarchy isn't configured correctly in order for those errors to go
> to the root port. Or perhaps they're just being reported to the BIOS &
> ignored or not cleared.

 FWIW, there's no BIOS in this system, just U-Boot.  Also I'm not sure how 
this is supposed to be reported and handled other than by Linux, once the 
kernel has booted.

> > but how would I gather such error information?
> 
> Lets try to figure out what is in control of AER & how/whether the hierarchy
> is configured to send errors all the way to the root port. First we have to look
> around "OSC" related kernel logging & the adjacent root port. Example here from an
> Intel system we can see OS took control over AER (and other things) from BIOS. We
> can infer this was for Bus 4f root port since its logged just after afaik. The
> negotiation happens on a per root port basis so need to make sure its the root
> port in hierarchy of the devices we're interested in. I've seen some BIOS retain
> AER control over PCIe ports on the PCH.
> 
> Example dmesg from during boot:
> acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
> acpi PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
> PCI host bridge to bus 0000:4f

 Hmm, I don't know what OSC is and I seriously doubt U-Boot handles any of 
this stuff.  It does minimal PCI/e setup so as to be able to load software 
from a PCI/e storage or network device.

 I can see:

pcieport 0000:00:00.0: AER: enabled with IRQ 36

in the log, but no interrupts ever actually delivered:

 36:          0          0          0          0 DW-PCI-MSI-0000:00:00.0   0 Edge      aerdrv, PCIe bwctrl

 I've attached a recent bootstrap log and will appreciate if you guide me 
as to what to look for.

> We would want to look at lspci for the root port, the asmedia USP, the asmedia
> DSP and the USP of the pericom switch (when able). I don't have any nested
> switch configurations, but I think I can generalize it a little. Maybe this is
> a correct configuration (using BDFs from a system I have to start with).
> 
>  +-[0000:4f]-+-00.0 Intel Corporation ...
>  |           +-...
>  |           +-01.0-[50-57]--+-00.0-[51-57]--+-00.0-[52-53] 
> 
> RP: 4f:01.0
> USP (asmedia): 50:00.0
> DSP (asmedia): 51:00.0
> USP (pericom): 52:00.0

 Yeah, roughly:

-[0000:00]---00.0-[01-0b]----00.0-[02-0b]--+-00.0-[03]--
                                           +-02.0-[04]----00.0
                                           +-03.0-[05-09]----00.0-[06-09]--...
                                           ...
RP: 00:00.0
USP (asmedia): 01:00.0
DSP (asmedia): 02:03.0
USP (pericom): 05:00.0

> Root port can tell us if PCIe errors are going to the BIOS. IF any of the
> ErrCorrectable, ErrNon-Fatal, ErrFatal, are set in the RootCtrl then those
> error types would most likely go to the BIOS even if the OS thinks it took
> control. Someone will have to correct me if wrong about ARM. If you sent
> the full lspci -vvv of root port, USP/DSP/USP combo I could figure out
> whats going on.
> 
> lspci -vvv -s 4f:01.0
> 
> 4f:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         ...
>         ...
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
>                 LnkCap: Port #25, Speed 32GT/s, Width x8, ASPM not supported
>                         ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 16GT/s, Width x8
>                         TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #0, PowerLimit 75W; Interlock- NoCompl-
>                 RootCap: CRSVisible+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+

 I've attached a full `lspci -xxxx' dump instead, just in case anything 
else turns out useful.  I'll appreciate if you have a look.

  Maciej
---2058476832-1449621486-1764569904=:36486
Content-Type: application/x-xz; NAME=dmesg-unmatched.log.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2512010618241.36486@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=dmesg-unmatched.log.xz

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
1UK9iAMA1N2GiLHEZ/sCAAAAAARZWg==

---2058476832-1449621486-1764569904=:36486
Content-Type: application/x-xz; NAME=pci-xxxx-unmatched.log.xz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2512010619050.36486@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=pci-xxxx-unmatched.log.xz

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
AARZWg==

---2058476832-1449621486-1764569904=:36486--

