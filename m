Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950E1F6B9C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgFKPwC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 11:52:02 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:6138
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbgFKPwB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 11:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOwTVCOGv0bJMWgtdhAvJHO/Lws09eG9EedY+Kl742PRYdgeVDVE2s7hTp1dRVqPsXb7fZFj6XiwVDOIGfrZhHroiUrJrQ8RyEyKPzUz+TqRKhT8QUzkMikOtAHqRTf0sqmz2nYOsR6tYTdNOxdecYL2X0cxnoLmV/ZdnuSJ8DOk/vS1Dd0H/ILLWtt9qTheAu8IGMBvaKmxVm702fBvqjNCcCuMDXVUrVdaMBltUhpMx7yNHrBhvpAkbcgvjXQpbZu+AguxjEfpGjtxI4yGlLqlBVfssx6GEJvMMFw2dDhicQSgGoBS73PodotTuGtGPgbGu68tRo1ZaMBSdBW/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5juV4R3u22EBZmEKjM7bfZVaS5DpMuCiK05Mm6tkEM0=;
 b=Cr6MrkfS2k604DnXC71rdmnq+GWBGPvKiQ32k4bRiSNG/ezsBrgjDrx8OcvoH3ZrjBLVmKu5BzcQxhNlyk3FY7XlxtvBOH78luyjQBeaWxvkSvP/mQkziA9aPAolOv/FSr/Xbj1//8gWxcC+QAi7TBQ1+YEx5j3TOuy2X5jO/1+ktgkOq3DEgrObcPLYFkEogLtG8USidRS3NPOLR9NZHwAOm0W/NGSQNFmhvkgS5Vd61uKqFG+sJ+hCu9VSdEzw0zffx6gkPz/0McXJJ7+ipptXUdsh2xs0ed9IMvVNeVyRKDEF+KcuLh0e7XscYOADfz4GOd/k9p5kXdoX5US/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5juV4R3u22EBZmEKjM7bfZVaS5DpMuCiK05Mm6tkEM0=;
 b=cE0yuvoBn2GxdeesgZXOAdbuJdc0g71avbD2tGIuK1p5XBiUEvxRUgfZt/cVfBUVzdD4L1100F6Z5aCaZHksElnI24FP+GehemtjJUuutW5VLsV0N+How4lWlgWY8rIKlE65QLRQeQX1xzMLUPuHK9DK+wyXIcoVJJ1QD7pR6FQ=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5991.namprd02.prod.outlook.com (2603:10b6:a03:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 15:51:53 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 15:51:53 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWPZdq6W68nNHNZEqBlWufdyFfUqjPAbcAgASFrZA=
Date:   Thu, 11 Jun 2020 15:51:53 +0000
Message-ID: <BYAPR02MB5559D2F57E35F8881F5B608CA5800@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <c2e4b1288ce454c6ae2b2c02946d084f@kernel.org>
In-Reply-To: <c2e4b1288ce454c6ae2b2c02946d084f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13f1a36f-7257-4f97-8eb3-08d80e1f5cee
x-ms-traffictypediagnostic: BYAPR02MB5991:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5991DCCD1DBC29F1E5A887FCA5800@BYAPR02MB5991.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rb9acnaJpDiwKHmbJx1bXlIF4drtmCryzGlVdDLTQi05izqONNqIfH9Zc2ZGlcEyF6ACqYm+d8DeMYbqY2gmzqCgPGUOQhryI/lfW0ELEKWEMmNc2Z6oGiQ8Rw4gypephjxM4AuOqvM+hDnTkZiOP5RL9mPW6NZ8+xTz6RzTSdmzYD+tPLlbOEtJ/I8m9ZKdeDZYYc5/bDwObuUOp02jqYAjf0aM2YCYFizdJPTWEtne/F9r+TOEWIQ5n34cHZFGedWN0xypKke42jhKoXMn7WFmU6jCp9HpzYi3p8IuoLJJSXs66A3ldg7hRDMptEnB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(9686003)(55016002)(6916009)(478600001)(54906003)(4326008)(8676002)(316002)(186003)(2906002)(8936002)(66946007)(76116006)(5660300002)(83380400001)(86362001)(66556008)(26005)(7696005)(30864003)(6506007)(33656002)(53546011)(66476007)(52536014)(71200400001)(64756008)(66446008)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +jBhHg8oOZxB3VZCqZDcHKhTJVx635RMYjo9rIajLQKSg1KNS4pOEudnw1dXRyZ/aArZDoJ6c75+qHNwlBW0vaUUKIMpM3qvE8gw4cqD+1nzR1YE4pnxCJe37pFPveIhbtQ3WMyJo7hzUAvdg/L3mEeJZFQv9WxZkCIWyIasO3RPgkm+XXxTAlyNd4PU5Dnm0AcsqHAaW8zWNxMImurOzqynNLmQYkN6q4U/ZA3YDUB7WeuqtFvAGa8nEC5tg6vTbsanLL0MMqMm+uJDSiLQku0S84adr3PV6Byb/hq7NxKl+azazJSLqboRya1v/tYeDoRyHgR7N+Z7n8QKrJjVbG8tFG8JsDpjBIViKFQvMyd6OH3cjzd2Mkq9x4gEs0tlF/KupNgKFWzl20t1bJ3MafCGpIobRjSIvQQTWr0qbKfPjYH2ydhuIHS2f3irdqB3/IZ82sUhZZi92Id5il59Aj/wA/qO0W1NXI0FvJPwb+PwuAiHCX/5dz7LNiLsxrUF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f1a36f-7257-4f97-8eb3-08d80e1f5cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 15:51:53.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttqP3wvxO0ElzoGGf3VAwcbV8Ta7wfMXF+Sn0sWVL+qEPJfLgiY6dqcWf4v2CWy6yDRfpqd43LG7GndoMpShBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5991
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> Hi Bharat,
>=20
> On 2020-06-08 14:18, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The
> > integrated
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific interrupt line.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
>=20
> Please don't. Either you take my initial patch as is (potentially with re=
works
> that we discuss on the list), or you add a note saying that I suggested s=
ome
> of the changes. But do not add my Sob without me agreeing to it, speciall=
y
> when there are changes that I object to (see below).
>=20
Hi Marc
Agreed, will add note.=20
> > ---
> >  drivers/pci/controller/Kconfig           |   8 +
> >  drivers/pci/controller/Makefile          |   1 +
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 621
> > +++++++++++++++++++++++++++++++
> >  3 files changed, 630 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> >
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index 20bf00f..d9e393a 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -81,6 +81,14 @@ config PCIE_XILINX
> >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> >  	  Host Bridge driver.
> >
> > +config PCIE_XILINX_CPM
> > +	bool "Xilinx Versal CPM host bridge support"
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	select PCI_HOST_COMMON
> > +	help
> > +	  Say 'Y' here if you want kernel support for the
> > +	  Xilinx Versal CPM host bridge.
> > +
> >  config PCI_XGENE
> >  	bool "X-Gene PCIe controller"
> >  	depends on ARM64 || COMPILE_TEST
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile index 01b2502..78dabda 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-
> common.o
> >  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
> >  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o
> >  obj-$(CONFIG_PCIE_XILINX_NWL) +=3D pcie-xilinx-nwl.o
> > +obj-$(CONFIG_PCIE_XILINX_CPM) +=3D pcie-xilinx-cpm.o
> >  obj-$(CONFIG_PCI_V3_SEMI) +=3D pci-v3-semi.o
> >  obj-$(CONFIG_PCI_XGENE_MSI) +=3D pci-xgene-msi.o
> >  obj-$(CONFIG_PCI_VERSATILE) +=3D pci-versatile.o diff --git
> > a/drivers/pci/controller/pcie-xilinx-cpm.c
> > b/drivers/pci/controller/pcie-xilinx-cpm.c
> > new file mode 100644
> > index 0000000..5bc481e
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -0,0 +1,621 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
> > + *
> > + * (C) Copyright 2019 - 2020, Xilinx, Inc.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h> #include <linux/irqdomain.h>
> > +#include <linux/kernel.h> #include <linux/module.h> #include
> > +<linux/of_address.h> #include <linux/of_pci.h> #include
> > +<linux/of_platform.h> #include <linux/of_irq.h> #include
> > +<linux/pci.h> #include <linux/platform_device.h> #include
> > +<linux/pci-ecam.h>
> > +
> > +#include "../pci.h"
> > +
> > +/* Register definitions */
> > +#define XILINX_CPM_PCIE_REG_IDR		0x00000E10
> > +#define XILINX_CPM_PCIE_REG_IMR		0x00000E14
> > +#define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> > +#define XILINX_CPM_PCIE_REG_RPSC	0x00000E20
> > +#define XILINX_CPM_PCIE_REG_RPEFR	0x00000E2C
> > +#define XILINX_CPM_PCIE_REG_IDRN	0x00000E38
> > +#define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
> > +#define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
> > +#define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> > +#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> > +
> > +/* Interrupt registers definitions */
> > +#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
> > +#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> > +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
> > +#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
> > +#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
> > +#define XILINX_CPM_PCIE_INTR_NONFATAL		10
> > +#define XILINX_CPM_PCIE_INTR_FATAL		11
> > +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
> > +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
> > +#define XILINX_CPM_PCIE_INTR_INTX		16
> > +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
> > +#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
> > +#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
> > +#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
> > +#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
> > +#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
> > +#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
> > +#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
> > +#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
> > +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
> > +
> > +#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
> > +
> > +#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
>=20
> Why do we have this twice?
Will remove this.
>=20
> > +
> > +#define XILINX_CPM_PCIE_IMR_ALL_MASK			\
> > +	(						\
> > +		IMR(LINK_DOWN)		|               \
>=20
> nit: Please use tabs between | and \.
>=20
Agreed, will fix it.
> > +		IMR(HOT_RESET)		|               \
> > +		IMR(CFG_PCIE_TIMEOUT)	|               \
> > +		IMR(CFG_TIMEOUT)	|               \
> > +		IMR(CORRECTABLE)	|               \
> > +		IMR(NONFATAL)		|               \
> > +		IMR(FATAL)		|               \
> > +		IMR(CFG_ERR_POISON)	|               \
> > +		IMR(PME_TO_ACK_RCVD)	|               \
> > +		IMR(INTX)		|               \
> > +		IMR(PM_PME_RCVD)	|               \
> > +		IMR(SLV_UNSUPP)		|               \
> > +		IMR(SLV_UNEXP)		|               \
> > +		IMR(SLV_COMPL)		|               \
> > +		IMR(SLV_ERRP)		|               \
> > +		IMR(SLV_CMPABT)		|               \
> > +		IMR(SLV_ILLBUR)		|               \
> > +		IMR(MST_DECERR)		|               \
> > +		IMR(MST_SLVERR)		|               \
> > +		IMR(SLV_PCIE_TIMEOUT)			\
> > +	)
> > +
> > +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> > +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> > +#define XILINX_CPM_PCIE_IDRN_SHIFT		16
> > +
> > +/* Root Port Error FIFO Read Register definitions */
> > +#define XILINX_CPM_PCIE_RPEFR_ERR_VALID		BIT(18)
> > +#define XILINX_CPM_PCIE_RPEFR_REQ_ID		GENMASK(15, 0)
> > +#define XILINX_CPM_PCIE_RPEFR_ALL_MASK		0xFFFFFFFF
> > +
> > +/* Root Port Status/control Register definitions */
> > +#define XILINX_CPM_PCIE_REG_RPSC_BEN		BIT(0)
> > +
> > +/* Phy Status/Control Register definitions */
> > +#define XILINX_CPM_PCIE_REG_PSCR_LNKUP		BIT(11)
> > +
> > +/**
> > + * struct xilinx_cpm_pcie_port - PCIe port information
> > + * @reg_base: Bridge Register Base
> > + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> > + * @dev: Device pointer
> > + * @intx_domain: Legacy IRQ domain pointer
> > + * @cfg: Holds mappings of config space window
> > + * @intx_irq: legacy interrupt number
> > + * @irq: Error interrupt number
> > + * @lock: lock protecting shared register access  */ struct
> > +xilinx_cpm_pcie_port {
> > +	void __iomem			*reg_base;
> > +	void __iomem			*cpm_base;
> > +	struct device			*dev;
> > +	struct irq_domain		*intx_domain;
> > +	struct irq_domain		*cpm_domain;
> > +	struct pci_config_window	*cfg;
> > +	int				intx_irq;
> > +	int				irq;
> > +	raw_spinlock_t			lock;
> > +};
> > +
> > +static u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg) {
> > +	return readl_relaxed(port->reg_base + reg); }
> > +
> > +static void pcie_write(struct xilinx_cpm_pcie_port *port,
> > +		       u32 val, u32 reg)
> > +{
> > +	writel_relaxed(val, port->reg_base + reg); }
> > +
> > +static bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port) {
> > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_clear_err_interrupts - Clear Error Interrupts
> > + * @port: PCIe port information
> > + */
> > +static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port
> > *port)
> > +{
> > +	unsigned long val =3D pcie_read(port, XILINX_CPM_PCIE_REG_RPEFR);
> > +
> > +	if (val & XILINX_CPM_PCIE_RPEFR_ERR_VALID) {
> > +		dev_dbg(port->dev, "Requester ID %lu\n",
> > +			val & XILINX_CPM_PCIE_RPEFR_REQ_ID);
> > +		pcie_write(port, XILINX_CPM_PCIE_RPEFR_ALL_MASK,
> > +			   XILINX_CPM_PCIE_REG_RPEFR);
> > +	}
> > +}
> > +
> > +static void xilinx_cpm_mask_leg_irq(struct irq_data *data) {
> > +	struct xilinx_cpm_pcie_port *port =3D
> irq_data_get_irq_chip_data(data);
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	mask =3D BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> > +	raw_spin_lock_irqsave(&port->lock, flags);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	pcie_write(port, (val & (~mask)),
> XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> > +
> > +static void xilinx_cpm_unmask_leg_irq(struct irq_data *data) {
> > +	struct xilinx_cpm_pcie_port *port =3D
> irq_data_get_irq_chip_data(data);
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	mask =3D BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> > +	raw_spin_lock_irqsave(&port->lock, flags);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> > +
> > +static struct irq_chip xilinx_cpm_leg_irq_chip =3D {
> > +	.name =3D "INTx",
> > +	.irq_mask =3D xilinx_cpm_mask_leg_irq,
> > +	.irq_unmask =3D xilinx_cpm_unmask_leg_irq,
>=20
> nit: Please align the assignments vertically:
>=20
Agreed, will fix it.
> static struct irq_chip xilinx_cpm_leg_irq_chip =3D {
> 	.name		=3D "INTx",
> 	.irq_mask	=3D xilinx_cpm_mask_leg_irq,
> 	.irq_unmask	=3D xilinx_cpm_unmask_leg_irq,
> };
>=20
>=20
> > +};
> > +
> > +/**
> > + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark
> > IRQ as valid
> > + * @domain: IRQ domain
> > + * @irq: Virtual IRQ number
> > + * @hwirq: HW interrupt number
> > + *
> > + * Return: Always returns 0.
> > + */
> > +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> > +				    unsigned int irq, irq_hw_number_t hwirq)
> {
> > +	irq_set_chip_and_handler(irq, &xilinx_cpm_leg_irq_chip,
> > +				 handle_level_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > +
> > +	return 0;
> > +}
> > +
> > +/* INTx IRQ Domain operations */
> > +static const struct irq_domain_ops intx_domain_ops =3D {
> > +	.map =3D xilinx_cpm_pcie_intx_map,
> > +};
> > +
> > +static void xilinx_cpm_pcie_intx_flow(struct irq_desc *desc) {
> > +	struct xilinx_cpm_pcie_port *port =3D
> irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	unsigned long val;
> > +	int i;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	val =3D FIELD_GET(XILINX_CPM_PCIE_IDRN_MASK,
> > +			pcie_read(port, XILINX_CPM_PCIE_REG_IDRN));
> > +
> > +	for_each_set_bit(i, &val, PCI_NUM_INTX)
> > +		generic_handle_irq(irq_find_mapping(port->intx_domain, i));
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void xilinx_cpm_mask_event_irq(struct irq_data *d) {
> > +	struct xilinx_cpm_pcie_port *port =3D irq_data_get_irq_chip_data(d);
> > +	u32 val;
> > +
> > +	raw_spin_lock(&port->lock);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> > +	val &=3D ~d->hwirq;
> > +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> > +	raw_spin_unlock(&port->lock);
> > +}
> > +
> > +static void xilinx_cpm_unmask_event_irq(struct irq_data *d) {
> > +	struct xilinx_cpm_pcie_port *port =3D irq_data_get_irq_chip_data(d);
> > +	u32 val;
> > +
> > +	raw_spin_lock(&port->lock);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> > +	val |=3D d->hwirq;
> > +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> > +	raw_spin_unlock(&port->lock);
> > +}
> > +
> > +static struct irq_chip xilinx_cpm_event_irq_chip =3D {
> > +	.name           =3D "RC-Event",
> > +	.irq_mask       =3D xilinx_cpm_mask_event_irq,
> > +	.irq_unmask     =3D xilinx_cpm_unmask_event_irq,
>=20
> nit: Please use tabs between the field name and the =3D sign.
>=20
Agreed, will fix it.
> > +};
> > +
> > +static int xilinx_cpm_pcie_event_map(struct irq_domain *domain,
> > +				     unsigned int irq, irq_hw_number_t hwirq)
> {
> > +	irq_set_chip_and_handler(irq, &xilinx_cpm_event_irq_chip,
> > +				 handle_level_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops event_domain_ops =3D {
> > +	.map =3D xilinx_cpm_pcie_event_map,
> > +};
> > +
> > +static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc) {
> > +	struct xilinx_cpm_pcie_port *port =3D
> irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	unsigned long val;
> > +	int i;
> > +
> > +	chained_irq_enter(chip, desc);
> > +	val =3D  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> > +	val &=3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> > +	for_each_set_bit(i, &val, 32)
> > +		generic_handle_irq(irq_find_mapping(port->cpm_domain,
> i));
> > +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
> > +
> > +	/*
> > +	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> > +	 * CPM SLCR block.
> > +	 */
> > +	val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> > +	if (val)
> > +		writel_relaxed(val,
> > +			       port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
>=20
> The write_relaxed() call would be more readable on a single line.
>=20
Agreed, will fix it.
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +#define _IC(x, s)                              \
> > +	[XILINX_CPM_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> > +
> > +static const struct {
> > +	const char      *sym;
> > +	const char      *str;
> > +} intr_cause[32] =3D {
> > +	_IC(LINK_DOWN,		"Link Down"),
> > +	_IC(HOT_RESET,		"Hot reset"),
> > +	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
> > +	_IC(CORRECTABLE,	"Correctable error message"),
> > +	_IC(NONFATAL,		"Non fatal error message"),
> > +	_IC(FATAL,		"Fatal error message"),
> > +	_IC(SLV_UNSUPP,		"Slave unsupported request"),
> > +	_IC(SLV_UNEXP,		"Slave unexpected completion"),
> > +	_IC(SLV_COMPL,		"Slave completion timeout"),
> > +	_IC(SLV_ERRP,		"Slave Error Poison"),
> > +	_IC(SLV_CMPABT,		"Slave Completer Abort"),
> > +	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
> > +	_IC(MST_DECERR,		"Master decode error"),
> > +	_IC(MST_SLVERR,		"Master slave error"),
> > +	_IC(CFG_PCIE_TIMEOUT,	"PCIe ECAM access timeout"),
> > +	_IC(CFG_ERR_POISON,	"ECAM poisoned completion received"),
> > +	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> > +	_IC(PM_PME_RCVD,	"PM_PME message received"),
> > +	_IC(SLV_PCIE_TIMEOUT,	"PCIe completion timeout received"),
> > +};
> > +
> > +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void
> > +*dev_id) {
> > +	struct xilinx_cpm_pcie_port *port =3D dev_id;
> > +	struct device *dev =3D port->dev;
> > +	struct irq_data *d;
> > +
> > +	d =3D irq_domain_get_irq_data(port->cpm_domain, irq);
> > +
> > +	switch (d->hwirq) {
> > +	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
> > +	case XILINX_CPM_PCIE_INTR_NONFATAL:
> > +	case XILINX_CPM_PCIE_INTR_FATAL:
> > +		cpm_pcie_clear_err_interrupts(port);
> > +		fallthrough;
> > +
> > +	default:
> > +		if (intr_cause[d->hwirq].str)
> > +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> > +		else
> > +			dev_warn(dev, "Unknown interrupt\n");
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void xilinx_cpm_free_irq_domains(struct xilinx_cpm_pcie_port
> > *port)
> > +{
> > +	if (port->intx_domain) {
> > +		irq_domain_remove(port->intx_domain);
> > +		port->intx_domain =3D NULL;
> > +	}
> > +
> > +	if (port->cpm_domain) {
> > +		irq_domain_remove(port->cpm_domain);
> > +		port->cpm_domain =3D NULL;
> > +	}
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_init_irq_domain - Initialize IRQ domain
> > + * @port: PCIe port information
> > + *
> > + * Return: '0' on success and error value on failure  */ static int
> > +xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port
> > *port)
> > +{
> > +	struct device *dev =3D port->dev;
> > +	struct device_node *node =3D dev->of_node;
> > +	struct device_node *pcie_intc_node;
> > +
> > +	/* Setup INTx */
> > +	pcie_intc_node =3D of_get_next_child(node, NULL);
> > +	if (!pcie_intc_node) {
> > +		dev_err(dev, "No PCIe Intc node found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	port->cpm_domain =3D irq_domain_add_linear(node, 32,
>=20
> No. The domain must be attached to the intc node, not to the RC.
> Why would you have this intc node otherwise?
Agreed, will fix it.
>=20
> > +						 &event_domain_ops,
> > +						 port);
> > +	if (!port->cpm_domain)
> > +		goto out;
> > +
> > +	irq_domain_update_bus_token(port->cpm_domain,
> DOMAIN_BUS_NEXUS);
> > +
> > +	port->intx_domain =3D irq_domain_add_linear(pcie_intc_node,
> > PCI_NUM_INTX,
> > +						  &intx_domain_ops,
> > +						  port);
> > +	if (!port->intx_domain)
> > +		goto out;
> > +
> > +	irq_domain_update_bus_token(port->intx_domain,
> DOMAIN_BUS_WIRED);
> > +
> > +	of_node_put(pcie_intc_node);
> > +	raw_spin_lock_init(&port->lock);
> > +
> > +	return 0;
> > +out:
> > +	xilinx_cpm_free_irq_domains(port);
> > +	dev_err(dev, "Failed to allocate IRQ domains\n");
> > +
> > +	return -ENOMEM;
> > +}
> > +
> > +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port) {
> > +	struct device *dev =3D port->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int i, irq;
> > +
> > +	port->irq =3D platform_get_irq(pdev, 0);
> > +	if (port->irq < 0) {
> > +		dev_err(dev, "Unable to find misc IRQ line\n");
> > +		return port->irq;
> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> > +		int err;
> > +
> > +		if (!intr_cause[i].str)
> > +			continue;
> > +
> > +		irq =3D irq_create_mapping(port->cpm_domain, i);
> > +		if (WARN_ON(irq <=3D 0))
> > +			return -ENXIO;
> > +
> > +		err =3D devm_request_irq(dev, irq,
> xilinx_cpm_pcie_intr_handler,
> > +				       0, intr_cause[i].sym, port);
> > +		if (WARN_ON(err))
> > +			return err;
> > +	}
> > +
> > +	port->intx_irq =3D irq_create_mapping(port->cpm_domain,
> > +					    XILINX_CPM_PCIE_INTR_INTX);
> > +	if (WARN_ON(port->intx_irq <=3D 0))
> > +		return -ENXIO;
> > +
> > +	/* Plug the INTx chained handler */
> > +	irq_set_chained_handler_and_data(port->intx_irq,
> > +					 xilinx_cpm_pcie_intx_flow, port);
> > +
> > +	/* Plug the main event chained handler */
> > +	irq_set_chained_handler_and_data(port->irq,
> > +					 xilinx_cpm_pcie_event_flow, port);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_init_port - Initialize hardware
> > + * @port: PCIe port information
> > + */
> > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port
> > *port)
> > +{
> > +	if (cpm_pcie_link_up(port))
> > +		dev_info(port->dev, "PCIe Link is UP\n");
> > +	else
> > +		dev_info(port->dev, "PCIe Link is DOWN\n");
> > +
> > +	/* Disable all interrupts */
> > +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IMR);
> > +
> > +	/* Clear pending interrupts */
> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> > +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IDR);
> > +
> > +	/* Enable all interrupts */
> > +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IMR);
> > +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> > +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
>=20
> No. I've explained in the previous review why this was a terrible thing t=
o do,
> and my patch got rid of it for a good reason.
>=20
> If the mask/unmask calls do not work, please explain what is wrong, and l=
et's
> fix them. But we DO NOT enable interrupts outside of an irqchip callback,=
 full
> stop.
The issue here is, we do not have any other register to enable interrupts f=
or above=20
events, in order to see an interrupt assert for these events, the respectiv=
e mask bits
shall be set to 1.

Regards,
bharat


