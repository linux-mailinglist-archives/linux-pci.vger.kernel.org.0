Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA6446081
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 09:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhKEIVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 04:21:13 -0400
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:38152
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232572AbhKEIVM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 04:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWA1DFjeppPG4UBOYd+FSvtCc/NZGpmp6NLedQTlYMcz4PlzLkS9mVL6QJ3a5GWxtMRcAguI6eAXueYBnNfwgNploVcTrrfOV1rvVvz3gE+2LLlKIV6Bef7jwjXX/oVy5cS2qKAhWEWnLatpMEH3cWNXsgXRKz0rgtm8mBBQ0fbqpJGBNGKcm9Kj0C4Aot4GzUj7BFNsoEc1IsUarO2yGB2tigAQ+QhWGdDMZ8ySVOBP/09Ijvcex4giJYPC1ccvyYB6E0oUb3bXVUIsDDxRCRCuo8dZyQm0YJ6eKYAiKv8On88fRx6bAAd2Fgt0ZVQFvrhVWpDpU6rhBxxl9kXDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPYZjRZDL965O0CQq9qvEmQWNFg9FZQ3w7k+Z1+3COc=;
 b=HQoZWX7R0Y8WwxiYo6JfJY/87PCMppE76OE1Ic5ITKorz6AsgKkzI95427eHN94x9P6l/yZsTcDCY8fflBohDj8EBhW3g/yjaV/R+ixwwaBqTR8yR4AyTm7F2c4EKmm+vIcPeBsgOzVB0z8uz+ABmySqR3l0Dr41c8NunMVfMXH0fcrqM6/pK3OmOSn1jaDj+6iSx5cUs6/C29OGNA4Wf/Jh9sGlxRckZ8+6pa1yi1Kq1eK4nerX8XsrGwxfrCeXnEGAid6s3x7/AXCPlhRwkbH1en9zlg33gGWsmV/mdFqBTiLHk5EF38dspI30wZonxyJ8mYiy3ENhEeVKle5/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPYZjRZDL965O0CQq9qvEmQWNFg9FZQ3w7k+Z1+3COc=;
 b=MMKxOdc02K+jvhKVdBuXfNhAKl9MBzioiae1hulzQ0Zui2w+6jg7HHUVZb3zqklZFk3aohlaWtSdwQnVtLJPbOdpLQ4IwqMVdw1T2pume8SBSzEchjDMtlmS3dd4ge0gN8Qe9EIzlieiRheuYaUjPeAj/v/bL537YteBQbxtQwg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 08:18:31 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 08:18:31 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
 fails
Thread-Topic: [PATCH] PCI: imx6: Allow to probe when dw_pcie_wait_for_link()
 fails
Thread-Index: AQHX0Q86pmFTFD0HQ0+vlkapkYarDKvyiKYAgAAQXwCAAf+aYA==
Date:   Fri, 5 Nov 2021 08:18:31 +0000
Message-ID: <AS8PR04MB86766C25BF33050C342DE47E8C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211104000202.4028036-1-festevam@gmail.com>
 <AS8PR04MB8676C527C11B6E0BCB455E1B8C8D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAOMZO5CHOS9sczwa1ts4e0jaSjxa9CyGG8yCEJUjEj4BUf7Z2w@mail.gmail.com>
In-Reply-To: <CAOMZO5CHOS9sczwa1ts4e0jaSjxa9CyGG8yCEJUjEj4BUf7Z2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c615a211-9740-4345-2899-08d9a034dabd
x-ms-traffictypediagnostic: AS8PR04MB8451:
x-microsoft-antispam-prvs: <AS8PR04MB845108129A4D944CF9E362A88C8E9@AS8PR04MB8451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/1L417/yffJ2+NiUmc0bSkqqZ+mAb1yV6L+rv8EmeGQ4D+BA7HjPWMwGPj2qbsS5+HdhdNMB+tTifJ2+ZVzUvSt/ad59X2Bk5Rgu77i+cRskZKVDuhDmU6iddrW9RmPECep8xK0XUo9HZeXAC9FMvpOVgXM8tdvjKj5Lk5GHCr24UQDnYBlw8IvqbXf7qE2NuCpXKBtOKJKXyEW5gPP91c9wnU6rOoF7wBCWKTu2f6FCRRsGMx6nOVlz2dj9EN6DXaGZFiehaaXYqUi/01oNz9Jeum+eonnU1+66Y8Gox19ITxtuUp0+NNoGCRhDfvdEyRDRI1TaAqI8vZg71TiAw/ANux2l2k04q7T4dj0AULVm15plFZu5nfX7pyb17RzWViZYM73+Ih72nHccnNPGNDc44hEBLi8A3cB8pbX9GQ+6PRgxyJP7PcElBgkFK4AbrzuLZwrfGU1GMfQofkVoYS4zg0kIES+yzdpbPxf4Zh0MfOLFx9PKBNmmnJURXJuf8GCg0Z9SphTqBrFPg5T/T75rHBSw3mRB3aMt3W29y8Kj2j9zcQqan1BqXZ9MPFsKhcxqL3uYPzRMcfCS3/TcjVzmSIX6QWrB3VtW7fYloGSfZD+JI1qr0pG3RXVJb/7xtTshsA67PrUXGDMQDdgBfWXofEj2aM+2DeLAyduYBMsKC43mnDbR3koby+CEzv6rcxr3E8KkJXvQ6Aip/ysqySvD+CrEFfayfwCR9L11hGWpQoz1vtU/0dMCXyMZPaN4ughwV8+yjgd6uFbhOgJ8EuvYBD8mpbKXbwZsWFXorI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(7696005)(54906003)(508600001)(38070700005)(45080400002)(83380400001)(4326008)(316002)(55016002)(9686003)(38100700002)(122000001)(52536014)(71200400001)(64756008)(66446008)(66946007)(66556008)(76116006)(66476007)(5660300002)(6506007)(33656002)(53546011)(8936002)(26005)(6916009)(186003)(44832011)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WQ23qXTbUgmON4UfAtNDilCuav+HgS2090dhLfEdYUX8Cf5iyot2X9AUXAR3?=
 =?us-ascii?Q?Vf1yiE1ivxVF3I8EEWriwNI6G4x63jbayP2oiQKOI+hXbOqXp9rv6f/ltRWY?=
 =?us-ascii?Q?BV4UEmDCpnFf9HO/yXx8Kb7AHYPpfQeA2NtDDCAeHuSRGktAfkKNGqyktDs4?=
 =?us-ascii?Q?16nhn5KRV1Elyfs2AI/0xdo1DSmdySolKSwtRT/JUz9Dd5V4fYM0ptmEu/Eg?=
 =?us-ascii?Q?51ddeGeA6vB1YB2fh6Oo6pUxnZDpw8IYjz5jk53WFU8gZlvif5zNUo/a4SW8?=
 =?us-ascii?Q?gptx6hvk3RhBCzk4o5tBwEeQDe4h6JZ9fC/wY0KRb2RELzq87aMAhb5tD2YS?=
 =?us-ascii?Q?8Y6c/ZauMF/NGVvn14xG9abvW+eOKH9Re7NkIvbXr+EqH2bMIs2FsPG7rZk9?=
 =?us-ascii?Q?CbTmMWTyJteJ7upGRCd2KxPsXcBslzOO1vStcha2xOnXoSwn7GXN6q29Jjm4?=
 =?us-ascii?Q?Dbg+Tt7bplPX38tVDUASmuClgxsHDwXIWLFUc4/ntY2aKrlDBnneCvk6Wj7z?=
 =?us-ascii?Q?xSbQeqqMkoDMBpigUFgLOoH5/w4PWpKQ1SgIp8yJ1Ku3FOF1DqisQFaLXNYp?=
 =?us-ascii?Q?rO0Hv4AFuPIHlLcfA8grhyIVJw3GnIgNmDHOHrJGWowlaNJb56UZaMLo0x6X?=
 =?us-ascii?Q?c1u8NyEXRp7lQtyU/WRnJGGfGjJ/bdZLW8KyT8dbo8K2huGctnomfJyuaRav?=
 =?us-ascii?Q?BVT9/Pw9lSrb2Zl/1cU6lUy1ilIXa43V3acus/ALFK0bHEGzcCnjzsIR8zFS?=
 =?us-ascii?Q?A7fihXlm23N/EpK3B7ccDMdS+TI0ECGm3/dE8LLV13CPl26F36ZC4A+iB/b4?=
 =?us-ascii?Q?n5hZ3pBNqsoMreFMApIQIsCmITTAx2G7sA0eLz9coJTQ+rGe8aCwL373hQym?=
 =?us-ascii?Q?+slyEL4Ww1v4QzzoRV1Pv9hoaYotyrwnQZl7QX2Zg7NVA6zX8j492gxLQ4Mq?=
 =?us-ascii?Q?sxnMG9pNSUx/uoCVB50K/xVsOfzKh+DbpzSaALNYEcTaonJ/uLmcfiqXNk7a?=
 =?us-ascii?Q?g9bjlrTP5LF9R4ISl9KsndAAiu1O0/bPA6HSIhmONdhqajvugyoQkDwqIwaH?=
 =?us-ascii?Q?krC4q4wzXmK6q8K4ENdSYy+ZQ9KKO7R3zPW+04sf29bhSz+LKfPCOwYaO8QK?=
 =?us-ascii?Q?wSDjHT3HHHfc/zEPT5WiaAhtdCAAXDDCjqJS08FFWs95zbbuPUxmXkbdqDJj?=
 =?us-ascii?Q?ei9XlVb+9zHhbR77OpJs9FaBcV4R4cv05ioytt++SUhFgtid3NHLlnjnXn1/?=
 =?us-ascii?Q?eP5aZso8/yyS1+NdEzmFeac2EL8mZZUxFJTyKEPumLgQuslE5vu9sAFI6o6y?=
 =?us-ascii?Q?2ZItYIduENrGAPpi/PacI3VAkFvevSx0VsVjIy5d2ZsbgLrwGseVrVsSnhIW?=
 =?us-ascii?Q?0sv8RN0xqFwnj2IaLC3NUqTTUdbMi9KJiNDzRoXeXit02dtTVG0gbkBK8L3c?=
 =?us-ascii?Q?u8LHHF+eevEK5hPTzcjEehuwr6SLUVyFqE7n0tWFsBUDaVnTQLDc98aFNIc1?=
 =?us-ascii?Q?ZyzKqJaYmb+FKxF9YcEVnFXTVxBKxGXtyYjbLmStCXjche5cN5wmaRdJLUuy?=
 =?us-ascii?Q?d3uRAzyf/IlHntgMum4cr6VEp1OkoZDNIeMNyK0etxGedUTOVyQDAB1VmWpg?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c615a211-9740-4345-2899-08d9a034dabd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 08:18:31.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lg/EwncctcHMr9FEceuDblaScIM0YQy2zrfv+0R55dr5K19PXV0encJn72n+fOLIB3onsP52j7RD6LYu3YIpuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Fabio Estevam <festevam@gmail.com>
> Sent: Thursday, November 4, 2021 9:45 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] PCI: imx6: Allow to probe when
> dw_pcie_wait_for_link() fails
>=20
> Hi Richard,
>=20
> On Wed, Nov 3, 2021 at 9:58 PM Hongxing Zhu <hongxing.zhu@nxp.com>
> wrote:
>=20
> > [Richard Zhu] Hi Fabio:
> > First of all, thanks for your help to care this bug.
> > This dump is planned to be fixed in the #5 patch of  '[v4,0/6] PCI:
> > imx6: refine codes and add compliance tests mode support'
> >
> "https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp
> atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F163574
> 7478-25562-1-git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D
> 04%7C01%7Chongxing.zhu%40nxp.com%7Ca96f456b0a004a4da69008d9
> 9f34bb8b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6377
> 15871101762967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;
> sdata=3DbZInvFrlHI8VmWiIS2oxfraSCFAEhWmPG%2BtHLwNHD7A%3D&am
> p;reserved=3D0"
>=20
> Ok, great. Since this patch 5/6 is a bug fix, could you re-order this ser=
ies so
> that the bug fix is the first one in the series?
>=20
> This makes it easier for the backport to stable.
>=20
> Patch 1/6 is just a cleanup and could go further.
[Richard Zhu] Hi Fabio: The #5 patch relies on the changes of #2-4 patches.
And the #1 patch make the changes of #2 easier.
It's better to keep the sequence of the v4 series.

BR
Richard

>=20
> Thanks
