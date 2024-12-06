Return-Path: <linux-pci+bounces-17867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41A9E77D8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 19:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D9A18880CD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B591FFC4E;
	Fri,  6 Dec 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnhFn1Sj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8C2206A5;
	Fri,  6 Dec 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508764; cv=none; b=WuH/HsppV8kVeRTte6jmys6qshsrEfkNHYMuqdRei5+VnkjxutxfZo70xf/0UXJ7ICzjLBbAQ8pOu4/1/HB1VvXHiAxhT/bC8ft8WTGp1F85XNULAzduy+iHSbMof9UuLAP8vGxDwPuDJ4uuug9Ai/888T0qKywuk7QAXk1Qkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508764; c=relaxed/simple;
	bh=BD3rylJF4VrjXkyOGEszmEdPAFS1XWWp9p8/lp3GP64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFIRKc40oEmTFQKM3MHF4DRUorDKVPMDANLmzMUns8+1uf2pZujxibLRmG5TH8TbTgT0PJLbtNj4bZC+QyddIF/OhQ7W3izntNkdnqLH5Fpct2GItIofBA/cmEOt4A5JZHX1r0s+8hv/fDD1FpmVgOgydvpI2JxM4Ejsv9rGz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnhFn1Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C059C4CEDE;
	Fri,  6 Dec 2024 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733508763;
	bh=BD3rylJF4VrjXkyOGEszmEdPAFS1XWWp9p8/lp3GP64=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UnhFn1SjccuH+OFK60OheALghOj1seL4qxUwCxMDgCtWshCfchYrhZAiM0/zdPmvF
	 +SiyoHXrN4t+ibGfSNtTE9NoJsciM1orOlCfwkLTbNrxL+5xUcwlq9MryDozQlhW8D
	 lmAVFAWO0oTduGBDYvlD951tyX7PwopARsqBEj2jyANXyqWDcZBVwc5lTiPhAR5mwS
	 Dw7UplPiVya34VmGLg2PzXuv8rdh04Ied7jgWQqx32iIog2iePtmzjDEuf9nKwIA7x
	 vzqxe0ZMJQo29Uo5lXIq+eqO6rh3Dq1W5HMYkISZzgShLRT6r8R8dXAFOY5tZxNBWR
	 flSdXIHXIKXtA==
Message-ID: <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
Subject: Re: [PATCH v9 6/9] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
From: Niklas Schnelle <niks@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kw@linux.com>, "Maciej W . Rozycki"
 <macro@orcam.me.uk>, Jonathan Cameron	 <Jonathan.Cameron@Huawei.com>, Lukas
 Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, Krishna
 chaitanya chundru <quic_krichai@quicinc.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, 	linux-pm@vger.kernel.org, Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>,  Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, 	linux-pci@vger.kernel.org
Date: Fri, 06 Dec 2024 19:12:37 +0100
In-Reply-To: <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
	 <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-18 at 17:47 +0300, Ilpo J=C3=A4rvinen wrote:
> This mostly reverts the commit b4c7d2076b4e ("PCI/LINK: Remove
> bandwidth notification"). An upcoming commit extends this driver
> building PCIe bandwidth controller on top of it.
>=20
> The PCIe bandwidth notification were first added in the commit
> e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> notification") but later had to be removed. The significant changes
> compared with the old bandwidth notification driver include:
>=20
> 1) Don't print the notifications into kernel log, just keep the Link
> =C2=A0=C2=A0 Speed cached in struct pci_bus updated. While somewhat
> unfortunate,
> =C2=A0=C2=A0 the log spam was the source of complaints that eventually le=
ad to
> =C2=A0=C2=A0 the removal of the bandwidth notifications driver (see the l=
inks
> =C2=A0=C2=A0 below for further information).
>=20
> 2) Besides the Link Bandwidth Management Interrupt, enable also Link
> =C2=A0=C2=A0 Autonomous Bandwidth Interrupt to cover the other source of
> =C2=A0=C2=A0 bandwidth changes.
>=20
> 3) Use threaded IRQ with IRQF_ONESHOT to handle Bandwidth
> Notification
> =C2=A0=C2=A0 Interrupts to address the problem fixed in the commit 3e82a7=
f9031f
> =C2=A0=C2=A0 ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are
> acked")).
>=20
> 4) Handle Link Speed updates robustly. Refresh the cached Link Speed
> =C2=A0=C2=A0 when enabling Bandwidth Notification Interrupts, and solve t=
he
> race
> =C2=A0=C2=A0 between Link Speed read and LBMS/LABS update in
> =C2=A0=C2=A0 pcie_bwnotif_irq_thread().
>=20
> 5) Use concurrency safe LNKCTL RMW operations.
>=20
> 6) The driver is now called PCIe bwctrl (bandwidth controller)
> instead
> =C2=A0=C2=A0 of just bandwidth notifications because of increased scope a=
nd
> =C2=A0=C2=A0 functionality within the driver.
>=20
> 7) Coexist with the Target Link Speed quirk in
> =C2=A0=C2=A0 pcie_failed_link_retrain(). Provide LBMS counting API for it=
.
>=20
> 8) Tweaks to variable/functions names for consistency and length
> =C2=A0=C2=A0 reasons.
>=20
> Bandwidth Notifications enable the cur_bus_speed in the struct
> pci_bus
> to keep track PCIe Link Speed changes.
>=20
> Link:
> https://lore.kernel.org/all/20190429185611.121751-1-helgaas@kernel.org/
> Link:
> https://lore.kernel.org/linux-pci/20190501142942.26972-1-keith.busch@inte=
l.com/
> Link:
> https://lore.kernel.org/linux-pci/20200115221008.GA191037@google.com/
> Suggested-by: Lukas Wunner <lukas@wunner.de> # Building bwctrl on top
> of bwnotif
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Hi Ilpo,

I bisected a v6.13-rc1 boot hang on my personal workstation to this
patch. Sadly I don't have much details like a panic or so because the
boot hangs before any kernel messages, or at least they're not visible
long enough to see. I haven't yet looked into the code as I wanted to
raise awareness first. Since the commit doesn't revert cleanly on
v6.13-rc1 I also haven't tried that yet.

Here are some details on my system:
- AMD Ryzen 9 3900X=20
- ASRock X570 Creator Motherboard
- Radeon RX 5600 XT
- Intel JHL7540 Thunderbolt 3 USB Controller (only USB 2 plugged)
- Intel 82599 10 Gigabit NIC with SR-IOV enabled with 2 VFs
- Intel n I211 Gigabit NIC
- Intel Wi-Fi 6 AX200
- Aquantia AQtion AQC107 NIC

If you have patches or things to try just ask.

Thanks,
Niklas


