Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89D57CF46
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGUPgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGUPgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 11:36:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CCE82FA7;
        Thu, 21 Jul 2022 08:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2PMzXhVQOoGOhuCTqqgGdytg75A7jqlQCZucW7+RvhImFhURKrYmHR5RGIus45wgLA+BRarfWzDuLuqlWgUq2+1snAgTxEt627sAeK3BTJpRisybz8X7Xtr4IJ4Eojz5gERo3cllrN4OFH4Tpb/kpBAQDRF7XKTwVnUOTpIghGqB5YyWsnZrn8clUcOzJHcNlLs5RADarVS3vYe5/W/cTdLPCEA7GdGDwFIGep6xywYbIUlUaDWRmavLehdHhnBIRbeCDkR8JfKzoizSQ54vHLeOaH9526LUEuEWC863KPEvUktWPxk7dhE2KFY7SIcDNwPZ60t0WHezDf3GxlVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q87A6sZe5ky0mEkPPqSRKCtSZfxgFYQ0ZS8yL0jDqes=;
 b=lSEMeHlIDW8JW0gcu/zFevmX0DIn0+UP28EtoNAj+H1/vkOm0fhhNCbymHEr8mA9CHKj1baji+9+NcTLkGoBbyz710NapZu91W54Td7XZ3mIQvcFFezue/S/W6MfghdkZwOXjLCCmlAFokxji6x8xAxEXXHbnnzLuAP5JTI3F/2GgMC1Jz0cLrM0D30ajIycpkuaIgYenFtQlCYtCDKd3ATlPW7rulzdeu40dpREaTzoN4FaWCbzkydlQwEpHD8K30PCW1+Qn2TtSdKbTrGjki/oCzatzs2Q29ryfyNOowhW9/cG058PkDs49cKBW/jUrEpZ2LqA84h0g/lzExe21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q87A6sZe5ky0mEkPPqSRKCtSZfxgFYQ0ZS8yL0jDqes=;
 b=A+/fE/u4FlTFB+TR/UMGdidl/Tw7aKLE9uWnaS2NboT3JQySbLBMaGDxKsTkMgoQuCYDLRkdTjyMl/gIPFRg1/1OfRy8wq5eKtMciTQHUGndudDKCPqaLbu44mfQuA/8l0uBy9cesqJp6aXO96eFLHnFUOg65Nh1EZqjS09CvV8=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DU2PR04MB9052.eurprd04.prod.outlook.com (2603:10a6:10:2e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 15:35:36 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::54aa:b7cb:a13c:66ab%9]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 15:35:36 +0000
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
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7CAAAWJAIAAAUWA
Date:   Thu, 21 Jul 2022 15:35:26 +0000
Message-ID: <PAXPR04MB91865AD14BD2BE33A4A9445E88919@PAXPR04MB9186.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 7efa949b-7f05-43a4-f189-08da6b2ea802
x-ms-traffictypediagnostic: DU2PR04MB9052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ME/sNHB4SEobl4toyrjlwFyobFuSZO/2Xot7wIg/vstVxWgmeGFbPELpjRs+JDKO2ZERJcGOpX1urVIT7CxEv8Oh7vdE9htXuAjaTTjIL5jGaNPddIqij6zDyi4r3LrBTh4UHy0aP5CIsHzLQdU/OwvrIyXm4fp+jAv1Zyldf6VyT14hwMcAPeA9v7dHq1uBuU+jAiGnEGiHU+L8AXwQ8E3fZ2McDvFailavuBH59H81jii6eegped5t3YDpcG++zHPW0KeNPIRf133b9KeACrjiu21u/ivxhM2jELs9NsWPJvwUVlfORzgnlQBmrRznWTE+TQH4LLtAyR7b/tzcdDg2jowg+dcLP2rwBWGB7Q/DzDDlOzKN8iqpn5ttkF/PXKZ3EMaVZWook08ec2hcA2P+8dCJ+/D2Ndq4muzOGVndsiX7yDQ2Tl2hIoB9R5Zc+jp6N60kMutAX2+oU6aD1bHfpy4aJBHy8eVPQRjTQLpQ5mUyvVPgklRbHTCI/cpFM/QiLIhlxcOlDb4mL3hALNOQa/oYkytP4IPavA7TXP7QC0rgNSf7XA9jSCqaZ7w4gWx+HxfcIGes84TQCWg60knix4H2KwkVvgKp7oiCIvOgrk+977e8JyrBLrgQCqK5hJ+5uklP5pi5gmOPEdvs3LrHvq3J2u4FwU6Kh+4gyzOhMUA7ttBSo3ykXd96hOWBrTE1472unsq1IYUCRDXnfv2bseOxb2s6Z0ICGsh/lVesP99xNi2uFLKDpUBH9CNf9zcf4Sn5fAMWLJZWNmV/NRFyRIzt33iCxINTLGXGfLEconY5Pp6LF645v49OjPW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(71200400001)(38070700005)(122000001)(26005)(38100700002)(7696005)(33656002)(86362001)(9686003)(6916009)(41300700001)(6506007)(186003)(55236004)(316002)(6666004)(478600001)(66476007)(5660300002)(8676002)(55016003)(4326008)(8936002)(7416002)(76116006)(30864003)(52536014)(66556008)(66946007)(66446008)(64756008)(2906002)(53546011)(83380400001)(54906003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Q+6q1Ujts5Te2fR2ioOTzlKbhqG0TU0htpTgjSp347Q8PmK9dW9DI8cuzkP?=
 =?us-ascii?Q?5GVSfLFPHRpxHOwYpm3GqkY7k7BmdpLfAnGe6hoawBFnjq3uxmg4NoJlN93j?=
 =?us-ascii?Q?Sh6hxo9aMti0lxztMEKVZhXV7McOlNU/JP3NyH1JQz4QlXY1CnGO3uTd8z5f?=
 =?us-ascii?Q?vGBuSRZwHZu1ZNAu1Ut4xj1F/HAPwlbXCheoKeU2O6g5P6Mf7INbIX3Iu3za?=
 =?us-ascii?Q?zM49GlwVTaPm322yDr6ApPcejhUZWUtcu+Bkk6MiZ75BczRTgSw78+SLRjxq?=
 =?us-ascii?Q?zTJaLh2KzsU/XJRiadgoz+F5tDY6aNAb0if/COyMn/rxoVbXsLE8I0Ubj+Lh?=
 =?us-ascii?Q?geOYDrGXmuIAwpAInAOYtGaHgydhaviyMJWdkjxYmaODVdKt0KQw3bLdgpw3?=
 =?us-ascii?Q?IbVmBewDoGZft3a0fotghCwNrMZi0+lud6zWhBzrllH13Noubw5MKbmPkilQ?=
 =?us-ascii?Q?zPGd62CUFIpIYDo/bkfywMORLNocgnrN5rVhqtePPngJPZrtG1pBSZKRAwHl?=
 =?us-ascii?Q?+YI6IWs67OmtrPdlaWQ+RLAhXgeW+7i9hT+M7y3rv1ceCSSzNerv4Fc0b25h?=
 =?us-ascii?Q?7seehr+1FCd/dalg/wqXYhIBffvtkHekOvU/dwvNXj486x7V2a1p2GpUYDz9?=
 =?us-ascii?Q?d9HCEM7qWmj6CPGstlae984M6dfRRbmrQQQ3MGfATVwPULuqC2iDYRoFEGI2?=
 =?us-ascii?Q?cYWhm3mow1l5+rgvP9O41RwSb3ABnqhVaRKqS7Kp7zKyZflYqKht1IcZp46x?=
 =?us-ascii?Q?GasvZU4irMOAVygf9k4MTsBoG0yWt5dun1idKO+PVUl6im0umtifadOkTsxq?=
 =?us-ascii?Q?tkIRoIHZfBKN2Wvcs5jto8raUc7zuA9GF3pKuPcXmaZR6Znkgg/04xFFjuO7?=
 =?us-ascii?Q?pH1dNVQPeLnVzxV6nw/72lSb86kWyCarDatjmfynUUzC2FMfuz4FVMk+wIlx?=
 =?us-ascii?Q?kZyCBh4F3Rsj+7FzBKCSLVofq45yLZCOT+NVZ8Rc3eUGqhqjTbrCPymHJ4iH?=
 =?us-ascii?Q?wMkKK33beHXO6A7CuCI+Yi0FYFT/uLO52na/AGYduOaVUK0QQHN6zOTNkaD0?=
 =?us-ascii?Q?z5+C/nXcC8Gk+0/ivZdxV71fvjwQMMmv9DssgzdV8Cfy0+UVjbcqDm6l2O7b?=
 =?us-ascii?Q?ttjtsKWyCkpw6P8UXiK+4AByskOtTZqg/ekBMmcuFQhYCl2Cxha81F+xcWDo?=
 =?us-ascii?Q?soEq0XE9B8R1gf8Lq+qlty7RVk1swdusDaTq5PjaQ74F7LbiNiqj5hoaD8uJ?=
 =?us-ascii?Q?HXv+WRitpio0q2wA+41URlQ/r2rJgKPju9DFRHCPKatJiJbiyt59RH1+WW3c?=
 =?us-ascii?Q?EThqaKrYyuPYoBMUxQUS3P/0pshAr9xSuuA45NAPP8w5BIctRe1eiIKhYXkA?=
 =?us-ascii?Q?BcqUNWPipZhcdET4NIZveZ/ktvqA6/U1OVmYF0JGXATcLEqfllSZgXNEo8o2?=
 =?us-ascii?Q?YbKU5bbwnLuNeq4LuR5SHwsWAzpY/lEWeGrHaaNHxGEkzAM9G7LVNSVqy26/?=
 =?us-ascii?Q?ILygnXRb59E8kWAjkSq9+7AFmZ2r+Bu7o397tDrqUSEBnSK7tkFzznrxRsCp?=
 =?us-ascii?Q?roDXOJTtN18JQX0MXN0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efa949b-7f05-43a4-f189-08da6b2ea802
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 15:35:35.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYaQj1e4W/qax3luKk+gKGGQTAt22xFp5sP3gj1TdXDBkZLD/YBnXJJ/QbudwMonHU8nglGJry4+iE9HPe+icQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9052
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

I understand your means now.  The name "its_pmsi_ops" is wrong.=20
Not ask why empty structure here. =20

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
> > >
> > > > +             }
> > > > +     }
> > > > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > >
> > > If your MSIs are a chained interrupt, why do you even provide an
> > > affinity setting callback?
> >
> > [Frank Li]  it will be crash if no affinity setting callback.
>=20
> Then you have to fix your driver.
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
