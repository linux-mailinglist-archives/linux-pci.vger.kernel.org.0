Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4F434165
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 00:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJSWc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 18:32:58 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:64096
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229723AbhJSWcz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 18:32:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeVyNSabmNKM1VPtLlnGnXAEaee0bv00nYYCGkB/gOo5UoD3hvfs0kHV0W3CMCgbYbQjZCgqVFFQa9dAuuGk/VtiHepBAe32CahtVqnTRjvrMC4jayd3mTfq89kfIqtSL2rt2WV2Cv9+XpLorQUioW+UO4A57vpD8OsqC8TjR2xflEmlGNX/1bT4RE991rwOOv+vClk1crLXVkeW0Bz4FYgQNB0ZMkjPjzyEiFobfmlJN8Hmph0JsUYfqrHayk699EKB5AQm6c7l6XMgBw00uuLovJZXiheBMg/gHUJUPFlxUGwgw0m+67hPHvt/Lvga+iD8ixQ+BDqyqqBl9fUVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa6Ydt9UIcm/jEdBh1XuEN4w+r7B9tSLMFENyy+3rHE=;
 b=fboMeZShVdgyFTQ+GUWqmasWTjDIWU+KNjK5EGgzZg9LnfkEeENIKihGWuD11lOeh/sX8J8nM30QA1eewxpSgZjmMsr45K33bGTINcvDckerTAaWrfVZ2J4a4Dok6CDF9ZBa+u0G2xMmnxpKVzz1V3YPxamhMFHfNx2JUkaQ1ZQWCJpMLTqUnuGivj6Wft28gZNtovJ0ThSnkoovhMQjRx6xcNO1iAA9VwABuxjjx+RdNHrFJOjNuESJ/0PUf9KmgXtNJPo3jhPdQ7P0Dbj+4r1cVYWyOCkP5TcebSFtuHxErYsBbkydPA8cfeXR0fgfbbDhx+gBI/BtP9XxGG2fnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa6Ydt9UIcm/jEdBh1XuEN4w+r7B9tSLMFENyy+3rHE=;
 b=UsNaGA5zwfjtNSWAhfW7J9hTBbQWyxmpvtDz4TE2NwIHWSuzkQcEjf+0H1tj590j1yoK6KhgE/2aDU0BLQEanACgKthX9nkFXgGKdsECaS5Hxvh5B0OLgMRQ9VLAliWSvhc1omEpDwvXaT8t3fNatFxsOqTEGcSNFqKNrDKbKvg=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB9063.eurprd04.prod.outlook.com (2603:10a6:20b:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 19 Oct
 2021 22:30:39 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%5]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 22:30:39 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH 1/2] arm64: dts: Add PCIe endpoint mode DT node for
 ls1012a
Thread-Topic: [PATCH 1/2] arm64: dts: Add PCIe endpoint mode DT node for
 ls1012a
Thread-Index: AQHXxNsH2qPMictuQUW7K4wCT2T8u6va5rvQ
Date:   Tue, 19 Oct 2021 22:30:39 +0000
Message-ID: <AS8PR04MB8946F2F300CD848DF1C29F658FBD9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211019111750.28631-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20211019111750.28631-1-Zhiqiang.Hou@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8062756-c5d9-4b08-94a7-08d99350143d
x-ms-traffictypediagnostic: AS8PR04MB9063:
x-microsoft-antispam-prvs: <AS8PR04MB90636323F08BAA9D89D58E398FBD9@AS8PR04MB9063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 788yLT56g3L9yhqGGRlQonaupgDikh9k3A4FzywivUNv/JfmxqSqkldLiyYzml0wGBV+GNpqG71MmilHw1myskfft217ha0s1cIK/a+LP5nlp8kd+bgo/2PjOHctUYp5MU9Pe1g0K1wLnFhse05nud5KWV6u+mZxRPWKWp/MSYt9JPB463b6aOFFyjfWHYQr1xGUGhxM9gIG1Hapzafjd+QK0FM+AN3DRJYMGFnvw1Za3aSjzda0dnV96BWB3YnfgfdWQlQtHFOfSdg+MD7raHN3IKVux3nytgH5dXxXfbZymJ/JBC5UVNFcFLkbFfQxKq16X4FhRydYFyKJj6Z65wvH+jdS77kFYMojgDveAgN19D5ybmbNJ1H+0rd8V0uadLJt6xwC9wlLFuySWQ3LWe+JioZRm1bxX+/blrab2QQn7Zzj7Ieaf2xj9rVRM+01qUOPwxesUbgtBF4y1QVIhV1MdebMn0bs1mpeGuiRplAFosl6RxzHDRq1rXubjrpPYmYToKAmaZ3ykWt/OxG5CmqP8DzEpxwloica/hxYOAKPGtfwgmsdjV9UJfwbNTMkFWPj3qMvNRJHa0OyhRfYeLqcz/K5Fm/Dn+veERoSRDG85EDDYwrC+lMGN5Q+QnedJIrIU5+RnUR8kF8ww67sVL4siJ7BwZhMm2IIDMAQd9ZsTEn9hSJjfXXMB2QQlgMYgC7ln+j6r0Agec4v0Lwo/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(71200400001)(122000001)(186003)(7696005)(38100700002)(26005)(6506007)(86362001)(53546011)(52536014)(8676002)(9686003)(76116006)(66476007)(508600001)(66556008)(66446008)(66946007)(64756008)(33656002)(8936002)(110136005)(83380400001)(55016002)(5660300002)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jRP8zf/pPUxawdocDIn71Z7zjyFHjz367iUf15qbvxT7I38r1jNh6bwnZgCj?=
 =?us-ascii?Q?JIRKnuMoGQs1vjQbgzVa2hsVu2z/PtYjh7UdSPWjHiajBc5V3b4Ck432gFgp?=
 =?us-ascii?Q?Kzcqh3Yx852whrgZ+GlMTNfFf5IXUnUUbtBodmxBJaMF8ZTeSu6js+6Sg7M7?=
 =?us-ascii?Q?/EWPhF4uwRHI5M0XRClRWPRnrHL5h7FqelIN5Ym+CZxHYckyshpTAGHDxG65?=
 =?us-ascii?Q?9CoARQqDbepgNaSVJkkNXXkWuCgSUw2a1sQtPiuRTUOcd8uhtCRt5EHS0yIX?=
 =?us-ascii?Q?2CLuUO/gOg+oS7du9pnP1adFOj2w+LuTRX9dxsZ2KT0cHX5Wazlr04jMb5LJ?=
 =?us-ascii?Q?QDY9CApfFtBM3OuVIqvPqyV50IkE66mJ5cpWcxY8hXgVQAYp2mhpVUsA4992?=
 =?us-ascii?Q?nxVLb7iRo2g7gvdA6IYAL8znB1JvwAMAFQ3EhohDuYoUzkgC0f6H2X9pZYMU?=
 =?us-ascii?Q?S1GBmxXudZpSrsyYzBVq7bXD/UzLP42CVhFNSN+CJu2LJsdFDe2kRvL5VOsa?=
 =?us-ascii?Q?uk8VcvaJBdPyOvjuxka9bLbz6YJFiNUKLoZi5FRODcRaBRhePfIVFJr6E6lV?=
 =?us-ascii?Q?YxuW5vXoNhBQLreuDbN/segEmlGqmItZj8vFqClLvv4VSZdBQxyZ+X3WUD4J?=
 =?us-ascii?Q?IoMa+DBmHwruIoVhsHcBTnRm0OueYQSXdqbhFaPCfaMepKFOpjzwwDZH6eN0?=
 =?us-ascii?Q?roaI5gOIE8s3Evn+wwEatsnRm/xZvVPIea6rK9ths5U86G0gUIa/xVywldis?=
 =?us-ascii?Q?VmGDA0M0TkCkMsaItLH0XsKhGDapTW0koDdSISMgydMNoGn4Z4gz+DIduHYU?=
 =?us-ascii?Q?NzKN/l6EpRB1PTDxGs0eM3G79how/FHM4Fu58C+DAA/k3twvMw5Ntg3CQbJl?=
 =?us-ascii?Q?M4FvgHq8/ix1gJfmqATtTH+R7cY62Gs8LeaqdqrcVE/kLbQttew+fni2aRFV?=
 =?us-ascii?Q?EWewkY1kMsaNUPIEzpd1mytmSCmXmvpj1boCJ7yZxc9LFKh/Pvp/1TI5itEv?=
 =?us-ascii?Q?Q7Vog7mMzA4i8ViA2qr7zvzMNYspzBL0urhpumxVcR2qQs0sS/yYFNCyqNGA?=
 =?us-ascii?Q?DjNrBeyFea+KMS1GsaIAL5fRpSmD81RiQpm2QZqUDiiZsmpe9oJWniBQNJkR?=
 =?us-ascii?Q?qBhq13cf8gTrOhOkBJwsUK3GFd1i5gsKBQJisrzc5uT98zmY3GTABF3u9HoL?=
 =?us-ascii?Q?m7Enb70r7GCU0g6Gkf0S4pE0+cfET2uVYeW7cvoS8TARJrzf9wPptcN3gArr?=
 =?us-ascii?Q?i64inMh+WSHg9Vr+7bG4BYNUHQPX1S6SDrlovaruMBZg8EMDNST4Mdyzolnk?=
 =?us-ascii?Q?0IDnLQ7TTs9IkuzgLqKZnPvAIFUTiQYuhl8Td8L2RSUprCzBsJOmAXxhib7O?=
 =?us-ascii?Q?QGz+2Sfng9A2iObtjNi+fAAeGLxgcfeDemWbQEz5/ro2MMK4J4QON7PxAclO?=
 =?us-ascii?Q?EGp66F+NBSE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8062756-c5d9-4b08-94a7-08d99350143d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 22:30:39.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9063
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Z.Q. Hou <zhiqiang.hou@nxp.com>
> Sent: Tuesday, October 19, 2021 6:18 AM
> To: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; shawnguo@kernel.org; robh+dt@kernel.org; Leo
> Li <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com; kishon@ti.com
> Cc: Z.Q. Hou <zhiqiang.hou@nxp.com>
> Subject: [PATCH 1/2] arm64: dts: Add PCIe endpoint mode DT node for
> ls1012a
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> Add PCIe endpoint mode DT node for ls1012a and reuse the compatible
> string of ls1046a.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 50a72cda4727..82bf2fe6f8bd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -545,6 +545,16 @@
>  			status =3D "disabled";
>  		};
>=20
> +		pcie_ep1: pcie-ep@3400000 {
> +			compatible =3D "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
> +			reg =3D <0x00 0x03400000 0x0 0x00100000>,
> +			      <0x40 0x00000000 0x8 0x00000000>;
> +			reg-names =3D "regs", "addr_space";
> +			num-ib-windows =3D <2>;
> +			num-ob-windows =3D <2>;

It looks like these properties are defined in "snps,dw-pcie-ep.yaml" instea=
d of "layerscape-pci.txt".  Shall we add a reference to that in the binding=
?  Or maybe we can just reuse the snps,dw-pcie-ep.yaml binding?

> +			status =3D "disabled";
> +		};
> +
>  		rcpm: power-controller@1ee2140 {
>  			compatible =3D "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-
> 2.1+";
>  			reg =3D <0x0 0x1ee2140 0x0 0x4>;
> --
> 2.17.1

