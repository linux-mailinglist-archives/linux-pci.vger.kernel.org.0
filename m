Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEDC1609B3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 05:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBQE4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Feb 2020 23:56:22 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:16622
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbgBQE4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Feb 2020 23:56:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbnKq6AWZ+Zho5Tq+5k9nerfxJbVN2tSM166bfyR8+SRQv63gvXYeXtk2cLQ2FIMwlyoiL5wbYZO8Thsj0LqMj9GCQT0+P8IH9e6jQH39A12vYQ60BYNcVhNaJr7Qah5lgVv0NJQsiLg61rpMrkWWSlR1DXaxxjw5CHXlIp454X4P6/erY4S7imURqJjkmPkk9fAKhYqwY8TXwztbGWwQRe0CLtqujuXd63v0P0k1quOwI1a0mZ7jOljeW5xPebkOe7KgjzuaJauZJC//wvMVUS6Nl+JpsA9vNJ5WcP4jTO5l66Rl5Xm9piEKG2OcjlpiTPip0GJ0a8yw/vBYlJRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgIMzex/HcVpsf6BTMju5btdTbBIYKhEV4j1AcbAxfE=;
 b=gbPUw8ml4V3GqcYvg5eyeh2L89QpFr7pc8D9LqVKf1FmuhkPSGVbO+2dcf6dDQydRqTWWa/fnu4/syRHKUMTtLiVOjo/CmOfuEfN0/MDWIdTm5idoFeRBLWgFbXLKlm+/7cUfP3tnhDIpz4WmQ87U3D3Y/cg9ADKfeTsUcCND9j1Rsj4VaNmjPIuFxH/mPE/SsIBriyqwUEEG6rSsHpfigsAzGm4umKI7Y5rCAgEoHUChGqqWVhlCYE6rD7V6KSUghGZrYsgOZATRsj7+U3R0a5tG0XrhXgnC+Q/is+/72RPEbC9wzUNkG22fmWGYkfz2oHyhZpN1za8Dr7dRS0LQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgIMzex/HcVpsf6BTMju5btdTbBIYKhEV4j1AcbAxfE=;
 b=qnrY/1A2kQ1l27nCynChwiGoMmcv19EdKZxvxuu/kWYZO0IX/meFAX6pj+4tcWV1OVeCj23hVK9e/1tWu309uWLdkKnqzlme7w7v3QjcCWWJA4IxA1AZ2qcnvhDBsQyRJdhxoqMvP++UbWFeX/Dy4a1smDH9FhW+UVwhS26xvPk=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB5888.namprd02.prod.outlook.com (20.179.98.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Mon, 17 Feb 2020 04:54:31 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::dd35:8dfd:df9:1322]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::dd35:8dfd:df9:1322%7]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 04:54:31 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kge7WEg
Date:   Mon, 17 Feb 2020 04:54:30 +0000
Message-ID: <MN2PR02MB6336CE2064A00EE9ECCCD5D1A5160@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65e0df72-5681-45bd-65a2-08d7b36579e2
x-ms-traffictypediagnostic: MN2PR02MB5888:|MN2PR02MB5888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB5888F8AA44236F28CF245F9DA5160@MN2PR02MB5888.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:422;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39850400004)(136003)(199004)(189003)(4326008)(8676002)(107886003)(8936002)(81156014)(81166006)(64756008)(66446008)(52536014)(66556008)(5660300002)(66476007)(86362001)(110136005)(30864003)(316002)(76116006)(7696005)(9686003)(53546011)(478600001)(186003)(6506007)(2906002)(33656002)(54906003)(55016002)(71200400001)(66946007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5888;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a36Sv0Zne3vfYwwb13ObUl10oWhVxmF+gIY5DI/yGeDbZKqFB51dySR94d00DGSlMaxdCaAzeZ0ZdEguiitdSUjG0hry5mQHrJD4urx7d0tTH7YjlHVzZ1fmfp0R2eRqk5G+llk4SibiB1zn9UPgUlFpw4vB6+fw6/+RUVIEhR6stAuHWWYr8ts/P8zBSMiJbKCDR3BZCQcilt40v9qtLT2dim20wuuZUGF3SY2Pchi/rj3BUYvD0Meml0qUXLIi1LlKcO59XrwImmHN5Y0+id4O/OfKG0ZGLZkn73BC0SfpY41yYndl/tkmcQF+266/1bMLvvuTr6hXIUfkx6SQUoN7YV8TcEV/ZRSRazcKkEHcTAWoGAABJtnVc+4unTbCDtxR0v5xvntNm+K8de6xGQfNGm6ubMAAuS0a/bEnqsxtRvW+sLxJuDgljrjMoKeu
x-ms-exchange-antispam-messagedata: gQ2/E3A3K69HViLfztk+ZA3GbECYkq6oT3SEwvkn5MO+bvQM6zyj2YNW3p+5s82MVjzfHH3ZtrgC+Yc6Xi+MQVkhQoUUBiC/SILCC9/dUXgjDS7Tn2vWfA7U+DTRiLLIl639tG+QZC88ZhCGLnAGWA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0df72-5681-45bd-65a2-08d7b36579e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 04:54:31.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWWL4516F2QxDRxaibQ3h3lUnWo8irgta8BdBFDLAEpVjVrSeo1EbBSAsjiamMpumEmd3dH7G76WUY8xhDOAng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5888
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Can you please let us know, if you have any further comments on this series=
 ?

Regards,
Bharat

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Thursday, January 30, 2020 9:43 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com; Ravikiran Gummaluri <rgummal@xilinx.com>;
> Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
>=20
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific MISC interrupt line.
>=20
> Changes v5:
> - Removed xilinx_cpm_pcie_valid_device function
>=20
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/controller/Kconfig           |   8 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-xilinx-cpm.c | 491
> +++++++++++++++++++++++++++++++
>  3 files changed, 500 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig index
> c77069c..362f4db 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -81,6 +81,14 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>=20
> +config PCIE_XILINX_CPM
> +	bool "Xilinx Versal CPM host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  Say 'Y' here if you want kernel support for the
> +	  Xilinx Versal CPM host bridge. The driver supports
> +	  MSI/MSI-X interrupts using GICv3 ITS feature.
> +
>  config PCI_XGENE
>  	bool "X-Gene PCIe controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Mak=
efile
> index 3d4f597..6c936e9 100644
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
> index 0000000..4e4c0f0
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
> + *
> + * (C) Copyright 2019 - 2020, Xilinx, Inc.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
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
> +#define XILINX_CPM_PCIE_INTR_LINK_DOWN		BIT(0)
> +#define XILINX_CPM_PCIE_INTR_HOT_RESET		BIT(3)
> +#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	BIT(8)
> +#define XILINX_CPM_PCIE_INTR_CORRECTABLE	BIT(9)
> +#define XILINX_CPM_PCIE_INTR_NONFATAL		BIT(10)
> +#define XILINX_CPM_PCIE_INTR_FATAL		BIT(11)
> +#define XILINX_CPM_PCIE_INTR_INTX		BIT(16)
> +#define XILINX_CPM_PCIE_INTR_MSI		BIT(17)
> +#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		BIT(20)
> +#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		BIT(21)
> +#define XILINX_CPM_PCIE_INTR_SLV_COMPL		BIT(22)
> +#define XILINX_CPM_PCIE_INTR_SLV_ERRP		BIT(23)
> +#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		BIT(24)
> +#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		BIT(25)
> +#define XILINX_CPM_PCIE_INTR_MST_DECERR		BIT(26)
> +#define XILINX_CPM_PCIE_INTR_MST_SLVERR		BIT(27)
> +#define XILINX_CPM_PCIE_IMR_ALL_MASK		0x1FF39FF9
> +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
> +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
> +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
> +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
> +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
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
> +/* ECAM definitions */
> +#define ECAM_BUS_NUM_SHIFT		20
> +#define ECAM_DEV_NUM_SHIFT		12
> +
> +/**
> + * struct xilinx_cpm_pcie_port - PCIe port information
> + * @reg_base: Bridge Register Base
> + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @irq: Interrupt number
> + * @root_busno: Root Bus number
> + * @dev: Device pointer
> + * @leg_domain: Legacy IRQ domain pointer
> + * @irq_misc: Legacy and error interrupt number  */ struct
> +xilinx_cpm_pcie_port {
> +	void __iomem *reg_base;
> +	void __iomem *cpm_base;
> +	u32 irq;
> +	u8 root_busno;
> +	struct device *dev;
> +	struct irq_domain *leg_domain;
> +	int irq_misc;
> +};
> +
> +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
> +{
> +	return readl(port->reg_base + reg);
> +}
> +
> +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> +			      u32 val, u32 reg)
> +{
> +	writel(val, port->reg_base + reg);
> +}
> +
> +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
> +{
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0; }
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
> +/**
> + * xilinx_cpm_pcie_map_bus - Get configuration base
> + * @bus: PCI Bus structure
> + * @devfn: Device/function
> + * @where: Offset from base
> + *
> + * Return: Base address of the configuration space needed to be
> + *	   accessed.
> + */
> +static void __iomem *xilinx_cpm_pcie_map_bus(struct pci_bus *bus,
> +					     unsigned int devfn, int where) {
> +	struct xilinx_cpm_pcie_port *port =3D bus->sysdata;
> +	int relbus;
> +
> +	relbus =3D (bus->number << ECAM_BUS_NUM_SHIFT) |
> +		 (devfn << ECAM_DEV_NUM_SHIFT);
> +
> +	return port->reg_base + relbus + where; }
> +
> +/* PCIe operations */
> +static struct pci_ops xilinx_cpm_pcie_ops =3D {
> +	.map_bus =3D xilinx_cpm_pcie_map_bus,
> +	.read	=3D pci_generic_config_read,
> +	.write	=3D pci_generic_config_write,
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
> +				    unsigned int irq, irq_hw_number_t hwirq) {
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops =3D {
> +	.map =3D xilinx_cpm_pcie_intx_map,
> +	.xlate =3D pci_irqd_intx_xlate,
> +};
> +
> +/**
> + * xilinx_cpm_pcie_intr_handler - Interrupt Service Handler
> + * @irq: IRQ number
> + * @data: PCIe port information
> + *
> + * Return: IRQ_HANDLED on success and IRQ_NONE on failure  */ static
> +irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data) {
> +	struct xilinx_cpm_pcie_port *port =3D data;
> +	struct device *dev =3D port->dev;
> +	u32 val, mask, status, bit;
> +	unsigned long intr_val;
> +
> +	/* Read interrupt decode and mask registers */
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> +	mask =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +
> +	status =3D val & mask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
> +		dev_warn(dev, "Link Down\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
> +		dev_info(dev, "Hot reset\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
> +		dev_warn(dev, "ECAM access timeout\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
> +		dev_warn(dev, "Correctable error message\n");
> +		cpm_pcie_clear_err_interrupts(port);
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
> +		dev_warn(dev, "Non fatal error message\n");
> +		cpm_pcie_clear_err_interrupts(port);
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
> +		dev_warn(dev, "Fatal error message\n");
> +		cpm_pcie_clear_err_interrupts(port);
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_INTX) {
> +		/* Handle INTx Interrupt */
> +		intr_val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
> +		intr_val =3D intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
> +
> +		for_each_set_bit(bit, &intr_val, PCI_NUM_INTX)
> +			generic_handle_irq(irq_find_mapping(port-
> >leg_domain,
> +							    bit));
> +	}
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
> +		dev_warn(dev, "Slave unsupported request\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
> +		dev_warn(dev, "Slave unexpected completion\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
> +		dev_warn(dev, "Slave completion timeout\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
> +		dev_warn(dev, "Slave Error Poison\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
> +		dev_warn(dev, "Slave Completer Abort\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
> +		dev_warn(dev, "Slave Illegal Burst\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
> +		dev_warn(dev, "Master decode error\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
> +		dev_warn(dev, "Master slave error\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
> +		dev_warn(dev, "PCIe ECAM access timeout\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
> +		dev_warn(dev, "ECAM poisoned completion received\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
> +		dev_warn(dev, "PME_TO_ACK message received\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
> +		dev_warn(dev, "PM_PME message received\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
> +		dev_warn(dev, "PCIe completion timeout received\n");
> +
> +	/* Clear the Interrupt Decode register */
> +	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	val =3D readl(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
> +	if (val)
> +		writel(val, port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> +
> +	return IRQ_HANDLED;
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
> +	port->leg_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
> +						 &intx_domain_ops,
> +						 port);
> +	if (!port->leg_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
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
> +	/* Enable all interrupts */
> +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IMR);
> +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
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
> +static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port
> +*port) {
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	int err;
> +
> +	port->irq_misc =3D platform_get_irq_byname(pdev, "misc");
> +	if (port->irq_misc <=3D 0) {
> +		dev_err(dev, "Unable to find misc IRQ line\n");
> +		return port->irq_misc;
> +	}
> +	err =3D devm_request_irq(dev, port->irq_misc,
> +			       xilinx_cpm_pcie_intr_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "xilinx-pcie", port);
> +	if (err) {
> +		dev_err(dev, "unable to request misc IRQ line %d\n",
> +			port->irq_misc);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure  */ static int
> +xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port) {
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct resource *res;
> +	int err;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	port->reg_base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(port->reg_base))
> +		return PTR_ERR(port->reg_base);
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "cpm_slcr");
> +	port->cpm_base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(port->cpm_base))
> +		return PTR_ERR(port->cpm_base);
> +
> +	err =3D xilinx_cpm_request_misc_irq(port);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_probe - Probe function
> + * @pdev: Platform device pointer
> + *
> + * Return: '0' on success and error value on failure  */ static int
> +xilinx_cpm_pcie_probe(struct platform_device *pdev) {
> +	struct xilinx_cpm_pcie_port *port;
> +	struct device *dev =3D &pdev->dev;
> +	struct pci_bus *bus;
> +	struct pci_bus *child;
> +	struct pci_host_bridge *bridge;
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
> +	err =3D xilinx_cpm_pcie_parse_dt(port);
> +	if (err) {
> +		dev_err(dev, "Parsing DT failed\n");
> +		return err;
> +	}
> +
> +	xilinx_cpm_pcie_init_port(port);
> +
> +	err =3D xilinx_cpm_pcie_init_irq_domain(port);
> +	if (err) {
> +		dev_err(dev, "Failed creating IRQ Domain\n");
> +		return err;
> +	}
> +
> +	err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> +					      &bridge->dma_ranges, NULL);
> +	if (err) {
> +		dev_err(dev, "Getting bridge resources failed\n");
> +		return err;
> +	}
> +
> +	bridge->dev.parent =3D dev;
> +	bridge->sysdata =3D port;
> +	bridge->busnr =3D port->root_busno;
> +	bridge->ops =3D &xilinx_cpm_pcie_ops;
> +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq =3D pci_common_swizzle;
> +
> +	err =3D pci_scan_root_bus_bridge(bridge);
> +	if (err)
> +		return err;
> +
> +	bus =3D bridge->bus;
> +
> +	pci_assign_unassigned_bus_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bus);
> +	return 0;
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

