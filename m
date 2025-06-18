Return-Path: <linux-pci+bounces-29993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDEADE138
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 04:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E84E17BE15
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239871A5B86;
	Wed, 18 Jun 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A4Q+1UHa"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292881D5150;
	Wed, 18 Jun 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214610; cv=fail; b=tChsaHOj4AtJfYIdTlMwPL0G5m2vj0AVT0hFQMf/Mdg+Q6zq/FpCkFbGGOcIKhHu91jAOEyvKYH52YyPjFzP3icG5/38l/WZE3doaCYx9SJpg2BtOJ3PLadza/XVVtpwYcYIU9BUI7DfcM0Nho+2AEg0yMI0MOCT1gicjKMQWZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214610; c=relaxed/simple;
	bh=spXaTUNWbjDr0Z799DAGf+KAGsuLXvRYAZkfa253A4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUkRf694vV+7Rw6LnXCSkGHu85cDZaIS04o203yBpZjlraw35HSS+s/6fneu9VLO9ZyNkdaTEOz6YJ85xO23XBkoMQsMuSC8AyQ+q+UY9VuGECbYmzsIo/hUEbnIf7uSIKimFBukxrdD3LlboB8MR9CzNAn6Ae2CglkoCRTAmmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A4Q+1UHa; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrGIOOpLLJglOUB0OVfapTQ6AoqxGx+qn3XUxpR/4hFFuYyv2tpxo1GrtS6nHW5P0ZNYDyUWnr8uNsF/UpVn8XBbVpjxv/hhgYDmWBZw044TN9FDV0GpghmKGvBq5ljDABCa6hYd4RhpCsKcwwZ3src7PClC4X3uoeWlkLH7SDbNKO/lyXe9GI4gYhawABKJqiJG3AbLDWC4h+ZNmKvS0kCSrdw7HhCAjWIkX9uTBVg8KJuczVugo3xxPk9hewfnvKyGaQ33EIEZrJ3Hv4bEP7WDbFQDwVW1jZv02B3NvPYclgPL6z4DmYKAoYGmGTD4p2rPj+RreyWufAC7u6u9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QVfpL3Uu4Qneq+YaDedsMxDi0CtiDEiWyGaABqQyzc=;
 b=RqFMESx1TjniwpeffroxdEqTAF6YkkMsXCYDWwtEeAM1+ZicFpCe2UBXvRZVN3G3CG9gtZ0shs/WlIiSPIFyZfULs/uNb1IsWtLi2hwRV6cABbWZ2BUlzpaR5dGEafgdkF/63uMRO2LL/AirdekymOYJ212UvGwMppUAeJ5EhzFSgReVVhFQdjXGUPCbRxri461ADm6VqOWTljKv8urHg1q5rY2HN4UCPAA8pmcKU63RoKyB3pC+jIgIcwLqjd3F6HOVzXSCEaoilseQPZhdYfVeg4T8vrt9xtTZZt8wIM0FidiFy7NKVsvf7CklsRAl1JobpQNOFhlmj+Lu233ijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QVfpL3Uu4Qneq+YaDedsMxDi0CtiDEiWyGaABqQyzc=;
 b=A4Q+1UHaXNerIdjo2dpo/WIUdkY2qpedceAh1yLJ4SMNdP/+u8DSAi41bWMSuBtDB3ZLc6Nhj+GFpIKmtuWGmF/VtTqGjgDvOK8yrbn6ddBGW9Lnz19mr8nmBaBlq7mul5CVVhX3Q7uzVh0dw0sNu0C8YVAHlI3VajRwky7FvX58es6kScCqpOdV8UJQbJcce8Id+JnRLSf8pCBUjlRXYW+hnmpIjbWgaUjJwkcJrqsTpqUKNPTZ/y1RwO/fslMieyaqbX7sTo7xPd+pGTFwRkID3eOqa3IUo03pLkBUG86B33mhf44it+Fahkk6kImVD6PCe405fmFDrGUyRixbfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU4PR04MB10960.eurprd04.prod.outlook.com (2603:10a6:10:585::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 02:43:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 02:43:25 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 2/5] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe in PM operations
Date: Wed, 18 Jun 2025 10:41:13 +0800
Message-Id: <20250618024116.3704579-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DU4PR04MB10960:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ca5b94-6be3-454a-ca9a-08ddae11e5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YN0gUfWw76JuY0DNK+jhTTXYohwF7mexCJhWpGBIzojUvz+aB9XdK75TDdRn?=
 =?us-ascii?Q?edmiEkX7Wm/yB6ZfarrOs4jvYsv2z1PPKke+M0M48Ji3ZjIhzE9x6Fy0M9nn?=
 =?us-ascii?Q?hCu/JTxr3LYAXrbNhIruuF0hT9yUZzXNX2wihIAUc1FOBmq1IhEI7Iu5MV7m?=
 =?us-ascii?Q?yvhExd9cPM3bqYqkHg1BTJmrcs8FNa829HYt1BN2wN4MvBIrR5kk4V1NJsKZ?=
 =?us-ascii?Q?Q4r2ojQ2u/fAk0IWEyi1QYOO849O5B+3xfk5l74LCzSPds9qP7Ppb4aOvAfP?=
 =?us-ascii?Q?g8/Bu0irPHgGx4lltrTdkhRKnsSgu8tfB16yL+8+hDesdnVe5SkRPgt2W2+5?=
 =?us-ascii?Q?6RoyQR3wMW4+/+TYQB3o0XLILXrnHvp5MGFzK9zxRog1V3F4Y7kHYUoQc7w6?=
 =?us-ascii?Q?rQRypi/vFb7RO8CyOZmxjfz7ck/VyQBijIrmOJnAV+znxE4i/4ExkDf0d7gu?=
 =?us-ascii?Q?Bmzie5HJsKELRO/SqPtqhWIKevc9JcaFATz27ncRKzmAYGbrqI2KM+8kJfFp?=
 =?us-ascii?Q?aVpEm/pxXMYKfv+kbVwRTv/XPQb1E1yNma3yh+CFwI/nKIubQPRx+g6pbNJT?=
 =?us-ascii?Q?aZlqjDHY1BdxRUU4CUVCVi0ynNR7uTcz2YolTc7XLF0574tgsQYiCXcQSTic?=
 =?us-ascii?Q?kUsnjpsDnpJxVGaA8Y+mBaIcnyuPCyP6Q4u6ZVtTYRPy+5Fk2eoTGRbGo7ts?=
 =?us-ascii?Q?4f253y+iOQ5NPLLxnRotXxtHnIT93OH7WlDLLBNA6ir/KpEfOfa9VV3p16Bv?=
 =?us-ascii?Q?9Af9laGASHbIV/QcC+tAJ8EV6ODvUZWCs4SUJl60OVTgMCXoc9OzwHW8e6+U?=
 =?us-ascii?Q?1cId6Zuln4101gNx1QtzWNOtrYkE2NNeJ/zmk2yHcM4n6jisxnQVGKA/k3yJ?=
 =?us-ascii?Q?uX5UyUelvDmJQAdPZCaKuF1hNEBnPuG2BVpc3nMjD+4Ru8jvJKeHcQlqHCMB?=
 =?us-ascii?Q?tcCYgmCNXUd4RvQ54nfNbls8+0pLoInmrQKTvDrnQeTmHWdIig8s5yx+tLDI?=
 =?us-ascii?Q?etQ6m+d5cdv9d94tZRalHO+BEfO6z5dU7thubO5+Iferr1ill5d+C/tFySXm?=
 =?us-ascii?Q?xV2Y2pPqKF42DSfjNKNHd6OcJE3gNZaz1qFngMmoHxu/lphGcEuHuOgTt57i?=
 =?us-ascii?Q?nxgPLPLYOqy5gY8EB2bnewhlKI7V5OjwNM+b7JVbDYL7VinRdp8ebS8deB3Q?=
 =?us-ascii?Q?qPCsKf50rvJKMwXxodAT7a7k97BvE80VKELm6Kz2fCIO4QT3qgcC5gxb9Xq6?=
 =?us-ascii?Q?iboIzHI8h+P+CUtHlkfhOsy9L3HlXaEikLLwOjJjlbI45Q5VKQzvNQGfEc3k?=
 =?us-ascii?Q?fkdJ5hrdBHrvhSv391x996Hza2ItKzlimgw8K25MoxFrtuObRr+esfx2VeVO?=
 =?us-ascii?Q?30mCqI9ZL4/a+TYmACvqVG16XFud1S+SAP9bze9r5NDhungaB+Qw/G+k8mUM?=
 =?us-ascii?Q?iUTxnm/HrKR18X6O+FCl4hEWRfKp/OrrwYCncMbsnjoxNIH6Zik8yBksFeWe?=
 =?us-ascii?Q?fjG83LOpziCSt2o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2rOsfuFXYZj/RY27mJDTI2bFTTpRRDCJulMkIxdApL91Fuo4UA9WXUGLszv?=
 =?us-ascii?Q?FDFugd/boLy+FSMv1vAgLRPcjqCNfDg7deaYLQCYPDgnDYRyhphN79qHFfB3?=
 =?us-ascii?Q?jSvzHawfC6+8DIPBaOJfmMRvIpuefzKfzwAvIsuR5rZdvcUlL9ONvbOi7ZgU?=
 =?us-ascii?Q?FnDWYsJR0CrrVrhAbccp70dapza0X2VFmbaO894vVEDcIXUWHsgWGDyXeO1y?=
 =?us-ascii?Q?AFsX7Tj/9Srdo9F04Rv6p0GFbEvOsWZIWfFRNJp9fgUKLq4Vw82OuknYwfNd?=
 =?us-ascii?Q?MPrtTjuQv/5MApy5rMzHpRK/XdtXh3twr2W68SmI6TURdPht6xDV1LLa/pIx?=
 =?us-ascii?Q?odoB2Lo2X/6FnK3yE2aZEyPS5VPWcZXMV7lseerM5IsThCYfApXLq0IM1i1h?=
 =?us-ascii?Q?uOTBJ+MO687qMCJuphkCwqb5nukdeoGA3ruubvZyskRTkEqTQ2e2qiuCmk2p?=
 =?us-ascii?Q?OlB4fMVGxzjiUWQyKPxRm9W5/eXTJAMOopBTN5DyMcdEN8WP0HOhS8vP7fUH?=
 =?us-ascii?Q?9FipiAm2mCU/IyZy10ML9zTSmzXu7ZiSaydWtvJhQRBNPwENSqTuNp7POjBf?=
 =?us-ascii?Q?6rCYpPOdK9JiA44r0ZIgZ6gfRPcDNMoIHLaigmkTjqau9Ar3zakXoz3Bo/Kr?=
 =?us-ascii?Q?br7kaXLpMt91gDd48Ha4FmpGT7FX1mYld0uK2m3hTKiYKCOUA68zN6flpBTm?=
 =?us-ascii?Q?xvbHqnHiSzg7mHhWZ08RUl/44oiojHEKN0eesKOCWzNdz+XLZ6giEfa+jlha?=
 =?us-ascii?Q?28NUxKlFzniWzhJjkKt6eAhyqGP4wIdQHiE0b3AAJYQ4afOglM+5EoMnTHCN?=
 =?us-ascii?Q?zCnYOcvhgdf9DiMZas71tZzgAC1/q524kN3o2cXMvvr6okfeRob+trn7b49o?=
 =?us-ascii?Q?4wa1ElrTiHZOGp4gnBmOKVR8ybdiTRqP5jX8xGWtQU7AjZTIEJ/a6wWhF4GH?=
 =?us-ascii?Q?nU/KOE2/W1hBus4sDtcsxnHByz674eoAYlK0jVDNND3Iwu8WyB41xMbFJn9p?=
 =?us-ascii?Q?9zHaDNUjs8JbVf7O9NvNhdJrNxhdXNaWAX/E42r3Nn2vQgjDP/maBlXv+ze1?=
 =?us-ascii?Q?Zq5n3ROKjkAVnbfYvRR5fnSYdumeH4btq4pEjrQConlfAa07FLFswQTobrR7?=
 =?us-ascii?Q?r5iLngtwvAW/oJ5NGn4PvF5Dxf9pxj8zNvxgDYb8L+v3oQIlFJ9gAU1vbc68?=
 =?us-ascii?Q?uyZU6XqWCbjJhqe0XGAtoNAzakvgKE9ebn4QV+MivxKd1Mcf/cHSkDFEA+kV?=
 =?us-ascii?Q?A//pSvdX3e1aSk/rznhlryonC1kUUtopUl0xb1UdB8WtKf8h5c+feFmWOlDF?=
 =?us-ascii?Q?xXpaHHw7LfuBGoBsHy4eS41LwIHZMrrySnYAXSVfdny+LwrklopmeK/3VBIK?=
 =?us-ascii?Q?RqwI/7zqB7qSzC1uHEE6+umrNng45GXKmv2IGO5DdTZQc/eB+iG/Y8A5uiUO?=
 =?us-ascii?Q?L9rFNtEvuNrelrUfoncOAtUvkJb+O4tV+Xm8tUasKb1yNZ4X51IebFCdLEGW?=
 =?us-ascii?Q?StHSS8dudzqTRBAvFqE5P325XEljG8mrLWY5G7JWfz/PqStg8xPuz2wDW61g?=
 =?us-ascii?Q?2+AVDYkxRiNVsak6Wt3fQJGiobu+t5OHF+62NB7q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ca5b94-6be3-454a-ca9a-08ddae11e5e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 02:43:25.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yj1mUnxeGTc7S8OA8F1A1kTQEU6/nEFmi+GnN7TMyl2qTpPdrNxEe/v560iigZMcVVfYfZyM3kvnyMuOL6dNlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10960

Add a quirk flag(QUIRK_NOL2POLL_IN_PM) for i.MX7D PCIe. Don't poll the
LTSSM states after issuing the PME_Turn_Off message.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8b7daaf36fef..f084a9ad1001 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1851,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-- 
2.37.1


