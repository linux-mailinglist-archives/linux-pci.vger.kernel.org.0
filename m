Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8334C432470
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhJRRMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 13:12:44 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:9945
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232587AbhJRRMj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 13:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh3R1KsSEtNfJ/1DA61dXQDsR/HRWw4F42bdeH89D4L3GSous/d6kcgFWOnrmCfYpM3IitWZPqtjTWX0Fq11hHm2jkf3x3av1dij9MnTuYM/jNUi47p6a5DTcFhwUYMIOjAI20HftaisJ/XuR9nwMcR+XBt2ftT/HTb4uEaLlmX64CZLZa6LVIjZKfAQq9yvYFxS6HZV+Y+dl40tz+edLFD2qGHtz/wk6k8/mZ/XY8k/c5ERHOcABIMG3IzbzCAQSlXGeaOsW2y8vqabMy3AcyPTZZW2O+cAkUzRbPaTuUsA1HpkxN5q0iZXCk2F7H4BjQmXLhuNi282+bYdnlq84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdjbhIo7ltaZxFUhrGvNal0xJXd148Or/oLPNq3n2Co=;
 b=USAgsevYokR09WGLbyFNGQ7/sULasqBbmVelKFSpiysm7EY9VKJW+XVCgvR4I1NWz3zi72NIeaRHHMGpPapx1mdsg5Ww9wZYtNK7s0t5ls6vY/OFMzdcbQnxGedACH9LTrJAVJUKAGQc6oFWwSVHYS6yTGN3N4o4q4D7VX3w9m9HC1kmkBgFy3eBgxjKoZZqacHns8XCzz4/Ko2S58/Ljj3w8pCSz4gSSW0PedJnD7TVnhnz8wI8bC42lxMGdPPz2FUI8fXlLqUhV1EvjtiTfdcDDqAWYeuzwuSjB/OYe+cpUcagPUwLgvn/Y5OR1eT3oXPlCET6snnJ9CcLb59RXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdjbhIo7ltaZxFUhrGvNal0xJXd148Or/oLPNq3n2Co=;
 b=K7hDsaXVLEphvb6AABVxAEjk+XeVeWsxR9RZI3irG7lIrktSHox2lu94kEt9FiciU7AJsrazraU2QgXStXzPIP8EnBCBoyFI/U7MhEBK7MXmI2KE7TN+mRtGndJDw0T+c2FFBNC/b7HjREy5XtQUIDqTdr6iB64eW9ST4uFp5Ow=
Received: from AS8PR04MB8500.eurprd04.prod.outlook.com (2603:10a6:20b:343::14)
 by AS8PR04MB8962.eurprd04.prod.outlook.com (2603:10a6:20b:42d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 17:10:26 +0000
Received: from AS8PR04MB8500.eurprd04.prod.outlook.com
 ([fe80::cc48:f7ea:188c:682e]) by AS8PR04MB8500.eurprd04.prod.outlook.com
 ([fe80::cc48:f7ea:188c:682e%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 17:10:26 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "kw@linux.com" <kw@linux.com>, Sherry Sun <sherry.sun@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXT] Re: Linux PCIe EP NTB function
Thread-Topic: [EXT] Re: Linux PCIe EP NTB function
Thread-Index: AdfBOZgtLzEoMbYXS6Ol7OT0aw0WZQAAdtXgAKbosoAAGp6WMA==
Date:   Mon, 18 Oct 2021 17:10:26 +0000
Message-ID: <AS8PR04MB850020CCA53E0BA2378CCC5588BC9@AS8PR04MB8500.eurprd04.prod.outlook.com>
References: <AS8PR04MB850055DFB524C99D64560B6188B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
 <AS8PR04MB85008E09EAE36DFD6A51F4B588B89@AS8PR04MB8500.eurprd04.prod.outlook.com>
 <459745d1-9fe7-e792-3532-33ee9552bc4d@ti.com>
In-Reply-To: <459745d1-9fe7-e792-3532-33ee9552bc4d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05815b4e-00e9-4c32-7c2c-08d9925a2dd2
x-ms-traffictypediagnostic: AS8PR04MB8962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB89626D83FF9C82EE1E640B4C88BC9@AS8PR04MB8962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Jw9dC/wxslwy5Wvpif8n2MeSkC1TDi0Qd0bR4r1OYbRTc3LXYvxhXmP4ZAZncTWGKFaYvAF7M8i4TPN6DaQC3dHztY2xUFqWzUnSFW9syhJdZ56tg1JnE/T5Ug/75kLO83unkOFXJ2OnXCEw6ZepgC9sYJtEXmd6Mj0SvtnnBZcmrO8L65Z/mfwxES3a8iCZNT9CUlOJaI9aCxrspX4hpPlv7t75hzCrcgzFgCkszVvREOZJ37El9lDs2Q3CuFLEbw9/SWPvPvds1hDo3h3bNuK3daCQrgffSVI+PqBTfefZyoUXe2RAXxitnTXlfbKdMrU9LTg93+dDf8dQHHhZBL7gbJUy/3mQuTjh7dbDr9rdLU3SveKzQYP1S+OriGnRJfpPAKMQKOnQ2bxO+WqlmsEIjcjuRIZlBacMeo+Bu73kAngr3mWJqP8TlVHsvwI4oZ4GOYU8QobVtidhR+oQ1br4eKy8NSd0JtSiL69dyG9WgRYWMhHjgsbMh5pNJom2vuIKOvwsyUs9LueeNnX814y/F16ESlNq9QSph2V27jVM7M8hvwgZdWSwld4u2uec4bQFNR6qDLO3tinqVPd86K0BMgC28oNvJoYg7fgfr+KULt8xChM+i3VQTYkNF1vSjnvMUxWfRT1ZCf42qfOT1nVTEZiGTAjglZ/02zdE8CZzcTtsKhyfVj+/PwD6XrZVyVm8ZgswX9QhW6/npc+4bwEW6gQR36VTK7WZqFN8q5oTgs4xaz/LNq+FmnE6kdyIQzTmZ3O2/ftI22tKqEpFjmP+oDWIkZ4DYJx8ZB17Ew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(110136005)(38100700002)(6506007)(186003)(6636002)(9686003)(26005)(52536014)(122000001)(8676002)(44832011)(7696005)(86362001)(508600001)(4326008)(66946007)(66446008)(45080400002)(33656002)(66556008)(66476007)(64756008)(53546011)(8936002)(55016002)(76116006)(966005)(71200400001)(38070700005)(316002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TAe8LaOz2HLsJbVEBMJ0pv9f2ljbIuIei1rakndKf9wt8UkWdc8bikNDa7Zo?=
 =?us-ascii?Q?YJhlUTnzAiGC34oHZm7H40e3j81wcQAUCBtYwpF9NY1RyNx8gLCqEFLvodza?=
 =?us-ascii?Q?Q1+2VSUEJWThLdbAte9xFNilfo7WCZMrtI7rYj9G7e2iC8vWVeUluP3XgPUL?=
 =?us-ascii?Q?fzC4YpXGqxgftHwJMFwfpNbuROg2qntO2vXQe1M7LoMqPOSbaKPPm0Py00pl?=
 =?us-ascii?Q?JnQYf1Y95yjiYRzbPJvSHdZ5/ymTidadykMw7x5ItN9NObn1/U4K7j80SKhZ?=
 =?us-ascii?Q?/4VcgyrAWTA/v26Sj1qzpDHkc1dRqcMJ/LzFbO7E3WXWXjrDhzcthLkK7zxO?=
 =?us-ascii?Q?0GlTY5Az0fnFqJ3s4dYUp634pJpycmtpqNLPKqbBX5wGTcbLp+/xDw0VWIqj?=
 =?us-ascii?Q?JKwsuUtwRVIdzb4/bVT6bOFoTfyJJUE0y4S3bhgBwUa+AtbvTGgoIQtyMDuO?=
 =?us-ascii?Q?/HgXYaZfHIr24Sw2YuJSwHKF1Qx+TN8s0lGpCPcNuPPY6X/IE2cCis8K1wHX?=
 =?us-ascii?Q?z0z8NowOe+JYH23DNsWpe09TssjXmI3uS2/rApFj2BCDB8kesFYalAQkQDAH?=
 =?us-ascii?Q?0O/FD9zSl4dq4tew1649aKBXrxVzU8ti8KNmWeKv8a95Z9GyDXJ7KnmNhUHM?=
 =?us-ascii?Q?c3J1g1dCrUZXzEwrywYTpxU5HOouCpNLKmmpkeIPrQIP89T+ffWA/+eFDMUX?=
 =?us-ascii?Q?JZXoEndBhNIyFGNOgZkC4NHGshzZ2eXp6v1MI76KWrpsojV5M9ei6hkeEavj?=
 =?us-ascii?Q?ST5wUGZrQX7SqE/yQGtNvkZ65kr8FOdGLZ0MrPFIq9rQ/EZaSI7++ri0pvx+?=
 =?us-ascii?Q?b6Snt0ccMu5ur00jKabhwVDlpo8olgZiZNlvf+ZUxJbJhT7v4RjPME2LQnak?=
 =?us-ascii?Q?ueqIfofutBHoiZqk2tY8i+P3WeUxt7YpRHwiyZhOJJQFdA4AbIvo4b2YQWEr?=
 =?us-ascii?Q?rSuyuYdVtRUzpBuNRyaR2tbcz+kGXLABD8NMgcI6UiSDIfctwXE6MBFr0DRi?=
 =?us-ascii?Q?SPnfA8fipFKjZYqiTVHITDJynLjumM4nJCYKpWgwgSS97f0tw2sEGzP3AHOf?=
 =?us-ascii?Q?hR5xZbM8M5KZIWsZUkP4SVKygQ/+oTA3/zRGPtOF1IyTS7QTygKt1N+fH8rT?=
 =?us-ascii?Q?NgBKPmpRFnLDhh/QrDqQS6kZCnH1z7/Ht3xhGQkHFvi1+nmkh7CoShhrn2LJ?=
 =?us-ascii?Q?Wdc+kbHwvYdVZZuzh3DpfER48LUmffLkotGXXpCof37SQlp+3XGUrHRW5cJP?=
 =?us-ascii?Q?w1ZFrxFKib9Ga47Mn2Wc+QRUpxJT3a/wcKcZZ1RKE4JOaJW8ciM1jppjsAtD?=
 =?us-ascii?Q?f+CINABwZCjSXpknG2VVzzs8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05815b4e-00e9-4c32-7c2c-08d9925a2dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 17:10:26.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmUxe9n9A+KZ2ZmmIUtLKPvHZ9FbDqcpEmxzbV8Rj1yxrcbjyPmERj4mAxz+eNUzR8qtX6ql47XH3XqRwi6CNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8962
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Sunday, October 17, 2021 11:18 PM
> To: Frank Li <frank.li@nxp.com>; kw@linux.com; Sherry Sun
> <sherry.sun@nxp.com>; Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-pci@vger.kernel.org
> Subject: [EXT] Re: Linux PCIe EP NTB function
>=20
> Caution: EXT Email
>=20
> Hi Frank,
>=20
> On 15/10/21 2:10 am, Frank Li wrote:
> > Sorry, correct Linux-pci mail list address.
> >
> >> -----Original Message-----
> >> From: Frank Li
> >> Sent: Thursday, October 14, 2021 3:35 PM
> >> To: kishon@ti.com; kw@linux.com; Sherry Sun <sherry.sun@nxp.com>;
> Richard
> >> Zhu <hongxing.zhu@nxp.com>
> >> Cc: inux-pci@vger.kernel.org
> >> Subject: Linux PCIe EP NTB function
> >>
> >> Kishon:
> >>
> >>      We use VOP(virtio over PCIe) communication between PCI RC and EP
> side.
> >> But VOP already removed and switch into NTB solution.
> >>      I saw you submit patch and already accepted by community about pc=
i-
> >> epf-ntb.
> >>
> >>      According to document, whole system work as Device1 (PCI host) ->
> EP1
> >> -> EP2 -> Device2(PCI host).
> >>      But our user case is Device 1(RC Host) ->  Device 2(EP).
> >>
> >>      I am not sure how to apply ntb frame work into this user case.
>=20
> NTB by definition is PCIe RC-to-RC communication. For RC-to-EP, see
> pci_endpoint_test.c (RC) and pci-epf-test.c (EP) that provides sample
> endpoint
> usecase.
>=20
> One more RC<->EP communication model was built in [1], but that is not ye=
t
> upstreamed.

Thank you very much. We already can run pci_endpoint_test, which
is too basic and just proof data can transfer between RC and EP.

We want to hook into standard interface such as net. I also find below patc=
hes by
Google. The patch set was sent out last years. What's reason why not contin=
ues such
Work. I just saw NTB solution is acceptable by community.

Previously we were working on VOP solution, kernel dropped VOP just when we=
 prepare upstream
our work. We don't want to these happen again. So I want to check RC-EP com=
munication direction.

So we can work at the same directions.  =20

Best regards
Frank Li

>=20
> [1] ->
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Fr%2F20200702082143.25259-1-
> kishon%40ti.com&amp;data=3D04%7C01%7Cfrank.li%40nxp.com%7C09c9aaaba663411=
c1bd
> a08d991ee3cd4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63770127468220=
16
> 79%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik=
1h
> aWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DkJkAPZHywJfv9gwj5MhI9BUAG2veDyouMcB=
H%2B
> rx8xWY%3D&amp;reserved=3D0
>=20
> Thanks,
> Kishon
>=20
> >>
> >>      I think we can modify pci-epf-ntb to register a ntb devices. But =
I
> am
> >> not sure that this is recommunicate method.  I think this user case is
> >> quite common. I don't want to implement a local solution.
> >>
> >>      Any suggestion?
> >>
> >>
> >> Best regards
> >> Frank Li
