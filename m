Return-Path: <linux-pci+bounces-42634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFFCA4344
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF0E3089445
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5822D47E8;
	Thu,  4 Dec 2025 15:05:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2099.outbound.protection.partner.outlook.cn [139.219.17.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC02D0C99;
	Thu,  4 Dec 2025 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860721; cv=fail; b=qwQJ3580W+/UP1OLqBp092FR+2tLoO+Fb+eIhwFpRgPdhT1rPZIZ/5+eAopVnGbnDqvjQFTaVQpgoy3+0GMFZ2MXFT1ZwffE/hyVbYnQgEjtJ/XrdR939MwyXEwTs3X+xE/VJvu0yqRvizFQDTDKQJKAeLaWEsJuWwgpdECnEM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860721; c=relaxed/simple;
	bh=PF+49HlI3kQqiHbLn8cNX2VAUx7gzusgARq3dq01/Bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NqFTd40/t+tSJYgCpbSpjpCjwr1D3jmPQy4hKto/+5BePRwTVc6Q0l4Vq1T90oOBCzkVhY6HF0Nzn8g1vnPXDNRK5KVdL5QpKTprHEd9AjVhTk6JxJdBHtJtrtZED6Yw7OH4ofa1eDAsp33vlZ3WwEYCja2+wkfC4kDyytd4oFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ2PR01MB1146.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::10) by ZQ0PR01MB1142.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 14:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsJIlV3LFX4YIuBcuIMoj/e2pE3r188zkvw0V0lXpxON+5cHhwUcS25+Xs9V8XSmudkq2ZUaO2wK4/NZbiNa4Pcyg7NfNx/MZifhlkxlXTb8v/NfwUEtgA102qlyJe4iBHgYNAUGU9UvXnroGHEtiL8tAyjBtMDpg6/4hMZDfS7SSdLLqn1E0N93SB5xCGqqOJy9Wg+XESi8A5YqvrVAoBr6G17MRLGT0jRX+guN+DMwnuGQNbox3wskjsLSV3ZBzoJG4v7wskc4aqjcADigIadyIIe8ABNxDJcgDbkZEinYiScyxmwA67XGMmzKga9PCEWg0wWugn9yeWemeYxVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUZkoO7Bs4QaiscVoESsOSi3d4yEvOR4YrK1LaEQuD8=;
 b=f5rhDKYHOcIVl/HEJ5cJvnHgpmDFxLBzU8ZwPOOlgsZzr4GNcyX3rD9xxNAKi5EDJY1bItN221LfPRuAbcl73gV7iFgkkH0UPE8LilRKjCkGlbrQTsEtdpzR949wkn/H3BpO9tdObClLQf6BnNnBcOHuakZnhenmtUyNCOuYIVEzXjU6TeB5xnvEEBlgGm2mrAPXP1/ehQeufiWrqP3KJvgZkfF5e56AgqhUHEsCFjFmowynfRpAdk+dyVQJwphvpl/mBuJJdFebeI1npClnebYByHAUElDPcs7G+POjt0dgEol2JZah5n1LcL5cigIPBmCwrrr1q6KplJFTRb7/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1146.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 13:19:53 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 13:19:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Kevin Xie <kevin.xie@starfivetech.com>
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
Subject: RE: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Topic: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to enable the 3V3 power supply of PCIe slots
Thread-Index: AQHcXeD4WDMn2zfogkuoU7yPusoik7UNTRYAgABR2wCAABWUAIAA4d8AgAEvWPA=
Date: Thu, 4 Dec 2025 13:19:53 +0000
Message-ID:
 <ZQ2PR01MB1307A6D1E4B93A716EFFDC25E6A62@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References:
 <ZQ0PR01MB09816DBC8A88CEC939C8968482D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
 <20251202163114.GA3075889@bhelgaas>
In-Reply-To: <20251202163114.GA3075889@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ2PR01MB1307:EE_|ZQ2PR01MB1146:EE_|ZQ0PR01MB1142:EE_
x-ms-office365-filtering-correlation-id: bc961581-2834-4d15-5ad4-08de3337cfaf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 XBteslkwDAJjEzkRjSLegtF+yZe08DkiWODSxA92QMFcztQ+2cjW6Vitv3i2+9QBL+RmndgTFs+TyL4exmcBsLm7XLWA9UDXxlV3D4lGgIbpScLdKgk+Dl8f9KVdiXvFhXVGstrY2v2h9wd2nBjIYhigiXKuEJZ0Bs6qE5vz1QBG9/3BzAJw/Xq1Q1tmAQC9776xUzScqAPXGKRBYEDg8m0afcfznBqrKdcDxDR3TUAEcrXHYAh+ICV86MCQoTsxOlKcSNFmO8MI89xRk3QvAcZSRiywY6FhoY4CtNf/sdr0huqmvX3knghmFHLrtC4st0x5Yfblm5kSJipnEJqFImZPcJVIxLy7d19hD5G+iums+6MjhV9QkJ4l5xFbDywHL9Qb/pMFS2BKkdd5i9wkgXVFT/0E5kX9BWIGZIkQ6GC0ExlB4PT2Bfaf4w1ZYAu1ZO2BxOCz34vgNjVTrDm6PN9hGhiISQAlrZbS8R2J1XB0mh6JTW27hHiGOWsbFk7bZ6IiZpfK8mvsOsmDCO+5fZ16QQUj4IElZ9vH3PWbJpKHiP4u1Ed6l5dNfU0ttjMVpyL3xNQcIYUdIMn02kgc7j8JVxPvElrU/gVeJKyaaJM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?NgQ/M5ArXGFUAgkEWRFB/vsED3+xGkqlpi9Z3kmYuyvRt5NimPixXpIyuU?=
 =?iso-8859-2?Q?iWRvl7KpmUzqizPqSIV25E+/FIhpXDVLsqUXuUDeHBix7Ljh9yWTD5ResT?=
 =?iso-8859-2?Q?T+uVW2UniHwtZgYrjL6caJSvjNJ46oxVRh2LYXx8xiHvzOXhT31k6bvSUR?=
 =?iso-8859-2?Q?r+XVSyOv4b+Hmk4vmgVNYXYrEhhox8/Lhe7PJFmzeW8XOu5h4loXCzGMhr?=
 =?iso-8859-2?Q?kw/hpyHTebvtIrrHodFC5+1gjSOxD2vX5d08jkfXv9RUhs3TjI7dxP/YUE?=
 =?iso-8859-2?Q?x2x8ADB//VyDgUyXNfFH4x5uUaLOuN0gRSE2JZvPLFnx0Y9ruXMFbg4Pag?=
 =?iso-8859-2?Q?ynb2db6pBKetFQpxQESad48m2RxCXy1ERIWzAI2YUpoyAYqdoVk16Hz8bO?=
 =?iso-8859-2?Q?vcGXvfpKCuNHKfTsMNiQ/2Cd1wRLeufUagCjoYFzfa8oRE3xZQDRd5rVK5?=
 =?iso-8859-2?Q?lKiYr+jGATcaeGjxPnYa4KaROmkK7HN/VJKL+qZimvIBjb/WTo7l0ygIdK?=
 =?iso-8859-2?Q?qbtcqu4ci77ROv/Zy3d8/P49kguQNPlaXKZL4CxtZ4oeyWBKO+VHIzjDiG?=
 =?iso-8859-2?Q?fuPBNn8jEcIAfdn/M5/7O1erXpWvTxOwy2wQH1W46sgzk6QvZM7n/5bPoQ?=
 =?iso-8859-2?Q?u+0dfH2E9/70Kg8O9GdLdXjwM0EBFmaa+FFpVfUbXPbalQ71eM6o0d11Rd?=
 =?iso-8859-2?Q?P8C+M1FYCwvBoIvdmm6VnveaC0g35sX/NUA8cBwT7vXarVOTSxZUQaRmdF?=
 =?iso-8859-2?Q?4B2XUBHcV5MBxABj+kKiuRdR1CwZtotCtbMmV5byp991ownR2pld4p4KcB?=
 =?iso-8859-2?Q?0niazg5r6Vvb3xhgnZ3ft9lS3s6eY1Up5/sg3V75nQ/Lc0NNv5bzfZ0sMP?=
 =?iso-8859-2?Q?JSgYI2pwAKnDnShWNqXAGqpCkPNG+EqlNjcPve0VABzb5hNM2Ar38zwFqU?=
 =?iso-8859-2?Q?lT5aDA3ruDWVevvBFU3So5G3a4VOOBrmZ6711Vuv9/w/DKAyo/ZuOEO/1q?=
 =?iso-8859-2?Q?2wHpj63ZXnjkIoiNVafkB/JdgMD9AeGMO+wJo/f6PUvgnmgfwu1nbF6/HX?=
 =?iso-8859-2?Q?eG/ykWeaaCdFWW/lEJGupJ4AdN7T1y3xvu+KHkP//PQ0hDiqJhPCU4J1tu?=
 =?iso-8859-2?Q?4WXyIaaqt5CMHTSR0iyfVS3ClHmtzNfGYsBj0drMfqxx+gv5QXrm1gQQ3e?=
 =?iso-8859-2?Q?9CIiqFkwnzYwi6MD9QSMKYIvRu0Y3sFU1T4s7hekpHyC7vm7gIE95R3C1S?=
 =?iso-8859-2?Q?ogQ2bVHv6QKfTQGlkyUhEoDNcvhmNrhXLT/1wulPjdRxy59zsJ6UFOaXmC?=
 =?iso-8859-2?Q?0VLUaB+vmtf0KwhwxDkRgf/cZk29FuZLjJUZc9sWaEHNuXTM1t+DLhq7BL?=
 =?iso-8859-2?Q?H5gwayWEwHVmkgFWS0K4mnA6I7NOEpCIAXoyvtfD4JzTMTax4++wD+V07q?=
 =?iso-8859-2?Q?ioDQYWPZ06YBA+L9GD2TVfSxWPPKi5IbOI67vFMZHWszXvK1njOHq5MdKn?=
 =?iso-8859-2?Q?aWt3U5sJjfjz4Z3BMvyoKaIKP+zbUz9/ljaUYcl2xtOIb/CE6dAW1ClYcL?=
 =?iso-8859-2?Q?GmZQOGeDkoc8dZlQC9uDTqqbNF2rhU9U7qeRW7dSUqlWnYrSPvouu7AIT6?=
 =?iso-8859-2?Q?tS+1u90qx/DVTGEtHL5uE0kRiMTDOnPZvD?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: bc961581-2834-4d15-5ad4-08de3337cfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 13:19:53.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKncWoJwdlm7Tg8NGUHcg2R9SIFkYQTua6JV5pdgxdhmnL0FEbEU4dpSypTNPGa08EyoGqDLZcOO+h+UGzEQe3CYCN7B7Mdqn7K9F7jS2rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1146
X-OriginatorOrg: starfivetech.com

> On 03.12.25 00:31, Bjorn Helgaas wrote:
> On Tue, Dec 02, 2025 at 03:02:48AM +0000, Kevin Xie wrote:
> > ...
>=20
> > > > On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
> > > > > The "enable-gpio" property is not documented in the dt-bindings
> > > > > and using GPIO APIs is not a standard method to enable or
> > > > > disable PCIe slot power, so use regulator APIs to replace them.
> > > >
> > > > I can't tell from this whether existing DTs will continue to work
> > > > after this change.  It looks like previously we looked for an
> > > > "enable-gpios" or "enable-gpio" property and now we'll look for a
> > > > "vpcie3v3-supply" regulator property.
> > > >
> > > > I don't see "enable-gpios" or "enable-gpio" mentioned in any of
> > > > the DT patches in this series, so maybe that property was never
> > > > actually used before, and the code for pcie->power_gpio was actuall=
y
> dead?
> > >
> > > pcie->power_gpio is used in the our JH7110 EVB, it share the same
> > > pcie pcie->controller driver with VisionFive2 board. Although
> > > JH7110 was not upstreamed, we still hope to maintain the
> > > compatibility of the driver.
> >
> > Sorry, I missed the background information regarding replacing
> > enable_gpio with regulator APIs. I agree with this change.
>=20
> OK, thanks.  I would still like to have something added to the commit log=
 to the
> effect that this change will break any DTs that use "enable-gpios" or "en=
able-
> gpio", but that's not a problem because such DTs were only internal to St=
arFive
> and we are OK with updating them and dealing with the fact that the DT is=
 rev-
> locked with the kernel version (old kernels would require an old DT with
> "enable-gpio" and new kernels require an updated DT with "vpcie3v3-
> supply").  Or DTs using "enable-gpio" never existed in the first place.
>=20
> Or whatever.  I just want the commit log to be clear that "enable-gpio" i=
s no
> longer supported and "vpcie3v3-supply" must be included instead, AND that
> you are aware of the breaking nature of the change and here is why that's=
 not
> an issue.

OK. I send another patch [1] today and add the some description to the comm=
it
log accordingly. Please check it. Thanks for your review.

[1] https://lore.kernel.org/all/20251204064956.118747-1-hal.feng@starfivete=
ch.com/

Best regards,
Hal

>=20
> We can't make kernel changes that require end users to upgrade the DT whe=
n
> they update the kernel or downgrade the DT when rolling back.
>=20
> Bjorn

