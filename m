Return-Path: <linux-pci+bounces-13078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC1976655
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 12:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC98E28429B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DCF19F11E;
	Thu, 12 Sep 2024 10:06:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2122.outbound.protection.partner.outlook.cn [139.219.146.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBF19CC19;
	Thu, 12 Sep 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135564; cv=fail; b=lNjBlclDugAkF1Gd+91F5jx6nZzb+xj9rPgXduBlaJFpHDheTGJgIB7UUYelZCjYfQ6mJRmgYQyydJvMUBkBTYu3M3kLfTv/eoDE+TrXiGfkGWDAQtnMGFDvgkoZ6uYWeBvCpo4ZpUqj8Lgy0fYYk7WDmo2XRxDceo9tqk+iNQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135564; c=relaxed/simple;
	bh=ccEwssl2aplxXqG4Z2U0+tQxwM2aVXpTLEQI2150VdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E7q9bWT4ntADJZzjV2juqYTyIN7zfQSNZ/SwDdqm62Xu5nS5+MG2CnMY7owFPLEG7Uws9e4Q/87434oGVr8Kd/ujE3rXeUFjcYxo9/jEeZiUobCf/lxhkXGT3NiN8v29Xo1WkDmNn6QgP5mlAFhRV/uTl0BqEZnpeJA2yBAn/vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgytjtinqdsULAV3RAqrx83Ik0c08vc2891hTeBvpoFEYH6YC3Zin0YqDiP6GuUqkf36se97O+hAOn4w3he0Nk0BWlrqpCST6y0n7k4hfWxg7MqZETiTx7jhBcFgw6sxg49RZLjvWYPQmFyR5CuyfgcVtzJX5JzuxbaOJvvuKgGlfLnZgB6qUFWomtzOTdbofP//EuFRM2zl+9WmuV9OgMUaBdhqub+SRrafiGCq/+OhQtS8OzBxzInj+Qk3WMQEwGPSlSpW3UvfzmnOoDrF3hds4IjtEEhocMyBqBlLK1Mxswi5snvNq0sax2L0fbEomBCDoOpeZC5KH8Lj7Jzr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRGOZamObQ6yvNp8DtEqEPZkM44OSr6zNvpoCqAFAJo=;
 b=achQoL8/pmWqIMpDNdKDwW3t2YJMz+Pf8ZYeXzGgqWgcBOWSDlhlw559JYQEs/qZwd1dJN/nE7tmKp0RzsDsjOQDb9VIA9pPzehN8Db1iCj/lPSeBd9slYYSQWZbOKZNM7Wq9iHdZwRvEkr/gbkgmXAyuPaNm8+rCIrn0x+6liAwBnHesPFqopHZrsA5+TTVlUp9MJX3AfsGN+bO2DkcfaCFi1zF9gm6/CsQOZ/jyrfJsbslyaTKVX7dnfmzUvZnjliKMRVO4Lg+UxFh1wl0UjGnHttGdr5hYSdYz2jeq/HRXzIS4XXq51z0YvhtlZ9fGLN5/YxaN/HN9XIe34pGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0798.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.33; Thu, 12 Sep
 2024 09:49:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.032; Thu, 12 Sep 2024 09:49:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: "daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v9 2/3] PCI: microchip: Fix inbound address translation
 tables
Thread-Topic: [PATCH v9 2/3] PCI: microchip: Fix inbound address translation
 tables
Thread-Index: AQHa9Vf2RPNmxyZqn0mZxLezldc8ybJUB3gg
Date: Thu, 12 Sep 2024 09:49:38 +0000
Message-ID:
 <SHXPR01MB08632D4FA056118612EA675AE6642@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240823122717.1159133-1-daire.mcnamara@microchip.com>
 <20240823122717.1159133-3-daire.mcnamara@microchip.com>
In-Reply-To: <20240823122717.1159133-3-daire.mcnamara@microchip.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0798:EE_
x-ms-office365-filtering-correlation-id: a1ceb3ab-eef6-4747-454e-08dcd310376a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 aVuHsUNADJRij9abRX75bmNsfC4dE7JacsM2NxPm6wJuMXO0oC+QUM4P33S1PG6Q/KQ0BC7/INMLVCbT6hC7TJJFbiVVGtKlFZiI7n85eVNxcYlcUcNdtWrQfGUai4Yr3j5boRtUOaxH4WJQgbHedJywNahXS70h7tL+umAvpOERbT6AngesaSDla5qHnX21hOPmKPDR7ngt9cjNQQu4IZjSCvFWo52vgbTmLQ9MEJdIqW9QgPfgl8BHV7B3YIABy9/UPLQukJghMF7eyWj8C8fD8wDDiPiqw2+vQVzh0k3kVLrXpjbRPkaFwMMsJ6z6xozl572SeKv/mGJogTs31c7RSpKNEuTckFF5MCDpPWyUv0oYH2oZJIch120YI3BPTS5+OjtNsnDLLxPg/3n1SK/QywWJUpIgKcQIb7mY5BtyehJbnwqfBDK1ptEYzHE9gDKxt5wTl/JU8aS2KDaUjeKeg8PRseGVFeCmEzmpoKH8pgrmaYkhK5RYXydoyNsqN970oDaxkxK2cez+igatRnisDlkEesrnjI6ChVfIsuPzPqWOj9gP79lzcn7uh16YZa82suqoWtaBlScqzSwMq+sEU5wCvFw/J68orRZRHAGth5NiZl2+SgN4alzblmR1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?palda4okWS0MTP0JyiA5KZxexG+cjCcJSaFLtBykjFkZ2OKD2egHcO+y6CRa?=
 =?us-ascii?Q?j5H63xKHcd7exKwUDEZkdWIPBp2pLGwZ9PBUxtEN/ui9P9AE8b1KVSzmah/D?=
 =?us-ascii?Q?FUUD4cDneHVX5prWav8c3i8FOUVuLEPX54eSoQB2Wd9GURDUnR7MxASLrEam?=
 =?us-ascii?Q?s2cLgtRgpFAH+WvMTlsS4+mvf7cHM44E0DGm6xWTI/6DEVnT0hyHnK7Oj1N4?=
 =?us-ascii?Q?WB9SOpeZ8aJrIh7BwSo/lXu1bXc1qi5JDRE5D1EVc54bjmvfiy8ruK09g9nG?=
 =?us-ascii?Q?U7xePcjf+aYvUIiVgsz4BZb4c3pk3nOY4C2KJTmcElU2EOkQnSoP0N5iZg1P?=
 =?us-ascii?Q?cGazT1WBQdC/S3rcx1Yr3UZjpCqhJP0qdeshlkDSeqdmaMs4mm4TYfTZlwhX?=
 =?us-ascii?Q?Wc722lUaLt2KcjS31m8yO7hoGKe4QojYQo3mhL/gLsa7Nyq7+pxEZeHUwyPU?=
 =?us-ascii?Q?Qn9NW5UrC3jAiBC9BS5GqOoVWclN9BsXHAgpnv8a1ievv/rFmMGSRooUYlRF?=
 =?us-ascii?Q?R32IVDENPCk1uB13leQS+oLrOG/HA6bc35K/4t9V8x/6YmhdZm8tQt8nDNiD?=
 =?us-ascii?Q?sE988blucUAGt+DTcQntWqc0NTl8gY/ZBtUu53BCgfjQ7GhVr7FcgrtVJ6zf?=
 =?us-ascii?Q?WGYVix6BFbOuw9oZMIXW6ZTiDUvGHzrZtawuh0MyPcFmpviPXUOqidyhukkX?=
 =?us-ascii?Q?9NQt2gd1zHcJBt0boKv4wBG23beN5nvPMORhsnL5dczQJJ5XnytvMHGQoBnC?=
 =?us-ascii?Q?flnWB3qOVukCAaaZB5p5JBKit1Xh11gOEf2OJVDJOtqpdXKq+QhbRIRAJMF9?=
 =?us-ascii?Q?20RC3Lq4cbVUjt+II+mIa0hAYRYB57/pzw+Lwwif58RZp7RaSDVQXWT3aWJ5?=
 =?us-ascii?Q?FSUFjEqyDfmqnlTABCRZdZ7zecmcLCf2YgfRSKu1FkZFGnOqviJutXL7g7CQ?=
 =?us-ascii?Q?Uh6lrv41WIbTrbVa6/7Rj2zwx23C9rsfkbv3f46UA9doT6L9p5ENQjWCuuiA?=
 =?us-ascii?Q?heqxklL+9ZwHT373OdQLq6lbO8TGT5p31tZ9Wiqr6SwI0JEZi6rtDxSMJEeH?=
 =?us-ascii?Q?7ya2h3QERhqaZTSMjx6CRKji03qTn9Kb52BpyeFcqXP9Sv8kBE+H96ToNddV?=
 =?us-ascii?Q?5x+vVfcURiPGh76/+BD2IZPr9z+ZUWvmJ6t4KNR7QZZBiGoHBQN2rZ32CU2h?=
 =?us-ascii?Q?yAVtdGRKOeHlW1l80+wGB/voinCJyaEeOD+Hvofcm6tXbOq6lcSS9/gPXn2x?=
 =?us-ascii?Q?9CklIzMOGU2DIo6T5rX+lvLSBuMhtpxVP4ndMwNlOalRvpdeg94C0y3zc8oJ?=
 =?us-ascii?Q?bsDXnBINvmYDnbDzD7tVbEYmN11/bYZU7t91mRBGfPzdf6ATnfxGaH7OSoVX?=
 =?us-ascii?Q?mZCGbsWc6hxMeQP6xpjG4ta77jElcrxDdwaGBr6aThEIOvtISK4M0tPwMJvq?=
 =?us-ascii?Q?91W21lEHOBbj9UlJIOEpr0MjIIGxlIVUuuwKvr6oMHSiqB3LQactOnhjJqXx?=
 =?us-ascii?Q?ZYBwTj7S802iR45C5l2OghwPsk/qffb9DOaCabVpf0RWobYKamViD/gLG12R?=
 =?us-ascii?Q?8JhOA4eKLFZ0DwUttQt9HnO5B3LnNbwak93LYkej?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ceb3ab-eef6-4747-454e-08dcd310376a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 09:49:38.2031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHGi77I2SR32U7RfehrLwIBbWAnh+iiols2suXu7m64OB5GfS39NYr9NYz4WuTScdIwEyYfWueH9kSZNcRGYqms7hPJqR+L3gnjfz5Q0UP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0798


>=20
> From: Daire McNamara <daire.mcnamara@microchip.com>
>=20
> On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
> general purpose Fabric Interface Controller (FIC) buses that encapsulates=
 an
> AXI-S bus. Depending on which FIC(s) the Root Port is connected through t=
o CPU
> space, and what address translation is done by that FIC, the Root Port dr=
iver's
> inbound address translation may vary.
>=20
> For all current supported designs and all future expected designs, inboun=
d
> address translation done by a FIC on PolarFire SoC varies depending on wh=
ether
> PolarFire SoC is operating in coherent DMA mode or noncoherent DMA mode.
>=20
> The setup of the outbound address translation tables in the Root Port dri=
ver only
> needs to handle these two cases.
>=20
> Setup the inbound address translation tables to one of two address transl=
ations,
> depending on whether the Root Port is being used with coherent DMA or
> noncoherent DMA.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe contro=
ller
> driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 93 +++++++++++++++++++
> drivers/pci/controller/plda/pcie-plda-host.c  | 17 +++-
>  drivers/pci/controller/plda/pcie-plda.h       |  6 +-
>  drivers/pci/controller/plda/pcie-starfive.c   |  3 +
>  4 files changed, 114 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c
> b/drivers/pci/controller/plda/pcie-microchip-host.c
> index fa4c85be21f0..e06251523560 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -7,21 +7,27 @@
>   * Author: Daire McNamara <daire.mcnamara@microchip.com>
>   */
>=20
> +#include <linux/align.h>
> +#include <linux/bits.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
> +#include <linux/wordpart.h>
>=20
>  #include "../../pci.h"
>  #include "pcie-plda.h"
>=20
>  #define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
> +#define MC_MAX_NUM_INBOUND_WINDOWS		8
> +#define MPFS_NC_BOUNCE_ADDR			0x80000000
>=20
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> @@ -614,6 +620,89 @@ static void mc_disable_interrupts(struct mc_pcie
> *port)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);  }
>=20
> +static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr,
> +				      u64 pcie_addr, u64 size)
> +{
> +	void __iomem *bridge_base_addr =3D port->axi_base_addr +
> +					 MC_PCIE_BRIDGE_ADDR;
> +	u32 table_offset =3D window_index * ATR_ENTRY_SIZE;
> +	void __iomem *table_addr =3D bridge_base_addr + table_offset;
> +	u32 atr_sz;
> +	u32 val;
> +
> +	atr_sz =3D ilog2(size) - 1;
> +
> +	val =3D ALIGN_DOWN(lower_32_bits(pcie_addr), SZ_4K);
> +	val |=3D FIELD_PREP(ATR_SIZE_MASK, atr_sz);
> +	val |=3D ATR_IMPL_ENABLE;
> +
> +	writel(val, table_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +
> +	writel(upper_32_bits(pcie_addr), table_addr +
> +ATR0_PCIE_WIN0_SRC_ADDR);
> +
> +	writel(lower_32_bits(axi_addr), table_addr +
> ATR0_PCIE_WIN0_TRSL_ADDR_LSB);
> +	writel(upper_32_bits(axi_addr), table_addr +
> +ATR0_PCIE_WIN0_TRSL_ADDR_UDW);
> +
> +	writel(TRSL_ID_AXI4_MASTER_0, table_addr +
> ATR0_PCIE_WIN0_TRSL_PARAM);
> +}
> +
> +static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev,
> +					struct mc_pcie *port)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *dn =3D dev->of_node;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	int atr_index =3D 0;
> +
> +	/*
> +	 * MPFS PCIe Root Port is 32-bit only, behind a Fabric Interface
> +	 * Controller FPGA logic block which contains the AXI-S interface.
> +	 *
> +	 * From the point of view of the PCIe Root Port, there are only
> +	 * two supported Root Port configurations:
> +	 *
> +	 * Configuration 1: for use with fully coherent designs; supports a
> +	 * window from 0x0 (CPU space) to specified PCIe space.
> +	 *
> +	 * Configuration 2: for use with non-coherent designs; supports two
> +	 * 1 GB wide windows to CPU space; one mapping CPU space 0 to PCIe
> +	 * space 0x80000000 and mapping CPU space 0x40000000 to pcie
> +	 * space 0xc0000000. This cfg needs two windows because of how
> +	 * the MSI space is allocated in the AXI-S range on MPFS.
> +	 *
> +	 * The FIC interface outside the PCIe block *must* complete the inbound
> +	 * address translation as per MCHP MPFS FPGA design guidelines.
> +	 */
> +	if (device_property_read_bool(dev, "dma-noncoherent")) {
> +		/*
> +		 * Always need same two tables in this case.  Need two tables
> +		 * due to hardware interactions between address and size.
> +		 */
> +		mc_pcie_setup_inbound_atr(0, 0, MPFS_NC_BOUNCE_ADDR, SZ_1G);
> +		mc_pcie_setup_inbound_atr(1, SZ_1G, MPFS_NC_BOUNCE_ADDR +
> SZ_1G, SZ_1G);
> +	} else {
> +		/* Find any DMA ranges */
> +		if (of_pci_dma_range_parser_init(&parser, dn)) {
> +			/* No DMA range property - setup default */
> +			mc_pcie_setup_inbound_atr(0, 0, 0, SZ_4G);
> +			return 0;
> +		}
> +
> +		for_each_of_range(&parser, &range) {
> +			if (atr_index >=3D MC_MAX_NUM_INBOUND_WINDOWS) {
> +				dev_err(dev, "too many inbound ranges; %d available
> tables\n",
> +					MC_MAX_NUM_INBOUND_WINDOWS);
> +				return -EINVAL;
> +			}
> +			mc_pcie_setup_inbound_atr(atr_index, 0, range.pci_addr,
> range.size);
> +			atr_index++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
>  			   struct plda_pcie_rp *port)
>  {
> @@ -656,6 +745,10 @@ static int mc_platform_init(struct pci_config_window
> *cfg)
>  	if (ret)
>  		return ret;
>=20
> +	ret =3D mc_pcie_setup_inbound_ranges(pdev, port);
> +	if (ret)
> +		return ret;
> +
>  	port->plda.event_ops =3D &mc_event_ops;
>  	port->plda.event_irq_chip =3D &mc_event_irq_chip;
>  	port->plda.events_bitmap =3D GENMASK(NUM_EVENTS - 1, 0); diff --git
> a/drivers/pci/controller/plda/pcie-plda-host.c
> b/drivers/pci/controller/plda/pcie-plda-host.c
> index a18923d7cea6..2a3cc2544200 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -8,11 +8,14 @@
>   * Author: Daire McNamara <daire.mcnamara@microchip.com>
>   */
>=20
> +#include <linux/align.h>
> +#include <linux/bitfield.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/msi.h>
>  #include <linux/pci_regs.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/wordpart.h>
>=20
>  #include "pcie-plda.h"
>=20
> @@ -509,8 +512,9 @@ void plda_pcie_setup_window(void __iomem
> *bridge_base_addr, u32 index,
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_PARAM);
>=20
> -	val =3D lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
> -			    ATR_IMPL_ENABLE;
> +	val =3D ALIGN_DOWN(lower_32_bits(axi_addr), SZ_4K);
> +	val |=3D FIELD_PREP(ATR_SIZE_MASK, atr_sz);
> +	val |=3D ATR_IMPL_ENABLE;
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
>=20
> @@ -525,13 +529,20 @@ void plda_pcie_setup_window(void __iomem
> *bridge_base_addr, u32 index,
>  	val =3D upper_32_bits(pci_addr);
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> +}
> +EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
> +
> +void plda_pcie_setup_inbound_address_translation(struct plda_pcie_rp
> +*port) {
> +	void __iomem *bridge_base_addr =3D port->bridge_addr;
> +	u32 val;
>=20
>  	val =3D readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>  	val |=3D (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
>  	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>  	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);  }
> -EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
> +EXPORT_SYMBOL_GPL(plda_pcie_setup_inbound_address_translation);
>=20
>  int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
>  			   struct plda_pcie_rp *port)
> diff --git a/drivers/pci/controller/plda/pcie-plda.h
> b/drivers/pci/controller/plda/pcie-plda.h
> index 0e7dc0d8e5ba..61ece26065ea 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -89,14 +89,15 @@
>=20
>  /* PCIe AXI slave table init defines */
>  #define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> -#define  ATR_SIZE_SHIFT				1
> -#define  ATR_IMPL_ENABLE			1
> +#define  ATR_SIZE_MASK				GENMASK(6, 1)
> +#define  ATR_IMPL_ENABLE			BIT(0)
>  #define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
>  #define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
>  #define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
>  #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
>  #define  PCIE_TX_RX_INTERFACE			0x00000000u
>  #define  PCIE_CONFIG_INTERFACE			0x00000001u
> +#define  TRSL_ID_AXI4_MASTER_0			0x00000004u
>=20
>  #define CONFIG_SPACE_ADDR_OFFSET		0x1000u
>=20
> @@ -204,6 +205,7 @@ int plda_init_interrupts(struct platform_device *pdev=
,
> void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>  			    size_t size);
> +void plda_pcie_setup_inbound_address_translation(struct plda_pcie_rp
> +*port);
>  int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
>  			   struct plda_pcie_rp *port);
>  int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops, =
diff --git
> a/drivers/pci/controller/plda/pcie-starfive.c
> b/drivers/pci/controller/plda/pcie-starfive.c
> index c9933ecf6833..55e84bc79eca 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -355,6 +355,9 @@ static int starfive_pcie_host_init(struct plda_pcie_r=
p
> *plda)
>  	 */
>  	plda_pcie_set_pref_win_64bit(plda);
>=20
> +	/* Setup the inbound address translation */
> +	plda_pcie_setup_inbound_address_translation(plda);
> +
>  	/*
>  	 * Ensure that PERST has been asserted for at least 100 ms,
>  	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
> --
> 2.34.1
>=20

Hi Daire
  Could you please CC Kevin to this patch-set e-mail list? Thanks.

