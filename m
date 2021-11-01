Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A154411DF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 02:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhKABtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 21:49:18 -0400
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:44001
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230133AbhKABtO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 21:49:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyOd+hMDn6jVsy1K/Hdqvu77xnOFOXxFNXj7uTZRxxWAeS49RpIW7buUednLa3S+2Cr6yKm7r2f1e15/4NDqtK6mnRw6W24R1HsZgoDUFJzh1tOeASUQqpFfhP2nSDw5JPA0CkciTOG7LeFSuCqbmRjlBqbdgRsYMwVfIkCVm+UzMM+d/Bmv1guodHl8jQMyqrugw8fuTDoxtuTc/szXabi2e45UDQXWjWJSJlXdXad8uv5HpANtuwX2YcnRpiZ5nsYIovJAf54+j0Ae5VVI/tj6yp38pxTQQhIV6kTstwpOnghdJW0M2ci+WbbQikgkVGVmUjYVbdXA0mqb3U1X0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7f3TU1fd7TQEy+/gDO5PHybi5gH/wdJ0IyvuqPEU5Q=;
 b=KAyEEycljde8giyrlBW8PRM2y/A4TQWaoMqU8oqR4k1N9clvtA78cR6e5JvtXED0TaGRtN4372q7cOVXKSHEmzuRyEDGzOAHlpC50dmJFzEvTZd1yi/+HSEyT78EoOrcK0At6cajf7KTaAgLXYl4U2tGdGO3ilalg4/gXts4iM1Z+7wDqHuLyQx/0EQw77wS50hE/mzL2Yfx5H7y+9ogJYTskj+0HSr61Mm8o+mfuMoySs+e1Ag3baJnrJPG8/6CrgLPLC7zpg1mEDU91AT7FDB2LyMta/o9OBPZoH/zHNKMgvbcmSRC25y7r+ZSdzIRK/38Zjqy9jZFLD7Bd9haGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7f3TU1fd7TQEy+/gDO5PHybi5gH/wdJ0IyvuqPEU5Q=;
 b=mhdnlvN1XBg0ukU0aqLHx7R6wADPlllGlOS24a2Nh+rY32SbkGSChz0/2J2Va6xfaF5zgEHLTenigs+YyQE+dRwBFN8kbpm5/cy7aeN377SmSUKVRfw+YthCvAVFZhCx1yrF0qur3XjtIBLWcobRsq6kwkel/tizf0DVuT9uJqg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Mon, 1 Nov
 2021 01:46:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 01:46:35 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAIAAlv4AgAFuIxCAAcUHAIAA/dUAgACTWACABA5hcA==
Date:   Mon, 1 Nov 2021 01:46:35 +0000
Message-ID: <AS8PR04MB86761F6DD5395282A472CFBC8C8A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXffRmvPYwetsg3L@sirena.org.uk>
 <AS8PR04MB8676AF8685A951E19B1CE0688C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXqOcAIO2aYkr1sM@sirena.org.uk>
 <AS8PR04MB8676CF52F4D8E9E4E6C07F758C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXve+HlpEWOzZ+k3@sirena.org.uk>
In-Reply-To: <YXve+HlpEWOzZ+k3@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc11d0b8-2162-4ada-be30-08d99cd9701b
x-ms-traffictypediagnostic: AS8PR04MB9208:
x-microsoft-antispam-prvs: <AS8PR04MB92086ABB0C0B12BB225D33968C8A9@AS8PR04MB9208.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiq0ftANNWPIYzv1A4gsWT+BbFARMWNfs7nkYwiDRe/moXkHQiR+AzWUikBasVTw3PcmG6OQ6+oYR+a/xJ5VK1zi6ZI9TkpuFS1kjSb6TT85VcmKqqMjxAhVrp8/16KoGzu4RigUNG5GMERG/DUMTFmXfeIZ+YoSSCKTDbkjigjAhTyleQrlSERwNs9RsJKovw5ZCAQMy9k2o15RhXiYlx9oXd0gTxDasL76OgL6WZmrwZdZZvBHwrw758naUIwvvLwa/cZM5eqEEHL1i89ZrN5JJLYPkDEXf33SlS1wu91NKiZY3UdmvUy0aUFVxaxuU0ozLYNJRl1aGkhREqlDIlcEdtG2dEkkefrvSQdwdUdgnpDr4ZlX9MVknozeP/rB4oMMLIXTOX6uM76EJC3Iy2F1g3Dmj6bZ9Vcl6uQaEr9utjwUneXIVHYkLOXIOpckgfUcWM0mY+Ql1sK7FCJP4DDu/3u38H3b1zEpdBoSVtO+YZ27r6lT3eU3H/6DhxbLmpJQlqifz00RQG6twXAYVl30Ylt90tPyIosSCiEROijNbrA/aPMN/Yi+A2zQ0lMBWaoa7N/JwafdtR5952Ikj9jdo73tYKHCnDs9a0DvKfTy5QQxCnpTEWRHeiuLV3JxMNN7sW5HKlppu2DwlxGPhCIH+aqIGwdk+vzcG8nHI/Xq973M1EH/5lKsiwOXKmnRKShmdD71D7HiCU4nnrN5ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(8676002)(186003)(83380400001)(55016002)(6916009)(4326008)(52536014)(64756008)(5660300002)(66446008)(316002)(66946007)(9686003)(66476007)(26005)(33656002)(54906003)(7696005)(122000001)(76116006)(7416002)(6506007)(66556008)(71200400001)(2906002)(38100700002)(38070700005)(8936002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NqV6nzBg9/2UQ/ZwzMgQcXEI92r0sY3v0E515GT0tgQDp7asgqlUPb9FtK9X?=
 =?us-ascii?Q?6KMZnrliWv9UxRQiytDXHTNIJ4R9nopk2U7Zitq8nVOdJBLwWht42RqCe++i?=
 =?us-ascii?Q?ybeuxOpn9jYVdJTpZ6YrXHFXnHzUpCrERoymnLCUBD6IYuGkM0kkjmMBQl2p?=
 =?us-ascii?Q?POS64ySsiEhLNR0qOgeRuC3XkLNsYeZTX7AMvPRKRb3gH8JihnlTBcteVcDY?=
 =?us-ascii?Q?gcN4Ze2oO2jdRADlfXz3AwDD3vTB3LdhDGvGDOIAkYXNPrQIhmBD0TmRaCQf?=
 =?us-ascii?Q?xez73y8IM3QAyDVLBD5e9yuRtmkcqBoo8EbYVPpNbl1T0iONhBzmNeYagZI7?=
 =?us-ascii?Q?mf1B9q85MhqgdazDX5rr53goU9l4f21ysGYi3WovX5Wnfz9+taHmV+110osz?=
 =?us-ascii?Q?ux0xkfvk2sIEFOXr91YLeYcAhhlW2hhCzy3lIg36t1OCD+oEG4BtvLcLjTzD?=
 =?us-ascii?Q?XxuiVIq5wxRNIoV7gasVdVTGt5l7svnOplgwJqzLrSWu4V7+nCUxm2o6hKHc?=
 =?us-ascii?Q?NvW6N59Td61lY6JcFjV8Kso3N066cqZm1YkhZ5t6YcXa+rwM4bPLVLYqyAkn?=
 =?us-ascii?Q?2iVLl8iPRxB/L+/yYF9bL7efV0a4/JmqteGHH9FRxjLegBSljzU9QEPPe0GG?=
 =?us-ascii?Q?xfLZ+vx+GsZDwZdh3yzKnACLFaljOm3hg9SchaHxKowbUUfpoEau3IaO1/lB?=
 =?us-ascii?Q?Lkkb9DBqjfMdTlHEDhBs9DiH7DryZ5sd9sjb8ZVjiJDPyXvPpqEhjSP/VadI?=
 =?us-ascii?Q?/nYKNah2q3yHX/yA7/Y9zerYhpW1fFuc9eGB1zN5p9BQwhu00Q9/ZBzVS9cs?=
 =?us-ascii?Q?8YzhnPYMBm/U70uy48n7y3whVUSzYvB3pqhJBKgZqBSRGSrqG6a38GKbAOfF?=
 =?us-ascii?Q?X/ZHiA2UYn1TdgltIXnuorzU9MrSGeXIJSGVHMESuGpdjnrx5UODY/PlzqAP?=
 =?us-ascii?Q?SAY+GHUeAQkRsxFRnUeqNpbkhUUIKcDgtYNcqCHKHz/ATCKUSinVP01ileIW?=
 =?us-ascii?Q?QeOhtTEwprl5SOmgx0T3//zW/SF8SELbKkpORPuvmG7NKxkU8oyqZ3PQApk6?=
 =?us-ascii?Q?hCMHcSLhb29vJl//HGqvolMPT8l+08KSGKTbUZ8qto8PnPq8wwDxAce6nkOl?=
 =?us-ascii?Q?OUYky9BdLGrpaknJWU4n9FbpmN3hx3yAsTzBZiLzzqNjIPtAWTlXroXeUyKC?=
 =?us-ascii?Q?B6hFEKw55qMP5tUCn4Gcmau360oXLVKUALdUSufIt47DX412RMXj8MS352c3?=
 =?us-ascii?Q?cJ49gO5BAgowYNhZBjoumIxD2AmGMVCYRmdrpBzmmHwni7NBLbbTTMDNZGEl?=
 =?us-ascii?Q?WKtRMtSEVMMFhOBooOWPVY1k3IcoGmnTxkPXoAQbEn+q89vnWMXma9jf2iMq?=
 =?us-ascii?Q?5CuMJMXJ9zTq2Jxy/nVgYtW2pq/xypUeImxEIiD6OfGgtoiqKsgFqWy0sdbK?=
 =?us-ascii?Q?tb59Kely9vfEKzqDyfPT+/YpZuuIRk6M+lhQ1gixsL+PawjRCulCrE4LcXyv?=
 =?us-ascii?Q?M7L3/KoIhxbZB3B+fs3dPn01eS/7ZM8VAe8xlvnjFUg9+vrWLXen5OjpCQXr?=
 =?us-ascii?Q?q2YgCvfCdg4s/3CViPByAT0IwqU4+H6OmReATitaG0jFbC5l0Pv0EogyBjXb?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc11d0b8-2162-4ada-be30-08d99cd9701b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 01:46:35.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCVUyfZc7qKtOOm4IqilSZrCopH8ugS/LeArIL5aV2qvggAonBekGLo2hbpfW8aUVmQFKxhUTsoOF4ohtEZKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, October 29, 2021 7:46 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>;
> l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link
> never came up
>=20
> On Fri, Oct 29, 2021 at 03:58:41AM +0000, Richard Zhu wrote:
>=20
> > > The driver should undo any enables it did itself, it should not undo
> > > any enables that anything else did which means it should never be
> > > basing decisions on regulator_is_enabled().  While the regulator may
> > > not be shared in the particular board you're looking at it may be
> > > shared in other systems.
>=20
> > [Richard Zhu] Understood. Thanks.
> > Can I disabled this regulator in PCIe probe failure handler without
> > the
> >  regulator_is_enabled() check?
>=20
> If the driver called regulator_enable() (and that didn't return an
> error) it can always call regulator_disable() as many times as it called
> regulator_enable(), no need to check if the regulator is still enabled.
> When the driver hasn't successfully called regulator_enable() it shouldn'=
t
> call regulator_disable() even if the regualtor is enabled.
> This means that after your driver has enabled the regulator it can just
> disable it but between the regulator_get() and regulator_enable() it
> shouldn't do that.
[Richard Zhu] Got that, thanks a lot.
BR
Richard
