Return-Path: <linux-pci+bounces-25205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB07A79B6F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C2E189191A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60128199EB0;
	Thu,  3 Apr 2025 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NuFNKNoS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CF19F40B;
	Thu,  3 Apr 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658865; cv=fail; b=jX2EujccTzqq8YKadVnqLAtkV0QCncx9/lzKXD/IXcWw5KUef1QpTDILqvbV3AJgC0egiK4czqTgdJjpxNDtGtRPwyjzTicN1a7d10TtuFvT3Sd5TbKZVdwCsIVpEW/2ONhAUCBiIF4GhW1QkH30mdEMRvQ1TlWiQxYq5r66gpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658865; c=relaxed/simple;
	bh=oyZ75HMd9ASjhDC15EGovwg0hscu6DB2Fzaj8Jxm0zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXAy+R0gneduJazdCFzJmT701wDjl+VDz3qQK++513QqjYiRXJbSIzQ0oyzgqmnUbAvyu5fDgFj4bYVSRT0TO7YNrcRShXsZjcimD2Z9ZxN5oCYDFYpOYCi/DynXzgJqdTyhSy6pvPNu9vbcLAf1WfslTYwE5MXzBxZpdA7cNI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NuFNKNoS; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ2PGlmnRC8/a6Ec8bSJnZWJVIHfWh6GnMqsa0MBwJMHyydnrEJT8fpHbXD+vVpJMzNbkiykFMLqXzgXiyFEdZY/DBsR1Kl/U28fuNtp8SYsp59oLqMaARy+v2Gnt6xXo6kj64OOK3d0rUPbJZSFHPTJ+O2grMkf6UH2U6n1vNcuvLMn7fw4HcO4Rw/fkzI+bCb+rLLl4Kmn7wrvcx6cgzNbR9geG+GMLBSpal+x+8w2NE6BfaXVY7n6VKPAwtlNqABsL5zawYac045y6q9IqohNGkBEfxCZaqvRUS2P97rspNH5doaYIvpkTy7iq+ZV2SCMfbUMobyaInkTIJbEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOtK7fo6MbkGRP68NZXTNEWJ4mxJmvpSJ47IKPnT7jU=;
 b=S2yAyWyzFTpazYUt8Oz/Xhr7eA0azuuW6kUFG+Ar0HUpftKGVrHzhoJ0dj8KH7zJha8YnS4KBo6vVTJ51WiSAO6n95+1P2Rjir/9fvYvMJB1qOHktmjP8oW1BtvCxy29t/2Td2fcL6J4BWBqe9j+wuuPcGJna1sKMRbD4ZPLwNk3a5fguL9I/1g75d0AThtkcFVp2RU5RUlNtJ1BIs3QlliLFPczcSeC0h+0wb2965hoBncyqdbNXku5SHFJNGZw6f/DdSn58lgJXhoC6YEfGPxnPvFmLcnHd4sBIOPFJRbS9WVTu3WXkF0HcBzaZP77s5AC1gp5UydW2Z25iedNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOtK7fo6MbkGRP68NZXTNEWJ4mxJmvpSJ47IKPnT7jU=;
 b=NuFNKNoSe34VXSHtL3iop3JBKh98+Amv8oh9t5g6/4/Z8jev/Gukz78A3zFAj7dYiQpfUc6+c3RBCjKtjTuT2olWfX34NtogBdMAW+1g3DTm4YHKecPqj7ri49Y7bTaoeTTuYip6eHaxVXleOelIR6AcrgMTxQUQX0yqwlds0YNSF5OQyTDUpUsHHeSucXzB5KTexwDjekx9DP+ZwDQSPnR/FeSBxfBl0VsQliVORqc1mm4/Ms0ntvg456adWo1UwJISd6wnE/l9vIa6aY7qXyjoRtRmmVir5FMN35YWA8hxT2zv+wILgVVqcqlPzRTLQbyItUp75itC2I+/uSoK6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:00 +0000
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
Subject: [PATCH v4 1/7] PCI: imx6: Start link directly when workaround is not required
Date: Thu,  3 Apr 2025 13:39:31 +0800
Message-Id: <20250403053937.765849-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250403053937.765849-1-hongxing.zhu@nxp.com>
References: <20250403053937.765849-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c8ee6-26de-4902-2645-08dd72721d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jo7H+QqKRTAGa0Mg/5qZ3wECSIyKudHxYz/iypHfucWpRihqAk4xU1zsyqjh?=
 =?us-ascii?Q?UDy1qs0/wkzan2Ic6gEVJuEMhzv84r4Hz2j/bHpkEODAgZL/jE/sxVKbKyEt?=
 =?us-ascii?Q?TCPeLIYLx8T3mVzJMpUkbIp1vyZ1FL/hNtv7GEIPc1xQeaJNZ/oCPnM8ZBox?=
 =?us-ascii?Q?Q4/D77Y9e4NC3JaFCiZ/gHiRdqOnYkF+eYzMyNXwyDKwt/+K0EztjwQz52JN?=
 =?us-ascii?Q?avE2wDUWGvHHF5kUJ71QC5w7navgCgXEO9YKRPH2mwwLznDdJJQjYNo5diHJ?=
 =?us-ascii?Q?udHSrpGSpzh6sK+ZO1wYqCXrZ+GWTYxW8z9OnqxGZki72syPdEBbH8szHuE7?=
 =?us-ascii?Q?py1LA/6JMu9rWvOnENcd/wtYqyQ1fz81SIFwrEFChgsceTY/tazLEBqVTXJ9?=
 =?us-ascii?Q?VRaC8K/l2GeS4nPAyzq9J7RFX8vA7LX5YzKuIFBqpECTWjlJTgw7ml4gpiCg?=
 =?us-ascii?Q?BQr+xj9/ANI+8tKJDzg8+EsFb37QHHy2Bb2LXoWuvFBTq9esJG8mlL89e6Or?=
 =?us-ascii?Q?3bL00iPjPOF3YiqZIjumdv/WBGtWr5QNKOBlzqGIGSs6MkKQ54RBvwgBBu0l?=
 =?us-ascii?Q?H/Ik6HWyXHyf1qGlRA/lDoTQFUbzv0Wp/gthMlNPXWu11ZgebDtal0oY5jzt?=
 =?us-ascii?Q?ICXE4mPGYc20qawbvSEN8vWOhDwRJ/VFEN2Fn7506+rAPY33GkZN+lkVLWom?=
 =?us-ascii?Q?PPNKsXHYcTCKQY0LSmvVzq8mf1G9uTcAq3W4C/PPD2BYveHxWQ9yjCAVknmT?=
 =?us-ascii?Q?iueEvpSTBDt1UXsy16PGkAIJYFgiDMvLhDh4iW0zEkEL+I3+6PZ99onA91WY?=
 =?us-ascii?Q?xZnqSqEdRYCshNBvRcBBh0QiwCOAMRXw7AUeEynpYLJXkix+biWBUWWTPo73?=
 =?us-ascii?Q?iXZjkLm1MgDUYJUQLSajW3esd/cPWrtX7zSkJOCLQWH7cHhrE2EkISy0sqlB?=
 =?us-ascii?Q?uT/0HQZ30mYyNqA6jqCFLnDRwxu9NqFMxLA1Ks0v9qv6XewTFJLGL+CQ2ayR?=
 =?us-ascii?Q?iTJNwq7KzpJLiHpSb/eR8iitwgg6DbkTb2sJBUoH98nLdx7rX8D4Wlo4/5/4?=
 =?us-ascii?Q?HwXYFgqV8dirV7WPGyJMK8tv5vzzOE+91DSiDhei9+plczqkfAzdQPKCPmRS?=
 =?us-ascii?Q?wPgxwYR5SWCYg3OyiGMJvDqM7TxkRiGhelWyvQFDYqPnoffrTu3qAu73eUqK?=
 =?us-ascii?Q?aryvys1KF2QPJl2Hg1eG1wNpwvGKaVLNAY2soIZG6CRQolVrA2GWG7CH9KNP?=
 =?us-ascii?Q?PwHxM7uPjokiLU1kmfx7hg5wgdBjV7OB69OhGZGuEVSvBwDzDEwKVQPtQqPE?=
 =?us-ascii?Q?+m97SqwWsgJhviD5zpVuJqT6ITyZQWZfO9AmFMCIA0gSQPlqap5JBxC+WFCc?=
 =?us-ascii?Q?utqErkGQj0U/2vsPOGhJNKo/OVnqsp+ftVXkqj3oLiX2YWMxjwDioslErw8I?=
 =?us-ascii?Q?IT1fdz/+S1ydhNkKmEcXYwyCyiUVr1uewl0AesRuhKHgbFZyfZl92A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9xAsPpn/oYUjVI5H1f/N3yHwrxgpHFR6o66NWnacOg6Cx6RHWQtujg+XlbvA?=
 =?us-ascii?Q?aUV7Qpc8QpdkX6pNkc6OfebIDLJh7WRMr/eN2ihoiTzRS64lviM8iWV3ooBW?=
 =?us-ascii?Q?K6hSRyVtIERZPngb0ZWb9a3AS2rQkQ97scm1nVeuxbhXA/iebpBAcmc49ko9?=
 =?us-ascii?Q?zh6dxLe3Ut17ii2Y9EZIIWEBsHdgyzAVGM9yc5g77aWabhpSaKxSrUKCzdtB?=
 =?us-ascii?Q?BuEkipoEgauMtsX9tYJ1f6EIgCi4LTK1PH+PB4nIvcas/v2CJmKpGnw/V3rF?=
 =?us-ascii?Q?qwyWaM3XVZv2FkN8UovjjOQDCKjtvXvApiF/dwJ9r85HrvTA1UXFyFzBynPf?=
 =?us-ascii?Q?lsj6bGG2DuNobAaslczhaQjGNJI2Jj+t+ZMqj3uLs9E+Z82nY/uNzCgVd0pb?=
 =?us-ascii?Q?L5fK+85JYBVaVHmTgqIIiexM0J+tL573TqWZa0ryESMy7ovH54zYhkqOfj35?=
 =?us-ascii?Q?qPiloZ0tVHUehOrxwmQxIybNJY8A0zJjVQrThq+Xkfl88HV4urxNmdGRHDo3?=
 =?us-ascii?Q?xDnx8TItNRwmiS189gjwjpGcNRlNZQvoiJvfyivcwEU9gHkECQ6hKiQo1KPb?=
 =?us-ascii?Q?9hsZ+rXZF0Apl/wUtsAf4K1buuZjh1Ai1QNPskcrLcnuwi8qvBNjv4r7z/gp?=
 =?us-ascii?Q?Eun3bHZ65lbBBoBK/OYyH4XnKY2bYzeGJLaY314RB2lhhz9hxwA/t9G0VEDs?=
 =?us-ascii?Q?r0RS2DbWurAox55bFa5Z/Upe3MXFx1/C50m+9zTuRaOH1exQQC5Zfw/tKrhv?=
 =?us-ascii?Q?f1IjQrCAC2oO7Fjj/EzIK5h95gO+PdPRp+Bim7cKK369iZL7hyqagkUxXwa7?=
 =?us-ascii?Q?Gwgw/9RBffmlb846UJmTcSu08f3ELiaicuFWRPwVIgOBV/6jWLhtsNGrpxXS?=
 =?us-ascii?Q?eBkeJs5tNkWdRj1hp4VCxFmL6TAls0UwdRVzddjdLWtEMnNFiP8eOCkOhJRl?=
 =?us-ascii?Q?POf91ZeSjQaUhRoawI1CosUjcRjG9QkzsycEvuZosu7VnZAbS/2bGsa+AjgE?=
 =?us-ascii?Q?pxevyWNVotUi2YyXq3VfUUska49HlI+YcqCEkOdQQLLxhE/ZTNoo+2xXtYtn?=
 =?us-ascii?Q?Qysokoft43/bga3qlaxW9B1EDXdpbU6ysbLRS+LEqMf3DB89tXR2lwwWDgXv?=
 =?us-ascii?Q?DyUjDfxuPPC4zLspaiGMdqmMLjj+II3NTJn60/WcZrYrfTVaVu1y+zKNPZSn?=
 =?us-ascii?Q?V1LV39mBjKZ5Rm2ox5N8pPczH+hfKMBF5OkGIbSSTv4U3RofIusX+wIIZMCl?=
 =?us-ascii?Q?YZKoANdWxUy5/hVbekAVFxGFFooPgdxdCN+n/DKfFl6ZQL+FBGdQ94oKln0T?=
 =?us-ascii?Q?vfLYt1eJpJFnaQvTXbrNjgMFOn+hkHER5xJvh3uJvkGVE6u/DTzqswCggGwh?=
 =?us-ascii?Q?EigqsaqwSizsTItZb3oYoar4nHzcVLO1tUVehPecT4JZS89Tdvh+TaAWmBw0?=
 =?us-ascii?Q?pATClBp32t5Ez23CLuuiAvygJWOFXD3LjdNVyb1ULiuGmp7j5tNaZpQlT0Bf?=
 =?us-ascii?Q?7nERqLRpAU8TtED3SfcZHPpcWlr/tRLqxnQ1sHXaxjXV6gfqfcXzPq7eKcro?=
 =?us-ascii?Q?fHRZaLzDXwiFGCz486YJs2MjoKaDBuBRaPPSQ1mK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c8ee6-26de-4902-2645-08dd72721d97
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:00.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdbZuyDzjRrUiZAKMWhMCyfXRy+NoL3EcAxfDO4bfpYnBKuHvQ8ylOegA2GeUARILR5aQjQnjTdB1ma7MrVDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

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
index c1f7904e3600..57aa777231ae 100644
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
@@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
@@ -1681,7 +1675,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -1696,7 +1690,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
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


