Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD26D5B5DB6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiILPxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiILPxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 11:53:48 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47233A149;
        Mon, 12 Sep 2022 08:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=honxgY63l/ceD1NGnKAovCQrc0uJmKbO/zIYuJr3NmUq24sYPncEcbjklvTOIJWNj6ORj9WUxgPLmH8uoNgvzuVp4kQ19y3jHDLqQgUFYXPZN4M+teBlSSDXrWZJYqxr36K/AUXrqNaMI/hJXmwTu0h3r+Wt/uywRB+wVbkD2z+Eygqth9bdiR7Ai0p3KkWItlVjj8tpQlBQWuyl8P9zi4TWuDxD1YGzHuPWqdnn7E5MFXJwvoRJSP2zS7llHSbD1mX2uiGrJJB9QCqSNRLMdQRbqLPieC7m6mdYjXRyvNmByuBY7H1B76Qu/td/YIBSrSre3YHJb1aR66MA66uxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IORcsfPdnHyvLcn5W7GLXAxTyOON8c8lA4ipDdsljUk=;
 b=lzbklyYMoxX6PUVN098LA/njwRJMYPrEenvrB+aCCnmiPoE4D9iGsoR39U0eRyf8BMLx1+lH4c0/FMZN84zj8IVR6AYV6f9mJEzuLs2W59dOgaxlFXKzpAaS6yFjEhcakEprCihlrTvxcmbo9rjchk00tW1d3+ZNnEB20cMX9VKBCIRqovQmldN0kjX2CYEePArdgSuef5bvoGhkRdPK7kVKEeeLJfvpbqK1xJ+0byfuQ9fIfxXyVOVTHWlWcXzoGbSbitQbClEdxxHq6Ovc+zwwv90wdTGu30abfSD1esBWws6Ns4EnoN5qNGx3JXZ/lGE5jbPvQ4ji+vDcI4CsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IORcsfPdnHyvLcn5W7GLXAxTyOON8c8lA4ipDdsljUk=;
 b=sA/SjxLyA4MUlj4rhUpbYbPgIJYk6sb1UhX5pVa8MXXKPsUSaBEh53G3e47JCt5SlPuFj8qHZ57eKULXzLmbtSZXno8ENJAwizLZ9yveLso6ki3l7B/FpLuE8o5n1L7OQaMgS9zdwYaCaU441xqyaIbRkD1aD4UTnzKaaPpqyvY=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by AS8PR04MB8343.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 15:53:41 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::e5ca:22d0:52e2:15f5%3]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:53:41 +0000
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
Thread-Index: AQHYwmzT0d5rWoxlpEiRJzxdVpfwVa3VJ32AgABtNnCAAAtoAIAGWbkg
Date:   Mon, 12 Sep 2022 15:53:40 +0000
Message-ID: <AM9PR04MB879393DEDC03A5C092C81DA888449@AM9PR04MB8793.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|AS8PR04MB8343:EE_
x-ms-office365-filtering-correlation-id: 9a3a3412-7c2d-4baa-fc87-08da94d6f6df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAKFxdHcgazwkLXjZ4r7femDwz04yT3tAySmIs64UytMJZQBIgaljJK60oaV+apVN8cmqTvoQUWRq0kxtMMlHlGyp2mw0YPgGIyzC20TpaOaU/5qt3/41b9ZI/eHV8cTJ4FPCfKLvW7yynBwUcPeDQ6/n9eI2Yp+gKJHFG6pxFagJIdUyN6Prh9t+ZiJo/EMawpmb+D9hXoV7LnweWPejyYcjmjvPwb4NGsWq816LE0ok4JeD74EMvw1SgUAN0fmE5FhWCm9KpSExa0r8jqITpl0rPlNN95Mg/IcLSlicNjyszrofITFlkRy1jtoq8TdomucEcQ/p7kJv12jQ+Eqs5LWLV96lh5Qmbh2hnOGXbPksWBgOjReqQRN2DjSVzNLUD5FL18W2uBZt33a+5Lm1+juW3Uv6QC8GeWcBiOeQulyhvb4Tmfv5hCTEB3wM7aIW3W8tWdyMFMrO5FcqjL6GueVDzSERdBAfk3+fwbvY+XnaWwXPo6hYzQFr2UGgEk9cFwgAJiWZB5wCTsC0kPYCmSl7xT/PzL1tr/+f/85IIMjHhr08dk6n2CQYkGQLwL705GnyIvFf1EZBi0PBl7LuYgvv5V6GXzX9oFGazImdyaxRmXJGzMHKS5nhDQ43OgJrHU/n7jOBQDADFJQOa5X3RT6Hvx9vSxePx20TgfZ6bM3avHAwIgjceseTqx2mi2hdTuS3puNq/NJXSFmiPgdBxl1BJIPb6S9tzdg4DBgsI3SPTL0PE3kIm7XK1QYoiSFgUMUKlVtnM+GM7ZTSHahdyqJ+BlIFO1d7UStF4uTU4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(38070700005)(38100700002)(122000001)(8676002)(64756008)(66476007)(66946007)(76116006)(66446008)(4326008)(66556008)(33656002)(86362001)(83380400001)(9686003)(26005)(6506007)(41300700001)(55236004)(186003)(53546011)(7696005)(71200400001)(966005)(478600001)(316002)(6916009)(54906003)(55016003)(2906002)(44832011)(52536014)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nQH/B6gjmVlEzhCROG5NERVJg2UKiDWpy4mkGAjgRZPyYtHGRUxEUoaH0v9h?=
 =?us-ascii?Q?cgvu/XisSYZvcAwckHtRQ4Vwj3Oyr3dpT/Qy02QWspmjUBNpT20hS1gas/K5?=
 =?us-ascii?Q?t/IJGRTEnyFi3BLYgOVq5sCPiEJisS8AmFGYrBAWaM1JPge9TwSCiXOVT3zq?=
 =?us-ascii?Q?V35u7obalwf3UKyFCoAM8T1Eu6vGhPVQ9MhjDyclkDuRxcwdocAwR5xA/kFH?=
 =?us-ascii?Q?qup+fXlD+RPDvr2kSwYj13yMeiRNRC/0zIQbyYqkVbneGm9ow+qAgFBsllBB?=
 =?us-ascii?Q?FriOV/3WYvRGpkLByhKGQ1RwJ/zn2j6P+uY93dTczQbxDK5A3UgbyjqhNqEM?=
 =?us-ascii?Q?ZH9VtlTKOBqo4rkmVdcg02tjjdDFyYptmrrmRNYJ94ewK0RVBb5xCgsvox9n?=
 =?us-ascii?Q?nWaNVe3uAVcGa5IjJYjxRuq+j3zwtgVSq7hV8vwInvjbbHO2z9YIJEKdzgpl?=
 =?us-ascii?Q?hr38xIG+FRnOI1lA9sggjX6pg9ifdng0XIHF8wmfcjzZf1H3u8SKITMhy2zY?=
 =?us-ascii?Q?uM+GtoKrsB1rchXTWhnt/HfZqptbnIQGyEZIZYfjHT6dhqIe1fhMjjrcw5Qb?=
 =?us-ascii?Q?NIGyyTxUHl+PgK5ta4q+Y4kWwqLqwwfFBmmO+2v26O6DVocdU7/oY384RwC5?=
 =?us-ascii?Q?YT555YRGi1TljY7M8gparFQ0aihz+AdszGZmgyclVWv7FbJJihLokJgHZD+U?=
 =?us-ascii?Q?1VXei36CuCqe2X/SCYqjIwShDlJC5HTimEf5mWNNNScfuZuI4SvVhjN4qcgc?=
 =?us-ascii?Q?T01ij1r24+2PknMqt5Zxoz4zlIJs8S8WjhSHgB5Hg7eDVN5uo2paeUmRvcW9?=
 =?us-ascii?Q?YhcU1T0I+lEmxXxX7ZB9rGkdasUQQ4/KIEkj+s+Eo9+aNNieXGBuxozFopXI?=
 =?us-ascii?Q?ItE/rkSTttx917pKqged2jvT2DHnj3zScXr9qgELHcX8iAjHs1FB96p7jlwx?=
 =?us-ascii?Q?/rx5J6uwcl03IJ5+ydZTGChLCQA7bQWcZwDzSMPlpR/74XPs1cZXUK6Kro+3?=
 =?us-ascii?Q?Wn2Saa0I+oSH5LQBeloaI39AUnswILLY/mnxx79CoD4rLNn+jEVap1V0fTC+?=
 =?us-ascii?Q?t4EMmP5DoZr+xZFLJT8Nd/IFbZW7NLDGcYi84KJcQYbgqrrACHCJ/suiyIs5?=
 =?us-ascii?Q?eelqDv8OfffcI0gAvlFkIftp8eOuXfsn7ldeBNlgWQjcOuXj1YnXElxRvJKO?=
 =?us-ascii?Q?WNncXhKIjjUZrbGGFCavKBEwxIaXvY2aJ2JXVxbJoVaIwsdAcmNTIMCIse5y?=
 =?us-ascii?Q?mXqh/UAmiCMLf49LSi8M4J1LTwmEiV1rOwOzIlvLwBDUajewRZ2SxSu9upGb?=
 =?us-ascii?Q?ICKjM3yxax3MTxzILIqf9Us3JTFwHM7VNhpmYohgi2LEnw3blSGLoHgEiaGn?=
 =?us-ascii?Q?Nci1lUhNsLtktqO9UBnM0tJeAFDUyUiCjh3bb+jZjFuG8IHvUX0xRGGWG4Ov?=
 =?us-ascii?Q?FUQL7T3u0+2NxLj4mEj2juH2BEhkleUi0PANK7gkSUoP+gZHlGuWHshwU6BO?=
 =?us-ascii?Q?HNf313HaQdh4bnACYxuRNjmEL9OY5S2kat8cymkgqX+nlwvIFUuDw5lFz03M?=
 =?us-ascii?Q?SFmiyrMr6prXuRhlYB8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3a3412-7c2d-4baa-fc87-08da94d6f6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:53:41.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RM9cG+dBeESeQpBdY2BQUYOR2iCuSv3/dNRkO27HU2OJ5xCw/z0ORIujw9SHMud4J8N/YdRMECmNANy8cxFUeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8343
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

[Frank Li]  A problem,  platform_msi_create_irq_domain have NOT export to l=
et module
Call it.   https://elixir.bootlin.com/linux/latest/source/drivers/base/plat=
form-msi.c#L122

Do you want to me add EXPORT_SYMBOL_GPL for it  OR keep "bool" here?=20
=09
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
> Why wouldn't it be good enough? I'd really like to know.
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
