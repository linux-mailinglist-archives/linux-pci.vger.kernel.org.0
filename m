Return-Path: <linux-pci+bounces-6818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704418B670B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 02:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943E51C22CEE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B62610F7;
	Tue, 30 Apr 2024 00:50:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C920EB;
	Tue, 30 Apr 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438224; cv=fail; b=Hjen28MBq9XADDACkpvbjZTKQu5j2Lh4oXVhK+W4rcRszj9qR5p+XSMtk199RK0HooWjJ1qCGcJmDUMG/ZFThZT8KazIXn/Kb8zFiYrBuxuLY1zRug5eNR88Z0neA4qKG+3KPK8yS/Xq67UFNS1Utb4UOMaJNUY3i8fC7DqcihY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438224; c=relaxed/simple;
	bh=+zJ5guYFlvEynRENXInKQxX+dIM9Uo32M90pOYNeGus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lftt7DWqWKvy2gLjfkT2neIFd/qZiAPKRjBOP4wnz6WENwuzsQBmnvdkl9gdsKdIWZRJ/mt8pJaIUVyY8P4LRCvdriv7zBT5/TT7dwJ84DsSM0VpPyMccn+Ib0nFu6X/+m40CIqKEJjNLEy7ZMPUQrS0NwJnegU0HkLK2AT0lTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+uKWj+42xfQWPB3a7pqI+EB3tA/FmdHQ00ywkchVKxl+na3Dhc+s7WfrzTV/GFke6rkjYv9MXqnjUpIxr/8HgmVM9xKwVmlLisUoXo5vxGG6tOsG1APM6rroartD9w6tz/bhBiAZnF/YJolm/Lnx4AAH3/kpGpnnTsanjS+mQL6m5mg+WwkMtZRZehn3XPRjuYWA7a89r8og7G/z415NN5Myw/bwyBC4mj57/tQBhXf0PmkBYmEYWNqFS2MTzHlCloK7Jyu/eA2cDOldl2noEWQyVvuFYYlR/5xwUfonMps9YkAcm8xKn9RDKB68wD95DPm08/iHwIKhyV4xpEjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeTILt1v8L0hlm0IowNWIINS/QOqgp6YbCFQjj2thnM=;
 b=RX+3WWze22LTNZeYGhliPovsUOy1lNiNB4eAYqBvY7CWQJOmrPRjDdRREQ2eP40mkjRYsIr4kEIRU3p3Oi69b14l3u4g691ZewaulXrZMRN4mtVPy8gQ9qlPMBuPBJYrZpfvA0yeyhP7rs4JoxhV8mcbtlAhdIP4/XICWnzqytKGuQcLoVvMzmqz2BN7Lv/fFJkeyVlkj8XvFvsThaxp8KVxgn6h3dxFgpiak1f66oHlrH+D6jInEjYLZrPZHYoGFwhFHEcly/URHoXvO9B8S8TzHuxz4gkRj1iPThR18RkRGtYUWKQPyww465cVf4uswIBm6kQeKkQkUjI97v6YPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0551.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 30 Apr
 2024 00:50:10 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Tue, 30 Apr 2024 00:50:10 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Conor Dooley
	<conor@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v16 15/22] PCI: microchip: Add event irqchip field to host
 port and add PLDA irqchip
Thread-Topic: [PATCH v16 15/22] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Thread-Index: AQHagPD3nzNr5zgHs0qxspgsCqWuULGALtGg
Date: Tue, 30 Apr 2024 00:50:10 +0000
Message-ID:
 <BJXPR01MB0855B876D2B73F33E8A39460E61AA@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
 <20240328091835.14797-16-minda.chen@starfivetech.com>
In-Reply-To: <20240328091835.14797-16-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0551:EE_
x-ms-office365-filtering-correlation-id: 39c4636d-a2ee-4fb6-87b1-08dc68af7cc1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IC7L7ENSk60VN2JMKLAI2JRW2H3MCzA6UmTmIgW06HgGTRXVOLLKAOe0bySSRkAKv5RyOgGMYE3nGCQlpuZmIsvxe3eLlt4Q22CpYq20imm5j7+UqlgI2dI1nEET0q/Xc6s5znjBV3XyJEb0Xq7qE7/CldGDt6pwk4cpjAif8dET1JeQ3LtrMFlsYkMe96jKS2mH0qJXu4cG7cy5sdqvoeyzBCjuuNw56zB5vu7Jx2CLPgpWpIfZHxGUbcy1czztRvWKJrSNH+/NFOoZ7LSDR2Ux/qUf7ShVU4TvBKbt2ii7HT5i0LMTozQQEdEBLbJn8YGkdw9Z55ZIHnrUxQ4ey9/qBhZ+Mu7dIdGdN7UUzI2oObAOQpATgo4sqPkmy0PoQq6j74PhBUMPvQSuznbJbdshdo6GhEjE+WQ+PC+JXsBPc2Cf3LQNrE9/veFbf41i4gOXpmyupqGV0xp+c6kdoGJ0D543LCo5RRcBbvRQmUUxatfg81yhjlcW70WBq2xcxLraH/agf95OBE2J25IBnpm07/Fn3F0A2Ku0/EzcIhlMTZ33+5M37EPIOkoncXuHXbSOEZwxzAT6l96cyI9SiaWIDRXAsNjRXITBMifLF5sJg4pwLtW/a6PA8e4TWM7X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mtNFwSY906Vas59N6vWZa3tUgw9CknMkR2ojmcM6IoT433ibu67XGfjVSe?=
 =?iso-8859-2?Q?ieJXCTl2gKBzvdG3R1aJadqCUwswxZ+iK4R8hpgofTxcnIT+0j+4XkI4W+?=
 =?iso-8859-2?Q?jSEWRgMEwCfhjBVXqbzakaCqPxKBQ6ZYGkbwZAfaK+PyoN0xSFHQjyCFt+?=
 =?iso-8859-2?Q?StbVrpbiRfoeV4sjncuU1hRJBWot4SFfm+pDOMY9MTWnZQQNeYV8aD9bOa?=
 =?iso-8859-2?Q?IRK9Z0W+j7vRRZtXqH2Gs/5lDcsxV2qiZzSKLdZItk0N81fOuMmuvIuP0K?=
 =?iso-8859-2?Q?69aB3eYSQ2x/9yVxEbJaQtLCSfI2GAfRLiuIHhRtLVSYIYj9QYpHZik8hu?=
 =?iso-8859-2?Q?SRaZfufCR75mfJ6Ovc5/LentoTz3PPhthmLcM0L3gTZH0zBbU8kqJcMHrQ?=
 =?iso-8859-2?Q?Y46X/Y8xWSBf93Pf/7+BV8BY3rgf6S/hTc3aqGV1qQMUuebM2mY0anZPor?=
 =?iso-8859-2?Q?a/EWclZSraWbH3Lm00Q9yCeKkFf6jNxxvffwFY2YhuKucQUukCG8UB2Lzj?=
 =?iso-8859-2?Q?sdSug3dj26fd8vVjxGLz85BuyAsvACLGtH14DsDVPN+Tk/p0P9wPuh3Rc9?=
 =?iso-8859-2?Q?lvBJTfdx4UkJXkG5Jn6ZsJyaLJbWiQPxGAGC6E2STsQn3J88OlNbND6hqs?=
 =?iso-8859-2?Q?h/Z0tv8hC1Tn8sUYgEVT2NJ5ocARF1YETepk8JiRprA8thp58LOw3MMIhL?=
 =?iso-8859-2?Q?+d1fxRlv88IC/oOnHZ57UEKFTJ1DFyIrlsmsaR0lFYBWqZr++wysCrbvXt?=
 =?iso-8859-2?Q?D1o9icE7vWFeyKj02ottxPhqESIyu1kSzaoqTM47B3OfTuPA0aFV7iBmvE?=
 =?iso-8859-2?Q?spZHIq5Z1Z/pRKUlK5VK2lJllHXm1ZIAyEaCkrJ3/F4S2nXc9LkUptrAEP?=
 =?iso-8859-2?Q?ym5jRhQZpqdytBHzT+/UkucD6bDNCJXpihExGaNziNWOMDiasFkGnv3xon?=
 =?iso-8859-2?Q?ZP7wcuT4WHB84e5YhRsN4Mm+z6wMtg/u/lstxiX/4c89z52niVvp1Avmvg?=
 =?iso-8859-2?Q?2zpdAXb2MBJ8L5+h3/CIbA33sTlqYDhNlimQZjMXIIQlu8GSwAtf5RYOQx?=
 =?iso-8859-2?Q?V1znLs6uTgVW7TIeTRyifKuVypMSgaRPnY1nIC5Fy1j7gZCfF4vn+/pUFZ?=
 =?iso-8859-2?Q?se0DIhBCT3w4sjQ5h8+8DGlQ5MBw2e8FRHPCvxcpQ9kjzbOiXAezdZcNKn?=
 =?iso-8859-2?Q?+YGbBEsLZcq8rOM8frfSJ2H32vDoNSqgV7W0KZILUirWYp8u1Qz4IJFQ+I?=
 =?iso-8859-2?Q?7HGCVNI7WlWphwfW6irqTbPrPsazROrPeqZYM8AHx/CaNgsgBR1rjYZv+X?=
 =?iso-8859-2?Q?dcYXedpsZM0fhL6BPHhELnAS1miX2RKuDund8s35tR80PFIAm4oqhy20l1?=
 =?iso-8859-2?Q?rwqAKuR51lwsabRjNcAABawyuR6kramQXUvM/Z2iwKUyk3cq7jGy2+GJx8?=
 =?iso-8859-2?Q?s5uLpp7dpZOZjRXH/Ks6aOkOARVnLlFLZsG2lyZWLVBI3DfgkCmxsTALay?=
 =?iso-8859-2?Q?f2ih8bW/gysxi0OZitTLU4gnTFJC4AGa2FkIoOfJMcoI4nZQ4QTF2hzOJc?=
 =?iso-8859-2?Q?HTx6uOkru5mhWvCPLDcRvqBJ+7sM6pKb17fyM8swXDQ4+bKqIv1juXg8+1?=
 =?iso-8859-2?Q?0IcCUFj1HyhEJB+7SE50ZG2EL8lQ5x8H/R?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c4636d-a2ee-4fb6-87b1-08dc68af7cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 00:50:10.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDYJVKpGqY2Hb9j9TIjCHg6+ikojGMU+3OL/EMpKFioOFNNbWVbqr+avcGCi6J/7wYkixZeV4/cioz7k2gqbJ068AvsUjM43eefwemLEyAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0551


>=20
> As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
> plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
> controller.
>=20
> Microchip PolarFire PCIE event IRQs includes PLDA interrupts and Polarfir=
e
> additional interrupts. The interrupt irqchip ops includes ack/mask/unmask
> interrupt ops, which will write correct registers.
> Microchip Polarfire PCIe additional interrupts require to write Polarfire=
 SoC
> self-defined registers. So Microchip PCIe event irqchip ops can not be re=
-used.
>=20
> Microchip Polarfire PCIe additional intrerrupts:
> (defined in drivers/pci/controller/plda/pcie-microchip-host.c)
> EVENT_PCIE_L2_EXIT
> EVENT_PCIE_HOTRST_EXIT
> EVENT_PCIE_DLUP_EXIT
> EVENT_SEC_TX_RAM_SEC_ERR
> EVENT_SEC_RX_RAM_SEC_ERR
> ....
>=20
> To support PLDA its own event IRQ process, implements PLDA irqchip ops an=
d
> add event irqchip field to struct pcie_plda_rp.
>=20
Hi Thomas
  Could you review this patch? Thanks.=20

> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 66 ++++++++++++++++++-
>  drivers/pci/controller/plda/pcie-plda.h       | 34 +++++-----
>  2 files changed, 84 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> b/drivers/pci/controller/plda/pcie-microchip-host.c
> index b3df373a2141..beaf5c27da84 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -770,6 +770,64 @@ static struct irq_chip mc_event_irq_chip =3D {
>  	.irq_unmask =3D mc_unmask_event_irq,
>  };
>=20
> +static u32 plda_hwirq_to_mask(int hwirq) {
> +	u32 mask;
> +
> +	/* hwirq 23 - 0 are the same with register */
> +	if (hwirq < EVENT_PM_MSI_INT_INTX)
> +		mask =3D BIT(hwirq);
> +	else if (hwirq =3D=3D EVENT_PM_MSI_INT_INTX)
> +		mask =3D PM_MSI_INT_INTX_MASK;
> +	else
> +		mask =3D BIT(hwirq + PCI_NUM_INTX - 1);
> +
> +	return mask;
> +}
> +
> +static void plda_ack_event_irq(struct irq_data *data) {
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +
> +	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
> +		       port->bridge_addr + ISTATUS_LOCAL); }
> +
> +static void plda_mask_event_irq(struct irq_data *data) {
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	u32 mask, val;
> +
> +	mask =3D plda_hwirq_to_mask(data->hwirq);
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
> +	val &=3D ~mask;
> +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void plda_unmask_event_irq(struct irq_data *data) {
> +	struct plda_pcie_rp *port =3D irq_data_get_irq_chip_data(data);
> +	u32 mask, val;
> +
> +	mask =3D plda_hwirq_to_mask(data->hwirq);
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
> +	val |=3D mask;
> +	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip plda_event_irq_chip =3D {
> +	.name =3D "PLDA PCIe EVENT",
> +	.irq_ack =3D plda_ack_event_irq,
> +	.irq_mask =3D plda_mask_event_irq,
> +	.irq_unmask =3D plda_unmask_event_irq,
> +};
> +
>  static const struct plda_event_ops plda_event_ops =3D {
>  	.get_events =3D plda_get_events,
>  };
> @@ -777,7 +835,9 @@ static const struct plda_event_ops plda_event_ops =3D
> {  static int plda_pcie_event_map(struct irq_domain *domain, unsigned int=
 irq,
>  			       irq_hw_number_t hwirq)
>  {
> -	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
> +	struct plda_pcie_rp *port =3D (void *)domain->host_data;
> +
> +	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_irq);
>  	irq_set_chip_data(irq, domain->host_data);
>=20
>  	return 0;
> @@ -962,6 +1022,9 @@ static int plda_init_interrupts(struct platform_devi=
ce
> *pdev,
>  	if (!port->event_ops)
>  		port->event_ops =3D &plda_event_ops;
>=20
> +	if (!port->event_irq_chip)
> +		port->event_irq_chip =3D &plda_event_irq_chip;
> +
>  	ret =3D plda_pcie_init_irq_domains(port);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n"); @@ -1039,6 +1102,7
> @@ static int mc_platform_init(struct pci_config_window *cfg)
>  		return ret;
>=20
>  	port->plda.event_ops =3D &mc_event_ops;
> +	port->plda.event_irq_chip =3D &mc_event_irq_chip;
>=20
>  	/* Address translation is up; safe to enable interrupts */
>  	ret =3D plda_init_interrupts(pdev, &port->plda, &mc_event); diff --git
> a/drivers/pci/controller/plda/pcie-plda.h
> b/drivers/pci/controller/plda/pcie-plda.h
> index e0e5e7cc8434..0e5157eb3a32 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -107,6 +107,8 @@ enum plda_int_event {
>=20
>  #define PLDA_NUM_DMA_EVENTS			16
>=20
> +#define EVENT_PM_MSI_INT_INTX			(PLDA_NUM_DMA_EVENTS +
> PLDA_INTX)
> +#define EVENT_PM_MSI_INT_MSI			(PLDA_NUM_DMA_EVENTS +
> PLDA_MSI)
>  #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS +
> PLDA_INT_EVENT_NUM)
>=20
>  /*
> @@ -116,21 +118,22 @@ enum plda_int_event {
>   * +--+--+--+-+------+-+-+-+-+-+-+-+-+-----------+-----------+
>   * |12|11|10|9| intx |7|6|5|4|3|2|1|0| DMA error | DMA end   |
>   * +--+--+--+-+------+-+-+-+-+-+-+-+-+-----------+-----------+
> - * bit 0-7  DMA interrupt end : reserved for vendor implement
> - * bit 8-15 DMA error : reserved for vendor implement
> - * 0:  AXI post error (PLDA_AXI_POST_ERR)
> - * 1:  AXI fetch error (PLDA_AXI_FETCH_ERR)
> - * 2:  AXI discard error (PLDA_AXI_DISCARD_ERR)
> - * 3:  AXI doorbell (PLDA_PCIE_DOORBELL)
> - * 4:  PCIe post error (PLDA_PCIE_POST_ERR)
> - * 5:  PCIe fetch error (PLDA_PCIE_FETCH_ERR)
> - * 6:  PCIe discard error (PLDA_PCIE_DISCARD_ERR)
> - * 7:  PCIe doorbell (PLDA_PCIE_DOORBELL)
> - * 8:  4 INTx interruts (PLDA_INTX)
> - * 9:  MSI interrupt (PLDA_MSI)
> - * 10: AER event (PLDA_AER_EVENT)
> - * 11: PM/LTR/Hotplug (PLDA_MISC_EVENTS)
> - * 12: System error (PLDA_SYS_ERR)
> + * event  bit
> + * 0-7   (0-7)   DMA interrupt end : reserved for vendor implement
> + * 8-15  (8-15)  DMA error : reserved for vendor implement
> + * 16    (16)    AXI post error (PLDA_AXI_POST_ERR)
> + * 17    (17)    AXI fetch error (PLDA_AXI_FETCH_ERR)
> + * 18    (18)    AXI discard error (PLDA_AXI_DISCARD_ERR)
> + * 19    (19)    AXI doorbell (PLDA_PCIE_DOORBELL)
> + * 20    (20)    PCIe post error (PLDA_PCIE_POST_ERR)
> + * 21    (21)    PCIe fetch error (PLDA_PCIE_FETCH_ERR)
> + * 22    (22)    PCIe discard error (PLDA_PCIE_DISCARD_ERR)
> + * 23    (23)    PCIe doorbell (PLDA_PCIE_DOORBELL)
> + * 24    (27-24) INTx interruts (PLDA_INTX)
> + * 25    (28):   MSI interrupt (PLDA_MSI)
> + * 26    (29):   AER event (PLDA_AER_EVENT)
> + * 27    (30):   PM/LTR/Hotplug (PLDA_MISC_EVENTS)
> + * 28    (31):   System error (PLDA_SYS_ERR)
>   */
>=20
>  struct plda_pcie_rp;
> @@ -155,6 +158,7 @@ struct plda_pcie_rp {
>  	raw_spinlock_t lock;
>  	struct plda_msi msi;
>  	const struct plda_event_ops *event_ops;
> +	const struct irq_chip *event_irq_chip;
>  	void __iomem *bridge_addr;
>  	int num_events;
>  };
> --
> 2.17.1


