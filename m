Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427479DE62
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 04:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjIMCtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 22:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjIMCtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 22:49:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842A1724;
        Tue, 12 Sep 2023 19:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fELRAigxp86sDcY1cBq6AWi3eezT0glzKe+MHV06RQc71PMLak/7mwtFgiZK8gm3seuB6PM8AKUWLJfyvyLQ0Q3GhpZHfgsxzcJyDTCMPb4pnYm+/RPDtJNtftMIJp5+H3N+4Xa3+TsBdYidA4ySgu7p+HW0iE6/OphC0HJqCcoG8g09v/okUGuPx5ZVivUdJiqMGogqt45hwCEnVEkR+LM1nSiejCb0btYRz/Rk9JLduo/rzGrjYu1BlBhHkFDoJTbglgX82mrro+PUM9UTv1mpfyUqQCbZDMM+qV901IswkEomRrItgzIxjLa7onuVOPK00+GCieB7RW/fwNy9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPT8WA6NTtkZvz8aG90l+RoiXPtgEYNVmvkOwIGPY1c=;
 b=basIlytAxRufRWDt8bKWUvEOpWqYLaj3Q0bcwiibSL7ProVfvlxhrknuALsO/eHnMSEvoaP5dkgaN9bpMWuKqaF3hluPUy5gmdFR9RPHrfSRnImDz8ukVNhBn2BqqByrsMNyFYdrv4CdYsZbOL7MQWoMMahippyIMFaDr+vfdWd9mnnvVAvldrW5Jycp71OBx/fYJBY93lzEMDE765Eznm3ukEN6Rr67IUOwMayu0ZroUmU0+x08od5Dq4UdFsONnR5KRY5g+0WxwfPVdQmiW6vr4FrFFshG48Q97pC8ieQdiLCCs1J/jA3PflSaoWbg/LJIMG9pgSBrg0mIWzuSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPT8WA6NTtkZvz8aG90l+RoiXPtgEYNVmvkOwIGPY1c=;
 b=MnebWpbkvH8Qs5i0y4JZWioSyXgR+cax26uuoR2Gcv0uZ4nhfh/1H2nr1YYGo83L2s8h95wCwyUL0+abcVEy9Pr39GWI8qwUBWUxWFo6R2t0SpCm0Ji5k+NQxOUddpwhCj4foT47s0rjaSedY36au8EEKTrcGeNEuynjVL4BL+A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8167.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 02:49:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:49:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Topic: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Index: AQHZzxhuyRkzZgDao0KEaKWaunEMhbAX8PmAgAAxQqCAAA8+AIAACMAg
Date:   Wed, 13 Sep 2023 02:49:37 +0000
Message-ID: <DU0PR04MB941790B85BCDD60ACA2601A588F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417E04B52A553984D83540188F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230913021306.GA418113@bhelgaas>
In-Reply-To: <20230913021306.GA418113@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8167:EE_
x-ms-office365-filtering-correlation-id: 019e0d65-aedf-49a0-581f-08dbb40411f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIV10PzO/cIkMdaAWW73rBI8e4hTVA8CdhytCohGUnCU3L5gCJu3+u77Z4uFXWIsDi9Dl3CmP7IDe88hdOdnYmN91fc3nHTCl6bCqYsK57bHb/R6MAJGauXyG0BN5KRok2tY1dTAk/NcTDzetR5tjtMbemnmVpbJ5KJGtKcE8jXzFhl5GmCGpB98wdQ825+iJir8YhF3JSrdjLtL5FguGCbpzljWAFaI0J+aHq6Qu8LSePfsVs6ZBdK1vlpH1ZCkPlsR9qRWTWpVlM4JcWCS6rIw81WEqH0aCwLKx8KRbgsQ0X01yEUUgbHCtG4Nl5KR1xEp0bo8EWtFJ7TmoDnlgFp2+8JPd1Xfd/1cH57mQhIdVgjHbwaEs/o4Js5X+Y6VWylvD/eT2ctUvDacHxo9ziVLp+xz7ppMADezp7XSOA9olxJKjF5VnzZm2cWqyCtlUAGB2fyJqrJLIo9yI78lgtcAgGtxL3kI3fnzYKdIImGf7+mBBJVKhlJ8bt6SW8/oBK+69146IsViEEXFRd+hskw3W66zkdOShIMthAi0IFRqej+2ai0B/tR1icu5MKc6P6npEH6CYqBRtaYPRoMkHggT9c4JHlokWsktBKO/xPKTmKx3RTQJ51GBoMdUWfkM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(316002)(66446008)(66556008)(66476007)(66946007)(76116006)(6916009)(54906003)(64756008)(26005)(83380400001)(45080400002)(9686003)(7696005)(6506007)(71200400001)(33656002)(122000001)(86362001)(38100700002)(38070700005)(55016003)(478600001)(966005)(2906002)(4326008)(8936002)(8676002)(41300700001)(52536014)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4uiVUilp8V+2dWUJ3ScSauHNET6hMDt6ewnO9W68jgXMTvhiChHPBnc0Nba?=
 =?us-ascii?Q?5uLK3D5Qhd8WF+mdHHuCFnckRvT5kMIhnAHz1fGfJV3B8pqo66R8eAQ3Cu0c?=
 =?us-ascii?Q?7EGzIF5+MxPVvAnP6Y4i62pgX9XL/vs9CTJfdFNu+MgRlESkk4rfBmfEA6p6?=
 =?us-ascii?Q?315lbeO8T14cJ2Y1KlQbWKtS2XRxRQqNoTF2LFE1n7UbYvgDbcNewsbxRJXB?=
 =?us-ascii?Q?fW1ynZukVvUkKrUheesp3QzJKwTIgjdmPZA47vx9vLAJ7RFZBLZaaE4p7X8S?=
 =?us-ascii?Q?CalchC3IYRco3ocM9EsCONF2UjdcYFll+MOcYB2yCY9MVBaucd86ODFWCQr4?=
 =?us-ascii?Q?sgwGxoDDW9Yfdwtds89RDANXbV3RRviEU/QvMbZ8PMhEuXm7HNsjjqvg4HF3?=
 =?us-ascii?Q?WrisCEH8CsS/SJ9+B5Egd2tAPNWM0aE6dPMoKm8qwLN44mwzsOqym9j6v0Bi?=
 =?us-ascii?Q?G4EJpvzi5WdO8zVwlkvpSUhdHb6pCVWTuyGmWCFpEIbaSG3klYtls/R6SQuL?=
 =?us-ascii?Q?BvyGS+MgZRrCRQNbkJbUjghiPMv4h1TzYdy+zM7ugQ3UQyrIDv9CWnRf+EgS?=
 =?us-ascii?Q?2EqRzXPX7TabD0O92pVE7AKEFmSCuclIZNG5KoRce8hZGSRt8JJvUczA1uER?=
 =?us-ascii?Q?89Bc0GuwzxD3YH2gCvci5OPwxV1/twbyCree4GUOT4Rv0LLPWwYlggw+r20j?=
 =?us-ascii?Q?qPtGXqTh0S9Zn9U0HS9qCb9raUOFzPJsAdjIoIIz3/+0K49DZc9BQfeX+mcv?=
 =?us-ascii?Q?soPE0+EiWvzEHaBVPZReKVlrgVvvdQ/FKi6jRmQ+H7boApnjhYiasnkQsvW1?=
 =?us-ascii?Q?SJsvCUbHvWIc/DFE4MxNC4omYF9w/noABRhrC/AFT7GlvvdSayqDCzbVnLJ9?=
 =?us-ascii?Q?XorvIxX/nFSdzXGZP/Y8c52tZKqoRaBRRr/4Qrz9IYftZ5bODffBw0zpqIb3?=
 =?us-ascii?Q?mZoyekEEOYLo56fZ4iIjVC/bN09OEIkgB1e4r8pM5hPYbIwkzbBlGTfF/KcN?=
 =?us-ascii?Q?wGme2xOqpcVK3jWmUIehPkHBr4S/NTsHAZFnXZIvY/Jn/Mh/B+qJ7g3BVS+m?=
 =?us-ascii?Q?7lq01RQpn52qc29EYlkAQELrYpJkRB7y3sk8z18lJGohFZYMbKTMV7LuAjmo?=
 =?us-ascii?Q?n8nmKaJxxE6lPQf/s0ntYOnsci9wZiAN5shX1zXWT6KJzHJqyAJof2IV0Feq?=
 =?us-ascii?Q?gUxSlTM4TIgKHclKiJxZ239ZTXcKpNr7XwKJ//Llpc2X3Q/6HJT96p5A1oiK?=
 =?us-ascii?Q?cgzyhO4ODphm8wAyiVNRX4xEftYWsM7J0yoK1dnPUgXwhwN6YmR5qpgKMcJy?=
 =?us-ascii?Q?ihPdCipO326AEitRfecj/puTI3w8a9vNrjOuS2lQXo5xRcraXDmX3D6SBs71?=
 =?us-ascii?Q?eHqeEwxMPJVIpI3ct9UINDAetqfkgJvBzH7l0jpUtUPg49MueT38CvCuZgJm?=
 =?us-ascii?Q?xs69um/vQgo+nhm8LinbWhjAPjwLXeKHFFK1at4vjfhgJ2ORcbMte8/3cWvs?=
 =?us-ascii?Q?expDo6Jbmgz6XkLf9T+nwe2qP3GqaaSBnZKOeD+r3kvIgetNYI6NvJ2y+9zm?=
 =?us-ascii?Q?W6WCjB2K46eJTnOzhWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019e0d65-aedf-49a0-581f-08dbb40411f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 02:49:37.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tyn8ncdINyY5wlr1aOEhaMd8gmuHCDjX4pRMfxktvvUkIKjUDXDc6u9v3bZMydRxSu51LLB61sNJvAvjf+ZMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8167
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr fr=
om
> which IDA
>=20
> On Wed, Sep 13, 2023 at 01:24:26AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2] pci: introduce static_nr to indicate
> > > domain_nr from which IDA
> > >
> > > On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > When PCI node was created using an overlay and the overlay is
> > > > reverted/destroyed, the "linux,pci-domain" property no longer
> > > > exists, so of_get_pci_domain_nr will return failure.
> > >
> > > I'm not familiar with how overlays work.  What's the call path where
> > > the overlay is removed?  I see an of_overlay_remove(), but I don't
> > > see any callers except test cases.
> >
> > We are using an out of tree hypervisor driver:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2Fsiemens%2Fjailhouse%2Fblob%2Fmaster%2Fdriver%2Fpci.c%23L
> 483&d
> >
> ata=3D05%7C01%7Cpeng.fan%40nxp.com%7C1bf0364c585f42dae7f108dbb3fe
> fcc4%7C
> >
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63830167996269745
> 6%7CUnknow
> >
> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> JXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DraIsz2HIH%2FQ0nmolBBwd81
> WxQh2vmFeXN
> > t3n6OIQaSU%3D&reserved=3D0
> > >
> > > I guess the problem happens in a PCI host bridge remove path, e.g.,
> > >
> > >   pci_host_common_remove
> > >     pci_remove_root_bus
> > >       pci_bus_release_domain_nr
> > >         of_pci_bus_release_domain_nr
> > >
> > > But I don't know how that's related to the overlay removal.
> >
> > When the overlay node got removed, the device removal will be invoked
> > and the domain number indicated by linux,pci-domain should also get fre=
ed.
> >
> > But actually the domain number not got freed because of bug as this
> > patch shows. "of_pci_bus_release_domain_nr will actually use the
> > dynamic IDA, even if the IDA was allocated in static IDA."
> >
> > So after the overlay node got destroyed and our test recreate the
> > overlay node with same domain number, issue triggered, the device
> > could not be created.
> >
> > > Is this an ordering issue?  It seems possibly problematic that the
> > > OF overlay is destroyed before the device it describes (e.g., the
> > > host
> >
> > No. it is "of_pci_bus_release_domain_nr will actually use the dynamic
> > IDA, even if the IDA was allocated in static IDA "
>=20
> Yes, that's the *symptom*, to be sure.  My question was why the overlay w=
as
> removed before the host bridge.

I am not sure.
I added a dump_stack, would this help to understand?
root@imx93evk:~# jailhouse disable
[  595.150529] CPU: 1 PID: 582 Comm: jailhouse Tainted: G           O      =
 6.5.0-rc4-next-20230804-05021-g3d4cc14b42ef-dirty #355
[  595.161998] Hardware name: NXP i.MX93 11X11 EVK board (DT)
[  595.167475] Call trace:
[  595.169908]  dump_backtrace+0x94/0xec
[  595.173573]  show_stack+0x18/0x24
[  595.176884]  dump_stack_lvl+0x48/0x60
[  595.180541]  dump_stack+0x18/0x24
[  595.183843]  pci_bus_release_domain_nr+0x34/0x84
[  595.188453]  pci_remove_root_bus+0xa0/0xa4
[  595.192544]  pci_host_common_remove+0x28/0x40
[  595.196895]  platform_remove+0x54/0x6c
[  595.200641]  device_remove+0x4c/0x80
[  595.204209]  device_release_driver_internal+0x1d4/0x230
[  595.209430]  device_release_driver+0x18/0x24
[  595.213691]  bus_remove_device+0xcc/0x10c
[  595.217686]  device_del+0x15c/0x41c
[  595.221170]  platform_device_del.part.0+0x1c/0x88
[  595.225861]  platform_device_unregister+0x24/0x40
[  595.230557]  of_platform_device_destroy+0xfc/0x10c
[  595.235344]  of_platform_notify+0x13c/0x178
[  595.239518]  blocking_notifier_call_chain+0x6c/0xa0
[  595.244389]  __of_changeset_entry_notify+0x148/0x16c
[  595.249346]  of_changeset_revert+0xa8/0xcc
[  595.253437]  jailhouse_pci_virtual_root_devices_remove+0x50/0x74 [jailho=
use]
[  595.260484]  jailhouse_cmd_disable+0x70/0x1ac [jailhouse]
[  595.265883]  jailhouse_ioctl+0x60/0xf0 [jailhouse]
[  595.270674]  __arm64_sys_ioctl+0xac/0xf0
[  595.274595]  invoke_syscall+0x48/0x114
[  595.278336]  el0_svc_common.constprop.0+0xc4/0xe4
>=20
> The current ordering is this, where A happens before B:
>=20
>   A overlay is removed
>   B pci_host_common_remove
>       pci_bus_release_domain_nr
>         of_pci_bus_release_domain_nr
>           of_get_pci_domain_nr      # fails because overlay is gone
>           ida_free(&pci_domain_nr_dynamic_ida)
>=20
> But if the host bridge were removed first, the ordering would be as follo=
ws,
> and the problem would not occur:
>=20
>   B pci_host_common_remove
>       pci_bus_release_domain_nr
>         of_pci_bus_release_domain_nr
>           of_get_pci_domain_nr      # succeeds in this order
>           ida_free(&pci_domain_nr_static_ida)
>   A overlay is removed
>=20
> Is there a reason the overlay should be removed before the host bridge?
>=20
> Obviously the overlay is loaded before the host bridge is created, and
> symmetry would suggest that the overlay should be removed after the host
> bridge is removed.

Hmm, I need check more. But do you think this patch is fix a real issue or
If order is did as you say above, this patch is not required anymore?

Thanks,
Peng.

>=20
> > > bridge) is removed.  I would expect the device to be removed before
> > > the description of the device is removed.
> > >
> > > > Then of_pci_bus_release_domain_nr will actually use the dynamic
> > > > IDA, even if the IDA was allocated in static IDA.
> > > >
> > > > Introduce a static_nr field in pci_bus to indicate whether the IDA
> > > > is a dynamic or static in order to free the correct one.
> > > >
> > > > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > >  Update commit message
> > > >  Move static_nr:1 to stay besides others :1 fields.
> > > >
> > > >  drivers/pci/pci.c   | 22 ++++++++++++++--------
> > > >  include/linux/pci.h |  1 +
> > > >  2 files changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > > > 60230da957e0..5c98502bcda6 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -6881,10 +6881,10 @@ static void
> > > of_pci_reserve_static_domain_nr(void)
> > > >  	}
> > > >  }
> > > >
> > > > -static int of_pci_bus_find_domain_nr(struct device *parent)
> > > > +static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct
> > > > +device *parent)
> > > >  {
> > > >  	static bool static_domains_reserved =3D false;
> > > > -	int domain_nr;
> > > > +	int domain_nr, ret;
> > > >
> > > >  	/* On the first call scan device tree for static allocations. */
> > > >  	if (!static_domains_reserved) {
> > > > @@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct
> > > device *parent)
> > > >  		static_domains_reserved =3D true;
> > > >  	}
> > > >
> > > > +	bus->static_nr =3D 0;
> > > > +
> > > >  	if (parent) {
> > > >  		/*
> > > >  		 * If domain is in DT, allocate it in static IDA.  This @@ -
> > > 6899,10
> > > > +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device
> > > > +*parent)
> > > >  		 * in DT.
> > > >  		 */
> > > >  		domain_nr =3D of_get_pci_domain_nr(parent->of_node);
> > > > -		if (domain_nr >=3D 0)
> > > > -			return ida_alloc_range(&pci_domain_nr_static_ida,
> > > > -					       domain_nr, domain_nr,
> > > > -					       GFP_KERNEL);
> > > > +		if (domain_nr >=3D 0) {
> > > > +			ret =3D ida_alloc_range(&pci_domain_nr_static_ida,
> > > > +					      domain_nr, domain_nr,
> > > GFP_KERNEL);
> > > > +			if (ret >=3D 0)
> > > > +				bus->static_nr =3D 1;
> > > > +
> > > > +			return ret;
> > > > +		}
> > > >  	}
> > > >
> > > >  	/*
> > > > @@ -6920,7 +6926,7 @@ static void
> > > > of_pci_bus_release_domain_nr(struct
> > > pci_bus *bus, struct device *par
> > > >  		return;
> > > >
> > > >  	/* Release domain from IDA where it was allocated. */
> > > > -	if (of_get_pci_domain_nr(parent->of_node) =3D=3D bus->domain_nr)
> > > > +	if (bus->static_nr)
> > > >  		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> > > >  	else
> > > >  		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> > > @@ -6928,7
> > > > +6934,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus
> > > > *bus, struct device *par
> > > >
> > > >  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device
> > > > *parent)  {
> > > > -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> > > > +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
> > > >  			       acpi_pci_bus_find_domain_nr(bus);  }
> > > >
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > > eeb2e6f6130f..222a1729ea7e 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -677,6 +677,7 @@ struct pci_bus {
> > > >  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
> > > >  	unsigned int		is_added:1;
> > > >  	unsigned int		unsafe_warn:1;	/* warned about RW1C
> > > config write */
> > > > +	unsigned int		static_nr:1;
> > > >  };
> > > >
> > > >  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> > > > --
> > > > 2.37.1
> > > >
