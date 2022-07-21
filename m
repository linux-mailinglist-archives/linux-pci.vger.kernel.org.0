Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA157CECA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiGUPWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUPWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 11:22:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F64F652;
        Thu, 21 Jul 2022 08:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeUKA+G7+se9XlTXcTnxsO9LkdJQNj7AOvfcCpOXC2/dzVT7OzqcgoMUhHPKcmAXV6pOO48VL1pPvpN798zWuFqX/hiqeBpbXWmvg0v8PuxlxHXDesQiY1PYWYApQrs6gIWzI5XXSwAtw25offLvojVXOGDV5rD8Y85whcEuqOflvuOUR3wh8sfZZ3vcL+pHBBO4PEeWQmE+3xyk+UNOZe/C7pHRBrjRXJUqvcmp/8lF2ZpG9UsXyxh+pi4ZqA9OSZUIb2WVSQ08hHVoCWXkfFNzchNqtYUV7ZH19Ks7qEo5tSA6qt1uLPIdD/n/D/2EYY1sOq7B8nAZMCcpSFlW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbIkv4N2KC/xnDul/yha8YLj7fWLLR9rJg0NU6fWlOw=;
 b=cbgmCCsO1nmLPVr9SdpUZWNw5NkqW0ryrvg8JwxEjSkjAyJQ/+sp1UXovXrNFGXUm20hCpEfbDV/dGXjWgghCunS5YjAEscrfBZ5EgftAOx4Y31SZSeVgwrObRg28J+mi2hDYukJVjv/Vqqnff8uWRMt/WX4Lc1MP1fDfADTaKBXiopILcYMOxoKvYBrYi+hzE9sCyknXZlqn/v5YQjl8DYRDidQvlmSTkt4SVnkvwtAdk34W/J9o7TG+qmnLFECxwyqqXncUQFop/PtLXnB8XrRP7hc8tHjNMN+nNwzrrhnlMtI0lGcDu8ejtj34kQufny1oXvCsxBu8CY5UkCSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbIkv4N2KC/xnDul/yha8YLj7fWLLR9rJg0NU6fWlOw=;
 b=RvxTjlCGVY2yguuxoR8sSqHSCDaHiBZrr3b3oy2jaIjmI9Mh2ZeOwfkHWMWwisLDYurCriw7FllswrmEMFleF1nP18AG4Q4EjvDBuhWBlqzBNqv3qc/mu1V4ruJiGn9X3VgP4dZodog5WdyBj2iJld3gzl47bzoZ1A7zE6U6ziM=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB9319.eurprd04.prod.outlook.com (2603:10a6:102:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 15:22:08 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 15:22:08 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi controller
Thread-Topic: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
 controller
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7A=
Date:   Thu, 21 Jul 2022 15:22:08 +0000
Message-ID: <PAXPR04MB9186A1D283ACE8BD6954039288919@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
        <20220720213036.1738628-3-Frank.Li@nxp.com> <874jza525l.wl-maz@kernel.org>
In-Reply-To: <874jza525l.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f73579c8-6ffc-4372-1525-08da6b2cc6c9
x-ms-traffictypediagnostic: PA4PR04MB9319:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+8YNCdV3pIaijlxHiC3ssxMvJY4ENShZbAZKpxK0+Wqf4JlaLPLwfRf6LXOOeqJXTTw7fPNmReLtZNOlLk/ZBRI1Kq5ErtuT/H4L+egK7RUGgvTqjvl5zOl4oyH5OxZTYnC/jcy0II1y9fc36eetc+s8E0923ioZ5tzQMFRKHBFQvEcDezEa408Yd9CnRQnUQuiTUshet+F+J3hzScWihRcUJZ0liwFCKrfN3EU4AqpRwzMOmzlwSgXQeyiMMPLP9sDprcHuXzoZ+WbjtGJVDyBLoa5s4BzYop/KatLzWlPEMC4nT5KQA61Cf2PnGcMxpn/qkbvE/VpH9T1pvQ84COnfL6v4sX3ePXprLe0CV9ZrMpVWme+8ksUlc92nimnWAGz+I69Kx4lPm2EP3hoOIIYZgiVb/UFG4q2cT6IRU/MTWtDvaZa8aKIERzU9ec8fap6VoVN9NY6Hd8g82N+ltOg9PuUcHrpX+YwO5FqpgTW+7q73x5FZpsyU3QeqvYsUF4vEPI6VUUSuv68q1RsR86dHOJAOEKMA/Xf1tp8S7LTnJcGRk47jizkDWqEcmLzpHW00GCkXEGErTarO/yZedOyrFJFys0HK86t9FTnApO1P/ZpuCzwbPEfprwWFWOzSU211NRDwvru3dvVgkJIuiXEu5bXMogtL7nPGUDb3yh90maiJmezeVGdW1AAaVxA7knQD8H16AlJYWXQn5+W32XIdCgHPmaSa89SWmxWK+GBSHxHkO+zCAEksjQ7LRC/HM2JZVpnX7Jz5fXaKJcToagJfsFPMzmH+J9KIHha1Y0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(30864003)(7416002)(316002)(8936002)(44832011)(71200400001)(2906002)(478600001)(9686003)(55016003)(52536014)(54906003)(26005)(5660300002)(6916009)(7696005)(6506007)(53546011)(55236004)(41300700001)(38070700005)(186003)(122000001)(76116006)(8676002)(66476007)(64756008)(66556008)(4326008)(66946007)(38100700002)(83380400001)(86362001)(33656002)(66446008)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJoj66DsP7VaEpvL3jH26rwEepDTDZYUzx3YJLSJaBEeC4YvXc1UCYm7H1qZ?=
 =?us-ascii?Q?XtMD1Hc9qZ3sYDz7XtKS24uNugQs6ydSYdZc7ndg19umm23XpsdrgnZGiqV2?=
 =?us-ascii?Q?R3xIdOt1TZxR95xyv6rG9T2p9Cx2X+qZZ5rVYIhlKmnCWbpVcVi23QzL8Jbe?=
 =?us-ascii?Q?HNO4J7xShEURU0SEwrV/gEPGYjL0uqTkCZJ2ZcaYWUCFpiLLsh8p1i/Pms0C?=
 =?us-ascii?Q?Fb+u9zOiwvJqK5lZwkgGf/yh2JdsV2CCBeewsLBggm/+W4eAxZFepEWn4dYP?=
 =?us-ascii?Q?zT5u5OXz92aQRwTyXusPC7KMfBYCbpu9BEAbEAOcpDmOBPKHVIjzOETw3qsW?=
 =?us-ascii?Q?aP08b4SBZ1Bmc757fg/W4Zp5ugBkoecYdzLfnhJ1TkI0wMsJ5NL0r7BWdEeG?=
 =?us-ascii?Q?PgD3QlcQ2DPoaXlba6WYtOqhIB5jIlBJeB7AmyeqmLId5o9PyvLyOmP6paTu?=
 =?us-ascii?Q?dKKytjLPi0lsko3omUJaS5gRHMwQ9/kx4pCRohx0M8VgV+BF2xJ2NTW18bLl?=
 =?us-ascii?Q?ydL2uqc/gR7WXnlyVsB1ItkCxRUBTxZ4avja/EZ7Nua2Db1UfC/6CQ0qQOxG?=
 =?us-ascii?Q?0T1/oa2GCpDfWPVWhFaLnnREUtxFjG2DVp0bs+KVUqn4LciBHuLjCvEPyshK?=
 =?us-ascii?Q?9ulVEJFGTWNBt9mPyYFnpzEhy6egv75xkmEMcCFGT2T4pvivioR+Il6TKWIR?=
 =?us-ascii?Q?e5aX8LQkBchdb9Ua9c1JFSRfTbs+aHQ1w3LFQKNlJZ1u8IfCnSz7+4Nbpi7Q?=
 =?us-ascii?Q?XrBjf4GQThBg08tOYHpjtsWdtZckyn6AETSFOOIifu3iOXsE48ydw6VHuCZm?=
 =?us-ascii?Q?TP+DGyunraQSnJA/oV+5wCXAPJy8Bz8/ccji/DP9ldx+AD/wIYRlKOVqaJaW?=
 =?us-ascii?Q?iu/noMYoSj8P5/xchQJHvZFJzejvsj2qKgyQXA4v1gRGcSyH0JWT06nXQhUn?=
 =?us-ascii?Q?rFtPZKNheGFLh3OPlAfYjX+1ndFFMF5YbzfHE5yZ9L0GEmBv3nGuUvLfVevQ?=
 =?us-ascii?Q?hzEzvhZJAoTaOx9ky2DG1HHiFjEgSD0PrgmHjNdHKD/Nqah1iPssA35RivBu?=
 =?us-ascii?Q?OUdzI92iRMn6xbxCIbBkHZ/a3sUoD5Ei50fA41zmtLBcWPOcnbWIlD/yw/Ar?=
 =?us-ascii?Q?JKSwN9dKf3M1g0mkj76qSdRiA1ul3smHGeoyO7945sFqe6ft0F9++J8D75qi?=
 =?us-ascii?Q?0EtbzGpCfozzBqAbauvhoDX3L4Wg1I/QzOKjtIrgLiMmBW8i+B6HYKUCmo3Y?=
 =?us-ascii?Q?+SErxFk/dZryKOWOvDLM3DmQB0AvBSbXbsBzcRRr09YvTtN7kgafeBmorXFW?=
 =?us-ascii?Q?hWx2remFF6ML/ssUx0zXftH598Seln8CUUhzkT/nkfKtGGkQe6AbEc+9LSMG?=
 =?us-ascii?Q?VthkPzhg2J0a39jOMcTtP4Hs5E/PVGIcGS8GvpoiPtmEXcVSCUDTVlMhyLsi?=
 =?us-ascii?Q?84nbFxow9t5UdgjqOZ8m2ERA4XaQYKCwx637YpUMrT2lGuNyASAufyZnqFho?=
 =?us-ascii?Q?i3K+OT2ok6vhmp8LBQ6o6wcpYxXuniGCxdYgnxUGCaJkvi9edaXUlklU0rdv?=
 =?us-ascii?Q?0uy71dNgO5KtWudN95U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73579c8-6ffc-4372-1525-08da6b2cc6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 15:22:08.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvvGega5reQd36oHu++QGzH5/4KZYSAyo+etCb01b/YLx9C26lMGDPFj9+avtqqFrWj+HqpJFladISz8kj1GgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Thursday, July 21, 2022 2:57 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: jdmason@kudzu.us; tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev
> Subject: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi controlle=
r
>=20
> Caution: EXT Email
>=20
> On Wed, 20 Jul 2022 22:30:34 +0100,
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
> >  drivers/irqchip/irq-imx-mu-msi.c | 462
> +++++++++++++++++++++++++++++++
> >  3 files changed, 470 insertions(+)
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
> > index 0000000000000..8277dba857759
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-imx-mu-msi.c
> > @@ -0,0 +1,462 @@
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
> > +     spinlock_t                      lock;
> > +     struct platform_device          *pdev;
> > +     struct irq_domain               *parent;
> > +     struct irq_domain               *msi_domain;
> > +     void __iomem                    *regs;
> > +     phys_addr_t                     msiir_addr;
> > +     const struct imx_mu_dcfg        *cfg;
> > +     unsigned long                   used;
> > +     u32                             gic_irq;
> > +     struct clk                      *clk;
> > +     struct device                   *pd_a;
> > +     struct device                   *pd_b;
> > +     struct device_link              *pd_link_a;
> > +     struct device_link              *pd_link_b;
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
>=20
> Urgh... No. Please don't go poking into the *parent* stuff. Implement
> the masking at the parent level, and use irq_chip_mask_parent() for
> this level, unless you can explain why you can't do otherwise.
>=20
> > +
> > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0,
> IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
>=20
> How about making this readable and move the dereference inside the macro?
>=20
> > +}
> > +
> > +static void imx_mu_msi_unmask_irq(struct irq_data *data)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data-
> >parent_data);
> > +
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
>=20
> What does this have to do with the ITS?

Without this, it will be crashed as access 0 address.

>=20
> > +
> > +static struct msi_domain_info imx_mu_msi_domain_info =3D {
> > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> > +                MSI_FLAG_USE_DEF_CHIP_OPS |
> > +                MSI_FLAG_PCI_MSIX),
>=20
> What does PCI_MSIX mean in this context? I really wish you used
> copy/paste a bit more carefully.
>=20
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
>=20
> This is a horrible way of writing this. you should compute the address
> first, and then apply the address split.
>=20
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
>=20
> Err... What effect does this have if you don't do anything?

[Frank Li] Without this, it will be crashed as access 0 address.

>=20
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
> > +     WARN_ON(nr_irqs !=3D 1);
> > +
> > +     spin_lock(&msi_data->lock);
>=20
> Interrupt fires after lock acquisition, handler masks the interrupt.
> Deadlock.

[Frank Li] you are right, it should be spin_lock_irqsave.

>=20
> > +     pos =3D find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
> > +     if (pos < IMX_MU_CHANS)
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
>=20
> Does this HW even have an IOMMU?

[Frank Li] we have a platform with iommu.   =20

>=20
> > +     if (err)
> > +             return err;
> > +
> > +     irq_domain_set_info(domain, virq, pos,
> > +                         &imx_mu_msi_parent_chip, msi_data,
> > +                         handle_simple_irq, NULL, NULL);
>=20
> This is an edge interrupt. Please handle it like one.

[Frank Li]  Not sure what your means?

>=20
> > +     return 0;
> > +}
> > +
> > +static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
> > +                                    unsigned int virq, unsigned int nr=
_irqs)
> > +{
> > +     struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(d);
> > +
> > +     spin_lock(&msi_data->lock);
>=20
> Same problem.
>=20
> > +     __clear_bit(d->hwirq, &msi_data->used);
> > +     spin_unlock(&msi_data->lock);
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
>=20
> Why the parent? You must start at the top of the hierarchy.
>=20
> > +             }
> > +     }
> > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
>=20
> If your MSIs are a chained interrupt, why do you even provide an
> affinity setting callback?

[Frank Li]  it will be crash if no affinity setting callback.=20

>=20
> > +}
> > +
> > +static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data)
> > +{
> > +     /* Initialize MSI domain parent */
> > +     msi_data->parent =3D irq_domain_add_linear(dev_of_node(&msi_data-
> >pdev->dev),
> > +                                              IMX_MU_CHANS,
> > +                                              &imx_mu_msi_domain_ops,
> > +                                              msi_data);
>=20
> Use irq_domain_create_linear() instead.
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
> > +                             &imx_mu_msi_domain_info,
> > +                             msi_data->parent);
>=20
> And you don't get an error due to the fact that you use the same
> fwnode for both domains without overriding the domain bus token?
>=20
> > +
> > +     if (!msi_data->msi_domain) {
> > +             dev_err(&msi_data->pdev->dev, "failed to create MSI domai=
n\n");
> > +             irq_domain_remove(msi_data->parent);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     irq_domain_set_pm_device(msi_data->parent, &msi_data->pdev-
> >dev);
>=20
> I really wonder why you both implementing a MSI domain if you are
> always bypassing it for absolutely everything... This completely
> nullifies the effect of this call, as no interrupt request will ever
> trigger the PM.
>=20
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
>=20
> Why do you need to do all this dance?
>=20
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
> > +MODULE_LICENSE("GPL");
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
