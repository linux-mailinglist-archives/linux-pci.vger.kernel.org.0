Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09574582986
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiG0PXc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiG0PXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 11:23:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A808C45048;
        Wed, 27 Jul 2022 08:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4rvZMX1csjKgEi164zaDivC0KxjeCsx8LRPEabJqlGHkoutHvqnnNSicPwsRqShtuSCb9YVeLfbWHRP+SkK/6LQNp+M/O4nbZN00DpVf7t2EVWX8FcskwctGFtIu+Nrg8/01Naul9RiC9OPxvOE9j1Z4rJJvq9fnUW29/8210EgM/DqDBiTTJIwxNl4RL17bUJcH/oJfmIH2P26tazm6PoOR0cLHpPd0mUwLyiY4a5eFqjJdSv1eTn9FSsDOB7QYvScssgvs4ez80JEW0c4BpUMOO+ye/AQuWlqwnb188cK/csje3Ktmtqk0hoAjnvaf0SIOrjbV8+qC1LAAoXsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xig+Jm3ouyakqnUm5MNd5Sv45PlK1ptzAoLhiHLaZvI=;
 b=nGoqaHElE6RtH9PKqovpKCyUcePJCH9t5AS0h/NZHxQWmlvuuqdHJrVKWS8jkvwdPkHXg6MPbNu2hmNefqMEgQ/TZjePidSnWQTCKCU3WV6NfEdO13e9jGR5l+Pk/FrI5smNK9ETyNZkoWV/NPxlhqvGFWkxLFBhpMdcrSlrQqQgsW7xs0kWqWKHGCU0kRidgdjJdA78olD+8UXETFL3zNzJ55r5gp12qUKi/cJd/dTaZA7VlSZvl+H7rFQ5hesKQhP8DnEH/S7V7xmmHQv7T6KUtE2vfQgJykqYei7xD9MGBEhtgkv8cL9+LVQfAxUmri70Rcil4LRWpVYHEBWloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xig+Jm3ouyakqnUm5MNd5Sv45PlK1ptzAoLhiHLaZvI=;
 b=c8czNVFYZe821DH/zv1i4WmKuwjDRzr+g3NY9tAV93Apa09yMi2htsp0Py1YeegX5qYtywFr4b4w6zcOnYcs7/7pl/ZwpyfRDtvrQNRej7GIJhtHo8QiF7G8M/oIkYNZwF50E6pbvGsJ7PGXHTvsJpEBXaaiK+tb3205eTlqujQ=
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB6272.eurprd04.prod.outlook.com (2603:10a6:803:fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 15:23:26 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::1c38:3e39:bb58:8fb5%8]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 15:23:26 +0000
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
Thread-Index: AQHYnIAGRldFRqOr4kOZ1c4K3zYfO62IdfUAgAB4j7CAAAWJAIAIQw5AgACuYoCAAHgmoA==
Date:   Wed, 27 Jul 2022 15:23:26 +0000
Message-ID: <PAXPR04MB91861BF0BA341211C442B20988979@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
        <20220720213036.1738628-3-Frank.Li@nxp.com>     <874jza525l.wl-maz@kernel.org>
        <PAXPR04MB9186A1D283ACE8BD6954039288919@PAXPR04MB9186.eurprd04.prod.outlook.com>
        <87wnc6xz6r.wl-maz@kernel.org>
        <PAXPR04MB918621013E6276D37B56C48488949@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <877d3zx9su.wl-maz@kernel.org>
In-Reply-To: <877d3zx9su.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59cd687b-d2c0-433d-19ab-08da6fe3f3dd
x-ms-traffictypediagnostic: VI1PR04MB6272:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0r5ji3nDU59OsErM5B/249c8wm6B+CoLwVhPP+58M+Xij26n/h8t+2Iwsh5M7S1ptLetPRO0Q2BKS7sTEMUDAsosLpcIpgbyp/SQHgRJqT/FgmpjE7YutbcOLi+TYAHnmhjkgHdGNdzi819cDuoviA+qFayFLJGJWyRraig4a2pwUFKCHPhi2KYsuwX641OswiYL/gFywL4AzI+fwiKWP2kKC8pJiMUl7Tc930U7rQBhJJuRkHbDfxRJFuWzpQMBm5kyGkbbSANK0aAr1R3GRJ1Buqic05tYTQ9UfnVFBxUPaE7pVBYFcSVQAEgnjBqmj+zldFVkTqzlgvk2EIVqtIkrOGpJIV8/4rYrAu8R/WHj0gj2RBWERdOk+WjWUTuIe6S9g+J3Fd5FaC7tE5kOcIGlUJlCSkIO1v2Kit4R1VBBrmkY3v/MiMmxAeR52IA0pswwwUiJDzU65iCWerxESCBEnvFth3ENIB5yCyaYLCNemZvIrCTADRfD9vTMpYnhv5djOLh56e8XZRokYhudOcE19kPgQXg9tv8iaGsS+bgJIWHMooBWHDykJDr6+V0JEy1NhE4hpyLOpMUneetmOrJe2dwk4rFqRrZjZS3dn2cLEq8omcQeHPpgXwVZL2e98cltXd+PLUPy1p5dHCvydV9XOgKIJMVmFE/YCDSbIZPcZTv3RknwSTA0FoRdDYYvRwXjZtSZcArl42MVZt7INT2yIB7vrMMZ9sJuzJT3vZOqXB5yUDAa/uigrwmqnu7RMFxSkrdxKihJ3HUjZkQ8WHq8SHD0iMqPxE74uLzRru3dXwD7SfrLo3Em9nN3AIe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(478600001)(7696005)(9686003)(71200400001)(6506007)(38100700002)(53546011)(55236004)(41300700001)(38070700005)(86362001)(26005)(122000001)(186003)(83380400001)(5660300002)(8936002)(2906002)(44832011)(66476007)(7416002)(52536014)(55016003)(4326008)(66446008)(66946007)(33656002)(66556008)(76116006)(8676002)(64756008)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NN/HvMgdJGYZ0m8GlIKYfC3m0lWia4VWwkSSoElKea+gGCW3fc0uDtNDYv2G?=
 =?us-ascii?Q?C9ZJQZZfDA8VHkis8RYvIvanZW5ZaR3oX/QhSWgslA5U6WEenluW6uu0M97P?=
 =?us-ascii?Q?DJBdm1OPxevONNTs1TxMjRL1PO5sph+qxs52CIn15O1atQbQPeGeATXWqVzM?=
 =?us-ascii?Q?09v1IOiQ3NJg6BpEtGl4g3HbBA4LhQQN4i1m4e7mnSCX8ScTz4H1WkhF03/p?=
 =?us-ascii?Q?GAz5qIf1zdHqnXry4FuGl599kNW9zEW1Fln7+k5sDLn02YI+9uAsPLHeS+6y?=
 =?us-ascii?Q?GGQJ0uXD6XW2wrzGh6D8PerLiTF987C6BIIFUZlUz37OvwBEq2MsQ0pL+A6T?=
 =?us-ascii?Q?rCL3xQf1E6PwhfBbV6ZKUM3ftjFNGnP2+8AeSuQMCKJy3gI91e8XJbOC9MUl?=
 =?us-ascii?Q?ew4oe5ytzlBgZKWF3Iz4WHWMFjTdfTn+7THnBsQW4e1DxftQ5OxxZeFrqru/?=
 =?us-ascii?Q?F2oSZWCK0sEPopUzbkaU81pt0G4gwXzu4qnoXgTGNE7qh7k9oPyCN/KBExA5?=
 =?us-ascii?Q?Byh7kFnwQidPxHzO+pVL+ekG7NlbG0yEXjqDrxjlPCiExMcqQOqVf1vjJ7dJ?=
 =?us-ascii?Q?3dBWSnxLuw/0n2/35tCD87EUu44mZMS9mu4MkYqGyVRDFK3JnmKNt/axjmMF?=
 =?us-ascii?Q?cPKjPiVb1aBFV8romHCugS9RBaS+Z1wstE/++ROenp/0697ZWTclq4ReBazQ?=
 =?us-ascii?Q?LMuphSam20fLiC6UCKYAryBbK5V27IAb5cPUmQoriChB7MEBgYhvTs/96mwK?=
 =?us-ascii?Q?zPWDLcKay4NYp6J9leXH77FNSBp3yYCcVSbcQ8zFQZYfQ/bVezwx9Iha6CLF?=
 =?us-ascii?Q?5At4jahQb0TMV6W+Zte9hrYvp6EWV3wKj+p69IVrg8Oq5XJhBrKtgm55Li47?=
 =?us-ascii?Q?CdC172Pbt6xsPqS/CC3LmviTieWyEWYV/5GO1ly+MScSqEQYrDpwQA6CzPR0?=
 =?us-ascii?Q?n4W6NrECT1mND3kA6Mh4LhXrpHLcEwcvwORA/7zmHV638ayzWQWXS60ti/DW?=
 =?us-ascii?Q?OPQ/6xkd/bQrGShRi2iGQJaFksoi79ioU3o4giilqSbwCIRPwvc9k2rwVGSZ?=
 =?us-ascii?Q?G72c734FrDn6h4Y07AdPwGd00A5/EOzohlBYSDlL6ZwjINnTi6AL7cPXdCNZ?=
 =?us-ascii?Q?yM3KCPQ5SutQQKKSXQSKd+Xd/Q1Y4G1OgQW3J39Yc6AN07WkNYLa3fnh5zt0?=
 =?us-ascii?Q?glvHpZRlKRTs4+MVUTVgz9h2q/9fU4Rj5Fr2bNXUSD3XQjuBPWOxPn81i333?=
 =?us-ascii?Q?lDf/R0N1jYaW9ABiLc5XhnvpQIb6R6LXwx0otG4DjKfi+gtSVMDUazLxYuwK?=
 =?us-ascii?Q?5RJuxYJb0p5CwC2xNUe1/dYVA12o1qgYLnPJaN7dKpsmq+hDHxw3ngWW1XpT?=
 =?us-ascii?Q?ks+xCvzbr5QsceBFWYWpIfquWs8N/WxO4gGcbOQPJ78YO6XtZJaMyQk0BkL+?=
 =?us-ascii?Q?W/r5XbV4emCxgu4k2lMG/ArADBG3QcYOgB5gz4yRrSlrYdei78h/dAuJgLM0?=
 =?us-ascii?Q?xhNjruevqtetGhMZqDotvR2BZ0wv5oPzGhT2/FMuP1xpp1bXYdaWBD+LYIvx?=
 =?us-ascii?Q?h0YjN6YXTcHvdSH/e98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cd687b-d2c0-433d-19ab-08da6fe3f3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 15:23:26.5490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iw6oQfvYbZdrnfPd0WCfX7kjEc3bkAGqrlmq27q2/TGgV+ASzoUPVK67OMW6ndHdQvU0gDJQY6PlurNm8V3m5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6272
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
> Sent: Wednesday, July 27, 2022 3:03 AM
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
> On Tue, 26 Jul 2022 22:48:32 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> > > > > > +static void imx_mu_msi_irq_handler(struct irq_desc *desc)
> > > > > > +{
> > > > > > +     struct imx_mu_msi *msi_data =3D
> irq_desc_get_handler_data(desc);
> > > > > > +     u32 status;
> > > > > > +     int i;
> > > > > > +
> > > > > > +     status =3D imx_mu_read(msi_data, msi_data->cfg-
> > > >xSR[IMX_MU_RSR]);
> > > > > > +
> > > > > > +     chained_irq_enter(irq_desc_get_chip(desc), desc);
> > > > > > +     for (i =3D 0; i < IMX_MU_CHANS; i++) {
> > > > > > +             if (status & IMX_MU_xSR_RFn(msi_data->cfg->type, =
i)) {
> > > > > > +                     imx_mu_read(msi_data, msi_data->cfg->xRR =
+ i * 4);
> > > > > > +                     generic_handle_domain_irq(msi_data->paren=
t, i);
> > > > >
> > > > > Why the parent? You must start at the top of the hierarchy.
> >
> > [Frank Li] Do you means that should be msi_data->msi_domain instead
> > of msi_data->parent?
>=20
> Indeed. you must *not* bypass the hierarchy, and the top level of the
> hierarchy has to implement whatever is required by the interrupt flow.=09
>=20

[Frank Li] I see, just want to confirm msi_data->msi_domain should be corre=
ct here?
It should be leaf of irq hierarchy tree.=20

> >
> > > > >
> > > > > > +             }
> > > > > > +     }
> > > > > > +     chained_irq_exit(irq_desc_get_chip(desc), desc);
> > > > >
> > > > > If your MSIs are a chained interrupt, why do you even provide an
> > > > > affinity setting callback?
> > > >
> > > > [Frank Li]  it will be crash if no affinity setting callback.
> > >
> > > Then you have to fix your driver.
> >
> > [Frank Li] After debug,  msi_domain_set_affinity() have not did null ch=
eck
> for (parent->chip->irq_set_affinity).
> > I think impact by using dummy set_affinity is minimized.
> >
> > int msi_domain_set_affinity(struct irq_data *irq_data,
> >                           const struct cpumask *mask, bool force)
> > {
> >       struct irq_data *parent =3D irq_data->parent_data;
> >       struct msi_msg msg[2] =3D { [1] =3D { }, };
> >       int ret;
> >
> >       ret =3D parent->chip->irq_set_affinity(parent, mask, force);
> >       if (ret >=3D 0 && ret !=3D IRQ_SET_MASK_OK_DONE) {
> >               BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
> >               msi_check_level(irq_data->domain, msg);
> >               irq_chip_write_msi_msg(irq_data, msg);
> >       }
> >
> >       return ret;
> > }
>=20
> No. Changing the affinity of an interrupt must not affect the affinity
> of another. Given that this is a chained handler, you *cannot* satisfy
> this requirement. So you can't change the affinity at all.
>=20

[Frank Li] I understand affinity can't be changed.=20
But system use set affinity to write msi msg.=20

The call stack as
[   25.508229]  epf_ntb_write_msi_msg+0x78/0x90=20
[   25.512512]  platform_msi_write_msg+0x2c/0x38
[   25.516882]  msi_domain_set_affinity+0xb0/0xc0=20
[   25.521330]  irq_do_set_affinity+0x174/0x220
[   25.525604]  irq_setup_affinity+0xe0/0x188
[   25.529713]  irq_startup+0x88/0x160
[   25.533214]  __setup_irq+0x6c8/0x768

I have not found good place to hook a function to write msi msg.=20

int irq_startup(struct irq_desc *desc, bool resend, bool force)
{
        struct irq_data *d =3D irq_desc_get_irq_data(desc);
        struct cpumask *aff =3D irq_data_get_affinity_mask(d);
        int ret =3D 0;

        desc->depth =3D 0;

        if (irqd_is_started(d)) {
                irq_enable(desc);
        } else {
                switch (__irq_startup_managed(desc, aff, force)) {
                case IRQ_STARTUP_NORMAL:
                        if (d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP)
                                irq_setup_affinity(desc);
                        ret =3D __irq_startup(desc);
                        if (!(d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP=
))
                                irq_setup_affinity(desc);
                        break;
                case IRQ_STARTUP_MANAGED:
                        irq_do_set_affinity(d, aff, false);
                        ret =3D __irq_startup(desc);
                        break;
                case IRQ_STARTUP_ABORT:
                        irqd_set_managed_shutdown(d);
                        return 0;
                }
        }
        if (resend)
                check_irq_resend(desc, false);

        return ret;
}

>         N,
>=20
> --
> Without deviation from the norm, progress is not possible.
