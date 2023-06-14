Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E872F295
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 04:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjFNCaU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jun 2023 22:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFNCaT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 22:30:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F59183;
        Tue, 13 Jun 2023 19:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eILoTNjdPHIsVVaHUYiXiHLBUaH++8V7YA3iR8xrjUvXQ18bwYb323ZkIr9guZ7lc/M+9uQJOifT/5UQWriiViuDpLEQRdATo3/aY9f7GMjWg5bcsyVpS3Ry/tClrIxfV0GT4LoeQYdJEN/Rt2fWl5g4Kw1sITS0hg9Ef0dIlQtnPZxMkdSjR17kpEJdEjMWhXJqWkKMtoHqj+HJb/3cIm5CIrRCUYQH9Ml8+AMz4g3SwNoEs55u4ACkP1WrhcQs/6ke8rtiBBeQ5fFCdwkZcbgJxXAImXNW5tIREkl/hXvJB79e2rmoJ5SOkswugtzD4lTmShZClDfs9nXg5byVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v3L4Rffm1b4qULj8Qle3NOAK00qMdIq3IBtM6cB3v4=;
 b=gAhCK3quKQY+czcpZQIdJro2AuQstRX+kNEHZLL7WVk51ispMCZvN4lhTQWQ2LMcrjkyvSysW9POrpMTyhKqwNXD9aEVbrlmvclkoFdFYqm2a56Id3ngnchcmO2fuRdpH0mXJQ+a2NGwdMmyVXqg+3pYYd1os9tilavsvTwZdcvlroafiKnHcLW4h5Km64KPFOrlAckjEliNyww3pctUc+WPMywdAkHEUeg+PLFdQTv2Wc8n87qKX5Pwcve7ka7QhPvuqSLulTGuJbpvyXGu/Lrx8jR4hnYVsg1rw++zxHEFohMd8OiE/23N9GtKfaiA0jfhyBcCgMRLj5oz5FLUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v3L4Rffm1b4qULj8Qle3NOAK00qMdIq3IBtM6cB3v4=;
 b=lwx9z230sAxkopGogNF3hmOBZ/9NN/9fFATxiDfZSYxhs7gBpAeoGhw9BlxfSZfuEzYzrliDRP6eEIuo+UZqflwFiiQUIxbOgiAf5PFxPisU0Vlxri5H9zz7vGp2JlPNmNDz0b4dFrQfFfLQ9ZDuJ5gUi5FeUkPo0UxUAbtHQd8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10647.jpnprd01.prod.outlook.com
 (2603:1096:400:2a3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:30:13 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.047; Wed, 14 Jun 2023
 02:30:13 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZgwfSD1pv8+kZFEalYK7OljPo8698cOgAgAEOU0CAAe45gIABPKpggABUd4CAANbBAIAApgeAgATdZkCAAG/UgIAB+7ug
Date:   Wed, 14 Jun 2023 02:30:13 +0000
Message-ID: <TYBPR01MB534161A79DFF1830B65D303FD85AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-20-yoshihiro.shimoda.uh@renesas.com>
 <20230605143908.fcgqzedp7oiarbyu@mobilestation>
 <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230607121533.cxvidvdqat5h2tqu@mobilestation>
 <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230608121115.qnilmougdfd6fdyq@mobilestation>
 <TYBPR01MB5341AD39983D6B39034AF01BD851A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230609105407.c4olqepv7vuoqktz@mobilestation>
 <TYBPR01MB53411835ACCD884FCA9ECBE2D854A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230612195149.hdnttkcabynmf4kx@mobilestation>
In-Reply-To: <20230612195149.hdnttkcabynmf4kx@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10647:EE_
x-ms-office365-filtering-correlation-id: 05df7e5b-29fe-495e-3c14-08db6c7f488d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1NHvGNkyWCkbgPefZE3Evs5fOm/K+WD7DnI+eYrhMOYS/JiZb54tg/uroOYpuhKfiukdRdWkSKk3HcuxghzsiGnPXb/wL26gZvjVgwmipNxLo8HnNDs0IpMUmJDkJeeZU11hzH9M+JwfeG17lIkwdduUZ5VWFAAvyukgPcpQar7v1wMtJiEJi46BHQHzGLsNSuV2I6TdBD7lxB7rG3H/xPSbI/0layvFCGh6E04w6eaZ+rU3oYyNyswY8zKishL2JbiIhwCISU6dHuRAp2Ujx1I3mjslis7ctKEoPZBXGYbWqTlOLxix0LHHotEavvPbmFc4lAmAmP1HyNII2o+Sp/rVYc/ZKUo76BfJNRDDZRVcpE87KWyD/5jnY+1ZSJ6dIiR1dR5kU82YFatnxqCVnpHoBSZjuK4/ZCXsCJH1A0JZEVNyujUTKvCBKcYz/W8eiP8hESBm48bxSjcvUOHFtH5tIIDv/fF7eruntiJiVFd/57+vi/nql+ERH67TZ47UWIlkGEKpduK+tpdD1Y8/qjApzNt/qyDAbl5ZhHeMRkypk8ixuAkFyQozl/J9ZiVwMrMcKpEF5VEvnLRGHav8giA5a07WwWVYUR80iuAiop+0WCHS5CXNbHi5tnDxMNh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(33656002)(478600001)(71200400001)(2906002)(7696005)(55016003)(8936002)(8676002)(316002)(38100700002)(41300700001)(83380400001)(9686003)(86362001)(186003)(52536014)(38070700005)(7416002)(6506007)(5660300002)(54906003)(66476007)(4326008)(6916009)(66446008)(66556008)(64756008)(66946007)(122000001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AdYCir7r20VHHosY871R4hGNXg5xcgUBY52cWoMrQon5vMEP2CJuA6vHtNrw?=
 =?us-ascii?Q?4uLZsajNsbRvQjr34r4n4LfjCDQvwxEob/pJaTWm1c+zNjinnp16/hJikfWv?=
 =?us-ascii?Q?hJTOlygbUxtu504cjloScDNzgAv1cd1+eP2V7ivxX63SyEwjfSb0AjG/vf62?=
 =?us-ascii?Q?hScZrvjab4QBkFd4oW/qhDgdjSWCO4cR/ByX8bGrl086pqNDTrAt19cGks7j?=
 =?us-ascii?Q?554y7/HntEM9l9aBKUXtzflv8v9HJwDdhxjkgbTC0CIF67EFQAzw/rRWsa40?=
 =?us-ascii?Q?513RLX44/y9fCWs1Jv5lzivfWwZAPJgZqj6Rnd8mkfuiiIIXvcmGWiExRQ4/?=
 =?us-ascii?Q?X7zb3Hao88bPDrFuueIGbx5XTZXtH1oLOS98/jWmT8cd6eYxCqwHeaJ/tq7w?=
 =?us-ascii?Q?SOclKAOrQZNNWCdPwwW5SVdh+2yP3OFwyEhXYU9GHwsxxL1PClxqu+VtgJOS?=
 =?us-ascii?Q?DO4gzJgTSomRxDnDVe5Xr3LcSKvlNf5zAkeLCWYmUmLmV4uPWWVKmSWWe7sY?=
 =?us-ascii?Q?oWvz4ep4rBNn3Whl6Y0fiJ9yvJRXWRMfTyWYZZVaBBFmIxKkhTFq+Rmn5c7P?=
 =?us-ascii?Q?fnBaJT4V1l15CwbjDjLGBRjPdBhicnJv70pn7W2L5b6DRODw/sC0J6nDBA9J?=
 =?us-ascii?Q?6UzouCOqK6Gajeqrwdun18NnZFIiCiD5/Qn4JrzTmnXedsfG24L/Zf2MJve+?=
 =?us-ascii?Q?dtdOlFFjL345KgiaSjA0t3AqtQGLsNELdA1vsOUL9hRHrUF9vr+Oq9icVI5S?=
 =?us-ascii?Q?TXW9g/UOcC537SjxZkMixsgeFuTnz2P+leXVmxXDXKEVNA9rXPhpAhPCU0KH?=
 =?us-ascii?Q?PZeh4TXKJh2V5KR3KkDBIr6xyOBLwLlIQ5oIiVWOeElgJPmneNVp8wuQQwpW?=
 =?us-ascii?Q?PNCr4iDgjAW/o3UL0yKqfCoilh6AjrSkDSkq7vHmyU+MeS/bZuhWOdWgLBUl?=
 =?us-ascii?Q?1b/6kWNW6UwPzK/Y1ofnIvbJi8oRFFsn2DHPGWnbQt8JGKHdUYRH2GdG7buS?=
 =?us-ascii?Q?k3o2Z4AtmHTsEH9o399E7vTCp6Re9ouSmuWcLId/88podJ2ToecDKqNsUM8s?=
 =?us-ascii?Q?8oxmh/p2DWgtQIxJxTiumbuwghQ4EHZa9zg5DlkJNYPJiL8c7U028dCyaXYA?=
 =?us-ascii?Q?WBlb0eWzmr5+sIq+76CfT81yt5OEz39U9dQimV9UZ1i31tAZL1kkuQK/fkEq?=
 =?us-ascii?Q?EFCHk5rLn2JPQXUqXchiSkI9Obb5rSMSeLeBRNDrXtsS9EBZMQEL2KD77MF9?=
 =?us-ascii?Q?getf0sB8JBL7PkzTqo14A3MH0c2NdmxEusOLWcTXQnZN3SmPcwpWqt5kfolP?=
 =?us-ascii?Q?Evw45mNTQ38JSLV+Jw4hIbP2QATuvt7lYHRRdHgjPx2w8DkUK+BFwx3Bc/qp?=
 =?us-ascii?Q?X2YvwrvEwu9hlzYMgekqm1tRbkN8XJiPyVY8QgBaPJzgDz5Fh1vhMBJKGTxI?=
 =?us-ascii?Q?ZbySTguL04fejwpfkgRk47p4qoCvsC57jAB4v7rz+WpX23vnvihb4Xg9BA8o?=
 =?us-ascii?Q?BeaRM1mgG5cLUqBsFBTjtUCaenDb5+OZASk0UBBwArYrKST71Lcf7vHwaXwX?=
 =?us-ascii?Q?I3Tdy56LGLPEkZigjTZiHpDmQLejwpr6QWpB3Tp2jY53397PlnwL5cObDxUA?=
 =?us-ascii?Q?EoImFeJBkYUIUwykTb3WbCAAVMziqJpsdI1coIOEvLPcikEXUGUzmsNmlR9c?=
 =?us-ascii?Q?176yNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05df7e5b-29fe-495e-3c14-08db6c7f488d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 02:30:13.6530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tV/RJ1+RStCPUVDmrKJm2zAkgptmT+izPO7JyRuX6HDfX4WHdOHRhdZtmoxBoerPm2T347EmeBFuncjmLSmmghpfj/vpuUKinifEJcOZmni724yz5gcbR95WeHjUExPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

 From: Serge Semin, Sent: Tuesday, June 13, 2023 4:52 AM
>=20
> On Mon, Jun 12, 2023 at 01:19:02PM +0000, Yoshihiro Shimoda wrote:
> > Hello Serge,
> >
> > > From: Serge Semin, Sent: Friday, June 9, 2023 7:54 PM
> > <snip>
> > > > > > static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > > > {
> > > > > >         struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > > > >         int i;
> > > > > >
> > > > > >         rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > > > >
> > > > > >         /*
> > > > > >          * Require direct speed change here. Otherwise RDLH_LIN=
K_UP of
> > > > > >          * PCIEINTSTS0 which is this controller specific regist=
er may not
> > > > > >          * be set.
> > > > > >          */
> > > > >
> > > > > >         if (rcar->needs_speed_change) {
> > > > >
> > > > > Seeing this is specified for the root port only what about
> > > > > replacing the statement with just test whether the rcar_gen4_pcie=
.mode =3D=3D
> > > > > DW_PCIE_RC_TYPE? Thus you'll be ablt to drop the needs_speed_chan=
ge field.
> > > >
> > > > Thank you for the comment. I'll fix it.
> > > >
> > > > > BTW Just curious. Why is the loop below enabled for the Root Port
> > > > > only? What about the end-point controller? It's the same hardware
> > > > > after all..
> > > >
> > > > This is reused from v16 and then it used "link retraining" which is=
 only for
> > > > the Root Port. As you mentioned, it seems endpoint controller is al=
so needed
> > > > if we use direct speed change.
> > > >
> > > > > >                 for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++=
) {
> > > > > >                         rcar_gen4_pcie_speed_change(dw);
> > > > > >                         msleep(100);
> > > > > >                         if (rcar_gen4_pcie_check_current_link(d=
w))
> > > > > >                                 return 0;
> > > > > >                 }
> > > > >
> > > > > Did you trace how many iterations this loop normally takes?
> > > >
> > > > i =3D 0 or 1 (if the max-link-speed is suitable for a connected dev=
ice.)
> > > >
> > > > > Is it
> > > > > constant or varies for the same platform setup and a connected li=
nk
> > > > > partner? Does the number of iterations depend on the target link =
speed
> > > > > specified via the "max-link-speed" property?
> > > >
> > >
> > > > This is not related to the "max-link-speed". It seems to related to
> > > > a link partner.
> > > > 		LinkCap	max-link-speed	loop
> > > > Device A		4	4		1
> > > > Device A		4	3		1
> > > > Device B		3	3		0
> > >
> > > Great! If so I would have just left a single unconditional
> > > rcar_gen4_pcie_speed_change() call placed right after the
> > > rcar_gen4_pcie_ltssm_enable() method with no delays afterwards. These
> > > methods would have been invoked in the framework of
> > > dw_pcie_start_link() after which the dw_pcie_wait_for_link() method i=
s
> > > called with several checks parted with the ~100ms delay. It will make
> > > sure that at least some link is up with the link state printed to the
> > > system log. If for some reason the performance degradation happens
> > > then it will be up to the system administrator to investigate what wa=
s
> > > wrong. Your driver did as much is it could to reach the best link gen=
.
> >
> > IIUC, is your suggestion like the following code?
> > ---
> > 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > 	if (!dw_pcie_wait_for_link(dw)) {
> > 		rcar_gen4_pcie_speed_change(dw);
> > 		return 0;
> > 	}
> > ---
> >
> > Unfortunately, it doesn't work correctly...
> > The following code can work correctly. The value of i is still 1 on the=
 device A.
> > What do you think that the following code is acceptable?
> > ---
> > 	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > 	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > 		msleep(100);
> > 		rcar_gen4_pcie_speed_change(dw);
> > 		if (dw_pcie_link_up(dw)) {
> > 			printk("%s:%d\n", __func__, i);
> > 			return 0;
> > 		}
> > 	}
> > ---
>=20
> My idea was to implement something like this:
>=20
> +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> +
> +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +
> +	rcar_gen4_pcie_speed_change(dw);
> +
> +	return 0;
> +}
>=20
> and retain the rcar_gen4_pcie_link_up() method as is.

Unfortunately, such a code doesn't work on my environment...

> * Note: originally your loop used to have the msleep() call performed
> after the first rcar_gen4_pcie_speed_change() invocation. Thus the
> delay can be dropped if there is only one iteration implemented (see
> further to understand why).

Calling rcar_gen4_pcie_speed_change() multiple times is required on
my environment. I thought msleep(100) was quite long so that I tried
other wait interval like below:

 msleep(1) : about 5 loops is needed for link. (about 5 msec.)
 usleep_range(100, 110) : about 400 loops is needed for link. (about 40 mse=
c.)
 usleep_range(500, 600) : about 80 loops is needed for link. (about 40 msec=
.)

The delay timing doesn't seems important. Both cases below can work correct=
ly.
--- case 1 ---
	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
		rcar_gen4_pcie_speed_change(dw);
		if (dw_pcie_link_up(dw)) {
			printk("%s:%d\n", __func__, i); // will be removed
			return 0;
		}
		msleep(1);
	}
---
--- case 2 ---
	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
		rcar_gen4_pcie_speed_change(dw);
		msleep(1);
		if (dw_pcie_link_up(dw)) {
			printk("%s:%d\n", __func__, i); // will be removed
			return 0;
		}
	}
---

So, I'll use case 1 for it.

> You don't need to wait for the link to actually get up in the
> start_link() callback because there is the link_up() callback, which
> is called from the dw_pcie_wait_for_link() method during the generic
> DWC PCIe setup procedure. See:

Since the procedure will call rcar_gen4_pcie_speed_change() from
->start_link() once, my environment cannot work correctly...

Best regards,
Yoshihiro Shimoda

> dw_pcie_host_init():
> +-> ops->host_init()
> +-> ...
> +-> dw_pcie_setup_rc()
> |   +-> ...
> |   +-> dw_pcie_setup()
> |   +-> ...
> +-> if !dw_pcie_link_up()
> |   |   +-> ops->link_up()
> |   +-> dw_pcie_start_link()
> |       +-> ops->start_link()
> +-> dw_pcie_wait_for_link();   // See, wait-procedure is already performe=
d
> |   +-> loop 10 times          // for you in the core driver together
> |       +-> dw_pcie_link_up()  // with the delays between the checks
> |           +-> ops->link_up()
> |       +-> msleep(~100)
> +-> ...
>=20
> -Serge(y)
>=20
> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > -Serge(y)
> >
