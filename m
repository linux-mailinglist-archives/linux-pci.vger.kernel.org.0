Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E05B2074
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiIHOYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiIHOYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 10:24:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCCE1316DA;
        Thu,  8 Sep 2022 07:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOJFEHDX6HWu6otbTuQ022S5R/wxwkv4i51jZ939OtEGD58kAS/Yv6DofMdrQVH9fmUOb8YDwlek1MsGGBgUWX2Vf6gw4i56E7LgZ0F+HRgvk0tMhDm07crO7hlcXl9EMGNtj8TOprzfZqU1g66yvunZ8bwZ2nOpwOJt8PEJhXfQWQ3btm5pQJPmthogbctUod3TgvXeVaFSTl7EuiPQrn4hdBbcR1lGXkek+pOfGPx9mbMXfIYbWZnC+1ymuS2+f9RTllKApsTxLCfb6bQH6oTNNWpy8i/t/gOdNpBiP0STbtaWXlSrRAW26A7bgLQuqer1YSV79tBXpPMEiJflIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5RJ1aD82LV9x1joSmvC9xYPDFN5lDQtxH3GcBXuPHc=;
 b=YARZBV6yyjHuLmFVMWZJ9nm3DX2T4sv1cHejL+58KV+Kxk+lvdEwN2FFqLWKpJZHW2IfubBa1o7/hLv+amaCc7D0hcdo/rk8DQgH/bzF6pu3nPxxC2b4q4U028JR/IAxs8z9Lk59V1UBtsUL76gPb2lzwDVUjmA7WHGiFHWzOpF0MZTKB/nGydXY5icZVCbnTKCGSo2SVS8Y3o+vgh8cMqltKWfHuz56Y2iOA/LefgKLV1P66YNKMeMOXCORbOdC7hEGJKP5ANgUfU8J6IGRFkd3RLv/CkCZ0/PhoRy5Dl2ijIkIAxqDqNa1N9wZ6k6Oh5S0ZpYLb+lQMwEydCxKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5RJ1aD82LV9x1joSmvC9xYPDFN5lDQtxH3GcBXuPHc=;
 b=O2D+JqWGnhZ2THSWrYYwzX/VdK1rRFKno9GJ54G/NMC2rGpqyNjS5kXW1NdOprKgMyL52ECNyyh3UX9WLrMRdUec11oZWNmxjn3U0abracnpDG+4WZHIzSU+moNRo/ijKoV4VDrJMfWNam19ZZPSse5YntCX1om8gqzUS2tqzWg=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by VI1PR0402MB3662.eurprd04.prod.outlook.com (2603:10a6:803:1c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 14:23:53 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 14:23:53 +0000
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
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: RE: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
 driver
Thread-Topic: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
 driver
Thread-Index: AQHYwmzT0d5rWoxlpEiRJzxdVpfwVa3VJ32AgABtNnA=
Date:   Thu, 8 Sep 2022 14:23:53 +0000
Message-ID: <AM9PR04MB879338D6D4B55A74CD002E6D88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
        <20220907034856.3101570-3-Frank.Li@nxp.com> <87fsh2qpq4.wl-maz@kernel.org>
In-Reply-To: <87fsh2qpq4.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|VI1PR0402MB3662:EE_
x-ms-office365-filtering-correlation-id: 169404a4-f47a-4dd2-013b-08da91a5c1ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cht6hIt2SgIvT/BzM12tgpssWY5h28vpgajWB1/EnX3F1w8oMNpmEE/Do6PyYYaOB/oCxWavempccEmaP85VnKIjaJdXz0Qr++r5lyX2mSjZaSJBGlJT6v4n0QvHgLASXX3sr4boiLn96UHhYl5CIEEhpm/E7WHklTuM12boTdu2LAJaUGnOJj3JuAILQ2RE+hjMZb4+0m8yHtqBasCHyWM6rmMrnhqqXxKLlJyXmZ6WMZnZM8A6oaduVZoVr3zZP8zJJP9izOxVpxPHax2bvnbQk8BueDFJQWj23G4CvKy+BsDOYpR/WXIkVLJlp2LlmuUWybpVX+hldzOzmkZh3czc0Q6reqOMaPdgP/38nfC+ZpIYRsMQGc42iCRBhbFWe6/F7znjgIWXOva1inp4kSPycx/euWz8h0r12LKjBKz0rjW6ZxcCGyCbG+y//Q7OFDus9k1WVfGtUmq3l3nPl1dZykfs1rj2ekgjW2lI35f5gjVGsbAgvdOSh7HJaacq8hH65XTN78z4ersN4bVTArRL3I7W6TzZ1AfAtpwJZnamZa0XLWEkycNnyfWMZzAH8bh+wfkMeNNwaXgO1R7hXthHLZv1Ma+9Z7ic5nL7mzJIdSRxcp+8ANy3BnwjQPJl7bH+N3mHGh1aHqlxKndo9D4b3Ix3VgA7+KAxeC0vztL+S2+mdbwdJMJS7yWoC7utdsy2lpjZw01B9MyiTeFJtGyC6UKmxYzs7plSMblvUTQBefU6uPT10Z5fFmNLQIRZzH7/ppgsv1sgJ9mBqnpndQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(7696005)(6506007)(71200400001)(9686003)(26005)(53546011)(55236004)(38070700005)(86362001)(478600001)(41300700001)(186003)(83380400001)(7416002)(122000001)(38100700002)(76116006)(4326008)(8676002)(30864003)(44832011)(8936002)(5660300002)(6916009)(55016003)(316002)(66946007)(33656002)(54906003)(64756008)(66476007)(52536014)(2906002)(66556008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JOIpz+2vCBZ8tIQmv2Da0HTQNLKG6/AA2It31+e6Z02bQbsDuPBkHHnDUlT9?=
 =?us-ascii?Q?bJfNZ24LvXC5DfyZLSzocEKU7v1VZglLL4byh40GpIWk61O+wqCQMy8CncRb?=
 =?us-ascii?Q?oEZYdsIdD6x0bDixibkW4th7NZPM5yJNErFQDg52I8OALgykxIolVoc/tfIr?=
 =?us-ascii?Q?ve0c4uFPNQLhGrIkeW39mETMyzfnep/NkiAlDhl3NZXJ7kCF1Sr1Q7lpWuiK?=
 =?us-ascii?Q?mbqXq+LYdLv85ELRhPPyyh+yb4blXRebqEhP/YdOAk3pd84+PMk4D5tNTCSw?=
 =?us-ascii?Q?BTwNAqt1AVUPELplPQDgzVzGcBCPIwFYxJCzgfJ0nY2wzVsAUFCLBZvI00ur?=
 =?us-ascii?Q?lCGjS07jkQgLliWS47FR7B1EOxG6x4oyEkM3mPYT77iL0zPwDW8vbfse/dw6?=
 =?us-ascii?Q?r/kUp5cyhDmU7GXDTZNnLcqUOByZgan3yyyWAgejVI9+IRRdhfrtNx0n9+nP?=
 =?us-ascii?Q?F5uYzqS61QS+PH3jPPKO5Q0ozU8UzQrvjSo6PFRtg+MB1XYPySOlQyZOctOQ?=
 =?us-ascii?Q?c85dPR3mC34NPKXUBygbfqGPUEoOvp0Uh37LpY+czOhUqY7VQuc1ozxQ10+/?=
 =?us-ascii?Q?6XCCUEBR6GHHq9YygbuYro5R4ywkdwid6O1YpbfAPkYNtIbaSzc183gjik8+?=
 =?us-ascii?Q?vzniL4BbOKxhB0vpATGulfxQPMpk9enyTHPS1LO5Lfzj2btZUVi9gMSk6mt+?=
 =?us-ascii?Q?6at4vyhd92qjeZkQqaqKUHpvu9sjz2fZqNV7TbX9kj9eOjugrzlS2uuOqUP4?=
 =?us-ascii?Q?Z4EkLMr0QArWJ2HJ90Qxa71wIK+zZSF0cCYJxrto+Sm8slFvm7tQoJQ0cUJn?=
 =?us-ascii?Q?XFmMc4RiAmFHUXj27/rXS3H1WQyyRTSs2j2+QFS5NrLMk3A8kCN5rZEVhMu4?=
 =?us-ascii?Q?prMZkCfMGrfFxZh0XDwNJ6yWt9KqFxv7OhSRr1ctFqx1Hj0bUazRSdcJOqtK?=
 =?us-ascii?Q?4qd26QVdQFWR7mFQeSyu6zKH9TDpB5tscEt7fZLEwHzy9Mv4NNmKrMvR8rCy?=
 =?us-ascii?Q?Q45eiir1+BsCJGde774I1QPQ+2SShsy+iJRc2b7G7wkfADJuoBu6RGC0jrun?=
 =?us-ascii?Q?3cVwcpHqt4Dj07dhYne56zJ0iXfODZEdinAy7B8/8gXij2KkyYCK/HxeGPBK?=
 =?us-ascii?Q?pQtX9cyrpGmo//xK2rtco/Rxgae4wopmBPOhD8FngMsXKPwoSOcBZbMooJbG?=
 =?us-ascii?Q?lPDg6ePftQuWB8rEzcHM3SZZHLkTnhOWoZFtvbmccSth/YlV438AJ7GTcCsE?=
 =?us-ascii?Q?eQosrrw2LJfj9sc6XQE1axhaBatCSPfhI14U3UgDyqwXliKSi8JE6UxBKV7A?=
 =?us-ascii?Q?ZNaEhe5vttL4NQIk9AwACIaQrCcGH5lsCRnteZXPCReMDWxTp7bS8M8rXicg?=
 =?us-ascii?Q?fSpoCLaoK90dTqwn+vgp6/h/r6yhetdUh3vYSlbopKtECg3tgmbpPkHJFQuO?=
 =?us-ascii?Q?OEuRTN2EcUVG5w1E6FMt1gH4tmm4qke5T7HCsaHhMUANBm51OH0BXz2nrAQl?=
 =?us-ascii?Q?EwqxRio5eEmFEE6ApvDPU2T8WpzWnGmvyijFyWQgVaZUPi4xl2Z6SbXzbVJC?=
 =?us-ascii?Q?VEzbJZdppgd3U8ZNGKc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169404a4-f47a-4dd2-013b-08da91a5c1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 14:23:53.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GI7Sv7Br3+UL/eT/IRhb06Sn7VX2dlBrXbxCYL+UO6sv6gqbg1GjZUU/A9Qc7CAWB8mkFIb3nag/UGUWeSVVOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3662
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
> Sent: Thursday, September 8, 2022 2:40 AM
> To: Frank Li <frank.li@nxp.com>
> Cc: tglx@linutronix.de; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> jdmason@kudzu.us; kernel@pengutronix.de; festevam@gmail.com; dl-linux-
> imx <linux-imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> ntb@lists.linux.dev; lznuaa@gmail.com; imx@lists.linux.dev;
> manivannan.sadhasivam@linaro.org
> Subject: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller driv=
er
>=20
> Caution: EXT Email
>=20
> On Wed, 07 Sep 2022 04:48:54 +0100,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > The MU block found in a number of Freescale/NXP SoCs supports
> generating
> > IRQs by writing data to a register
> >
> > This enables the MU block to be used as a MSI controller, by leveraging
> > the platform-MSI API
>=20
> Missing full stop after each sentence.

[Frank Li] Do you means missed "."?
=20

>=20
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/irqchip/Kconfig          |   9 +
> >  drivers/irqchip/Makefile         |   1 +
> >  drivers/irqchip/irq-imx-mu-msi.c | 451
> +++++++++++++++++++++++++++++++
> >  3 files changed, 461 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-imx-mu-msi.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 5e4e50122777d..e04c6521dce55 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -470,6 +470,15 @@ config IMX_INTMUX
> >       help
> >         Support for the i.MX INTMUX interrupt multiplexer.
> >
> > +config IMX_MU_MSI
> > +     bool "i.MX MU work as MSI controller"
>=20
> Why bool? Doesn't it also work as a module?

[Frank Li] I remember you said that irq-chip can't be removed.=20
So I am not sure why need build as module. =20

>=20
> > +     default y if ARCH_MXC
>=20
> Why would this be selected by default?
>=20
> > +     select IRQ_DOMAIN
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     select GENERIC_MSI_IRQ_DOMAIN
> > +     help
> > +       MU work as MSI controller to do general doorbell
>=20
> I'm not sure this is that generic. It really is limited to CPU-to-CPU
> interrupts.
>=20
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
> > index 0000000000000..82b55f6d87266
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-imx-mu-msi.c
> > @@ -0,0 +1,451 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Freescale MU worked as MSI controller
>=20
> s/worked/used/
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
>=20
> Keep this list in alphabetical order.
>=20
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
>=20
> What is this last enum used for?
>=20
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
>=20
> This is never used. Why?
>=20
> > +     IMX_MU_V2 =3D BIT(1),
> > +     IMX_MU_V2_S4 =3D BIT(15),
>=20
> Same thing.
>=20
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
> > +     raw_spinlock_t                  reglock;
>=20
> Why two locks? Isn't one enough to protect both MSI allocation (which
> happens once in a blue moon) and register access?

[Frank Li] Previously your comment, ask me to use raw_spinlock for read\wri=
te register access.=20
I don't think raw_spinlock is good for MSI allocation.=20

>=20
> Also, where are these locks initialised?
>=20

[Frank Li] struct imx_mu_msi is fill zero when allocated.
Does it still need additional initialization for spinlock?

> > +     struct irq_domain               *msi_domain;
> > +     void __iomem                    *regs;
> > +     phys_addr_t                     msiir_addr;
> > +     const struct imx_mu_dcfg        *cfg;
> > +     unsigned long                   used;
> > +     struct clk                      *clk;
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
> > +     raw_spin_lock_irqsave(&msi_data->reglock, flags);
> > +     val =3D imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
> > +     val &=3D ~clr;
> > +     val |=3D set;
> > +     imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
> > +     raw_spin_unlock_irqrestore(&msi_data->reglock, flags);
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
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
> > +
> > +     imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
> > +}
> > +
> > +static struct irq_chip imx_mu_msi_irq_chip =3D {
> > +     .name =3D "MU-MSI",
> > +     .irq_ack =3D irq_chip_ack_parent,
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
> > +static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
> > +                                       struct msi_msg *msg)
> > +{
> > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(data);
> > +     u64 addr =3D msi_data->msiir_addr + 4 * data->hwirq;
> > +
> > +     msg->address_hi =3D upper_32_bits(addr);
> > +     msg->address_lo =3D lower_32_bits(addr);
> > +     msg->data =3D data->hwirq;
> > +}
> > +
> > +static int imx_mu_msi_parent_set_affinity(struct irq_data *irq_data,
> > +                                const struct cpumask *mask, bool force=
)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static struct irq_chip imx_mu_msi_parent_chip =3D {
> > +     .name           =3D "MU",
> > +     .irq_mask       =3D imx_mu_msi_parent_mask_irq,
> > +     .irq_unmask     =3D imx_mu_msi_parent_unmask_irq,
> > +     .irq_ack        =3D imx_mu_msi_parent_ack_irq,
> > +     .irq_compose_msi_msg    =3D imx_mu_msi_parent_compose_msg,
> > +     .irq_set_affinity =3D imx_mu_msi_parent_set_affinity,
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
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     u32 status;
> > +     int i;
> > +
> > +     status =3D imx_mu_read(msi_data, msi_data->cfg->xSR[IMX_MU_RSR]);
> > +
> > +     chained_irq_enter(chip, desc);
> > +     for (i =3D 0; i < IMX_MU_CHANS; i++) {
> > +             if (status & IMX_MU_xSR_RFn(msi_data, i))
> > +                     generic_handle_domain_irq(msi_data->msi_domain, i=
);
> > +     }
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct
> device *dev)
> > +{
> > +     struct fwnode_handle *fwnodes =3D dev_fwnode(dev);
> > +     struct irq_domain *parent;
> > +
> > +     /* Initialize MSI domain parent */
> > +     parent =3D irq_domain_create_linear(fwnodes,
> > +                                         IMX_MU_CHANS,
> > +                                         &imx_mu_msi_domain_ops,
> > +                                         msi_data);
> > +     if (!parent) {
> > +             dev_err(dev, "failed to create IRQ domain\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
> > +
> > +     msi_data->msi_domain =3D platform_msi_create_irq_domain(
> > +                             fwnodes,
> > +                             &imx_mu_msi_domain_info,
> > +                             parent);
>=20
> nit: move the first argument after the opening bracket (longer lines
> are fine).
>=20
> > +
> > +     if (!msi_data->msi_domain) {
> > +             dev_err(dev, "failed to create MSI domain\n");
> > +             irq_domain_remove(parent);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     irq_domain_set_pm_device(msi_data->msi_domain, dev);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Register offset of different version MU IP */
> > +static const struct imx_mu_dcfg imx_mu_cfg_imx6sx =3D {
>=20
> Why doesn't this have a type?
>=20
> > +     .xTR    =3D 0x0,
> > +     .xRR    =3D 0x10,
> > +     .xSR    =3D {0x20, 0x20, 0x20, 0x20},
>=20
> Since you defined enums for all the register offsets, please be
> consistent and use them everywhere:
>=20
>         .xSR =3D {
>                 [IMX_MU_SR]     =3D 0x20,
>                 [IMX_MU_GSR]    =3D 0x20,
>                 [...]
>         },
>=20
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
> > +                              const struct imx_mu_dcfg *cfg
> > +                             )
>=20
> Move closing bracket after 'cfg'.
>=20
> > +{
> > +     struct platform_device *pdev =3D of_find_device_by_node(dn);
> > +     struct device_link *pd_link_a;
> > +     struct device_link *pd_link_b;
> > +     struct imx_mu_msi *msi_data;
> > +     struct resource *res;
> > +     struct device *pd_a;
> > +     struct device *pd_b;
> > +     struct device *dev;
> > +     int ret;
> > +     int irq;
> > +
> > +     if (!pdev)
> > +             return -ENODEV;
>=20
> How can that happen?
>=20
[Frank Li] Not sure, many driver check as it.=20

> > +
> > +     dev =3D &pdev->dev;
> > +
> > +     msi_data =3D devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERN=
EL);
> > +     if (!msi_data)
> > +             return -ENOMEM;
> > +
> > +     msi_data->cfg =3D cfg;
> > +
> > +     msi_data->regs =3D devm_platform_ioremap_resource_byname(pdev,
> "processor-a-side");
> > +     if (IS_ERR(msi_data->regs)) {
> > +             dev_err(&pdev->dev, "failed to initialize 'regs'\n");
> > +             return PTR_ERR(msi_data->regs);
> > +     }
> > +
> > +     res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "processor-b-side");
> > +     if (!res)
> > +             return -EIO;
> > +
> > +     msi_data->msiir_addr =3D res->start + msi_data->cfg->xTR;
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq <=3D 0)
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
>=20
> Why is it acceptable to continue with no clock?
>=20
> > +     }
> > +
> > +     pd_a =3D dev_pm_domain_attach_by_name(dev, "processor-a-side");
> > +     if (IS_ERR(pd_a))
> > +             return PTR_ERR(pd_a);
> > +
> > +     pd_b =3D dev_pm_domain_attach_by_name(dev, "processor-b-side");
> > +     if (IS_ERR(pd_b))
> > +             return PTR_ERR(pd_b);
> > +
> > +     pd_link_a =3D device_link_add(dev, pd_a,
> > +                     DL_FLAG_STATELESS |
> > +                     DL_FLAG_PM_RUNTIME |
> > +                     DL_FLAG_RPM_ACTIVE);
> > +
> > +     if (!pd_link_a) {
> > +             dev_err(dev, "Failed to add device_link to mu a.\n");
> > +             goto err_pd_a;
> > +     }
> > +
> > +     pd_link_b =3D device_link_add(dev, pd_b,
> > +                     DL_FLAG_STATELESS |
> > +                     DL_FLAG_PM_RUNTIME |
> > +                     DL_FLAG_RPM_ACTIVE);
> > +
> > +
> > +     if (!pd_link_b) {
> > +             dev_err(dev, "Failed to add device_link to mu a.\n");
> > +             goto err_pd_b;
> > +     }
> > +
> > +     ret =3D imx_mu_msi_domains_init(msi_data, dev);
> > +     if (ret)
> > +             goto err_dm_init;
> > +
> > +     irq_set_chained_handler_and_data(irq,
> > +                                      imx_mu_msi_irq_handler,
> > +                                      msi_data);
> > +
> > +     pm_runtime_enable(dev);
>=20
> Shouldn't you enable the device PM before registering the chained
> handler?
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
