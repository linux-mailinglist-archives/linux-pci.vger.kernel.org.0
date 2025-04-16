Return-Path: <linux-pci+bounces-25988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C5A8B316
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3814436C1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2D23237C;
	Wed, 16 Apr 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D56iqDsW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC572309B2;
	Wed, 16 Apr 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791315; cv=fail; b=kvHpf0l8U2dXYVZ7azEOxqkwMZsuQBRY+CwrWCKczJCCTlbn3LppOBZSAr5CflhPZvhx0Zehv4CG3j+FVtJGZWcSCkzGjHDJZZRxNNJZxXhPrd0D8tv+WjrWDF47U1q3CZmDvOyU0CGxacRIKHq1sAafRt8+jY3gkdpgvj5CEFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791315; c=relaxed/simple;
	bh=05OR7GMsw6tCcxxV4BS9S0fsZHWSm7d6m2ZAlpytvNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABgRcLgJbjGoQ0xlxhqB2A8MsCXs1/VLctdP0NukytJIE2vjgUxaYFqo6sRIsACZ2Y0mTKMCCkzOq0H0OWqTlFopfA4Itk+SEqULUG/Wi3HJXwOE4JsxnUpz0JtIE2Rn8tDAaTo+X5unZkVcxztZJseywxaEqOBadj2qT1hWNGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D56iqDsW; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMfgldExKYxc1HV0IDraeCJzN8+bEfnOUYLjVzLsFdoXpj5eWAZjJJoTs08GU96o62KlX/m0fyMk5L+/2QOl1GaJKD7Bm9bYJs/eU3UsNsvjw49WNBMGbEPMq56pgwTYedbJT7v8W0FgIDG4frEI/abnVV+aEo3dmIa3lEAetMO3S/ZEY+gTWCLLAV0EZSixQbHmosDYVOgLX2Ugvkfedlq7Y3Fvdgnj5ybgK81XldWSwGfJHc+/XGQk+YMVkuSM2mSjLnkvfS02DG0UyNnYccbb+qHI3pUYFARb/ptlufrAiGG4onNx5ykUE6Js7w5TjJY7tSG28QyzxY1h3n2VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B/lfEN7rPO1S+G39kNESf1k2qmqyvyn4LZaV7YqVBI=;
 b=shl5OYinhjFd8uyqGvs3Uxtvd6/HSnqtME2wCbWk2T98KiiWmuw1WmeCGpn5R5IFFG8zyyLRSr+Gy4pyeb5m6sjvbB9IZyQ/6QYq86uJaZmYemv+ZP8wHFCRegcs7pnFi05E+55dlXjQMa4sa5A6Yb57GGFK3AblecLJ95Z2BSw6ENWzaeLAnGCQHpoE4OucCiNrFxK9p2wUGjg7kY/5vDxWYq4+XbO0oUdixULji3StZ8hHddKspoIbelIoO/6weOIFZGwZEiEe+wobQwP/Wc9qUf9heJKmsnoc/MqzO9ooDD6BLD13mUz/hsG0puI3xw8zGEnkceUDYrLVKZ9zEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B/lfEN7rPO1S+G39kNESf1k2qmqyvyn4LZaV7YqVBI=;
 b=D56iqDsWi2pybx+O/EVefXVW79/oo8f0f0rIci9KktdIqAMCBpr2vNIJu5zhv9/E4SrbEuKx372jTOlg03gLdtBCVx6T3QLAQkB7KkJGd2cx0eUMc9GAa9o4X7S0vrZ7zwmVFYXFlmMCFiRWMr/DeWthn4G732cAAf5TyDXLdFKJYYgmK2MA57qpLRkACzmMbevI20RdwrN1fIT7pbxcDVHP9ysZiHSVdpFHdzthvKHr5cOYwNp1A2jp4FSYm05gGei12FdKojZIp3RYUH62+lgbbZd2DWZq2g5xn8J+h+X3RNOVmEWQlSIiu0BCY7/1+EmVQZDcynC5mkSc55oClw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:15:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:15:10 +0000
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
Subject: [PATCH RESEND v6 6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
Date: Wed, 16 Apr 2025 16:13:13 +0800
Message-Id: <20250416081314.3929794-7-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d2d376c-c7e3-474e-059c-08dd7cbece18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evsklXDMA8UPVl5a2YbxjYwmSq5I5fcNfP++vbm1H1IkOmskdlV8hiPnqfNa?=
 =?us-ascii?Q?npvZuKITtGerG1M4UDGiTzIxIZdo0U+LHPoIOEZ5tf+GYPOTNlp5AR3/T/Ol?=
 =?us-ascii?Q?J98w0unQN/iz3pqsaq0vDip460GUZBUXm5JKnxWC60RLuf6Gy/+1g4q7SnkT?=
 =?us-ascii?Q?Qe8p1z9Zw7yR/B5IOHs4YHB54BoSCVVrDHrVtct8lGTXfFyQVTdwJWjLX8SK?=
 =?us-ascii?Q?VPUYxAz2b/yD0Q3Hk8FqMoiVqhD0mkp5+xIzLmUyn64mSq1bCLVpKIvtKKI8?=
 =?us-ascii?Q?0uQX3hpD/fqXzz3fJw1lRYZei1P3O4QWDK6xyO+X316qS5soxvDElU1V+OL9?=
 =?us-ascii?Q?Q6XF8Clh2QhLiKvynTAW90JQldH7Bw+vmivImMjxiKVhqc/ywnnzuVBOkt+n?=
 =?us-ascii?Q?i7DbjD2gkwqEeD5vw6ZXlFQqVWzu94v3SHN+EqNwbvLh8fDSMQGs4xXYPYDJ?=
 =?us-ascii?Q?guQ2VYXtAPW5KO06KSAFNf/wT71yox0NwzQ0Pgj0XOikBHEY6TWmq/tMTF/u?=
 =?us-ascii?Q?FHduWi5mNi5IKlhW1/uzf3GydQb4QVroIh+t1knYPVo4dP25/tKoy572O2Yu?=
 =?us-ascii?Q?Ob5zmG/USarR17T4vLpkUfk5ukzKJ/etiwbEpN8ussYF9nwBeT7qoLrZX1xZ?=
 =?us-ascii?Q?1o1/Q0i7YC2JNtQIy3heZa2McB6kkzHzQKTmIUhFoocRqNUTBwrlLpPTmrlG?=
 =?us-ascii?Q?bc+b535ZNWDrhxDFkZu/pLHAGH3T2erqjc/brPJPjZ3MoZ7uBMTzO2dPsAb7?=
 =?us-ascii?Q?J0meGQrmB9t5cTy4nSClegZAFZmClXjY1F6o/0MLQZtxryU9hKvMj+NW7GrM?=
 =?us-ascii?Q?vuBJN/0cTGTokr/opvL8jsoecIdn+PoxNcpFkIey1yOR5wHY8ClayRH+sezt?=
 =?us-ascii?Q?v6VrHcP1uj7OOStj8TS9LLq1BjGiCSP+NaE0T+2J7brs5R+sjjnlRaTWvkvJ?=
 =?us-ascii?Q?t2F+2QvAm69LZQVWfr6+/BtPWl4McjViX3tQNhPHyTG/A6SKQi7OaYbfkwGg?=
 =?us-ascii?Q?h7eRwv7beBVKVgnIPDtbBGbBSVOzA4i3bmRYGUmz3G98kYmxWzioHDAUR9ec?=
 =?us-ascii?Q?cOhBNZK5dRsthWFi+fxMcHpw4nlnivf7PLq9t6RYMzs3kC7HDdXgxKm1+6Pg?=
 =?us-ascii?Q?EHzjNkGYGLh7YdqThmFRF4yn3NrwTDz9Bre2V8zcWTJQGnucgTTqLHfQBekL?=
 =?us-ascii?Q?InxOUVO23eEK1s2KT+tkNkeI9VdjX+yjcUFShc2Ql27maH6QXXDCXPYSqvF8?=
 =?us-ascii?Q?eJhqYE0LKPnZHNSiLdXr/i/gO2918tTqDvW3ejvd7Qs13ffQ8gyE7lZV0rps?=
 =?us-ascii?Q?j/p8BOYnbGV/d6dSu7NBDzaIS5Crk84rc90tMHtt83mr6euKnk/bkHS2RqTG?=
 =?us-ascii?Q?xy7rgHJVD/QWWYg63UM8w3UtYd5yjMiRowjwJvhUB6QA9syFFXP2OH4UEOCf?=
 =?us-ascii?Q?hAMslPnfFBGoI1fUTN/k7MfEes7dzwuNuBVnHg0tRZ0eieLG0DeFs5WpF/0r?=
 =?us-ascii?Q?McY7QFUcQeFo/Qg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWR7Q9G69QhGs/kjQF1DGEHgMC5DcOHrOjzzcf1jd6eXWS/Eg+dYkTZ7jBLT?=
 =?us-ascii?Q?ZDV8mANDlK5yfDN+b49U0cvj1PahITHjwlwqxIIMo+e44TMuTy6iXYX4P+w1?=
 =?us-ascii?Q?GEc0IisCMozFzE4ze+EFZbihUF/+RJj9vFjAHf+k/5Hd6BvGUDJ7/5icXlH/?=
 =?us-ascii?Q?x045i/wUKTXX+uJosFG3YtpFsb4BFdz5ZfV8hq6v9nZQDcydVt44AQX4ODx7?=
 =?us-ascii?Q?PQR6PV3SqGiflkJsJpkoqPvh2UJ0KEL76rmmoJH9Cqh1Xepq/HGSry1adHIk?=
 =?us-ascii?Q?O4qyKEQ1sCDLHzLLKG8BgJ9bQZPcRDQPdVflrpWBmPGiFJbYUuNk//jwUNer?=
 =?us-ascii?Q?jO3bUxGZSl3pB80U4C1Me54ZP5QMJRMX7DvCGitjvEcN9BIyPJugVHI9w/vR?=
 =?us-ascii?Q?iK3JgokTkD0YJvSHU+4n5kxHYsMSFAH0sBIIgK6B+qG82/qnlmkYS0RDZE/V?=
 =?us-ascii?Q?VBxgK9M2CkT3UeW2amsLBBlzpmQ4Bou0+DLHTfmokiB+o+hEz22RS7GE73Nc?=
 =?us-ascii?Q?0NE5uEV8wH3XMmS/VD1VWnEaN0YxB8QIIINsPTd3hSlDzRG1Wg4JTiEauvFz?=
 =?us-ascii?Q?FlgofOOf6beSLGYQgkdfkBkkJDewf5E7JpsM9TY6ItJMBICb0PJZDh+/tfGm?=
 =?us-ascii?Q?keYVksbB2ijZ+XwJ0FjeJZ4SgNQfASEJRhwPmCk1ZfbAUp/F3zF4YUzm2/t9?=
 =?us-ascii?Q?3jpajk5JcB/wZDPTZmKSRnc7Ouc470Uz4q4E6wTsWOBYSQqAkDo82HriKolt?=
 =?us-ascii?Q?yN2u5u4yGYtDhSf/6CQqpv2R9pXLiJBrSX4eQrMSKLRnLvUrKQ3CHytrDcwR?=
 =?us-ascii?Q?e0Xrf3RsLzdYGRY5TdDgntvVeBT01WcCCjmgNLUOOyL/Nd0YLb/VyKRQG5gR?=
 =?us-ascii?Q?Yp+OvDhZlP8e9WKQaJytBWPU2Rs575jPedSbl7lznOpDqvf/CsUDkN5Qjblk?=
 =?us-ascii?Q?7Ly4sRSn7VrV4UC8B0yZL8OvORXrNMgXsyJYtmYprwCejjHjBG55NpOw7eHp?=
 =?us-ascii?Q?/H1u4h8rURB667ZaRII2M+OZ4185zdkbm6q1NjfkFj1Q4/Ph0fMGtxdT4FZw?=
 =?us-ascii?Q?hSNQYrEF9lbvow1DZZTQHCEUFRmZtkMLy3cORIwHdSP/MTjq95QhpY1wcv+H?=
 =?us-ascii?Q?AyhfrevTJw7epT7FQJWncxezCljjnZmzvp2CeSeqcoRl/4nr0VuB0bXzL4Ly?=
 =?us-ascii?Q?jpC3K95d4JXAzqCXDuwwwbYn4MkV3n5M+xhLh5fRQtXV4Nj8LQo0/m1WZ8xp?=
 =?us-ascii?Q?KG34L+Jdt0zA/uKDB10Kh0wrbIFsg/KsGmVlQObCFajgSM5eiSokMncwh0CV?=
 =?us-ascii?Q?I5cYHrveAcHtQMl5i5RDJW5/in/3WqTTeHclJNA8bKF+Kok0Np4ZH2WwdssK?=
 =?us-ascii?Q?I70arhcW2hG2L0iMDNHOfkizREeH9e8ztGxgShXNwZRJzrvEaJvd71Co5nqS?=
 =?us-ascii?Q?gYwGUx3oKWdupou92L8GO2UQqDaQvCVU6NLFzQFmdkETd37ErBBwBtqb8mdD?=
 =?us-ascii?Q?iTJ6Qo/qJeFwwAZr7+Obii16q/5sizK2OFP7PBThUrrgfRH5web14TsPUfP3?=
 =?us-ascii?Q?yWBSWHaaOaVhiOO9p5t6pTcuXYM3w6daKUBSdQ6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2d376c-c7e3-474e-059c-08dd7cbece18
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:15:10.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7ti4VD8mEiG+syQxa3uXhKisT+CARTtTQ0UwzgoU8XXGC5cjzZLjdV7WcCSHktKDPzk48lDbjMakUNmqUnf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

Add PLL clock lock check for i.MX95 PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7dcc9d88740d..4cff66794990 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -45,6 +45,9 @@
 #define IMX95_PCIE_PHY_GEN_CTRL			0x0
 #define IMX95_PCIE_REF_USE_PAD			BIT(17)
 
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
@@ -132,6 +135,7 @@ struct imx_pcie_drvdata {
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
+	int (*wait_pll_lock)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -479,6 +483,23 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
+static int imx95_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
+{
+	u32 val;
+	struct device *dev = imx_pcie->pci->dev;
+
+	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
+				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
+				     val & IMX95_PCIE_PHY_MPLL_STATE,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
+		dev_err(dev, "PCIe PLL lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 {
 	unsigned long phy_rate = 0;
@@ -1225,6 +1246,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		goto err_phy_off;
 	}
 
+	if (imx_pcie->drvdata->wait_pll_lock) {
+		ret = imx_pcie->drvdata->wait_pll_lock(imx_pcie);
+		if (ret < 0)
+			goto err_phy_off;
+	}
+
 	imx_setup_phy_mpll(imx_pcie);
 
 	return 0;
@@ -1826,6 +1853,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
+		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1880,6 +1908,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
 		.core_reset = imx95_pcie_core_reset,
+		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


