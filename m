Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B63656C062
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiGHQ1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiGHQ0s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 12:26:48 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5083F07;
        Fri,  8 Jul 2022 09:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZti52TJcRY4N0FOR0Zvk6mSI58RoyPBGyt4boMsoNSy+mxEcenFgOJE8Y9T7LxJ1WhjiaJWSwJzQM4mwVpFurRmx5pp82t4BosEWU3kLfdxJSiDQE5VLUaeoKqSvGYBl9Mv66dAmVodfrCM80uc/1eV51TpXsc4ZbqUkFe0vA6Wvhl3fGkCNo7WgXVPvMYY77G67TRKJYydOqOQ2iXqiBidGaV5WkTUdbUGqDh2fXhPhBWceJ1nLX9ax6tNUKupMDDeQcOiLu7sU2MP9IgvVI5Lq++6ts7Z5X7GWmvuG+mkcrAhm6ITXvrPj08FUQiCysRpx2qhSNBAimU6oL1jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y44kqoV8bYTWq873TvOQrW2B2AAxGZbw807t05mhqrA=;
 b=DmI84WREJhnnMgjCKsEA39yn6oc4r4bIdw37OPTsjaGWALMJahnZsTf/mdYPEHHzei8o9bnUxbFLCm3zki71qe87QbPRENOlrkdpO6PfEDwEGw3+Glrdzw3PkZAei3cAPDbRSWnliVG7CIor4UxGCPA1xjcn0cmv4UL/27ayyHvcqf2L9DfbN/NIqyAp3fuz1q4lajr+yTevOLvE9x4yreuuFEoyBPtb3L+iNh/XQ+x/6UHYRIo3e6/557Sf5BPEML0FGVCkV9lBwr5AY5JmIbwrbDDimIQKNuLKCVFvoOtgMbjEjPA37pmdlshfdBnnt5hRPIqS199GcHxYmQx3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y44kqoV8bYTWq873TvOQrW2B2AAxGZbw807t05mhqrA=;
 b=o71KlwKjtMvdXXJ3ehpGMDmiv5cyYpDowHNlo2j6yCj0PHJPyi/Zc3wE5nJwKMyez039G9rbueqsrX7/r9TzSX/1vHDI9Pzu30zhBv3W/GpcpqSA0bTleYae5Q8a06mnMKOvAJmfvdUpU64tnyPVeCVFIyfxk7vSIPFrLh3CEvw=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0402MB3917.eurprd04.prod.outlook.com (2603:10a6:803:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 16:26:33 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e945:8bde:54e5:d83e%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 16:26:33 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH 1/3] irqchip: imx mu worked as msi controller
Thread-Topic: [EXT] Re: [PATCH 1/3] irqchip: imx mu worked as msi controller
Thread-Index: AQHYkkT2+y+HF1xDMk6QBzQk2IrQoK10LUOAgAB1MGA=
Date:   Fri, 8 Jul 2022 16:26:33 +0000
Message-ID: <PAXPR04MB9186714350C749DB6AADB35188829@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220707210238.917477-1-Frank.Li@nxp.com>
 <87r12wkmkm.wl-maz@kernel.org>
In-Reply-To: <87r12wkmkm.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e56d46b-608b-4ba9-968a-08da60fe9f26
x-ms-traffictypediagnostic: VI1PR0402MB3917:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOIgPbicFT8mVDi92GmrfLx02leI2PnJAhQnaOvfbu2KhGkwKu/oSvnl6L+N4q0vbX/R0wrZ9Jf00ByWbqftIReg9rLOuNqUceMySN55QghW8l+BVGbgRWrPd+afB0KfpWlZl4XW9/Cgmxv04NEkJujtmEB5zuvpZF2ORabDa4t75eGQjTHEk0bG9vOa2quGQYOQErEPUrprPZa9T7RQIXOUpm0v2KIQIS2eURvX85l6EZScHAkl/WdrPFGUrmywWK+elpo6GZoAbgrQAsNuaysT7XiihhI2yDYdtqx6SeJtYnaRGuc3Cc2j7X5em/3q2dHkwugd8hjpb/e0tDM1YL1y8gIwW7MJZlOTOzrDS/54gus97WDgajl+dn+uFgxJk1qsWxyPh3IZmNT696F5JTszNDLv27EZu3dh6x7TqEDROJdNlq6g2/KUBXUoJoLj4Yv05AqhZeqhA/AeuP3Ah/KfUSiD9RQcgcM1Zet8MBYIWUJ97xDWMpF6d0kO2vIFbzb5ZXleIFc2bELRaP8FMbmynWQFYwWEPelhVA/cMX6bAU4WHYD8mwM0nAaVfeRN6sJAyys+a34/XCpHsvmU9LmrWx0EB4pxYVgXcJUYc+GiVepmtjWliUYH0JJiCnVTMEOuZLP6x41mXpXSdbFbgyc0DiWNo+fEk1soC3FGFNVxFB5nZzWfCyKDelfwCbBxbY8RjtE3vrM3Z4Edmdlri/y5gUtNMHDvCXjfdmvCscBA0M8itbIH1OzA5Rq1XOnpJQqExUl+SBXGut/4ZlpgIddo9nfDGR3MVp45BCcZzvDDRNspkHjp9uPI0QCmO2BmrxKrvTM31pRbY9Jq3E/Cn534vec0rzBnummNWfFpDWxIX5d+Yh2MCEqWzxWvyP9L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(8676002)(186003)(66476007)(64756008)(71200400001)(66946007)(66556008)(4326008)(55016003)(9686003)(53546011)(6506007)(7696005)(76116006)(66446008)(83380400001)(54906003)(26005)(55236004)(6916009)(86362001)(38070700005)(38100700002)(33656002)(44832011)(52536014)(316002)(41300700001)(122000001)(2906002)(478600001)(7416002)(8936002)(30864003)(5660300002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PgqpCyOzXMwDDv8BhvLKpMiYlfMEqTSRpMDXz/I7QPgy5FWs8h14WapzBRL4?=
 =?us-ascii?Q?2fBSat00ZMiuX/2q9HVBoKZQgtCXkfTFFoHQVNfTOwMW+IR7QSi1ucoCjVmf?=
 =?us-ascii?Q?iiyKOmqNPc/HNL1cUJ5AF8kDpDYh/qrQ/Cwul9lSZhxx2oV/ShzXRuZ63Uq6?=
 =?us-ascii?Q?j8XWR1Uy5yyFbd0ZBagSEPR34t2Z0eBufGX5xnIq6xXYwNlNpW0ryhFWfqwG?=
 =?us-ascii?Q?GBJSowvuH0p1POiJ3udSJ1E5vkza/RG92RMXHiBkq7epBP04wS3sVwcLXBA4?=
 =?us-ascii?Q?cQkqB3lAakKhzpqnfJQTVkPNtJCHHICK2/AKU7MrDWag6FDCszniO+h6pqr/?=
 =?us-ascii?Q?TQjQNMGA8ZNDHQZI93J2VoRw7gkLQ/ELsJEsjkyyvC+b1oLYugv4jJV3UtTm?=
 =?us-ascii?Q?6nrnFfxlQ6xoTBi3QJ8DFtGuXGu6le9nuQrg8sRH3fZzrW6FP6/BOQOzZwiT?=
 =?us-ascii?Q?sVekfljzxqjjeSXgDnJ12vuNEZ9azm3y1TcWuXnZLsCMtVV5u7PPPJqIVmKP?=
 =?us-ascii?Q?8Ezw+3sATN0nCMroRTGCIFBI28EbwsDqVCCTL71I35rJtei8Sod30tGvXih5?=
 =?us-ascii?Q?9yRxsVyMlEqnbJGr52XKeZapnaumOY9JkxfR5m2cvs6uCjRNYIQp7+Dou8hU?=
 =?us-ascii?Q?faPSNNCfEu0HwMxujj4iDdHR1+7zys8VRs4SX+YwTpmV3x2ulkCyGh0X3MKL?=
 =?us-ascii?Q?5BN4tmY8q57l7yOH3q1TYhU61I2WcR8CUHdhra2Lq3a1jf1dBfuMyheaMsNz?=
 =?us-ascii?Q?wDFM7Sk90WtYCP/VI0xOSPyhhY4rYVXeChXMPKLu30Z0mJD7/Ylw0UgZsXM+?=
 =?us-ascii?Q?DrOZMF9BSPqamB1ldfzZIKmnYGwuZUywUGKgW1Zf5bQ/spGshbnX64StfpLg?=
 =?us-ascii?Q?NJnYq5Mcf/1vMthmv/F60VLa2eZ21HOsbzzvLVqx2EyuFSiNlcgITWfr31ap?=
 =?us-ascii?Q?wLAgqpuGEHo0bBspJNK6UjDkuEulcYEP0OF5DJyq08XYx3mtaR42X7uGMyA5?=
 =?us-ascii?Q?aDUKkEu3+vFiPchHfH6VRjQZx8LDwXhPK4NcEnGBQLl17I85GY20S7tq2jcR?=
 =?us-ascii?Q?scBdyzf2OIrBAaXS4ksf0WTS9ecJzxSUK/qN//GPwhjoLpV6IETSv+z2UC5z?=
 =?us-ascii?Q?1i60TIZk8hwECSc3xT5cPE7Pv1HhgA3sgLJ9CTsTUsl1AEPF0PgRBvBGsLzx?=
 =?us-ascii?Q?RFndzKA87Osgbnl+fTK+hjvNm5otRW6kcAPosCQhbRMivUkpz1TqrrDZembL?=
 =?us-ascii?Q?xtrTGctUG3vEIscXjSXySdj0QK31m9SH/FqA5zPC/XNYGF/CUJ+sL/1tf3Jp?=
 =?us-ascii?Q?2D+DewX3lxoEh7TdgnfeXd0+I5fdm8LOww0Lwvme9+3Vphb7TDwkRJSfwsy6?=
 =?us-ascii?Q?3NnL889nexgzfTawteE1n6R4piloJhk/9+ud6NGxATEB6t0+YLv1qUVok3v2?=
 =?us-ascii?Q?wE5QbuFv/+QwxR/ozosJuvq56q0GfVT79dwhSPnideGJnCjkhghJ3D5cWG29?=
 =?us-ascii?Q?xs56bIL9TWJvmymWo31+jRYzpywBEULRcaCs/5UZPYj6oCYgYhJ70nGyXLBk?=
 =?us-ascii?Q?D7C0608ueWDyZByQzpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e56d46b-608b-4ba9-968a-08da60fe9f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 16:26:33.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFN5+Y/I1DvyPRrAPeyE+Mi5d5YlpzKMnWx3evfeWBM9w11bpua044no/iIiVscL8JaDvGQ6z7p1JXXzrzKcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Friday, July 8, 2022 3:59 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH 1/3] irqchip: imx mu worked as msi controller
>=20
> Caution: EXT Email
>=20
> On Thu, 07 Jul 2022 22:02:36 +0100,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > MU support generate irq by write data to a register.
> > This patch make mu worked as msi controller.
> > So MU can do doorbell by using standard msi api.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/irqchip/Kconfig          |   7 +
> >  drivers/irqchip/Makefile         |   1 +
> >  drivers/irqchip/irq-imx-mu-msi.c | 490
> +++++++++++++++++++++++++++++++
> >  3 files changed, 498 insertions(+)
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
> > index 0000000000000..f7193a6c1245e
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-imx-mu-msi.c
> > @@ -0,0 +1,490 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NXP MU worked as MSI controller
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
> > +enum imx_mu_chan_type {
> > +     IMX_MU_TYPE_TX,         /* Tx */
> > +     IMX_MU_TYPE_RX,         /* Rx */
> > +     IMX_MU_TYPE_TXDB,       /* Tx doorbell */
> > +     IMX_MU_TYPE_RXDB,       /* Rx doorbell */
>=20
> What does any of this even mean for MSIs?

Sorry, I forget deleted it.

>=20
> > +};
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
> > +     IMX_MU_V1,
> > +     IMX_MU_V2,
> > +     IMX_MU_V2_S4 =3D BIT(15),
>=20
> If the bit assignment is significant, make it so for all members of
> this enum.

[Frank Li] Yes, you are right.

>=20
> > +};
> > +
> > +/* Receive Interrupt Enable */
> > +#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24
> + (3 - (x))))
> > +#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 +
> (3 - (x))))
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
> > +     spinlock_t              lock;
> > +     struct platform_device  *pdev;
> > +     struct irq_domain       *parent;
> > +     struct irq_domain       *msi_domain;
> > +     void __iomem            *regs;
> > +     phys_addr_t             msiir_addr;
> > +     struct imx_mu_dcfg      *cfg;
> > +     u32                     msir_num;
> > +     struct imx_mu_msir      *msir;
> > +     u32                     irqs_num;
> > +     unsigned long           used;
> > +     u32                     gic_irq;
> > +     struct clk              *clk;
> > +     struct device           *pd_a;
> > +     struct device           *pd_b;
> > +     struct device_link      *pd_link_a;
> > +     struct device_link      *pd_link_b;
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
> > +     val =3D imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
> > +     val &=3D ~clr;
> > +     val |=3D set;
> > +     imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
> > +     spin_unlock_irqrestore(&msi_data->lock, flags);
> > +
> > +     return val;
> > +}
> > +
> > +static void imx_mu_msi_mask_irq(struct irq_data *data)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data-
> >parent_data);
> > +
> > +     pci_msi_mask_irq(data);
>=20
> What is this? Below, you create a platform MSI domain. Either you
> support PCI, and you create a PCI/MSI domain (and the above may make
> sense), or you are doing platform MSI, and the above is non-sense.

[Frank Li] You are right. This work as platform msi. Needn't call pci_msi_i=
rq() =20

>=20
> > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0,
> IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
> > +}
> > +
> > +static void imx_mu_msi_unmask_irq(struct irq_data *data)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data-
> >parent_data);
> > +
> > +     pci_msi_unmask_irq(data);
> > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR,
> IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq), 0);
> > +}
> > +
> > +static struct irq_chip imx_mu_msi_irq_chip =3D {
> > +     .name =3D "MU-MSI",
> > +     .irq_mask       =3D imx_mu_msi_mask_irq,
> > +     .irq_unmask     =3D imx_mu_msi_unmask_irq,
> > +};
> > +
> > +static struct msi_domain_ops its_pmsi_ops =3D {
> > +};
> > +
> > +static struct msi_domain_info imx_mu_msi_domain_info =3D {
> > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> > +                MSI_FLAG_USE_DEF_CHIP_OPS |
> > +                MSI_FLAG_PCI_MSIX),
> > +     .ops    =3D &its_pmsi_ops,
> > +     .chip   =3D &imx_mu_msi_irq_chip,
> > +};
> > +
> > +static void imx_mu_msi_compose_msg(struct irq_data *data, struct
> msi_msg *msg)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
> > +
> > +     msg->address_hi =3D upper_32_bits(msi_data->msiir_addr);
> > +     msg->address_lo =3D lower_32_bits(msi_data->msiir_addr + 4 * data=
-
> >hwirq);
> > +     msg->data =3D data->hwirq;
> > +
> > +     iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
> > +}
> > +
> > +static int imx_mu_msi_set_affinity(struct irq_data *irq_data,
> > +                                const struct cpumask *mask, bool force=
)
> > +
> > +{
> > +     return IRQ_SET_MASK_OK;
> > +}
> > +
> > +static struct irq_chip imx_mu_msi_parent_chip =3D {
> > +     .name                   =3D "MU",
> > +     .irq_compose_msi_msg    =3D imx_mu_msi_compose_msg,
> > +     .irq_set_affinity =3D imx_mu_msi_set_affinity,
> > +};
> > +
> > +static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
> > +                                     unsigned int virq,
> > +                                     unsigned int nr_irqs,
> > +                                     void *args)
> > +{
> > +     struct imx_mu_msi *msi_data =3D domain->host_data;
> > +     msi_alloc_info_t *info =3D args;
> > +     int pos, err =3D 0;
> > +
> > +     pm_runtime_get_sync(&msi_data->pdev->dev);
>=20
> The core code already deals with runtime PM. What prevents it from
> working, other than the fact you don't populate the device in the
> top-level domain?

[Frank Li]  Do you means power domain or irq domain?

>=20
> > +
> > +     WARN_ON(nr_irqs !=3D 1);
> > +
> > +     spin_lock(&msi_data->lock);
> > +     pos =3D find_first_zero_bit(&msi_data->used, msi_data->irqs_num);
> > +     if (pos < msi_data->irqs_num)
> > +             __set_bit(pos, &msi_data->used);
> > +     else
> > +             err =3D -ENOSPC;
> > +     spin_unlock(&msi_data->lock);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr +
> pos * 4);
> > +     if (err)
> > +             return err;
> > +
> > +     irq_domain_set_info(domain, virq, pos,
> > +                         &imx_mu_msi_parent_chip, msi_data,
> > +                         handle_simple_irq, NULL, NULL);
> > +     return 0;
> > +}
> > +
> > +static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
> > +                                    unsigned int virq, unsigned int nr=
_irqs)
> > +{
> > +     struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(d);
> > +     int pos;
> > +
> > +     pos =3D d->hwirq;
> > +     if (pos < 0 || pos >=3D msi_data->irqs_num) {
> > +             pr_err("failed to teardown msi. Invalid hwirq %d\n", pos)=
;
> > +             return;
> > +     }
>=20
> How can this happen?

I just copy from irq-ls-scfg-msi.c
It should be impossible happen if everything work as expected.=20

>=20
> > +
> > +     spin_lock(&msi_data->lock);
> > +     __clear_bit(pos, &msi_data->used);
> > +     spin_unlock(&msi_data->lock);
> > +
> > +     pm_runtime_put(&msi_data->pdev->dev);
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
> > +             if (status & IMX_MU_xSR_RFn(msi_data->cfg->type, i)) {
> > +                     imx_mu_read(msi_data, msi_data->cfg->xRR + i * 4)=
;
> > +                     generic_handle_domain_irq(msi_data->parent, i);
> > +             }
> > +     }
> > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > +}
> > +
> > +static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data)
> > +{
> > +     /* Initialize MSI domain parent */
> > +     msi_data->parent =3D irq_domain_add_linear(NULL,
>=20
> NAK. Don't create anonymous domains.
[Frank Li] will fixed at next version.

>=20
> > +                                              msi_data->irqs_num,
> > +                                              &imx_mu_msi_domain_ops,
> > +                                              msi_data);
> > +     if (!msi_data->parent) {
> > +             dev_err(&msi_data->pdev->dev, "failed to create IRQ domai=
n\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     msi_data->msi_domain =3D platform_msi_create_irq_domain(
> > +                             of_node_to_fwnode(msi_data->pdev->dev.of_=
node),
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
> > +     return 0;
> > +}
> > +
> > +static int imx_mu_msi_teardown_hwirq(struct imx_mu_msi *msi_data)
> > +{
> > +     if (msi_data->gic_irq > 0)
> > +             irq_set_chained_handler_and_data(msi_data->gic_irq, NULL,
> NULL);
> > +
> > +     return 0;
> > +}
> > +
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
> > +     .type   =3D IMX_MU_V2 | IMX_MU_V2_S4,
> > +     .xTR    =3D 0x200,
> > +     .xRR    =3D 0x280,
> > +     .xSR    =3D {0xC, 0x118, 0x124, 0x12C},
> > +     .xCR    =3D {0x110, 0x114, 0x120, 0x128},
> > +};
>=20
> What are these? We really don't need more magic numbers.

It is register offset.  The difference version MU hardware's register map i=
s difference.=20

>=20
> > +
> > +static const struct of_device_id imx_mu_msi_ids[] =3D {
> > +     { .compatible =3D "fsl,imx7ulp-mu-msi", .data =3D &imx_mu_cfg_imx=
7ulp },
> > +     { .compatible =3D "fsl,imx6sx-mu-msi", .data =3D &imx_mu_cfg_imx6=
sx },
> > +     { .compatible =3D "fsl,imx8ulp-mu-msi", .data =3D &imx_mu_cfg_imx=
8ulp },
> > +     { .compatible =3D "fsl,imx8ulp-mu-msi-s4", .data =3D
> &imx_mu_cfg_imx8ulp_s4 },
> > +     { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, imx_mu_msi_ids);
> > +
> > +static int imx_mu_msi_probe(struct platform_device *pdev)
> > +{
> > +     const struct of_device_id *match;
> > +     struct imx_mu_msi *msi_data, *priv;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     match =3D of_match_device(imx_mu_msi_ids, &pdev->dev);
> > +     if (!match)
> > +             return -ENODEV;
> > +
> > +     priv =3D msi_data =3D devm_kzalloc(&pdev->dev, sizeof(*msi_data),
> GFP_KERNEL);
> > +     if (!msi_data)
> > +             return -ENOMEM;
> > +
> > +     msi_data->cfg =3D (struct imx_mu_dcfg *) match->data;
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
> > +     msi_data->irqs_num =3D IMX_MU_CHANS;
>=20
> If that's hardcoded, why do we need an extra variable? I also question
> the usefulness of this driver if the HW can only deal with *4* MSIs...
> This looks a bit like a joke.

MU don't really MSI controller.  Each MU have 4 channel. =20
I.MX have several MU units. =20

PCI EP driver need an address as doorbell,  so PCI RC side can write
This address to trigger irq.  Ideally,  it use GIC-ITS. But our i.MX chip
Have not ITS support yet now.  So we can use MU as simple MSI controller.

So PCE EP side driver can use standard MSI method to do doorbell for
GIC-ITS,  MU and other msi controller without any modification.=20

I will add such information at cover letter next version.

>=20
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
> > +
> > +     irq_set_chained_handler_and_data(msi_data->gic_irq,
> > +                                      imx_mu_msi_irq_handler,
> > +                                      msi_data);
> > +
> > +     pm_runtime_enable(dev);
> > +
> > +     ret =3D pm_runtime_get_sync(dev);
> > +     if (ret < 0) {
> > +             pm_runtime_put_noidle(dev);
> > +             goto disable_runtime_pm;
> > +     }
> > +
> > +     ret =3D pm_runtime_put_sync(dev);
> > +     if (ret < 0)
> > +             goto disable_runtime_pm;
> > +
> > +     clk_disable_unprepare(msi_data->clk);
> > +
> > +     return 0;
> > +
> > +disable_runtime_pm:
> > +     pm_runtime_disable(dev);
> > +     clk_disable_unprepare(msi_data->clk);
> > +
> > +     return ret;
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
> > +static int imx_mu_msi_remove(struct platform_device *pdev)
> > +{
> > +     struct imx_mu_msi *msi_data =3D platform_get_drvdata(pdev);
> > +
> > +     imx_mu_msi_teardown_hwirq(msi_data);
> > +
> > +     irq_domain_remove(msi_data->msi_domain);
> > +     irq_domain_remove(msi_data->parent);
>=20
> How do you ensure that no device is still holding interrupts? Let me
> give you a hint: you can't. So removing an interrupt controller module
> should not be possible.

[Frank Li] I agree. But there are many *_remove under irqchip.=20

>=20
> > +
> > +     platform_set_drvdata(pdev, NULL);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver imx_mu_msi_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "imx-mu-msi",
> > +             .of_match_table =3D imx_mu_msi_ids,
> > +             .pm =3D &imx_mu_pm_ops,
> > +     },
> > +     .probe =3D imx_mu_msi_probe,
> > +     .remove =3D imx_mu_msi_remove,
> > +};
> > +
> > +module_platform_driver(imx_mu_msi_driver);
>=20
> Please use the standard probing methods
> (IRQCHIP_PLATFORM_DRIVER_BEGIN
> and co).
>=20
> > +
> > +MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
> > +MODULE_DESCRIPTION("Freescale Layerscape SCFG MSI controller
> driver");
> > +MODULE_LICENSE("GPL");
>=20
> I have the ugly feeling that this driver really isn't about MSIs, but
> is just a way to sneak some terrible abstraction into the kernel... I
> guess we'll eventually find out. In the meantime, this driver needs
> fixing.
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
