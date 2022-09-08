Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5A5B226C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiIHPfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiIHPf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 11:35:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E059752B;
        Thu,  8 Sep 2022 08:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1O6EFeNKvjvGoeTzcsp3QdNjhct0uIwjxCiEy85kWFb/mjdKE02JRYRMz19rUkK+AT+jtxlUZYGdAUZKKOyLVIIq6lnSgGlXrHM+MhZbyoXUPj74vn0K6WgycBnkRVeUzZDTiIVHrSO8shCi2yD2YpDTXA++n+HUInKaYS6VdJqd7iuP2NLjKhBQCQAOhltVcmPu/7DOJ9ZeRKg0/Aao/PI2ON6HMVWSuRcCPeK1b8JvOhZQju+eZyXOrDRVqSfatHAtBV3X/oBVgzA1uA/FNA/5sLyVHRkpcKICV9Wjp3YjC5XNnv2SsdlyLChrnJXYYYNF4Ow9y4/i9Z3V/vtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFzAeXDhemK6UHU/FfXl8argJ8PW8y/LSdy1nAZ+zR8=;
 b=ZftO0Glm4SYeCa8+buJjKg1NSw9nII4jGvkh9r6TR/95ZV85XT2NirAgVwOeYoapOhJhCbb9jx/Y3sLGnCjjAJjmlgKI8Cvt7bjVf/x7tdPiKE3rJs4cHutFvHVQF8WNxVh4bHslaR9EkvZ2u7RpqIdhvGpUhJnEvw2NwIsDQ+SzyTQWT0g/L4aM9TjFUZftIzGHd2J6CN6Np2GurMq3PPK21hlWSWiFTWlP22hh3jZkNEthq3UoKWN4gRZxdaL4wZeEzpSgYjXLq9dSflVaRtwzbpHaPanKcLiMi3aqoP6dTA7p8ZpZ8V694A2PQmIrzxACjcMVTuMlfpVbBOVo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFzAeXDhemK6UHU/FfXl8argJ8PW8y/LSdy1nAZ+zR8=;
 b=j1fzW5d09/7fFtfIf/sFvPHhHbq6euMnpixcmg9mztddkRB1R8iQOjMJg+GAPcRmjEhP3fzioCZR0i4EJ4o9JhDFvg/OpRRTyUqaCSP7/ihB0n7yyL5C6T+eR8X4Jgp0EDXjoajk6+qSqATMaw/taPICtjGq4yzljIGvgfj0Sbc=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AM0PR0402MB3585.eurprd04.prod.outlook.com (2603:10a6:208:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 15:35:21 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::1c3e:36a0:1adc:beb%9]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 15:35:20 +0000
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
Thread-Index: AQHYwmzT0d5rWoxlpEiRJzxdVpfwVa3VJ32AgABtNnCAAAtoAIAAAWig
Date:   Thu, 8 Sep 2022 15:35:20 +0000
Message-ID: <AM9PR04MB8793CE5AAAB281CE628845AC88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
        <20220907034856.3101570-3-Frank.Li@nxp.com>     <87fsh2qpq4.wl-maz@kernel.org>
        <AM9PR04MB879338D6D4B55A74CD002E6D88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
 <877d2dvs0d.wl-maz@kernel.org>
In-Reply-To: <877d2dvs0d.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|AM0PR0402MB3585:EE_
x-ms-office365-filtering-correlation-id: fd29796d-ea1c-4c03-ed60-08da91afbd5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HxXTQOaxv1D0P20De0ngugp27/5qfpZI430PuBW1TZVuEcOv9Dj8f8t0mUCgRojmpvdPLsmG4u9tdDxgTSHmI0YsV5ei81c8Nt5cCxyy4jqnXT41qYbXwCigDpHtXVuICyK5nFLK9dLhBvZee+66lKx9N9Rp7cbl518bzZt5i7RnwmEz3Vnnko6G/C5IFO/mRdwDXy39ltB8BnouqXEjNRVbNhBZ/sNQ/58KtLqT04zS67YsrlN/8DD8oVBLnC4cRfYyZUsP+Pj1HJD8KuDOV640qZAAOExYUxXxHf8bWVgxBkGuMOY52e25fX1L8dBFE8h/QKJI1ncKyKBC5fOHqLSSuwOnvL1M8FmU3Mc5ll4vSyfah2/z72IWqCeUIXZ12gfnNunAqgLizabirdKCQ0U5NqHJKz6W4mt0/2HmSU0ZM8dFIFtrNehUzkCPxqu/kk640ZzdkAqXKuuCanPBbMyADZEHLfgq4sSbHfI+QnmnOVouQymcNgB2qHg1f77mnBlYSzQKAMIUwCQyqxwalecF+uyE/R5d0DBLLyq3WJDjyw13XNccPRrNuKuhotdgnAU8AKJka8/N73y1RwESi1k4/6GQrsXIMUFBPIV820uhu5yTn2MqielwsAvHDmZwFsy89IbEokmx5RNKzRIyZ+2qoZcrxPwjUbuKQrh4kFP0fzz4YqYTf3dr6mwDWG+suOnsLO1jo8eglCmICvLmzvG48rR5He/5Ovi+s5kIrisEghpm2J03+Yqo5fzIezdvSci0gn7Gh9ppc4TggW5Lyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(4326008)(7416002)(52536014)(33656002)(5660300002)(53546011)(26005)(9686003)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(55016003)(8936002)(2906002)(44832011)(38100700002)(6506007)(55236004)(316002)(54906003)(8676002)(6916009)(7696005)(83380400001)(86362001)(186003)(122000001)(38070700005)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cB+NIIiM2rGnPRgXCkhJkXzvc5NuYd1HXB3fQLbGohLgwSnTzZqETahrL+o7?=
 =?us-ascii?Q?33HDAfWVd/O9OqCl2d/CapiauOhXCbbo/0f/LPdHgXONTnO1LD+/VcAfG6Zn?=
 =?us-ascii?Q?2913dFARvWZjNZc7zO5HSa/DJbWEJIIxH0D17yZiQMcLgv4EcI+fVUAl4hj6?=
 =?us-ascii?Q?4uflq+y/H3n2jT0nUpAzHqA5QnAvnpLJhA0vfCFrqQJBYO3iTtaGhLMmJQQv?=
 =?us-ascii?Q?qoAqwS5CBQbaF8mYhNAiyMNB+x9dmHJ9MOx0at7MjcmV3bK4DO6Y/FisOJr4?=
 =?us-ascii?Q?dSQ7lStuhVPHbNtN8lhdYk+GeFhWEPORsEF5dZIpMhhC4oUpZSZEepVLE7zI?=
 =?us-ascii?Q?65PvdB8HzTqZfljBrntDAnH0Ah5se3YoK1YbVhHUAYxM1Xy3vu1DKpR1PGGh?=
 =?us-ascii?Q?ZcR1f2WQ/qRSQw+T2ij4cH2L3eyhbcL/4Y+0xlGOhgXHidnvFaI55SB3fgtX?=
 =?us-ascii?Q?G6JzikLNTJQE6oQFgI1TlKMnSoP711mExdCSPnrlTibpfE/c+js4sFPBurxD?=
 =?us-ascii?Q?ghHPrK87+BbyXnWeU/F9XFMgFhaUuC/vTmcXN7YOzua/JmjLMHwQKV0sGmmM?=
 =?us-ascii?Q?mIUCrw8bUWR3Zx2QzJ9OpspL1eV1CoM8l0hckZUmKZ7EowrcfkCNXXFJa70w?=
 =?us-ascii?Q?wxC2BvDDqOJYlG4q/yq7JN+roMpRsXEppaunhJcFLwA8g3bKC5xxZ8bsPvpT?=
 =?us-ascii?Q?/rwCuZjVuoHgWRSo8o2olEtNBqmBztfK2pnGvFcCLUW7z5uXIsg1NL7BfNpL?=
 =?us-ascii?Q?wSdyLSLF0/xPrv8e1+oeiExYsdKzHus+wPdT3EcFwwvyG2DxIvxU7p1jvC1A?=
 =?us-ascii?Q?o3djBQDci46ql91DrcoylqiN9NNd/+sHtKtQF/Dn63kohdu9sMyr5nSfS99J?=
 =?us-ascii?Q?zGUWSTc8yMfIATcIlZ5WbgR+TTHdFOX4WgFTgWh+Rsr1n2V0Ux3qLrnu87aa?=
 =?us-ascii?Q?SpTCxbjonBO0NEuVaDVO0yrgC/DUMqxIRr6+IaacYk/hwYFUpfCpMRHC4sSM?=
 =?us-ascii?Q?9o6dEU2i1EY445KnhFNrQCHg9elnaX6hYdPk/b5uhyHgMMMOrJGc0nf3U/Ng?=
 =?us-ascii?Q?c9UZ1Ym9H63B5Y/2uYhIEDrbDWAaKEv471j6WbRY2baU3L1L0e7SECmuroiM?=
 =?us-ascii?Q?7nGDPuxASFM5FkmxhTFJ0owzc1tL9Nrj+MUV03eGEaEJk7uU3LeXMuwbLQ2C?=
 =?us-ascii?Q?jDvQNMQBkbsdXu/fP21irP2jOU6wZKaVpluKkXSIXWlAogUDWm3NwV//LcI4?=
 =?us-ascii?Q?A/6BGDA1OjaryQh2B80JXeHHVwnwBv+wZt5A3uYlpiMtHnd2W7iApL6h62MM?=
 =?us-ascii?Q?yc3uoAVkFFgPgSP/NfExcZwUB/oKgQsILwDefnbSyAgRZPdlGfgT5SMvOjAB?=
 =?us-ascii?Q?IwwNpSicoTQwyFkumZLmWZl/x+OspRs3I+AefkfXQwt5zfljEQB69ooKmGFm?=
 =?us-ascii?Q?PQapuSQDw4mO34AOKNYIQofkT/ukosB9IrsYHjt/9iU1AZAUZAdqKRhBw/jz?=
 =?us-ascii?Q?uOSKamERjeE7PRyPYyQyNPDfDfNcOqBicftKg23DUZfrRJSySxaRU27CvNKi?=
 =?us-ascii?Q?s3noV9i3Ao+y8KgSaz4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd29796d-ea1c-4c03-ed60-08da91afbd5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:35:20.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGae8Oy0IcUeLNBs6817A5X8BvpVMxYGcPhdRLw/5Jw/GcSTc8C2kvOXcA3bCibv9F+hUR0m6IUii7D3iNdTMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3585
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
> Sent: Thursday, September 8, 2022 9:52 AM
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
> Subject: Re: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller
> driver
>=20
> Caution: EXT Email
>=20
> On Thu, 08 Sep 2022 15:23:53 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> > >
> > > On Wed, 07 Sep 2022 04:48:54 +0100,
> > > Frank Li <Frank.Li@nxp.com> wrote:
> > > >
> > > > The MU block found in a number of Freescale/NXP SoCs supports
> > > generating
> > > > IRQs by writing data to a register
> > > >
> > > > This enables the MU block to be used as a MSI controller, by levera=
ging
> > > > the platform-MSI API
> > >
> > > Missing full stop after each sentence.
> >
> > [Frank Li] Do you means missed "."?
>=20
> Yes.
>=20
> > > > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > > > index 5e4e50122777d..e04c6521dce55 100644
> > > > --- a/drivers/irqchip/Kconfig
> > > > +++ b/drivers/irqchip/Kconfig
> > > > @@ -470,6 +470,15 @@ config IMX_INTMUX
> > > >       help
> > > >         Support for the i.MX INTMUX interrupt multiplexer.
> > > >
> > > > +config IMX_MU_MSI
> > > > +     bool "i.MX MU work as MSI controller"
> > >
> > > Why bool? Doesn't it also work as a module?
> >
> > [Frank Li] I remember you said that irq-chip can't be removed.
> > So I am not sure why need build as module.
>=20
> Not being removed doesn't mean it cannot be built as a module and
> loaded on demand. Why should I be forced to have this driver built-in
> if my kernel is used on a variety of systems, only one of them having
> this device?
>=20
> > > > +
> > > > +struct imx_mu_msi {
> > > > +     spinlock_t                      lock;
> > > > +     raw_spinlock_t                  reglock;
> > >
> > > Why two locks? Isn't one enough to protect both MSI allocation (which
> > > happens once in a blue moon) and register access?
> >
> > [Frank Li] Previously your comment, ask me to use raw_spinlock for
> > read\write register access.  I don't think raw_spinlock is good for
> > MSI allocation.
>=20
> Why wouldn't it be good enough? I'd really like to know.[Frank Li] '

[Frank Li] According to my understand, raw_spinlock skip some lockdep
/debug feature to get better performance, which should be used when
Frequently call, such as irq handle\polling thread.=20

Spinlock have DEBUG feature to check wrong use lock.  Allocate MSI generall=
y
only is call once when driver probe. =20

The basic principle,  lock should be used only when necessary.  Access reg =
and
Allocate msi is totally independence events.

For this case, it is not big detail. =20

1.  change spin_lock to raw_spin_lock at allocate msi function.

2.  kept define spinlock_t lock;
     In register modify function using
	Raw_spin_lock(spinlock_check(lock), flags).

>=20
> >
> > >
> > > Also, where are these locks initialised?
> > >
> >
> > [Frank Li] struct imx_mu_msi is fill zero when allocated.
> > Does it still need additional initialization for spinlock?
>=20
> Have you heard of lockdep? Or CONFIG_DEBUG_SPINLOCK?  Maybe you
> should
> try it.
>=20
> > > > +     if (!pdev)
> > > > +             return -ENODEV;
> > >
> > > How can that happen?
> > >
> > [Frank Li] Not sure, many driver check as it.
>=20
> And? Just because someone does something pointless, you have to
> imitate them?
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
