Return-Path: <linux-pci+bounces-36609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15919B8EC99
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 04:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75BF1898E31
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750822ED14D;
	Mon, 22 Sep 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KtYVgbRI"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237516CD33;
	Mon, 22 Sep 2025 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508704; cv=fail; b=SL5LEm2rSJMuOPyKU+5oMaFfAKmLbMb/QAdGrikpDkS0vS3ggPL+dr+27A5M4qbTO8jx+rZ6+jgnifhkfbdnhO2EkxmSNn9bkmw5qiG5jBzcN9QicYN5s3lDgkUbDBgl798PAVp84UQbIpOcdSSA3LCbyGuE/CmZFbGUB/1TJbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508704; c=relaxed/simple;
	bh=DRelEcYBSkVNI0CgHc9M1uCxmeLhjhnsZx4OgU8cF4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fultX8n8SvfHlWuwoScIbR0JLbuM6HHNwVooan4x1TD12oPzuTa6VoI3/h3Rx0IB8daxjDYwLbkyNq2szhY9NGdAG+cG990DbX/BRTSlFtzkkmjjl6ZoTIrCbqpXII0PnjHQJV+IypZ8KU9reTyHDRc7t2G5Wup49/67MFsSmCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KtYVgbRI; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lym6iXRaPiybrwdrg4zHuDtp+wRKrOqj1EK+15WHUPgZdnTgcYrv1HRx5+TzDy/XBpY9p6r4sXqmktnpkfoKiHquAkEUnipRn0vnRRrMT6vtfA/V5WZKK/CVbequXWF7/ZDQVv+AXxBmZjm40Ul2jsdv4V8hDXLwTD4RNry/whgAVfvVcsNqI4ulPB0wmXVVsYHQI+3GsWU6+sXszHgSVA6m6LjI3DNBp/g/vMKXPPH8PrIoYkT5vJp4eh1vJZppko5vBe2ZX03jwGwKaeiLay3YCqQqbGVld8MyMUMrRqZq9qsKSe4AuWxluRSQ7d//9Qd/5R6Q0kQbzFDpu75ysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=cL0YMU8J7u3L8qE/FwtpJk82F0vaZfhyk9e0CbMBlhVyG4S7GenmX2YAdG9dxoZ03FV/CF1ydKYxKys8z+5+wy1S4MtSyzSinQL2K9VBj2MusFs/fmkhLwE2N4rCNie5SKLUAjxmU62fhgqKlRBT5mxxYNp0vAB0jVD5Tdc5SUP9epEmqbK7qJNJcT/89PYvpkYSX9BzDnTNJPTgpfjVl5sZfi8CgcM2YVoKVhTyjeqv+wndTD3UZjAu/9dEAk8OSAuYr6hsp/pJ2yJJyp/z2I1nrQ8sUazbmf7nKBdD0bFMTVjhoYZJ0VUBWdfBBa1Vx99PtqmTr6v1h8bEV8bGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=KtYVgbRI5Z2Bqk1T3WsPrhobGQ2q3qfaRsX4f+h3g8/H4bRTcLe4RSXcTPiG7Bmp/i6LY2oHMu54ueT+uflk59BRzatbs7s/M+fuS9Hndjzf/B7EKIiYWAIsGv8knLvDnovwQbLZRkMMRKmE4/veeg2bALytvVLd5EpfuNV3QfJ2qtorxrMe3yZ3K+6b+DI5Xabd9HpH7U++9IGrMa4DhC9qhgqJicSTrt8DhUsNfcsurg6UkaYZyoTFYgQf83ZsME1u7f6iJnaIJ4Kh9cCD3VxRfiZ84CuhVVlnNohSCzmBhE1cfqljx1KNULapSGFdsco1Ym+UlTXPJhAVN3pxow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB4PR04MB11280.eurprd04.prod.outlook.com (2603:10a6:10:5e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:38:20 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:38:20 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
Date: Mon, 22 Sep 2025 10:37:40 +0800
Message-Id: <20250922023741.906024-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922023741.906024-1-hongxing.zhu@nxp.com>
References: <20250922023741.906024-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB4PR04MB11280:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a2f792-f32b-4fbf-dae6-08ddf98117bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0oYp5O2/mvJMWZtkdUMKpGKW9y8fUF787yCepv66y4w9weFUkCzJpuqhgP8M?=
 =?us-ascii?Q?uagtTiCLAlHJA4UFOgdwciTHlGKecNof5NCn4dkn/NZR1STSEDS4BKf6d+LN?=
 =?us-ascii?Q?s9BFHdC+uwKAzOwI+ZAvCNc7CvrOj7vBhcc0jkIiyY6Z4yPdq5DDNeIt7Rrm?=
 =?us-ascii?Q?FSuQcqoV20v+fljzyIrArNkIp5CueBZp92f/WOi2E6n4pf084vVU+Oy9zoBz?=
 =?us-ascii?Q?RRqOdfRppevlBZRHP7RfQ7kQu7V7qFZUiyq881wUsUOCcJf4kKB31FVwWpAR?=
 =?us-ascii?Q?ss4NXa9d8Oa4Xt+6iCSOuXIQQLnhYIlHF2hTe2oDtiZieotDKz272MHeCxm9?=
 =?us-ascii?Q?6bk3pjpR8CYsAb/h0cCjM4I9d6OC5MdiCDM2bQyOTtMTMDBoBrUlsYweDg6d?=
 =?us-ascii?Q?l12Wb5w/wV2MUxsIxVUhtatj49tX5zsKK3SH8/a9UYJqWiWmr1hpjLmObGGZ?=
 =?us-ascii?Q?NOryXp8ZvSbl+DHA54nxO+vvy7p6/a4ED/zqvmxbkrcQKyZuZs+uyvetYboa?=
 =?us-ascii?Q?jT9VxTVVfQJZjJaxvKwWw+SKIvz924wbe4AWE9faLqrFjMIq5grgJpd4FrbD?=
 =?us-ascii?Q?ZFR3bVtLgPs+EseJBfbuw6/0oFWbKo4WsfISDYoYonkcxV7kZLKgRHClbVVn?=
 =?us-ascii?Q?pBMwOlLaDjlurZtzmMW9prJ2N+yeRCSZ1wsxcn7af44NyH/Yq5VRWXkgiSbO?=
 =?us-ascii?Q?eiaHYB7V0VkzekMNDhEgdKC+yNIfDWGavjKfbfB66R4yi5Pa6Mn9YLmshYip?=
 =?us-ascii?Q?vOj7qHaKttT8h4oDKKiVWyK8OBLHPLYXQoYZ/hvIhoGP8qlp/7KDAIUDsjsx?=
 =?us-ascii?Q?mcCCWKlXROmAHc8/In1dyLkb8QFCOQt6x9DQCF5WKzV0qH54EoUTDAFW7Aa8?=
 =?us-ascii?Q?DfW7ag3YN6FcFtxm7rZDkmpAfA1mXQxQ3AwZcQmi0We3iCZofXQ95baX3sRr?=
 =?us-ascii?Q?eyEoKlcMpsEzCUCV3W528/mmKX9x1Yz2K2yOgnj70cyqLZNrMt1lmBtB8gMc?=
 =?us-ascii?Q?dZ00u6uKCvdXhOzZr1GX8qSJTp4fZ3CZVBsReYO/UBgN5tGPk5YByZ60nzdH?=
 =?us-ascii?Q?xAm/8zYLNE6Gv42bHw/b4ZYJcutIsBHi1XQ5vwGVhzlyY6iO17kBE8grDMV+?=
 =?us-ascii?Q?ezDKrrvffYGmeELFPUViBZ26gI6dY/txlLjH/vaxeTJQaSUKSZKvXxX+U/BH?=
 =?us-ascii?Q?98m8+zeBXWZoXmlAXVhQevBF0N/gGBcsy4yFTGE1fAu6sLt3dtLatkWg9G9r?=
 =?us-ascii?Q?foRKLEwKMzxEHgT5KlXBkCT2pAS9DwDV+LmEDNJy+48RiSqN7mndLI3vFfHy?=
 =?us-ascii?Q?8xXqCWXytL51HHFTDECytiJ4J1oxInEjOatkWmokuwbhxc6yvNorItHN6GAQ?=
 =?us-ascii?Q?VkDR+HWAEOSIeE/CHTjkFreuEwn+HLYSWVFIsDtBi+Hv5oY7gC3RapagUiDG?=
 =?us-ascii?Q?LdhHI41VBfC2HLw49Jltlkw/vonG2IwCpke6NeB/cAJ0Sgvd5RNJiIy/fpoj?=
 =?us-ascii?Q?06UN627NuGP29SU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gMlQAqWw+0UwOHjqlaz63rAwzO/NKX6bFa/0swJ2QR5CDViP7uKZ078WIYI?=
 =?us-ascii?Q?yUySMwANns7qPJUVOJYvBbgOHPxOfwvnWpEAc5qeoP779r6YdvZdaxexrKjL?=
 =?us-ascii?Q?t0/gUxoTjdFRCo3vgyuVJg+DK7VQ+xT91YmytZeLMQRMXWKAgY3Mh6zmwDbG?=
 =?us-ascii?Q?meTGwlsRjT5599Jeh0EcRDzruYGSX6RlQMzLv2ixzEKtB42pfY/amg5YubTv?=
 =?us-ascii?Q?mvmluVWAkTmmzvsmYqOimraKsdKPhQ12zx0XsFDj6CcZmfvuLCOalAmVeDs/?=
 =?us-ascii?Q?PK27C1q0TuZIdoF7tC2d/80solqXHEbQGkVCw1Nxp/LtifsqDDJLkiaoy2+t?=
 =?us-ascii?Q?ynUyaxBSDH6d3Royxu/1tzbwyBtw6fP6UkOZcigPmBYpYSJXxR1u6hJeuOCD?=
 =?us-ascii?Q?qFcRMIY+/bWv0/Kg9DqPD2ahplslzLfYv33kNuk6c+8gE5JWkQXpuxJ2GULT?=
 =?us-ascii?Q?RCCkcV7W+7fxUCgFs58O+oitmKRXFaIoqp/UfDBUuroipjHTmfw58c/Jtru1?=
 =?us-ascii?Q?q6/5D6OORb1vP3XgrJfPY8EwhAQEHl5Y4JwGgvGCJJlUlt63nAoSC3x5fVWC?=
 =?us-ascii?Q?tVS1ygw3VnuTndedIYrqP+LbvACOzQnP+IAfEG3s/vzqGMHvMhP2zauSo4a5?=
 =?us-ascii?Q?S5Jy4Qz190+db4HKDgMr3qYG0PgzKxBEbhsYlM/nyDsK2iG/EsBivCMyt+Sc?=
 =?us-ascii?Q?j5Z5Txod1f1CSAThHqrMUxk1nD9qETPU7447K51aj9NArHO2RE+jG+sq9ILK?=
 =?us-ascii?Q?kYMQos5umkGyIC7j5590anhlblfqA3ckKw7rl460BMXLlhDfEy0H+bayDdVG?=
 =?us-ascii?Q?+L4BQGUYo/vEgqKB+ooD+cFy7nUVUYTGUy0RpvidR0GFjURStFsOzuUScVKt?=
 =?us-ascii?Q?SXS/A8gt5P5UASdLfDvxg0rNNBecpJHljlLCHavPvi3A+xG6guibxFKS7P/z?=
 =?us-ascii?Q?jYzapImVfyivVZbYYgbTvI594fhhnsaYyeUoBpVricQsu2P0hdRXwW1+1+ky?=
 =?us-ascii?Q?SvOuymxY8yXMYnoSXyrvctyuSIIQgCEVlj+hKQi4D8AQUTU4/YNNDjXRqv0t?=
 =?us-ascii?Q?zWv6UZaEfbKqoiVrBr5rcjBjXg6yWqcWqa1GROWZLH32BMP4Pe1RaJJX7/j7?=
 =?us-ascii?Q?/AUeWeZkdK+51Djb97jwTtrL/1hIJg/xsHLZy153bOouWmC2GehgyvrHVFA+?=
 =?us-ascii?Q?/yg/kFS8ViBSeF23Uk0en6XfU+2uBF61t74kvVV2GgQiY6c2BrTeoS2uJfKM?=
 =?us-ascii?Q?BMx3gaUzr9DNKqrye2k6t72rfsijCQWzm8agqTArCsAjn3lodHQ54GoUtFCL?=
 =?us-ascii?Q?rXJcEmy5z96/lDLpK8QM0QXHSliwT/fTaV9pM0owtSQgn3sKpzq5PMYTc/8p?=
 =?us-ascii?Q?kOi7Pfe2daE03pz56Y7kiK1IqaGR08OC9+QkXAfNmMTEwqHEUkUJvWbsiX6l?=
 =?us-ascii?Q?QSTm2qmPXNaTIeMD42PDQe+8LyJzmSxOlbq9l1r8rLbwO37FuseCK/8bycHM?=
 =?us-ascii?Q?vkLP9p5BtaBMQUH47dXPyfhtbI0hH6qWFTk2BRKMsuov/JoFxff+zA83ldYe?=
 =?us-ascii?Q?yAgUNqqztIKz4jP/+SwgPQduQJ/paSDYmvricADq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a2f792-f32b-4fbf-dae6-08ddf98117bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:38:20.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKF6M/B9ns8F3iXIHRVR7KkqVeLH6j4PEpOfIDDcLvEXZYmw0ApDrugd0bitwQhTYeYYKFdfC8ib/v+gBXXkEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11280

If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..f24f4cd5c278 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
+	if (pci->pp.ops->post_init)
+		pci->pp.ops->post_init(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


