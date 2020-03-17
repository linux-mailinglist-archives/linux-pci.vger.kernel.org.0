Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375C5187B3E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 09:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgCQI30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 04:29:26 -0400
Received: from mail-eopbgr1400102.outbound.protection.outlook.com ([40.107.140.102]:32845
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgCQI3Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 04:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EODR3Rhkb7l1V/w7e2bZ6D2jLGYZoKRyKVrsaRuIC16k+SUUB/vb4ByPnsNO1j5mYVqddwwKzCHelpsV2xV1stFJJAuyxobeREPZC7MR8fwdjOzKdiepnZnZRipQIQCi50EQrwHizeql2iHQF83qnmkXJUtNoigk3bmHT7hVAZORCl9orlwjvUBpls176xqOBEdPfXF/PyP/xxgj/hL4l8Si5nDAXmvP9QZf2316JUVOaXKmR9ooiac8ZwUR82DPA2cm4q/43y1tuacmENyzvkQNYXn9aVCf3hO9NLc4d7DgYoZm+t2O0eP5OO9qqLW0XYLp5j2J/P4+My40bsS9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+hb1wGoS9Gc8Is/SOw//s41JqYi9EiKPzZM2BMYz5o=;
 b=acpT6igvqX8M5VUmu70HrfaRTnraKfvBOeaoGrsPWOE+B5h5DNZAs9jHHYqJ1PxRtE1qaa9wyMHzO1rxeXKj0Zp6T0aDzDDu1E9WToTx+b4WNVPyoOq5xm7ZNfdjMQHQEgPPPwx27BRzCiCEJaUFF2LHHpT4CC/H3NyZ3pNJn4M6yLnp4iplfxgC9YQcMCS+apza0txyxbQWxUSx1wDMV1KdBDLZTmu8tMLk/nfLP44YdIx++9ZjUizCQKy3TGuR/ut66GWS44D4Iu6iMKhvKoPR+hru5ozMoCPdBl0FFbPIObXyBgG/UVNZAwrnzJU6zD9ZF8xC5DxVERwRDJ+Lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+hb1wGoS9Gc8Is/SOw//s41JqYi9EiKPzZM2BMYz5o=;
 b=hontv9zwaWVfWEsrstkAnGwkPfDqL1sVQK591v1rxX/oc6vzpYIY0z/G1/pkHvswyupWDUW9xyqn1EKZvKNY2ghCzpBlYEACG53sfgN898aj+cBj2wFc7kcTxIuqmRVa05JOEoyNoOdx5lbCbdKTDbcJI+o7xaQ9fE4wxDlZUic=
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com (20.178.97.80) by
 OSBPR01MB2616.jpnprd01.prod.outlook.com (52.134.253.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 08:29:17 +0000
Received: from OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b]) by OSBPR01MB3590.jpnprd01.prod.outlook.com
 ([fe80::490:aa83:2d09:3a0b%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:29:17 +0000
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
Subject: RE: [PATCH v5 2/7] PCI: rcar: Move shareable code to a common file
Thread-Topic: [PATCH v5 2/7] PCI: rcar: Move shareable code to a common file
Thread-Index: AQHV7k2coenBQgwOOESYP68l9QNRTahMfTGAgAASLqA=
Date:   Tue, 17 Mar 2020 08:29:17 +0000
Message-ID: <OSBPR01MB3590A81511AD004519F1A20BAAF60@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB45444A34A4B2DC6F8594EABFD8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45444A34A4B2DC6F8594EABFD8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.mahadev-lad.rj@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82c7292b-7b64-44f5-ed78-08d7ca4d489a
x-ms-traffictypediagnostic: OSBPR01MB2616:|OSBPR01MB2616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB261662ABDFE001710DEC867DAAF60@OSBPR01MB2616.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(81166006)(86362001)(81156014)(7416002)(5660300002)(55016002)(4326008)(7696005)(316002)(8936002)(8676002)(9686003)(71200400001)(52536014)(30864003)(478600001)(54906003)(186003)(2906002)(66556008)(66946007)(64756008)(110136005)(76116006)(53546011)(66446008)(26005)(33656002)(6506007)(66476007)(579004)(559001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2616;H:OSBPR01MB3590.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7O/wElT0VrGzY6QE0JYh16qFznYp+xsZpXAi4jLmd0Gtx3sCNVUNJHkpGEVaeuTMXy1KaLG5ZPS2AGenW6FqHdX8wCs8jJQocDysYMERO99GuIJE1GXPdPlXCQp7vrnlYqSNpn9yuic/CexIWk/I8N6iMsFe0OL4FMMQkhq9AKJxZm97+VCftKyca5Nv8sbnSfrJYt2lAVxjlZbNfzu2qovtKEnEnquhSjJQeObu+3mgRF96OUqoefZ0kM12PBf52rPewbhY43F2VH+xeFvcpWxA2S1AACQV1lRM1fBR7Z2CfxMADXYtTREa1OVwhdOXS5kNIYBb5TOh2QU932RmEIzZ84U+ab8SvF6anOb0sFJ2o+1p08mURcQ1z2lq5KaM0iMwLRcgiA1TdrXT4z9V7P/E6muVJGkWiU/nj8ikHvkFsZMTY92KA3zOM24U445H
x-ms-exchange-antispam-messagedata: D/CtWk7aTLGvWdY/zO+R6DCoPTWyTaX74LCyLVKpAoCcNPp8pChgOD24AwtDqtY4Ju4sz7ZSu9d1feZwshiEE8RZZl4CiaLTomF9xYa+uL3wHnjc1NvvfbsnTc07sXoYg39QACgaTzYfzCEpM5KyTw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c7292b-7b64-44f5-ed78-08d7ca4d489a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 08:29:17.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rz04nIy0ZF9C2HybcO8zaH70YAPB2DqyaSLFYoTTbNtaEp4tSvgib2n1SlCRQJugTTmhSFq9HTDpR2qy8lAoCXQBEEUbp3860b+Iv2Fs74s71bKYx+pmk8PF43cB1hdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2616
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro-san,

Thank you for the review.

> -----Original Message-----
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Sent: 17 March 2020 07:23
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
> Subject: RE: [PATCH v5 2/7] PCI: rcar: Move shareable code to a common fi=
le
>
> Hi Prabhakar-san,
>
> Thank you for the patch!
>
> > From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
> >
> > This patch moves sharable code to common file pcie-rcar.c and the
> > #defines to pcie-rcar.h so that the common code can be reused with
> endpoint driver.
> > There are no functional changes with this patch for the host
> > controller driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> > ---
> >  drivers/pci/controller/Makefile         |   2 +-
> >  drivers/pci/controller/pcie-rcar-host.c | 358 ++++++++----------------=
--------
> >  drivers/pci/controller/pcie-rcar.c      | 117 +++++++++++
> >  drivers/pci/controller/pcie-rcar.h      | 125 +++++++++++
> >  4 files changed, 324 insertions(+), 278 deletions(-)  create mode
> > 100644 drivers/pci/controller/pcie-rcar.c
> >  create mode 100644 drivers/pci/controller/pcie-rcar.h
> >
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile index 4ca2da6..b4ada32 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_MVEBU) +=3D pci-mvebu.o
> >  obj-$(CONFIG_PCI_AARDVARK) +=3D pci-aardvark.o
> >  obj-$(CONFIG_PCI_TEGRA) +=3D pci-tegra.o
> >  obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
> > -obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar-host.o
> > +obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar.o pcie-rcar-host.o
> >  obj-$(CONFIG_PCI_HOST_COMMON) +=3D pci-host-common.o
> >  obj-$(CONFIG_PCI_HOST_GENERIC) +=3D pci-host-generic.o
> >  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o diff --git
> > a/drivers/pci/controller/pcie-rcar-host.c
> > b/drivers/pci/controller/pcie-rcar-host.c
> > index 759c654..93f22d8 100644
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * PCIe driver for Renesas R-Car SoCs
> > - *  Copyright (C) 2014 Renesas Electronics Europe Ltd
> > + *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
> >   *
> >   * Based on:
> >   *  arch/sh/drivers/pci/pcie-sh7786.c @@ -30,104 +30,7 @@  #include
> > <linux/pm_runtime.h>  #include <linux/slab.h>
> >
> > -#define PCIECAR0x000010
> > -#define PCIECCTLR0x000018
> > -#define  CONFIG_SEND_ENABLEBIT(31)
> > -#define  TYPE0(0 << 8)
> > -#define  TYPE1BIT(8)
> > -#define PCIECDR0x000020
> > -#define PCIEMSR0x000028
> > -#define PCIEINTXR0x000400
> > -#define PCIEPHYSR0x0007f0
> > -#define  PHYRDYBIT(0)
> > -#define PCIEMSITXR0x000840
> > -
> > -/* Transfer control */
> > -#define PCIETCTLR0x02000
> > -#define  DL_DOWNBIT(3)
> > -#define  CFINITBIT(0)
> > -#define PCIETSTR0x02004
> > -#define  DATA_LINK_ACTIVEBIT(0)
> > -#define PCIEERRFR0x02020
> > -#define  UNSUPPORTED_REQUESTBIT(4)
> > -#define PCIEMSIFR0x02044
> > -#define PCIEMSIALR0x02048
> > -#define  MSIFEBIT(0)
> > -#define PCIEMSIAUR0x0204c
> > -#define PCIEMSIIER0x02050
> > -
> > -/* root port address */
> > -#define PCIEPRAR(x)(0x02080 + ((x) * 0x4))
> > -
> > -/* local address reg & mask */
> > -#define PCIELAR(x)(0x02200 + ((x) * 0x20))
> > -#define PCIELAMR(x)(0x02208 + ((x) * 0x20))
> > -#define  LAM_PREFETCHBIT(3)
> > -#define  LAM_64BITBIT(2)
> > -#define  LAR_ENABLEBIT(1)
> > -
> > -/* PCIe address reg & mask */
> > -#define PCIEPALR(x)(0x03400 + ((x) * 0x20))
> > -#define PCIEPAUR(x)(0x03404 + ((x) * 0x20))
> > -#define PCIEPAMR(x)(0x03408 + ((x) * 0x20))
> > -#define PCIEPTCTLR(x)(0x0340c + ((x) * 0x20))
> > -#define  PAR_ENABLEBIT(31)
> > -#define  IO_SPACEBIT(8)
> > -
> > -/* Configuration */
> > -#define PCICONF(x)(0x010000 + ((x) * 0x4))
> > -#define PMCAP(x)(0x010040 + ((x) * 0x4))
> > -#define EXPCAP(x)(0x010070 + ((x) * 0x4))
> > -#define VCCAP(x)(0x010100 + ((x) * 0x4))
> > -
> > -/* link layer */
> > -#define IDSETR10x011004
> > -#define TLCTLR0x011048
> > -#define MACSR0x011054
> > -#define  SPCHGFINBIT(4)
> > -#define  SPCHGFAILBIT(6)
> > -#define  SPCHGSUCBIT(7)
> > -#define  LINK_SPEED(0xf << 16)
> > -#define  LINK_SPEED_2_5GTS(1 << 16)
> > -#define  LINK_SPEED_5_0GTS(2 << 16)
> > -#define MACCTLR0x011058
> > -#define  MACCTLR_NFTS_MASKGENMASK(23, 16)/* The name
> is from SH7786 */
> > -#define  SPEED_CHANGEBIT(24)
> > -#define  SCRAMBLE_DISABLEBIT(27)
> > -#define  LTSMDISBIT(31)
> > -#define  MACCTLR_INIT_VAL(LTSMDIS | MACCTLR_NFTS_MASK)
> > -#define PMSR0x01105c
> > -#define MACS2R0x011078
> > -#define MACCGSPSETR0x011084
> > -#define  SPCNGRSNBIT(31)
> > -
> > -/* R-Car H1 PHY */
> > -#define H1_PCIEPHYADRR0x04000c
> > -#define  WRITE_CMDBIT(16)
> > -#define  PHY_ACKBIT(24)
> > -#define  RATE_POS12
> > -#define  LANE_POS8
> > -#define  ADR_POS0
> > -#define H1_PCIEPHYDOUTR0x040014
> > -
> > -/* R-Car Gen2 PHY */
> > -#define GEN2_PCIEPHYADDR0x780
> > -#define GEN2_PCIEPHYDATA0x784
> > -#define GEN2_PCIEPHYCTRL0x78c
> > -
> > -#define INT_PCI_MSI_NR32
> > -
> > -#define RCONF(x)(PCICONF(0) + (x))
> > -#define RPMCAP(x)(PMCAP(0) + (x))
> > -#define REXPCAP(x)(EXPCAP(0) + (x))
> > -#define RVCCAP(x)(VCCAP(0) + (x))
> > -
> > -#define PCIE_CONF_BUS(b)(((b) & 0xff) << 24)
> > -#define PCIE_CONF_DEV(d)(((d) & 0x1f) << 19)
> > -#define PCIE_CONF_FUNC(f)(((f) & 0x7) << 16)
> > -
> > -#define RCAR_PCI_MAX_RESOURCES4
> > -#define MAX_NR_INBOUND_MAPS6
> > +#include "pcie-rcar.h"
> >
> >  struct rcar_msi {
> >  DECLARE_BITMAP(used, INT_PCI_MSI_NR); @@ -155,36 +58,10 @@
> struct
> > rcar_pcie {
> >  structrcar_msi msi;
> >  };
> >
> > -static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val,
> > -       unsigned int reg)
> > -{
> > -writel(val, pcie->base + reg);
> > -}
> > -
> > -static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, unsigned int
> > reg) -{
> > -return readl(pcie->base + reg);
> > -}
> > -
> > -enum {
> > -RCAR_PCI_ACCESS_READ,
> > -RCAR_PCI_ACCESS_WRITE,
> > -};
> > -
> > -static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask,
> > u32 data) -{
> > -unsigned int shift =3D BITS_PER_BYTE * (where & 3);
> > -u32 val =3D rcar_pci_read_reg(pcie, where & ~3);
> > -
> > -val &=3D ~(mask << shift);
> > -val |=3D data << shift;
> > -rcar_pci_write_reg(pcie, val, where & ~3);
> > -}
> > -
> >  static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)  {
> >  unsigned int shift =3D BITS_PER_BYTE * (where & 3);
> > -u32 val =3D rcar_pci_read_reg(pcie, where & ~3);
> > +u32 val =3D rcar_pci_read_reg(pcie->base, where & ~3);
>
> I'd like to avoid these many changes about "pcie" to "pcie->base" somehow=
.
> My idea is moving declaration of struct rcar_pcie to rcar-pcie.h and use =
it
> from both host and ep codes. According to the patch 6/7, the rcar-pcie-ep=
.c
> also has the same name of struct rcar_pcie and this has the same "base" a=
nd
> "dev.
> So, common rcar_pcie should have these members. Remaining members are
> contained on renamed structures like "rcar_pcie_host" and "rcar_pcie_ep".
> And then, the rcar_pcie_{host,ep} have struct rcar_pcie pcie member.
>
Agreed will do that.

Cheers,
--Prabhakar

> Best regards,
> Yoshihiro Shimoda
>
> >  return val >> shift;
> >  }
> > @@ -221,13 +98,13 @@ static int rcar_pcie_config_access(struct rcar_pci=
e
> *pcie,
> >  return PCIBIOS_DEVICE_NOT_FOUND;
> >
> >  if (access_type =3D=3D RCAR_PCI_ACCESS_READ) {
> > -*data =3D rcar_pci_read_reg(pcie, PCICONF(index));
> > +*data =3D rcar_pci_read_reg(pcie->base,
> PCICONF(index));
> >  } else {
> >  /* Keep an eye out for changes to the root bus
> number */
> >  if (pci_is_root_bus(bus) && (reg =3D=3D
> PCI_PRIMARY_BUS))
> >  pcie->root_bus_nr =3D *data & 0xff;
> >
> > -rcar_pci_write_reg(pcie, *data, PCICONF(index));
> > +rcar_pci_write_reg(pcie->base, *data,
> PCICONF(index));
> >  }
> >
> >  return PCIBIOS_SUCCESSFUL;
> > @@ -237,20 +114,23 @@ static int rcar_pcie_config_access(struct rcar_pc=
ie
> *pcie,
> >  return PCIBIOS_DEVICE_NOT_FOUND;
> >
> >  /* Clear errors */
> > -rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR),
> PCIEERRFR);
> > +rcar_pci_write_reg(pcie->base, rcar_pci_read_reg(pcie->base,
> PCIEERRFR),
> > +   PCIEERRFR);
> >
> >  /* Set the PIO address */
> > -rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
> > +rcar_pci_write_reg(pcie->base, PCIE_CONF_BUS(bus->number) |
> >  PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg,
> PCIECAR);
> >
> >  /* Enable the configuration access */
> >  if (bus->parent->number =3D=3D pcie->root_bus_nr)
> > -rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0,
> PCIECCTLR);
> > +rcar_pci_write_reg(pcie->base, CONFIG_SEND_ENABLE |
> TYPE0,
> > +   PCIECCTLR);
> >  else
> > -rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1,
> PCIECCTLR);
> > +rcar_pci_write_reg(pcie->base, CONFIG_SEND_ENABLE |
> TYPE1,
> > +   PCIECCTLR);
> >
> >  /* Check for errors */
> > -if (rcar_pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
> > +if (rcar_pci_read_reg(pcie->base, PCIEERRFR) &
> UNSUPPORTED_REQUEST)
> >  return PCIBIOS_DEVICE_NOT_FOUND;
> >
> >  /* Check for master and target aborts */ @@ -259,12 +139,12 @@
> > static int rcar_pcie_config_access(struct rcar_pcie *pcie,
> >  return PCIBIOS_DEVICE_NOT_FOUND;
> >
> >  if (access_type =3D=3D RCAR_PCI_ACCESS_READ)
> > -*data =3D rcar_pci_read_reg(pcie, PCIECDR);
> > +*data =3D rcar_pci_read_reg(pcie->base, PCIECDR);
> >  else
> > -rcar_pci_write_reg(pcie, *data, PCIECDR);
> > +rcar_pci_write_reg(pcie->base, *data, PCIECDR);
> >
> >  /* Disable the configuration access */
> > -rcar_pci_write_reg(pcie, 0, PCIECCTLR);
> > +rcar_pci_write_reg(pcie->base, 0, PCIECCTLR);
> >
> >  return PCIBIOS_SUCCESSFUL;
> >  }
> > @@ -332,41 +212,6 @@ static struct pci_ops rcar_pcie_ops =3D {
> >  .write=3D rcar_pcie_write_conf,
> >  };
> >
> > -static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
> > -   struct resource *res)
> > -{
> > -/* Setup PCIe address space mappings for each resource */
> > -resource_size_t size;
> > -resource_size_t res_start;
> > -u32 mask;
> > -
> > -rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> > -
> > -/*
> > - * The PAMR mask is calculated in units of 128Bytes, which
> > - * keeps things pretty simple.
> > - */
> > -size =3D resource_size(res);
> > -mask =3D (roundup_pow_of_two(size) / SZ_128) - 1;
> > -rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
> > -
> > -if (res->flags & IORESOURCE_IO)
> > -res_start =3D pci_pio_to_address(res->start);
> > -else
> > -res_start =3D res->start;
> > -
> > -rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
> > -rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
> > -   PCIEPALR(win));
> > -
> > -/* First resource is for IO */
> > -mask =3D PAR_ENABLE;
> > -if (res->flags & IORESOURCE_IO)
> > -mask |=3D IO_SPACE;
> > -
> > -rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
> > -}
> > -
> >  static int rcar_pcie_setup(struct list_head *resource, struct
> > rcar_pcie *pci)  {
> >  struct resource_entry *win;
> > @@ -382,7 +227,7 @@ static int rcar_pcie_setup(struct list_head
> *resource, struct rcar_pcie *pci)
> >  switch (resource_type(res)) {
> >  case IORESOURCE_IO:
> >  case IORESOURCE_MEM:
> > -rcar_pcie_setup_window(i, pci, res);
> > +rcar_pcie_set_outbound(i, pci->base, res);
> >  i++;
> >  break;
> >  case IORESOURCE_BUS:
> > @@ -404,37 +249,38 @@ static void rcar_pcie_force_speedup(struct
> rcar_pcie *pcie)
> >  unsigned int timeout =3D 1000;
> >  u32 macsr;
> >
> > -if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) !=3D
> LINK_SPEED_5_0GTS)
> > +if ((rcar_pci_read_reg(pcie->base, MACS2R) & LINK_SPEED) !=3D
> > +LINK_SPEED_5_0GTS)
> >  return;
> >
> > -if (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE) {
> > +if (rcar_pci_read_reg(pcie->base, MACCTLR) & SPEED_CHANGE) {
> >  dev_err(dev, "Speed change already in progress\n");
> >  return;
> >  }
> >
> > -macsr =3D rcar_pci_read_reg(pcie, MACSR);
> > +macsr =3D rcar_pci_read_reg(pcie->base, MACSR);
> >  if ((macsr & LINK_SPEED) =3D=3D LINK_SPEED_5_0GTS)
> >  goto done;
> >
> >  /* Set target link speed to 5.0 GT/s */
> > -rcar_rmw32(pcie, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
> > +rcar_rmw32(pcie->base, EXPCAP(12), PCI_EXP_LNKSTA_CLS,
> >     PCI_EXP_LNKSTA_CLS_5_0GB);
> >
> >  /* Set speed change reason as intentional factor */
> > -rcar_rmw32(pcie, MACCGSPSETR, SPCNGRSN, 0);
> > +rcar_rmw32(pcie->base, MACCGSPSETR, SPCNGRSN, 0);
> >
> >  /* Clear SPCHGFIN, SPCHGSUC, and SPCHGFAIL */
> >  if (macsr & (SPCHGFIN | SPCHGSUC | SPCHGFAIL))
> > -rcar_pci_write_reg(pcie, macsr, MACSR);
> > +rcar_pci_write_reg(pcie->base, macsr, MACSR);
> >
> >  /* Start link speed change */
> > -rcar_rmw32(pcie, MACCTLR, SPEED_CHANGE, SPEED_CHANGE);
> > +rcar_rmw32(pcie->base, MACCTLR, SPEED_CHANGE,
> SPEED_CHANGE);
> >
> >  while (timeout--) {
> > -macsr =3D rcar_pci_read_reg(pcie, MACSR);
> > +macsr =3D rcar_pci_read_reg(pcie->base, MACSR);
> >  if (macsr & SPCHGFIN) {
> >  /* Clear the interrupt bits */
> > -rcar_pci_write_reg(pcie, macsr, MACSR);
> > +rcar_pci_write_reg(pcie->base, macsr, MACSR);
> >
> >  if (macsr & SPCHGFAIL)
> >  dev_err(dev, "Speed change failed\n"); @@
> -498,7 +344,7 @@ static
> > int phy_wait_for_ack(struct rcar_pcie *pcie)
> >  unsigned int timeout =3D 100;
> >
> >  while (timeout--) {
> > -if (rcar_pci_read_reg(pcie, H1_PCIEPHYADRR) & PHY_ACK)
> > +if (rcar_pci_read_reg(pcie->base, H1_PCIEPHYADRR) &
> PHY_ACK)
> >  return 0;
> >
> >  udelay(100);
> > @@ -521,60 +367,31 @@ static void phy_write_reg(struct rcar_pcie *pcie,
> >  ((addr & 0xff) << ADR_POS);
> >
> >  /* Set write data */
> > -rcar_pci_write_reg(pcie, data, H1_PCIEPHYDOUTR);
> > -rcar_pci_write_reg(pcie, phyaddr, H1_PCIEPHYADRR);
> > +rcar_pci_write_reg(pcie->base, data, H1_PCIEPHYDOUTR);
> > +rcar_pci_write_reg(pcie->base, phyaddr, H1_PCIEPHYADRR);
> >
> >  /* Ignore errors as they will be dealt with if the data link is down *=
/
> >  phy_wait_for_ack(pcie);
> >
> >  /* Clear command */
> > -rcar_pci_write_reg(pcie, 0, H1_PCIEPHYDOUTR);
> > -rcar_pci_write_reg(pcie, 0, H1_PCIEPHYADRR);
> > +rcar_pci_write_reg(pcie->base, 0, H1_PCIEPHYDOUTR);
> > +rcar_pci_write_reg(pcie->base, 0, H1_PCIEPHYADRR);
> >
> >  /* Ignore errors as they will be dealt with if the data link is down *=
/
> >  phy_wait_for_ack(pcie);
> >  }
> >
> > -static int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie) -{
> > -unsigned int timeout =3D 10;
> > -
> > -while (timeout--) {
> > -if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
> > -return 0;
> > -
> > -msleep(5);
> > -}
> > -
> > -return -ETIMEDOUT;
> > -}
> > -
> > -static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie) -{
> > -unsigned int timeout =3D 10000;
> > -
> > -while (timeout--) {
> > -if ((rcar_pci_read_reg(pcie, PCIETSTR) &
> DATA_LINK_ACTIVE))
> > -return 0;
> > -
> > -udelay(5);
> > -cpu_relax();
> > -}
> > -
> > -return -ETIMEDOUT;
> > -}
> > -
> >  static int rcar_pcie_hw_init(struct rcar_pcie *pcie)  {
> >  int err;
> >
> >  /* Begin initialization */
> > -rcar_pci_write_reg(pcie, 0, PCIETCTLR);
> > +rcar_pci_write_reg(pcie->base, 0, PCIETCTLR);
> >
> >  /* Set mode */
> > -rcar_pci_write_reg(pcie, 1, PCIEMSR);
> > +rcar_pci_write_reg(pcie->base, 1, PCIEMSR);
> >
> > -err =3D rcar_pcie_wait_for_phyrdy(pcie);
> > +err =3D rcar_pcie_wait_for_phyrdy(pcie->base);
> >  if (err)
> >  return err;
> >
> > @@ -583,51 +400,51 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pc=
ie)
> >   * class to match. Hardware takes care of propagating the IDSETR
> >   * settings, so there is no need to bother with a quirk.
> >   */
> > -rcar_pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
> > +rcar_pci_write_reg(pcie->base, PCI_CLASS_BRIDGE_PCI << 16,
> IDSETR1);
> >
> >  /*
> >   * Setup Secondary Bus Number & Subordinate Bus Number, even
> though
> >   * they aren't used, to avoid bridge being detected as broken.
> >   */
> > -rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
> > -rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
> > +rcar_rmw32(pcie->base, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
> > +rcar_rmw32(pcie->base, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
> >
> >  /* Initialize default capabilities. */
> > -rcar_rmw32(pcie, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
> > -rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
> > -PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
> > -rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
> > -PCI_HEADER_TYPE_BRIDGE);
> > +rcar_rmw32(pcie->base, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
> > +rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_FLAGS),
> > +   PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
> > +rcar_rmw32(pcie->base, RCONF(PCI_HEADER_TYPE), 0x7f,
> > +   PCI_HEADER_TYPE_BRIDGE);
> >
> >  /* Enable data link layer active state reporting */
> > -rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP),
> PCI_EXP_LNKCAP_DLLLARC,
> > -PCI_EXP_LNKCAP_DLLLARC);
> > +rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_LNKCAP),
> PCI_EXP_LNKCAP_DLLLARC,
> > +   PCI_EXP_LNKCAP_DLLLARC);
> >
> >  /* Write out the physical slot number =3D 0 */
> > -rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP),
> PCI_EXP_SLTCAP_PSN, 0);
> > +rcar_rmw32(pcie->base, REXPCAP(PCI_EXP_SLTCAP),
> PCI_EXP_SLTCAP_PSN,
> > +0);
> >
> >  /* Set the completion timer timeout to the maximum 50ms. */
> > -rcar_rmw32(pcie, TLCTLR + 1, 0x3f, 50);
> > +rcar_rmw32(pcie->base, TLCTLR + 1, 0x3f, 50);
> >
> >  /* Terminate list of capabilities (Next Capability Offset=3D0) */
> > -rcar_rmw32(pcie, RVCCAP(0), 0xfff00000, 0);
> > +rcar_rmw32(pcie->base, RVCCAP(0), 0xfff00000, 0);
> >
> >  /* Enable MSI */
> >  if (IS_ENABLED(CONFIG_PCI_MSI))
> > -rcar_pci_write_reg(pcie, 0x801f0000, PCIEMSITXR);
> > +rcar_pci_write_reg(pcie->base, 0x801f0000, PCIEMSITXR);
> >
> > -rcar_pci_write_reg(pcie, MACCTLR_INIT_VAL, MACCTLR);
> > +rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
> >
> >  /* Finish initialization - establish a PCI Express link */
> > -rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> > +rcar_pci_write_reg(pcie->base, CFINIT, PCIETCTLR);
> >
> >  /* This will timeout if we don't have a link. */
> > -err =3D rcar_pcie_wait_for_dl(pcie);
> > +err =3D rcar_pcie_wait_for_dl(pcie->base);
> >  if (err)
> >  return err;
> >
> >  /* Enable INTx interrupts */
> > -rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
> > +rcar_rmw32(pcie->base, PCIEINTXR, 0, 0xF << 8);
> >
> >  wmb();
> >
> > @@ -663,16 +480,16 @@ static int rcar_pcie_phy_init_gen2(struct
> rcar_pcie *pcie)
> >   * These settings come from the R-Car Series, 2nd Generation User's
> >   * Manual, section 50.3.1 (2) Initialization of the physical layer.
> >   */
> > -rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
> > -rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
> > -rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
> > -rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
> > +rcar_pci_write_reg(pcie->base, 0x000f0030, GEN2_PCIEPHYADDR);
> > +rcar_pci_write_reg(pcie->base, 0x00381203, GEN2_PCIEPHYDATA);
> > +rcar_pci_write_reg(pcie->base, 0x00000001, GEN2_PCIEPHYCTRL);
> > +rcar_pci_write_reg(pcie->base, 0x00000006, GEN2_PCIEPHYCTRL);
> >
> > -rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
> > +rcar_pci_write_reg(pcie->base, 0x000f0054, GEN2_PCIEPHYADDR);
> >  /* The following value is for DC connection, no termination resistor
> */
> > -rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
> > -rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
> > -rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
> > +rcar_pci_write_reg(pcie->base, 0x13802007, GEN2_PCIEPHYDATA);
> > +rcar_pci_write_reg(pcie->base, 0x00000001, GEN2_PCIEPHYCTRL);
> > +rcar_pci_write_reg(pcie->base, 0x00000006, GEN2_PCIEPHYCTRL);
> >
> >  return 0;
> >  }
> > @@ -735,7 +552,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void
> *data)
> >  struct device *dev =3D pcie->dev;
> >  unsigned long reg;
> >
> > -reg =3D rcar_pci_read_reg(pcie, PCIEMSIFR);
> > +reg =3D rcar_pci_read_reg(pcie->base, PCIEMSIFR);
> >
> >  /* MSI & INTx share an interrupt - we only handle MSI here */
> >  if (!reg)
> > @@ -746,7 +563,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void
> *data)
> >  unsigned int msi_irq;
> >
> >  /* clear the interrupt */
> > -rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
> > +rcar_pci_write_reg(pcie->base, 1 << index, PCIEMSIFR);
> >
> >  msi_irq =3D irq_find_mapping(msi->domain, index);
> >  if (msi_irq) {
> > @@ -760,7 +577,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void
> *data)
> >  }
> >
> >  /* see if there's any more pending in this vector */
> > -reg =3D rcar_pci_read_reg(pcie, PCIEMSIFR);
> > +reg =3D rcar_pci_read_reg(pcie->base, PCIEMSIFR);
> >  }
> >
> >  return IRQ_HANDLED;
> > @@ -787,8 +604,8 @@ static int rcar_msi_setup_irq(struct
> > msi_controller *chip, struct pci_dev *pdev,
> >
> >  irq_set_msi_desc(irq, desc);
> >
> > -msg.address_lo =3D rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
> > -msg.address_hi =3D rcar_pci_read_reg(pcie, PCIEMSIAUR);
> > +msg.address_lo =3D rcar_pci_read_reg(pcie->base, PCIEMSIALR) &
> ~MSIFE;
> > +msg.address_hi =3D rcar_pci_read_reg(pcie->base, PCIEMSIAUR);
> >  msg.data =3D hwirq;
> >
> >  pci_write_msi_msg(irq, &msg);
> > @@ -839,8 +656,8 @@ static int rcar_msi_setup_irqs(struct msi_controlle=
r
> *chip,
> >  desc->nvec_used =3D nvec;
> >  desc->msi_attrib.multiple =3D order_base_2(nvec);
> >
> > -msg.address_lo =3D rcar_pci_read_reg(pcie, PCIEMSIALR) & ~MSIFE;
> > -msg.address_hi =3D rcar_pci_read_reg(pcie, PCIEMSIAUR);
> > +msg.address_lo =3D rcar_pci_read_reg(pcie->base, PCIEMSIALR) &
> ~MSIFE;
> > +msg.address_hi =3D rcar_pci_read_reg(pcie->base, PCIEMSIAUR);
> >  msg.data =3D hwirq;
> >
> >  pci_write_msi_msg(irq, &msg);
> > @@ -940,11 +757,11 @@ static int rcar_pcie_enable_msi(struct rcar_pcie
> *pcie)
> >  }
> >  base =3D virt_to_phys((void *)msi->pages);
> >
> > -rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
> > -rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
> > +rcar_pci_write_reg(pcie->base, lower_32_bits(base) | MSIFE,
> PCIEMSIALR);
> > +rcar_pci_write_reg(pcie->base, upper_32_bits(base), PCIEMSIAUR);
> >
> >  /* enable all MSI interrupts */
> > -rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
> > +rcar_pci_write_reg(pcie->base, 0xffffffff, PCIEMSIIER);
> >
> >  return 0;
> >
> > @@ -958,10 +775,10 @@ static void rcar_pcie_teardown_msi(struct
> rcar_pcie *pcie)
> >  struct rcar_msi *msi =3D &pcie->msi;
> >
> >  /* Disable all MSI interrupts */
> > -rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
> > +rcar_pci_write_reg(pcie->base, 0, PCIEMSIIER);
> >
> >  /* Disable address decoding of the MSI interrupt, MSIFE */
> > -rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
> > +rcar_pci_write_reg(pcie->base, 0, PCIEMSIALR);
> >
> >  free_pages(msi->pages, 0);
> >
> > @@ -1054,21 +871,8 @@ static int rcar_pcie_inbound_ranges(struct
> rcar_pcie *pcie,
> >  mask =3D roundup_pow_of_two(size) - 1;
> >  mask &=3D ~0xf;
> >
> > -/*
> > - * Set up 64-bit inbound regions as the range parser doesn't
> > - * distinguish between 32 and 64-bit types.
> > - */
> > -rcar_pci_write_reg(pcie, lower_32_bits(pci_addr),
> > -   PCIEPRAR(idx));
> > -rcar_pci_write_reg(pcie, lower_32_bits(cpu_addr),
> PCIELAR(idx));
> > -rcar_pci_write_reg(pcie, lower_32_bits(mask) | flags,
> > -   PCIELAMR(idx));
> > -
> > -rcar_pci_write_reg(pcie, upper_32_bits(pci_addr),
> > -   PCIEPRAR(idx + 1));
> > -rcar_pci_write_reg(pcie, upper_32_bits(cpu_addr),
> > -   PCIELAR(idx + 1));
> > -rcar_pci_write_reg(pcie, 0, PCIELAMR(idx + 1));
> > +rcar_pcie_set_inbound(pcie->base, cpu_addr, pci_addr,
> > +      lower_32_bits(mask) | flags, idx, true);
> >
> >  pci_addr +=3D size;
> >  cpu_addr +=3D size;
> > @@ -1170,7 +974,7 @@ static int rcar_pcie_probe(struct platform_device
> *pdev)
> >  goto err_phy_shutdown;
> >  }
> >
> > -data =3D rcar_pci_read_reg(pcie, MACSR);
> > +data =3D rcar_pci_read_reg(pcie->base, MACSR);
> >  dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
> >
> >  if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > @@ -1223,14 +1027,14 @@ static int rcar_pcie_resume_noirq(struct
> > device *dev)  {
> >  struct rcar_pcie *pcie =3D dev_get_drvdata(dev);
> >
> > -if (rcar_pci_read_reg(pcie, PMSR) &&
> > -    !(rcar_pci_read_reg(pcie, PCIETCTLR) & DL_DOWN))
> > +if (rcar_pci_read_reg(pcie->base, PMSR) &&
> > +    !(rcar_pci_read_reg(pcie->base, PCIETCTLR) & DL_DOWN))
> >  return 0;
> >
> >  /* Re-establish the PCIe link */
> > -rcar_pci_write_reg(pcie, MACCTLR_INIT_VAL, MACCTLR);
> > -rcar_pci_write_reg(pcie, CFINIT, PCIETCTLR);
> > -return rcar_pcie_wait_for_dl(pcie);
> > +rcar_pci_write_reg(pcie->base, MACCTLR_INIT_VAL, MACCTLR);
> > +rcar_pci_write_reg(pcie->base, CFINIT, PCIETCTLR);
> > +return rcar_pcie_wait_for_dl(pcie->base);
> >  }
> >
> >  static const struct dev_pm_ops rcar_pcie_pm_ops =3D { diff --git
> > a/drivers/pci/controller/pcie-rcar.c
> > b/drivers/pci/controller/pcie-rcar.c
> > new file mode 100644
> > index 0000000..41275f9
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-rcar.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe driver for Renesas R-Car SoCs
> > + *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
> > + *
> > + * Author: Phil Edworthy <phil.edworthy@renesas.com>  */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/pci.h>
> > +
> > +#include "pcie-rcar.h"
> > +
> > +void rcar_pci_write_reg(void __iomem *base, u32 val, unsigned int
> > +reg) {
> > +writel(val, base + reg);
> > +}
> > +
> > +u32 rcar_pci_read_reg(void __iomem *base, unsigned int reg) {
> > +return readl(base + reg);
> > +}
> > +
> > +void rcar_rmw32(void __iomem *base, int where, u32 mask, u32 data) {
> > +unsigned int shift =3D BITS_PER_BYTE * (where & 3);
> > +u32 val =3D rcar_pci_read_reg(base, where & ~3);
> > +
> > +val &=3D ~(mask << shift);
> > +val |=3D data << shift;
> > +rcar_pci_write_reg(base, val, where & ~3); }
> > +
> > +int rcar_pcie_wait_for_phyrdy(void __iomem *base) {
> > +unsigned int timeout =3D 10;
> > +
> > +while (timeout--) {
> > +if (rcar_pci_read_reg(base, PCIEPHYSR) & PHYRDY)
> > +return 0;
> > +
> > +msleep(5);
> > +}
> > +
> > +return -ETIMEDOUT;
> > +}
> > +
> > +int rcar_pcie_wait_for_dl(void __iomem *base) {
> > +unsigned int timeout =3D 10000;
> > +
> > +while (timeout--) {
> > +if ((rcar_pci_read_reg(base, PCIETSTR) &
> DATA_LINK_ACTIVE))
> > +return 0;
> > +
> > +udelay(5);
> > +cpu_relax();
> > +}
> > +
> > +return -ETIMEDOUT;
> > +}
> > +
> > +void rcar_pcie_set_outbound(int win, void __iomem *base,
> > +    struct resource *res)
> > +{
> > +/* Setup PCIe address space mappings for each resource */
> > +resource_size_t res_start;
> > +resource_size_t size;
> > +u32 mask;
> > +
> > +rcar_pci_write_reg(base, 0x00000000, PCIEPTCTLR(win));
> > +
> > +/*
> > + * The PAMR mask is calculated in units of 128Bytes, which
> > + * keeps things pretty simple.
> > + */
> > +size =3D resource_size(res);
> > +mask =3D (roundup_pow_of_two(size) / SZ_128) - 1;
> > +rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
> > +
> > +if (res->flags & IORESOURCE_IO)
> > +res_start =3D pci_pio_to_address(res->start);
> > +else
> > +res_start =3D res->start;
> > +
> > +rcar_pci_write_reg(base, upper_32_bits(res_start), PCIEPAUR(win));
> > +rcar_pci_write_reg(base, lower_32_bits(res_start) & ~0x7F,
> > +   PCIEPALR(win));
> > +
> > +/* First resource is for IO */
> > +mask =3D PAR_ENABLE;
> > +if (res->flags & IORESOURCE_IO)
> > +mask |=3D IO_SPACE;
> > +
> > +rcar_pci_write_reg(base, mask, PCIEPTCTLR(win)); }
> > +
> > +void rcar_pcie_set_inbound(void __iomem *base,
> > +   u64 cpu_addr, u64 pci_addr,
> > +   u64 flags, int idx, bool host)
> > +{
> > +/*
> > + * Set up 64-bit inbound regions as the range parser doesn't
> > + * distinguish between 32 and 64-bit types.
> > + */
> > +if (host)
> > +rcar_pci_write_reg(base, lower_32_bits(pci_addr),
> > +   PCIEPRAR(idx));
> > +rcar_pci_write_reg(base, lower_32_bits(cpu_addr), PCIELAR(idx));
> > +rcar_pci_write_reg(base, flags, PCIELAMR(idx));
> > +
> > +if (host)
> > +rcar_pci_write_reg(base, upper_32_bits(pci_addr),
> > +   PCIEPRAR(idx + 1));
> > +rcar_pci_write_reg(base, upper_32_bits(cpu_addr), PCIELAR(idx +
> 1));
> > +rcar_pci_write_reg(base, 0, PCIELAMR(idx + 1)); }
> > diff --git a/drivers/pci/controller/pcie-rcar.h
> > b/drivers/pci/controller/pcie-rcar.h
> > new file mode 100644
> > index 0000000..b529d806
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-rcar.h
> > @@ -0,0 +1,125 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * PCIe driver for Renesas R-Car SoCs
> > + *  Copyright (C) 2014-2020 Renesas Electronics Europe Ltd
> > + *
> > + * Author: Phil Edworthy <phil.edworthy@renesas.com>  */
> > +
> > +#ifndef _PCIE_RCAR_H
> > +#define _PCIE_RCAR_H
> > +
> > +#define PCIECAR0x000010
> > +#define PCIECCTLR0x000018
> > +#define  CONFIG_SEND_ENABLEBIT(31)
> > +#define  TYPE0(0 << 8)
> > +#define  TYPE1BIT(8)
> > +#define PCIECDR0x000020
> > +#define PCIEMSR0x000028
> > +#define PCIEINTXR0x000400
> > +#define PCIEPHYSR0x0007f0
> > +#define  PHYRDYBIT(0)
> > +#define PCIEMSITXR0x000840
> > +
> > +/* Transfer control */
> > +#define PCIETCTLR0x02000
> > +#define  DL_DOWNBIT(3)
> > +#define  CFINITBIT(0)
> > +#define PCIETSTR0x02004
> > +#define  DATA_LINK_ACTIVEBIT(0)
> > +#define PCIEERRFR0x02020
> > +#define  UNSUPPORTED_REQUESTBIT(4)
> > +#define PCIEMSIFR0x02044
> > +#define PCIEMSIALR0x02048
> > +#define  MSIFEBIT(0)
> > +#define PCIEMSIAUR0x0204c
> > +#define PCIEMSIIER0x02050
> > +
> > +/* root port address */
> > +#define PCIEPRAR(x)(0x02080 + ((x) * 0x4))
> > +
> > +/* local address reg & mask */
> > +#define PCIELAR(x)(0x02200 + ((x) * 0x20))
> > +#define PCIELAMR(x)(0x02208 + ((x) * 0x20))
> > +#define  LAM_PREFETCHBIT(3)
> > +#define  LAM_64BITBIT(2)
> > +#define  LAR_ENABLEBIT(1)
> > +
> > +/* PCIe address reg & mask */
> > +#define PCIEPALR(x)(0x03400 + ((x) * 0x20))
> > +#define PCIEPAUR(x)(0x03404 + ((x) * 0x20))
> > +#define PCIEPAMR(x)(0x03408 + ((x) * 0x20))
> > +#define PCIEPTCTLR(x)(0x0340c + ((x) * 0x20))
> > +#define  PAR_ENABLEBIT(31)
> > +#define  IO_SPACEBIT(8)
> > +
> > +/* Configuration */
> > +#define PCICONF(x)(0x010000 + ((x) * 0x4))
> > +#define PMCAP(x)(0x010040 + ((x) * 0x4))
> > +#define EXPCAP(x)(0x010070 + ((x) * 0x4))
> > +#define VCCAP(x)(0x010100 + ((x) * 0x4))
> > +
> > +/* link layer */
> > +#define IDSETR10x011004
> > +#define TLCTLR0x011048
> > +#define MACSR0x011054
> > +#define  SPCHGFINBIT(4)
> > +#define  SPCHGFAILBIT(6)
> > +#define  SPCHGSUCBIT(7)
> > +#define  LINK_SPEED(0xf << 16)
> > +#define  LINK_SPEED_2_5GTS(1 << 16)
> > +#define  LINK_SPEED_5_0GTS(2 << 16)
> > +#define MACCTLR0x011058
> > +#define  MACCTLR_NFTS_MASKGENMASK(23, 16)/* The name
> is from SH7786 */
> > +#define  SPEED_CHANGEBIT(24)
> > +#define  SCRAMBLE_DISABLEBIT(27)
> > +#define  LTSMDISBIT(31)
> > +#define  MACCTLR_INIT_VAL(LTSMDIS | MACCTLR_NFTS_MASK)
> > +#define PMSR0x01105c
> > +#define MACS2R0x011078
> > +#define MACCGSPSETR0x011084
> > +#define  SPCNGRSNBIT(31)
> > +
> > +/* R-Car H1 PHY */
> > +#define H1_PCIEPHYADRR0x04000c
> > +#define  WRITE_CMDBIT(16)
> > +#define  PHY_ACKBIT(24)
> > +#define  RATE_POS12
> > +#define  LANE_POS8
> > +#define  ADR_POS0
> > +#define H1_PCIEPHYDOUTR0x040014
> > +
> > +/* R-Car Gen2 PHY */
> > +#define GEN2_PCIEPHYADDR0x780
> > +#define GEN2_PCIEPHYDATA0x784
> > +#define GEN2_PCIEPHYCTRL0x78c
> > +
> > +#define INT_PCI_MSI_NR32
> > +
> > +#define RCONF(x)(PCICONF(0) + (x))
> > +#define RPMCAP(x)(PMCAP(0) + (x))
> > +#define REXPCAP(x)(EXPCAP(0) + (x))
> > +#define RVCCAP(x)(VCCAP(0) + (x))
> > +
> > +#define PCIE_CONF_BUS(b)(((b) & 0xff) << 24)
> > +#define PCIE_CONF_DEV(d)(((d) & 0x1f) << 19)
> > +#define PCIE_CONF_FUNC(f)(((f) & 0x7) << 16)
> > +
> > +#define RCAR_PCI_MAX_RESOURCES4
> > +#define MAX_NR_INBOUND_MAPS6
> > +
> > +enum {
> > +RCAR_PCI_ACCESS_READ,
> > +RCAR_PCI_ACCESS_WRITE,
> > +};
> > +
> > +void rcar_pci_write_reg(void __iomem *base, u32 val, unsigned int
> > +reg);
> > +u32 rcar_pci_read_reg(void __iomem *base, unsigned int reg); void
> > +rcar_rmw32(void __iomem *base, int where, u32 mask, u32 data); int
> > +rcar_pcie_wait_for_phyrdy(void __iomem *base); int
> > +rcar_pcie_wait_for_dl(void __iomem *base); void
> > +rcar_pcie_set_outbound(int win, void __iomem *base, struct resource
> > +*res); void rcar_pcie_set_inbound(void __iomem *base, u64 cpu_addr,
> u64 pci_addr,
> > +   u64 mask, int idx, bool host);
> > +
> > +#endif
> > --
> > 2.7.4



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
