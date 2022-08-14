Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0471591DB4
	for <lists+linux-pci@lfdr.de>; Sun, 14 Aug 2022 05:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiHNDMM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Aug 2022 23:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNDMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Aug 2022 23:12:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE474C61C;
        Sat, 13 Aug 2022 20:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Dq8QKKBRwxo8eZw76k2LY1fdEPd9Zx7ISoSNLuGxfWlV338DVG7ZBCbcXOFpeGI+lVFgH5GSqOMVgnw0eLTGpjfx7LH5AifNTxEsqF2Wxs7xWFPe1C0LTZgWEN8xV6zRbkH0w8+cEKB8+8Bdr3V0zcuJvf9AyaZHqNLQXqG3LPWy+jBJ1Oh37QThZn6b80VO6qPJpet2hITtUbJiK1W8jiSKF+s2k0d5edxiHpbLRFJ//6sNigIUgM7PsfTfrNjCBSmbqvDz4H88HmbpWp+clIfRNhDtIM+exzu8B9CROeCWmXu7iLnmSJme6oSHNnPnen3B9KZbDMjmUo/B5qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VP3YgCt2y8KKCdU19mQgppCm5jGAL/VLoNda4xFd2rg=;
 b=lYS0vWpquDixPp2W+9ETxnLItSrPj6LupjZ2YbWkgoMNlvfpkHrdjGgGoaXvI232bdC64hU+YEXYCt38uUpoSLMkS+645KJGssLZ7xgFZXbWkkPEvxfZrAC5Ci5k5JDjcXB8dFwUIhCGmFsR3z5vaQadrpOh6byDWsJi/P3GXQFupHjhUfGvyfa4H1oY9zTKfZKTVBZej1RjcQNX+tOvfhbptt5bqKV1kgn5BH3mWvBXEZ3d5U6LY1NTcZ95tJ7eKHiIGiyeXSuu6knuatBn+t9zZ1HxQW3a0zzKOxuOYago8bwfCI8cPY4A7dCTQoOA0ySqtPaqOZf0wfdCF32AYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VP3YgCt2y8KKCdU19mQgppCm5jGAL/VLoNda4xFd2rg=;
 b=gdaqm+zSRYJnO8G9QJhiiorsK0Icsz2EO9bdpiWE+6hoSaR9qMmZuYYwqVS52Ru/1mLO7+hqwMj1Qgfr+FBC4VG9DqSHpTgupI+zC/h2vV8d3bf9sGCJOrSVbxKxEtHfImbpmNjJy04CMyetRG88TtIeCXhvzcauXbumyWNV4UI=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5187.eurprd04.prod.outlook.com (2603:10a6:208:ca::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 03:12:01 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c5f1:b708:61db:a004%5]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 03:12:01 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: RE: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi controller
Thread-Topic: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi
 controller
Thread-Index: AQHYrpXqVoTaplRNPkC0NMrsvBWgTa2sjkeAgAEmxEA=
Date:   Sun, 14 Aug 2022 03:12:01 +0000
Message-ID: <PAXPR04MB918614DF535DA7FBADC956F988699@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
        <20220812215242.2255824-3-Frank.Li@nxp.com> <875yiwsdq2.wl-maz@kernel.org>
In-Reply-To: <875yiwsdq2.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac53413-27f7-4447-690a-08da7da2c186
x-ms-traffictypediagnostic: AM0PR04MB5187:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oD0TqUYDLsQ0e1Svo+wKig8UaT0YqxHl95w4LmfhgULNOou//PTDOlfho82BG3m7uwG0Ixu2lHrJUUL5tdAtLQFPzB3XNPGFgjMVU8LvupSHlObZ+8MFxnkdRFwGvkdOjfGu836yp8dVlUe265ShdOrpe0eN490AIaPP5URdJOdzV6YNv4CGQvG9QTKR2Vzm/csnpaAMFnTXsYL8qyQiynJq5P6Xi64iLqepmwK1rt5hSGANf8vS0ivTb7aSFNgKI/2THX5LCfxP/IuF0pQ46oNizaoT0N5l/3L2TNKatzbZgB3t8boODg+A7yaoaeUz5+tAsXVPyDPrdsvicdhBGnd8EQqLbkmagZiTAEP9pEhpQ2X7sKsy3mFo3VAL7XF0E3Md0dwTZv+yxXJ2Yti9IgFoMPQP9YOjKwlqKuDP/P8y1BYLRDjAAnCMjwyEKRRPpeVeBJvPOgh+TWRatnGhVcU3rpkbw6vgBLHqF/QidDnHwmz3yobru00ATE/qNsRC4+49dWjlsUcMsGoDIZMkjT8BE2ZtpwZ/HjrJJA6Vb/WucJOo2e3XslFSb5qhFPW1AZg1BU8Axo70OM4+m1eXD5RT19+PnIa51zkqYjdl9CfCAzJzicBirBuH8rlGXbWhkf63i5akvwpLBzVLYbW/8haOzqc4XcRtK+HjfZWRoE5l7PUCBilQCE2id5lmePQW/d4kCv4quRutRbuRzBnohzhQAPwI3AeTBXkjwdoIWvGUF7OLiyt/MjCTBRYcFD2E9gII1NoxDs7p4BBqf5+nrN0vV/o0ExhjZpZQABjftfN89YO0L74C4ImuqjKoND3y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(54906003)(6916009)(41300700001)(71200400001)(186003)(26005)(30864003)(2906002)(9686003)(33656002)(66556008)(64756008)(4326008)(122000001)(66946007)(66476007)(66446008)(8676002)(38100700002)(86362001)(316002)(44832011)(83380400001)(76116006)(7696005)(478600001)(53546011)(5660300002)(55236004)(8936002)(6506007)(55016003)(52536014)(7416002)(38070700005)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zA00JIsajSKxD2OZ3opMFts2iTBMJJOSIL41X7vAvnThO6sasbuUS1iSZaFp?=
 =?us-ascii?Q?DVTSgYqjYKqQ5lVjwHuvj5Mo0tqNkMJ5uWHM7WqrXWjBBjtycQreiQQtgYWp?=
 =?us-ascii?Q?OzJ4PRMf46QZapcFKZYEZVqtgVbxFfPrcXiQJ2g7AcPCkMa9LVDol5ye99fL?=
 =?us-ascii?Q?u2cZMZESqOhWWMMgSEo6fiZFcYGepnmZ7rppVdrI5nE31+LxOw2bOUgCNo4s?=
 =?us-ascii?Q?pN7LSWDN2P1F+aP36/nbI1Cv+Kw2DCh9yvXjdFGkmMlZE1yfcCwex+tgZAQP?=
 =?us-ascii?Q?FstGrVnWC2hy5Wbcy8pSZ2IfIQq0SxmXfKvDshoUnx6EUzKj7NzcauTkpV/6?=
 =?us-ascii?Q?YCuza7FP6tjorFjJKJHtJ3urjNVnQc81erBUnyccK4pPapXeUa6R1jsoTq4M?=
 =?us-ascii?Q?N/hoWQozxBlDYnCR2jVptXLTG8FnJzaTFnd16U5lBAI9xo3Nf+rkFCFFlFBB?=
 =?us-ascii?Q?LYL+K7C5SEXl3C8MCW+0vAUVObzumeNSy0AKPkfTmT92R7apCh1X0FVeVjQx?=
 =?us-ascii?Q?8X/j/eIgX0SzmnP6hbo5UHnDLznkrkW9tJJ8Xm3MSOQgrG2j2MuLZDB7W7Qa?=
 =?us-ascii?Q?I60OsiyaaRDpe4Wnbv5m+lAxAkmWbGS26H1jIA8QGhIwthe0Vg6efJ0FUylv?=
 =?us-ascii?Q?GiRjBZIVvThQp25L7Vb1UWjjAxwcSCJuGTlbx0r+a1OqsMsdoTfTmubKVrQN?=
 =?us-ascii?Q?DfFtsgaecZAB+CF0NOLQS0neMbulEGCMrVlKNvnKcMueWYCwazkT09wRasj+?=
 =?us-ascii?Q?JxWihicBYvdJJmKcqu3lhVIy5CDzdHYjzQ2SAdpUHj12X2guauVIC0gNxao0?=
 =?us-ascii?Q?+HfBd6J9iS5OiASckgpbdSKT3kQMhzFNHp8ik9xfGDz6yWHpjnEdJbACH1OO?=
 =?us-ascii?Q?qlTj5nC+vbpb9SzuG4vcJ9JtX+a4OE6yq6rbLH2Ih2LC+8oxrv4mDiADuDh/?=
 =?us-ascii?Q?g9VzJZRZojE+4d9Phuhq0ho/CZWOKcuam8J/MhNMbBu9LeZ4XVhGrCzWtvqa?=
 =?us-ascii?Q?VK4i50nMotGrjv+bi9jUhQcMHL2Bb6SqapPnqUayBkzMD5g0gRU+1k6r20Cf?=
 =?us-ascii?Q?BWlKzA2uPCdIzTZl3uc/vUXCjoSUfxUF+zYGd27PKs0AMsvW+kNk18QSNHfq?=
 =?us-ascii?Q?OmO1eJIuNiJ/N1+0NpxdvWGim2CmUUTmt5aGJUwyitkJh5Mm7MQACEDDzU26?=
 =?us-ascii?Q?sl1orz6vdPUpkzWBzkLMIeNPAq5u9aM8daOxw4jFeslSKVV/+p5OPxkBcv3k?=
 =?us-ascii?Q?n4u5WnBfqVTaxMwE8VY9FZFBrUKBhK/0IkgBp+Zr1j/0hb3zK+pUufWVnLnj?=
 =?us-ascii?Q?nQIoYcmeZhtrvrUSvAD+EddmfAN2mqus6/iyF8LfHhfbIqMqRcOXOvXi6Vjh?=
 =?us-ascii?Q?WyNydiXY0vnIuz37nJqLYKi/ewkGb2zBrEkbrhGwSVs4sxu2NpDSyS3jjG8m?=
 =?us-ascii?Q?vzHyLJkFZXlt+YTwEWzDTjBh3XLciV7YWfmWEIHz1NWK9pApEQZkLvd0q4qi?=
 =?us-ascii?Q?/AelqUFAl4QtFekKx6zBcnpZVNbOQRnWJW/i1y7ATYtJ8fsOnqSOO1pZCkRb?=
 =?us-ascii?Q?DGQKVS4RYoCwtp1FOwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac53413-27f7-4447-690a-08da7da2c186
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 03:12:01.1175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x79wTivGCC9Ujf48kkYtiBUxkFemjEOcjTohRejw1gG25Oue+GMqbmulf91eB0oWxynSIFAqeydu0ET56qtS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Saturday, August 13, 2022 4:19 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com
> Subject: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi controlle=
r
>=20
> Caution: EXT Email
>=20
> Frank,
>=20
> The patch title needs work:
>=20
> "irqchip: Add IMX MU MSI controller driver"
>=20
> On Fri, 12 Aug 2022 22:52:40 +0100,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > MU support generate irq by write data to a register.
>=20
> "The MU block found in a number of Freescale/NXP SoCs supports
> generating IRQs by writing data to a register."
>=20
> > This patch make mu worked as msi controller.
>=20
> Please see Documentation/process/submitting-patches.rst, and the
> requirement to avoid wordings such as "This patch".
>=20
> > So MU can do doorbell by using standard msi api.
>=20
> "This enables the MU block to be used as a MSI controller, by
> leveraging the platform-MSI API"
>=20
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/irqchip/Kconfig          |   7 +
> >  drivers/irqchip/Makefile         |   1 +
> >  drivers/irqchip/irq-imx-mu-msi.c | 443
> +++++++++++++++++++++++++++++++
> >  3 files changed, 451 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-imx-mu-msi.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 5e4e50122777d..4599471d880c0 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -470,6 +470,13 @@ config IMX_INTMUX
> >       help
> >         Support for the i.MX INTMUX interrupt multiplexer.
> >
> > +config IMX_MU_MSI
> > +     bool "i.MX MU work as MSI controller"
> > +     default y if ARCH_MXC
> > +     select IRQ_DOMAIN
> > +     help
> > +       MU work as MSI controller to do general doorbell
> > +
> >  config LS1X_IRQ
> >       bool "Loongson-1 Interrupt Controller"
> >       depends on MACH_LOONGSON32
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 5d8e21d3dc6d8..870423746c783 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -98,6 +98,7 @@ obj-$(CONFIG_RISCV_INTC)            +=3D irq-riscv-in=
tc.o
> >  obj-$(CONFIG_SIFIVE_PLIC)            +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)           +=3D irq-imx-irqsteer.o
> >  obj-$(CONFIG_IMX_INTMUX)             +=3D irq-imx-intmux.o
> > +obj-$(CONFIG_IMX_MU_MSI)             +=3D irq-imx-mu-msi.o
> >  obj-$(CONFIG_MADERA_IRQ)             +=3D irq-madera.o
> >  obj-$(CONFIG_LS1X_IRQ)                       +=3D irq-ls1x.o
> >  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)    +=3D irq-ti-sci-intr.o
> > diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx=
-mu-
> msi.c
> > new file mode 100644
> > index 0000000000000..bb111412d598f
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-imx-mu-msi.c
> > @@ -0,0 +1,443 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NXP MU worked as MSI controller
>=20
> Freescale? Or NXP? Please make up your mind.


[Frank Li] NXP and freescale is the same thing.=20
It is mux used at many place.=20
=20
>=20
> > + *
> > + * Copyright (c) 2018 Pengutronix, Oleksij Rempel
> <o.rempel@pengutronix.de>
> > + * Copyright 2022 NXP
> > + *   Frank Li <Frank.Li@nxp.com>
> > + *   Peng Fan <peng.fan@nxp.com>
> > + *
> > + * Based on drivers/mailbox/imx-mailbox.c
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/msi.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/dma-iommu.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pm_domain.h>
> > +
> > +
> > +#define IMX_MU_CHANS            4
> > +
> > +enum imx_mu_xcr {
> > +     IMX_MU_GIER,
> > +     IMX_MU_GCR,
> > +     IMX_MU_TCR,
> > +     IMX_MU_RCR,
> > +     IMX_MU_xCR_MAX,
> > +};
> > +
> > +enum imx_mu_xsr {
> > +     IMX_MU_SR,
> > +     IMX_MU_GSR,
> > +     IMX_MU_TSR,
> > +     IMX_MU_RSR,
> > +};
> > +
> > +enum imx_mu_type {
> > +     IMX_MU_V1 =3D BIT(0),
> > +     IMX_MU_V2 =3D BIT(1),
> > +     IMX_MU_V2_S4 =3D BIT(15),
> > +};
> > +
> > +/* Receive Interrupt Enable */
> > +#define IMX_MU_xCR_RIEn(data, x) ((data->cfg->type) & IMX_MU_V2 ?
> BIT(x) : BIT(24 + (3 - (x))))
> > +#define IMX_MU_xSR_RFn(data, x) ((data->cfg->type) & IMX_MU_V2 ?
> BIT(x) : BIT(24 + (3 - (x))))
> > +
> > +struct imx_mu_dcfg {
> > +     enum imx_mu_type type;
> > +     u32     xTR;            /* Transmit Register0 */
> > +     u32     xRR;            /* Receive Register0 */
> > +     u32     xSR[4];         /* Status Registers */
> > +     u32     xCR[4];         /* Control Registers */
> > +};
> > +
> > +struct imx_mu_msi {
> > +     spinlock_t                      lock;
> > +     struct platform_device          *pdev;
>=20
> This pointer isn't useful. It is only used in
> imx_mu_msi_domains_init(), which could take it as a parameter.
>=20
> > +     struct irq_domain               *parent;
>=20
> This pointer isn't useful. It is only used in the same function, and
> could well be a local variable.
>=20
> > +     struct irq_domain               *msi_domain;
> > +     void __iomem                    *regs;
> > +     phys_addr_t                     msiir_addr;
> > +     const struct imx_mu_dcfg        *cfg;
> > +     unsigned long                   used;
> > +     int                             gic_irq;
>=20
> This variable is only used in a single function.
>=20
> > +     struct clk                      *clk;
> > +     struct device                   *pd_a;
> > +     struct device                   *pd_b;
> > +     struct device_link              *pd_link_a;
> > +     struct device_link              *pd_link_b;
>=20
> Same thing. All this pd_* stuff is *never* used outside of a single
> function.
>=20
> > +};
> > +
> > +static void imx_mu_write(struct imx_mu_msi *msi_data, u32 val, u32 off=
s)
> > +{
> > +     iowrite32(val, msi_data->regs + offs);
> > +}
> > +
> > +static u32 imx_mu_read(struct imx_mu_msi *msi_data, u32 offs)
> > +{
> > +     return ioread32(msi_data->regs + offs);
> > +}
> > +
> > +static u32 imx_mu_xcr_rmw(struct imx_mu_msi *msi_data, enum
> imx_mu_xcr type, u32 set, u32 clr)
> > +{
> > +     unsigned long flags;
> > +     u32 val;
> > +
> > +     spin_lock_irqsave(&msi_data->lock, flags);
>=20
> This needs to be a raw spinlock.
>=20
> > +     val =3D imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
> > +     val &=3D ~clr;
> > +     val |=3D set;
> > +     imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
> > +     spin_unlock_irqrestore(&msi_data->lock, flags);
> > +
> > +     return val;
> > +}
> > +
> > +static void imx_mu_msi_parent_mask_irq(struct irq_data *data)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
> > +
> > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0,
> IMX_MU_xCR_RIEn(msi_data, data->hwirq));
> > +}
> > +
> > +static void imx_mu_msi_parent_unmask_irq(struct irq_data *data)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
> > +
> > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR,
> IMX_MU_xCR_RIEn(msi_data, data->hwirq), 0);
> > +}
> > +
> > +static void imx_mu_msi_parent_ack_irq(struct irq_data *data)
> > +{
> > +        struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(dat=
a);
> > +
> > +        imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
> > +}
> > +
> > +static struct irq_chip imx_mu_msi_irq_chip =3D {
> > +     .name =3D "MU-MSI",
> > +     .irq_ack =3D irq_chip_ack_parent,
>=20
> Crucially, no irq_write_msi_msg callback. So we happily inherit
> platform_msi_write_msg() and use the per descriptor write_msg()
> callback. Who sets this? Nobody.

[Frank Li] when set flag MSI_FLAG_USE_DEF_CHIP_OPS,=20
 irq_write_msi_msg callback will be set at function platform_msi_update_chi=
p_ops();

>=20
> So I suspect you're hiding it somewhere else, and I really want to see
> this code. I really don't see a good reason why it should be anywhere
> else.
>=20
> > +};
> > +
> > +static struct msi_domain_ops imx_mu_msi_irq_ops =3D {
> > +};
> > +
> > +static struct msi_domain_info imx_mu_msi_domain_info =3D {
> > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS),
> > +     .ops    =3D &imx_mu_msi_irq_ops,
> > +     .chip   =3D &imx_mu_msi_irq_chip,
> > +};
> > +
> > +static void imx_mu_msi_compose_msg(struct irq_data *data, struct
> msi_msg *msg)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
> > +     u64 addr =3D msi_data->msiir_addr + 4 * data->hwirq;
> > +
> > +     msg->address_hi =3D upper_32_bits(addr);
> > +     msg->address_lo =3D lower_32_bits(addr);
> > +     msg->data =3D data->hwirq;
> > +}
> > +
> > +static struct irq_chip imx_mu_msi_parent_chip =3D {
> > +     .name           =3D "MU",
> > +     .irq_mask       =3D imx_mu_msi_parent_mask_irq,
> > +     .irq_unmask     =3D imx_mu_msi_parent_unmask_irq,
> > +     .irq_ack        =3D imx_mu_msi_parent_ack_irq,
> > +     .irq_compose_msi_msg    =3D imx_mu_msi_compose_msg,
>=20
> Please be consistent in the naming.
>=20
> > +};
> > +
> > +static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
> > +                                     unsigned int virq,
> > +                                     unsigned int nr_irqs,
> > +                                     void *args)
> > +{
> > +     struct imx_mu_msi *msi_data =3D domain->host_data;
> > +     unsigned long flags;
> > +     int pos, err =3D 0;
> > +
> > +     WARN_ON(nr_irqs !=3D 1);
> > +
> > +     spin_lock_irqsave(&msi_data->lock, flags);
> > +     pos =3D find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
> > +     if (pos < IMX_MU_CHANS)
> > +             __set_bit(pos, &msi_data->used);
> > +     else
> > +             err =3D -ENOSPC;
> > +     spin_unlock_irqrestore(&msi_data->lock, flags);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     irq_domain_set_info(domain, virq, pos,
> > +                         &imx_mu_msi_parent_chip, msi_data,
> > +                         handle_edge_irq, NULL, NULL);
> > +     return 0;
> > +}
> > +
> > +static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
> > +                                    unsigned int virq, unsigned int nr=
_irqs)
> > +{
> > +     struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(d);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&msi_data->lock, flags);
> > +     __clear_bit(d->hwirq, &msi_data->used);
> > +     spin_unlock_irqrestore(&msi_data->lock, flags);
> > +}
> > +
> > +static const struct irq_domain_ops imx_mu_msi_domain_ops =3D {
> > +     .alloc  =3D imx_mu_msi_domain_irq_alloc,
> > +     .free   =3D imx_mu_msi_domain_irq_free,
> > +};
> > +
> > +static void imx_mu_msi_irq_handler(struct irq_desc *desc)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_desc_get_handler_data(desc);
> > +     u32 status;
> > +     int i;
> > +
> > +     status =3D imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
> > +
> > +     chained_irq_enter(irq_desc_get_chip(desc), desc);
> > +     for (i =3D 0; i < IMX_MU_CHANS; i++) {
> > +             if (status & IMX_MU_xSR_RFn(msi_data, i)) {
> > +                     generic_handle_domain_irq(msi_data->msi_domain, i=
);
> > +             }
> > +     }
> > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
>=20
> Do yourself a favour, and compute irq_desc_get_chip(desc) once, just
> like for most irqchips.
>=20
> > +}
> > +
> > +static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data)
> > +{
> > +     struct fwnode_handle *fwnodes =3D
> of_node_to_fwnode(dev_of_node(&msi_data->pdev->dev));
>=20
> How about dev_fwnode()?
>=20
> > +
> > +     /* Initialize MSI domain parent */
> > +     msi_data->parent =3D irq_domain_create_linear(fwnodes,
> > +                                                 IMX_MU_CHANS,
> > +                                                 &imx_mu_msi_domain_op=
s,
> > +                                                 msi_data);
>=20
> Consider setting the bus_token attribute for this domain to something
> that isn't the default, as it otherwise clashes with the following
> creation.

[Frank Li] Any suggestion? Which bus_token is good?=20

>=20
> > +     if (!msi_data->parent) {
> > +             dev_err(&msi_data->pdev->dev, "failed to create IRQ domai=
n\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     msi_data->msi_domain =3D platform_msi_create_irq_domain(
> > +                             of_node_to_fwnode(msi_data->pdev->dev.of_=
node),
>=20
> Why aren't you using the 'fwnodes' variable here?
>=20
> > +                             &imx_mu_msi_domain_info,
> > +                             msi_data->parent);
> > +
> > +     if (!msi_data->msi_domain) {
> > +             dev_err(&msi_data->pdev->dev, "failed to create MSI domai=
n\n");
> > +             irq_domain_remove(msi_data->parent);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* clean irq_set_affinity again because it is chained irq */
> > +     imx_mu_msi_irq_chip.irq_set_affinity =3D NULL;
>=20
> NAK. The way to do this is to provide a callback that returns -EINVAL,
> not to try and adjust things after the facts.
>=20
> > +
> > +     irq_domain_set_pm_device(msi_data->msi_domain, &msi_data-
> >pdev->dev);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Register offset of different version MU IP */
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx =3D {
> > +     .xTR    =3D 0x0,
> > +     .xRR    =3D 0x10,
> > +     .xSR    =3D {0x20, 0x20, 0x20, 0x20},
> > +     .xCR    =3D {0x24, 0x24, 0x24, 0x24},
> > +};
> > +
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp =3D {
> > +     .xTR    =3D 0x20,
> > +     .xRR    =3D 0x40,
> > +     .xSR    =3D {0x60, 0x60, 0x60, 0x60},
> > +     .xCR    =3D {0x64, 0x64, 0x64, 0x64},
> > +};
> > +
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =3D {
> > +     .type   =3D IMX_MU_V2,
> > +     .xTR    =3D 0x200,
> > +     .xRR    =3D 0x280,
> > +     .xSR    =3D {0xC, 0x118, 0x124, 0x12C},
> > +     .xCR    =3D {0x110, 0x114, 0x120, 0x128},
> > +};
> > +
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 =3D {
> > +
> > +     .type   =3D IMX_MU_V2 | IMX_MU_V2_S4,
> > +     .xTR    =3D 0x200,
> > +     .xRR    =3D 0x280,
> > +     .xSR    =3D {0xC, 0x118, 0x124, 0x12C},
> > +     .xCR    =3D {0x110, 0x114, 0x120, 0x128},
> > +};
> > +
> > +static int __init imx_mu_of_init(struct device_node *dn,
> > +                              struct device_node *parent,
> > +                              const struct imx_mu_dcfg *cfg)
> > +{
> > +     struct platform_device *pdev =3D of_find_device_by_node(dn);
> > +     struct imx_mu_msi *msi_data, *priv;
> > +     struct resource *res;
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     if (!pdev)
> > +             return -ENODEV;
> > +
> > +     dev =3D &pdev->dev;
> > +
> > +     priv =3D msi_data =3D devm_kzalloc(&pdev->dev, sizeof(*msi_data),
> GFP_KERNEL);
> > +     if (!msi_data)
> > +             return -ENOMEM;
> > +
> > +     msi_data->cfg =3D cfg;
> > +
> > +     msi_data->regs =3D devm_platform_ioremap_resource_byname(pdev,
> "a");
> > +     if (IS_ERR(msi_data->regs)) {
> > +             dev_err(&pdev->dev, "failed to initialize 'regs'\n");
> > +             return PTR_ERR(msi_data->regs);
> > +     }
> > +
> > +     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "b");
> > +     if (!res)
> > +             return -EIO;
> > +
> > +     msi_data->msiir_addr =3D res->start + msi_data->cfg->xTR;
> > +
> > +     msi_data->pdev =3D pdev;
> > +
> > +     msi_data->gic_irq =3D platform_get_irq(msi_data->pdev, 0);
> > +     if (msi_data->gic_irq <=3D 0)
> > +             return -ENODEV;
> > +
> > +     platform_set_drvdata(pdev, msi_data);
> > +
> > +     msi_data->clk =3D devm_clk_get(dev, NULL);
> > +     if (IS_ERR(msi_data->clk)) {
> > +             if (PTR_ERR(msi_data->clk) !=3D -ENOENT)
> > +                     return PTR_ERR(msi_data->clk);
> > +
> > +             msi_data->clk =3D NULL;
> > +     }
> > +
> > +     ret =3D clk_prepare_enable(msi_data->clk);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to enable clock\n");
> > +             return ret;
> > +     }
> > +
> > +     priv->pd_a =3D dev_pm_domain_attach_by_name(dev, "a");
>=20
> I'm sorry, but you'll have to come up with something slightly more
> descriptive than "a" or "b". At least add a qualifier to it. Same
> thing for the DT by the way.

[Frank Li] MU spec using  term "A side" and "B side".  So I think "a" and "=
b"
is enough. =20

Or do you think "a-side" is better? =20

>=20
> > +     if (IS_ERR(priv->pd_a))
> > +             return PTR_ERR(priv->pd_a);
> > +
> > +     priv->pd_link_a =3D device_link_add(dev, priv->pd_a,
> > +                     DL_FLAG_STATELESS |
> > +                     DL_FLAG_PM_RUNTIME |
> > +                     DL_FLAG_RPM_ACTIVE);
> > +
> > +     if (!priv->pd_link_a) {
> > +             dev_err(dev, "Failed to add device_link to mu a.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     priv->pd_b =3D dev_pm_domain_attach_by_name(dev, "b");
> > +     if (IS_ERR(priv->pd_b))
> > +             return PTR_ERR(priv->pd_b);
> > +
> > +     priv->pd_link_b =3D device_link_add(dev, priv->pd_b,
> > +                     DL_FLAG_STATELESS |
> > +                     DL_FLAG_PM_RUNTIME |
> > +                     DL_FLAG_RPM_ACTIVE);
> > +
> > +     if (!priv->pd_link_b) {
> > +             dev_err(dev, "Failed to add device_link to mu a.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D imx_mu_msi_domains_init(msi_data);
> > +     if (ret)
> > +             return ret;
>=20
> How about the clocks, the links, and everything else that has been
> allocated, enabled?
>=20
> > +
> > +     irq_set_chained_handler_and_data(msi_data->gic_irq,
> > +                                      imx_mu_msi_irq_handler,
> > +                                      msi_data);
> > +
> > +     pm_runtime_enable(dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused imx_mu_runtime_suspend(struct device *dev)
> > +{
> > +     struct imx_mu_msi *priv =3D dev_get_drvdata(dev);
> > +
> > +     clk_disable_unprepare(priv->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused imx_mu_runtime_resume(struct device *dev)
> > +{
> > +     struct imx_mu_msi *priv =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret =3D clk_prepare_enable(priv->clk);
> > +     if (ret)
> > +             dev_err(dev, "failed to enable clock\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct dev_pm_ops imx_mu_pm_ops =3D {
> > +     SET_RUNTIME_PM_OPS(imx_mu_runtime_suspend,
> > +                        imx_mu_runtime_resume, NULL)
> > +};
> > +
> > +static int __init imx_mu_imx7ulp_of_init(struct device_node *dn,
> > +                                      struct device_node *parent)
> > +{
> > +     return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
> > +}
> > +
> > +static int __init imx_mu_imx6sx_of_init(struct device_node *dn,
> > +                                     struct device_node *parent)
> > +{
> > +     return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
> > +}
> > +
> > +static int __init imx_mu_imx8ulp_of_init(struct device_node *dn,
> > +                                      struct device_node *parent)
> > +{
> > +     return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
> > +}
> > +
> > +static int __init imx_mu_imx8ulp_s4_of_init(struct device_node *dn,
> > +                                         struct device_node *parent)
> > +{
> > +     return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp_s4);
> > +}
> > +
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(imx_mu_msi)
> > +IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
> > +IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
> > +IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
> > +IRQCHIP_MATCH("fsl,imx8ulp-mu-msi-s4", imx_mu_imx8ulp_s4_of_init)
> > +IRQCHIP_PLATFORM_DRIVER_END(imx_mu_msi, .pm =3D
> &imx_mu_pm_ops)
> > +
> > +
> > +MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
> > +MODULE_DESCRIPTION("Freescale MU work as MSI controller driver");
>=20
> Please come up with a better description. Something like
> "Freescale MU MSI controller driver"
>=20
> > +MODULE_LICENSE("GPL");
>=20
> Thanks,
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
