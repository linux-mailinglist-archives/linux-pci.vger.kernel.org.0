Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA0187DEE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 11:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgCQKOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 06:14:49 -0400
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:20800
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbgCQKOs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 06:14:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMny3N0+KVqDHu+pEhVH+k5i/aAlrpB/09j6XbdlGomOcIL8qVqRZeadSjRmrIKA2kHoJCl2YdwHJrpYwzOvqm/sewnAdcxY+ikDNAEhAxsxycvTYbQZ6+PvVFsqqDGhg5xdfPzXq6l0eWCRoyMVBFg4oBq0S7YQaKqh74om5dFf8SGr8fwxeyo82G13FenDjftyV2Bb7KMHT5sppbXScWB8zfoyB/wHJ5qefR7MR39s/UHGUT0TWVek3Jpo5IybrfR8VDw+04EOwIzlpNC2Sqv7qxiDW21RLAEzcDV5KsjZ6lm71YredQXBvMMhF3GKEARlmxu1/N9BAyIydsy1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XmtuWXdmw92wQOC5V0vBeshHzT80BFMkZUKPPttbE0=;
 b=Wj1hccD9vbuSsxeuCQ4XLGdUD421JHOuB+aN6ZIw6VtUv5EUO0Xb7BIJOGQSsN12gjbK1+cE7tfduunVP5Tcx51lfkdavUyHGwWgIqvpoHHnHhLW2D+Pqm+UdOL4nBjc7oPLG9IIvFUppFoGvLmaMRFYxwem4gxQZaRiWFvZJ1isoAPNAOtSaVB8Sh0fVCaK5o70eo0/IjlTO7ljxy3/RYrGi7objmXgTbV0q0ii75qtkC+cMHQjdeSVhtabEELiXpOAo0MWCN7DwH3Ap4h8j26D8+rdzo3+8L5MTihlEPIQLWoMLm6P+DknD4GyfdKzw8wrIMOIgZ/cHZQMkd6MTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XmtuWXdmw92wQOC5V0vBeshHzT80BFMkZUKPPttbE0=;
 b=l4ZfgNHpcb2YHFLTb79BoA801cIn2dbSg1FsJEWTROxIFT6S0CDVJkg8ZQBvquPJZW86bX1K0kkZl7V6kVj3n50GmA440MgYcbkMwqvz3911Ft7bgW65SnwJzwFhBVmFvukqfy7Mhk7BoSVS+zwJ6ImWfiwEnVhGY3H9SHg84Zw=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB2454.jpnprd01.prod.outlook.com (52.134.253.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 10:14:40 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 10:14:40 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
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
Thread-Index: AQHV7k2o26WkjnS8fk2KjcbLYSuAj6hMqNeAgAABMfA=
Date:   Tue, 17 Mar 2020 10:14:39 +0000
Message-ID: <OSBPR01MB3590B241F5BBC991DE6ABED2AAF60@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB4544EAC877ADD0664CB93FF5D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB4544EAC877ADD0664CB93FF5D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17704d6a-1d79-4b15-b3e0-08d7ca5c012f
x-ms-traffictypediagnostic: OSBPR01MB2454:|OSBPR01MB2454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2454E859201518F88A24A03AAAF60@OSBPR01MB2454.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(199004)(316002)(110136005)(54906003)(2906002)(76116006)(4326008)(5660300002)(52536014)(33656002)(7416002)(66946007)(66476007)(64756008)(66446008)(8676002)(86362001)(7696005)(26005)(66556008)(186003)(71200400001)(8936002)(53546011)(81156014)(6506007)(478600001)(9686003)(81166006)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2454;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvUeP7XuG7nYNxUow8LB5GXbXo9FDhsBKRNQcwwPGK45t3GPvkFyKMFcsn2VPRmxtIeRue2lSo8jxqS96jEOTWeQUCym5/L3E8uNptUAT2RBPkGCJpgiQKuK0qtonbXJ+4gj+57fWhCVL1rk9LqFN985t+wFWdxqPf7gSAVtzMe6PYLFl3f03/+0GYUc3ZVBHl1BkW9p/+7Sp3NtBQnkS5da1HnsichhsEIhFfkT0FVtHc1R3XSWEl/YhlDTB52U3qI4/WnKeeRyrRs5vgTy5xvA9fcJK7eb0bGpO6WapxTfNknb9E5PhmdbPUjxYX8S/jFkgyiU10UNvGx2StQgSqUSWzx8085sFEmhY5gGVEqTnMuoqmcC4BOfjVt/LFL0a2jQBB7V7W2FJFzk0Ay8v4RjkwPEdJGccbCJxCxhosaAEK8RivSJoR3tV47BSLOo
x-ms-exchange-antispam-messagedata: 3PVgGe28oOVoyc1aWEX4gERuJpyO85sfo4L4uFkvZbwKYCaXIRdrGaYsDE4gnjst6yEa198kgCQW6Ju5mCHal4aoPd0+xTUaU+xaVvKgmvTSmqrbvPpUnNzSAQLTNf3NrCg4h/HGK25QO4ZpXoWWGQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17704d6a-1d79-4b15-b3e0-08d7ca5c012f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 10:14:39.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3vx+jtYPdzxrQAricawLILMFkEfQoOp0Fx/854yX8l6DqluH7KaYI83w1bwH9c6/sApaZvGB8RIL8YbsohMnsHxS0r05Yny77jZ7c7SnDRp97qkaGiNAKupYn5S5Vbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2454
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro-san,

Thank you for the review,

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 17 March 2020 09:59
> To: Lad Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Andrew Murray <andrew.murray@arm.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-renesas-soc@vger.kernel.org;
> linux-rockchip@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; Bjorn Helgaas <bhelgaas@google.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Jingoo Han
> <jingoohan1@gmail.com>; Gustavo Pimentel
> <gustavo.pimentel@synopsys.com>; Marek Vasut
> <marek.vasut+renesas@gmail.com>; Shawn Lin <shawn.lin@rock-
> chips.com>; Heiko Stuebner <heiko@sntech.de>
> Subject: RE: [PATCH v5 6/7] PCI: rcar: Add support for rcar PCIe controll=
er in
> endpoint mode
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
> >
> > This patch adds support for rcar PCIe controller to work in endpoint mo=
de.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> > ---
> >  drivers/pci/controller/Kconfig        |   8 +
> >  drivers/pci/controller/Makefile       |   1 +
> >  drivers/pci/controller/pcie-rcar-ep.c | 490
> ++++++++++++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.h    |   4 +
> >  4 files changed, 503 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
> >
> > diff --git a/drivers/pci/controller/Kconfig
> > b/drivers/pci/controller/Kconfig index 37e0ea7..9bf4b02 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -62,6 +62,14 @@ config PCIE_RCAR_HOST
> >    Say Y here if you want PCIe controller support on R-Car SoCs in host
> >    mode.
> >
> > +config PCIE_RCAR_EP
> > +bool "Renesas R-Car PCIe endpoint controller"
> > +depends on ARCH_RENESAS || COMPILE_TEST
> > +depends on PCI_ENDPOINT
> > +help
> > +  Say Y here if you want PCIe controller support on R-Car SoCs in
> > +  endpoint mode.
> > +
> >  config PCI_HOST_COMMON
> >  bool
> >  select PCI_ECAM
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile index b4ada32..067bd33 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
> >  obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
> >  obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
> >  obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar.o pcie-rcar-host.o
> > +obj-$(CONFIG_PCIE_RCAR_EP) +=3D pcie-rcar.o pcie-rcar-ep.o
> >  obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-common.o
> >  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
> >  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o diff --git
> > a/drivers/pci/controller/pcie-rcar-ep.c
> > b/drivers/pci/controller/pcie-rcar-ep.c
> > new file mode 100644
> > index 0000000..db89bbe
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-rcar-ep.c
> > @@ -0,0 +1,490 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe endpoint driver for Renesas R-Car SoCs
> > + *  Copyright (c) 2020 Renesas Electronics Europe GmbH
> > + *
> > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci-epc.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "pcie-rcar.h"
> > +
> > +/* Structure representing the PCIe interface */ struct rcar_pcie {
> > +phys_addr_t*ob_addr;
>
> I think "ob_mapped_addr" is better.
>
OK will rename that.

> > +struct pci_epc_mem_window *ob_window;
>
> I think we can get these windows from "array of address space of the
> endpoint controller" in struct pci_epc. If so, we can remove this member.
>
I shall see if this can be dropped.

> > +struct pci_epc*epc;
>
> This member can be removed like pcie-cadence-ep.c because this is not use=
d
> except saving the epc value from devm_pci_epc_create().
>
OK will drop it.

> <snip>
> > +static int rcar_pcie_ep_start(struct pci_epc *epc) {
> > +struct rcar_pcie *ep =3D epc_get_drvdata(epc);
> > +
> > +rcar_pci_write_reg(ep->base, CFINIT, PCIETCTLR);
>
> The following setting is needed before CFINIT like host.
>
> rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
>
I shall add this as part of rcar_pcie_ep_hw_init()

> > +
> > +return 0;
> > +}
> > +
> > +static void rcar_pcie_ep_stop(struct pci_epc *epc) {
> > +struct rcar_pcie *ep =3D epc_get_drvdata(epc);
> > +
> > +rcar_pci_write_reg(ep->base, 0, PCIETCTLR); }
> > +
> > +static const struct pci_epc_features rcar_pcie_epc_features =3D {
> > +.linkup_notifier =3D false,
> > +.msi_capable =3D false,
> > +.msix_capable =3D false,
> > +/* use 64-bit bars so mark bar1/3/5 as reserved */
> > +.reserved_bar =3D 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> > +.bar_fixed_64bit =3D  (1 << BAR_0) | (1 << BAR_2) | (1 << BAR_4),
>
> These parentheses are not needed like .reserved_bar.
>
Agreed.

> <snip>
> > +err =3D pci_epc_mem_init(epc, pcie->ob_window, pcie-
> >num_ob_windows);
> > +if (err < 0) {
> > +dev_err(dev, "failed to initialize the epc memory space\n");
> > +goto err_pm_put;
> > +}
> > +
> > +rcar_pcie_ep_hw_init(pcie);
>
> I'm not sure, but I wonder if we should call this hw init before
> pci_epc_mem_init().
>
Ideally shouldn't matter because in pci_epc_mem_init(), we just tell the fr=
amework
our windows properties.  But shall move hw_init() before mem_init().

> <snip>
> > +builtin_platform_driver(rcar_pcie_ep_driver);
> > diff --git a/drivers/pci/controller/pcie-rcar.h
> > b/drivers/pci/controller/pcie-rcar.h
> > index b529d806..5564ca8 100644
> > --- a/drivers/pci/controller/pcie-rcar.h
> > +++ b/drivers/pci/controller/pcie-rcar.h
> > @@ -17,6 +17,7 @@
> >  #define PCIECDR0x000020
> >  #define PCIEMSR0x000028
> >  #define PCIEINTXR0x000400
> > +#define  ASTINTX_SHIFTBIT(16)
>
> Just "ASTINTX" is better.
>
Shall replace it.

> >  #define PCIEPHYSR0x0007f0
> >  #define  PHYRDYBIT(0)
> >  #define PCIEMSITXR0x000840
> > @@ -55,12 +56,15 @@
> >
> >  /* Configuration */
> >  #define PCICONF(x)(0x010000 + ((x) * 0x4))
> > +#define  INTDIS_SHIFTBIT(10)
>
> Same here (we can remove "_SHIFT").
>
OK.

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
> >  #define PMCAP(x)(0x010040 + ((x) * 0x4))
> >  #define EXPCAP(x)(0x010070 + ((x) * 0x4))
> >  #define VCCAP(x)(0x010100 + ((x) * 0x4))
> >
> >  /* link layer */
> > +#define IDSETR00x011000
> >  #define IDSETR10x011004
> > +#define SUBIDSETR0x011024
> >  #define TLCTLR0x011048
> >  #define MACSR0x011054
> >  #define  SPCHGFINBIT(4)
> > --
> > 2.7.4



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
