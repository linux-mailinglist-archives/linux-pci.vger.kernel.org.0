Return-Path: <linux-pci+bounces-18100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D779EC68D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6923F166A44
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291671D5CCD;
	Wed, 11 Dec 2024 08:06:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2578F40;
	Wed, 11 Dec 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904370; cv=none; b=OH+3Iexu4VXXUVNR17XIlkMuPKoHV/Gdk0UkTNCMER6lSwEq7t8kjDQnLvH0in9Yt3zfT69a3MLTbUYbjhOisV12oD39FarZ9HkxKIawCQYYf0ufdrwDgdTTcQEJK6n2A022g6ddgx05deTTQ8SHRLz1wChJU0mYZ8/IW2uVBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904370; c=relaxed/simple;
	bh=2lpg8Qm3GiRa97KUHnH0N1dMtBglvRTfu1J7vBXsmmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgjbiwa6RMqL/CM3QYxGdq2njCZN5rHnhGAIsklQJKvpzfZwR1hrKM0PN5ty/u7bS50fui+0vPzDOw2XkvHIMM4RcxZHvDzG1TrOgjuEXpC1CBfj4WQhoC1SI8Qb46Og4Sq8B2giB9eTm521CCF7FiPxc5+vnyeUKVGPcwAJLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id DF9BF100D9401;
	Wed, 11 Dec 2024 08:57:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AD03A603AE3; Wed, 11 Dec 2024 08:57:23 +0100 (CET)
Date: Wed, 11 Dec 2024 08:57:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Schnelle <niks@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Message-ID: <Z1lF468L8c84QJkD@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
 <Z1gSZCdv3fwnRRNk@wunner.de>
 <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>

On Tue, Dec 10, 2024 at 09:45:18PM +0100, Niklas Schnelle wrote:
> On Tue, 2024-12-10 at 11:05 +0100, Lukas Wunner wrote:
> > First of all, the Supported Link Speeds field in the Link Capabilities
> > register (which you're querying here) was renamed to Max Link Speed in
> > PCIe r3.1 and a new Link Capabilities 2 register was added which contains
> > a new Supported Link Speeds field.  Software is supposed to query the
> > latter if the device implements the Link Capabilities 2 register
> > (see the other Implementation Note at the end of PCIe r6.2 sec 7.5.3.18).
> 
> Would it maybe make sense to update the comment for PCI_EXP_LNKCAP_SLS
> in pci_regs.h to point out that in PCIe r3.1 and newer this is called
> the Max Link Speed field? This would certainly helped me here.

The macros for the individual speeds (e.g. PCI_EXP_LNKCAP_SLS_2_5GB)
already have code comments which describe their new meaning.

I guess the reason why the code comment for PCI_EXP_LNKCAP_SLS wasn't
updated is that it seeks to document the meaning of the "SLS" acronym
(Supported Link Speeds).

But yes, amending that with something like...

/* Max Link Speed (Supported Link Speeds before PCIe r3.1) */

...probably make sense, so feel free to propose that in a separate patch.


> > So to make this future-proof what you could do is check whether only a
> > *single* speed is supported (which could be something else than 2.5 GT/s
> > if future spec versions allow that), i.e.:
> > 
> > -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> > +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> > +		    hweight8(dev->supported_speeds) > 1)
> 
> This also makes sense to me in that the argument holds that if there is
> only one supported speed bwctrl can't control it. That said it is
> definitely more general than this patch.
> 
> Sadly, I tried it and in my case it doesn't work. Taking a closer look
> at lspci -vvv of the Thunderbolt port as well as a debug print reveals
> why:
> 
> 07:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
>        ...
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
>                         ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; LnkDisable- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
> 	...
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> 	...
> 
> So it seems that on this Thunderbolt chip the LnkCap field
> says 2.5 GT/s only as per the USB 4 spec you quoted but LnkCap2
> is 0x0E i.e. 2.5-8 GT/s.
> 
> I wonder if this is related to why the hang occurs. Could it be that
> bwctrl tries to enable speeds above 2.5 GT/s and that causes links to
> fail?

Ilpo knows this code better than I do but yes, that's plausible.
The bandwidth controller does't change the speed by itself,
it only monitors speed changes.  But it does provide a
pcie_set_target_speed() API which is called by the thermal driver
as well as the pcie_failed_link_retrain() quirk.  I suspect the
latter is the culprit here.  If that suspicion is correct,
you should be seeing messages such as...

"removing 2.5GT/s downstream link speed restriction"

...in dmesg but I think you wrote that you're not getting any
messages at all, right?  Perhaps if you add "early_printk=efi"
to the kernel command line you may see what's going on.

One idea in this case would be to modify pcie_get_supported_speeds()
such that it filters out any speeds in the Link Capabilities 2 register
which exceed the Max Link Speed in the Link Capabilties register.
However the spec says that software should look at the Link Capabilities 2
register to determine supported speeds if that register is present.
So I think we may not conform to the spec then.

The better option is thus probably to add a DECLARE_PCI_FIXUP_EARLY()
quirk for Titan Ridge which sets the supported_speeds to just 2.5 GT/s.
*If* you want to go with the future-proof option which checks that
just one speed is supported.

Titan Ridge is an old chip.  I'm not sure if newer discrete Thunderbolt
controllers exhibit the same issue but likely not.

Thanks,

Lukas

