Return-Path: <linux-pci+bounces-18127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF69ECCD8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50569167A9B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54181EE7BB;
	Wed, 11 Dec 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeM6G5y1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C623FD04;
	Wed, 11 Dec 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922476; cv=none; b=nE+uCZ66lpCfI8DVEzQ4IfStwj7BAPQO42b9Q8uBzmOwe3f6lSzwlSEEJyzYgJt5dSodhG2Va0PF2IUiq2ifa9jxlGRmqoWqO0oV3sits30tSd7oT3TXjg7qKFbTNcS0Ok0yTHyAgEDDKVSXAirluaxl2KRGVPw2UoCtbHPi4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922476; c=relaxed/simple;
	bh=hwP08iiTroZvYMaXoxZcWTR5L5tzLEbjFJD4C4lJnrI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W4V/W9NM+qdn10fgsRvtciw2nHb875BFNqeEpnwI9m9feWnwH+RYbZT1OZuSJ9NrcVC6UkGmMO5V5XlP4hYUn87cTH5s7MpE4stweNo9IWTzRKNTqi9p098h/9po8RsRlG0ETnk7tvdhqvzy3UmbG4kDrb4Wo6pwy3MmUBULlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeM6G5y1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733922475; x=1765458475;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hwP08iiTroZvYMaXoxZcWTR5L5tzLEbjFJD4C4lJnrI=;
  b=LeM6G5y1ipxqKsBRHmHP5kWmEaiHbo5eXEY+QTzICZZ2ELE5Khm4L0w4
   MCsCaM4xMaKR3SFBjOlhXvp7e28FvSEMnf5XRr6cZ52aC14AwMz0TbiUx
   zKeq9HUEuNQbA7AAaiZkpMi8Eg2b/LoPEO/EwL5EueWlRcy5mT2S/waKS
   0tC2kcIzxLZMMRBnzMyBU8jPazN+coN9w9htimAGhdCzwf3F+bJxXx9HW
   yvxP0LNZamwfeWT7JnpOnjCgAwpwdh7HbAgdoipRjNufSmqInEYINHNNX
   GToDhMrjkk3ixVFV9gFVXPtnm4U+c71a5f3AohOSGIYHguUwcq6g3QstT
   Q==;
X-CSE-ConnectionGUID: LjdeCertQMO1u+9qcwg/dQ==
X-CSE-MsgGUID: 5dXMInu/RBONQV1mD5c9IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37133985"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="37133985"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:07:54 -0800
X-CSE-ConnectionGUID: QHYyk0tvSOWwbtQActBYmA==
X-CSE-MsgGUID: pKNJ3BVFTUSDmPc/iC9WLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126739102"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:07:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Dec 2024 15:07:38 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Niklas Schnelle <niks@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
    Krzysztof Wilczy??ski <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
In-Reply-To: <Z1lF468L8c84QJkD@wunner.de>
Message-ID: <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org> <Z1gSZCdv3fwnRRNk@wunner.de> <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org> <Z1lF468L8c84QJkD@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Dec 2024, Lukas Wunner wrote:

> On Tue, Dec 10, 2024 at 09:45:18PM +0100, Niklas Schnelle wrote:
> > On Tue, 2024-12-10 at 11:05 +0100, Lukas Wunner wrote:
> > > First of all, the Supported Link Speeds field in the Link Capabilities
> > > register (which you're querying here) was renamed to Max Link Speed in
> > > PCIe r3.1 and a new Link Capabilities 2 register was added which contains
> > > a new Supported Link Speeds field.  Software is supposed to query the
> > > latter if the device implements the Link Capabilities 2 register
> > > (see the other Implementation Note at the end of PCIe r6.2 sec 7.5.3.18).
> > 
> > Would it maybe make sense to update the comment for PCI_EXP_LNKCAP_SLS
> > in pci_regs.h to point out that in PCIe r3.1 and newer this is called
> > the Max Link Speed field? This would certainly helped me here.
> 
> The macros for the individual speeds (e.g. PCI_EXP_LNKCAP_SLS_2_5GB)
> already have code comments which describe their new meaning.
> 
> I guess the reason why the code comment for PCI_EXP_LNKCAP_SLS wasn't
> updated is that it seeks to document the meaning of the "SLS" acronym
> (Supported Link Speeds).
> 
> But yes, amending that with something like...
> 
> /* Max Link Speed (Supported Link Speeds before PCIe r3.1) */
> 
> ...probably make sense, so feel free to propose that in a separate patch.
>
> > > So to make this future-proof what you could do is check whether only a
> > > *single* speed is supported (which could be something else than 2.5 GT/s
> > > if future spec versions allow that), i.e.:
> > > 
> > > -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> > > +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> > > +		    hweight8(dev->supported_speeds) > 1)
> > 
> > This also makes sense to me in that the argument holds that if there is
> > only one supported speed bwctrl can't control it. That said it is
> > definitely more general than this patch.
> > 
> > Sadly, I tried it and in my case it doesn't work. Taking a closer look
> > at lspci -vvv of the Thunderbolt port as well as a debug print reveals
> > why:
> > 
> > 07:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
> >        ...
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
> >                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
> >                 LnkCtl: ASPM Disabled; LnkDisable- CommClk+
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s, Width x4
> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> > 	...
> >                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
> >                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
> >                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> >                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> > 	...
> > 
> > So it seems that on this Thunderbolt chip the LnkCap field
> > says 2.5 GT/s only as per the USB 4 spec you quoted but LnkCap2
> > is 0x0E i.e. 2.5-8 GT/s.
> > 
> > I wonder if this is related to why the hang occurs. Could it be that
> > bwctrl tries to enable speeds above 2.5 GT/s and that causes links to
> > fail?
> 
> Ilpo knows this code better than I do but yes, that's plausible.
> The bandwidth controller does't change the speed by itself,
> it only monitors speed changes.  But it does provide a
> pcie_set_target_speed() API which is called by the thermal driver
> as well as the pcie_failed_link_retrain() quirk.  I suspect the
> latter is the culprit here.  If that suspicion is correct,
> you should be seeing messages such as...
>
> "removing 2.5GT/s downstream link speed restriction"

That block is conditioned by pci_match_id() so I don't think it would 
execute.

The block that prints "retraining failed" is the one which attempts to 
restore the old Target Link Speed. TLS seems to also be set to 8GT/s as 
per the lspci from Niklas which is another inconsistency in the config 
space.

Although, I'd tend to think if these trigger the quirk/retraining now, 
kernel has done some retraining for these links prior to bwctrl was added, 
so perhaps that 8GT/s TLS is not going to be found as the culprit.

What could be tried though is to not do the LBMIE enabled at all which is 
one clearly new thing which comes with bwctrl. Commenting out the calls to 
pcie_bwnotif_enable() should achieve that.

> ...in dmesg but I think you wrote that you're not getting any
> messages at all, right?  Perhaps if you add "early_printk=efi"
> to the kernel command line you may see what's going on.
>
> One idea in this case would be to modify pcie_get_supported_speeds()
> such that it filters out any speeds in the Link Capabilities 2 register
> which exceed the Max Link Speed in the Link Capabilties register.
> However the spec says that software should look at the Link Capabilities 2
> register to determine supported speeds if that register is present.
> So I think we may not conform to the spec then.
> 
> The better option is thus probably to add a DECLARE_PCI_FIXUP_EARLY()
> quirk for Titan Ridge which sets the supported_speeds to just 2.5 GT/s.
> *If* you want to go with the future-proof option which checks that
> just one speed is supported.
>
> Titan Ridge is an old chip.  I'm not sure if newer discrete Thunderbolt
> controllers exhibit the same issue but likely not.

I recall taking note of this inconsistency in some lspci dumps I've from 
Mika (but forgot it until now). So I'm afraid it might be more widespread 
than just TR.

-- 
 i.


