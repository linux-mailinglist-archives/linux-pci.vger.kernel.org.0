Return-Path: <linux-pci+bounces-17872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40919E7C35
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 00:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92179280D3A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 23:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96381F9EC6;
	Fri,  6 Dec 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwevWi3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2161EF090;
	Fri,  6 Dec 2024 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526415; cv=none; b=TjAfkBjcoaI/70HbS9CGAMh08qT3rJrfJ39aPGgj4YgDWNyTLrPqaPvybSDUSTvEa0lmjRYFNES2wVGGRkkBNap0wIr6rA6UFulO6c7a1/I6Yd7bNd09TF8HD6W9SQ3JjcwO69zTUs+Ml3YRasLYQmqDO6coRokbp8JGVV5rm7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526415; c=relaxed/simple;
	bh=ZtoiAjQ2U+lEx4d4Q+20KSR/KUtr9wtqJss8xBJgrck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JuARf8kXdWkJZWcZgHg6UC+oMRIT/Fxu6hZD92yYBXdlwTlNm2ksoKvgrD2EkmlkEpGnghW4VNvF15M87bgJ3xjWfhEUo3695sQiYpeGeb5G6eDIFj6dI0fQqOeQL59lLQ0ij1AJGetDaym+6EVpsjKyA3r2G5Hacq/dl1Vfw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwevWi3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A704C4CED1;
	Fri,  6 Dec 2024 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526415;
	bh=ZtoiAjQ2U+lEx4d4Q+20KSR/KUtr9wtqJss8xBJgrck=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GwevWi3zEYTROksNfCuVInm2/ZJETA3X2Omp/Nz3xcxMo2mI3KyQLeGRMdIZ3i2hi
	 Ghk+KC7pFawEoLcBHwDUsaUo15ija/rUOtN4E1Sw/jYgqxaZ2BCQunRqu8BZvvsTod
	 XWRSfjTgOXtxW88x+SPkzCrkBTiqGCPjSUQTBn6ApxX5Wv3zwvh15yMawHxLJQiSTl
	 AAhLLApcTm4v1CRpe0yZ/0aEb1UOGVgE1rmsHCzbS7O+oZ+QN91j3jAgXG9hwYYX72
	 gmrnBOUbdkKc/JjyODzR9kC9ZdlwLglkj2GgDVusG5k2GXusx0nZGLgboAvDL5d3zC
	 AD+VUkhOMamww==
Message-ID: <5f27c14467aa728358ebfe1686517aabe7c1e878.camel@kernel.org>
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
 <christophe.jaillet@wanadoo.fr>, niks@kernel.org
Date: Sat, 07 Dec 2024 00:06:49 +0100
In-Reply-To: <7a4a9d51a9105bd5ca2c850c26fed6435b5e90e9.camel@kernel.org>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
						 <20241018144755.7875-7-ilpo.jarvinen@linux.intel.com>
					 <db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org>
				 <91b501c0ce92de681cc699eb6064840caad28803.camel@kernel.org>
		 <7a4a9d51a9105bd5ca2c850c26fed6435b5e90e9.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 21:07 +0100, Niklas Schnelle wrote:
> On Fri, 2024-12-06 at 20:31 +0100, Niklas Schnelle wrote:
> > On Fri, 2024-12-06 at 19:12 +0100, Niklas Schnelle wrote:
> > > On Fri, 2024-10-18 at 17:47 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > This mostly reverts the commit b4c7d2076b4e ("PCI/LINK: Remove
> > > > bandwidth notification"). An upcoming commit extends this driver
> > > > building PCIe bandwidth controller on top of it.
> > > >=20
> > > > The PCIe bandwidth notification were first added in the commit
> > > > e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> > > > notification") but later had to be removed. The significant changes
> > > > compared with the old bandwidth notification driver include:
> > > >=20
> > ---8<---
> > > > ---
> > >=20
> > > Hi Ilpo,
> > >=20
> > > I bisected a v6.13-rc1 boot hang on my personal workstation to this
> > > patch. Sadly I don't have much details like a panic or so because the
> > > boot hangs before any kernel messages, or at least they're not visibl=
e
> > > long enough to see. I haven't yet looked into the code as I wanted to
> > > raise awareness first. Since the commit doesn't revert cleanly on
> > > v6.13-rc1 I also haven't tried that yet.
> > >=20
> > > Here are some details on my system:
> > > - AMD Ryzen 9 3900X=20
> > > - ASRock X570 Creator Motherboard
> > > - Radeon RX 5600 XT
> > > - Intel JHL7540 Thunderbolt 3 USB Controller (only USB 2 plugged)
> > > - Intel 82599 10 Gigabit NIC with SR-IOV enabled with 2 VFs
> > > - Intel n I211 Gigabit NIC
> > > - Intel Wi-Fi 6 AX200
> > > - Aquantia AQtion AQC107 NIC
> > >=20
> > > If you have patches or things to try just ask.
> > >=20
> > > Thanks,
> > > Niklas
> > >=20
> >=20
> > Ok I can now at least confirm that bluntly disabling the new bwctrl
> > driver with the below diff on top of v6.13-rc1 circumvents the boot
> > hang I'm seeing. So it's definitely this.
> >=20
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 5e10306b6308..6fa54480444a 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -828,7 +828,7 @@ static void __init pcie_init_services(void)
> >         pcie_aer_init();
> >         pcie_pme_init();
> >         pcie_dpc_init();
> > -       pcie_bwctrl_init();
> > +       /* pcie_bwctrl_init(); */
> >         pcie_hp_init();
> >  }
> >=20
>=20
> Also here is the full lspci -vvv output running the above on v6.13-rc1:
> https://paste.js.org/9UwQIMp7eSgp
>=20
> Also note that I have CONFIG_PCIE_THERMAL unset so it's also not the
> cooling device portion that's causing the issue. Next I guess I should
> narrow it down to the specific port where enabling the bandwidth
> monitoring is causing trouble, not yet sure how best to do this with
> this many devices.
>=20
> Thanks,
> Niklas

Ok did some fiddeling and it's the thunderbolt ports. The below diff
works around the issue. That said I guess for a proper fix this would
should get filtered by the port service matching? Also as can be seen
in lspci the port still claims to support bandwidth management so maybe
other thunderbolt ports actually do.

Thanks,
Niklas

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index b59cacc740fa..76a14f959c7f 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -294,6 +294,9 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
        struct pci_dev *port =3D srv->port;
        int ret;

+       if (srv->port->is_thunderbolt)
+               return -EOPNOTSUPP;
+
        struct pcie_bwctrl_data *data =3D devm_kzalloc(&srv->device,
                                                     sizeof(*data), GFP_KER=
NEL);
        if (!data)


