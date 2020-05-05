Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A551C51C0
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEEJTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 05:19:53 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:6041
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727931AbgEEJTw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 05:19:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9IR6l7jGqm0QGzRrqleW/YzVFig2I8/1jAKafP9m90wElNt6W5iwzElUZkPvkPP7f58BoP54dkGa2sUAm+J6iQe5hNElM8BRVB/lo7ccoKcLUYNFCjxthaS3znLtdUmJS4cK0Cu4BDMeKAIqmgNjKpYKhi2gjqbKOEA3q5YlkKkZFo4N24C6IOcp1yIkeGOAYF6sFEU0AL8rRtACJS0gEWjwLJv+iPMfanfM1/wc7tybGJ7/+R2YDywgr4mwUGJjbYkqPYxQ6Z/sEoIqmcORawqLetgG4/qUf+Gl/DjcD6WVMjaTfhp3Lxa53KaWcfMf72zI6YK/mOketju2f/WQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tza6TURFB0LEhjB9fn0UYZjgM0RIyy7sryxxuTyGrbI=;
 b=TLUlU2oO2ZU54ZA6Hzek3BqzuWFGDonynHGyCL/f6UV7RwDkKsZ2Fr5v/LlBYHk78paQrmNBClv6N/esXTkh4gcZnlJYaI7Un2zo05R+jBRtlOSykoYV+FKOU0q10ZMMRBv5yJGnY6E9fe0UmHdsVHL9iZ7daPJglE8fJ111OdxKZ4Hhsc+kVmb0FbmWPALG9bgeAkb0S1MuqpLYAi/nHe+RXBb937YqfuJFcSfxI4EUQi5Flaz81tkRgyPQKZ3uxo3elbplQkLw6sNDgHXJgseDPgagtSfg1/jm8sqYXQrWHtCLFnD4e+8BD+JEeDTV9V2+LVk9keBKlEEObudklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tza6TURFB0LEhjB9fn0UYZjgM0RIyy7sryxxuTyGrbI=;
 b=pivG/pXz8qbqtZ0F9Y9X12/SyYV51zudQdrm2vpqH0odQ+k+n3L42ijcb587BYc9CWkRDXtj+FZ1lJB33vuw5/nEcaZ8XLt727rCY2+PrpA0Gvz18v+PtlPO1d0m0W9gTu+HIfRead/H2NREL+Zg9KbbNDVtkkQX0In4j/8N7zM=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5110.namprd02.prod.outlook.com (2603:10b6:a03:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 09:19:46 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::a1bc:4672:d6ab:d98b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::a1bc:4672:d6ab:d98b%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 09:19:45 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v6 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v6 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWGjCIIn+9iJ15EkSQK03grcWpOqiQgIkAgAjGvzA=
Date:   Tue, 5 May 2020 09:19:45 +0000
Message-ID: <BYAPR02MB5559A2524D33F73EE6AADBB5A5A70@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1587729844-20798-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1587729844-20798-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200429191452.5gu3nkljkfdrjvaw@bogus>
In-Reply-To: <20200429191452.5gu3nkljkfdrjvaw@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ce61c87-53fb-495c-c883-08d7f0d573ea
x-ms-traffictypediagnostic: BYAPR02MB5110:|BYAPR02MB5110:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB51102311040A0488129CB1F1A5A70@BYAPR02MB5110.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0epzk0eQOv23Rji8hXymQYW4ToSG/8eVOFxhTyq1eWn8ac8aZacczZ0yzsC/HIQbL9O8oSHUnWoTWLMkYx+Ae+Kx1IZkj3I9p6LHrGRQUGWyynclJw/bGQ+VKAw1XCFJqBVrF9g0FoyA3FyKf0EvZiFP2QIDNz7SeCKA35AAJYNMWYRld6G1uwaQhwUwB4xcv95GZMxxQ5tC5FJY2/sIx2EmNSF0E3duHQwGqe5pp+5a23D7C3j/Uuqa3H9+fBQbXt9Wa0peSCRZJGo0zJZIwJtvYqb8BnTy80a8d2OkS0adwaPl0Xj6Yh7ma5uYlwCrou/ACMYGxri7a5rqmIj9MwSpeaGgXyVC5BQ9Lk3iY4ReimL3D6kBa+V6J3Q35+XmyP5dS80hBJxNVYSOPV02BwNEf9DO8EtPxLugaLhSjx//g6046SktYW2Ucxrw5TdMAGSQXREoa3Ft3lhe9lPoRE9l5DkFQsy1riuj70RYzRUsBl2hHtRFn2OArKEDbFKpo3F6s9AsbkOAJjmNEwTPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(33430700001)(2906002)(86362001)(7696005)(33440700001)(107886003)(316002)(54906003)(9686003)(4326008)(66946007)(6916009)(64756008)(76116006)(478600001)(66556008)(66476007)(33656002)(5660300002)(186003)(30864003)(26005)(8936002)(8676002)(71200400001)(66446008)(52536014)(6506007)(55016002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G0aNqeLIiSIacz9J+330jOtUWqF87SCS9TxdvSg+Iepq8CHSs+s9BWEiOuzNEDTrNgpvniTHquXmthBsoMkksFOre9H8iOcQfS7SE5/ID+8qa8EsLSAeVdpldQrNO/+uSYVM0KvjuE3NyYQHEVNwkboJw0RiVxZXikHJZammvAk94DztpjZ3NszXGSZHEAgTsmAw/APDvb+aW0opj7sYDdUtyKFooHl1/fSD2DhBXCI4esGgTrPo4KhZKSpY6lGSXZ/DRmz21gwo5ZoEttYGAwKwQqG7flQ8wTKu1G08Nr9VCPXTEmEnzeDG+GTX+Q2Dc4PWySs0sIVa5utbjDsYrNTCtf6BVh9VmE7SL8I+D8ZebFXM0hWz7SlSvkKQX82YQPD40qHIyY0wv4O6HFPOAO183s9Jke+BW7NEltlc6zJ3bZGBaGeOWbGbBZh0WwjKKbylKF/d2rA4Sp9oK2K5t5icVT7Xf9hrf2j2kRspzlqJ+8RJ1mOByDuDGxrwPkT+w8c71k6sjRaRwaEBlE1dBXSVBWSI0Nz0maCx3yvGDUpFA4q0qn2F2dc2FlN4/gobhH3DprdZJu64C4124NfKyaHxhkDFXJxAZwA5lQop+rEjmjVq8OxSn01RAkeE59BFIhZ8MZvNkG1A+DdKc8/p/ukDBgaT78lg6Rqy4XdMP9B4coXqDRAx6sQYf1+o142IbRbyLfQ7WP9sOAYt0trPFCopGbiUQ/JvjE8NTgW+JRLK3jgH0dQWP/xm4JAR2vJzuugu6jOtEFpzoNN3llL57BqemWmWdBoD+043zliAkNg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce61c87-53fb-495c-c883-08d7f0d573ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 09:19:45.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FTCC7maczLCqrnxDXC+FxBHx1VkyFP73jxcaNGz8CXaKmBYreRQwTzl3/o8cAUxzKE2kQ6e8XmgWqq5+Ifrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5110
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Fri, Apr 24, 2020 at 05:34:04PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific MISC interrupt line.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/Kconfig           |   9 +
> >  drivers/pci/controller/Makefile          |   1 +
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 521
> > +++++++++++++++++++++++++++++++
> >  3 files changed, 531 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c
> >
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index 20bf00f..ca0ae24 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -81,6 +81,15 @@ config PCIE_XILINX
> >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> >  	  Host Bridge driver.
> >
> > +config PCIE_XILINX_CPM
> > +	bool "Xilinx Versal CPM host bridge support"
>=20
> Why can't this be a module?
Hi Rob, Thanks for your time. currently all host controller drivers are boo=
l, module support is removed.
>=20
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	select PCI_HOST_COMMON
> > +	help
> > +	  Say 'Y' here if you want kernel support for the
> > +	  Xilinx Versal CPM host bridge. The driver supports
> > +	  MSI/MSI-X interrupts using GICv3 ITS feature.
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
> > index 0000000..30ddec5
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -0,0 +1,521 @@
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
> > +#include <linux/pci-ecam.h>
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
> > +/**
> > + * struct xilinx_cpm_pcie_port - PCIe port information
> > + * @reg_base: Bridge Register Base
> > + * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> > + * @irq: Interrupt number
> > + * @root_busno: Root Bus number
> > + * @dev: Device pointer
> > + * @leg_domain: Legacy IRQ domain pointer
> > + * @irq_misc: Legacy and error interrupt number
> > + * @leg_mask_lock: lock for legacy interrupts  */ struct
> > +xilinx_cpm_pcie_port {
> > +	void __iomem *reg_base;
> > +	void __iomem *cpm_base;
> > +	u32 irq;
>=20
> Unused?
>=20
> > +	u8 root_busno;
>=20
> Shouldn't need this. The bus number gets stored in the bridge struct.
Okay, will remove this.
>=20
> > +	struct device *dev;
> > +	struct irq_domain *leg_domain;
> > +	struct pci_config_window *cfg;
> > +	int irq_misc;
> > +	raw_spinlock_t leg_mask_lock;
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
> > +static void xilinx_cpm_mask_leg_irq(struct irq_data *data) {
> > +	struct irq_desc *desc =3D irq_to_desc(data->irq);
> > +	struct xilinx_cpm_pcie_port *port;
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	port =3D irq_desc_get_chip_data(desc);
> > +	mask =3D (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
> > +	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	pcie_write(port, (val & (~mask)), XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags); }
> > +
> > +static void xilinx_cpm_unmask_leg_irq(struct irq_data *data) {
> > +	struct irq_desc *desc =3D irq_to_desc(data->irq);
> > +	struct xilinx_cpm_pcie_port *port;
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	port =3D irq_desc_get_chip_data(desc);
> > +	mask =3D (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
> > +	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags); }
> > +
> > +static struct irq_chip xilinx_cpm_leg_irq_chip =3D {
> > +	.name =3D "xilinx_cpm_pcie:legacy",
> > +	.irq_enable =3D xilinx_cpm_unmask_leg_irq,
> > +	.irq_disable =3D xilinx_cpm_mask_leg_irq,
> > +	.irq_mask =3D xilinx_cpm_mask_leg_irq,
> > +	.irq_unmask =3D xilinx_cpm_unmask_leg_irq, };
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
> > +	of_node_put(pcie_intc_node);
> > +	if (!port->leg_domain) {
> > +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	raw_spin_lock_init(&port->leg_mask_lock);
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
> > + * @bus_range: Bus resource
> > + *
> > + * Return: '0' on success and error value on failure  */ static int
> > +xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> > +				    struct resource *bus_range)
> > +{
> > +	struct device *dev =3D port->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct resource *res;
> > +	int err;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > +	if (res) {
>=20
> if (!res)
>   return -ENXIO;
>=20
> Less indentation and no need for 'else'.
Agreed, will fix this.
>=20
> > +		port->cfg =3D pci_ecam_create(dev, res, bus_range,
> > +					    &pci_generic_ecam_ops);
> > +		if (IS_ERR(port->cfg))
> > +			return PTR_ERR(port->cfg);
> > +	} else {
> > +		return -ENXIO;
> > +	}
> > +	port->reg_base =3D port->cfg->win;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +					   "cpm_slcr");
> > +	if (res) {
> > +		port->cpm_base =3D devm_ioremap_resource(dev, res);
>=20
> Use devm_platform_ioremap_resource_byname()
Agreed, will use this.
>=20
> > +		if (IS_ERR(port->cpm_base))
> > +			return PTR_ERR(port->cpm_base);
> > +	} else {
> > +		return -ENXIO;
> > +	}
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
> > +	struct resource *bus_range;
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
> > +	err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows,
> > +					      &bridge->dma_ranges,
> &bus_range);
> > +	if (err) {
> > +		dev_err(dev, "Getting bridge resources failed\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D xilinx_cpm_pcie_parse_dt(port, bus_range);
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
> > +	bridge->dev.parent =3D dev;
> > +	bridge->sysdata =3D port->cfg;
> > +	bridge->busnr =3D port->root_busno;
> > +	bridge->ops =3D &pci_generic_ecam_ops.pci_ops;
> > +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> > +	bridge->swizzle_irq =3D pci_common_swizzle;
> > +
>=20
>=20
> > +	err =3D pci_scan_root_bus_bridge(bridge);
> > +	if (err) {
> > +		irq_domain_remove(port->leg_domain);
> > +		devm_free_irq(dev, port->irq_misc, port);
> > +		return err;
> > +	}
> > +
> > +	bus =3D bridge->bus;
> > +
> > +	pci_assign_unassigned_bus_resources(bus);
> > +	list_for_each_entry(child, &bus->children, node)
> > +		pcie_bus_configure_settings(child);
> > +	pci_bus_add_devices(bus);
>=20
> All this can use pci_host_probe().
Agreed will use this API.
>=20
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
