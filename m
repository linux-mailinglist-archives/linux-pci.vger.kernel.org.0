Return-Path: <linux-pci+bounces-25465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD435A7F2F5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DCF3B585C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0724EA9B;
	Tue,  8 Apr 2025 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IVOOH9qB"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B72356AE;
	Tue,  8 Apr 2025 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081260; cv=fail; b=SYG17opyztQVX01TA+M1LuH5sjuI7JM03BLCnSwUen2t6jOKeadPZsiB1zfStfi78I6SnYPtrI6qEZMY4nTtn5P3YgrSFPdaSuuIfos51fgpwsJoLDoppLqtmqQvToIdItc/bl9PsBHsqxO35Tx4FGEe6QsnUrfzJlGqHeSHr6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081260; c=relaxed/simple;
	bh=OJaVlGIuZuLfuK43ca5IGo9AF0hfYb1Tipgg1k3Vhzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ifkrh06+mrYyNpd3fBnLysrFaQRHn+r4gOd88g6zxwyQAI4uJ4FpfrOPC/DwjqiEjPHerzY2Eg5f4Zi+rDZj60QjCcujw0bb0SseciEtSceABohwuzjlPhCDw1sV9lz7aDbE3Sj9yr/39AHqpwnJPDbIsfGBMal7CBSiFEmp4zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IVOOH9qB; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+pE+R15Q/4c6lFZ7LXhz15/yb8hUjChlcprcOp72gYf0VO7MjRndb9UexHYvJ6QrfLdB5hxSg8hgszL33aZt4p3cUHmzkV4ZkdC2b39kj7N0gpQvfdifS6zoUe7X9+7CkCrqALaK/HyeJyO4ATQZfNtXBD8I9ZcF1kXX1mbFfxsfS/UgsBYxRHeZrMejcgy4v+Wftj4mXAJzSYdMKE3OdzkqaUi9CKDqwFp1uTr35iWuMPin3F+FOCOV/M+HXueTNnwLgrVydKSeufB+NuS+skDEYSz+62E4zAISwnxfcvw92ME7HPDpzxwgsZw5E2NKxvy+pHWdwXSYVZAPpNFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzkuEuF3vxATR0qlAIIOxYhvBuAcc3gluQRBVeS2DXE=;
 b=FMyG2flhp3b7sxjvjHZUw4lDPISIpX6WWOB8RdfkRowSY4NFxsc/Vn6GVZaQI3CrtLeUw0lTBJgGLWrzJDOvCFpwjmYP+am6J17aGJdZ6HHJrl9OI4AcHlOawScMEWxNDjH7i62ghdLBkQmt0xAgClu5WAuITdA0W4bb7q2zjVDHCZ5AvoMRpbx/g2Q6XmjMtG9E2mtoxy6kkEwvPUprpoz3XY5y+ATTKnIGsv8gd28ZpMO5dcqBzLjcga9U7CQNo+8InY3OrH+JvmvGdbQBZJec2BCE1TASYjtGPXNzWtaKLQEeEAADiGKgTJsNiuGAJSm8QT5d+NOBrtvZYuOm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzkuEuF3vxATR0qlAIIOxYhvBuAcc3gluQRBVeS2DXE=;
 b=IVOOH9qBTeWQstimUOo5quDkAL3GB0KIJs98d4UtKjElPY1u9nCrxmankggpXqmVp2bnsiHkbeUnjZMkDWqRvza7KEN86G7mRokmZJw9FqPr8ISbbVWNt9kX/KLQz6fc7aPVZKugEU5e2T1sWDxkPQtXDQUR8vH8i4KwTIwf2WpMz+SbLcAO+myPrypoUXBHwGxs8OdfaJve/qOEQwb48pVMbB181d2oQe835i/UkEDgr0FgiXmg0O4xJpDWHq/ceZm5UMwVvJHHkTJmNagn+P7r04Kx5WL3YMC5lfVh8R23r51QOnSP5DRim1ek4N8lUT2E9hAL7rOQFZMpEIOHWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:00:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:00:56 +0000
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
Subject: [PATCH v5 1/7] PCI: imx6: Start link directly when workaround is not required
Date: Tue,  8 Apr 2025 10:59:24 +0800
Message-Id: <20250408025930.1863551-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: aba080f5-a1d2-412b-4671-08dd764994da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owXhqqKGWrtmI6wDuXEqiXv4wmib2p8RL2Mgwao0bjQ0E/FRpxF4S5F05ZOr?=
 =?us-ascii?Q?O+95djaTvukYoeVM2pmMDGm9C4UBwYx5E7BRHxkVk3z5J0odyAbIH9WwDyd1?=
 =?us-ascii?Q?UIrRnDlngG6UcuvubxJYA3jZuzQTzm88xS7bAUi5g1oTHJgzZ9Oheqex3Upz?=
 =?us-ascii?Q?3/JcaHc83+qhpaDP+tOh1RAYrctbEktR8xuZPm/eaxCbVTolMhB/4ivKPdDo?=
 =?us-ascii?Q?rpth1hmAM8jQHyxuy0OF8y38mcAS13aMlydjW5Ar7Ts4vROT6G/UCtvqiSpU?=
 =?us-ascii?Q?d2+kEA7zQ0KiN7nxPaGLatn7gT+RpJmR9OlSJz8zNR5cG4A6kCPgDxZmwADX?=
 =?us-ascii?Q?OlLzTpjUBvmUhDUzSMkgXRA4qc8BCvXj8YK70W/iHSgGb3ya3xsOGMK6DHeH?=
 =?us-ascii?Q?BdedYI2Az7B0sNnr2BovPrExd6aUvrg/cKX59cV8/ZPevucHMNFzATFQSUKo?=
 =?us-ascii?Q?We0wpDBYSqwU4m8C46Ru5BRtQGPMr0KF5Ueyqz8EIoElUYyZnCM6yLIQxX4d?=
 =?us-ascii?Q?Ua9P4jaUrQgdHtWyDlsFpcd7mBcC/nC1IzeA34S7JzQNviAMGk+IRR69efhy?=
 =?us-ascii?Q?LkV31Tj1au0FuPaswFEdmOhjKDDRxB5DXW3/xfJCdOKcEk73Xlvt6iaHTeE8?=
 =?us-ascii?Q?+RV2v8pi9neimslrsKzKPvnxC2bPnQkoi3QbrxO2FHZsO4+/bbfHc1EwJvBT?=
 =?us-ascii?Q?RcIt16sNhqY81c1mJsG11On9xxu9k1N9ffe4djKHXxwyS4z7mEGYCN6NKmn+?=
 =?us-ascii?Q?DmR0uV6r8EfVcjNSwDYl0xNApCivJlhcZdsT0NpnBM59143lkVdeDxMAQzf2?=
 =?us-ascii?Q?UuzwSiSgc7DCWVe22tIrehISUVkUGUzCgrBAoLf6r8F5BrIjZ2k6pqo+28IL?=
 =?us-ascii?Q?BjDKvwdAhQugLKePNOi9Ar/r2+xYRWrUODGvvQApWNNGwjZvmOlOKMm1KLn8?=
 =?us-ascii?Q?M0j4rOssKvo4bVoJ4/WelNSt+2lRPIt+KswBGfaamMGUJZJ5S6CDyqOcGLh6?=
 =?us-ascii?Q?Mq/FwMA8MdXubkOVuelWM6eeCiR+xyW2p0XNjC/NqSAnPreLnbuor67Et+UT?=
 =?us-ascii?Q?MLNmTbsCZ5S4IuqCT0FRPRvSiGuFhRUxwH5LmE4D+K/sDjg779KJNXWHKnlq?=
 =?us-ascii?Q?4DIdk+7Ti2LbZkLf3B1k2oOdT1iYqAgSHNVPP2jN7U1q21hud9I2Jr2whVP9?=
 =?us-ascii?Q?eW17c4JuuMHpiUZVBfiO8F2RD0ifpzSnfpjuT6DXFZSKGUkAqfqD1QUpQ8uV?=
 =?us-ascii?Q?ZqHW/yV7ZGFHE4qzP9LEGgMUfCRwXjYG7wTITmTaNQ3bcqoMGm8Q+uqHKT2k?=
 =?us-ascii?Q?/TGid8/vBhHVQhfJgz5k6HOM16/dXhnNm/OOeXIdCXWNohU92JHdvQg+oIy9?=
 =?us-ascii?Q?OhGyl1I42WQ3VHmRgrLqk7jxeHZQ2vRY74OdeSwchdh5rdxNW8mDwD/oEhqv?=
 =?us-ascii?Q?P9Zbv4bLX8vnjbCix03W6M2OCjjZkP6mct+rmUsdQbv5GXY4DlMqvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQJ4+zE4Tx2RjS/Ue14bzGzvzkZGbx2B5ysqVqKICvGe3PAOvoOtpvIHLVRx?=
 =?us-ascii?Q?KWSufWxavBf5/sZRCMo0j0r8QfR9hYHhbYYkaZSI0fobF0sRy0OE/uLkCMEX?=
 =?us-ascii?Q?LD+isLl5PjH8A3Vk3yRrhhgr36X9+XbAx076xlgkurcClGQAzfEnNgl9KrAN?=
 =?us-ascii?Q?0x10MkkMdnIdRTvbOmR/jPN0jiA3mAcLytUtYEdpkPRGWBCj3XT8jR8CBDOe?=
 =?us-ascii?Q?CcBmL0NyABZP/WP5v2S13QEI8dj5ySTUhCM9Zhl1y5o4fTNG1BkPimIKt3un?=
 =?us-ascii?Q?VEZf6Za7UfqszQuABAfNMIzvt768uDatYquymOPPMp206SqvCNboD2vpjyEL?=
 =?us-ascii?Q?/xVqdtyb+xbSsKl2mWV8FKHlW2c1YKzngb6kR1EUCyhQJ7l/eerFoDR/GvFv?=
 =?us-ascii?Q?Y9GoyJwoa1CUEbHBQV9+Y2zB8b38n9nPCxKAM1I0kbjNq26StttAz14ANubD?=
 =?us-ascii?Q?vf20qTw162nb5h1Cs266vIdCFbrhd3AYgJf2QyIh3D4vLd7s0Nn96Q+ocLn/?=
 =?us-ascii?Q?HGUXb0fZE7tp//nPrTKyr/wl5o6RMzFJMO45Bnwzcxbe3c4Lrz/6HB9Dusjh?=
 =?us-ascii?Q?VK8R335D3m3+pXUIbyFE9Wq6zYRUBatDAnq9JZ46nUpSE89voPKR6FXp0NZZ?=
 =?us-ascii?Q?tl+yW+oM3dCrs9356EjCbaxSnN2i2ucj3PhqNurfvWZQjt2M1bPZwDPZsOPa?=
 =?us-ascii?Q?g8/OwmeSOf0b9NRYVzp9H3u9Y23iKSfUVxh/3zWGuXiUsu6O3EGV1IOaEXOg?=
 =?us-ascii?Q?D5iFrBr6e3I4iGEVhhLugj/Bgvn1EWy6SgTW69iTEGEPQ8UwiQ++3TE0rMRh?=
 =?us-ascii?Q?Z8mXPU4WQFHuViRjpqkiMaBNkUUCOeYEjaMiicequq9vJ/LajjgvSb510SRQ?=
 =?us-ascii?Q?8AC4fozIswxydh4PObPC6f7+shCeIQpSe7xiXVcJI7rPdBca4RdhWHnVeHxg?=
 =?us-ascii?Q?FGo35jqiOrDfRJQ6QrCKRSZ16KZCvW8IWy+Ulqvtci8TruLhHEprw8MVYKCh?=
 =?us-ascii?Q?EPte5KoPdeRsf7zIWEQm7yRTha+4eHbpZcSwkxpZaWCQk3VHYgn44xqzOc/B?=
 =?us-ascii?Q?WsyDlMne2a+5ojmy/IowzVeDIrQXHf+4a9j46hgoNIpeekbQjjS8LAQN2Ca6?=
 =?us-ascii?Q?xz61q/+ZeTHlKtFdG+CNF19PdS1cN/C7ws4OItcs3yVm/2cqV6GqhOevz/6l?=
 =?us-ascii?Q?uknCgwToDvZ3HMkoBZdmwyGkhwOvHqnbJInLSs86h28cF4z3NzVoBGU1F9Cm?=
 =?us-ascii?Q?aKcM3HbizmNm0QbsrYUHeNKtdTtalBaoARQil+IY3HryXbpyzP817X3t+IBN?=
 =?us-ascii?Q?L/LOPwA/FVZj/gz98f/pXRGWhTu9COaQ/Go4ZBMIPWs+dBZ24QwN0QNKzGuJ?=
 =?us-ascii?Q?azJmldROyAmZdJTY1q+NssmfQURzRbdoI0OifdH0mEj0iUDEGivXcSIKICbE?=
 =?us-ascii?Q?fo74kMCnzo/pFZhIklsfRFmu7nfT0o1cMAIBzU4mQXeuc8r+KUgAPpXW4oKz?=
 =?us-ascii?Q?hIGmBDimx9uDT55nkBtNgH0xp/utsVFiH1h8bBV/cuItyXP/n37QLNn2ld0t?=
 =?us-ascii?Q?BtLarvfK+v06KMLu+p3VcGii+iVKWosqgEwzQGh3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba080f5-a1d2-412b-4671-08dd764994da
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:00:56.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piTQL/MlCiikRXZzxXMUQcYpryYZnvdjin/HPKuN04jDVUfBNlS/otz8TLi7ZizUZKmUMOFYDyhKjFKZmRK9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

The current link setup procedure is one workaround to detect the device
behind PCIe switches on some i.MX6 platforms.

To describe more accurately, change the flag name from
IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.

Start PCIe link directly when this flag is not set on i.MX7 or later
platforms to simple and speed up link training.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b5..a4c0714c6468 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ enum imx_pcie_variants {
 };
 
 #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
-#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
+#define IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND	BIT(1)
 #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
 #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
@@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	u32 tmp;
 	int ret;
 
+	if (!(imx_pcie->drvdata->flags &
+	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
+		imx_pcie_ltssm_enable(dev);
+		return 0;
+	}
+
 	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
 	 * started in Gen2 mode, there is a possibility the devices on the
@@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx_pcie->drvdata->flags &
-		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
-
-			/*
-			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
-			 * from i.MX6 family when no link speed transition
-			 * occurs and we go Gen1 -> yep, Gen1. The difference
-			 * is that, in such case, it will not be cleared by HW
-			 * which will cause the following code to report false
-			 * failure.
-			 */
-			ret = imx_pcie_wait_for_speed_change(imx_pcie);
-			if (ret) {
-				dev_err(dev, "Failed to bring link up!\n");
-				goto err_reset_phy;
-			}
+		ret = imx_pcie_wait_for_speed_change(imx_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to bring link up!\n");
+			goto err_reset_phy;
 		}
 
 		/* Make sure link training is finished as well! */
@@ -1649,7 +1643,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
@@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -1680,7 +1674,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-- 
2.37.1


