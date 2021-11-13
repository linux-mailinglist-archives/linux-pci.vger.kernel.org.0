Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5867944F1F3
	for <lists+linux-pci@lfdr.de>; Sat, 13 Nov 2021 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKMHIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 02:08:52 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:27974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229553AbhKMHIu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Nov 2021 02:08:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKQO57fFf5ACpuNkdvrSNpZfCNxu8m/tJFcZOcPJXlum6e/8YAEStQNC7X7rUlcO5piYOh5t6B6Exunjq5JdAoYe5dOAA3NRZ2fQKPLgwyfYYomHafYkzD1fvoK1dYENw+mbgyUo+LXpNc8W6ZvWBIpBn3HV3685iSehRBgLBWatxevwlm3e8700/mIDBFlsxa3XI9wwuMDD72C1nVHpR5CHkpLX4L1/+ds+Qis/ynRi5wzYwTw4Js4LlHplsyySzyo6scQXtS31tE9ZNRbsnZU9jrRmaDkSlKHkGjAP4KiHU8B6XiEnkipbs4Yh790eV4IaEH8Qu6JeHUEMKB0yqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEMTb8LxiWDS0MTmdcIlyx2eGZIw/LEihcSk1/piqkI=;
 b=exiQBC6WAUR0sAawniEjxCyO4E/g8Z1bWyI+sC5eAELiCX9KT14YPHgVOQelW0echgOp4gqp6IXC1yj54B46kH21xq6KaMAjJgkK0xpA+2p/ZndM1MY+mrxVOxwDGVNUhUsypiynErW2FxIVSxaYTIC+D+d4ovY8+YRqmkL7IloXjWCqkQMni4IQIy1Itrk+HVPAJPjlxM4ik+4nZweDnSTgFX2kcIuGk+k7eWnVKP+Hr/wC5CIl01wjbiF2mAxRcOif6mhmYvqPx8qZyeoFb6mGU6F3iHA6sSvVglsAP7w0X5dUV8eUcp6SK85SHS4pvFJJ3NeE4tlRDMpjRIKxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEMTb8LxiWDS0MTmdcIlyx2eGZIw/LEihcSk1/piqkI=;
 b=BVQjqPtlqgZNDmoR9RrkDL1c829n7YRLn3a90oXjWatDLdU4Q33l0VhWPe0m9m8I7rX6NZcjKoadI1nPeH4Bu6C6woY6cMIk19VyoO9OVxdXjZlyyyvLh+IVTq2XT5ly0cqtCBk/YmOlNKpFCuHY8an+Im303tecKU0fvBcyCVg=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Sat, 13 Nov
 2021 07:05:56 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%5]) with mapi id 15.20.4690.026; Sat, 13 Nov 2021
 07:05:56 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Sahil Malhotra <sahil.malhotra@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
Thread-Topic: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
Thread-Index: AQHX2BWMXZftU7n3BUyclmJD3bgkI6wBAXKAgAAH3gA=
Date:   Sat, 13 Nov 2021 07:05:55 +0000
Message-ID: <AS8PR04MB89462E6950AAEBCCE28FD6538F969@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
 <20211112223457.10599-12-leoyang.li@nxp.com>
 <DB7PR04MB532234C5ECD4B0F76A5F451F82969@DB7PR04MB5322.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB532234C5ECD4B0F76A5F451F82969@DB7PR04MB5322.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d9f7240-1b60-48bd-8e8b-08d9a67409cd
x-ms-traffictypediagnostic: AS8PR04MB8995:
x-microsoft-antispam-prvs: <AS8PR04MB899592B494A2E9C843BEFA5C8F969@AS8PR04MB8995.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLR9iC9N1J6rhleF6Mfb8Q/vY7iclVCAJSGoZrOxtdirW3d76KzBUD/ixCItM780fPIanZCzLbsPfAX0Tz0ssxlW9KQ4dXMNMcQnJx50Yd/deripMW6Xh6+equ5+qhe99EOZjBybS7SmPVc/gCfduThqOEWCq4Khv5rUhDERJx4F/dEDKcnzc/00IZNG8Y09+5mTVRAJmeulud8tkPpxk5/X9rrxgMvWJTvMYoZpPfl6fg6biUBwrZW3uxnWKmBr7Za5HpHmnqQLdArsw8A04e46I5CFPmRA1K6ly/h3myGYVjo/zSUK4L/3IDzoMLGwDKPufFTvHcjiVXeOizo8KqIv00M3rNBCC0/Bd1thM45WvkEE/VBl2/Mvk8520FGU33cZ0kFX0HgPB0pldRIyn+N8qM0Uhg55Ahm3plh9VQpkRRsvHfsVyI+KHFutJUdYmK4JpRBENg1+RUHdu6+o6BAYsEjNEKM06mri5h8qC0pVa/6lwkx/1ck2UGsVb20PIUY5FFJCtaPFWThMoZ4SJL8nhCfdznlClQyoUtoPG3yXuZNeyTEAyDnkaBCQHR/2UHTJi5XIGmmMNCOPV0vHpySR5q26/VYukbYkjVFSe0y8Su1+NR+OWaN9h7RRL6odOpGME2zX8dNNVAucJXuqssZl93Z+5MxXfG0vKXP6nrPomeD2CFB4TEyqnx/ELWGBCQvUallUQhHsaiTL32d8lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(33656002)(55016002)(26005)(66556008)(83380400001)(38070700005)(76116006)(66476007)(66946007)(64756008)(5660300002)(52536014)(8936002)(38100700002)(122000001)(54906003)(8676002)(508600001)(7696005)(6506007)(53546011)(186003)(86362001)(110136005)(4326008)(2906002)(316002)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5z7fTBTJI9v95Q0uPBuBDyiNzaDlWrTuF1mqkCrSdc/wB91l2orq6qVYnJiU?=
 =?us-ascii?Q?netUAU9OPMtkKJEd/G/B69/y+oOwSz0LKfkT0NAS4XZCs/1LCJjKBHs6IzBX?=
 =?us-ascii?Q?t1JRKvyc5LQ80Q01mVSccoas22UrdlZd+ckvU7tjKvjy1KJzz4oRJ5Hfstin?=
 =?us-ascii?Q?R3ien9fb94vmj4xdJZYCQ3b3aBGqOaynbLEMauUIt1tOKRYTlMtngxUbc3in?=
 =?us-ascii?Q?2/7WV7L7jcprVeQiQG97NGnlC/mWLLm5YqLJIsf0z0C57TZKOf0vds8ZbjFP?=
 =?us-ascii?Q?NeVAGpNwKdf80lOM6ojXH9+85AlXlXxTwYIQyia50iRSG8EhnfdA6lE1pOW7?=
 =?us-ascii?Q?qr92UmEFlebcJskhK2vcbdFqpu4b0sHSG1u9GgUFvU6cOYhMklPS25YRME6i?=
 =?us-ascii?Q?/hGJG6v2l76dE16ESNxFiYqoxeGy7Y5th4i2kz9my1Q05Eu8O18/CVAPaCPi?=
 =?us-ascii?Q?RCyjEX+Pig3zzdCDie58ClO0SmTg5qELsKCW9fKXPDYhjvLgX+N3I/dA/vo+?=
 =?us-ascii?Q?yfYMWHAOQeVUgqu9tTiWR9Yy2L5h9Qf+HPrcRJmbrYeFYG2MG27YMATbAEOS?=
 =?us-ascii?Q?zJz29rtmhzy95hII5WvBJo07XAX1PbDPty7ozhULB9DTJyBvsTlIPT6FfoLq?=
 =?us-ascii?Q?kmv7OSZ1r2bgwqOoSky9B3U1pt4Byp++Tg6eJOwf+wRVuOA2miU2FmTGzVPy?=
 =?us-ascii?Q?0Aqlt9U5b+Ra82lfVkLw1ZImX9JNmCSSEMQVYdPwpQTi6Yfmv7KzBcrc2gQk?=
 =?us-ascii?Q?PbqBOQcmkBDchIecXHS1dFvcbhg06cAzHN2kPbG4A2LfLLPHw2Dkb190Bohh?=
 =?us-ascii?Q?kjEVpqXkDcvAOmz3tbsi6KLuAlsj+zGc2htagauiWKBBdGjCIu3tVNKbkwwC?=
 =?us-ascii?Q?qlWKeTMk7Er500Mk+5pQRBHWL/W/Ak36OBD4sZEsh7kSE4mCwwX+wBzJfSIO?=
 =?us-ascii?Q?xlU5aXGV6VnHt2ftY+a5F5kNhIq5244K4oBRoinBNQRdn4LrTtdAUt/mJ5Um?=
 =?us-ascii?Q?TxVj8Z6kjLbQ+chREDpLOIVsxthsdTo57zy+gFk5bA8kSUDzenXOJVDWcuMA?=
 =?us-ascii?Q?NRMe6hCvZQ6mtlmJKMy1T+hvL32gsjgNc/LbkKyhmK2DSuT+et1J2rzJZn5q?=
 =?us-ascii?Q?wwAZOfBAQKXwvB82dMhRzvs37hZcYlyb83B/6NuJCsU3FDiV++z09V0LU4hZ?=
 =?us-ascii?Q?ZNv94Xhj8kKsTkKD2nXT1od3vvnpTE1ru1/3Vcsv3JJFfaJMt1Nz4wETaLk9?=
 =?us-ascii?Q?Yu6As3MRsgFhaJ662Fh7AlyyzSR2qnTb5PtIBM7IZAB+PJ0EA0hoMGaeiF7h?=
 =?us-ascii?Q?ccj3RCMvTjazL6m8p0WTfxyAiYMBaXoXaOOe0epWgjhp2J3V/E5VIetHRHqG?=
 =?us-ascii?Q?EfgJmNlQXjblkxt7gULmiCcwiJfh5XzJgyRcEVidcQClNv33XGlTSZL3iA2c?=
 =?us-ascii?Q?yObDQcKGFMarENyIcomHohhngBgpOTuZLO1fAcTi8hOhrHgRHXoWjLHR3ez2?=
 =?us-ascii?Q?EMrT32ukUuFIiV4QuU6jpA2HM1qutuHekQQpnXFu60BhYU8GO40PtyS3185Z?=
 =?us-ascii?Q?bdbhunATbdsxTm9rfmqxOeJWsyRc3Z6qthbtHSusZaxcIvcbsief0Hj1KXu+?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9f7240-1b60-48bd-8e8b-08d9a67409cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2021 07:05:55.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0J4UOxUOhOxw7pvUow4fHLOAQc73NpcPSlextKqvR68sYvKJwFEmylTQkJzM9i6OXYHpzRuP6AFAB0Gie0ajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Sahil Malhotra <sahil.malhotra@nxp.com>
> Sent: Saturday, November 13, 2021 12:37 AM
> To: Leo Li <leoyang.li@nxp.com>; Bjorn Helgaas <bhelgaas@google.com>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Leo Li
> <leoyang.li@nxp.com>
> Subject: RE: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
>=20
> Hi Leo,
>=20
> We support OP-TEE on LS1028A-RDB only as of now.
> LS1028A-QDS doesn't support OP-TEE.

I thought it was supported as you were adding the o-tee node to the soc dts=
i.

We will drop this patch then.

Regards,
Leo
>=20
> Regards,
> Sahil Malhotra
>=20
> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Saturday, November 13, 2021 4:05 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; Rob Herring
> <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sahil
> Malhotra <sahil.malhotra@nxp.com>; Leo Li <leoyang.li@nxp.com>
> Subject: [PATCH 11/11] arm64: dts: ls1028a-qds: enable optee node
>=20
> From: Sahil Malhotra <sahil.malhotra@nxp.com>
>=20
> Optee node is disabled in SoC dtsi.  We are enabling it on qds board.
>=20
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 0e2cc610d138..9c74be22d263 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -349,6 +349,10 @@ &mscc_felix_port4 {
>  	status =3D "okay";
>  };
>=20
> +&optee {
> +	status =3D "okay";
> +};
> +
>  &sai1 {
>  	status =3D "okay";
>  };
> --
> 2.25.1

