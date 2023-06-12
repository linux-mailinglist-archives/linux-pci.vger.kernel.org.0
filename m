Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB39872C5AD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjFLNTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 09:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjFLNTK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 09:19:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4010DA;
        Mon, 12 Jun 2023 06:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLsidEwOcBIbVlF1221rsvjDe5FDeUHUzi4BIjf87sxCnU4SJb8pHUIq7PiGWyETQ8q3N7hvESwRcaO1eis7LldACQD1bylIo77A4AK1IFr2189Rwy53HHAWPiIeviZV8teVJbl84nEt0wg/6ZIilSmQAqm6alDqt9pBBvovGZy3bhyvCtNHT8/Rj4oQSuOtQYzlXoLMdccLF57/DDjKZ2tjy9j1l/bP2KUXkPqGE6LuGh5anqyiIQfxtDkv0FSYAKfCyh84YJPsanLqkLyVdHvwXBvzIsc5yVedOgnxoTtiUnRN5sGFkBk01s6Oug2OGAtZickdtwRiB3L4d00tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzBEBS1sOX9/bvN9RCMp1NMzXVL1cZqHVZy8b2QCjCw=;
 b=FQ1PEowGNQ87TGQO7sUnqesmB8n8472xaAXf4LsPiuYtQ8AxlJLAL70zwLw5wSeYQLeyhEvwzNQlj1b6p2Oy8JJa/sHcIFlywhgbHl+hXSi7FLFENd78YYnLT+jo6kx0CVBk6hORZUxTLVl3LN/mUIZbdjrcyIaqtivN5mg+36ZiLWWLBNYx4ZMHqZ6PWpdBE3s80KV2HvoNHNcLTu4mhFnrwgTkiZhy2Lhw3lQFoRHR2ixJR/KMSjkWlGjySV2AzmgmaUgIv3GeLq7GudpEg0amr20u0pezI08o1ZdHoiS5y1Et3u8VmoLnMqzY0ZanUn+9wa/qsYfaZD1EUd7baQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzBEBS1sOX9/bvN9RCMp1NMzXVL1cZqHVZy8b2QCjCw=;
 b=nXj2yrn0ih0u1NXbYy2eDf3xCz56E+ocFI9zbsK2+2Iw9xIv/EKq6QvJPN+d2XK9Y1qSkMuxTrvw9fyEsQgNW2DE/0kKSEaemAH+Kp+NazsxuCXQbkehE1blIV8tIlAOFSGxjlN/HHy781kttuJR077GSUbVbCkztGCsrprcfBY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB5693.jpnprd01.prod.outlook.com
 (2603:1096:400:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:19:02 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 13:19:02 +0000
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
Thread-Index: AQHZgwfSD1pv8+kZFEalYK7OljPo8698cOgAgAEOU0CAAe45gIABPKpggABUd4CAANbBAIAApgeAgATdZkA=
Date:   Mon, 12 Jun 2023 13:19:02 +0000
Message-ID: <TYBPR01MB53411835ACCD884FCA9ECBE2D854A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-20-yoshihiro.shimoda.uh@renesas.com>
 <20230605143908.fcgqzedp7oiarbyu@mobilestation>
 <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230607121533.cxvidvdqat5h2tqu@mobilestation>
 <TYBPR01MB53417E55F5F9E667D679901CD850A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230608121115.qnilmougdfd6fdyq@mobilestation>
 <TYBPR01MB5341AD39983D6B39034AF01BD851A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20230609105407.c4olqepv7vuoqktz@mobilestation>
In-Reply-To: <20230609105407.c4olqepv7vuoqktz@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB5693:EE_
x-ms-office365-filtering-correlation-id: baa0da94-0087-4a8f-a6ad-08db6b479700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQRKeZMMcQlDk8iD/yPghWbp59t92rR7WwYPaUkJ1DjoCYt08D2gbNq5ptNMKFW2uJNy0Vdidv2hTsLWtG69hVGzjGGpHA5ir7psfqGd01LBs+5nWELAXJHTwJZ7EuXKCGUXyNIfkV8bWLPy8HITcsrezFyniw7wR+YgiquEUVpPdbdgjrcxFQ1gsisaVIM4DrN63fUSp2vMzYiDKju9MzzFAxUxoCDNJDX9C2Qi71c5xKo5PxuTqa6oaSFCJeVIebAK3u/mdK0SyLHQ8oAdRfEmVwo9JBAbrnXxqythFLcP0EkeO1hr4HUQXoBngzDNiMEm01DpuMOV9TCYBLaczG0egrcFti5M3r0R9hE9zL8pxqR26wQ7g8R2K/DQcHY2+wtVAkHwrnsqfUevydx1z54zMwNSNC6c67/2qAWHlUCpwU3XCnh+2fu/Q6M0ZGdtVDexeH919tEDPjhvNWQcrz4aDIXNKsciFrmJPcgqO9e18+KLM2GmGA+PnphEJPQmtixmGUuUWYlqYVGgUCRt76ydGdSN0LeNrLe87w4GP5v3mG7toTS+dG1YVBOmmkq9dbjJM5EJg2e2qpx6nxNN+dfnjextb3c+x3rv9ytQaBNcmR+A3TEr0cNxWHbHIbS4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(71200400001)(7696005)(478600001)(122000001)(33656002)(9686003)(6506007)(83380400001)(186003)(86362001)(38070700005)(38100700002)(55016003)(6916009)(66556008)(66446008)(66476007)(76116006)(66946007)(64756008)(4326008)(316002)(8936002)(8676002)(7416002)(52536014)(5660300002)(2906002)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P4IcQ1Vq/Rxv5ex39zxsVtoyIZhTEgkmRPdXKz/8u29XcMC8Mqy6T1s2Se2Y?=
 =?us-ascii?Q?DNRbr5oOLYx6SavKagh3j4aJpvtMze/R/O7ono5NJzxO5eUu0lw0ZEEZuxFZ?=
 =?us-ascii?Q?X7+oIV1A+nDVOkKJKbsL3p9ViRM6sJ1Frvz+zvhcQ4/XTRM0ADBVI7gz8OwF?=
 =?us-ascii?Q?ebH9kp7crFMjau+bkdk4D9S3wgvrsHG7dDG8FTNQXw9yRdCcsbFtaQlthLGx?=
 =?us-ascii?Q?ioibOMzPvqVy8oON2UYy98/RnpR1wrQZUT9DsDG8zz+iQmALrMB0+ZNb5aGZ?=
 =?us-ascii?Q?7TJTITAWTe7zk/4YdFXHiKYzyIDi1tbW4iKfgQEI8H/WYFSEvgfxdRGbJP04?=
 =?us-ascii?Q?XT59+6h35K5Dgrf+Yxi/uzvqlhQuGnDDuOgrxHSbJLr5/JcT1RhFyNkzm5Ph?=
 =?us-ascii?Q?qB4q9CYSvJqKFuxtOSt1K3IgfM1uANLMgpyWkrlfcieSaPBBKnY9dmOv76Q2?=
 =?us-ascii?Q?RUmH7gWvYYq8nyYUVnOt6sUEaP55C8t8cqNPbjasqympezp302uaGYge245V?=
 =?us-ascii?Q?dXy4TQoL8sBshV50caT7sQb7JBV9aSfZYQqR6V4b4csFg1iQy42/WYonv8E8?=
 =?us-ascii?Q?hXTpTNnE9+nuRbx8mb5HYilkEs625AuMsjS4lzy6MTTt8L2/TPWnzRC97WfZ?=
 =?us-ascii?Q?W4y0a1r7LR0d9PfTH3FMfZBQZwxHOhujMNFO85vdsLIrHf/8vICxofbGMvxk?=
 =?us-ascii?Q?0+9kJvaM4AMWZAs1tVpPjg3+9xAL5JwMxatXdl9FGvbHFtijeM6cid4AiwD1?=
 =?us-ascii?Q?oUwkDHu6vP7fE8x4ozchJtNVUvfvy6FZXeUd+xnBA/dUjnaiBfkaXAk9GBaB?=
 =?us-ascii?Q?yGXY6KwJvnBEdEXYJgBKHOfnBeHY2SXRWJGLDtRKoL6qTqSJQhlsCgjKsgyq?=
 =?us-ascii?Q?72Q/MwVgSp2t7RQfcMPF7zYFWyZBjQQEjeJu9CA/kSqUM5OFpc/pzTu3sAGC?=
 =?us-ascii?Q?N0WxRFSyk5eabTxTNsIB1dF0goFruRumkCpbc2TB4XApp7CuTGcIZ06hvQEh?=
 =?us-ascii?Q?jn3/EgGPvpXfawrefZpqUZKcQWey4lYCKqqS+z+niX6c6OmxLkrGb23L2LTB?=
 =?us-ascii?Q?Ei6erNBNHeBweIQ0V+LxS61ISVHvo9dD+kERexYRGjYEoljnUM48Ic5Agt29?=
 =?us-ascii?Q?z86DB9KrnWaRFMvs0f4x7rrbhezvduE1hcpjhD75PiCNlg8n1TY9IVSw79P1?=
 =?us-ascii?Q?ny2RJbV0i/xkZZEr831HdQ50dpd8g3XaP+6hAA7yopthigiqT8wSqiIddf65?=
 =?us-ascii?Q?3Ifb4EiOmAPfMJzEUFJNw3BXnoNfxNzKLIQ1W9lmC43CLP1MuyDkaCp5zWCH?=
 =?us-ascii?Q?eriRpjnLNhJ3yn113ERsQxK3Qxhw+lLuRaHrtrrqPnkiQZLR5bhmNfdzgPER?=
 =?us-ascii?Q?VXyu5PO4TA0gIQ9ImUxtD3XYo2Vb/mj+/Fa6zvaOfQxOQ/s17xZKgsEoueKn?=
 =?us-ascii?Q?aTqRxq9Pw8tKZS+9gG6QexObbrniTSa7qAT+GfAp1XROrHL2Yoe7meuSJ9Yy?=
 =?us-ascii?Q?qmChl72AFvZCOEyYiSndBTBn6W4Cm2us4bX4/QgoB67nU1z1ofeaErw481qi?=
 =?us-ascii?Q?okoYs2aciX3FRSSPwPXZm0hoz2NACKLa55qCDDevYQfCR4YzRUA9A15uWc3Z?=
 =?us-ascii?Q?hSrRc8JUD0W7jrONGXZWqMFLPAPuK9uXygiQ10iQp2anweW5MQwYWU6vghGe?=
 =?us-ascii?Q?Ma4+lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa0da94-0087-4a8f-a6ad-08db6b479700
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 13:19:02.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dpjrc3LHmOg7HnDk3TEuHPzDzp9GIHZe+U7jWOxq3WTcbyGHS+Kz0ppDtqHhekZpdGDc6aZ6BLf3peN6fLXJZ6Ic/LHjBGfgTovdY8dY/ptwIYzjzMCtdgTQgvPYWWJt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Friday, June 9, 2023 7:54 PM
<snip>
> > > > static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > > {
> > > >         struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > > >         int i;
> > > >
> > > >         rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > >
> > > >         /*
> > > >          * Require direct speed change here. Otherwise RDLH_LINK_UP=
 of
> > > >          * PCIEINTSTS0 which is this controller specific register m=
ay not
> > > >          * be set.
> > > >          */
> > >
> > > >         if (rcar->needs_speed_change) {
> > >
> > > Seeing this is specified for the root port only what about
> > > replacing the statement with just test whether the rcar_gen4_pcie.mod=
e =3D=3D
> > > DW_PCIE_RC_TYPE? Thus you'll be ablt to drop the needs_speed_change f=
ield.
> >
> > Thank you for the comment. I'll fix it.
> >
> > > BTW Just curious. Why is the loop below enabled for the Root Port
> > > only? What about the end-point controller? It's the same hardware
> > > after all..
> >
> > This is reused from v16 and then it used "link retraining" which is onl=
y for
> > the Root Port. As you mentioned, it seems endpoint controller is also n=
eeded
> > if we use direct speed change.
> >
> > > >                 for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
> > > >                         rcar_gen4_pcie_speed_change(dw);
> > > >                         msleep(100);
> > > >                         if (rcar_gen4_pcie_check_current_link(dw))
> > > >                                 return 0;
> > > >                 }
> > >
> > > Did you trace how many iterations this loop normally takes?
> >
> > i =3D 0 or 1 (if the max-link-speed is suitable for a connected device.=
)
> >
> > > Is it
> > > constant or varies for the same platform setup and a connected link
> > > partner? Does the number of iterations depend on the target link spee=
d
> > > specified via the "max-link-speed" property?
> >
>=20
> > This is not related to the "max-link-speed". It seems to related to
> > a link partner.
> > 		LinkCap	max-link-speed	loop
> > Device A		4	4		1
> > Device A		4	3		1
> > Device B		3	3		0
>=20
> Great! If so I would have just left a single unconditional
> rcar_gen4_pcie_speed_change() call placed right after the
> rcar_gen4_pcie_ltssm_enable() method with no delays afterwards. These
> methods would have been invoked in the framework of
> dw_pcie_start_link() after which the dw_pcie_wait_for_link() method is
> called with several checks parted with the ~100ms delay. It will make
> sure that at least some link is up with the link state printed to the
> system log. If for some reason the performance degradation happens
> then it will be up to the system administrator to investigate what was
> wrong. Your driver did as much is it could to reach the best link gen.

IIUC, is your suggestion like the following code?
---
	rcar_gen4_pcie_ltssm_enable(rcar, true);
	if (!dw_pcie_wait_for_link(dw)) {
		rcar_gen4_pcie_speed_change(dw);
		return 0;
	}
---

Unfortunately, it doesn't work correctly...
The following code can work correctly. The value of i is still 1 on the dev=
ice A.
What do you think that the following code is acceptable?
---
	rcar_gen4_pcie_ltssm_enable(rcar, true);
	for (i =3D 0; i < SPEED_CHANGE_MAX_RETRIES; i++) {
		msleep(100);
		rcar_gen4_pcie_speed_change(dw);
		if (dw_pcie_link_up(dw)) {
			printk("%s:%d\n", __func__, i);
			return 0;
		}
	}
---

Best regards,
Yoshihiro Shimoda

> -Serge(y)

