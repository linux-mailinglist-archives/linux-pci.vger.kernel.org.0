Return-Path: <linux-pci+bounces-17879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB989E817D
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968DB1883E64
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5397A13A;
	Sat,  7 Dec 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyyixNDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9933FF1;
	Sat,  7 Dec 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595514; cv=none; b=TSehneTEQhekvTsh10RwaCFyRZYH7rnx4AoiVzXE71QxAVJis3P/Gx3MXA4guVEqYEkrvVidM3Hr021fvK8nc61fp+3bAQEdFpGStYHOPMWtxRGSr1PUgiWzf2+gNRMeHEkruDKq0hq7hlgoAa9vUJyKVtBRxz+sINymP3jCXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595514; c=relaxed/simple;
	bh=cDkEobS2aski+JFPLJVhb5pmqltEfNy1h3hATzOB8c8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Io6f0bzrW1SLzGRpRqczh8bXN4v1A7IFopzP2VgaLav9J1bf/mz94mCMKZzsmoAG7cn89gdvPttWXJrPGTJFWsw7G3FxV0dSGLvx6L3usCiIWxwp48V5cvqJHZOZR5i11lFY5gQmaoLr/8RoOjQBXpbLVsVQjOWIfsCSOCBONIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyyixNDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F7C4CECD;
	Sat,  7 Dec 2024 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733595513;
	bh=cDkEobS2aski+JFPLJVhb5pmqltEfNy1h3hATzOB8c8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HyyixNDVKhjVU2Gx8hXFLYokEoJRrDjyeTelMB6qQJE5ofj+zQ0dMnBU5bgJU4ykA
	 Eo/+bqdt4C40QA+r2DNU2kJBbxNtb1CuSIuZRQ+Pjq92UDnawtoW1f5wQf9aKk9c3U
	 YGBKZ+IW5af6tba3mK//CyhHB6c+iGAuacEE9A5VPQfRIOvzdfO6WLAOB8o+2Dq9s5
	 3KFrC1pPZvzNZk5Qt0fngTXymUcxZqlc+il74nAQJ8D/RWNPAVMu2+YUAjt7MCZMAn
	 Mjy550hBlhhvAJMNujWRuwa27wH85Odqgs1QmASM0Q7cLjbitpYwlcmxPsuah1sEv6
	 Wi8ws6nkrVtYQ==
Message-ID: <43fc3e56e969be45278054e9adb91419668bd762.camel@kernel.org>
Subject: Re: [PATCH v9 6/9] PCI/bwctrl: Re-add BW notification portdrv as
 PCIe BW controller
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Wilczy??ski	 <kw@linux.com>, "Maciej W . Rozycki"
 <macro@orcam.me.uk>, Jonathan Cameron	 <Jonathan.Cameron@huawei.com>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>,  Krishna chaitanya chundru	
 <quic_krichai@quicinc.com>, Srinivas Pandruvada	
 <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, 	linux-pm@vger.kernel.org, Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Date: Sat, 07 Dec 2024 19:18:27 +0100
In-Reply-To: <Z1R4VNwCOlh9Sg9n@wunner.de>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
	 <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
	 <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
	 <91b501c0ce92de681cc699eb6064840caad28803.camel@kernel.org>
	 <7a4a9d51a9105bd5ca2c850c26fed6435b5e90e9.camel@kernel.org>
	 <5f27c14467aa728358ebfe1686517aabe7c1e878.camel@kernel.org>
	 <Z1R4VNwCOlh9Sg9n@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-12-07 at 17:31 +0100, Lukas Wunner wrote:
> [cc +=3D Mika, start of thread:
> https://lore.kernel.org/all/db8e457fcd155436449b035e8791a8241b0df400.came=
l@kernel.org/
> ]
>=20
> On Sat, Dec 07, 2024 at 12:06:49AM +0100, Niklas Schnelle wrote:
> > > > On Fri, 2024-12-06 at 19:12 +0100, Niklas Schnelle wrote:
> > > > > I bisected a v6.13-rc1 boot hang on my personal workstation to th=
is
> > > > > patch. Sadly I don't have much details like a panic or so because=
 the
> > > > > boot hangs before any kernel messages, or at least they're not vi=
sible
> > > > > long enough to see. I haven't yet looked into the code as I wante=
d to
> > > > > raise awareness first. Since the commit doesn't revert cleanly on
> > > > > v6.13-rc1 I also haven't tried that yet.
> > > > >=20
> > > > > Here are some details on my system:
> > > > > - AMD Ryzen 9 3900X=20
> > > > > - ASRock X570 Creator Motherboard
> > > > > - Radeon RX 5600 XT
> > > > > - Intel JHL7540 Thunderbolt 3 USB Controller (only USB 2 plugged)
> > > > > - Intel 82599 10 Gigabit NIC with SR-IOV enabled with 2 VFs
> > > > > - Intel n I211 Gigabit NIC
> > > > > - Intel Wi-Fi 6 AX200
> > > > > - Aquantia AQtion AQC107 NIC
> >=20
> > Ok did some fiddeling and it's the thunderbolt ports. The below diff
> > works around the issue. That said I guess for a proper fix this would
> > should get filtered by the port service matching? Also as can be seen
> > in lspci the port still claims to support bandwidth management so maybe
> > other thunderbolt ports actually do.
> [...]
> > --- a/drivers/pci/pcie/bwctrl.c
> > +++ b/drivers/pci/pcie/bwctrl.c
> > @@ -294,6 +294,9 @@ static int pcie_bwnotif_probe(struct pcie_device *s=
rv)
> >         struct pci_dev *port =3D srv->port;
> >         int ret;
> >=20
> > +       if (srv->port->is_thunderbolt)
> > +               return -EOPNOTSUPP;
> > +
>=20
> Thanks for reporting and analyzing this.
>=20
> The PCIe bandwidth controller is only instantiated on Downstream Ports.
> Per the spec, Thunderbolt PCIe Downstream Ports are just tunnel endpoints
> with a fake Max Link Speed of 2.5 GT/s (USB4 v2 sec 11.2.1):
>=20
>    "Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput.
>     Throughput is implementation specific and based on the USB4 Fabric
>     performance."
>=20
> So your patch does make sense in so far as the link speed of Thunderbolt
> PCIe Downstream Ports is fixed to 2.5 GT/s and cannot be throttled becaus=
e
> that's already the lowest possible PCIe speed.  The actual speed is
> determined by the Thunderbolt links.
>=20
> The check for the is_thunderbolt bit should be moved to the if-clause in
> get_port_device_capability() which sets the PCIE_PORT_SERVICE_BWCTRL bit
> in the services mask.
>=20
> Alternatively, it may be worth considering not to instantiate the
> bandwidth controller if the only link speed supported is 2.5 GT/s.

Thanks for the great explanation. I think your last point is also a
good one, if 2.5 GT/s is the only possible link speed why even
instantiate the bandwidth controller. As get_port_device_capability()
already reads PCI_EXP_LNKCAP we also have that information right there
already. Since I put time and effort in already I've gone ahead and
cooked up a patch with this approach and will send that shortly.

>=20
> We should try to find out what actually causes the boot hang
> (some interrupt storm maybe?), but that can hopefully be done
> internally at Intel if the boot hang is reproducible.

Makes sense, I do remember that this was one of very few motherboards
for AMD CPUs with Thunderbolt.

Thanks,
Niklas

