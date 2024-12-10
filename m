Return-Path: <linux-pci+bounces-18052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B39EBAF5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 21:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732A11673E4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63922ACDC;
	Tue, 10 Dec 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuPefJyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5D22A1C3;
	Tue, 10 Dec 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863528; cv=none; b=XEMT6wx38qDmkSAqUr6pt6y7wtuQabmHxMBtUbcLZheSe3/ZYOJAm9CC3xNw0MPQ4tPH8yRwFUkCsnmsmUJBiRyHA0Pm9k6QZaUTwrSiQUV7TngZl9GsKumWTSDbeKcofFvTupgZgpIEaE1Q60xqviCpJV0gs9fAnmyEztSwOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863528; c=relaxed/simple;
	bh=ju4X+yZhI1BnsMkCLu3fV4gRYkOlFHLyiHLIqGY2oAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQa/wcEk6QKQvhRuASxSr/nVmg0/70awf+tc0fcocZjB7qBiOz3kluNNVAG361bgABl9TwTWk3QtflfcXmWqYYgbZ4bYlnlqoFuPVcJ/dPJgLPRETdpSqITy7VGwloW/q/h3XIeuye+zRN/wnVg5YPPlasokXU2ny2L0yJTWDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuPefJyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C215C4CED6;
	Tue, 10 Dec 2024 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733863526;
	bh=ju4X+yZhI1BnsMkCLu3fV4gRYkOlFHLyiHLIqGY2oAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fuPefJywZSC3M5DKCRmu3ip8euNlDXxGdFXxooGSAULaGIOQ5Nr3J7A8yuFDyXspy
	 oQHvIsVL3v9/2MJzNtHGIBnOWUMkQV9CLVYggHAk4mUIFLn8ppTNLaDNDJ5mzYNClN
	 VSAnWePQkypQYcUCAZYFVZbYW58OhC0MG5N26Q+r34e0hFf3ycJbcxEAjSzibf320q
	 lE8PTVeXmLFx2jA3BhWto17ogq/CBBuZPWRn1hOW/idRHZkiH8d3NfUHD4mV420G9X
	 OPPTNfH92OPYM86pO92Jhv5vAAilHptux61V7er22TPoa0+IyydzfwsiBKB9tsj9Ta
	 dmZsLMaPudTMQ==
Message-ID: <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Wilczy??ski	 <kw@linux.com>, "Maciej W .
 Rozycki" <macro@orcam.me.uk>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Krishna chaitanya chundru	 <quic_krichai@quicinc.com>, Srinivas Pandruvada	
 <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, 	linux-pm@vger.kernel.org, Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 10 Dec 2024 21:45:18 +0100
In-Reply-To: <Z1gSZCdv3fwnRRNk@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
		 <Z1gSZCdv3fwnRRNk@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 11:05 +0100, Lukas Wunner wrote:
> On Sat, Dec 07, 2024 at 07:44:09PM +0100, Niklas Schnelle wrote:
> > Trying to enable bwctrl on a Thunderbolt port causes a boot hang on som=
e
> > systems though the exact reason is not yet understood.
>=20
> Probably worth highlighting the discrete Thunderbolt chip which exhibits
> this issue, i.e. Intel JHL7540 (Titan Ridge).

Agree will ad for v2.

>=20
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -270,7 +270,8 @@ static int get_port_device_capability(struct pci_de=
v *dev)
> >  		u32 linkcap;
> > =20
> >  		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> > -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> > +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> > +		    (linkcap & PCI_EXP_LNKCAP_SLS) !=3D PCI_EXP_LNKCAP_SLS_2_5GB)
> >  			services |=3D PCIE_PORT_SERVICE_BWCTRL;
> >  	}
>=20
> This is fine in principle because PCIe r6.2 sec 8.2.1 states:
>=20
>    "A device must support 2.5 GT/s and is not permitted to skip support
>     for any data rates between 2.5 GT/s and the highest supported rate."
>=20
> However the Implementation Note at the end of PCIe r6.2 sec 7.5.3.18
> cautions:
>=20
>    "It is strongly encouraged that software primarily utilize the
>     Supported Link Speeds Vector instead of the Max Link Speed field,

>     so that software can determine the exact set of supported speeds
>     on current and future hardware. This can avoid software being
>     confused if a future specification defines Links that do not
>     require support for all slower speeds."
>=20
> First of all, the Supported Link Speeds field in the Link Capabilities
> register (which you're querying here) was renamed to Max Link Speed in
> PCIe r3.1=C2=A0and a new Link Capabilities 2 register was added which con=
tains
> a new Supported Link Speeds field.  Software is supposed to query the
> latter if the device implements the Link Capabilities 2 register
> (see the other Implementation Note at the end of PCIe r6.2 sec 7.5.3.18).

Would it maybe make sense to update the comment for PCI_EXP_LNKCAP_SLS
in pci_regs.h to point out that in PCIe r3.1 and newer this is called
the Max Link Speed field? This would certainly helped me here.

>=20
> Second, the above-quoted Implementation Note says that software should
> not rely on future spec versions to mandate that *all* link speeds
> (2.5 GT/s and all intermediate speeds up to the maximum supported speed)
> are supported.
>=20
> Since v6.13-rc1, we cache the supported speeds in the "supported_speeds"
> field in struct pci_dev, taking care of the PCIe 3.0 versus later version=
s
> issue.
>=20
> So to make this future-proof what you could do is check whether only a
> *single* speed is supported (which could be something else than 2.5 GT/s
> if future spec versions allow that), i.e.:
>=20
> -		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
> +		    hweight8(dev->supported_speeds) > 1)

This also makes sense to me in that the argument holds that if there is
only one supported speed bwctrl can't control it. That said it is
definitely more general than this patch.

Sadly, I tried it and in my case it doesn't work. Taking a closer look
at lspci -vvv of the Thunderbolt port as well as a debug print reveals
why:

07:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan R=
idge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
       ...
                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Lat=
ency L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x4
                        TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
	...
                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retim=
er- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Speed=
Dis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0=
dB preshoot
	...

So it seems that on this Thunderbolt chip the LnkCap field
says 2.5 GT/s only as per the USB 4 spec you quoted but LnkCap2
is 0x0E i.e. 2.5-8 GT/s.

I wonder if this is related to why the hang occurs. Could it be that
bwctrl tries to enable speeds above 2.5 GT/s and that causes links to
fail?

Thanks,
Niklas


