Return-Path: <linux-pci+bounces-25986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5BA8B313
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1356E443B06
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC422E40A;
	Wed, 16 Apr 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxNG/1wh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3522F16C;
	Wed, 16 Apr 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791304; cv=fail; b=pa7ZckK5z/TvZuDeqil6usHn3qbyGRTcYsfBTlyTMmv0mCznNlun79R7hiIScglbEikTn43Wa8rRM5AxuZtEn/eig0Qwb2hn4bbrQV1DKq7SGAhEU2J2RbUJz3LEiX1xWak+vLAaDqh3jxfhW0L6tgnwvug3FJCt0NYjqJ/fTzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791304; c=relaxed/simple;
	bh=baZK1Jqxs/Af5rJEmDWFrD/U0dl0KE7X7CVm6Mgumc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RyE1qty2HS8R9tvUrul1nf3vrFRbiEofdKIeZ1dwqa2zvUJLywBDwDXQPAG8zDkuHUr0AySI4xHt5ihTZiX1k2SMIStQ7YtJKN8yjCeiqn5TmWYiP46eFtdO7JpIpwN/uh12VIoyv9EDvu7fI/J8L/S0AdV3q5LBWj3gGxHacuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZxNG/1wh; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltKKWRI8WD+tym+zLRKJYm4LWMH0FoGO+uYsiTe6WIgblTRS2SevJG6+Gd0poDTB04tFBxixjQ919OaOLnRA9k62pVmnGwmfTIv45bQ9+PyNkSRBSYkbt/SMmenU5tDzhxXf7M8mLce+MyhP4DyPCWvfTorEYKw4RcWkqMOjd3jPxryfaVLPdVeCpgwk0w3x6qDfb4gxrnM7nLjSriMeSIlvfDnBUFuzICpk66X4GZOInOVOLuuk2FZTTajf2+DR4NVwS+b/T2BD8owAhXDoqdr3cB0GmEZq7B53I0RXh4tXzC3lFLkFo+Mi1N73gbTRcbZWD/uUJ0sJxURbK2aXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44ql7gMMxH0e/yMRoGv/knoUioHznUcfCCpcl2n7P+E=;
 b=FgdIV+RGnHZ+I3f7iu5f5f+oMiV/Ycz2nKSAYQxJSPJI7bgV0IA76UR8fVj5CIWQq7fpXA06c0CbaOIKHY8MaXVAAdDMRM1LJe96b1cbdXny9hywfYBYukOwl04CEW7Agm8sW/xP2QdWFAuK5Mpe6Bryiccf5BL/qW+KLQQX8Q71clmhgwaaBSjwe4zu3Gi3RxdGEq7qR9TF44cQPyNV17kFKdo41trbWl8UtvgO/zQ/cWQcHLE213CWPY7RihJ9N32/C+sW+B1I9NWQwK4cuYIkSKBVDQIjTNsT5+rHW6X3qZO5TSj4TOSfGZy7F+1vUZr4H99SNtNcvN+weqxI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ql7gMMxH0e/yMRoGv/knoUioHznUcfCCpcl2n7P+E=;
 b=ZxNG/1whKfDy2vxPHSn1nzp5vNiOfrHklQFy7SizSBpSi8xlJkm6oAmGFuqWM53nbyNj1U9vNqAnXRTYEF4481TsCO0mO9NwXveSB5StZ0A3Y7XaXPqvvZcaKs5bsCzcdxRgTLWpTxRjdKQ1tkWU+pgBv0LwD/qP9e7lZg0/gPY863Js8dqCD+XDQJQN7mE877rII5aOBzfvJXWzwytnixp4P8NXBqxLXBRsVHtZBFm93DU4GvuZFdmBJTfZT6nyHGg/PMU5etfd2idkooOZlOuDP8VqIx8jbRb700OVKUL+lRRH9raYpHcO4rywZkymlJww8wUgdvgCs+1wLLW3sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:15:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:15:00 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH RESEND v6 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Wed, 16 Apr 2025 16:13:11 +0800
Message-Id: <20250416081314.3929794-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 2463741d-d5ee-49a8-cf67-08dd7cbec81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjeKhENTnT6Cr0kTEB5AYmNrSZRU+TyyVkoMuLyo4FWepPplxrTkx2Ca7n1I?=
 =?us-ascii?Q?oJkKNmmhozjljMEC7lIUnRl2o1Mbp1+dpAXjSi8HDJzpeq8qOFjxoDaDDuY/?=
 =?us-ascii?Q?c0uUA5mTPtXYycdL2gvvNr2ZRGOLGS0M9qObUlXVqjEFD3xXtgBgoUu02A7s?=
 =?us-ascii?Q?0pFctU4wQdebSS1odQ7DUQ9va8aq/g8c6MbeM5hgaOiPPjBt1ZGDqb77GZRa?=
 =?us-ascii?Q?JL66fIVZ7xXO7dvIHpNtQzl/XGu/q8+vmCYYbQ98kA+Kr6iKKnthOz4gATEI?=
 =?us-ascii?Q?PcAhFFvWddGc/oat+TtRaPew3wHMqwkPKU8do+BPgT3DNAmJ6tIPOeSj9FuD?=
 =?us-ascii?Q?7h9Qcg6xTjGhBABfei28p43EmRlD6czI9vydYTbR84ANzUT4YT6VFrwd2cFU?=
 =?us-ascii?Q?fvm27Grj1xQwwY40vwgkIKpuR4deaz6BP/Sc/P5nl56G8AEqQeD5sxRy/LVU?=
 =?us-ascii?Q?SiRrigorqCffcmcmYKztUCxxvB6OctJ5m7iBwhnOB1RbSK4eTBS2qlDi7/GZ?=
 =?us-ascii?Q?W6/y3E6Psq/EGx4gvsSKfppeIfCHDJ2okgwIxaly+/LNktX2BXruvrLuT5Lc?=
 =?us-ascii?Q?SR13fEDnYUu5WIfCnSLeFPOILcmAa67LcFQq2Ns92Obs+0wUa8sL9gr7YING?=
 =?us-ascii?Q?1TSMJjeWZ+WeNJAs3LTJvp1EnrgRkwqAk3OlAG3KBmMWaI8DbotTJGgFp8+g?=
 =?us-ascii?Q?K3ohnA/ZcHV4uAN3bjxddxh3Fli5TFnXAPt4eEAJU357w0hvkDjkXHeylBYF?=
 =?us-ascii?Q?x/iRIcJqO8vFelGA4eWk9wi/X40TPaP1Q66w95TG2boWYEujofp5j5JRGBq0?=
 =?us-ascii?Q?i5/OUxyRFdlXUNE45Uop9uMkPkUob1fDq/HsdrNY1hbZ7+CUZ04F5/HeRenF?=
 =?us-ascii?Q?ZdD5Q5e9nv4BBvS51BwBSkz/ErQ3T57a6YOBrQUxRjWttFzSHNMR/FJ6tUPL?=
 =?us-ascii?Q?0Zio8U/+7AMuTZUdnQojXLdKw3OoN86haDpZg1W9+kRjHjwSJoz5hNS41afT?=
 =?us-ascii?Q?JH9xh1NM7FPLvYzts3sZpBMKfOXKp/OveMgn2g679BPFKjGN/wt+BdRJn1gQ?=
 =?us-ascii?Q?SmaCW1W8YQDJW7DhP267mwA+DzJm4TlCQlp+ob6TONJYIcuMY65WCxhCZ0Pi?=
 =?us-ascii?Q?5T8vjIvhHkdR7/N16IfBOx2fY5/+ZwhezzZCFArqobdvgWqD1zKs/zMQzGlw?=
 =?us-ascii?Q?WILfxLK+tQeueTvDqmHsfg7vBfH7H82KdoiDnQzoVa25d41SwrsFcEFrempi?=
 =?us-ascii?Q?+G7ILpbu4GroucJ/iLixe/Tqn5gHnYLayBThb480y1qaK7L/kne8HRKEUMUq?=
 =?us-ascii?Q?0yxv8biUt0cMKldZXDGQYj63s4WuqNzlQhMu4c0YSz7pnfOKjQWSpcdcmk6O?=
 =?us-ascii?Q?6yNE/MsSDpY0fc7MvCqqmb1lNYBjDf77JgCTbeWpw2WfznbC6ShAoMi/2VhO?=
 =?us-ascii?Q?dhAbWuBT5u1uaQk+oJ1EprfBZtKZr8lrYhEI4eItJ5rWLm6jMjSpdIHl3X+P?=
 =?us-ascii?Q?STrIeeU1V+WiTKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5hFgqN4HTrX+koWQkkarWs7c/J0IlbM4crTwWJo6CGlf0QcwOJRV8z6ApXWK?=
 =?us-ascii?Q?0KWvXX4cOzACmgvluVgooZY9GsxRP5zxCievyOB3fLd/QOCIHgsXe1nbor5I?=
 =?us-ascii?Q?CEM1QLf5fkzxGgM9VprwHrmcP0PkUTTDJWil7PD7FxDcrWO6T05BIMqplKWu?=
 =?us-ascii?Q?1mEwxLOmEOHycAfH/v0OclEKG1yChf/AfbAoRu6ZebCC9Un2NGNAUvA2HoT1?=
 =?us-ascii?Q?eVOzZ//XVynb0iynxfBmsFbEkAQmWQt1tW8+wPuZET3D2Q5TjNHe9HBG1eKY?=
 =?us-ascii?Q?YzZlJn7/6oc+VEN1W8uupfOjKXiIKZ7NpJw8FlnazSSvVaJb386K31JAWMhU?=
 =?us-ascii?Q?49ZmFA29ReFPB6dHFR3Y8rvFK105ktLlK4PBpTWNyXSZKrb7K27AOVIt4g+Q?=
 =?us-ascii?Q?qgnkkHK9G15GOatQmBAsy5z7p1bD/xY0TehO57Swic7zMDx3TcZ86CZ7rE77?=
 =?us-ascii?Q?2aSvcs/kp272yhOvkBpYqgMGBZuqOWYFQoNm7UNE6GOo0eiAysMRJbF9rQsA?=
 =?us-ascii?Q?JoqQzszonGS1As1W/Ah6PmKhQZ5WU3oAWe69ibOy0RmUBZoHgkNUAUTrzmZI?=
 =?us-ascii?Q?4fLPyaJy/HUFYpTn1j7qiZ2yUB3pya/o9JUz83PzITAtq5w98zQH17JrcsV/?=
 =?us-ascii?Q?hWlMbli3rwCd/CvoJ+h3x8kCwUdVCIlpw+4WM9P/93GUYNMt2IyoTPruMIJ+?=
 =?us-ascii?Q?jA42czXzKoXYoiu7NHJAk2tW7ABUFbNE/QT+jdyMhNWR0rtg+SXzamaItH7Q?=
 =?us-ascii?Q?hn1d+wP0SsS3c0Y7EMkUVyDHQUF4xjQuZPwGzH1jqj3P6LcOG3ZvaRzDJStr?=
 =?us-ascii?Q?F0KO2tYvhkwEHBRHLOObHIjiLO4Ufdaay/0QejNY7RJIx27gFIob86mA2Nww?=
 =?us-ascii?Q?7XnYbftwWr5OiHFg4guqslx/mRkTLaRTbTpotbvAqEmyrJOkSDaA6VcFy09l?=
 =?us-ascii?Q?qBExUHU3fhb9Q2R8uVZ+ks7PLJPdJ+NRflrxTrOfs8Fq1THQ5GpF5DH0KPUa?=
 =?us-ascii?Q?8fyIt8HdR4Fyuq1vY2R09IZBhlCydLIP8igqIEP8vKYJBf9ZJqxSvxFLEhdF?=
 =?us-ascii?Q?xwF6iapvqwCIuvJ2Dad4hG2uWdMfyDTLtIC6oa5iFfKKNadVVg+wweCDBAkl?=
 =?us-ascii?Q?tOBMv58IBP38K4A0qtG4kjG5o7feyipcko8B/rI4Er2jSoYsGoky9Ot3S4ca?=
 =?us-ascii?Q?O/J4oqpOr85TYyMCRsgRjVrUnEcdhTp+kjat/6DzFIh7y+VcpNwc7QICxSya?=
 =?us-ascii?Q?BCXcejT2z3ZktF0fVJtZBO5/uVoCcjfVvV+SBnQYfySS9QyjrXVmDlki5qsz?=
 =?us-ascii?Q?IIaB5dlqC8fFAvqi619Y/Py/17FasHlWptQ/Ym6Bn769xK5sRVcvkAcdG5xJ?=
 =?us-ascii?Q?zcz2El4SC2ekpRRNIO5pvT69Jfl0QGUAdA2jycWiD8ZYEZlG58Pnx1AW3awb?=
 =?us-ascii?Q?mo2lxjZDrHnp1syrcO7P0XdBkjJIYDUMFK5dGSlXb4T562iwlhSIezp8Fk9Q?=
 =?us-ascii?Q?DQCwBqzFf5bMGCyqdNNpbXRL5fLIpThhsPZ6ONn2bpGM7LiFSVOvoB0oK1YQ?=
 =?us-ascii?Q?e2Mva3K0NDgEsIalbbqdS6pIrzaYLah89bXKRL9v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2463741d-d5ee-49a8-cf67-08dd7cbec81e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:15:00.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+Guz4s1P8uPl3u1Mat7YYqOLZK0Jy4AIhm5uXZlEWardzHIkKPWegHxyVeXWFgcki9eXz4sdoU3UI8HTRSpqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit from
L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

The workaround is irrespective of Vaux presence in remote partner.
In the other words, this workaround should work whatever the remote
partner has the Vaux or not.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7c60b712480a..016b86add959 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.37.1


