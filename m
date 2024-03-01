Return-Path: <linux-pci+bounces-4307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF5786DFC4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 12:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964791F24189
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390736995C;
	Fri,  1 Mar 2024 11:00:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1467E79;
	Fri,  1 Mar 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290857; cv=fail; b=HBsH/rVOtJ9ArNvMSH/8IE8roWx6OHQaYDBehMTQ7oBHC1KggeSEVNW8OjfNh75XgF07Co3vlLZIOUrv/auxSj5d4T2V60Oh6FJ8TyxVwcMcjFH+dsxRWJvw75bdn50+hfSFL7SKP7zdkyuAUZzzCTGzwurDiwSLL4UvsSRvnBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290857; c=relaxed/simple;
	bh=4EcKGVtFipKhFck54VfV2gsAgyjliwXZs/n+2uvmoG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPID4LL4omM9bPQMSqRACze/o+tsVmwIuxne5OzhDfEUUFcw9jNj8S0FJ0sVXn1t1XxO+VF7B2m0zS4S+2wPHMmjnFTrXbAMeFhCygRc2La15Au9gKmWSY9wSBVnfIIJi50J3xCXvsr+1iaNHbJfK33vQtnzmXb19pwWwX/GXOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPeZRXF7aSVl7H1oFBQiYR1A24jzawTN4XN9B3ikRbUxybGlAPC0s+QcdrShyqA76mKHp0GwWAQhJL+41MgMUNWf3aDgL6U+zOTMUoOJwH3htSFX/y6qHXnbkwUbXrjklRwocKEfgHrniAfskXR25Lpmk2B5yAxsj5PPfQ54OHsxHc2O2cfaqqRK0msgYeZx3lLnRQwZaEXtkayMKYuJYLySxx49nF1Hlx3Yykdy93XM5x44RjfgMeOuSfKirHN9qnfsxPvAlyTOObEH6Kl32Oyiai160BMESPiHInbJr/RL6Y3dI7BWWqZmUhBZ0PbAa97elkpXEirviU6kaa20hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIQewHXYNnVedN1Ibxzsh/skDP7UfnwRjFP1/PaKsn8=;
 b=nEH8BSQfRoFLk5XBq3+Q6lFWhI93EEDs4Cghxam6Vpy8mi7skh+GM2md62fw3ywcURsbNCQJwov2NVFgjR4OztF49RU8YeDncg6FsE55Gho/bdaPvt6YkakswQFfQ8ENGvcd6oiFCcBCw/4Jp3Ud0aNEKsB0ww+Vfpm5KWgAOYwujWdeLMSw+v2hV8Rbhr71trq/CLzZhl2g6pudblY1p4iNUZJkCtkLk5bqcwEMW47bjgY5L2C9vqgHpQOcVVkVoPQquJvHY7AoVYBMJv9c792KDasdUw2a/iD4HIOTOEyISQ13gYe2s7wOzVybIW2XIS+gtPsrU09A9HrQ0hbPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0541.CHNPR01.prod.partner.outlook.cn (10.43.110.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.47; Fri, 1 Mar 2024 11:00:41 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7316.039; Fri, 1 Mar 2024 11:00:41 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Conor Dooley <conor@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Daire McNamara
	<daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Philipp
 Zabel <p.zabel@pengutronix.de>, Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Kevin Xie
	<kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 05/23] PCI: microchip: Rename two PCIe data
 structures
Thread-Topic: [PATCH v15,RESEND 05/23] PCI: microchip: Rename two PCIe data
 structures
Thread-Index: AQHaaWiyA7Q5tqIZOEWq+4FAhKnLMrEhGcSAgAGi0EA=
Date: Fri, 1 Mar 2024 11:00:41 +0000
Message-ID:
 <SHXPR01MB0863701294B9FA8F9CFA6A1FE65EA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
 <20240227103522.80915-6-minda.chen@starfivetech.com>
 <ZeBWBfMlS4nxMZJ2@lpieralisi>
In-Reply-To: <ZeBWBfMlS4nxMZJ2@lpieralisi>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0541:EE_
x-ms-office365-filtering-correlation-id: cb9db192-85d3-4e17-5247-08dc39ded625
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NIEN88yE0r8+js/O02HOsf0AJ6RgXio6PCQ60MD1tEq4Sn4jTNGGg5hz+pj46WDUstiYjVFu/msyHPNjA9Lir4IiowzYWcIKIICksvo1BWog08bH4XEyx4lbV+c6bGuHd3RJJftW7dqp8ADCHqHBA1aGx6T98sCVjKBO/IVGag1Y0BAPzVrbGqGQMLurMP24qpPQn0RlWXVNJxjFzHVud3S8/TUibP4wOk/OiiuKg5ulMoaWEVOn3AsPJhYAcF9yhrtGUoIe0XM6suNTbriOygUWcMFb2W7hHyGJZsZ3vpH5wWc//AdmvM0slLts87vK202kekPg9NkZev/Hi6lm5FvkPpWLHVGFrtmo52p/a0qgHTVNU4YjSB1DBDIWpcg6GjY0Dws2JdkvqnnskPAwonq8QE6sHbF9eLh4StljamSM4wdjf2ySkssLoLroUSU98LiKyALmCarzDdJ1KKs39l/F+6V6+Zh5Spjo3KHH67FONeexKCMo0y3z9TuId2FuD6eJaIGTcRk1JqD/hRhF5GPE9h17D9zFxpXCKXjzZ/fL8tDQa4lRSMEm4sUAcPuZ2iODqa/hBII+MFwEc4OA4K8vEqgvpQwn44y4BQ+OY62lnKxhz8T5mdYZSmVRQdPK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?3eJXK433xUJmfLvsuSTHLgqSo/ygSJ8l/DRmRlB/7JTOXP+dzwOrgn21bu?=
 =?iso-8859-2?Q?oh+ktUWNCo/IB/ITPxN6dHZrHKSfNrx3cTkvyQcGdrH/l7kz79iLh2D5fW?=
 =?iso-8859-2?Q?r07SaoNuwcb6qtIalH1bQm5jccAjiDah2Q0nAJBxC37ZGNG8HzyUj5F/Te?=
 =?iso-8859-2?Q?In4LDB73+Tw8I27fnqGS2O0qlc3UPofIiW0HDbWO1SWG9svU9U5BPn//Jt?=
 =?iso-8859-2?Q?iMyroj20SPi6/oo/E56civOFjokuOFj1UcMUhJMpcIE7nlD8KLiDSDQ0Yj?=
 =?iso-8859-2?Q?e1jwSYkj9Aeqv03ogonyWYhkdZO/XlRTJabOgxnvLTPBh605/BKrRLfyZr?=
 =?iso-8859-2?Q?3xizZhDOuhwtmp0ipD3PeSYwIsKhi53lrq6m+UhcTOyQ0jWZRNnZXMf2Vv?=
 =?iso-8859-2?Q?7Ib4Kiue5tuDhoaXKSuBy50wB5NpvJofdMoo+N+nbu1x+izdqZKQ4xXyDy?=
 =?iso-8859-2?Q?dOcZd3y4Fzq4V98D1LoChALR43YRpkb215+FmRTT6Iy+Yx/utTBSpjjwzW?=
 =?iso-8859-2?Q?OBVXPInXIYzoMYfOfZ+uGoiK3LwbWtntTmn9brl9OeCLoFABl0He/uFxQS?=
 =?iso-8859-2?Q?cBjAaZA8WWkrXnWa23r4cYEZWekq2+1aXtGwnJPSlkWRmZlOtTJl01i9qj?=
 =?iso-8859-2?Q?7p7qav+ypEopqg5zIGSQxrBfG7qYp5oWWUdcBpnGm+5XV9MuuOtjUAUhmY?=
 =?iso-8859-2?Q?QNwvu84d4SZTR3xI7I3bAQef2ma5b0PPOJj/PmbibeXevoAdhtsG6+oENV?=
 =?iso-8859-2?Q?g4cWzojChnHAq827KGpW5esOHX/imQu6+DBqkC6quT6jAhFKj1rA5tPErv?=
 =?iso-8859-2?Q?e3aAK/VXOVUVJ+NOixGXxPnoGpHd2d7ttk1BnRTsp7nvjXsX/R4ju+DkQy?=
 =?iso-8859-2?Q?TaPkJf/Y8WK3UzQp8Ki1YCwAIAFk2Mvu/SQyglSu5CO80gp7EX0/QSC5Do?=
 =?iso-8859-2?Q?yaAYUjc1bl71X6w/UM1cPhDcoYq7cPm59TGa+EpyScS84EMnpXRH/tqOuH?=
 =?iso-8859-2?Q?yU5LpARXSEPli3Y/ARbcOYU8x+AvR9pPkaX1i61Rw+oj9HDGbgChVjY/6i?=
 =?iso-8859-2?Q?s8PV/k43OudhXjU1RUINOjOgeVQZvNskdeaTbIM2Z4t/Y5qWD6tjShNfgG?=
 =?iso-8859-2?Q?wd9ELMlFJ2KL6mhiEelpn8oe1hye3twsb0bcxrHlKDQBNeHHxo08rm6Qch?=
 =?iso-8859-2?Q?MSNkyPJddftlAZlRdDh1KcZCKOx4ibJVKsQXn8lQxnI4r/BfmMyjekv3Cm?=
 =?iso-8859-2?Q?t7y/4QZlBYT7wCF584nNnX/gpdVKyKyz72obNjUx+FhLz6oOZ3eWZxhIoY?=
 =?iso-8859-2?Q?GS94y8SwWe4ZqAK8nJ381jyChFgWz0w2HIQqDDvrJO9nG0zTrgN7TlhobF?=
 =?iso-8859-2?Q?J6pK6e4a4JW6b5q1js2yze+rVefUVObiU4ntJ6RsFLm5fgDqvNsN7WmcPo?=
 =?iso-8859-2?Q?hbhsIuZ02Kmtxjcscxm782jvoFiFqu4sGKIUK/ZvahGOfqDDmW4WuJrJGS?=
 =?iso-8859-2?Q?WEzZTCvBDMh8hOK/cRUhZqRODfJrgaXgpVx9yyTq/5J3beOAh3QBE0rc6b?=
 =?iso-8859-2?Q?CONCGphK4Elf5HUVsqMzglWDjxG/f6r3IKMaQP7xJpXXhkxq3Wznr/y1Mf?=
 =?iso-8859-2?Q?mBNPd318UZAJnw+90HmyWidFnyS7JMp0bkjQXiuAWr0rBW0vRV1SutLg?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9db192-85d3-4e17-5247-08dc39ded625
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 11:00:41.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RDHmq517XCOWA9ttGjC6STo7CYMGaBRf+NWfdlwq14wul25ZHjZXhBxM07b8mIqvbfbk/Ie7PZwLMvcNXXtWqs1wyYE5DlacGTvWfX0rRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0541



>=20
> On Tue, Feb 27, 2024 at 06:35:04PM +0800, Minda Chen wrote:
> > Add PLDA PCIe related data structures by rename data structure name
> > from
> > mc_* to plda_*.
> >
> > axi_base_addr is stayed in struct mc_pcie for it's microchip its own da=
ta.
>=20
> Here in "for it's microchip" you mean "since it's microchip" own data.
>=20
> Please fix this "for" usage in all commit logs, I noticed it is a recurre=
nt mistake
> you make I can do it but it is tedious.
>=20
> Don't resend another version yet, I am trying to see what I can take from=
 this
> one.
>=20
Thanks. I will change this. I know the Starfive codes need time to review. =
So previous=20
I just request accept some refactoring patches first. It looks now this can=
't be achieved.=20
I will send next version in 6.9-rc1.=20
And Kevin will reply the Starfive patch(patch 21, patch 22).

> > The event interrupt codes is still using struct mc_pcie because the
> > event
>=20
> "code", please not "codes". Please fix it everywhere in your patch series=
, same
> as above.
>=20
> Lorenzo
>=20
I will check all the commit message.

> > interrupt codes can not be re-used.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../pci/controller/plda/pcie-microchip-host.c | 96
> > ++++++++++---------
> >  1 file changed, 53 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> > b/drivers/pci/controller/plda/pcie-microchip-host.c
> > index c55ede80a6d0..df0736f688ce 100644
> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > @@ -22,7 +22,7 @@
> >  #include "pcie-plda.h"
> >
> >  /* Number of MSI IRQs */
> > -#define MC_MAX_NUM_MSI_IRQS			32
> > +#define PLDA_MAX_NUM_MSI_IRQS			32
> >
> >  /* PCIe Bridge Phy and Controller Phy offsets */
> >  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> > @@ -179,25 +179,29 @@ struct event_map {
> >  	u32 event_bit;
> >  };
> >
> > -struct mc_msi {
> > +struct plda_msi {
> >  	struct mutex lock;		/* Protect used bitmap */
> >  	struct irq_domain *msi_domain;
> >  	struct irq_domain *dev_domain;
> >  	u32 num_vectors;
> >  	u64 vector_phy;
> > -	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
> > +	DECLARE_BITMAP(used, PLDA_MAX_NUM_MSI_IRQS);
> >  };
> >
> > -struct mc_pcie {
> > -	void __iomem *axi_base_addr;
> > +struct plda_pcie_rp {
> >  	struct device *dev;
> >  	struct irq_domain *intx_domain;
> >  	struct irq_domain *event_domain;
> >  	raw_spinlock_t lock;
> > -	struct mc_msi msi;
> > +	struct plda_msi msi;
> >  	void __iomem *bridge_addr;
> >  };
> >
> > +struct mc_pcie {
> > +	struct plda_pcie_rp plda;
> > +	void __iomem *axi_base_addr;
> > +};
> > +
> >  struct cause {
> >  	const char *sym;
> >  	const char *str;
> > @@ -313,7 +317,7 @@ static struct mc_pcie *port;
> >
> >  static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem
> > *ecam)  {
> > -	struct mc_msi *msi =3D &port->msi;
> > +	struct plda_msi *msi =3D &port->plda.msi;
> >  	u16 reg;
> >  	u8 queue_size;
> >
> > @@ -336,10 +340,10 @@ static void mc_pcie_enable_msi(struct mc_pcie
> > *port, void __iomem *ecam)
> >
> >  static void mc_handle_msi(struct irq_desc *desc)  {
> > -	struct mc_pcie *port =3D irq_desc_get_handler_data(desc);
> > +	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> >  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> >  	struct device *dev =3D port->dev;
> > -	struct mc_msi *msi =3D &port->msi;
> > +	struct plda_msi *msi =3D &port->msi;
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> >  	unsigned long status;
> >  	u32 bit;
> > @@ -364,7 +368,7 @@ static void mc_handle_msi(struct irq_desc *desc)
> >
> >  static void mc_msi_bottom_irq_ack(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> >  	u32 bitpos =3D data->hwirq;
> >
> > @@ -373,7 +377,7 @@ static void mc_msi_bottom_irq_ack(struct irq_data
> > *data)
> >
> >  static void mc_compose_msi_msg(struct irq_data *data, struct msi_msg
> > *msg)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> >  	phys_addr_t addr =3D port->msi.vector_phy;
> >
> >  	msg->address_lo =3D lower_32_bits(addr); @@ -400,8 +404,8 @@ static
> > struct irq_chip mc_msi_bottom_irq_chip =3D {  static int
> > mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  				   unsigned int nr_irqs, void *args)  {
> > -	struct mc_pcie *port =3D domain->host_data;
> > -	struct mc_msi *msi =3D &port->msi;
> > +	struct plda_pcie_rp *port =3D domain->host_data;
> > +	struct plda_msi *msi =3D &port->msi;
> >  	unsigned long bit;
> >
> >  	mutex_lock(&msi->lock);
> > @@ -425,8 +429,8 @@ static void mc_irq_msi_domain_free(struct
> irq_domain *domain, unsigned int virq,
> >  				   unsigned int nr_irqs)
> >  {
> >  	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(d);
> > -	struct mc_msi *msi =3D &port->msi;
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(d);
> > +	struct plda_msi *msi =3D &port->msi;
> >
> >  	mutex_lock(&msi->lock);
> >
> > @@ -456,11 +460,11 @@ static struct msi_domain_info
> mc_msi_domain_info =3D {
> >  	.chip =3D &mc_msi_irq_chip,
> >  };
> >
> > -static int mc_allocate_msi_domains(struct mc_pcie *port)
> > +static int mc_allocate_msi_domains(struct plda_pcie_rp *port)
> >  {
> >  	struct device *dev =3D port->dev;
> >  	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
> > -	struct mc_msi *msi =3D &port->msi;
> > +	struct plda_msi *msi =3D &port->msi;
> >
> >  	mutex_init(&port->msi.lock);
> >
> > @@ -484,7 +488,7 @@ static int mc_allocate_msi_domains(struct mc_pcie
> > *port)
> >
> >  static void mc_handle_intx(struct irq_desc *desc)  {
> > -	struct mc_pcie *port =3D irq_desc_get_handler_data(desc);
> > +	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> >  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> >  	struct device *dev =3D port->dev;
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr; @@ -511,7 +515,=
7
> > @@ static void mc_handle_intx(struct irq_desc *desc)
> >
> >  static void mc_ack_intx_irq(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> >  	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
> >
> > @@ -520,7 +524,7 @@ static void mc_ack_intx_irq(struct irq_data *data)
> >
> >  static void mc_mask_intx_irq(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> >  	unsigned long flags;
> >  	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT); @@ -535,7
> > +539,7 @@ static void mc_mask_intx_irq(struct irq_data *data)
> >
> >  static void mc_unmask_intx_irq(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> >  	unsigned long flags;
> >  	u32 mask =3D BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT); @@ -625,21
> > +629,22 @@ static u32 local_events(struct mc_pcie *port)
> >  	return val;
> >  }
> >
> > -static u32 get_events(struct mc_pcie *port)
> > +static u32 get_events(struct plda_pcie_rp *port)
> >  {
> > +	struct mc_pcie *mc_port =3D container_of(port, struct mc_pcie, plda);
> >  	u32 events =3D 0;
> >
> > -	events |=3D pcie_events(port);
> > -	events |=3D sec_errors(port);
> > -	events |=3D ded_errors(port);
> > -	events |=3D local_events(port);
> > +	events |=3D pcie_events(mc_port);
> > +	events |=3D sec_errors(mc_port);
> > +	events |=3D ded_errors(mc_port);
> > +	events |=3D local_events(mc_port);
> >
> >  	return events;
> >  }
> >
> >  static irqreturn_t mc_event_handler(int irq, void *dev_id)  {
> > -	struct mc_pcie *port =3D dev_id;
> > +	struct plda_pcie_rp *port =3D dev_id;
> >  	struct device *dev =3D port->dev;
> >  	struct irq_data *data;
> >
> > @@ -655,7 +660,7 @@ static irqreturn_t mc_event_handler(int irq, void
> > *dev_id)
> >
> >  static void mc_handle_event(struct irq_desc *desc)  {
> > -	struct mc_pcie *port =3D irq_desc_get_handler_data(desc);
> > +	struct plda_pcie_rp *port =3D irq_desc_get_handler_data(desc);
> >  	unsigned long events;
> >  	u32 bit;
> >  	struct irq_chip *chip =3D irq_desc_get_chip(desc); @@ -672,12 +677,13
> > @@ static void mc_handle_event(struct irq_desc *desc)
> >
> >  static void mc_ack_event_irq(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +	struct mc_pcie *mc_port =3D container_of(port, struct mc_pcie, plda);
> >  	u32 event =3D data->hwirq;
> >  	void __iomem *addr;
> >  	u32 mask;
> >
> > -	addr =3D port->axi_base_addr + event_descs[event].base +
> > +	addr =3D mc_port->axi_base_addr + event_descs[event].base +
> >  		event_descs[event].offset;
> >  	mask =3D event_descs[event].mask;
> >  	mask |=3D event_descs[event].enb_mask; @@ -687,13 +693,14 @@ static
> > void mc_ack_event_irq(struct irq_data *data)
> >
> >  static void mc_mask_event_irq(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +	struct mc_pcie *mc_port =3D container_of(port, struct mc_pcie, plda);
> >  	u32 event =3D data->hwirq;
> >  	void __iomem *addr;
> >  	u32 mask;
> >  	u32 val;
> >
> > -	addr =3D port->axi_base_addr + event_descs[event].base +
> > +	addr =3D mc_port->axi_base_addr + event_descs[event].base +
> >  		event_descs[event].mask_offset;
> >  	mask =3D event_descs[event].mask;
> >  	if (event_descs[event].enb_mask) {
> > @@ -717,13 +724,14 @@ static void mc_mask_event_irq(struct irq_data
> > *data)
> >
> >  static void mc_unmask_event_irq(struct irq_data *data)  {
> > -	struct mc_pcie *port =3D irq_data_get_irq_chip_data(data);
> > +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> > +	struct mc_pcie *mc_port =3D container_of(port, struct mc_pcie, plda);
> >  	u32 event =3D data->hwirq;
> >  	void __iomem *addr;
> >  	u32 mask;
> >  	u32 val;
> >
> > -	addr =3D port->axi_base_addr + event_descs[event].base +
> > +	addr =3D mc_port->axi_base_addr + event_descs[event].base +
> >  		event_descs[event].mask_offset;
> >  	mask =3D event_descs[event].mask;
> >
> > @@ -811,7 +819,7 @@ static int mc_pcie_init_clks(struct device *dev)
> >  	return 0;
> >  }
> >
> > -static int mc_pcie_init_irq_domains(struct mc_pcie *port)
> > +static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
> >  {
> >  	struct device *dev =3D port->dev;
> >  	struct device_node *node =3D dev->of_node; @@ -889,7 +897,7 @@ static
> > void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
> > }
> >
> >  static int mc_pcie_setup_windows(struct platform_device *pdev,
> > -				 struct mc_pcie *port)
> > +				 struct plda_pcie_rp *port)
> >  {
> >  	void __iomem *bridge_base_addr =3D port->bridge_addr;
> >  	struct pci_host_bridge *bridge =3D platform_get_drvdata(pdev); @@
> > -970,7 +978,7 @@ static void mc_disable_interrupts(struct mc_pcie *port=
)
> >  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);  }
> >
> > -static int mc_init_interrupts(struct platform_device *pdev, struct
> > mc_pcie *port)
> > +static int mc_init_interrupts(struct platform_device *pdev, struct
> > +plda_pcie_rp *port)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> >  	int irq;
> > @@ -1043,12 +1051,12 @@ static int mc_platform_init(struct
> pci_config_window *cfg)
> >  	mc_pcie_enable_msi(port, cfg->win);
> >
> >  	/* Configure non-config space outbound ranges */
> > -	ret =3D mc_pcie_setup_windows(pdev, port);
> > +	ret =3D mc_pcie_setup_windows(pdev, &port->plda);
> >  	if (ret)
> >  		return ret;
> >
> >  	/* Address translation is up; safe to enable interrupts */
> > -	ret =3D mc_init_interrupts(pdev, port);
> > +	ret =3D mc_init_interrupts(pdev, &port->plda);
> >  	if (ret)
> >  		return ret;
> >
> > @@ -1059,6 +1067,7 @@ static int mc_host_probe(struct platform_device
> > *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> >  	void __iomem *bridge_base_addr;
> > +	struct plda_pcie_rp *plda;
> >  	int ret;
> >  	u32 val;
> >
> > @@ -1066,7 +1075,8 @@ static int mc_host_probe(struct platform_device
> *pdev)
> >  	if (!port)
> >  		return -ENOMEM;
> >
> > -	port->dev =3D dev;
> > +	plda =3D &port->plda;
> > +	plda->dev =3D dev;
> >
> >  	port->axi_base_addr =3D devm_platform_ioremap_resource(pdev, 1);
> >  	if (IS_ERR(port->axi_base_addr))
> > @@ -1075,7 +1085,7 @@ static int mc_host_probe(struct platform_device
> *pdev)
> >  	mc_disable_interrupts(port);
> >
> >  	bridge_base_addr =3D port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> > -	port->bridge_addr =3D bridge_base_addr;
> > +	plda->bridge_addr =3D bridge_base_addr;
> >
> >  	/* Allow enabling MSI by disabling MSI-X */
> >  	val =3D readl(bridge_base_addr + PCIE_PCI_IRQ_DW0); @@ -1087,10
> > +1097,10 @@ static int mc_host_probe(struct platform_device *pdev)
> >  	val &=3D NUM_MSI_MSGS_MASK;
> >  	val >>=3D NUM_MSI_MSGS_SHIFT;
> >
> > -	port->msi.num_vectors =3D 1 << val;
> > +	plda->msi.num_vectors =3D 1 << val;
> >
> >  	/* Pick vector address from design */
> > -	port->msi.vector_phy =3D readl_relaxed(bridge_base_addr + IMSI_ADDR);
> > +	plda->msi.vector_phy =3D readl_relaxed(bridge_base_addr + IMSI_ADDR);
> >
> >  	ret =3D mc_pcie_init_clks(dev);
> >  	if (ret) {
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

