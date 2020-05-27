Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2C1E4B6D
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE0RIf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 13:08:35 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:6061
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729783AbgE0RIf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 13:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkvC04zh8Yhg+kQV8Hf9yCpuLb2ojKWNGjqXp38lMS0NGCCiaJIQquaZM2/iBk5v1BK6p0nogephN4fZ+85qU5CbpwadmiCmFdIPb3Ilj46FiGMzcZhF6pUKddrdRcpyCgd6taLPxtel/rBvL7ILDXqYpP5cbg3prJgws/74un78ra9ASiLxbvZrM9vBE8xcSSbS78a/vqQ9KzMbY8eKjHH6rb3uic+HUF/CSgtFGDnKA7W10P9ooKakDGHyQ0HmMXkUrIRXgDhYM2WY0VX62YWLM2kyV2lrBCq8u8So5fyr5qkmS7FX1g/voayqEbJKzWjkSXGg4P2UMblVrbxmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX1tGcEKf8kpsTMRDzeT7GecGesq8msoQNWGD0CtiZ4=;
 b=dMNkApE1kBfSgSNcy4hGT4YGM7s0NnQ4r8WofJ3MzYr5se/xZ9LsAlkBFmgkehJWn7GKCIFwzlucCgDYo5WVZqylJzdnNgb5b9FSyLoFEGkVGfZ3k4JHwoeE5Pdi/lxwK6kJOBkGVxKlBSHcMhbBe6KiLslcXbK1pAhcQp1fhY5f2tj5GpCt9sW5c3BdhT5twAqYqK6RBauq3ZOw9AIFx43elWu7Ef+7KMNSY5vPbe/vdz2/uH0+24LVhFVsXzdbvFZ0kGK/WMtFXA2k9LzGo1j476/bKzkJawivhKwc7noeI3knzC8u7kLAdPZi7ojzpLC//dwidqeBAYJ2f0EzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX1tGcEKf8kpsTMRDzeT7GecGesq8msoQNWGD0CtiZ4=;
 b=VRTVRyCxOPO98gr1IWVHuRB+8ykhQ3AtMDS7eEoJEgDSkFMPacdL2Jdh+nqsXP0Gv3ILsrbO4Jg+mZRuN53MVLQjosuRCet3GXuGlyXDFeBVjKoRBvduEJfiOAvv39b8a4nKLGVZQqMfj+LhTf/9Cn7Uuq+xq86m0a3RLmpAcHw=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4054.namprd02.prod.outlook.com (2603:10b6:a02:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 17:08:22 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3045.016; Wed, 27 May 2020
 17:08:22 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWJGcFkx3tnPS0S0KeSN8z5DhGVai0WPmAgAfsDQA=
Date:   Wed, 27 May 2020 17:08:22 +0000
Message-ID: <BYAPR02MB55595603FADE80B67AD1372BA5B10@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1588852716-23132-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <07485a1859803d2e92b05a17835bd191@kernel.org>
In-Reply-To: <07485a1859803d2e92b05a17835bd191@kernel.org>
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
x-ms-office365-filtering-correlation-id: 630810c3-2910-4d41-09a9-08d802608ff6
x-ms-traffictypediagnostic: BYAPR02MB4054:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4054A817608A5519E4C83647A5B10@BYAPR02MB4054.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3b8OPCNP1oUbIa/sa9Hi7PUSLOX0tWKbCdB3yeBK2qjaf+b5nBVDquVrGpThOd+ZrEL2CJblNdRM1bA4RKoJ0aHB0RMScy/x9HLuGl7MYcprsfJuuWMtJrfzmIEgxv76gUq4D6L2aIVTazVKJ/xVh693UBPS9/FC5owNVUrAtHqzUXc9JvEgCpenX26/05PRvV93xS+veOGNX2UBUMo8U26QisfL8r9ozeTzEyUIv2S9EjrHHODYsMSCk/VmQusWTacTBsk1LvKeT52zlcJgLQFJjwxj3VIHgS2q53sIv41suw2K19BAv6Svt1f1akyLq/YQG6IcVbGL9A+0DfsCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(8936002)(71200400001)(4326008)(107886003)(52536014)(83380400001)(186003)(86362001)(9686003)(33656002)(8676002)(26005)(6916009)(55016002)(66556008)(2906002)(66446008)(30864003)(7696005)(64756008)(76116006)(54906003)(53546011)(5660300002)(66946007)(316002)(478600001)(66476007)(6506007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MjdEtBPTH2iWMiYbvbdDdduHkTkxBmecvbpBQLo9XYLN1RD2vGPVEW9QfZCodMd6lzEJI5JO+AzXDc6qtldvEIgVDA63pfUtWqejYsjOxAZwnCPNUI+0emjIy4JIuQbexZL27Nfc+7g9FIYV/bBjNij9NawUy1BrnXbY3bauAprILuB1sf0lnL+ibjmCHo+rDX5lpsHZx21mA/bGiHRl3dABpYG9A8TR4IRimKT0JaIttk8hywL+vxoPz7E5JoIc3bhZvxgFYk6UysZE6os3XHPLBUqZF/Cae2kysljDcQxDH6H30LVZ0v5XNmnbvjlJ+W/1XohNRtNO1eu8uh1vAR8j8gF2BCNPzSfyfSZBTo0YLp0swSwZmIs2Kqe5ppsG7KjlrAGFbGmqEpW4zyybQQxv0saYZUNFh2J+tS0u4vINQRFz+FMBTH0sLqla286VJYI5blTcdsbqVk+4Ju3NGIpVlCFHs4gPT2dRVr3GE6ozK7PS6MDudz7Hn2ViYqy4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630810c3-2910-4d41-09a9-08d802608ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 17:08:22.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9wcqCKnWLxjTPGZwWq8erFBPfOIKMHyoURLjwjLvIZfeaNQyg3qY1FnaVZPLpEqCshM/D/mOD6No9KwsnGWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4054
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Bharat,
>=20
> On 2020-05-07 12:58, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The
> > integrated
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific interrupt line.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/Kconfig           |   9 +
> >  drivers/pci/controller/Makefile          |   1 +
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 506
> > +++++++++++++++++++++++++++++++
> >  3 files changed, 516 insertions(+)
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
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	select PCI_HOST_COMMON
> > +	help
> > +	  Say 'Y' here if you want kernel support for the
> > +	  Xilinx Versal CPM host bridge. The driver supports
> > +	  MSI/MSI-X interrupts using GICv3 ITS feature.
>=20
> I don't think this last sentense makes any sense here. We usually don't
> mention things that the driver *doesn't* implement.
Agreed, will remove these details.
>=20
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
> > index 0000000..e8c0aa7
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -0,0 +1,506 @@
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
>=20
> I assume that this is the logical OR of all the XILINX_CPM_PCIE_INTR_* bi=
ts.
> Please express it as such.
Agreed, will change this.
>=20
> > +#define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
> > +#define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> > +#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
> > +#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
> > +#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
> > +#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
>=20
> So we have two definitions for bit 17... Given that nothing uses the MSI
> version, I assume it is useless...
>=20
> > +#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
>=20
> Please group all the XILINX_CPM_PCIE_INTR_* together.
>=20
Agreed, will change this.
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
> > + * @leg_domain: Legacy IRQ domain pointer
>=20
> leg, arm, thumb, limb... Given that oyu use the 'intx' description all ov=
er the
> driver, please be consistent and name this intx_domain.
>=20
> > + * @cfg: Holds mappings of config space window
> > + * @irq_misc: Legacy and error interrupt number
>=20
> Let's face it, this is the *only* interrupt this thing as, so the 'misc'
> is supperfluous.
>=20
> > + * @leg_mask_lock: lock for legacy interrupts  */ struct
> > +xilinx_cpm_pcie_port {
> > +	void __iomem *reg_base;
> > +	void __iomem *cpm_base;
> > +	struct device *dev;
> > +	struct irq_domain *leg_domain;
> > +	struct pci_config_window *cfg;
> > +	int irq_misc;
> > +	raw_spinlock_t leg_mask_lock;
> > +};
> > +
> > +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32
> > reg)
> > +{
> > +	return readl(port->reg_base + reg);
>=20
> There is no need for enforced ordering with non-device writes, so you can
> turn this into readl_relaxed. You can also drop the inline, as the compil=
er
> will do the right thing for you.
>
Agreed, will change to readl_relaxed.
=20
> > +}
> > +
> > +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> > +			      u32 val, u32 reg)
> > +{
> > +	writel(val, port->reg_base + reg);
>=20
> Same thing.
>=20
> > +}
> > +
> > +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port
> > +*port) {
> > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
>=20
> If you are making the return value a bool, you might as well return
> true/false. But that's a cumbersome way to write:
>=20
>          return pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
>                 XILINX_CPM_PCIE_REG_PSCR_LNKUP;
>=20
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
> > +	struct irq_desc *desc =3D irq_to_desc(data->irq);
> > +	struct xilinx_cpm_pcie_port *port;
> > +	unsigned long flags;
> > +	u32 mask;
> > +	u32 val;
> > +
> > +	port =3D irq_desc_get_chip_data(desc);
>=20
> port =3D irq_data_get_irq_chip_data(data);
>=20
> You should never have to get the irq_desc (and using irq_to_desc() is a
> prettyodd way to get it when you already have the irq_data).
>=20
> > +	mask =3D (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
>=20
> Also known as BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT).
>=20
> > +	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +	pcie_write(port, (val & (~mask)),
> XILINX_CPM_PCIE_REG_IDRN_MASK);
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
>=20
> "INTx" is a good enough description.
>=20
> > +	.irq_enable =3D xilinx_cpm_unmask_leg_irq,
> > +	.irq_disable =3D xilinx_cpm_mask_leg_irq,
> > +	.irq_mask =3D xilinx_cpm_mask_leg_irq,
> > +	.irq_unmask =3D xilinx_cpm_unmask_leg_irq,
>=20
> This makes no sense. If enable/disable have the same implementation as
> unmask/mask, then enable/disable is pretty useless. Please drop them.
>=20
Agreed, will drop these methods.
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
>=20
> There is a certain sense of repetition here. It really begs the question =
of
> *why* you want to take these interrupts if all you do is spam the console
> with warnings, not taking any action to potentially remedy the problem.
>=20
We use this information if user faces an issue to track down possible cause=
.=20
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
>=20
> That's a firm no. We don't demux chained handlers in an interrupt handler=
.
> It may work for now, but it will eventually break. And to be clear, this =
whole
> function needs to die. By the look of it, this PCie controller implements
> *TWO* interrupt multiplexers:
>=20
> - one that muxes all the ILINX_CPM_PCIE_INTR_* events onto a single top-
> level IRQ
> - another one that muxes all INTX lines onto XILINX_CPM_PCIE_INTR_INTX
>=20
> Please implement the whole thing as described above.
Agreed, thanks for resolving this.=20
>=20
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
>=20
> I'm pretty sure there is a slightly better way to write this...
>=20
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
> > +	port->leg_domain =3D irq_domain_add_linear(pcie_intc_node,
> > PCI_NUM_INTX,
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
> No. We don't enable interrupts randomly. They need a handler registered
> with the core IRq subsystem *first*, which is why this needs to be hooked=
 in
> as a proper irqchip, and each event handled individualy.
>=20
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
> > *port)
> > +{
> > +	struct device *dev =3D port->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int err;
> > +
> > +	port->irq_misc =3D platform_get_irq(pdev, 0);
> > +	if (port->irq_misc <=3D 0) {
>=20
> If 0 is an error, how do you distinguish it from the non-error case?
>=20
> > +		dev_err(dev, "Unable to find misc IRQ line\n");
> > +		return port->irq_misc;
> > +	}
> > +
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
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "cfg");
> > +	if (!res)
> > +		return -ENXIO;
> > +
> > +	port->cfg =3D pci_ecam_create(dev, res, bus_range,
> > +				    &pci_generic_ecam_ops);
> > +	if (IS_ERR(port->cfg))
> > +		return PTR_ERR(port->cfg);
> > +
> > +	port->reg_base =3D port->cfg->win;
> > +
> > +	port->cpm_base =3D devm_platform_ioremap_resource_byname(pdev,
> > +							       "cpm_slcr");
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
> > +	bridge->busnr =3D port->cfg->busr.start;
> > +	bridge->ops =3D &pci_generic_ecam_ops.pci_ops;
> > +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> > +	bridge->swizzle_irq =3D pci_common_swizzle;
> > +
> > +	err =3D pci_host_probe(bridge);
> > +	if (err < 0) {
> > +		irq_domain_remove(port->leg_domain);
> > +		devm_free_irq(dev, port->irq_misc, port);
>=20
> Why calling dem_free_irq()? The whole point of using devm* is not to have
> to manage the error handling.
>=20
> > +		return err;
> > +	}
> > +
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
>=20
> I don't think this driver is in a state where it can be merged. Given tha=
t we're
> already at v7 and to save everyone a bit of time, I've written the patch =
that
> implements the above comments. It compiles, but is probably broken.
> Hopefully you can test it and figure things out.
Hi Marc,
Thanks for your time and inputs.

Regards,
Bharat


>=20
>          M.
>=20
>  From 8b5d158374e59edf26e61c512eeb00ca7c9d891d Mon Sep 17 00:00:00
> 2001
>  From: Marc Zyngier <maz@kernel.org>
> Date: Fri, 22 May 2020 16:33:32 +0100
> Subject: [PATCH] PCI: xilinx-cpm: Revamp irq handling
>=20
> The xilinx-cpm driver missuses the IRQ layer in creative ways.
> It implements a chained interrupt demultiplexer inside a normal handler,
> enables interrupts randomly, and could overall do with a good cleanup.
>=20
> Instead, implement the IRQ support as two nested chained irqchips, the
> outer one dealing with all the PCIe events, the inner one namaging the IN=
Tx
> signals.
>=20
> Additionally, the whole driver is cleanup-up so that it can make a bit mo=
re
> sense to me. YMMV.
>=20
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/pci/controller/Kconfig           |   3 +-
>   drivers/pci/controller/pcie-xilinx-cpm.c | 427 ++++++++++++++---------
>   2 files changed, 263 insertions(+), 167 deletions(-)
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 1e0f63865775..d0abd671a7b6 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -87,8 +87,7 @@ config PCIE_XILINX_CPM
>   	select PCI_HOST_COMMON
>   	help
>   	  Say 'Y' here if you want kernel support for the
> -	  Xilinx Versal CPM host bridge. The driver supports
> -	  MSI/MSI-X interrupts using GICv3 ITS feature.
> +	  Xilinx Versal CPM host bridge.
>=20
>   config PCI_XGENE
>   	bool "X-Gene PCIe controller"
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> b/drivers/pci/controller/pcie-xilinx-cpm.c
> index e8c0aa757f72..32ed9e7e2676 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -5,8 +5,11 @@
>    * (C) Copyright 2019 - 2020, Xilinx, Inc.
>    */
>=20
> +#include <linux/bitfield.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
>   #include <linux/irqdomain.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -33,30 +36,55 @@
>   #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
>=20
>   /* Interrupt registers definitions */
> -#define XILINX_CPM_PCIE_INTR_LINK_DOWN		BIT(0)
> -#define XILINX_CPM_PCIE_INTR_HOT_RESET		BIT(3)
> -#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	BIT(8)
> -#define XILINX_CPM_PCIE_INTR_CORRECTABLE	BIT(9)
> -#define XILINX_CPM_PCIE_INTR_NONFATAL		BIT(10)
> -#define XILINX_CPM_PCIE_INTR_FATAL		BIT(11)
> -#define XILINX_CPM_PCIE_INTR_INTX		BIT(16)
> -#define XILINX_CPM_PCIE_INTR_MSI		BIT(17)
> -#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		BIT(20)
> -#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		BIT(21)
> -#define XILINX_CPM_PCIE_INTR_SLV_COMPL		BIT(22)
> -#define XILINX_CPM_PCIE_INTR_SLV_ERRP		BIT(23)
> -#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		BIT(24)
> -#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		BIT(25)
> -#define XILINX_CPM_PCIE_INTR_MST_DECERR		BIT(26)
> -#define XILINX_CPM_PCIE_INTR_MST_SLVERR		BIT(27)
> -#define XILINX_CPM_PCIE_IMR_ALL_MASK		0x1FF39FF9
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
> +#define IMR(x)	BIT(XILINX_CPM_PCIE_INTR_ ##x)
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
>   #define XILINX_CPM_PCIE_IDR_ALL_MASK		0xFFFFFFFF
>   #define XILINX_CPM_PCIE_IDRN_MASK		GENMASK(19, 16)
> -#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	BIT(4)
> -#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	BIT(12)
> -#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	BIT(15)
> -#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	BIT(17)
> -#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	BIT(28)
>   #define XILINX_CPM_PCIE_IDRN_SHIFT		16
>=20
>   /* Root Port Error FIFO Read Register definitions */ @@ -75,36 +103,37 =
@@
>    * @reg_base: Bridge Register Base
>    * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
>    * @dev: Device pointer
> - * @leg_domain: Legacy IRQ domain pointer
> + * @intx_domain: Legacy IRQ domain pointer
>    * @cfg: Holds mappings of config space window
> - * @irq_misc: Legacy and error interrupt number
> - * @leg_mask_lock: lock for legacy interrupts
> + * @irq: INTx and error interrupt number
> + * @lock: lock protecting shared register access
>    */
>   struct xilinx_cpm_pcie_port {
> -	void __iomem *reg_base;
> -	void __iomem *cpm_base;
> -	struct device *dev;
> -	struct irq_domain *leg_domain;
> -	struct pci_config_window *cfg;
> -	int irq_misc;
> -	raw_spinlock_t leg_mask_lock;
> +	void __iomem			*reg_base;
> +	void __iomem			*cpm_base;
> +	struct device			*dev;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*cpm_domain;
> +	struct pci_config_window	*cfg;
> +	int				irq;
> +	raw_spinlock_t			lock;
>   };
>=20
>   static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port, u32 reg)
>   {
> -	return readl(port->reg_base + reg);
> +	return readl_relaxed(port->reg_base + reg);
>   }
>=20
>   static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
>   			      u32 val, u32 reg)
>   {
> -	writel(val, port->reg_base + reg);
> +	writel_relaxed(val, port->reg_base + reg);
>   }
>=20
>   static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port *port)
>   {
>   	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> -		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP);
>   }
>=20
>   /**
> @@ -125,44 +154,56 @@ static void cpm_pcie_clear_err_interrupts(struct
> xilinx_cpm_pcie_port *port)
>=20
>   static void xilinx_cpm_mask_leg_irq(struct irq_data *data)
>   {
> -	struct irq_desc *desc =3D irq_to_desc(data->irq);
> -	struct xilinx_cpm_pcie_port *port;
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_data_get_irq_chip_data(data);
>   	unsigned long flags;
>   	u32 mask;
>   	u32 val;
>=20
> -	port =3D irq_desc_get_chip_data(desc);
> -	mask =3D (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
> -	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> +	mask =3D BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
>   	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
>   	pcie_write(port, (val & (~mask)),
> XILINX_CPM_PCIE_REG_IDRN_MASK);
> -	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
>   }
>=20
>   static void xilinx_cpm_unmask_leg_irq(struct irq_data *data)
>   {
> -	struct irq_desc *desc =3D irq_to_desc(data->irq);
> -	struct xilinx_cpm_pcie_port *port;
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_data_get_irq_chip_data(data);
>   	unsigned long flags;
>   	u32 mask;
>   	u32 val;
>=20
> -	port =3D irq_desc_get_chip_data(desc);
> -	mask =3D (1 << data->hwirq) << XILINX_CPM_PCIE_IDRN_SHIFT;
> -	raw_spin_lock_irqsave(&port->leg_mask_lock, flags);
> +	mask =3D BIT(data->hwirq + XILINX_CPM_PCIE_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
>   	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN_MASK);
>   	pcie_write(port, (val | mask), XILINX_CPM_PCIE_REG_IDRN_MASK);
> -	raw_spin_unlock_irqrestore(&port->leg_mask_lock, flags);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
>   }
>=20
>   static struct irq_chip xilinx_cpm_leg_irq_chip =3D {
> -	.name =3D "xilinx_cpm_pcie:legacy",
> -	.irq_enable =3D xilinx_cpm_unmask_leg_irq,
> -	.irq_disable =3D xilinx_cpm_mask_leg_irq,
> -	.irq_mask =3D xilinx_cpm_mask_leg_irq,
> -	.irq_unmask =3D xilinx_cpm_unmask_leg_irq,
> +	.name		=3D "INTx",
> +	.irq_mask	=3D xilinx_cpm_mask_leg_irq,
> +	.irq_unmask	=3D xilinx_cpm_unmask_leg_irq,
>   };
>=20
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
>   /**
>    * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and mark IRQ=
 as
> valid
>    * @domain: IRQ domain
> @@ -187,111 +228,130 @@ static const struct irq_domain_ops
> intx_domain_ops =3D {
>   	.map =3D xilinx_cpm_pcie_intx_map,
>   };
>=20
> -/**
> - * xilinx_cpm_pcie_intr_handler - Interrupt Service Handler
> - * @irq: IRQ number
> - * @data: PCIe port information
> - *
> - * Return: IRQ_HANDLED on success and IRQ_NONE on failure
> - */
> -static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data)
> +static void xilinx_cpm_mask_event_irq(struct irq_data *d)
>   {
> -	struct xilinx_cpm_pcie_port *port =3D data;
> -	struct device *dev =3D port->dev;
> -	u32 val, mask, status, bit;
> -	unsigned long intr_val;
> -
> -	/* Read interrupt decode and mask registers */
> -	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> -	mask =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> -
> -	status =3D val & mask;
> -	if (!status)
> -		return IRQ_NONE;
> -
> -	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
> -		dev_warn(dev, "Link Down\n");
> -
> -	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
> -		dev_info(dev, "Hot reset\n");
> -
> -	if (status & XILINX_CPM_PCIE_INTR_CFG_TIMEOUT)
> -		dev_warn(dev, "ECAM access timeout\n");
> -
> -	if (status & XILINX_CPM_PCIE_INTR_CORRECTABLE) {
> -		dev_warn(dev, "Correctable error message\n");
> -		cpm_pcie_clear_err_interrupts(port);
> -	}
> -
> -	if (status & XILINX_CPM_PCIE_INTR_NONFATAL) {
> -		dev_warn(dev, "Non fatal error message\n");
> -		cpm_pcie_clear_err_interrupts(port);
> -	}
> -
> -	if (status & XILINX_CPM_PCIE_INTR_FATAL) {
> -		dev_warn(dev, "Fatal error message\n");
> -		cpm_pcie_clear_err_interrupts(port);
> -	}
> -
> -	if (status & XILINX_CPM_PCIE_INTR_INTX) {
> -		/* Handle INTx Interrupt */
> -		intr_val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDRN);
> -		intr_val =3D intr_val >> XILINX_CPM_PCIE_IDRN_SHIFT;
> -
> -		for_each_set_bit(bit, &intr_val, PCI_NUM_INTX)
> -			generic_handle_irq(irq_find_mapping(port-
> >leg_domain,
> -							    bit));
> -	}
> -
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_UNSUPP)
> -		dev_warn(dev, "Slave unsupported request\n");
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_UNEXP)
> -		dev_warn(dev, "Slave unexpected completion\n");
> +	struct xilinx_cpm_pcie_port *port =3D irq_data_get_irq_chip_data(d);
> +	u32 val;
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_COMPL)
> -		dev_warn(dev, "Slave completion timeout\n");
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	val &=3D ~d->hwirq;
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_ERRP)
> -		dev_warn(dev, "Slave Error Poison\n");
> +static void xilinx_cpm_unmask_event_irq(struct irq_data *d) {
> +	struct xilinx_cpm_pcie_port *port =3D irq_data_get_irq_chip_data(d);
> +	u32 val;
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_CMPABT)
> -		dev_warn(dev, "Slave Completer Abort\n");
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +	val |=3D d->hwirq;
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_ILLBUR)
> -		dev_warn(dev, "Slave Illegal Burst\n");
> +static struct irq_chip xilinx_cpm_event_irq_chip =3D {
> +	.name		=3D "RC-Event",
> +	.irq_mask	=3D xilinx_cpm_mask_event_irq,
> +	.irq_unmask	=3D xilinx_cpm_unmask_event_irq,
> +};
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_MST_DECERR)
> -		dev_warn(dev, "Master decode error\n");
> +static int xilinx_cpm_pcie_event_map(struct irq_domain *domain,
> +				    unsigned int irq, irq_hw_number_t hwirq)
> {
> +	irq_set_chip_and_handler(irq, &xilinx_cpm_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_MST_SLVERR)
> -		dev_warn(dev, "Master slave error\n");
> +	return 0;
> +}
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT)
> -		dev_warn(dev, "PCIe ECAM access timeout\n");
> +static const struct irq_domain_ops event_domain_ops =3D {
> +	.map =3D xilinx_cpm_pcie_event_map,
> +};
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_CFG_ERR_POISON)
> -		dev_warn(dev, "ECAM poisoned completion received\n");
> +static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc) {
> +	struct xilinx_cpm_pcie_port *port =3D
> irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD)
> -		dev_warn(dev, "PME_TO_ACK message received\n");
> +	chained_irq_enter(chip, desc);
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_PM_PME_RCVD)
> -		dev_warn(dev, "PM_PME message received\n");
> +	val =3D  pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> +	val &=3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
>=20
> -	if (status & XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT)
> -		dev_warn(dev, "PCIe completion timeout received\n");
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_irq(irq_find_mapping(port->cpm_domain,
> i));
>=20
>   	/* Clear the Interrupt Decode register */
> -	pcie_write(port, status, XILINX_CPM_PCIE_REG_IDR);
> +	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
>=20
>   	/*
>   	 * XILINX_CPM_PCIE_MISC_IR_STATUS register is mapped to
>   	 * CPM SLCR block.
>   	 */
> -	val =3D readl(port->cpm_base + XILINX_CPM_PCIE_MISC_IR_STATUS);
> +	val =3D readl_relaxed(port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
>   	if (val)
> -		writel(val, port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> +		writel_relaxed(val, port->cpm_base +
> XILINX_CPM_PCIE_MISC_IR_STATUS);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +#define _IC(x, s)				\
> +	[XILINX_CPM_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> +
> +static const struct {
> +	const char	*sym;
> +	const char	*str;
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
> +	switch(d->hwirq) {
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
> +			dev_warn(dev, "Unknown interrupt\n");
> +	}
>=20
>   	return IRQ_HANDLED;
>   }
> @@ -315,17 +375,41 @@ static int xilinx_cpm_pcie_init_irq_domain(struct
> xilinx_cpm_pcie_port *port)
>   		return -EINVAL;
>   	}
>=20
> -	port->leg_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
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
>   						 &intx_domain_ops,
>   						 port);
> +	if (!port->intx_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(port->intx_domain,
> DOMAIN_BUS_WIRED);
> +
>   	of_node_put(pcie_intc_node);
> -	if (!port->leg_domain) {
> -		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return -ENOMEM;
> -	}
> +	raw_spin_lock_init(&port->lock);
>=20
> -	raw_spin_lock_init(&port->leg_mask_lock);
>   	return 0;
> +
> +out:
> +	of_node_put(pcie_intc_node);
> +	if (port->intx_domain) {
> +		irq_domain_remove(port->intx_domain);
> +		port->intx_domain =3D NULL;
> +	}
> +
> +	if (port->cpm_domain) {
> +		irq_domain_remove(port->cpm_domain);
> +		port->cpm_domain =3D NULL;
> +	}
> +
> +	dev_err(dev, "Failed to allocate IRQ domains\n");
> +	return -ENOMEM;
>   }
>=20
>   /**
> @@ -348,12 +432,6 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie_port *port)
>   		   XILINX_CPM_PCIE_IMR_ALL_MASK,
>   		   XILINX_CPM_PCIE_REG_IDR);
>=20
> -	/* Enable all interrupts */
> -	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> -		   XILINX_CPM_PCIE_REG_IMR);
> -	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> -		   XILINX_CPM_PCIE_REG_IDRN_MASK);
> -
>   	/*
>   	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
>   	 * CPM SLCR block.
> @@ -366,28 +444,45 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie_port *port)
>   		   XILINX_CPM_PCIE_REG_RPSC);
>   }
>=20
> -static int xilinx_cpm_request_misc_irq(struct xilinx_cpm_pcie_port
> *port)
> +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
>   {
>   	struct device *dev =3D port->dev;
>   	struct platform_device *pdev =3D to_platform_device(dev);
> -	int err;
> +	int i, irq;
>=20
> -	port->irq_misc =3D platform_get_irq(pdev, 0);
> -	if (port->irq_misc <=3D 0) {
> -		dev_err(dev, "Unable to find misc IRQ line\n");
> -		return port->irq_misc;
> +	port->irq =3D platform_get_irq(pdev, 0);
> +	if (port->irq < 0) {
> +		dev_err(dev, "Unable to find IRQ line\n");
> +		return port->irq;
>   	}
>=20
> -	err =3D devm_request_irq(dev, port->irq_misc,
> -			       xilinx_cpm_pcie_intr_handler,
> -			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       "xilinx-pcie", port);
> -	if (err) {
> -		dev_err(dev, "unable to request misc IRQ line %d\n",
> -			port->irq_misc);
> -		return err;
> +	for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		int err;
> +
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq =3D irq_create_mapping(port->cpm_domain, i);
> +		if (WARN_ON(irq <=3D 0))
> +			return -ENXIO;
> +
> +		err =3D devm_request_irq(dev, irq,
> xilinx_cpm_pcie_intr_handler,
> +				       0, intr_cause[i].sym, port);
> +		if (WARN_ON(err))
> +			return err;
>   	}
>=20
> +	irq =3D irq_create_mapping(port->cpm_domain,
> XILINX_CPM_PCIE_INTR_INTX);
> +	if (WARN_ON(irq <=3D 0))
> +		return -ENXIO;
> +
> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(irq, xilinx_cpm_pcie_intx_flow,
> port);
> +
> +	/* Plug the main event chained handler */
> +	irq_set_chained_handler_and_data(port->irq,
> xilinx_cpm_pcie_event_flow,
> +					 port);
> +
>   	return 0;
>   }
>=20
> @@ -422,7 +517,7 @@ static int xilinx_cpm_pcie_parse_dt(struct
> xilinx_cpm_pcie_port *port,
>   	if (IS_ERR(port->cpm_base))
>   		return PTR_ERR(port->cpm_base);
>=20
> -	err =3D xilinx_cpm_request_misc_irq(port);
> +	err =3D xilinx_cpm_setup_irq(port);
>   	if (err)
>   		return err;
>=20
> @@ -481,8 +576,10 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
>=20
>   	err =3D pci_host_probe(bridge);
>   	if (err < 0) {
> -		irq_domain_remove(port->leg_domain);
> -		devm_free_irq(dev, port->irq_misc, port);
> +		if (port->intx_domain)
> +			irq_domain_remove(port->intx_domain);
> +		if (port->cpm_domain)
> +			irq_domain_remove(port->cpm_domain);
>   		return err;
>   	}
>=20
> --
> 2.26.2
>=20
>=20
> --
> Jazz is not dead. It just smells funny...
