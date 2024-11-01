Return-Path: <linux-pci+bounces-15783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE909B8BA0
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5131F23971
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 06:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2A158553;
	Fri,  1 Nov 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAAGnrbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4C154C0C;
	Fri,  1 Nov 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444226; cv=fail; b=dtz1Lt9bh/8YszlEmCwbN0FsbQjUY72mQAVNB1aKh8HiHXy3OnA7lJFDlr4EZbVaZ4WonhE8fftsfntmxnFIEUYG1DxyNR/eyKaV7z457jftKkj2fHzWW7r92Vb2nF0XkcI77NVgrZHu9kGlwGIpuzaSQK25NR7Xexfz1aak/i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444226; c=relaxed/simple;
	bh=6bjSI6ixtgJVkD26jcLzHdro2cL3jACiYO1EDB+8158=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUj7jugtxmFdS+d+aVKo5e6MLLV86aUwldSPmOXtvJC8NjULxJdeGSHApIGJYni5kyE5V1GkAqvrBuPDpnAM75PQplOZWTJVZvqWe2VG797OjruqahbdXgEF0Us9F02eMDDPUtZrTWQp0LDE2wMAnDYckFsgFCXSncDA69pzMOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAAGnrbU; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzyxhPO08+9HCSqwJ1coU+34uGfP47BfjB1EJm5P3WdGWUao/QbYq9qQUmuyXL/Zh2bEwybc9yXiVyC40WK/30BGfy0PfIs1x53HdiN7TiQjFIzDWqSOm6ac86DbEN2Dv8FQP7Bs3cTj1f6O7u1XntKBgjJx3mEmrWUKKbDmeCN+2tmdkjiKquCDy8l9ZwVOUeef0TAmNDGqAnncv9lUZILqLvN9LXxcxb9roBEttv03X+trDK5kd/cAJvUrFpSQVDauvTg2adVep1BsNNC5QQpL/8S/eb1ta/Sk9WCC/do6AKWzTeFlO6cdLvzDDkX/YhVSinYdsZdZfh9ePG0cVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwhNL65v6k8+17D56SgrpcMwOYFeo4d2mvr3RZyVz9M=;
 b=sSMKdEnHBPh7r7Pgfj0wN4Si6PBcUkZttuigOBfLRLcedp1z8PB2ZO/cpDrEottBr0tZSivvL3zpQX7sWAj003jalcfxO4ZJIIziB7tL3WIzjaF/kA/3k/t53fRMZfnZgSonldt1ZTq5hcR/S+BngEp0tAI58BXg6EbjJJRXScbvqFujjczS3Hde1UemO/TnoAToj+anzPYY59WzBU9hmdcSpb1E+J3eOAC/vL4qMaZqo1jpMD+te+aj0zrtIlKraqQytuzyzQobCB1HjD5SqW3erzpxdUvVbAE3SkymucANC9ycDDqVcYgBYdQDDAsoRxwNfl9PBe2Q8RsD/HfvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwhNL65v6k8+17D56SgrpcMwOYFeo4d2mvr3RZyVz9M=;
 b=AAAGnrbUbfVh9kAGiz/Gl7TEH8rka/YO5Dmtf2d5c95kJ6rYGQImA88j4i+kalNzFZrfAyyOiSL1uR/S2tc2tevqThAnUoFjsDSaDcZIXEfupiJ8p2PxGNekcjlF7CwifmJh1t0NXx1rhCVM8T5exgE22tDp00QQ/AdIsDeKBI/JZkcZxNBMYZajliGwEj8vS4xUrs55JKfnlxICSKYnnSpF52qS+FIlFsjj7gCtlkgQHQAKNkZE/OngsYKt5X8zaLpCJPyKXvxCn2XPQS8BuWPNr3u31GERrYXqJxZ43YYP+st1ROsPvyiB/uph2rbeqRTfv6JqysA9N9XmxF/u+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8573.eurprd04.prod.outlook.com (2603:10a6:102:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 06:57:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 06:57:01 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 09/10] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM support
Date: Fri,  1 Nov 2024 15:06:09 +0800
Message-Id: <20241101070610.1267391-10-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a89643-9b92-4cef-a3b3-08dcfa4262ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CG/LPbDmTHrXGEECWWEzr08nodxUgIOxCxdSoSc99IkM9fJr/zpkqLtldAE2?=
 =?us-ascii?Q?AU8Pp8KSltG9ixWBFSt6Dilh5JlsUfWBescb+MhlFfHYXix+K0EjYEH5O/dU?=
 =?us-ascii?Q?Da41o1rqM/UZQbAfDq409oZRwxmaC6rd/WCP/3RVRS+xCZGbvke7w3TEX8ON?=
 =?us-ascii?Q?reNzdXxFs63V9N6GL93WyfLkA+ZTgFwFYU/3keVD6aDIY2xm4we5hlrs4RRo?=
 =?us-ascii?Q?aR1OeEFHfFpHCug5QwM9VuY3fyLnHPz8lQrchrZUMU0lkVwz06soe9vg/rk3?=
 =?us-ascii?Q?gWvud/NZCHTXoQCO6ilJ6qFu17NyC/XsVSU3EBrs6B3QFy5o0aBIH1RmUs+W?=
 =?us-ascii?Q?hFuSW7m71yIpfPh7ZrW2G7U7fhMKyshw0R0GfEOYqJ0U0VLbi0ZoeudI4fBX?=
 =?us-ascii?Q?PB9FQ64xUTAFyDfTuCNu04LrfYzKbVJs5mo8/wCS92Erv/WRtOnc3uYmAJEF?=
 =?us-ascii?Q?SQPHgPldlxkoUTK3SEwr2EMI1Kqp85xs7QeS3PmYJIT+tfT1TXmNMyi+FSuH?=
 =?us-ascii?Q?WRJV3WVoG3GpfggICtPQURTaz9aukHFBJm+6hr7A9N7D1fGYzzkOxAt7rzVu?=
 =?us-ascii?Q?qdJuLr7ITe0XStGaLHKkSjiN1ou3gkOCPUJvJLSdYF8Xll2RJbu3OTTvsmOR?=
 =?us-ascii?Q?dsuhwvvgQx1XURnc48B2XHtjagsF1eZuOTlB5SHcRvFXgLpc8of+PMVkjVmX?=
 =?us-ascii?Q?HYhxuXAjulqeIEmnCaKReDax9vjKgWj9QjZ9qPLonjU6HLx9cq7RkCemofq1?=
 =?us-ascii?Q?t+jMNpnaRaTVGRbc4V+totOXvOI2mv8AEu+xkynWVDNdrfcE6vziO6jVotwY?=
 =?us-ascii?Q?xa9bcGrI1GpfHEreMc7E1EIE+ZKylbs22B/vOauFkJdN0sW+CV1xPMe8qZ+6?=
 =?us-ascii?Q?bSoxQ4hLRKGbGJP+CFmTOuKHtP0zqwG5Dk5dTy6sytZuNpvJaFF0tLIqXGdf?=
 =?us-ascii?Q?Pqe+BN9ayZ8PYEGKVKksghV7q8SY79Z0O82gSzjXg+6J++fQHg8diJkBHaH9?=
 =?us-ascii?Q?p+nuif9DUiNIcrQ3UPmQV2ySJWAYwZC7dLQOZGm+cHNrN3tNHP5JzzScvHUR?=
 =?us-ascii?Q?KTXWqPUHPn3k6wvsbrvppDz8fDG3aRE6/P+NTJ/djvGUO5SI7d9mLya0bC27?=
 =?us-ascii?Q?Gbw14/+hsgfVuQUTRDoB4/XJgTRkxJERRzqMGfGkK0yVc43x8Zi02UD+yS0U?=
 =?us-ascii?Q?gaAfxjOgvAf0KXwFulowK3QR/QkAeC8nXBpkfROf9cslJP2JQk+xCqcDnsY4?=
 =?us-ascii?Q?WexqaqbVjuaU0zjN2bKVNJ/YlSHAGgid2ExcWcUMEfF76CqPgXJXs4q5jNR9?=
 =?us-ascii?Q?eUYbbJoLZ4E4rNofbaKQgk1ME57eaQGVSbJKWmwm83yKZ+0eSrSBo+H3IHu1?=
 =?us-ascii?Q?AxSwWl8ISWPf8H669bsowjbPLSIL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWCPE4y1Qjnh/RvwIwrZSW0vmAapK3tebF1cKEVNYBJu1eKqhXFd41WQKt09?=
 =?us-ascii?Q?LnydDu0kKDSQHsKUtLa3CdQ9v+cFjm/kNeuVAzqIXKhPefL5BTEyAoML6las?=
 =?us-ascii?Q?YXueLMLORGcNM7l+MTmPq3tinZ3z6hSrosX6QL/+zWnwF6oCWNeUBdgHmdzf?=
 =?us-ascii?Q?Z+p4/kcbvcAKGWKsv/IAYNOD7GMxOiCjZFxRdx1yamkYS7jHgw7cotfoxLT2?=
 =?us-ascii?Q?L4xRwH0Xr8CHJSFwK+0cvqneFqDX5Cru1bW0VwqnbMN5LEl+7FCTdnMd93Wt?=
 =?us-ascii?Q?FOMQEKSSHD9XE4Sthf7EWK7vp3UBm5/Pr4e27+huW4At8QFL0ZHhNsF0KIfL?=
 =?us-ascii?Q?b+/yOJaITopmvLdYUrFbSFchvH9ixI2acqCca9qjqPYZ15ab1Hm1vSGUmY5Q?=
 =?us-ascii?Q?YbtD87tAmUgSjMoGgyGgN2kc08uPOyKfVG09NYyDvVKcl6Pw2Eh9mkbehdj9?=
 =?us-ascii?Q?7Rw4hDHci+9A2Skr5nzR/Dk1f2pfbUx3M4zz0BMZWRaSpR2tPiSet9onDQGG?=
 =?us-ascii?Q?mPqpOel2eo0O2kwA4un93bKKG8tpgTzoAxo8fDjROuHMWSId2ize+pFucTQr?=
 =?us-ascii?Q?qWwjL9M4AiVPDr9U1QfyDb1utiG0vL9B63AyMSTi5vvz49XhzW53qxglnK7v?=
 =?us-ascii?Q?rOuOW029ze68qa3HIsPBrfCbU2QAPHy32c8Twgmlaeh88POxPrYf0QdA62gL?=
 =?us-ascii?Q?TXL4di9sU0kTD+BN18zdiiap9tJItuTchqXxCDvClQ3soF/LGV9cbLlSfUO5?=
 =?us-ascii?Q?1m8eSzU0SfdoS0XOJutSS1NSrjp++4AizK/VlyY1KZC5mH+HBgqEkjPHwmSS?=
 =?us-ascii?Q?si3xZhg7LmjeOOoMM0RBKZcCK7pPEtgVgMZfIK74lmFC/4nTZ7lP+W/mfcIV?=
 =?us-ascii?Q?hAlRYJ+u1UmTIBdQoUoArNI2qfF+duAV25f4kX09M7bTA6Cqnw6S8tApsXqu?=
 =?us-ascii?Q?YYo6Mi7JaVBtyauDuLsSnqC30D7az7ZAXc3e305BIrY0Q/w6PVKH8yPjwIAJ?=
 =?us-ascii?Q?k8SCNETE/df5KGolItOFKu1vdIn9CS1wGT4VVtp0XlJNhmEcWdyr848Ay00r?=
 =?us-ascii?Q?PZ5DtpLY/k8Ru9cMPtN/MJZOZK0ywOOeneStNV/4ay75854OBDucPPkJTppw?=
 =?us-ascii?Q?mQStX+GE/RrO3ZmqZC7Eozyd+ZvEm/kwuo92wdkaAGcmY4cCmQWNDCyojQPS?=
 =?us-ascii?Q?pG6mJpDRdqAQ9V3bgbh/vBMbMnjkK33H+Z68LeD3YN53iHgjzdpnH8rqLQlX?=
 =?us-ascii?Q?hZGB8UU7uOoDg0Alw3gYYeQxLvlVIimdxPxzAVJ8SVahvY1/w+BqZCIuAKpM?=
 =?us-ascii?Q?bo4GGOKzxGKchA5t5M+Jl5o4a/j/8z+XiA2ESUf8s2PooZeWA/DBGyHh2kEO?=
 =?us-ascii?Q?74nGXR/EPS7iO106aFeUc2evZ68ByWkAmHK7AI7RFa/ANW3GUR2pESHVKSJK?=
 =?us-ascii?Q?wfj3PSECsX5QdC39svRoYCLId5gVEsCbRm22RYDhEcyidVBp0GjTd7/sezD/?=
 =?us-ascii?Q?odvyGjtA7oKOtGBK0UrbbdAjn/7HDTQwNnfsEPE36Z2q8kK0AQ9AECn94ytV?=
 =?us-ascii?Q?qOJIe/xD/fYjWiiK/Cz2TFI0njK8bZ9IaZS0V4bd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a89643-9b92-4cef-a3b3-08dcfa4262ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 06:57:01.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH/Tq1nWwPes6l8x2Na5SpyJPxX16rJJSD9tbdmD7THs3ZzOhCBPJ2eNyKNMxMd52WZ9/iJHpDFBMSgAoO+2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573

Add iMX8MQ i.MX8Q and i.MX95 PCIe suspend/resume support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3c074cc2605f..cf2a9918537e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1498,7 +1498,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
-			 IMX_PCIE_FLAG_HAS_PHY_RESET,
+			 IMX_PCIE_FLAG_HAS_PHY_RESET |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1536,7 +1537,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX8Q] = {
 		.variant = IMX8Q,
 		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},
-- 
2.37.1


