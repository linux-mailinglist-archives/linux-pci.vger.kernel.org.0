Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC6581BC8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 23:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiGZVsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 17:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGZVsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 17:48:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331732D9A;
        Tue, 26 Jul 2022 14:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcFEtDDYc+gC8SPnWqGo1CvvqH2tU9jgdjMuINBy+hObgNRU8QxgmqmCyz1Fy3zL8hN52OesTqDrRYWqXAphs6r0WkYpTkp0Om+1T6vNluM2KXiVjjdVE7GmXIITftaMqllNEHSUnSv3xVC/IOLicy++xVWKuWJT/HmsRGdbFU7qYXJkbOah2+ldnx44jCoP1fVnVtjO/Ht+OUK9ETW2kXZXWEO6ewj23DMwDJpVpFzp9HQLB1O26tKCVXu/hj7xRYhHo4N636i+cqyoIuNF7TP4WadFFCAHTkXA+BDCsKWpJ0GYVwTIztNaumqTZv60ItRGXZBv1nTAkrYe0aZJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJXrJjRCkpj5TT1yEcHAdS+BkG7HnK9xbH8p1nP7GUY=;
 b=WBLV9uzd6BkQ0Gupp4peGMQvhHYIBAM7N7iB7T35Wy/W9b6Uy9mS3PNN1cf5C9e7eeittcwbPsfbKvG8VxAHGslefilvslGmKNvhWUWlgCgN3ebJkGNm+pkP32jVDMi/joAiX+nT8Zyup6/zM6k5XqM81oaS0nQc62Trp6mZCA5+oZnGPYOv3u9qLQYeXCx12uEbaI5+FEkzHjyisFx/TnnSJpxyU1pA7Nv6zQZ7+menn/S9AmM/oU3CUwBQT9W5NamfGM3c2/DIEDjOjGqJ4dgRJeG9zHlSogbF9T5WDfTrYjAUea8FUfttWJerpgQUGwSqQ6ghSSYTjIrLYyV8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJXrJjRCkpj5TT1yEcHAdS+BkG7HnK9xbH8p1nP7GUY=;
 b=LbkyVXvFOQWliGMEcDfIZWvHhgO64TaVptoUjGp7jEFJBj4sCjor990EWFtT6+4UHa1IKL2KfPOjoFB/M4uIqVPW/LPOGeelZ8AUw3CzDFBs82yY3M62mvoSS19U2l/z4Mp3/IyNtPweDRTRDUO9SUBPzeKazndfh81r/2+j9zM=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5473.eurprd04.prod.outlook.com (2603:10a6:208:112::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 21:48:33 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5%8]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 21:48:32 +0000
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
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7CAAAWJAIAIQw5A
Date:   Tue, 26 Jul 2022 21:48:32 +0000
Message-ID: <PAXPR04MB918621013E6276D37B56C48488949@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
        <20220720213036.1738628-3-Frank.Li@nxp.com>     <874jza525l.wl-maz@kernel.org>
        <PAXPR04MB9186A1D283ACE8BD6954039288919@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <87wnc6xz6r.wl-maz@kernel.org>
In-Reply-To: <87wnc6xz6r.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d355cf4-a63e-40f6-4532-08da6f5095dd
x-ms-traffictypediagnostic: AM0PR04MB5473:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8vb25QwXESsuL96QjVRuPx9/x6/1LlqQQHFGm34/HPv4qXUMD1hcn2icQTKorhS6ZVid/WLRf33NQmD496VuJTYVW1jVm4NrpxKeY54osSiFlcUi0NnQR24WVPLKQbWo3I37YSqIuHR/6y+bf9IEmUujl8yynQ4HK+lna8+mNTIL1Lv0702QQpuqSssbxWQSN9Sd4qB79u/mmixP8jeT39l2pddC3pI/V6klL/HwbkWrh4+04VPavLUDPsQBlxofq5fwY3aB4o7zEcoc/dLm6VxYLP9w/umUuGuaTWvGXUMSiFuW9r3IWhohzHZBNNB0/gKiJCPP3rSLvevid9xLN+TC9D29bsQ/VxW9PvdZ4B6upnAqRLJ6PiLbWyiSpOFUlk7nz2QeHhXOUzasjyu4Bd+A2+v0+uuyrOsPqxSbFTN2/E+rIFQGTwHioB28Qu8QiBp0xFv2F9FmecgGwXFh+QI2NjbWxJp1cUeF4GWzqodC3v+0xEKuzyEphX9N6/agWYWWAOFtVMzV3OtfXL5QLCWe8uc1EuF/PhknZd2ytf9edHazcYzHupaWnDRnkLqRYFYac2oXFcBM4vGTNY9d+/ndExDF7OQmpINguaa1ng4GId9p6JR2rE1FMIShOadIYdpFeN45/hN1095p0NM4F2aVlJuYpt0qRukPrbgCLewxXE4Tw/u+zglp8ePPpgrM8hLP9kH9exZXr4bvBuHQrxjzJzLZfc41YyTlXg7TvEPprPqLdbf/kVU2zI7xSE4JkI6+KDuA4bKyJczhfdVt5qCi+vvt/rgjUrXVqfq4ofY2aBxiNp4Ccph6Yw/yLPC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(122000001)(38070700005)(33656002)(86362001)(38100700002)(5660300002)(8936002)(7416002)(30864003)(44832011)(478600001)(316002)(66556008)(83380400001)(71200400001)(8676002)(66476007)(4326008)(66946007)(76116006)(9686003)(52536014)(186003)(54906003)(6916009)(2906002)(41300700001)(55236004)(6506007)(26005)(55016003)(53546011)(64756008)(66446008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?93vTD/nh8aPt9LZj2HXH39abbY0u7cM4E5bP9ovifsrD/cDGQr/jqMFKe0if?=
 =?us-ascii?Q?6imft0uVcK7pAHEu4zkcOX5SXBISAnF3PskJdfsy2iAr11rFuq9sKbUzj9wl?=
 =?us-ascii?Q?6hUeawnmAfAtmObEvVSNOpshJywtaNFqhK2dr+sQEKB+7Iz7lUn8XdrmHpAb?=
 =?us-ascii?Q?sgzwWNKnDTZxYanz38iB4GWCB4HS5tHXSM1VZJEJQ2YDt+Cdww7UR76G282n?=
 =?us-ascii?Q?4ZmudqxUuHGbLbRO4+CYH8xf4QyBc8P5QvgnU0WjTzi/Ecg0oZAEpXQtDICr?=
 =?us-ascii?Q?D0D4baljk/2+Nfhddohxw91GbUWtT2KSoXSIyRxbee94jhR+xFY8uCUPnA3a?=
 =?us-ascii?Q?x3or17bp0oc3QnhpSan642ScqUoF+by0aEL7iP2jj3Se/Gstdwm6ohTKxgFa?=
 =?us-ascii?Q?Qd+Re86pI1oY3NdJ/PukrLfS7vX90L1Uk4H7DgYGT7DNSrzXcFmcKTMSyuuV?=
 =?us-ascii?Q?tBi5MZhSY4qm//35ychbyS14kA2RUGOuGIWB2AxTOJi5FaOgQo0t6pY7DUSt?=
 =?us-ascii?Q?rLpPagWAvuR6G2BZA0aklAfRC135st/i0hiJcRJL1hVWIn0mFMYeUszsIOBA?=
 =?us-ascii?Q?immO1U01HUp2TkJcy+yTA8jgJWxLEBJmjWliqpr7Ji7QYCFWpqhqggPp3ciu?=
 =?us-ascii?Q?x6QNpOFjgyvy6SFKLzCkhuPxtKVHrEmyvqIZianMJ6nisjo2mMy2N00SNjly?=
 =?us-ascii?Q?Oo2sJEvrLAeKCor5Is28JUfQ7JNsPnNzx6JEDMC/tOFAhQQILF/I9d+KHN6E?=
 =?us-ascii?Q?FPaexL6bTdqbDMXsKZ4rpMa/IJG9YMSaO8dI+OUewVbSURxnyQSugy03amEv?=
 =?us-ascii?Q?RG5Gn4LxgbFg1G6qnRdKc5advli9kfPU04CkqQoMWVBYcZ2THSpYSCYAAOIN?=
 =?us-ascii?Q?NiaX5XjHaa7lJuf1GP8vUqUecWTGQPJhdnLbctB51yTdZB0AAt5b3O5A+/fy?=
 =?us-ascii?Q?3kagiO8FHNEmA9x/un7ZIUSxpoxN0v80NGvKy6W2RBJc+IXXIM4vbciBtJzk?=
 =?us-ascii?Q?o4dDrHvlMKSUazCHtOJdrujpCzG2GkkpBw2S7ysmS9lubocFc16YYOadxWgh?=
 =?us-ascii?Q?NftPDOn0DCXrlWCKmKp2+X8IwHOxWszDDNV/EbQPy3WDChdoFKHwYqq7s4ld?=
 =?us-ascii?Q?aM4mTcZsmoEbTG5bosBp7pYUdxkk75wuJj72LrA/n++a10CV79zCUN4gyolC?=
 =?us-ascii?Q?fqySMKmPhICh6iBHPMTTCwRviC8ilULQE72YJt4gckrbkDP+/u7xpxsLNclm?=
 =?us-ascii?Q?fF+2NYEE5r6aPYhDndpcrCauCSI12fPr6hrZ6xLy0E7QHe8+xVRvyEDQEyml?=
 =?us-ascii?Q?Smda43KdVNJ7C2mO0VGH9BWOIw5AvAIW6ACqfc19E3zxxE0681zoRaalSH8u?=
 =?us-ascii?Q?nNnMEPzb3JVCSaKxd8/gy3i5LHv+bI+9j+KHj2FTjwxlftgEpmcolc+ecENX?=
 =?us-ascii?Q?m86V9kCXboxpyjPoftM8Zv5At2/EIAQqIQfCCpGuIttQBO98FTCrcTPAtnWf?=
 =?us-ascii?Q?yhFeILxylR0r9lLYH1j19splFfL3Vh8JaxBlzPSJm7Mdz5ulaU+qGqiuJHk5?=
 =?us-ascii?Q?OJ3keFmbmPAkrg96l8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d355cf4-a63e-40f6-4532-08da6f5095dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 21:48:32.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wmaSowmLtHaloQ+Oh1eSg6gF4GtP0bj2YHD0LqL70IKOpD+shMoGhZum+qBuh4QznX7jgXCvo2V4qH50GR0OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5473
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
> Sent: Thursday, July 21, 2022 10:28 AM
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
> Subject: Re: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> controller
>=20
> Caution: EXT Email
>=20
> On Thu, 21 Jul 2022 16:22:08 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Marc Zyngier <maz@kernel.org>
> > > Sent: Thursday, July 21, 2022 2:57 AM
> > > To: Frank Li <frank.li@nxp.com>
> > > Cc: jdmason@kudzu.us; tglx@linutronix.de; robh+dt@kernel.org;
> > > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; kw@linux.com; bhelgaas@google.com;
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; linux-pci@vger.kernel.org; Peng Fan
> > > <peng.fan@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> > > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > > imx@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com;
> > > ntb@lists.linux.dev
> > > Subject: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> controller
> > >
> > > Caution: EXT Email
> > >
> > > On Wed, 20 Jul 2022 22:30:34 +0100,
> > > Frank Li <Frank.Li@nxp.com> wrote:
> > > >
> > > > MU support generate irq by write data to a register.
> > > > This patch make mu worked as msi controller.
> > > > So MU can do doorbell by using standard msi api.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/irqchip/Kconfig          |   7 +
> > > >  drivers/irqchip/Makefile         |   1 +
> > > >  drivers/irqchip/irq-imx-mu-msi.c | 462
> > > +++++++++++++++++++++++++++++++
> > > >  3 files changed, 470 insertions(+)
> > > >  create mode 100644 drivers/irqchip/irq-imx-mu-msi.c
> > > >
> > > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > > index 5e4e50122777d..4599471d880c0 100644
> > > > --- a/drivers/irqchip/Kconfig
> > > > +++ b/drivers/irqchip/Kconfig
> > > > @@ -470,6 +470,13 @@ config IMX_INTMUX
> > > >       help
> > > >         Support for the i.MX INTMUX interrupt multiplexer.
> > > >
> > > > +config IMX_MU_MSI
> > > > +     bool "i.MX MU work as MSI controller"
> > > > +     default y if ARCH_MXC
> > > > +     select IRQ_DOMAIN
> > > > +     help
> > > > +       MU work as MSI controller to do general doorbell
> > > > +
> > > >  config LS1X_IRQ
> > > >       bool "Loongson-1 Interrupt Controller"
> > > >       depends on MACH_LOONGSON32
> > > > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > > > index 5d8e21d3dc6d8..870423746c783 100644
> > > > --- a/drivers/irqchip/Makefile
> > > > +++ b/drivers/irqchip/Makefile
> > > > @@ -98,6 +98,7 @@ obj-$(CONFIG_RISCV_INTC)            +=3D irq-risc=
v-
> intc.o
> > > >  obj-$(CONFIG_SIFIVE_PLIC)            +=3D irq-sifive-plic.o
> > > >  obj-$(CONFIG_IMX_IRQSTEER)           +=3D irq-imx-irqsteer.o
> > > >  obj-$(CONFIG_IMX_INTMUX)             +=3D irq-imx-intmux.o
> > > > +obj-$(CONFIG_IMX_MU_MSI)             +=3D irq-imx-mu-msi.o
> > > >  obj-$(CONFIG_MADERA_IRQ)             +=3D irq-madera.o
> > > >  obj-$(CONFIG_LS1X_IRQ)                       +=3D irq-ls1x.o
> > > >  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)    +=3D irq-ti-sci-intr.o
> > > > diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq=
-imx-
> mu-
> > > msi.c
> > > > new file mode 100644
> > > > index 0000000000000..8277dba857759
> > > > --- /dev/null
> > > > +++ b/drivers/irqchip/irq-imx-mu-msi.c
> > > > @@ -0,0 +1,462 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * NXP MU worked as MSI controller
> > > > + *
> > > > + * Copyright (c) 2018 Pengutronix, Oleksij Rempel
> > > <o.rempel@pengutronix.de>
> > > > + * Copyright 2022 NXP
> > > > + *   Frank Li <Frank.Li@nxp.com>
> > > > + *   Peng Fan <peng.fan@nxp.com>
> > > > + *
> > > > + * Based on drivers/mailbox/imx-mailbox.c
> > > > + */
> > > > +#include <linux/clk.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/msi.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/irqchip/chained_irq.h>
> > > > +#include <linux/irqchip.h>
> > > > +#include <linux/irqdomain.h>
> > > > +#include <linux/of_irq.h>
> > > > +#include <linux/of_pci.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/spinlock.h>
> > > > +#include <linux/dma-iommu.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +#include <linux/pm_domain.h>
> > > > +
> > > > +
> > > > +#define IMX_MU_CHANS            4
> > > > +
> > > > +enum imx_mu_xcr {
> > > > +     IMX_MU_GIER,
> > > > +     IMX_MU_GCR,
> > > > +     IMX_MU_TCR,
> > > > +     IMX_MU_RCR,
> > > > +     IMX_MU_xCR_MAX,
> > > > +};
> > > > +
> > > > +enum imx_mu_xsr {
> > > > +     IMX_MU_SR,
> > > > +     IMX_MU_GSR,
> > > > +     IMX_MU_TSR,
> > > > +     IMX_MU_RSR,
> > > > +};
> > > > +
> > > > +enum imx_mu_type {
> > > > +     IMX_MU_V1 =3D BIT(0),
> > > > +     IMX_MU_V2 =3D BIT(1),
> > > > +     IMX_MU_V2_S4 =3D BIT(15),
> > > > +};
> > > > +
> > > > +/* Receive Interrupt Enable */
> > > > +#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) :
> BIT(24
> > > + (3 - (x))))
> > > > +#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) :
> BIT(24 +
> > > (3 - (x))))
> > > > +
> > > > +struct imx_mu_dcfg {
> > > > +     enum imx_mu_type type;
> > > > +     u32     xTR;            /* Transmit Register0 */
> > > > +     u32     xRR;            /* Receive Register0 */
> > > > +     u32     xSR[4];         /* Status Registers */
> > > > +     u32     xCR[4];         /* Control Registers */
> > > > +};
> > > > +
> > > > +struct imx_mu_msi {
> > > > +     spinlock_t                      lock;
> > > > +     struct platform_device          *pdev;
> > > > +     struct irq_domain               *parent;
> > > > +     struct irq_domain               *msi_domain;
> > > > +     void __iomem                    *regs;
> > > > +     phys_addr_t                     msiir_addr;
> > > > +     const struct imx_mu_dcfg        *cfg;
> > > > +     unsigned long                   used;
> > > > +     u32                             gic_irq;
> > > > +     struct clk                      *clk;
> > > > +     struct device                   *pd_a;
> > > > +     struct device                   *pd_b;
> > > > +     struct device_link              *pd_link_a;
> > > > +     struct device_link              *pd_link_b;
> > > > +};
> > > > +
> > > > +static void imx_mu_write(struct imx_mu_msi *msi_data, u32 val, u32
> offs)
> > > > +{
> > > > +     iowrite32(val, msi_data->regs + offs);
> > > > +}
> > > > +
> > > > +static u32 imx_mu_read(struct imx_mu_msi *msi_data, u32 offs)
> > > > +{
> > > > +     return ioread32(msi_data->regs + offs);
> > > > +}
> > > > +
> > > > +static u32 imx_mu_xcr_rmw(struct imx_mu_msi *msi_data, enum
> > > imx_mu_xcr type, u32 set, u32 clr)
> > > > +{
> > > > +     unsigned long flags;
> > > > +     u32 val;
> > > > +
> > > > +     spin_lock_irqsave(&msi_data->lock, flags);
> > > > +     val =3D imx_mu_read(msi_data, msi_data->cfg->xCR[type]);
> > > > +     val &=3D ~clr;
> > > > +     val |=3D set;
> > > > +     imx_mu_write(msi_data, val, msi_data->cfg->xCR[type]);
> > > > +     spin_unlock_irqrestore(&msi_data->lock, flags);
> > > > +
> > > > +     return val;
> > > > +}
> > > > +
> > > > +static void imx_mu_msi_mask_irq(struct irq_data *data)
> > > > +{
> > > > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(da=
ta-
> > > >parent_data);
> > >
> > > Urgh... No. Please don't go poking into the *parent* stuff. Implement
> > > the masking at the parent level, and use irq_chip_mask_parent() for
> > > this level, unless you can explain why you can't do otherwise.
> > >
> > > > +
> > > > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR, 0,
> > > IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq));
> > >
> > > How about making this readable and move the dereference inside the
> macro?
> > >
> > > > +}
> > > > +
> > > > +static void imx_mu_msi_unmask_irq(struct irq_data *data)
> > > > +{
> > > > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(da=
ta-
> > > >parent_data);
> > > > +
> > > > +     imx_mu_xcr_rmw(msi_data, IMX_MU_RCR,
> > > IMX_MU_xCR_RIEn(msi_data->cfg->type, data->hwirq), 0);
> > > > +}
> > > > +
> > > > +static struct irq_chip imx_mu_msi_irq_chip =3D {
> > > > +     .name =3D "MU-MSI",
> > > > +     .irq_mask       =3D imx_mu_msi_mask_irq,
> > > > +     .irq_unmask     =3D imx_mu_msi_unmask_irq,
> > > > +};
> > > > +
> > > > +static struct msi_domain_ops its_pmsi_ops =3D {
> > > > +};
> > >
> > > What does this have to do with the ITS?
> >
> > Without this, it will be crashed as access 0 address.
>=20
> Because the *name* of the structure has an influence on the behaviour
> of the kernel?????
>=20
> >
> > >
> > > > +
> > > > +static struct msi_domain_info imx_mu_msi_domain_info =3D {
> > > > +     .flags  =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> > > > +                MSI_FLAG_USE_DEF_CHIP_OPS |
> > > > +                MSI_FLAG_PCI_MSIX),
> > >
> > > What does PCI_MSIX mean in this context? I really wish you used
> > > copy/paste a bit more carefully.
> > >
> > > > +     .ops    =3D &its_pmsi_ops,
> > > > +     .chip   =3D &imx_mu_msi_irq_chip,
> > > > +};
> > > > +
> > > > +static void imx_mu_msi_compose_msg(struct irq_data *data, struct
> > > msi_msg *msg)
> > > > +{
> > > > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(da=
ta);
> > > > +
> > > > +     msg->address_hi =3D upper_32_bits(msi_data->msiir_addr);
> > > > +     msg->address_lo =3D lower_32_bits(msi_data->msiir_addr + 4 * =
data-
> > > >hwirq);
> > >
> > > This is a horrible way of writing this. you should compute the addres=
s
> > > first, and then apply the address split.
> > >
> > > > +     msg->data =3D data->hwirq;
> > > > +
> > > > +     iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data),
> msg);
> > > > +}
> > > > +
> > > > +static int imx_mu_msi_set_affinity(struct irq_data *irq_data,
> > > > +                                const struct cpumask *mask, bool f=
orce)
> > > > +
> > > > +{
> > > > +     return IRQ_SET_MASK_OK;
> > > > +}
> > >
> > > Err... What effect does this have if you don't do anything?
> >
> > [Frank Li] Without this, it will be crashed as access 0 address.
>=20
> Then you should fix that bug, because what you have here makes
> absolutely no sense.
>=20
> >
> > >
> > > > +
> > > > +static struct irq_chip imx_mu_msi_parent_chip =3D {
> > > > +     .name                   =3D "MU",
> > > > +     .irq_compose_msi_msg    =3D imx_mu_msi_compose_msg,
> > > > +     .irq_set_affinity =3D imx_mu_msi_set_affinity,
> > > > +};
> > > > +
> > > > +static int imx_mu_msi_domain_irq_alloc(struct irq_domain *domain,
> > > > +                                     unsigned int virq,
> > > > +                                     unsigned int nr_irqs,
> > > > +                                     void *args)
> > > > +{
> > > > +     struct imx_mu_msi *msi_data =3D domain->host_data;
> > > > +     msi_alloc_info_t *info =3D args;
> > > > +     int pos, err =3D 0;
> > > > +
> > > > +     WARN_ON(nr_irqs !=3D 1);
> > > > +
> > > > +     spin_lock(&msi_data->lock);
> > >
> > > Interrupt fires after lock acquisition, handler masks the interrupt.
> > > Deadlock.
> >
> > [Frank Li] you are right, it should be spin_lock_irqsave.
> >
> > >
> > > > +     pos =3D find_first_zero_bit(&msi_data->used, IMX_MU_CHANS);
> > > > +     if (pos < IMX_MU_CHANS)
> > > > +             __set_bit(pos, &msi_data->used);
> > > > +     else
> > > > +             err =3D -ENOSPC;
> > > > +     spin_unlock(&msi_data->lock);
> > > > +
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     err =3D iommu_dma_prepare_msi(info->desc, msi_data->msiir_add=
r
> +
> > > pos * 4);
> > >
> > > Does this HW even have an IOMMU?
> >
> > [Frank Li] we have a platform with iommu.
> >
> > >
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     irq_domain_set_info(domain, virq, pos,
> > > > +                         &imx_mu_msi_parent_chip, msi_data,
> > > > +                         handle_simple_irq, NULL, NULL);
> > >
> > > This is an edge interrupt. Please handle it like one.
> >
> > [Frank Li]  Not sure what your means?
>=20
> A MSI is an edge interrupt. Use handle_edge_irq.
>=20
> >
> > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
> > > > +                                    unsigned int virq, unsigned in=
t nr_irqs)
> > > > +{
> > > > +     struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> > > > +     struct imx_mu_msi *msi_data =3D irq_data_get_irq_chip_data(d)=
;
> > > > +
> > > > +     spin_lock(&msi_data->lock);
> > >
> > > Same problem.
> > >
> > > > +     __clear_bit(d->hwirq, &msi_data->used);
> > > > +     spin_unlock(&msi_data->lock);
> > > > +}
> > > > +
> > > > +static const struct irq_domain_ops imx_mu_msi_domain_ops =3D {
> > > > +     .alloc  =3D imx_mu_msi_domain_irq_alloc,
> > > > +     .free   =3D imx_mu_msi_domain_irq_free,
> > > > +};
> > > > +
> > > > +static void imx_mu_msi_irq_handler(struct irq_desc *desc)
> > > > +{
> > > > +     struct imx_mu_msi *msi_data =3D irq_desc_get_handler_data(des=
c);
> > > > +     u32 status;
> > > > +     int i;
> > > > +
> > > > +     status =3D imx_mu_read(msi_data, msi_data->cfg-
> >xSR[IMX_MU_RSR]);
> > > > +
> > > > +     chained_irq_enter(irq_desc_get_chip(desc), desc);
> > > > +     for (i =3D 0; i < IMX_MU_CHANS; i++) {
> > > > +             if (status & IMX_MU_xSR_RFn(msi_data->cfg->type, i)) =
{
> > > > +                     imx_mu_read(msi_data, msi_data->cfg->xRR + i =
* 4);
> > > > +                     generic_handle_domain_irq(msi_data->parent, i=
);
> > >
> > > Why the parent? You must start at the top of the hierarchy.

[Frank Li] Do you means that should be msi_data->msi_domain instead of msi_=
data->parent?=20

> > >
> > > > +             }
> > > > +     }
> > > > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > >
> > > If your MSIs are a chained interrupt, why do you even provide an
> > > affinity setting callback?
> >
> > [Frank Li]  it will be crash if no affinity setting callback.=09
>=20
> Then you have to fix your driver.

[Frank Li] After debug,  msi_domain_set_affinity() have not did null check =
for (parent->chip->irq_set_affinity).=20
I think impact by using dummy set_affinity is minimized. =20

int msi_domain_set_affinity(struct irq_data *irq_data,=09
			    const struct cpumask *mask, bool force)
{
	struct irq_data *parent =3D irq_data->parent_data;
	struct msi_msg msg[2] =3D { [1] =3D { }, };
	int ret;

	ret =3D parent->chip->irq_set_affinity(parent, mask, force);
	if (ret >=3D 0 && ret !=3D IRQ_SET_MASK_OK_DONE) {
		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
		msi_check_level(irq_data->domain, msg);
		irq_chip_write_msi_msg(irq_data, msg);
	}

	return ret;
}
=20

>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
