Return-Path: <linux-pci+bounces-42476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7DC9B5A8
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 12:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68DE44E3507
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F541CD2C;
	Tue,  2 Dec 2025 11:48:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2129.outbound.protection.partner.outlook.cn [139.219.17.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D2247289;
	Tue,  2 Dec 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676106; cv=fail; b=uEDoc52gq3VNU3FYTq/V45TSy4sJVDcOqDdGym0efPvnXbjQ7y6+UzOzwAbabBn6/25bHRJrOjtRmQz1guH8wgwEWZ3ElH/8JjOV+QWXAlzcuS4AlYpIE8EB9lkLOUqGcSi7JOuegRz+HpzY/WfUyU3jCzKQaTNRD8y3YdvxfJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676106; c=relaxed/simple;
	bh=I8njSH+P4c8tT//3JRNboLmxDGSclM/htDhv3dA9Bmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pndKmKfqQE/qBK2r+BZPYd4iebZCWvJ6XunWxYrK1ilCEB2QWINIoHUwXKG6XyDFhBHsaYQ0cjtxo+c8DjCjFwLeep6sUCSObenFLBzf4tcNE2hoTp0VQOb2SzKn9BVkp+Cvy1+PXp7OFtSTAHlKBPBPCXWcV5SfpFhmPnj3dC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIuZ9fce/ynNIEBFEOC487hHuGANm+OSimUsh94piSk7BZKQvfB8eHKr5eYHhYVgdYmnw9ajbBHlhxOhOmciSaJUWk+ArAI7nL/GVG5ZwsdiuxEA4IpCKw8ARCAsSX1AlHuEHLHwl1IK0gu7s3ccklkLHH4ww0Iw6HDRZQVhm2x1aJ3pYfWngQzV3Df0OX8YpIsCDKwJv8cfHGBsckqJ0z7HLx3H0CSW87cVGEJslJHA0STveZ+OFol8F5AQJGHbm1aGxpA3GluOfJAg+7ovCa6DvZbQbv6D3pGvJZZ3sG77eQQ/Qx/dZtPdq96Wyf/13pdmAtNHFhKDNlIvt7LeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++v4MPYb0zg/HMXLX0kXJVxCglGYOgthmgVEynH7LT8=;
 b=f3LMYue1jzNClQ3ltUxVBi+jPle9pE2DkzhFvh5Bq3+ReiRIGMmZR3OI363S5xqL3nlu5BZ4i1eDRg5unbo+KjFDS/T2uRstmDjBdmW28oKqLU3VO0buSGny94Pe2RtQmCZ9s+v71pf+2DKAyYSc715QVLFgSyavCpwKU0lAWF1umcmm7hSznTefSDTJR/KtDR6+WKw9CWl4WK26ePm1Io40mB6wPjhdyEfuLewy3W4DFRuXljEsPLsyVHvsEbO17qCz5MQ2JXnchY+pgqICB+ph9HUs2zJtGcXX/+tBNx+ftHz6JEVQMo/ghZuXtKs3iwUzJOEkyCx1CMTPZM7XrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 2 Dec
 2025 03:16:23 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b9:99db:485d:ea26]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::f2b9:99db:485d:ea26%4])
 with mapi id 15.20.9388.003; Tue, 2 Dec 2025 03:16:23 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Hal Feng <hal.feng@starfivetech.com>
CC: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Topic: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Index: AQHcYwRwWAZxAfe/n0a28faM175GW7UNkvowgAAXQxCAAAPMgA==
Date: Tue, 2 Dec 2025 03:16:23 +0000
Message-ID:
 <ZQ0PR01MB0981E3055536E5E7405093B882D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20251125075604.69370-2-hal.feng@starfivetech.com>
 <20251201205236.GA3023515@bhelgaas>
 <ZQ0PR01MB09816F6CF06E8021488DBCBC82D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
 <ZQ0PR01MB09816DBC8A88CEC939C8968482D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <ZQ0PR01MB09816DBC8A88CEC939C8968482D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1047:EE_
x-ms-office365-filtering-correlation-id: 64722de1-cb98-43e6-b5dd-08de31512c3e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|38070700021;
x-microsoft-antispam-message-info:
 OOcB4HPJiV8YCxrlfd6qMI1WlEPTeqxFY7fWDRZisg3feKqe+IF83sypmgOKikonNEvyeP7ydqzYC2XYe9M1pYczRFn0a8YtvAn5WmRNQK0FpX8nzOWhNNhNtBAPwM+vpoYG/idVZTyEftDH68NwDG9eIy/0UDSulI+m4k8x1cT0QmQZuM9dhsJ1BwM3UaFks0SvBcnSBkLlaqxLaICfNMqa30jteqOMaMBewvjfuy7ghhMpLnfRNHfXBo+G0WgMI+dVEj5Yy1O1RDGCn7pPHrG+tBJO3fOiRrcb2Z/MOkATaRi8ht4P5IalSUhB+y8NvMYZ71bzVKbrfs0U3ruwlcX/mcEc1Ugi652Gnh93WjUsq1WtICxkaOKOO4bgQkgEXDzkV95eiS11bHatdROwj172RjZ21Fo/dkzD40Ikp/PiFQUUxxtQ9ssVtR+FVyryFaRQdBTMyr49dl0NmNjgKMljRpqjkd+8JY/8frRyi0fwfiV6HLu2zA5MIlu6CgbMpEfBAOsHuC+44qJm7e15VlNwk/Lf3QIUcKfIeklQbO6ogMOQMxiUKV9g5Xv1bXNOv+sn2E06e2DoNzQS4h8uuWCi5t+VrXuBLksOSh4uD1I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?WoQLFuSvICG5tQZgiK3BVY24I3ufc0j71FGpfh3pKvXL7iyC+mew1za7tp?=
 =?iso-8859-2?Q?iQ+pzmlyiBTazJcLHexDl7pOaM1S1+sh3Ww2yZnxZdk80LNss6A4u3qEN1?=
 =?iso-8859-2?Q?DZbq6p7LTHpqjYUQL9pXJUWcs+zySUNQitvYK3wa4otC3K0bY96UG2Uxag?=
 =?iso-8859-2?Q?KxPMvCTQ1wUsBk7jtdv3l9ExX+DfG8RWio47J95dWtkruKcJ27NxdBtei6?=
 =?iso-8859-2?Q?XfPkhIP2d7E+aw7gSM+ovi4rbdXENnD5lv97E4jVfYrVox/4DBVeqB1sl8?=
 =?iso-8859-2?Q?nmwpali73DjyaduZrkIv42QRGC21fFex7PExjHJ4Xj6ndSs8yELH90N3ga?=
 =?iso-8859-2?Q?lowynGMlFAOi3cLvHiAhLFl2J/C5JDTdI85rnEcG4uhNfXSdA2mJzhHaeY?=
 =?iso-8859-2?Q?XSEV2SVBTeEvkgbf2Vlmw9CtctHq2pRMgETrS/Cs8Wo66KFm1Wr/GQ+SRX?=
 =?iso-8859-2?Q?e6b76RmoM+b5y4noe6sD93Q1LS8Wf6ADenYMSw8ioln4TKYs1uyj7cD0bl?=
 =?iso-8859-2?Q?4qkHrGeZJLDT5wrniGKLO0lmz3nPmBuzopL5v+WYMENpZBQTIQUhCL953v?=
 =?iso-8859-2?Q?CR68PcwYE1fQd6fFSzQtCs1nQrPL5AfbtUTiMx95igQpSqfWk9tVVM/JBX?=
 =?iso-8859-2?Q?43NJHNz7+kKCS7ERYBe51x3ef5eyxMZ6DYf0Z1BBu9KljHb2urS0SGfJRT?=
 =?iso-8859-2?Q?e4PyclDHbujvG236n2VksgCx7C0QeBvA+uk6JMSJWwE/4SExGhcLV9BtMt?=
 =?iso-8859-2?Q?n2351Yss+24gdCAaVUuasmPLMaAt87M7TICIb/chyVBg+6LNIVFeo981z5?=
 =?iso-8859-2?Q?+vp//ydW6DnWNnoRhfI05GxAcDA68H9Vq72AKidWpnylLxQ7xELfk3LdBA?=
 =?iso-8859-2?Q?nvqhOXxTO74Fyl9iXNpcvYt5tgAzIKaTVzsJib8UmIGtOT/PzV+/FjAu9S?=
 =?iso-8859-2?Q?RlscfXy5qhtIK9/Uma15ASLCVFdoqHPxEQeiM7O7EoNDmiRXrcF7gqWeC0?=
 =?iso-8859-2?Q?88S8cgMGAYc/x4n+gtOFvpex7zf5Vm0vuCuM9geXl6tH0EK1RDnDazaLCP?=
 =?iso-8859-2?Q?N/DvewciseCNqpfsM2J1WPYmZn0stl/4RMlwag3jiZGO56hSkZQCyuqzYl?=
 =?iso-8859-2?Q?RxleuiCxbcoKmhyBepaDFva5wCpx+3bqDGQ/OY5Bmgq2Swilf5AaMP72Jh?=
 =?iso-8859-2?Q?gY5kkeb7m/NpvaTSiqieA1eR0MMhqC0HeSBeHOaWbwp1W4FN6PN94zzQ3j?=
 =?iso-8859-2?Q?CIYVi4FlQbOpoH7lec+yDn/60/oRLoIQPEQIgcMB/2genSS4W8MBmTORk6?=
 =?iso-8859-2?Q?PQGDDBHFGDKMI8jZZjjtGZy3mLdzR+OGy1DNRd/EGirKhCOGtJ9I9redHP?=
 =?iso-8859-2?Q?zR0BExAjvBX1y+TG1Kkiv6yo4LXJnBAiXHjrHeRt6uAS9RwqonKdoN6igT?=
 =?iso-8859-2?Q?X2phoWBvc9fcjcngPk7NyjA0fG0BO+0sWdRhqK+TbgzNCdo0atBaXKJ5mp?=
 =?iso-8859-2?Q?yx9UeWDPV/qRtagQUqfpSEZt3OYEIzScWnrTo6W+1QJtjUW4gtHRZFTN2A?=
 =?iso-8859-2?Q?lR68aaoun42LuhLyZ1t1WJwiQ8FbYqU8AVDkajLCb7qi8DIrBdqnsmeyow?=
 =?iso-8859-2?Q?QI2U24s9f2TCeI7htgaF5E5yWtiAL/VYNhkw2zC2XZzh5Wl0uAAX+R0g?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 64722de1-cb98-43e6-b5dd-08de31512c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 03:16:23.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKHLhEYzuLpYmzobPLHz8OLZvIOwmPVqbbMUSNUqx5exe52U0ygdqXfi/tk1jFawgNv4FpcTW7PYcmcwJ3Qtpy0AuJBvTsQhxXDTgc8SpMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1047

> > >Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of  GPIO
> > >APIs to enable the 3V3 power supply of PCIe slots
> > >
> > > [+cc Kevin, pcie-starfive.c maintainer; will need his ack]
> > >
> > > Subject line is excessively long.
> > >
> > > On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
> > > > The "enable-gpio" property is not documented in the dt-bindings
> > > > and using GPIO APIs is not a standard method to enable or disable
> > > > PCIe slot power, so use regulator APIs to replace them.
> > >
> > > I can't tell from this whether existing DTs will continue to work
> > > after this change.  It looks like previously we looked for an
> > > "enable-gpios" or "enable-gpio" property and now we'll look for a
> > > "vpcie3v3-supply" regulator property.
> > >
> > > I don't see "enable-gpios" or "enable-gpio" mentioned in any of the
> > > DT patches in this series, so maybe that property was never actually
> > > used before, and the code for pcie->power_gpio was actually dead?
> > >
> >
> > pcie->power_gpio is used in the our JH7110 EVB, it share the same pcie
> > pcie->controller
> > driver with VisionFive2 board. Although JH7110 was not upstreamed, we
> > still hope to maintain the compatibility of the driver.
> >
>=20
> Sorry, I missed the background information regarding replacing enable_gpi=
o
> with regulator APIs. I agree with this change.
>=20
> > > Please add something here about how we know this won't break any
> > > existing setups using DTs that are already in the field.
> > >
> > > > Tested-by: Matthias Brugger <mbrugger@suse.com>
> > > > Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
> > >
> > > Based on the cover letter, it looks like the point of this is to add
> > > support for a new device, which I don't think really qualifies as a "=
fix".
> > >
> > > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Acked-by: Kevin Xie <kevin.xie@starfivetech.com>

> > > > ---
> > > >  drivers/pci/controller/plda/pcie-starfive.c | 25
> > > > ++++++++++++---------
> > > >  1 file changed, 15 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> > > > b/drivers/pci/controller/plda/pcie-starfive.c
> > > > index 3caf53c6c082..298036c3e7f9 100644
> > > > --- a/drivers/pci/controller/plda/pcie-starfive.c
> > > > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > > > @@ -55,7 +55,7 @@ struct starfive_jh7110_pcie {
> > > >  	struct reset_control *resets;
> > > >  	struct clk_bulk_data *clks;
> > > >  	struct regmap *reg_syscon;
> > > > -	struct gpio_desc *power_gpio;
> > > > +	struct regulator *vpcie3v3;
> > > >  	struct gpio_desc *reset_gpio;
> > > >  	struct phy *phy;
> > > >
> > > > @@ -153,11 +153,13 @@ static int starfive_pcie_parse_dt(struct
> > > starfive_jh7110_pcie *pcie,
> > > >  		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
> > > >  				     "failed to get perst-gpio\n");
> > > >
> > > > -	pcie->power_gpio =3D devm_gpiod_get_optional(dev, "enable",
> > > > -						   GPIOD_OUT_LOW);
> > > > -	if (IS_ERR(pcie->power_gpio))
> > > > -		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> > > > -				     "failed to get power-gpio\n");
> > > > +	pcie->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3");
> > > > +	if (IS_ERR(pcie->vpcie3v3)) {
> > > > +		if (PTR_ERR(pcie->vpcie3v3) !=3D -ENODEV)
> > > > +			return dev_err_probe(dev, PTR_ERR(pcie->vpcie3v3),
> > > > +					     "failed to get vpcie3v3 regulator\n");
> > > > +		pcie->vpcie3v3 =3D NULL;
> > > > +	}
> > > >
> > > >  	return 0;
> > > >  }
> > > > @@ -270,8 +272,8 @@ static void starfive_pcie_host_deinit(struct
> > > plda_pcie_rp *plda)
> > > >  		container_of(plda, struct starfive_jh7110_pcie, plda);
> > > >
> > > >  	starfive_pcie_clk_rst_deinit(pcie);
> > > > -	if (pcie->power_gpio)
> > > > -		gpiod_set_value_cansleep(pcie->power_gpio, 0);
> > > > +	if (pcie->vpcie3v3)
> > > > +		regulator_disable(pcie->vpcie3v3);
> > > >  	starfive_pcie_disable_phy(pcie);  }
> > > >
> > > > @@ -304,8 +306,11 @@ static int starfive_pcie_host_init(struct
> > > plda_pcie_rp *plda)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > -	if (pcie->power_gpio)
> > > > -		gpiod_set_value_cansleep(pcie->power_gpio, 1);
> > > > +	if (pcie->vpcie3v3) {
> > > > +		ret =3D regulator_enable(pcie->vpcie3v3);
> > > > +		if (ret)
> > > > +			dev_err_probe(dev, ret, "failed to enable vpcie3v3
> regulator\n");
> > > > +	}
> > > >
> > > >  	if (pcie->reset_gpio)
> > > >  		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > > > --
> > > > 2.43.2
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

