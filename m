Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE916A185
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 10:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBXJOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 04:14:50 -0500
Received: from mail-mw2nam12hn2235.outbound.protection.outlook.com ([52.100.167.235]:34777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbgBXJOr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 04:14:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0HVfji69qft3nyeLMT8pNEqZIS7R1TVWBpPa2YscikZVwMpOFQeka2U/qgEdGJ+Bx9B3kbVRG9El9rZNVAZAzb2EP6pV7+PoDfMWxgJrAtdxyuytNZm55zmRshlzmlXDCIfkq4BakQi6ZxYFhzSFOTyWatIobfVhV+66oAcQkdReHrSdSguamhOjSvRUAq8UxeEFMBB1igNCrTrMx3IgRUmrT9sj1ef3OR6ydbto8m9dfysbgoOrADlujTTrKQ2OLgqBdBxXLbvJGTAig0yjwIlX236mHByQYd252bA5sxLoWLixynNE3fEdsTylneVB/noqloXsydmLVxgflyK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZDwtcrF8nr0fLOAug2Xf0sW8vpJEm5jnihhvEGszu0=;
 b=G8OE7EDXbCDl3mz9He3+XsBnk7/nt6uE4foI7lC3hoi3a2e1yW+uxHi28I7NpcKVYbXCJjd2Z5zt+E+cHOAXu5UFFc+PnrRGCWTND/6rX1uNjo65kubBaeK1iRlHubNfzveiYsCOCMe/Dc3x/fCPlBs+dmWzdk6QuWU2f97Wr1qnZLVerj0NVQAPYe/mclVih+x/qFLwIuOT8nVl7JXLLfFyL2FjCv7oXolIPoRAjkpHU5VuPk3FDu23iYmvj6M/cOz2L+WsV7Qkk0FAF3LKhvW8guN7hiVikLDA/vdhhq2hanEvShJYMUXrt/zh5JI/0iXFygjHFZ0tjZcD9dtLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZDwtcrF8nr0fLOAug2Xf0sW8vpJEm5jnihhvEGszu0=;
 b=IGs/GoE7/ytYjiThs5FA3BKhiKb6LmmjFv3utOlMps4FUWYaPWcLV+XLYAtlfzI2bu9U91pRJtIGJ4WFKFOIM/M1wI+3weOn81ThQajR5XkTn1qA9ZK9Er4Vz0ul7qtnLuyakrLwX6TjNHyDrPVy0t9srtpieCTo7VNFrfulVyw=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (2603:10b6:208:1b8::30)
 by MN2PR02MB6253.namprd02.prod.outlook.com (2603:10b6:208:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Mon, 24 Feb
 2020 09:14:36 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f452:65fb:14c7:dd6b]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f452:65fb:14c7:dd6b%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 09:14:36 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03KggLH6AgAoHaWA=
Date:   Mon, 24 Feb 2020 09:14:36 +0000
Message-ID: <MN2PR02MB6336B50284E7E8B75A457CACA5EC0@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200217235549.GA47074@google.com>
In-Reply-To: <20200217235549.GA47074@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 944af8b9-f989-4610-37c1-08d7b909f822
x-ms-traffictypediagnostic: MN2PR02MB6253:|MN2PR02MB6253:|MN2PR02MB6253:|MN2PR02MB6253:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6253AE4A1593228F2A865DDDA5EC0@MN2PR02MB6253.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:SPM;SFS:(10001);DIR:OUT;SFP:1501;SCL:5;SRVR:MN2PR02MB6253;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;CAT:OSPM;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?+K8rjpCa1K+nVo0diNUDu5aO7K4QyPIfnbsfsUHhmxseEWyMV9A22VIgZDaQ?=
 =?us-ascii?Q?iRnSPajSX5LcLFdq6PP6dHnYeuv7BGvsb6GBpBSbhlUA5GMdx3O5kG7k+2n7?=
 =?us-ascii?Q?k3m69LZsHR99zJ+LS6nDoNF1Om5CTRWtl7cgDk0qowD7HZlsljwC70nhDiBj?=
 =?us-ascii?Q?W+aPnHKow9xOkf8krkZ9BQY7cTUqFiv/jyNQ+84RMbNr7kEUkfLDT7JZ4IQx?=
 =?us-ascii?Q?UrfFgJe4oWIPso2llSzAPJJwNnu3GNLb04gt/0lDIn4fCQ+hnk5tYnYq2YKz?=
 =?us-ascii?Q?/Z4Skti9lTlXo88FLKdu6+gAGUIF/nn6gFE2IRR65b9PQNTTaWNWPUNPhFxN?=
 =?us-ascii?Q?+lOgXOqIRlxkrOR+XCDGs7CjHbHi7UA35fuFFRD/bTddliIeFANj3FageqY3?=
 =?us-ascii?Q?u20mMtUYGRm+nQaSPQHmaaJDUgSVj2tNR8QUg7bJE2lC3LrAazj4wl+NWakP?=
 =?us-ascii?Q?FVr/CG8gyliJBGLuBWRY58ZdQdTGyUhyYMU0D0XVvJGFMRJWXuhpWbO8p/jn?=
 =?us-ascii?Q?+Btpy8K1CPydD1LI4vHHUgJ702IafPO/YCIq/5JCEHQoFngFI9cSeDiFX867?=
 =?us-ascii?Q?LvK2RObZNhUKISp/8lvoiOKbQ+Wx9EwzE0R9UzRHXZ2qSnzwmaJlyFBII8Ow?=
 =?us-ascii?Q?s0r4ZIDJYsFa8+mUqVFnIeQ6nVBXsjgYmsh++StaBEx3KVQGiAAO94Ej3uLq?=
 =?us-ascii?Q?XH1Pecw6398CoIB5NWMCfoXOpOjC0V/LWgIsLem4xY6Oj55VB0R63zuYBIGp?=
 =?us-ascii?Q?whiYC7SYf020JCf1SGmA2YZrnBeoURaIYux1XbPMR07wAPIg8jU1YINEj+MQ?=
 =?us-ascii?Q?s6Mn3N4RWzfDxdVNBygz1YwBAMYOFCVc5QNPFEjKU1R9gpYJeO8SNQ7yDNwe?=
 =?us-ascii?Q?0VgDwYqrH6P8GVhyouJi8BSUS13j5LWwXh+PuV0IDeadqNeB8SnsX/besCl9?=
 =?us-ascii?Q?WSJo3hWv0hZHyOMbjos5bQ=3D=3D?=
x-ms-exchange-antispam-messagedata: rgM4et75PSFMZUd+y8IFADI7o7pTaa1tb47sqa2NBID3m7w2XWW03TXhi1iNXZUThVU8tsHchz4G8LDoQSvbNNBq0xCdXEMqdf3itYetgqvkErN2O3hnfw/snFjI7fLKbybcRtWKNZp+gPkA659WaQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944af8b9-f989-4610-37c1-08d7b909f822
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 09:14:36.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf2hD/KoAdfb+aaHWcOky++A5bRpqNCOULJPMvqRDRGd3t1cyqjbPc0Ux6U/QkE5GBAFXyzSWvXnC1lR9heJdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6253
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn.

Hi Lorenzo and Andrew, please let me know if you have any further queries.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, February 18, 2020 5:26 AM
> To: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Ravikiran
> Gummaluri <rgummal@xilinx.com>; lorenzo.pieralisi@arm.com; Andrew Murray
> <amurray@thegoodpenguin.co.uk>
> Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> Lorenzo and Andrew take care of drivers/pci/controllers/*.  I'm sure this=
 is on
> their radar already but I cc'd them for good measure.
>=20
> On Thu, Jan 30, 2020 at 09:42:51PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
> >   vectors and handling MSI/MSI-X interrupts.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific MISC interrupt line.
> >
> > Changes v5:
> > - Removed xilinx_cpm_pcie_valid_device function
>=20
> I don't include this sort of history in the commit log because it's not r=
eally of
> enduring interest.  Lorenzo will probably take it out for you, so no need=
 to
> repost just for that.
>=20
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/Kconfig           |   8 +
> >  drivers/pci/controller/Makefile          |   1 +
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 491
> > +++++++++++++++++++++++++++++++
> >  3 files changed, 500 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> >
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index c77069c..362f4db 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -81,6 +81,14 @@ config PCIE_XILINX
> >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> >  	  Host Bridge driver.
> >
> > +config PCIE_XILINX_CPM
>=20
> I would consider making this PCIE_XILINX_CPM_HOST because many of these
> chips can be either a host or an endpoint, and if you add _HOST now there=
 is
> room for a future endpoint driver.  E.g., see CONFIG_PCI_DRA7XX_HOST and
> CONFIG_PCI_DRA7XX_EP.
>=20
> > +	bool "Xilinx Versal CPM host bridge support"
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	help
> > +	  Say 'Y' here if you want kernel support for the
> > +	  Xilinx Versal CPM host bridge. The driver supports
> > +	  MSI/MSI-X interrupts using GICv3 ITS feature.
> > +
> >  config PCI_XGENE
> >  	bool "X-Gene PCIe controller"
> >  	depends on ARM64 || COMPILE_TEST
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile index 3d4f597..6c936e9 100644
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
> > index 0000000..4e4c0f0
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -0,0 +1,491 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * PCIe host controller driver for Xilinx Versal CPM DMA Bridge
> > + *
> > + * (C) Copyright 2019 - 2020, Xilinx, Inc.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
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
> > +#define XILINX_CPM_PCIE_INTR_LINK_DOWN		BIT(0)
> > +#define XILINX_CPM_PCIE_INTR_HOT_RESET		BIT(3)
> > +#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	BIT(8)
> > +#define XILINX_CPM_PCIE_INTR_CORRECTABLE	BIT(9)
> > +#define XILINX_CPM_PCIE_INTR_NONFATAL		BIT(10)
> > +#define XILINX_CPM_PCIE_INTR_FATAL		BIT(11)
> > +#define XILINX_CPM_PCIE_INTR_INTX		BIT(16)
> > +#define XILINX_CPM_PCIE_INTR_MSI		BIT(17)
> > +#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		BIT(20)
> > +#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		BIT(21)
> > +#define XILINX_CPM_PCIE_INTR_SLV_COMPL		BIT(22)
> > +#define XILINX_CPM_PCIE_INTR_SLV_ERRP		BIT(23)
> > +#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		BIT(24)
> > +#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		BIT(25)
> > +#define XILINX_CPM_PCIE_INTR_MST_DECERR		BIT(26)
> > +#define XILINX_CPM_PCIE_INTR_MST_SLVERR		BIT(27)
> > +#define XILINX_CPM_PCIE_IMR_ALL_MASK		0x1FF39FF9
> > +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> > +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> > +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
> > +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
> > +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
> > +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
> > +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
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
> > +/* ECAM definitions */
> > +#define ECAM_BUS_NUM_SHIFT		20
> > +#define ECAM_DEV_NUM_SHIFT		12
> > +
> > +/**
> > + * struct xilinx_cpm_pcie_port - PCIe port information
> > + * @reg_base: Bridge Register Base
> > + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> > + * @irq: Interrupt number
> > + * @root_busno: Root Bus number
> > + * @dev: Device pointer
> > + * @leg_domain: Legacy IRQ domain pointer
> > + * @irq_misc: Legacy and error interrupt number  */ struct
> > +xilinx_cpm_pcie_port {
> > +	void __iomem *reg_base;
> > +	void __iomem *cpm_base;
> > +	u32 irq;
> > +	u8 root_busno;
> > +	struct device *dev;
> > +	struct irq_domain *leg_domain;
> > +	int irq_misc;
> > +};
> > +
> > +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32
> > +reg) {
> > +	return readl(port->reg_base + reg);
> > +}
> > +
> > +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> > +			      u32 val, u32 reg)
> > +{
> > +	writel(val, port->reg_base + reg);
> > +}
> > +
> > +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port
> > +*port) {
> > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0; }
> > +
> > +/**
> > + * xilinx_cpm_pcie_clear_err_interrupts - Clear Error Interrupts
> > + * @port: PCIe port information
> > + */
> > +static void cpm_pcie_clear_err_interrupts(struct xilinx_cpm_pcie_port
> > +*port) {
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
> > +/**
> > + * xilinx_cpm_pcie_map_bus - Get configuration base
> > + * @bus: PCI Bus structure
> > + * @devfn: Device/function
> > + * @where: Offset from base
> > + *
> > + * Return: Base address of the configuration space needed to be
> > + *	   accessed.
> > + */
> > +static void __iomem *xilinx_cpm_pcie_map_bus(struct pci_bus *bus,
> > +					     unsigned int devfn, int where) {
> > +	struct xilinx_cpm_pcie_port *port =3D bus->sysdata;
> > +	int relbus;
> > +
> > +	relbus =3D (bus->number << ECAM_BUS_NUM_SHIFT) |
> > +		 (devfn << ECAM_DEV_NUM_SHIFT);
> > +
> > +	return port->reg_base + relbus + where;
>=20
> I *think* this is exactly pci_ecam_map_bus(), so maybe you could just use
> pci_generic_ecam_ops instead of defining xilinx_cpm_pcie_ops?  If so,
> congratulations, you've achieved what seems to be almost impossible.
>=20
> > +}
> > +
> > +/* PCIe operations */
> > +static struct pci_ops xilinx_cpm_pcie_ops =3D {
> > +	.map_bus =3D xilinx_cpm_pcie_map_bus,
> > +	.read	=3D pci_generic_config_read,
> > +	.write	=3D pci_generic_config_write,
> > +};
> > +
> > +/**
> > + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark
> > +IRQ as valid
> > + * @domain: IRQ domain
> > + * @irq: Virtual IRQ number
> > + * @hwirq: HW interrupt number
> > + *
> > + * Return: Always returns 0.
> > + */
> > +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> > +				    unsigned int irq, irq_hw_number_t hwirq) {
> > +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > +
> > +	return 0;
> > +}
> > +
> > +/* INTx IRQ Domain operations */
> > +static const struct irq_domain_ops intx_domain_ops =3D {
> > +	.map =3D xilinx_cpm_pcie_intx_map,
> > +	.xlate =3D pci_irqd_intx_xlate,
> > +};
> > +
> > +/**
> > + * xilinx_cpm_pcie_intr_handler - Interrupt Service Handler
> > + * @irq: IRQ number
> > + * @data: PCIe port information
> > + *
> > + * Return: IRQ_HANDLED on success and IRQ_NONE on failure  */ static
> > +irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data) {
> > +	struct xilinx_cpm_pcie_port *port =3D data;
> > +	struct device *dev =3D port->dev;
> > +	u32 val, mask, status, bit;
> > +	unsigned long intr_val;
> > +
> > +	/* Read interrupt decode and mask registers */
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> > +	mask =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> > +
> > +	status =3D val & mask;
> > +	if (!status)
> > +		return IRQ_NONE;
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
> > +		dev_warn(dev, "Link Down\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
> > +		dev_info(dev, "Hot reset\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
> > +		dev_warn(dev, "ECAM access timeout\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
> > +		dev_warn(dev, "Correctable error message\n");
> > +		cpm_pcie_clear_err_interrupts(port);
> > +	}
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
> > +		dev_warn(dev, "Non fatal error message\n");
> > +		cpm_pcie_clear_err_interrupts(port);
> > +	}
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
> > +		dev_warn(dev, "Fatal error message\n");
> > +		cpm_pcie_clear_err_interrupts(port);
> > +	}
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_INTX) {
> > +		/* Handle INTx Interrupt */
> > +		intr_val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
> > +		intr_val =3D intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
> > +
> > +		for_each_set_bit(bit, &intr_val, PCI_NUM_INTX)
> > +			generic_handle_irq(irq_find_mapping(port-
> >leg_domain,
> > +							    bit));
> > +	}
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
> > +		dev_warn(dev, "Slave unsupported request\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
> > +		dev_warn(dev, "Slave unexpected completion\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
> > +		dev_warn(dev, "Slave completion timeout\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
> > +		dev_warn(dev, "Slave Error Poison\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
> > +		dev_warn(dev, "Slave Completer Abort\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
> > +		dev_warn(dev, "Slave Illegal Burst\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
> > +		dev_warn(dev, "Master decode error\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
> > +		dev_warn(dev, "Master slave error\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
> > +		dev_warn(dev, "PCIe ECAM access timeout\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
> > +		dev_warn(dev, "ECAM poisoned completion received\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
> > +		dev_warn(dev, "PME_TO_ACK message received\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
> > +		dev_warn(dev, "PM_PME message received\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
> > +		dev_warn(dev, "PCIe completion timeout received\n");
> > +
> > +	/* Clear the Interrupt Decode register */
> > +	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
> > +
> > +	/*
> > +	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
> > +	 * CPM SLCR block.
> > +	 */
> > +	val =3D readl(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
> > +	if (val)
> > +		writel(val, port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_init_irq_domain - Initialize IRQ domain
> > + * @port: PCIe port information
> > + *
> > + * Return: '0' on success and error value on failure  */ static int
> > +xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port) {
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
> > +	port->leg_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
> > +						 &intx_domain_ops,
> > +						 port);
> > +	if (!port->leg_domain) {
> > +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_init_port - Initialize hardware
> > + * @port: PCIe port information
> > + */
> > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port
> > +*port) {
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
> > +
> > +	/*
> > +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> > +	 * CPM SLCR block.
> > +	 */
> > +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> > +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> > +	/* Enable the Bridge enable bit */
> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> > +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> > +		   XILINX_CPM_PCIE_REG_RPSC);
> > +}
> > +
> > +static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port
> > +*port) {
> > +	struct device *dev =3D port->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int err;
> > +
> > +	port->irq_misc =3D platform_get_irq_byname(pdev, "misc");
> > +	if (port->irq_misc <=3D 0) {
> > +		dev_err(dev, "Unable to find misc IRQ line\n");
> > +		return port->irq_misc;
> > +	}
> > +	err =3D devm_request_irq(dev, port->irq_misc,
> > +			       xilinx_cpm_pcie_intr_handler,
> > +			       IRQF_SHARED | IRQF_NO_THREAD,
> > +			       "xilinx-pcie", port);
> > +	if (err) {
> > +		dev_err(dev, "unable to request misc IRQ line %d\n",
> > +			port->irq_misc);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> > + * @port: PCIe port information
> > + *
> > + * Return: '0' on success and error value on failure  */ static int
> > +xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port) {
> > +	struct device *dev =3D port->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct resource *res;
> > +	int err;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > +	port->reg_base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(port->reg_base))
> > +		return PTR_ERR(port->reg_base);
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +					   "cpm_slcr");
> > +	port->cpm_base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(port->cpm_base))
> > +		return PTR_ERR(port->cpm_base);
> > +
> > +	err =3D xilinx_cpm_request_misc_irq(port);
> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_probe - Probe function
> > + * @pdev: Platform device pointer
> > + *
> > + * Return: '0' on success and error value on failure  */ static int
> > +xilinx_cpm_pcie_probe(struct platform_device *pdev) {
> > +	struct xilinx_cpm_pcie_port *port;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct pci_bus *bus;
> > +	struct pci_bus *child;
> > +	struct pci_host_bridge *bridge;
> > +	int err;
> > +
> > +	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*port));
> > +	if (!bridge)
> > +		return -ENODEV;
> > +
> > +	port =3D pci_host_bridge_priv(bridge);
> > +
> > +	port->dev =3D dev;
> > +
> > +	err =3D xilinx_cpm_pcie_parse_dt(port);
> > +	if (err) {
> > +		dev_err(dev, "Parsing DT failed\n");
> > +		return err;
> > +	}
> > +
> > +	xilinx_cpm_pcie_init_port(port);
> > +
> > +	err =3D xilinx_cpm_pcie_init_irq_domain(port);
> > +	if (err) {
> > +		dev_err(dev, "Failed creating IRQ Domain\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> > +					      &bridge->dma_ranges, NULL);
> > +	if (err) {
> > +		dev_err(dev, "Getting bridge resources failed\n");
> > +		return err;
> > +	}
> > +
> > +	bridge->dev.parent =3D dev;
> > +	bridge->sysdata =3D port;
> > +	bridge->busnr =3D port->root_busno;
> > +	bridge->ops =3D &xilinx_cpm_pcie_ops;
> > +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> > +	bridge->swizzle_irq =3D pci_common_swizzle;
> > +
> > +	err =3D pci_scan_root_bus_bridge(bridge);
> > +	if (err)
> > +		return err;
> > +
> > +	bus =3D bridge->bus;
> > +
> > +	pci_assign_unassigned_bus_resources(bus);
> > +	list_for_each_entry(child, &bus->children, node)
> > +		pcie_bus_configure_settings(child);
> > +	pci_bus_add_devices(bus);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id xilinx_cpm_pcie_of_match[] =3D {
> > +	{ .compatible =3D "xlnx,versal-cpm-host-1.00", },
> > +	{}
> > +};
> > +
> > +static struct platform_driver xilinx_cpm_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "xilinx-cpm-pcie",
> > +		.of_match_table =3D xilinx_cpm_pcie_of_match,
> > +		.suppress_bind_attrs =3D true,
> > +	},
> > +	.probe =3D xilinx_cpm_pcie_probe,
> > +};
> > +
> > +builtin_platform_driver(xilinx_cpm_pcie_driver);
> > --
> > 2.7.4
> >
