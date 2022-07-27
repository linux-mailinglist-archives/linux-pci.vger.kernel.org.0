Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F765832D3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiG0TFI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiG0TEs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 15:04:48 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641F5FAD9;
        Wed, 27 Jul 2022 11:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXScmbNbJOXJMOjnKVelzs5rIMW/98laMJDrvAm+DMVUHqi0fGaJ/oNuc1DdL2mfDdF+EX5qzVQnSjPfLock/+UmvP5SF4BdQKQXBhAS7w1H/mqNWTgLdZgia0p7Eyg173eJzhkhnfYDL1CooQ42X5hm243XKlWUdNaH9pNOuVlUlfN53vuTrgDy0MATD4MHjKzaNFEKF9DFuEF29LW3MxkespYCRI3/Xe9ItBQhve7u4bCaI3saE6OZYctCdi47KOVRvnZATh3rLQ0Y+9lH5iUmmbmRXptYh86gn14j8oCaEMJljZYpbhFfzF5nyuvW5Ao+Y0rEKdr0wGvc2oFXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QelDGqyWmLLVUfXIeveAqL4T2A2Wxy6G2ubGKBOiX8g=;
 b=ZSsHWWvtwQmonBpBhkDt5KC1WREptELtEZo7+3BpkEgP6F/GUVZ28RHqvPrZY2KPzmAvUkor31iaROwi2ggqxnbqlzVhm3NkTcrNCPYobzteqBVlmcDwyx2OCoh4hBFXknDA3CA2Bvt8EOOKcDXAPqHR8upkF0EY2zR7VY1x2dYnPyUsSF3bl8WzaFbSsjd+qHfFiWr3RBBN7DGd3EcQxTisubNaZBVleHnQWmk4suCO74+7vfliGqQOybf6iGQgFnnf7ZVKa+7CKCBNZ5j47vMW3ajusytqJY6hHAgLStespGOe6rjzmYO1FxolAkh1h0KIYjujlVswn49Ji9EVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QelDGqyWmLLVUfXIeveAqL4T2A2Wxy6G2ubGKBOiX8g=;
 b=PP5r+UE95asJQ0aIuIDjBXBBT1fx2+I2HJyocF2kdAsdaHhSloHFHGLp9UcNPKrRj9ICQnYvW1Med0oiBqYnzhucxIdDe2+hyVaF2CJBxDuMDavSN1CTTNHNdcPzBNoarcWj3B1uwy60OVqtR9Le9Q3x998DbfLbhSpOurkDThQ=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4716.eurprd04.prod.outlook.com (2603:10a6:10:18::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 18:29:43 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5%8]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 18:29:43 +0000
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
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7CAAAWJAIAIQw5AgACuYoCAAHgmoIAABhyAgAAvExA=
Date:   Wed, 27 Jul 2022 18:29:42 +0000
Message-ID: <PAXPR04MB918619B0E33DE2F3992FEDD288979@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
        <20220720213036.1738628-3-Frank.Li@nxp.com>     <874jza525l.wl-maz@kernel.org>
        <PAXPR04MB9186A1D283ACE8BD6954039288919@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <87wnc6xz6r.wl-maz@kernel.org>
        <PAXPR04MB918621013E6276D37B56C48488949@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <877d3zx9su.wl-maz@kernel.org>
        <PAXPR04MB91861BF0BA341211C442B20988979@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <871qu6y3g4.wl-maz@kernel.org>
In-Reply-To: <871qu6y3g4.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 483736d8-1071-4e89-be72-08da6ffdf994
x-ms-traffictypediagnostic: DB7PR04MB4716:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MdwuW0TNiBAfUP+6yIGsQbCRVK3mKmPvHIEtBeEHlfE+JPNiiRuMhj/ZNwp7I7E9NAyI8xM0qKYAiEWmMDqZbFtUt/oLzxEedKKGQkEpmsePpGfq2wRiuVPH2IrhHhi3t8ko+yQTCNlJCMff/BwicGDFNLqGxjQ+zG/V0KPQhPyFZpSD8jjocBfWqY8b/mLN13Y4OoI0nVzKjdr/mfynw1gQcJZD41GvinLP9D6KS3m4dBkUtPO88ThwlomolakOVnRtsAaOGu+kOXtR3n7/qCFmBQs1PeHNwuMsW4i5PkVc4sQur7DLR9CCNQreDJfpOyv454hw65udWDzsQjqvMoVD+F9wmACUhj8/sSvSyBHKRMkF6FJC4VgoMUtmxGwaBgtyVKPRx/6E7S6A7czBXF2U7U5mCXKbbNWUIoNVP5ab/zhJvTtk9vykST6VwcVoFTi0s+KazlN56/a2qOmrkR3touKGglO/JTR1M561nZ2UF8VIH+CdQaHpYykq5IdO3hHqTP6N9DYi6LKutQAaOV1I2IDYzjO5Fkp+tgoEmT3qbCoeEjupfQxjc5+QAYWXuWvWY+w/wYVOqK7TPmfQVEjgS3KsPqWqK89Lwn5C6oJNwZoVcKh0G37NwTfSAs8ecU4RiTPR8uRMk4vjfRZc1pKnbvk1sDzVVzuD3s0HQI7tUBiwEnWQVq3M9JfJV4/xu8486m9J6kn6/HrllVUr2J8wUpJu4RqrpzAdHyQb20rZyXRY1HgjUGm2eju7sNftVYt1xZikgE/7jcmzuBlKTF+fL5IkjVBRlLPp2HBoA5snc+LNPXqUALQGZHc01Uat
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(41300700001)(66446008)(26005)(66476007)(6506007)(186003)(54906003)(7696005)(71200400001)(86362001)(478600001)(6916009)(55236004)(122000001)(38070700005)(8936002)(53546011)(2906002)(5660300002)(7416002)(9686003)(44832011)(8676002)(52536014)(83380400001)(4326008)(76116006)(66556008)(55016003)(38100700002)(33656002)(64756008)(316002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?piq8V1e1WJU+UKAScRttuAql8wIumeXnrWH/hieBivNxrQIIJBp45gj9KqaZ?=
 =?us-ascii?Q?gQWz/1y0YtkRRRXMHsnifADK7r7Mr6crkG8bQnour0l7uGueI6LXOuCcdg93?=
 =?us-ascii?Q?ZlbHtOWuwgX0tXO/j+ShBeMRcgVxUtpn/d1CmGih7uW9U3/HzwZZYmVSYkpG?=
 =?us-ascii?Q?KzJFYackU+nwzmqRERTZV0dQCpDV0g2lrQr+dvTBdrVThV10zeMRS24dYb59?=
 =?us-ascii?Q?EWcdXcJnpkcAfwFSFb48lg71km2SVdRfciYo0h10/9Vk+yxMnhnOb6LWonoL?=
 =?us-ascii?Q?PlvjNT6roM7XDYG/kDDLMyLG5uj28QGK2vrr39QC/ehUsN6lpEhG8IQvQml7?=
 =?us-ascii?Q?j/Wfe/MPEex7ZNJaMl4VoPSIfm/i6VHDDq39MCS6mOOrWBXMaUIC3LBoxVHZ?=
 =?us-ascii?Q?3RgcjWYsgYB3p/ZCkCPO1a8qnfMCVI2gptwxeG0qHFz+UOZkVyRcuWoRgWBX?=
 =?us-ascii?Q?gLPthTXesSBdp8T9nzdIlvbA5iZo5sNspQoNwnHKt8n0Zo6xR/h7MaMLhzt4?=
 =?us-ascii?Q?30JvOwXoedApouabx2o1nsBP/DkDESkCMriFijEQ1jqc9DwM4afp/GkfP909?=
 =?us-ascii?Q?g/kHgb7078Vcm/wBHIP6Bd9FzZVhiUOzWJTYPktRV2sT7vxYJe6BVe3dIo2L?=
 =?us-ascii?Q?SCoI4/Z58r/VTM74/oOPm3/vQHr2m3QTfFZy2PAHfjVh1fJe7IpnA+B3z98J?=
 =?us-ascii?Q?UX7nBhgiGzNp1ouVjIhiqliDCF/nlW7jR0Pt1wxupDbflfVBgLu93DWL2bN/?=
 =?us-ascii?Q?aCvxvYRjov/RJSCHJ66qtzEafxPLBkXKsaWEwn+qq40AFufwJtMRYdnKYLEA?=
 =?us-ascii?Q?k8jbzuJMyHc34yIjlWW/tcSewWscml3lmvxEnQcrB+fq2lWa9pnT0kteqSjG?=
 =?us-ascii?Q?Q6bS4DLl6ZyXoAdnB0+o5ksmtDDzzQeWFrp+5+jVxr9vycjbr/8oFlSXOkvS?=
 =?us-ascii?Q?keiZHW03cM6rMaqgOn5khrWvn8qb5eUbH1SB4Q6VVuaJOpRaIu4DV+xZVz6f?=
 =?us-ascii?Q?gewqRnq0EtC+LUoKrVG6adjQL/2aQv0c2d0JnTRozVR8y5l5Xi2L2ioPJdrc?=
 =?us-ascii?Q?N/XSwuHHLDzbRhDEtZ6uQNBtHQ4QIZIGMYMSFHZbl8h+vEl5VfoOzGjMU1IO?=
 =?us-ascii?Q?Vf12TwXoyf2uveEgTgIobXXiXss3uZBM8QnUgJF3o8aAq4AuulvjNBz31VEA?=
 =?us-ascii?Q?dzV4yl9JGObq4Q1Z5I0keJUjnc9cmDQD+eP+tYwFumgvl94INEYFRpH6FPJ/?=
 =?us-ascii?Q?wYJn2TRNjEN8PfpxDOSwoziVOeM/uOPoYVmspajEbI2C8NUWMJZnXG/JqXtH?=
 =?us-ascii?Q?Fxth1XlhzurbK0Oey0fit6INr4WbdStrwLWc3wrCe0mTVfE8R/LaB9BZMKcP?=
 =?us-ascii?Q?YgdUzqJia5nGkCDg6OAaUT6zzb37N7UtrGK77N6bZ8pAsSk9tq60QrHrD/J3?=
 =?us-ascii?Q?7KxCfqccYWZqkErTdl1Xppb7NT1vjYMkC5p5DQrvXSo72v/RFGwt3ax/6N7w?=
 =?us-ascii?Q?RJAS20HA4EPkqGAvuINdckjKQvSxbwGBQFdmA7bn38E0n59N8prkrxYK9fyi?=
 =?us-ascii?Q?+JbemOmfBQMsLMhRsSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483736d8-1071-4e89-be72-08da6ffdf994
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 18:29:43.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjBX2QhDMtsJSj3Kmqf5SKSqplvVRPOoCsou6u/k+Q+tQ1ei+0tK1vevnU39/iwX2jrLkwy+gsWYblfj0Brd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4716
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
> Sent: Wednesday, July 27, 2022 10:35 AM
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
> On Wed, 27 Jul 2022 16:23:26 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Marc Zyngier <maz@kernel.org>
> > > Sent: Wednesday, July 27, 2022 3:03 AM
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
> > > Subject: Re: [EXT] Re: [PATCH v3 2/4] irqchip: imx mu worked as msi
> > > controller
> > >
> > > Caution: EXT Email
> > >
> > > On Tue, 26 Jul 2022 22:48:32 +0100,
> > > Frank Li <frank.li@nxp.com> wrote:
> > > >
> > > > > > > > +static void imx_mu_msi_irq_handler(struct irq_desc *desc)
> > > > > > > > +{
> > > > > > > > +     struct imx_mu_msi *msi_data =3D
> > > irq_desc_get_handler_data(desc);
> > > > > > > > +     u32 status;
> > > > > > > > +     int i;
> > > > > > > > +
> > > > > > > > +     status =3D imx_mu_read(msi_data, msi_data->cfg-
> > > > > >xSR[IMX_MU_RSR]);
> > > > > > > > +
> > > > > > > > +     chained_irq_enter(irq_desc_get_chip(desc), desc);
> > > > > > > > +     for (i =3D 0; i < IMX_MU_CHANS; i++) {
> > > > > > > > +             if (status & IMX_MU_xSR_RFn(msi_data->cfg->ty=
pe, i)) {
> > > > > > > > +                     imx_mu_read(msi_data, msi_data->cfg->=
xRR + i * 4);
> > > > > > > > +                     generic_handle_domain_irq(msi_data->p=
arent, i);
> > > > > > >
> > > > > > > Why the parent? You must start at the top of the hierarchy.
> > > >
> > > > [Frank Li] Do you means that should be msi_data->msi_domain instead
> > > > of msi_data->parent?
> > >
> > > Indeed. you must *not* bypass the hierarchy, and the top level of the
> > > hierarchy has to implement whatever is required by the interrupt flow=
.
> > >
> >
> > [Frank Li] I see, just want to confirm msi_data->msi_domain should
> > be correct here?  It should be leaf of irq hierarchy tree.
>=20
> Yes.
>=20
> >
> > > >
> > > > > > >
> > > > > > > > +             }
> > > > > > > > +     }
> > > > > > > > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > > > > > >
> > > > > > > If your MSIs are a chained interrupt, why do you even provide=
 an
> > > > > > > affinity setting callback?
> > > > > >
> > > > > > [Frank Li]  it will be crash if no affinity setting callback.
> > > > >
> > > > > Then you have to fix your driver.
> > > >
> > > > [Frank Li] After debug,  msi_domain_set_affinity() have not did nul=
l
> check
> > > for (parent->chip->irq_set_affinity).
> > > > I think impact by using dummy set_affinity is minimized.
> > > >
> > > > int msi_domain_set_affinity(struct irq_data *irq_data,
> > > >                           const struct cpumask *mask, bool force)
> > > > {
> > > >       struct irq_data *parent =3D irq_data->parent_data;
> > > >       struct msi_msg msg[2] =3D { [1] =3D { }, };
> > > >       int ret;
> > > >
> > > >       ret =3D parent->chip->irq_set_affinity(parent, mask, force);
> > > >       if (ret >=3D 0 && ret !=3D IRQ_SET_MASK_OK_DONE) {
> > > >               BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
> > > >               msi_check_level(irq_data->domain, msg);
> > > >               irq_chip_write_msi_msg(irq_data, msg);
> > > >       }
> > > >
> > > >       return ret;
> > > > }
> > >
> > > No. Changing the affinity of an interrupt must not affect the affinit=
y
> > > of another. Given that this is a chained handler, you *cannot* satisf=
y
> > > this requirement. So you can't change the affinity at all.
> > >
> >
> > [Frank Li] I understand affinity can't be changed.
> > But system use set affinity to write msi msg.
> >
> > The call stack as
> > [   25.508229]  epf_ntb_write_msi_msg+0x78/0x90
> > [   25.512512]  platform_msi_write_msg+0x2c/0x38
> > [   25.516882]  msi_domain_set_affinity+0xb0/0xc0
> > [   25.521330]  irq_do_set_affinity+0x174/0x220
> > [   25.525604]  irq_setup_affinity+0xe0/0x188
> > [   25.529713]  irq_startup+0x88/0x160
> > [   25.533214]  __setup_irq+0x6c8/0x768
> >
> > I have not found good place to hook a function to write msi msg.
>=20
> It is called at MSI activation time (msi_domain_activate).

Another issue:   platform_msi_write_msg() is static function at platform-ms=
i.c.=20
It access a local structure struct platform_msi_priv_data.

If I use MSI_FLAG_USE_DEF_CHIP_OPS flags,  both msi_domain_set_affinity and=
 msi_domain_set_affinity.=20
will be set at chip. So it will NULL point error happen if I don't set affi=
nity function.

>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
