Return-Path: <linux-pci+bounces-42429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E428C99EFD
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 04:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB83D3A4862
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F6D20C029;
	Tue,  2 Dec 2025 03:03:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9532AEE1;
	Tue,  2 Dec 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644585; cv=fail; b=gGzpb829HCCIX/DSouaE/BzLnhUGoBMzvju0K1MeQZVC8Pa4TDScx/O4jm+u5b/4yJzhCts4gYlLXNFyXuBNG7JK1y3CsydqSQbNYKsqySI2TwXz79r6DREWt+Vvr19BZq7LMvR21dy4OCcTH3xmiZDGUOhUNNKC2D5UDtZgxjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644585; c=relaxed/simple;
	bh=PSoXU1oFzCq0aKcG4CdgCIWSsmtz1UCQ3VFaSYj96+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=utEnhSjueTzSMt1k/v1ef1ZaDS8494Jj/syp5AZ12YZtXMuvKpOzHuCXX+672tW8KrMhxG5AltuX8fRMflWjW1WkO1Pooqiqphm6unL5aRP/469eBfmTNzsR9mQJy2fqzYBgUSKLibw0bCA1py9wA9PTcgj367PWGg/DZvkOqvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7yz6ENzh2FutRKmHIypeVWI9qnq4nHyaps9ZEciTrTn3UwqNUvttczGBZx8wQ4Q6wwPsmo6HeZUXP4CH6VDblxUSuyn+yghjzS39x6l+q2mKGjl4p6V4A8LOrjrr8mWItMfPo1nLVu9Q3zcPqobciZMStVUabpn8taxqGqoy4uuOYzS6CtaUaRie9Fj8G/tzQrUR3xxiQJOMhG9XLWESmnaYDF+g94NxPxYiazfMG3SIFcEWW7+TI2HCk2czvaASjV/QMPOuRBp+P5U2yXZjwvhqbdPNB/R0/ONgBsu6+DuJ8K9Qqj8/lRE802xROSRsghNGXn25rYBOZ7qJO7o8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQlwmg8bJ8qr/Fy/ZQFu+NrqccDgju+5RZXi7hHjXzU=;
 b=a4gc2Cot21h0DBWsJTBhbPHwj2CNmC9phyrrFHtItSYpUVDlSK1WKAZ/pXC5meVFKwPmJhcPZ9lim/e4HXFPZsOv6DVM7SmnHLgcKqfCagnU/u1Mp8pGV53aNleNnopBHfYa10eO5udUs3MSvag6N2MakmuSIM3UlEOnEXWYbFJbUKRvrtpOEcr/Q9kYzj4bZuyiq4kj98arbd5SsGA86ZaPpgIBx6JPMxpdA3Vo/GCbWzQKhjLAB/vrtMpTrjPPfiEjtMLKpKO3RfvqF+Lj76PC4ajxtvvO0vZCb6uZImXZbzSweKYZblFrhpkdTeMYSVV/FNZCkIoqahIX9hbI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1270.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 03:02:48 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::f2b9:99db:485d:ea26]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::f2b9:99db:485d:ea26%4])
 with mapi id 15.20.9388.003; Tue, 2 Dec 2025 03:02:48 +0000
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
Thread-Index: AQHcYwRwWAZxAfe/n0a28faM175GW7UNkvowgAAXQxA=
Date: Tue, 2 Dec 2025 03:02:48 +0000
Message-ID:
 <ZQ0PR01MB09816DBC8A88CEC939C8968482D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20251125075604.69370-2-hal.feng@starfivetech.com>
 <20251201205236.GA3023515@bhelgaas>
 <ZQ0PR01MB09816F6CF06E8021488DBCBC82D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
In-Reply-To:
 <ZQ0PR01MB09816F6CF06E8021488DBCBC82D82@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1270:EE_
x-ms-office365-filtering-correlation-id: 1e299e10-1a34-4e8a-d0d6-08de314f465a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|41320700013|1800799024|38070700021;
x-microsoft-antispam-message-info:
 LjOD3v84edKvIEtnDdOJLy+/rceey775Cx6/lCeUqVxKzpY5Fsu7sNEJymPvXZSsBS5JO/B8S3NlleVGxA7VOMPNK6ev2GY0pg81dCiXFgoGglY/Hl2aHiLt3dgVCKKIfowQqLLD3orteccoKbQFkyy2aDORWx+g4bQrAkmoBb3O/0YboINX+ZoP4px2MJmfPMCB1/Ye1wEquFfzu37a7qDb3ifbsLYaLQiUjIHT4s0RQZT4JKyAYiLI9jqEaIzdQjkgLMW3Gid077WFo6rC2Y++zjgspDt9OJ0FTg0TotS9cqQ8Hh/1fbMm2vfVVzX8awfjZ0VzbwFU1GrHNS6JzLCWukF8B1Fg/+giL4OpSWboAFjeLDFA39TmN6ioUCPwoQ3lzuKxBs+gr+P+JvCnXNt5rMIL7DyF4lvog1wMpRnwrYXruIF1Da5HgecbbLL5ItthJNlKcrvP5bea6j71dD+3WeE6uv8hBZL+sJx0zUYVibNv1V01ccjageMK4131qsXhi6NTAsWnfC2f2jImXdJqZ+9Ap+zHq8+HbSOwIwT3VI0mbjh8ept7XNKAIDP1NAWuLG8zc4jaeCkxULQPEjLcYlhSPncFn3OEmVSfZ0k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(41320700013)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?LBMVV8jtF1qFXUekBzDEEYEru6JOsQgiprG1RGCwl/7u98qiSylSXAM2aJ?=
 =?iso-8859-2?Q?6HHa03KE81djMdkxULdGfb5J5Qwp5DraeoyklLHa7LbPKx1AS/dB4Vrgkx?=
 =?iso-8859-2?Q?7HBw5PluyhXz2ymc1yKpu4noBGGwVEGdVrh7qT8e18o9O0RIUIav34MUv3?=
 =?iso-8859-2?Q?Dlo7K/VFfYeQMyPbznDm5sragwpoeBm1JzJfUjHsN69gp3NlfkEKLRCH4M?=
 =?iso-8859-2?Q?wQPYMUPt4jFQsxw4HFV4orHfQ5S7OWCa3YMJ1IgvAIiljA6XzusAeEpThq?=
 =?iso-8859-2?Q?Icbt9KaHxfocut0AbH5/TW0A89oLU2+FmG+jgpGNC428o2KzLOiK+vkV2b?=
 =?iso-8859-2?Q?aqucJtw6pqUBanTn51thljPHls0VMrTOv/tfuTP8XieWO2Xn6DbZu5E3z3?=
 =?iso-8859-2?Q?6ai5r/waNHAZEqTTz9DXOsjdXf3fXS4dCTnXKcUBzUleuyyVG23kEYA5Hw?=
 =?iso-8859-2?Q?fXwlehDMlL4Ik8Qssl+RMmzXkylijV5hmwaaMLP/I1wMNZH7mWdDGeWlJO?=
 =?iso-8859-2?Q?IxlPj3nXfzbGff86dU4t0+AEZTK8MzAYj4RfosySgIOP5bkQKSzWlnOFku?=
 =?iso-8859-2?Q?r/mOOdyLRc9Hh3dp2+bN2bYUUrqOegA26o+27uLJuy3M6cicClYe8y/lsk?=
 =?iso-8859-2?Q?Z8Dh+FjOi+UXjcdOH69XzEpf4yOKWKuLoTBPutxKgzJJ+REKzGvTSdWmob?=
 =?iso-8859-2?Q?caPhblL5Hk4xZg+5INsg8FnyXWjUyWPDciVlHK9ej7P104AuTUgD19iGH1?=
 =?iso-8859-2?Q?za3mLb/CJ9Kr9MHdcqtLy4epQ5ojZQl0dVlAwF9e8dhU9rg9qlzpvrOu2W?=
 =?iso-8859-2?Q?A/6h6t+frj+iRFknAvaUsOBGm/hK4Dk63ldMaQWJJsIQrDJJFnkTYMC2w0?=
 =?iso-8859-2?Q?58bvjuIvQ3CouplxtJUXTXVm8Go3322RZJtIGEFHL/xAl6tNpiyMW2fRzH?=
 =?iso-8859-2?Q?j6FQxQtH1Rvh2UiafqTnHn6iF9AQgAZQT9KEfZGk4q8XLu5/Be9RvqzUAJ?=
 =?iso-8859-2?Q?9oM3wC/xyqxndfrecMyechXEZLFE5hi7SVVozhSbqIemZAM7t6EpgfP7PU?=
 =?iso-8859-2?Q?iHCZOKkZJcE5NZ9K+KU3VSk5IcF+jl/YnxH51vQRWn0P6QuSUoSYnWEy5s?=
 =?iso-8859-2?Q?iX3VFpmFDbBFu6g6jlIP/XzXtMice5LJjxq3BGwgwzxfa6csm+RDAFpZSo?=
 =?iso-8859-2?Q?OQKMWY5MIvSaiwUQffQaaVCEft7DGjb51X3MwwBx58Kh76H1YxIQ45fHzc?=
 =?iso-8859-2?Q?qPsM53D+blK8h9L41dWwDEzM6d3Rpdt2LJJbceav0znD3fzZHVgZo+oKV4?=
 =?iso-8859-2?Q?id5Zvbauhn1JWC26Q/QV6ICznUAxFa/E/bqeYPGyse29JlckCaNODg184D?=
 =?iso-8859-2?Q?U6ILXgxJf1ZBQVHJf5IHkPU+rGhEMNJd+z50cci4/Q/X54n94smCAgkQ7V?=
 =?iso-8859-2?Q?zFq+TRFOmuNgH40bjrEtS6lFYYa72JIS771fbqcHQ7ejc8I4nx6wLytbqK?=
 =?iso-8859-2?Q?ipesBl7yxcejEhvNPMieBlrx+tHfzWMZi7xrNNGfN74UdQIH/4QXkmE28Q?=
 =?iso-8859-2?Q?A7ztKbTW5dy8/lrNp/A2KPkFOt7jnIJDng/6Ny748DQKXrut72M0WeiWjE?=
 =?iso-8859-2?Q?U4bzvEtIakuvIgHEcvXUhOyKU1TAoWL0SvZ/jkNO4GStT9m00ORVrg9A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e299e10-1a34-4e8a-d0d6-08de314f465a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 03:02:48.5536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVyMWxJfUrQHROLdaU6OZ/BeXPLqOI+xGravt1zEAT6ctlW+RlIA/lIb27TJAUI+UYwFefL91Zh20tRNGZHv0vCK30H8j6yNaeDKGpn+3m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1270

> Krzysztof Kozlowski <krzk+dt@kernel.org>; Palmer Dabbelt
> <palmer@dabbelt.com>; Paul Walmsley <pjw@kernel.org>; Albert Ou
> <aou@eecs.berkeley.edu>; Rafael J . Wysocki <rafael@kernel.org>; Viresh
> Kumar <viresh.kumar@linaro.org>; Lorenzo Pieralisi <lpieralisi@kernel.org=
>;
> Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>; Manivannan Sadhasivam
> <mani@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Emil Renner
> Berthing <emil.renner.berthing@canonical.com>; Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>; E Shattow <e@freeshell.de>;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org
>Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO
> APIs to enable the 3V3 power supply of PCIe slots
>=20
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Palmer Dabbelt
> > <palmer@dabbelt.com>; Paul Walmsley <pjw@kernel.org>; Albert Ou
> > <aou@eecs.berkeley.edu>; Rafael J . Wysocki <rafael@kernel.org>;
> > Viresh Kumar <viresh.kumar@linaro.org>; Lorenzo Pieralisi
> > <lpieralisi@kernel.org>; Krzysztof Wilczy=F1ski
> > <kwilczynski@kernel.org>; Manivannan Sadhasivam <mani@kernel.org>;
> > Bjorn Helgaas <bhelgaas@google.com>; Liam Girdwood
> > <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Emil Renner
> > Berthing <emil.renner.berthing@canonical.com>; Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com>; E Shattow <e@freeshell.de>;
> > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Kevin
> > Xie <kevin.xie@starfivetech.com>
> >Re: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of
> > GPIO APIs to enable the 3V3 power supply of PCIe slots
> >
> > [+cc Kevin, pcie-starfive.c maintainer; will need his ack]
> >
> > Subject line is excessively long.
> >
> > On Tue, Nov 25, 2025 at 03:55:59PM +0800, Hal Feng wrote:
> > > The "enable-gpio" property is not documented in the dt-bindings and
> > > using GPIO APIs is not a standard method to enable or disable PCIe
> > > slot power, so use regulator APIs to replace them.
> >
> > I can't tell from this whether existing DTs will continue to work
> > after this change.  It looks like previously we looked for an
> > "enable-gpios" or "enable-gpio" property and now we'll look for a
> > "vpcie3v3-supply" regulator property.
> >
> > I don't see "enable-gpios" or "enable-gpio" mentioned in any of the DT
> > patches in this series, so maybe that property was never actually used
> > before, and the code for pcie->power_gpio was actually dead?
> >
>=20
> pcie->power_gpio is used in the our JH7110 EVB, it share the same pcie
> pcie->controller
> driver with VisionFive2 board. Although JH7110 was not upstreamed, we sti=
ll
> hope to maintain the compatibility of the driver.
>=20

Sorry, I missed the background information regarding replacing enable_gpio =
with
regulator APIs. I agree with this change.

> > Please add something here about how we know this won't break any
> > existing setups using DTs that are already in the field.
> >
> > > Tested-by: Matthias Brugger <mbrugger@suse.com>
> > > Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
> >
> > Based on the cover letter, it looks like the point of this is to add
> > support for a new device, which I don't think really qualifies as a "fi=
x".
> >
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  drivers/pci/controller/plda/pcie-starfive.c | 25
> > > ++++++++++++---------
> > >  1 file changed, 15 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> > > b/drivers/pci/controller/plda/pcie-starfive.c
> > > index 3caf53c6c082..298036c3e7f9 100644
> > > --- a/drivers/pci/controller/plda/pcie-starfive.c
> > > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > > @@ -55,7 +55,7 @@ struct starfive_jh7110_pcie {
> > >  	struct reset_control *resets;
> > >  	struct clk_bulk_data *clks;
> > >  	struct regmap *reg_syscon;
> > > -	struct gpio_desc *power_gpio;
> > > +	struct regulator *vpcie3v3;
> > >  	struct gpio_desc *reset_gpio;
> > >  	struct phy *phy;
> > >
> > > @@ -153,11 +153,13 @@ static int starfive_pcie_parse_dt(struct
> > starfive_jh7110_pcie *pcie,
> > >  		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
> > >  				     "failed to get perst-gpio\n");
> > >
> > > -	pcie->power_gpio =3D devm_gpiod_get_optional(dev, "enable",
> > > -						   GPIOD_OUT_LOW);
> > > -	if (IS_ERR(pcie->power_gpio))
> > > -		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
> > > -				     "failed to get power-gpio\n");
> > > +	pcie->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3");
> > > +	if (IS_ERR(pcie->vpcie3v3)) {
> > > +		if (PTR_ERR(pcie->vpcie3v3) !=3D -ENODEV)
> > > +			return dev_err_probe(dev, PTR_ERR(pcie->vpcie3v3),
> > > +					     "failed to get vpcie3v3 regulator\n");
> > > +		pcie->vpcie3v3 =3D NULL;
> > > +	}
> > >
> > >  	return 0;
> > >  }
> > > @@ -270,8 +272,8 @@ static void starfive_pcie_host_deinit(struct
> > plda_pcie_rp *plda)
> > >  		container_of(plda, struct starfive_jh7110_pcie, plda);
> > >
> > >  	starfive_pcie_clk_rst_deinit(pcie);
> > > -	if (pcie->power_gpio)
> > > -		gpiod_set_value_cansleep(pcie->power_gpio, 0);
> > > +	if (pcie->vpcie3v3)
> > > +		regulator_disable(pcie->vpcie3v3);
> > >  	starfive_pcie_disable_phy(pcie);
> > >  }
> > >
> > > @@ -304,8 +306,11 @@ static int starfive_pcie_host_init(struct
> > plda_pcie_rp *plda)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	if (pcie->power_gpio)
> > > -		gpiod_set_value_cansleep(pcie->power_gpio, 1);
> > > +	if (pcie->vpcie3v3) {
> > > +		ret =3D regulator_enable(pcie->vpcie3v3);
> > > +		if (ret)
> > > +			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
> > > +	}
> > >
> > >  	if (pcie->reset_gpio)
> > >  		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > > --
> > > 2.43.2
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

