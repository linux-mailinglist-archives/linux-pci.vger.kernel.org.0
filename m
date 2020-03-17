Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD5187DA1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgCQJ70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 05:59:26 -0400
Received: from mail-eopbgr1410130.outbound.protection.outlook.com ([40.107.141.130]:59819
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgCQJ7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 05:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl5v+ZFC8Zh9bqWBRQGyetYn1mSG/nE2IEdh2Pz46I6xnBQSZMTRFOyhEjhcaqq4ANxgMUFcFCdv37h0wtoLgmCvEAVlggqseUWcLjookv2+WnZJB2louTxfgNHyVnGZox1VKNIwkS1EyCxJ7H33tXp5wAuS+CFRuBN8uL+PH42xQ2Li+aGYq90usyhzKwmGV+IZdbnUD9HZYplkxOgLYnlRIB1Qp+ieCXaN2BIKeAbxQ1FRqiS5zw0Xk7qwiScLyYn7PZC8TO/6wabiFa4q0swF/HpWhQVW4lRw/ZRzWKH+fqHkuTJilVI274+xDVJ6smaSql7XGGD5EvyDW/ZuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fePM37l7GGMckJ+yLTGu3BPLxB5feX/N1muhSe/6L9w=;
 b=dEL3JadugBzMHs+aanUHgHR8FdaAU6IyQP+YPZZCpd9ksRi/XiQI3HgL1AykXjnxxp4NQTA8PNj29ygSVxCJRgNw+GjGaSQqROhyn4kMoS9jHuH/UxZ6jTZmTKMGnoilLf5Tec+A1UpOAuVMpnKiQ1GU0aarY0j6MyExvUJuL1mDJWuCQ5iPPNy+tmNdpz5mZXfl4NxGd4tbxzCFvrQqTJRJrlhWqOsCijLcUGSP1RYVK1JG7fiZFmazXIQcsLntWT6Q3qssGWoEgWkxpSW5QNuAVMSJZzU3AtWvgaLz7IWs5lT035WWmV2qrD5HumPGqBMO7hc/ZOLW4IkOoN6y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fePM37l7GGMckJ+yLTGu3BPLxB5feX/N1muhSe/6L9w=;
 b=bB5mBFcJnblz1V+8hzKAqv5IeHmrhJ4fJgRj1WKGZlQyBj3x7A/8/Apm2sc9vNXjh4vrR0B5Vaq05Ti+OVSzq/gVRgPB23g3aToDJFNf+pzT0qJPP1gzYU6tCqot3GH9gcw162dCm9Z3+0f8kNHgQFTenDjOIhzQJ6Fan9jzq5k=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3952.jpnprd01.prod.outlook.com (20.178.139.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Tue, 17 Mar 2020 09:59:20 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 09:59:20 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
CC:     Andrew Murray <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v5 6/7] PCI: rcar: Add support for rcar PCIe controller in
 endpoint mode
Thread-Topic: [PATCH v5 6/7] PCI: rcar: Add support for rcar PCIe controller
 in endpoint mode
Thread-Index: AQHV7k2o5Onf4KClakaz57hoModJO6hMjyUw
Date:   Tue, 17 Mar 2020 09:59:19 +0000
Message-ID: <TYAPR01MB4544EAC877ADD0664CB93FF5D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228154122.14164-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3be9faa8-1476-40db-7923-08d7ca59dce6
x-ms-traffictypediagnostic: TYAPR01MB3952:|TYAPR01MB3952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB39524DA68CEC2FCCF52D60F2D8F60@TYAPR01MB3952.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(478600001)(2906002)(8936002)(8676002)(33656002)(81166006)(81156014)(86362001)(64756008)(71200400001)(6916009)(26005)(4326008)(5660300002)(6506007)(186003)(52536014)(55236004)(55016002)(7416002)(9686003)(7696005)(66946007)(76116006)(66476007)(54906003)(316002)(66446008)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB3952;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCvVIzyawL0LRlasqf0t3E0W6e1bHkK7KTILgx/OBJQJ/WtoetLWXMREf2JSMkkejSr7X8zPy5fjp8jxUlmCJYA2Hs7EGa90xoCxfQ1X+8RCo+CNsvLQGirGUPxI5uy0tsUBLvJxQPECBn1Z3N4jPeF8yLGtxBfO2uabO6+ETC6rSzDN/We3Vd8bE9EIG4WdXgIbQQm5BJpaKY+82hMFWtG6kAWiMZFxctVv23x1yyZyI59CGaLzSo9MQT/fdQBrX1jiZMd5QHMYQBCB+fcnBsnjYqkkpNHv4hJDDIPYSrsEVmb/9Ko82igWa30Clsc5FpJ5cQ/ZjE1npFICUR+acYxHt/XvYFl31PtdrPACJhtx+MZtnvWaSHEk4JABzxs9tMGErAqwK8hKtA019b+S2pk4yW/PDMDc8JUM8C2SIXNejXfgjjEx5+7zlXy8B6HO
x-ms-exchange-antispam-messagedata: TdQOESFzqF6eHW+kCjGt1UCormjZBUILTU8Zkoy5pdD8wKsV2Y8B7ElG8FMlrAQzaAGHdyw1+H9I1psD37qoYh+qRgmQJAZzSEY+k8gyiWzMDCj5R77OzKRRVg4TfHO3LxOvZhaflmZkIvRTzA0HBA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be9faa8-1476-40db-7923-08d7ca59dce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 09:59:20.1087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttpo8Vd7ZyUv2/bFyEt+mHbLfEyvT3S3hM9USU9hID2foarIFKEhfvaaJ+/aPb0D8c7Z4JuLKFiVOUtioW2SvEVoGbYBSSjbXTYc1RCCDsc40qxWzpJ0AJ5uwsM0Prvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!

> From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
>=20
> This patch adds support for rcar PCIe controller to work in endpoint mode=
.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/Kconfig        |   8 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pcie-rcar-ep.c | 490 ++++++++++++++++++++++++++++=
++++++
>  drivers/pci/controller/pcie-rcar.h    |   4 +
>  4 files changed, 503 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 37e0ea7..9bf4b02 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -62,6 +62,14 @@ config PCIE_RCAR_HOST
>  	  Say Y here if you want PCIe controller support on R-Car SoCs in host
>  	  mode.
>=20
> +config PCIE_RCAR_EP
> +	bool "Renesas R-Car PCIe endpoint controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	help
> +	  Say Y here if you want PCIe controller support on R-Car SoCs in
> +	  endpoint mode.
> +
>  config PCI_HOST_COMMON
>  	bool
>  	select PCI_ECAM
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Mak=
efile
> index b4ada32..067bd33 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
>  obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
>  obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
>  obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar.o pcie-rcar-host.o
> +obj-$(CONFIG_PCIE_RCAR_EP) +=3D pcie-rcar.o pcie-rcar-ep.o
>  obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
>  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controll=
er/pcie-rcar-ep.c
> new file mode 100644
> index 0000000..db89bbe
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe endpoint driver for Renesas R-Car SoCs
> + *  Copyright (c) 2020 Renesas Electronics Europe GmbH
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/pci-epc.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-rcar.h"
> +
> +/* Structure representing the PCIe interface */
> +struct rcar_pcie {
> +	phys_addr_t		*ob_addr;

I think "ob_mapped_addr" is better.

> +	struct pci_epc_mem_window *ob_window;

I think we can get these windows from "array of address space of
the endpoint controller" in struct pci_epc. If so, we can remove
this member.

> +	struct pci_epc		*epc;

This member can be removed like pcie-cadence-ep.c because
this is not used except saving the epc value from devm_pci_epc_create().

<snip>
> +static int rcar_pcie_ep_start(struct pci_epc *epc)
> +{
> +	struct rcar_pcie *ep =3D epc_get_drvdata(epc);
> +
> +	rcar_pci_write_reg(ep->base, CFINIT, PCIETCTLR);

The following setting is needed before CFINIT like host.

	rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);

> +
> +	return 0;
> +}
> +
> +static void rcar_pcie_ep_stop(struct pci_epc *epc)
> +{
> +	struct rcar_pcie *ep =3D epc_get_drvdata(epc);
> +
> +	rcar_pci_write_reg(ep->base, 0, PCIETCTLR);
> +}
> +
> +static const struct pci_epc_features rcar_pcie_epc_features =3D {
> +	.linkup_notifier =3D false,
> +	.msi_capable =3D false,
> +	.msix_capable =3D false,
> +	/* use 64-bit bars so mark bar1/3/5 as reserved */
> +	.reserved_bar =3D 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> +	.bar_fixed_64bit =3D  (1 << BAR_0) | (1 << BAR_2) | (1 << BAR_4),

These parentheses are not needed like .reserved_bar.

<snip>
> +	err =3D pci_epc_mem_init(epc, pcie->ob_window, pcie->num_ob_windows);
> +	if (err < 0) {
> +		dev_err(dev, "failed to initialize the epc memory space\n");
> +		goto err_pm_put;
> +	}
> +
> +	rcar_pcie_ep_hw_init(pcie);

I'm not sure, but I wonder if we should call this hw init before pci_epc_me=
m_init().

<snip>
> +builtin_platform_driver(rcar_pcie_ep_driver);
> diff --git a/drivers/pci/controller/pcie-rcar.h b/drivers/pci/controller/=
pcie-rcar.h
> index b529d806..5564ca8 100644
> --- a/drivers/pci/controller/pcie-rcar.h
> +++ b/drivers/pci/controller/pcie-rcar.h
> @@ -17,6 +17,7 @@
>  #define PCIECDR			0x000020
>  #define PCIEMSR			0x000028
>  #define PCIEINTXR		0x000400
> +#define  ASTINTX_SHIFT		BIT(16)

Just "ASTINTX" is better.

>  #define PCIEPHYSR		0x0007f0
>  #define  PHYRDY			BIT(0)
>  #define PCIEMSITXR		0x000840
> @@ -55,12 +56,15 @@
>=20
>  /* Configuration */
>  #define PCICONF(x)		(0x010000 + ((x) * 0x4))
> +#define  INTDIS_SHIFT		BIT(10)

Same here (we can remove "_SHIFT").

Best regards,
Yoshihiro Shimoda

>  #define PMCAP(x)		(0x010040 + ((x) * 0x4))
>  #define EXPCAP(x)		(0x010070 + ((x) * 0x4))
>  #define VCCAP(x)		(0x010100 + ((x) * 0x4))
>=20
>  /* link layer */
> +#define IDSETR0			0x011000
>  #define IDSETR1			0x011004
> +#define SUBIDSETR		0x011024
>  #define TLCTLR			0x011048
>  #define MACSR			0x011054
>  #define  SPCHGFIN		BIT(4)
> --
> 2.7.4

