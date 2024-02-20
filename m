Return-Path: <linux-pci+bounces-3753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040985B9CF
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F1B25CFC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29498664AB;
	Tue, 20 Feb 2024 11:00:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36616604A9;
	Tue, 20 Feb 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426829; cv=fail; b=TUIjDtptd4iT99oX0UemH4KUecTMoDN3uEuM4QUvibDuY6uJXIHMOxGk/2CyLj9b6Djt6zwaMVkBVNkZZ7gDhvT+8W3XwqAYsISGnEa9uzVu0x/IDP5yTFj8iDECiAIoUDHNaa3gOvfg9KqIlmo0KEmVW1Q/uZINnUgaaAM8muw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426829; c=relaxed/simple;
	bh=7x6twa1IH+tYVH9rw4QvYwkHw3lu8RJWXW+wzzrYBxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quhGwNBNSq5tcz5c5goDh1farR8O7QD4AOtuI5/MBBYg4Iajla8wlBcAATJ9HUSn6Wl6eKaEC5HvC80w3TXB8c9lSQgAipq1/wDdKfBt+gtU/jTNUNLIZDZSnYxyfYwwiREmyZgeifaNWVoBJmDJSF8b6rUfTBXqWblKYf+EVRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASaVZ1LyOHy4h8aA6EK3KY646tEIf7FS/PzgA1HKAlQ5GJnraaMVj3+EcB997v08tiwKGhBhASguPeEENATwBbagOawmPsf/Opy1DCxIr9zZUNkHHJ4C7H5mNVUESl5FcJd1DK/khG/M7iWmPPNq2XM3LVMGdGBqjXMcShbG/rs5ciqpzS2WP2gQl9qMAUdKaLU4ozl7W6QmN+oAZEtkwaMNr/qbcdrqz7wipL3CmL0q0pC7w8oc50fyIogzbyAO3GlMUaA+9fTQBNO4OyvpbM9G1KntWZFFNiDOiL6jUYAgUZ6eCDMjpTQIugUn41mnN4flpdUk5LxEq+MS0K0S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u+zLms5P02Il8Xvgpg3bAA/7ABQ34rJQEwEYQH9bVs=;
 b=WYf0hG3fhemihfCQKPm7gTjPYmBa6HoX8Hy3HhJRSOGRV/1SN2AMZ4v0hcxWgqbdCyfrDJlHmDPKcjjJAr85Fo81jiQVxkfYY30B2nSOnGfIwe3dERSH5mFU5+0drROQaM2wg0X2jHFWsVdgbnIJ0PXph52DyOFdae0gNv+dnkm2ZpWqGMGIk0gQtAJcQHT7K37NQzW46n/hWP40DXpJM4S9788K1KvJZV0s/ZsXVL0oedbPRAcETIjXK/jfN6Z7st5beAx4orEVz3JiLftrexHkJPK3Lbbw1pr4QMuH0gBYtKcFR5qpd+KgCCyamL2KGEqVYRAQboN4ITUI7X/L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0783.CHNPR01.prod.partner.outlook.cn (10.43.107.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Tue, 20 Feb 2024 11:00:13 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Tue, 20 Feb 2024 11:00:13 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas
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
Subject: Re: [PATCH v15 15/23] PCI: microchip: Add event irqchip field to host
 port and add PLDA irqchip
Thread-Topic: [PATCH v15 15/23] PCI: microchip: Add event irqchip field to
 host port and add PLDA irqchip
Thread-Index: AQHaYlPYD6wUc0NM7EGAypJO2so9u7ETE0sg
Date: Tue, 20 Feb 2024 11:00:12 +0000
Message-ID:
 <SHXPR01MB0863FCE82CA2155E52A3EB6FE650A@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240218101831.113469-1-minda.chen@starfivetech.com>
 <20240218101831.113469-2-minda.chen@starfivetech.com>
In-Reply-To: <20240218101831.113469-2-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0783:EE_
x-ms-office365-filtering-correlation-id: d8bc096b-5f1a-4ecd-4bb2-08dc32031cd9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x6Qh1ne/zLagT3fIXs4sEzRldkOaDKAPrf7GM3S/vu9CiaI9gxWqSp0OZz+J7lzHjXMr6aQAb6ZB031NGKXpxzMiFOfn2fqsjuwl+TuRP5xswYQcJNPR4u+cPVIFhchIsncusMqK8viIB3rDJhZvkCVTZjJxvshxjLxq6L2ca+WRT7KG/o6xNF2Kui27l17lQaCnGaFucUhhfMHTm+o6v2Apt1qDdKk2QMu/+Fz/f6203xAo589FXyc7gZBHjtkD8EUSdXwmI7fgkwvKZn+5eikvVR79aF1b10fA65KPXChVapD69Lky1rbwYTTaS7uPeEzhx/ZTEX9yN+spHp/7BmpWA+xhoKrhVgf8zkRZFTh2IEP8Zh57lmGiBHXrbBNaGWuaDhXxth4dBMUMVif0hr2W4JzfYHsnt85FqZIqXSMbyPe2AHQsx6byN8v0c/gWXQ91tLAAfvveZuQCih9SFhDFb5QBCX+12go4gigPKW6385N7D6qjCyHa5y6CXz39NbYdCGf5IHMMcYF9LR+QUwY95U/1WT4w+L2HOcJ0Zl677gm/GgNMfyzE+k6rShQg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?prn2hXtv+g9Xl/xzEVHAsb3w+XpeqRSklrpFg7+oklSUEjvOxf9tqglmp+?=
 =?iso-8859-2?Q?+UjcWaIgJvFdmi3pAkV1mIQ/fALo+zAEZIMa2efbTZ5z8rjZR/TA3MgglA?=
 =?iso-8859-2?Q?xFQE+Mt6S302oWwmrp/1QjNANS+UmvXFgs4PqJH7E6r80VejrimBTiCIto?=
 =?iso-8859-2?Q?6Hd8VEL9Pxv1/TVKrER3CUpaNTruEbhIH98/vx8zPhfLe7AA+1YgBuR+j7?=
 =?iso-8859-2?Q?oFx+nx41ncjPeajlg6ofDZTRuZmGt5PcQB7Gb922fjbZYSHn0iOkCNgVCW?=
 =?iso-8859-2?Q?OwBVBUO+1gHZaHrN3jcf0E6qiwf0skXFpwSZ1Xm5uegwQ/dMjszwA3l7sP?=
 =?iso-8859-2?Q?6BhiNKBzgsLaUAXOSzxZWjMnfokR7S8uEk2+cnsk6gq+nWdoMQfcB+bKTL?=
 =?iso-8859-2?Q?mI+oQGqFwx9TWeN/u4EddJnONXkW66VXb1Ad8r6JDmwAr40G6pxXab6fg6?=
 =?iso-8859-2?Q?WbB1hY5KTZGnVcFWt41+RkVwG1jYqAVoUrr+2aCy3P+T1r/ZZz+701WZ0d?=
 =?iso-8859-2?Q?ADSNZX5+xAtoxP7b6cmqKqyh8ymzcq4MQY8O/8bJ8qHNzIkEvB/8VcwusD?=
 =?iso-8859-2?Q?AuEKeUtdrMp7lOw8xJ05KQrfmoaT1mRRQ3PKnBUmG2CxvBpLpTCSKoUo1p?=
 =?iso-8859-2?Q?7VAtUUuAFESf5ZmdxXVfs31HsdvNotAxWeMONFeUjYz31N/VaQwVQT8nWb?=
 =?iso-8859-2?Q?7E1YZZbn3lpG8VQaWKvm2eXjAEFlbAaaaBXE7mbUmKYZSrLy3BApfTjmkw?=
 =?iso-8859-2?Q?72b1sUE25ZWk3er3dE1/twYrVMcPEJ2NTbcf8VAk7Y+p0AtePt1ipbYmWB?=
 =?iso-8859-2?Q?UAikWI1PQMboCXv+o84QMrZb83dhvRX3TAjpWiq5R/3KNpuh3u+5UaySqn?=
 =?iso-8859-2?Q?gnoMMI/e6M5FTcKu4LFEa7ruP6PCkQvC4k+iL84aKeYsaKOPuKfRcREkN2?=
 =?iso-8859-2?Q?R0z880GdW4BRhF0rvpdfBBQpey9hyXGfiXnyIkJNDMt5YKjYr9cHIxS6Wd?=
 =?iso-8859-2?Q?gVFYZ6BaNYRLPRorjC85F54MsR/qkSRDZNRt3VJE3umViHQZiwAHSOhxB7?=
 =?iso-8859-2?Q?qU8YGMbrCrNae6Rlo4qo3ETqLY9VNmFHyBnEplWAGjMtpbfhyq+gmwG/s6?=
 =?iso-8859-2?Q?k4fqANeWMr3KzoT7jYRTGeIdolt77FGCAN2UE7Aj7DRgfXnsFlWRfARGst?=
 =?iso-8859-2?Q?IJgKzpd6/0Rb+Y7wZzrQKUnLkMi6iFU7UMoO4R76a2MvDHVQT7EMzY/xJ/?=
 =?iso-8859-2?Q?XSXA4BVjQ3vUTV08kQTtXU4fSy461IUgoghNdhTEDNCbBKfU8sTeZu6GY6?=
 =?iso-8859-2?Q?VylphJ65yjWE/Wu88zfRgBiQRjA7VTImwAZATbjjsxDdfUKUqTy+nHmVP8?=
 =?iso-8859-2?Q?8mQfwsDcEqkIuGIWW3+JuX3JLSJBqpFVj2h13MgvhCKygKRWQYdgjlFKHS?=
 =?iso-8859-2?Q?eOejIGPZRdiFPOFukUBL2dOfwzrp1ktlk2WYONCyFke4o0Zmdilii+gR4C?=
 =?iso-8859-2?Q?x178YSZL+baXDLOItr97PBeck2uOu/oWGVd2iqTecc2fQ7ieMh3eQCgKah?=
 =?iso-8859-2?Q?jnhxgGY05mOcvJmGrglDXfnEtljM4PHa+el2lMJMgOHnVmkLRSB1Mv3JmP?=
 =?iso-8859-2?Q?9+yB57lDnH7aVUk7YQiCPTtV1CxiJox/4m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bc096b-5f1a-4ecd-4bb2-08dc32031cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 11:00:12.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF36AW0k+7d6C/HWaHG1FTe5gZ3xs7CJrcyZAnm3lVfD4GT676aBNLtd/LLk4qYraGg6XSb63NlnJoD+KyQgf7O6X8AyHF7A4Tmp/p2LoAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0783


>=20
> As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
> plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
> controller.
>=20
> Microchip PolarFire PCIE event IRQs includes PLDA interrupts and Polarfir=
e their
> own interrupts. The interrupt irqchip ops includes ack/mask/unmask interr=
upt
> ops, which will write correct registers.
> Microchip Polarfire PCIe additional interrupts require to write Polarfire=
 SoC
> self-defined registers. So Microchip PCIe event irqchip ops can not be re=
-used.
>=20
> To support PLDA its own event IRQ process, implements PLDA irqchip ops an=
d
> add event irqchip field to struct pcie_plda_rp.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 66 ++++++++++++++++++-
>  drivers/pci/controller/plda/pcie-plda.h       |  3 +
>  2 files changed, 68 insertions(+), 1 deletion(-)
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
Hi Thomas
  I think this patch code it is easy to review. If you busy, Could you let =
other
IRQ maintainer review? Thanks.

Hi Lorenzo, Bjorn and Krzysztof
  Now the code is pending several weeks. Maybe this patch is blocking.
Actually I write irqchip ops(ack/mask/unmask) like microchip irqchip ops.=20
They looks very simple that write PLDA mask or status register. They all ca=
ll the=20
same function plda_hwirq_to_mask(). Now you can see this function below.=20
Except INTx interrupt, one irqnum mapping to one register bit. The PLDA reg=
ister
graph can be seen 14th patch, which can show all the PLDA interrupts and ea=
sy to
 get PLDA codes logic.

  Now the 6.9-next will be closed less than 20 days. I still hope the refac=
toring patches
(patch 1 - 16) can be accepted to 6.9. (Starfive and PLDA patches have to b=
e delayed=20
to 6.10 or later). I will try my best to achieve it because this series pat=
ches reviewed lasts=20
a long period and Conor have reviewed all the refactoring patches.

I have no experience in refactoring code before this series patches. I try =
my best to do this.
Maybe I did something wrong in this. Please forgive me.

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
> index e0e5e7cc8434..a3ce01735bea 100644
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
> @@ -155,6 +157,7 @@ struct plda_pcie_rp {
>  	raw_spinlock_t lock;
>  	struct plda_msi msi;
>  	const struct plda_event_ops *event_ops;
> +	const struct irq_chip *event_irq_chip;
>  	void __iomem *bridge_addr;
>  	int num_events;
>  };
> --
> 2.17.1


