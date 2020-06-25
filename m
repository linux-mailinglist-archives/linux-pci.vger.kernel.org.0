Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA3209DB6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbgFYLre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 07:47:34 -0400
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:34945
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404220AbgFYLrc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 07:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNyiEzlV6IbAQkefcCD6vuwPv7JDJvImOy19aGm8cWquMmzfSA4lv7Om8DPYeZoovH1hh4QH67f7V0Ast9xEIOyj6ixcxuKncIG5dK/7XWqqVmGsZs+dNzXiVBUGxYBKvoIn3zmwrHlGz6Zw39ZCakXzIcMfFOKWBvzEpJ7MyU30fisCff1l67bxvdJeF4v9GSyf0yPgDXFirHU6DnL2x29KMCFM5z3ay8XYXqSnrbhQ1B/ydPuvnENMbzQ1VCTyMYs1oCkIEYBJi5Faws7J3C9VmfaxTxbkGnH/oPxqM9Yp0PtuldAATfp85sDz2z5HqgWiM2hg6jjHrPzzTEV3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSDnSvjZRLLsoq0K3dWCChZK2U1pvZd2vNewOXv+veg=;
 b=cMDPndjd+/DLGgil+ZQrw5WJ2vxYKLODWJQfZe4rp8d3zVT00oH+GG4QleDWuC3qQF7QxSx6xWE4ZW68LFL/nhCDuGfRUT3Un0s80WK+SSkfWhSD9gwcmAr7xDXD/JVapWa0gvIU0estNOQB7DQNGPhCm1uzgfrNS1t8tDS5O2DyIk90FVlSZRADFJxiwnges26jW42M7LZQXrntCOhcqytGTjQQT3bsO+4Ixv7BaoLfdh8ZubdT9T6u/CEmQLa8DabLiqkQLKsd5ON6yEeX9d7s6kwHBs0ypfT9wFQsL6g2t2wvgM0Q5n5hJh88XKV1PxTeb/FAd6Anh1fFLbUuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSDnSvjZRLLsoq0K3dWCChZK2U1pvZd2vNewOXv+veg=;
 b=XxRCCDg56RWK0TKeyQMcEWxU0KdZ+7f5d0ZiZsrm47NXwCvrDSRKGXuxc+STegGjP/qE/GnRntzkIMQZ53Pg2COldQC3GlwKcjD0h4qC5jf3aPG5o7r+/Yix2NsFc1/ymJ0G4txawvGVGnkTFBhBCK+EGeoi9h459Vyg4ATVFfw=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4869.namprd02.prod.outlook.com (2603:10b6:a03:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Thu, 25 Jun
 2020 11:47:26 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 11:47:25 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWQ92np3oy3WTBdkWe1KxJ1x02XqjpQ7gg
Date:   Thu, 25 Jun 2020 11:47:25 +0000
Message-ID: <BYAPR02MB555926C1F6A0EBBBFCC7E5DDA5920@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b07100aa-0224-41f4-196c-08d818fd87f8
x-ms-traffictypediagnostic: BYAPR02MB4869:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4869217E4B99D4D5702A076EA5920@BYAPR02MB4869.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8sZj1PKDiNslxVR1vWJ5VYX5czWlmIabsc23f79sqFilMp50XnW+WyY+uVY5nA3TCcVF/2t/ZV7mN1L8MsJqoDyNGfqypUrilXFm9zJCbr6Raqq8UYSS3jXrNWWXGRQUprNbV78vhqWPgYAhcMXKOfzSBt3eBxeowa94s+4nsFUwBR9JHPXPDQW146lF1zjzB9pdrHBUZUi6BwRzM8UrXZwUC7tdryUhfjiE80cQuoILEcwLBov0RHOT/W0AhQ/PpJBsnCYAvCsau9MSv7LUGoeYAb5sJ+QXWd2XFRvaj3K0jJhhHGprm2PTEV+0YHU1hKWvBdvf8bdItgU8zhH+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(110136005)(52536014)(7696005)(66446008)(4326008)(5660300002)(30864003)(66556008)(54906003)(83380400001)(55016002)(8676002)(64756008)(316002)(66476007)(9686003)(8936002)(86362001)(76116006)(33656002)(66946007)(186003)(71200400001)(53546011)(2906002)(26005)(478600001)(6506007)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ovLfFa3VlbBibqOSLfck7lhHdTQ6BlMUzN/4gcy4E92+qZHMxt7+EKSiGEEi+UksisecSX/rnYBfG+YgAmWm3ZmPvxv4Gevrdt1pgOrDV3L7FJCk2ljgWvll3mFG3ORqMq1O3v8Zg6BhPKMvajuM+1HdNct8K8P2Q6rAaCJfZWWb06BiJq6I1bue70WjSptLSuVw9S8hGELywo1/iN4gWAKLv4jWNCsQpGL+vDwOI8dnM6PnBydp1W4Ih7iaAalFH0G7CidMCX7Jjbp61NU4Bpl8+x796OWZoLLMeb22t/KgzeraI8Dw9w+qrDWXfIqBj5SccllBOSIkmwkYDIGjWT+8/bzkUNan+aBFbW/6R0yewlb9gq4518Ii3qQpVn3CWt0hkSNFYkF2K9U6X/CYFsSFt6tvGM+EvUV1Vy80zMZna8DLS5iocWdyCvgMUNwJsXesqs0x6hpXLxnH1YUMdQfnqGXAcYQ8NGrrc23FJYztkjDh5TDMV43QH489tfx5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07100aa-0224-41f4-196c-08d818fd87f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 11:47:25.8422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwYMqCtQWqCPpkkV9FnhcThVct1z6GQYvRV5JApL9/m2IoLAaTdTkPotwjMahjTOGnRDwKQsAYim00AC/jQ0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4869
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Gentle ping.

Regards,
Bharat

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Tuesday, June 16, 2020 6:27 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com; lorenzo.pieralisi@arm.com; robh@kernel.org;
> maz@kernel.org; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
>=20
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.
>=20
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c | 617
> +++++++++++++++++++++++++++++++
>  3 files changed, 626 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 20bf00f..d9e393a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -81,6 +81,14 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>=20
> +config PCIE_XILINX_CPM
> +	bool "Xilinx Versal CPM host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	select PCI_HOST_COMMON
> +	help
> +	  Say 'Y' here if you want kernel support for the
> +	  Xilinx Versal CPM host bridge.
> +
>  config PCI_XGENE
>  	bool "X-Gene PCIe controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Mak=
efile
> index 01b2502..78dabda 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-
> common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
>  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) +=3D pcie-xilinx-nwl.o
> +obj-$(CONFIG_PCIE_XILINX_CPM) +=3D pcie-xilinx-cpm.o
>  obj-$(CONFIG_PCI_V3_SEMI) +=3D pci-v3-semi.o
>  obj-$(CONFIG_PCI_XGENE_MSI) +=3D pci-xgene-msi.o
>  obj-$(CONFIG_PCI_VERSATILE) +=3D pci-versatile.o diff --git
> a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-=
xilinx-
> cpm.c
> new file mode 100644
> index 0000000..2592dbb4
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -0,0 +1,617 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
> + *
> + * (C) Copyright 2019 - 2020, Xilinx, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci-ecam.h>
> +
> +#include "../pci.h"
> +
> +/* Register definitions */
> +#define XILINX_CPM_PCIE_REG_IDR		0x00000E10
> +#define XILINX_CPM_PCIE_REG_IMR		0x00000E14
> +#define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> +#define XILINX_CPM_PCIE_REG_RPSC	0x00000E20
> +#define XILINX_CPM_PCIE_REG_RPEFR	0x00000E2C
> +#define XILINX_CPM_PCIE_REG_IDRN	0x00000E38
> +#define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
> +#define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
> +#define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> +#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> +
> +/* Interrupt registers definitions */
> +#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
> +#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
> +#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
> +#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
> +#define XILINX_CPM_PCIE_INTR_NONFATAL		10
> +#define XILINX_CPM_PCIE_INTR_FATAL		11
> +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
> +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
> +#define XILINX_CPM_PCIE_INTR_INTX		16
> +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
> +#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
> +#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
> +#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
> +#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
> +#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
> +#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
> +#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
> +#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
> +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
> +
> +#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
> +
> +#define XILINX_CPM_PCIE_IMR_ALL_MASK			\
> +	(						\
> +		IMR(LINK_DOWN)		|		\
> +		IMR(HOT_RESET)		|		\
> +		IMR(CFG_PCIE_TIMEOUT)	|		\
> +		IMR(CFG_TIMEOUT)	|		\
> +		IMR(CORRECTABLE)	|		\
> +		IMR(NONFATAL)		|		\
> +		IMR(FATAL)		|		\
> +		IMR(CFG_ERR_POISON)	|		\
> +		IMR(PME_TO_ACK_RCVD)	|		\
> +		IMR(INTX)		|		\
> +		IMR(PM_PME_RCVD)	|		\
> +		IMR(SLV_UNSUPP)		|		\
> +		IMR(SLV_UNEXP)		|		\
> +		IMR(SLV_COMPL)		|		\
> +		IMR(SLV_ERRP)		|		\
> +		IMR(SLV_CMPABT)		|		\
> +		IMR(SLV_ILLBUR)		|		\
> +		IMR(MST_DECERR)		|		\
> +		IMR(MST_SLVERR)		|		\
> +		IMR(SLV_PCIE_TIMEOUT)			\
> +	)
> +
> +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> +#define XILINX_CPM_PCIE_IDRN_SHIFT		16
> +
> +/* Root Port Error FIFO Read Register definitions */
> +#define XILINX_CPM_PCIE_RPEFR_ERR_VALID		BIT(18)
> +#define XILINX_CPM_PCIE_RPEFR_REQ_ID		GENMASK(15, 0)
> +#define XILINX_CPM_PCIE_RPEFR_ALL_MASK		0xFFFFFFFF
> +
> +/* Root Port Status/control Register definitions */
> +#define XILINX_CPM_PCIE_REG_RPSC_BEN		BIT(0)
> +
> +/* Phy Status/Control Register definitions */
> +#define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
> +
> +/**
> + * struct xilinx_cpm_pcie_port - PCIe port information
> + * @reg_base: Bridge Register Base
> + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @dev: Device pointer
> + * @intx_domain: Legacy IRQ domain pointer
> + * @cfg: Holds mappings of config space window
> + * @intx_irq: legacy interrupt number
> + * @irq: Error interrupt number
> + * @lock: lock protecting shared register access  */ struct
> +xilinx_cpm_pcie_port {
> +	void __iomem			*reg_base;
> +	void __iomem			*cpm_base;
> +	struct device			*dev;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*cpm_domain;
> +	struct pci_config_window	*cfg;
> +	int				intx_irq;
> +	int				irq;
> +	raw_spinlock_t			lock;
> +};
> +
> +static u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg) {
> +	return readl_relaxed(port->reg_base + reg); }
> +
> +static void pcie_write(struct xilinx_cpm_pcie_port *port,
> +		       u32 val, u32 reg)
> +{
> +	writel_relaxed(val, port->reg_base + reg); }
> +
> +static bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port) {
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
> +}
> +
> +/**
> + * xilinx_cpm_pcie_clear_err_interrupts - Clear Error Interrupts
> + * @port: PCIe port information
> + */
> +static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port
> +*port) {
> +	unsigned long val =3D pcie_read(port, XILINX_CPM_PCIE_REG_RPEFR);
> +
> +	if (val & XILINX_CPM_PCIE_RPEFR_ERR_VALID) {
> +		dev_dbg(port->dev, "Requester ID %lu\n",
> +			val & XILINX_CPM_PCIE_RPEFR_REQ_ID);
> +		pcie_write(port, XILINX_CPM_PCIE_RPEFR_ALL_MASK,
> +			   XILINX_CPM_PCIE_REG_RPEFR);
> +	}
> +}
> +
> +static void xilinx_cpm_mask_leg_irq(struct irq_data *data) {
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask =3D BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	pcie_write(port, (val & (~mask)),
> XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> +
> +static void xilinx_cpm_unmask_leg_irq(struct irq_data *data) {
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask =3D BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> +
> +static struct irq_chip xilinx_cpm_leg_irq_chip =3D {
> +	.name		=3D "INTx",
> +	.irq_mask	=3D xilinx_cpm_mask_leg_irq,
> +	.irq_unmask	=3D xilinx_cpm_unmask_leg_irq,
> +};
> +
> +/**
> + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark IRQ
> +as valid
> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> +				    unsigned int irq, irq_hw_number_t hwirq)
> {
> +	irq_set_chip_and_handler(irq, &xilinx_cpm_leg_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops =3D {
> +	.map =3D xilinx_cpm_pcie_intx_map,
> +};
> +
> +static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc) {
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	val =3D FIELD_GET(XILINX_CPM_PCIE_IDRN_MASK,
> +			pcie_read(port, XILINX_CPM_PCIE_REG_IDRN));
> +
> +	for_each_set_bit(i, &val, PCI_NUM_INTX)
> +		generic_handle_irq(irq_find_mapping(port->intx_domain, i));
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void xilinx_cpm_mask_event_irq(struct irq_data *d) {
> +	struct xilinx_cpm_pcie_port *port =3D irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	val &=3D ~BIT(d->hwirq);
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void xilinx_cpm_unmask_event_irq(struct irq_data *d) {
> +	struct xilinx_cpm_pcie_port *port =3D irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	val |=3D BIT(d->hwirq);
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip xilinx_cpm_event_irq_chip =3D {
> +	.name		=3D "RC-Event",
> +	.irq_mask	=3D xilinx_cpm_mask_event_irq,
> +	.irq_unmask	=3D xilinx_cpm_unmask_event_irq,
> +};
> +
> +static int xilinx_cpm_pcie_event_map(struct irq_domain *domain,
> +				     unsigned int irq, irq_hw_number_t hwirq)
> {
> +	irq_set_chip_and_handler(irq, &xilinx_cpm_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops =3D {
> +	.map =3D xilinx_cpm_pcie_event_map,
> +};
> +
> +static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc) {
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +	val =3D  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> +	val &=3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_irq(irq_find_mapping(port->cpm_domain,
> i));
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> +	if (val)
> +		writel_relaxed(val,
> +			       port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +#define _IC(x, s)                              \
> +	[XILINX_CPM_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> +
> +static const struct {
> +	const char      *sym;
> +	const char      *str;
> +} intr_cause[32] =3D {
> +	_IC(LINK_DOWN,		"Link Down"),
> +	_IC(HOT_RESET,		"Hot reset"),
> +	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
> +	_IC(CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +	_IC(SLV_UNSUPP,		"Slave unsupported request"),
> +	_IC(SLV_UNEXP,		"Slave unexpected completion"),
> +	_IC(SLV_COMPL,		"Slave completion timeout"),
> +	_IC(SLV_ERRP,		"Slave Error Poison"),
> +	_IC(SLV_CMPABT,		"Slave Completer Abort"),
> +	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
> +	_IC(MST_DECERR,		"Master decode error"),
> +	_IC(MST_SLVERR,		"Master slave error"),
> +	_IC(CFG_PCIE_TIMEOUT,	"PCIe ECAM access timeout"),
> +	_IC(CFG_ERR_POISON,	"ECAM poisoned completion received"),
> +	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> +	_IC(PM_PME_RCVD,	"PM_PME message received"),
> +	_IC(SLV_PCIE_TIMEOUT,	"PCIe completion timeout received"),
> +};
> +
> +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
> +{
> +	struct xilinx_cpm_pcie_port *port =3D dev_id;
> +	struct device *dev =3D port->dev;
> +	struct irq_data *d;
> +
> +	d =3D irq_domain_get_irq_data(port->cpm_domain, irq);
> +
> +	switch (d->hwirq) {
> +	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
> +	case XILINX_CPM_PCIE_INTR_NONFATAL:
> +	case XILINX_CPM_PCIE_INTR_FATAL:
> +		cpm_pcie_clear_err_interrupts(port);
> +		fallthrough;
> +
> +	default:
> +		if (intr_cause[d->hwirq].str)
> +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +		else
> +			dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port
> +*port) {
> +	if (port->intx_domain) {
> +		irq_domain_remove(port->intx_domain);
> +		port->intx_domain =3D NULL;
> +	}
> +
> +	if (port->cpm_domain) {
> +		irq_domain_remove(port->cpm_domain);
> +		port->cpm_domain =3D NULL;
> +	}
> +}
> +
> +/**
> + * xilinx_cpm_pcie_init_irq_domain - Initialize IRQ domain
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure  */ static int
> +xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port) {
> +	struct device *dev =3D port->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node =3D of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -EINVAL;
> +	}
> +
> +	port->cpm_domain =3D irq_domain_add_linear(pcie_intc_node, 32,
> +						 &event_domain_ops,
> +						 port);
> +	if (!port->cpm_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(port->cpm_domain,
> DOMAIN_BUS_NEXUS);
> +
> +	port->intx_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
> +						  &intx_domain_ops,
> +						  port);
> +	if (!port->intx_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(port->intx_domain,
> DOMAIN_BUS_WIRED);
> +
> +	of_node_put(pcie_intc_node);
> +	raw_spin_lock_init(&port->lock);
> +
> +	return 0;
> +out:
> +	xilinx_cpm_free_irq_domains(port);
> +	dev_err(dev, "Failed to allocate IRQ domains\n");
> +
> +	return -ENOMEM;
> +}
> +
> +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port) {
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	int i, irq;
> +
> +	port->irq =3D platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		int err;
> +
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq =3D irq_create_mapping(port->cpm_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map interrupt\n");
> +			return -ENXIO;
> +		}
> +
> +		err =3D devm_request_irq(dev, irq,
> xilinx_cpm_pcie_intr_handler,
> +				       0, intr_cause[i].sym, port);
> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}
> +
> +	port->intx_irq =3D irq_create_mapping(port->cpm_domain,
> +					    XILINX_CPM_PCIE_INTR_INTX);
> +	if (!port->intx_irq) {
> +		dev_err(dev, "Failed to map INTx interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(port->intx_irq,
> +					 xilinx_cpm_pcie_intx_flow, port);
> +
> +	/* Plug the main event chained handler */
> +	irq_set_chained_handler_and_data(port->irq,
> +					 xilinx_cpm_pcie_event_flow, port);
> +
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_init_port - Initialize hardware
> + * @port: PCIe port information
> + */
> +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port
> +*port) {
> +	if (cpm_pcie_link_up(port))
> +		dev_info(port->dev, "PCIe Link is UP\n");
> +	else
> +		dev_info(port->dev, "PCIe Link is DOWN\n");
> +
> +	/* Disable all interrupts */
> +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IMR);
> +
> +	/* Clear pending interrupts */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IDR);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +	/* Enable the Bridge enable bit */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> +		   XILINX_CPM_PCIE_REG_RPSC);
> +}
> +
> +/**
> + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + * @bus_range: Bus resource
> + *
> + * Return: '0' on success and error value on failure  */ static int
> +xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> +				    struct resource *bus_range)
> +{
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct resource *res;
> +
> +	port->cpm_base =3D devm_platform_ioremap_resource_byname(pdev,
> +							       "cpm_slcr");
> +	if (IS_ERR(port->cpm_base))
> +		return PTR_ERR(port->cpm_base);
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "cfg");
> +	if (!res)
> +		return -ENXIO;
> +
> +	port->cfg =3D pci_ecam_create(dev, res, bus_range,
> +				    &pci_generic_ecam_ops);
> +	if (IS_ERR(port->cfg))
> +		return PTR_ERR(port->cfg);
> +
> +	port->reg_base =3D port->cfg->win;
> +
> +	return 0;
> +}
> +
> +void xilinx_cpm_free_interrupts(struct xilinx_cpm_pcie_port *port) {
> +	irq_set_chained_handler_and_data(port->intx_irq, NULL, NULL);
> +	irq_set_chained_handler_and_data(port->irq, NULL, NULL); }
> +
> +/**
> + * xilinx_cpm_pcie_probe - Probe function
> + * @pdev: Platform device pointer
> + *
> + * Return: '0' on success and error value on failure  */ static int
> +xilinx_cpm_pcie_probe(struct platform_device *pdev) {
> +	struct xilinx_cpm_pcie_port *port;
> +	struct device *dev =3D &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct resource *bus_range;
> +	int err;
> +
> +	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	port =3D pci_host_bridge_priv(bridge);
> +
> +	port->dev =3D dev;
> +
> +	err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +					      &bridge->dma_ranges,
> &bus_range);
> +	if (err) {
> +		dev_err(dev, "Getting bridge resources failed\n");
> +		return err;
> +	}
> +
> +	err =3D xilinx_cpm_pcie_init_irq_domain(port);
> +	if (err)
> +		return err;
> +
> +	err =3D xilinx_cpm_pcie_parse_dt(port, bus_range);
> +	if (err) {
> +		dev_err(dev, "Parsing DT failed\n");
> +		goto err_parse_dt;
> +	}
> +
> +	xilinx_cpm_pcie_init_port(port);
> +
> +	err =3D xilinx_cpm_setup_irq(port);
> +	if (err) {
> +		dev_err(dev, "Failed to set up interrupts\n");
> +		goto err_setup_irq;
> +	}
> +
> +	bridge->dev.parent =3D dev;
> +	bridge->sysdata =3D port->cfg;
> +	bridge->busnr =3D port->cfg->busr.start;
> +	bridge->ops =3D &pci_generic_ecam_ops.pci_ops;
> +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq =3D pci_common_swizzle;
> +
> +	err =3D pci_host_probe(bridge);
> +	if (err < 0)
> +		goto err_host_bridge;
> +
> +	return 0;
> +
> +err_host_bridge:
> +	xilinx_cpm_free_interrupts(port);
> +err_setup_irq:
> +	pci_ecam_free(port->cfg);
> +err_parse_dt:
> +	xilinx_cpm_free_irq_domains(port);
> +	return err;
> +}
> +
> +static const struct of_device_id xilinx_cpm_pcie_of_match[] =3D {
> +	{ .compatible =3D "xlnx,versal-cpm-host-1.00", },
> +	{}
> +};
> +
> +static struct platform_driver xilinx_cpm_pcie_driver =3D {
> +	.driver =3D {
> +		.name =3D "xilinx-cpm-pcie",
> +		.of_match_table =3D xilinx_cpm_pcie_of_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe =3D xilinx_cpm_pcie_probe,
> +};
> +
> +builtin_platform_driver(xilinx_cpm_pcie_driver);
> --
> 2.7.4

