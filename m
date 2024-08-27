Return-Path: <linux-pci+bounces-12229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E595FE37
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 03:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD342828D6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 01:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F444C92;
	Tue, 27 Aug 2024 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dc8GQJ8S"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013053.outbound.protection.outlook.com [52.101.67.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B94A2D;
	Tue, 27 Aug 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724721778; cv=fail; b=h53E0iVQiPSiH2TOCaHDEfe70Ild7R2CSSxogo6VCKm2p6hRFDJW8ORiF3zuSHNApfDmAvmY3qjzvau5fQ+giQIQkvF7x68mUY05VCNMrvH+/Q/XYWiEvmYws555w6IPDZ5V6qibqnJz83XW1YSejRPdyg8qw0+UhBDFzZU2/sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724721778; c=relaxed/simple;
	bh=cGxGRpUdoxEDxGaoD54MJuhDSrq9tmALxARiX1M5wfk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkZrfLgJh1hSxpOi2wNDsfHos4COjuMh28qKaqhe/Ty6VBDvsFF5F87OD6+S/NUj0LKykldcptCYGM7dumQsBTpoEU83VpNihHEzYy2abTc17F6Y5OJp+3Q/b0nbo7d8Qzyplp9mTffgyzH7EZ/3UK6aZqt4Zj/GB0sJvUM7CJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dc8GQJ8S; arc=fail smtp.client-ip=52.101.67.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd4t7IAGhkGcPYA5khRKbkPmdi9bHHps7YefFMdsbdr0Lt3iRB4jV0g0ze9XZz8F32VnaJagtAp5HACUziHcRUdgWKc/ULCejhSJ4kf1Q0MGz0PZv+8gZMOrpla/3UgcyhNxIVjw4hdyAo3jVwm6u88gfXzMtv7m4yVbmfC7ZNKIdaUM+/st+x1RLmE2Pp7KuQDbQlniNBfkrzQFlGb1HzJ1Usv6t7J7HZCvet5pnO9ql/fhvGEEd/I7hmW+RdLvhAT/m7FWZ9OBziAYvwuEJnlErUtEiUfXbdSfUj6+VBFLy0IY66JtUa7VtG3DmDu1xT36KKdX/uQGkYl0vIVYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGxGRpUdoxEDxGaoD54MJuhDSrq9tmALxARiX1M5wfk=;
 b=YBnvY8aP+E1YFpyE5gZHjp5N5A5MAgE3189exK5HKpd+o34scqXtIR+9C94O8JaylMtCH9gl9XKyEXlStPkY9ThlMupIElzfVWUlwOFRLBRzKHoCAHTSoEnoIGxFQyDOQQ3iy4WgsoAB0SpPmRK+aUYyJmNULuyNmE/IVbOdDQ02m24KlklbXmykfhkepXC+z4JS+1zz6ZO1RyYHWHrz9hvRP2+3/ECN4UT4cbxQVEbavvgcjJVE2ddotXcnipgL8LB6ZHA6HDKZqktjkH2BydsYiI4L8gmFbLxO3NivjW8NXiin+MZHVyXDOLoXkgRZ+kMkeAf9o6qshMF7dQ2G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGxGRpUdoxEDxGaoD54MJuhDSrq9tmALxARiX1M5wfk=;
 b=dc8GQJ8SS5ImwAUCzqZAQA0zOTaD6L+h5RymQm5Qfy3pUnOAYLOw6YC+mSgSDdRUaixSys60KVkFcXik18a8rAIWKbQhGNrCNXcca5UqA7EIyvLACXkE2/2nv13CaImyecW+cQvBWImjZsWElDnic/NZI4qJQKtdrZNQXt1/ogq5kYgXUhziwKs4yztE0uuTGpjlRgAXy90wd0ti6CJxPgAikBH/Hapm82TIN8sNAEG16UbkBAGmplXg5v/l5huabZRBXIFbrY7TRLK8lHhFhyCBrWqRwf69NW/3X7oNv8rwhOPITGTCwkte94F6rFs21ZoRhuqEuZkn/lGRtxcq1A==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 01:22:53 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 01:22:52 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>, "moderated
 list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>, "open
 list:PCI DRIVER FOR IMX6" <imx@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] MAINTAINERS: PCI: Add mail list imx@lists.linux.dev
 for NXP PCI controller
Thread-Topic: [PATCH 1/1] MAINTAINERS: PCI: Add mail list imx@lists.linux.dev
 for NXP PCI controller
Thread-Index: AQHa9/ZwjqvuCl/0XUaWp52wrA0qHbI6TuWw
Date: Tue, 27 Aug 2024 01:22:52 +0000
Message-ID:
 <AS8PR04MB867653F3383E76B7AB875BB28C942@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20240826202740.970015-1-Frank.Li@nxp.com>
In-Reply-To: <20240826202740.970015-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB9103:EE_
x-ms-office365-filtering-correlation-id: 3d3c5762-5c5e-4546-8350-08dcc636c5b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?U21mTGcxTSs3amRsWUZsYnVDV0lERFcyWHF1MXVmZXgrSm1GcTZPcDBBQWxI?=
 =?gb2312?B?Qi84WmpSWXdFMXpxMVJWYUV4WTRSdzdwZ3FEOCs0MkROYW14MXlKT1Rhd0Uy?=
 =?gb2312?B?Z1pQYzA4U3liV0lpdnJqN1RoR3d4djVsZHl5VmdZZDVRWTJ0c1dWSU44OXNn?=
 =?gb2312?B?MDBhOXJhZkQyNDRxRkJ3Z0V5Z3B3TGNzbUxDRnhoVEJJNlVsUHluekYxRWIx?=
 =?gb2312?B?TWdRTFdRbG5jQ2hzK3FTQVA3RjlBQzFlUXBzRGFid0ZEVzhRbVFnSFVNKys1?=
 =?gb2312?B?S05nRkVKSitOU1hXN3o0QjN6emdqNDV5YTJxZkZaQUNyYzRvU2F5ZStyd1Q5?=
 =?gb2312?B?YTRCMU5zV2xRMGJ4SXNSMjJ2S2xWVWQrNmVISm1OWGdOMmRGMnBVa3ZjMHBC?=
 =?gb2312?B?dWRUT2orY3R3dk9vK0NKNmRmbm00MHR6WkdLV01OQTRzQ1dQR0lsMEUrc0Nu?=
 =?gb2312?B?d2pIK21CMjBXU1JFdlNPVGdPNDY4T0ZzcXpuOTQrQ1NIV3k0WWd3cEFQUVQw?=
 =?gb2312?B?QXdwNnpaUjhYTXVQdW5NQmk4aTFHVm5hOVpqZW1yYUk1ckdQOXJxVTFjaGpX?=
 =?gb2312?B?ZzBnRVJHdFY1T3VYaHNyYkRoVUtaLzBaR1c4N0lGNlQxZzVZQkdRR1RiQkVF?=
 =?gb2312?B?MlN5bkdCUEV1SUhqRVFSQWgrcWp1ODVIbXdKcU5CZGNlaDBoMHVYanRRM0VQ?=
 =?gb2312?B?emVaaS96NnYvRERIS01zRHVuVmgvdmRUbHN0ajBMdWxEMEswU3VocVlyRTRI?=
 =?gb2312?B?TTZ0VURoc0F0K2NYekRxR1Q3Z0t5VjhtYUdNRmRDQVBMZERBWnZLclBEWkh5?=
 =?gb2312?B?cW1NN29xa21GbnlVYnF3YitKK3EwL0xhU3IvaGxVVnlqQTNYUXhvRW5ZVEdN?=
 =?gb2312?B?S2tYalpsYlRkYXlYbGV2SG9qN2RZNk1YM0NzR2M4L2lSK25SSmNGT0dONFVo?=
 =?gb2312?B?UlNwdEwrbjVOQ0xIbFc3SDFwLzdUYTJMRkdtVSsrdHpVRngxTEZKLzZkRmVY?=
 =?gb2312?B?T3VCMmxuMXhaZGRQRHJ3WjF2dWk0U05zeFNKV0JKT01wWWoxYnJIVjVwYTNS?=
 =?gb2312?B?SG1vYnp1SXdRZUd6VllwN2R5c0VSbFUrQzBIY2g5NDl4NGxaSkMyK0piTVE2?=
 =?gb2312?B?MVlxWC9BR0JQTitmVzBLRjNoemdOam9nSXdPM1N2OVY4NUd3UU9NOGNJdnN0?=
 =?gb2312?B?REwyRUJlRWhmUjRPVDNuWW15YnlMS2tXNFdCcFhqc2RYWEZYZ2NHSlVaVHJ2?=
 =?gb2312?B?RGlnSitlRE8zY2hIRVhrUzVIcXNlaGNwZ1FqMlhkcnRzS1V1UFB2WVBJRjMr?=
 =?gb2312?B?YnV1MnA4WlM5NnhWUWMzQm1OcnVsak52dFVFdW1JMkdMbjJDMkhPcjNrTjNq?=
 =?gb2312?B?QktsVTNDcVRRM255ZzNlNFhEdmhwNFF0cnh3R1dIV2Y1ZzFVZUptTWozWldM?=
 =?gb2312?B?ajlkMDNDU3g2MFBuRDMrWGN0Ry9XcmJ2U24wNHhFSDFUamtDN2dSS0djQU9m?=
 =?gb2312?B?ZzZxbGpZNUhpK1lrdlB6UGhYUXdUM3NPLyt4WWw2cXFWT3NabnFiMkJwMWVC?=
 =?gb2312?B?eEVuZ3ZtdHUzK29seWlVeVRIaU5DNXgwSHhLYzVoL3lpZTY5UnRSdEVQNlYz?=
 =?gb2312?B?NHRBZHdLZnM1K1hNdUtyZkl0TU5KVERQTUtNZ25qWFhkUStVblJvMTJTMXdU?=
 =?gb2312?B?YmdCTjNPclRBVS9WSHpGV3pLQmQrUzZWeEIrelNuOW9hWHNKb2U1TSsrbXcz?=
 =?gb2312?B?aWowU2QydTdKMXQzMWMrWmVuaEw3QlMvSzNZeXVTRmo0Z3YwcEVuVnBuMVBZ?=
 =?gb2312?B?My9WaXFWUlZLOVIydmNQK3dubVkzQ2pjQlhhRXlNN3orTXNmUGZZalMvbXVI?=
 =?gb2312?B?VExSSHVhYVUxdHprSkR0a25JT2NpQVpBTzd6dUhZZ01FRWVzbUxaWVBiYUFE?=
 =?gb2312?Q?rV2VUAuFxBk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bUYzSGMvc0ZPWktxQ0hMbHF0WkZtczU3UnR2REJCdXFObkd2N2JMZlJSOTV4?=
 =?gb2312?B?TXFRTGlWa0hSdmk1SGZ0dDF1VDN2M1lxSTdTeVFhM2ovSE9KTWhnU2dncmhO?=
 =?gb2312?B?YVdzeE9Na3lLWDJ4elNKV2JJaFd0a3VtNVVrSTg1OTVpT2NHSUUvYmdIZXhh?=
 =?gb2312?B?NUhWMEhGN0xMYWYyS2FzMEhBZVl4Rk15b1p4M1V2VDVZWlkrUzhLREZ5VjlI?=
 =?gb2312?B?T2RybzZlWHg0alpJVzVoc01uZXJPNjNNVkVPNEMrOVgrcFc3bUdxWEtwbUx0?=
 =?gb2312?B?Z1dPbzRmdXVocUNHQitZbE5JU3lUZDZic1ZPYXMwMmZnK3dNSkExd0t3VjRL?=
 =?gb2312?B?UXZBa0IvQ2FpL2YvU1l3ckFSc3NSR3JwUVhNYWFFbWRDRVU3Si8yODJlVkxR?=
 =?gb2312?B?dFNqeDgwZWwyOHVUcVdKRVlxSEhkNi9reUlxeUpoc25PNXBGMWJ5bkJUZ3dV?=
 =?gb2312?B?OE5aZ3B5WXEvS01ZbzhKeS92VkVOUDRzNzFXQnR0QXpwam9IQU9FUkt6THlO?=
 =?gb2312?B?enBZQmQwVjhRYUlsT3JidGxzV3JHV1dIUEc0Z3piREkxUTNES2NHRU5reDd3?=
 =?gb2312?B?VmdxcTVHVlZ2clRCWTNaOUZrYkpORHFZaWMvZnhtZ0d2dXlQWnFJY2hTY0RT?=
 =?gb2312?B?dDF2RWp3U3ZuYk55RG5qYWxhMlBEZU5tb09SUEdKV1hPR0xPNmVmR2FveHJ4?=
 =?gb2312?B?QmNvclVMZ3BXVGdUekdadG92d3IvVksySjR3aVdPbU0rWUhic2hkVmU3ckxC?=
 =?gb2312?B?cEM0alp2ZnptQ2NnNWdTZ05WRmNzaDJZSXBaZmNaSnpXdDRpbXF1UmZaeHhG?=
 =?gb2312?B?d0xqRlZHUmk0eisxZzVwOG9HcEN5MDd0NFJXd1pwcUtHYk5aemdsZGw0akx1?=
 =?gb2312?B?UVdhZHRhY3oyYjVwbTRjS2lpMHJRd0xYbFlsRDlWYStObDk1QUpqeTlOUVlh?=
 =?gb2312?B?amRCMFlOMVk3MDNLVmwvSmIwY0FZZW9zUFZLVW9oNzhvOVRmNWF3eVZNQTFL?=
 =?gb2312?B?dFVuSFI1Umh6eFJDNmRQUnlTZW9ZK1llRzJmelFGcW9Qc21mVWNUa3hFNllu?=
 =?gb2312?B?TTczYll1cDBJYmFWL3Y2ME40Z0JrcU9oaGRiOWwrZEp6d01TTVhQU0FvZkpJ?=
 =?gb2312?B?VGdWWkdrb2lRTndKYTNmbjZiVFIzWUlSRitkNEVOSVhzcjd2MjZ0ajhoQThx?=
 =?gb2312?B?bGcybzQ0YXVOb0ZzQjJYYW1TRStxUHBFTTNPNnorMVJMbEd4MnJtSFBubFlr?=
 =?gb2312?B?UStPdzRBVWxHelRmNjJma1dLbFVQY1haQ3lXOUtmSmt6TS8za1dHOGZTVnpx?=
 =?gb2312?B?M0RNSFdKZUZvNnlkb0V3cWZ6L1dYeVpZd0FtVFF3RHFMMjhaNmI2cU1wZ1pv?=
 =?gb2312?B?dXBjbC9YVmd6aHlQNkxpYzRsSkMrSm9MOVdkUGNQWEJNbkExMWg4R0Frc0Y0?=
 =?gb2312?B?a3dUa0tQdjRIdGVBUklsZFpPVzRENk9xaVRyQ1RNMzBub3ZkckY2d0huWWph?=
 =?gb2312?B?dC8vRkRRV3FyYnc3MVJZRE83dVlVL3pyaHFmZFlVVVZWbmVaUFQxRStnQUdY?=
 =?gb2312?B?QjFMMHFoOWVTb2pTUGNURERYMWFiOE50SHZzS1BXbVd2aHdEVW1zOGwzYlp3?=
 =?gb2312?B?clZ3Nk1DaUZnMHNWR3dISUR4SkFWK01iOS9QTW5MaWozTEhicUEwc3JGY2dN?=
 =?gb2312?B?UjZCdFVzNFdDSytaak5jUUw2V0xTRWxJK3VoUGs3aW52RWJYSGR2TXZXL0FW?=
 =?gb2312?B?MUNsaDRqakZUanR6NEMxMnJSWm0zazBSYmtZNnlsdDU2VVZZU3hnTXd0eFFC?=
 =?gb2312?B?N0MxRG9kQ0htUitkdFNodlByQzUxNi9tTVU1MW9lMlhsRE82Z0U3SGxpOS9Z?=
 =?gb2312?B?TFRqMUYrRzZkL1cxcC9CRmdLU3pHTGphelJBbTlJRFA2OXJXK2FUN1VXZEFs?=
 =?gb2312?B?aThoL1R5T09ndnlpdWNjRVc2ZzA1aWN2S0F1N2YwUmZGeml4bFBwZkNZOEd3?=
 =?gb2312?B?NzMvajVyaFd0YjVlZlFmbm1IWmNjeHQ3K3lQVzY4Z2VLbC9lbUlqRVhuaDVL?=
 =?gb2312?B?RDByY0pVOEJvanA4NmZQejBZanBxOGl6ZnVSQWUySUN6OVQyY2duUi9neTJp?=
 =?gb2312?Q?cqNSwec2yX3daTHrjg0SUBYcH?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3c5762-5c5e-4546-8350-08dcc636c5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 01:22:52.7026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NfkLe1g1QgBhDgUCAA1a5uG9JSgkicdguEfi9TGkEXVOGU7hkSIXaQTJcKaCrNvWfbzmJy2iGLAEwskwJ647Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqONTCMjfI1SA0OjI4DQo+IFRvOiBIb25neGluZyBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2gNCj4gPGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mDQo+IFdpbGN6eai9c2tpIDxrd0BsaW51eC5jb20+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0N
Cj4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz47IEJqb3JuDQo+IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGENCj4gSGF1ZXIgPHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgb3BlbiBsaXN0OlBD
SQ0KPiBEUklWRVIgRk9SIElNWDYgPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBtb2RlcmF0
ZWQgbGlzdDpQQ0kgRFJJVkVSIEZPUg0KPiBJTVg2IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3Q6UENJIERSSVZFUiBGT1IgSU1YNg0KPiA8aW14QGxpc3Rz
LmxpbnV4LmRldj47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4g
U3ViamVjdDogW1BBVENIIDEvMV0gTUFJTlRBSU5FUlM6IFBDSTogQWRkIG1haWwgbGlzdCBpbXhA
bGlzdHMubGludXguZGV2IGZvciBOWFANCj4gUENJIGNvbnRyb2xsZXINCj4gDQo+IEFkZCBpbXgg
bWFpbCBsaXN0IGlteEBsaXN0cy5saW51eC5kZXYgZm9yIFBDSSBjb250cm9sbGVyIG9mIE5YUCBj
aGlwcyAoTGF5ZXJzY2FwZQ0KPiBhbmQgaU1YKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5r
IExpIDxGcmFuay5MaUBueHAuY29tPg0KQWNrZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiAtLS0NCj4gIE1BSU5U
QUlORVJTIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMTEyNzIxNDM0
ODRjYS4uMjIxMjVhMzkyMjUxYiAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIv
TUFJTlRBSU5FUlMNCj4gQEAgLTE3NTQ1LDYgKzE3NTQ1LDcgQEAgTToJUm95IFphbmcgPHJveS56
YW5nQG54cC5jb20+DQo+ICBMOglsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiAgTDoJ
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiAgTDoJbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykNCj4gK0w6CWlteEBs
aXN0cy5saW51eC5kZXYNCj4gIFM6CU1haW50YWluZWQNCj4gIEY6CWRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjLypsYXllcnNjYXBlKg0KPiANCj4gQEAgLTE3NTcxLDYgKzE3NTcyLDcgQEAgTToJ
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiAgTToJTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+ICBMOglsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+
ICBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBmb3Ig
bm9uLXN1YnNjcmliZXJzKQ0KPiArTDoJaW14QGxpc3RzLmxpbnV4LmRldg0KPiAgUzoJTWFpbnRh
aW5lZA0KPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14
NnEtcGNpZS1jb21tb24ueWFtbA0KPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS1lcC55YW1sDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

