Return-Path: <linux-pci+bounces-29844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DEADAB56
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 11:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CEB170F6B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B2273816;
	Mon, 16 Jun 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IWKr86Op"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012021.outbound.protection.outlook.com [52.101.71.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA0273808;
	Mon, 16 Jun 2025 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064390; cv=fail; b=lOKjDPhImnSHyGcOB/37G8KDNvYGwRd+NY8v7cATxkNbLBqwK8e2pc9SfIvj1WnTqonxwVYgqIlevoM6ucffWaUM4CrGjf+yzZS14Ax8pSSSg6Lqd+WLLOoXk72aesuIafiXOzqTVWckmKwVEpghJGCfc1Ueu+N4pvKN+1DdEIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064390; c=relaxed/simple;
	bh=zO8stQffc+HpUc4j1r8Fe9c8zTeYh4YqSOp1W/7Adng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBxXUPnRacEZGfFqJiBaH5tFnzwLhlFiY6BPgq9CJOQE0lSRF0NoqSsovPb99Q6B1sMfoinbq1mIa+m4OCrJPey2TIwjT14s2QjAnGoHKgdDXhC2HRHzZPTpZVVWDQSi3krK9MGEJllOQMivDcNTkqhfjG/SGcuEYTl8swOJcuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IWKr86Op; arc=fail smtp.client-ip=52.101.71.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB3JY+68QXUgAZB1rbEHRJFLs4LePVEIDYHVEWFT3hTWmafi61MCYYxEawyhNzaHNqAGp8FNvecY9gBKfKBnFE+nIFuo1phPJWJkVznGwwDF0r1aGp04nGxonG/GDmxPCwSlx0qoUioyo3fkWdQ8xCQ5EpY84tKzHl6weskCFQ625GOsbUdoZGED63AMDK4yFS9BQ8g5tt5mmcI1DDdetTKIldj5zQtdenVy0rhH7itC5DOpi6/HnLYDf2ohFf6oGDFnAvsBBLLM1hWjkV/XgmUnm75MUq3EZVFeiZ3T0QSBjTPSd3wJ30hTOOv8qN3jf9Q/1migrtQVg50sbmty1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+ZRwaaUaSZTy0JUpYgOSAB2xJg99nCjpCfK0kRmCqw=;
 b=tKQZXIcSAJzqHk7pgYGggH/Uh48pluieiZhErTJ7adYpPCPHClkE3biUEIMhtwyYZPmW763mQ4nFmg9AzUMmvZg0phYwHoMye8Or54/RnH/Zfst9eyuYLOwAMpGSXKqHt1fy9gPCBwruajlgfdC2JaV/bAMpCZni381vPurvNxIJ2E+E571PRpk0fHIly/SRJ5/R2RxfZn0D+PezkE2jVFQTspq0C/SvGsMLFT/z6W8YIhnM4y1HzapMI3JOKmcFWHekkf8tAYtcSznuj0cagZ76n7BOaJMHLOAHBp3QQ/ymVHXAoyMenwB2j0izMN5KQRxZTsaV72A4sMUZHMaM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+ZRwaaUaSZTy0JUpYgOSAB2xJg99nCjpCfK0kRmCqw=;
 b=IWKr86Op4dgDzZtU9dGkFwgalP8IfT94hdcXuxDvAQl3/eqlof6MnDcr7GQj0Cu6fgfGXx1Y5O0MIcOkinozgxI6B8TAvCE47b3Oi5TOrZXJOUlFKSAQPcF9MC2PxTl2O7EugB2PreJFiXHhprjn7jXQQ3gmmLMZ9NdEeV/LwXcaGEVnSI8POr88iF9UuP3xPeJXDALEdqSe282nAKGruOZa9cetfgvpFM4wpnfcdo3v5hFaV3luHZybqAIU4cNKsHW9hcND8QkPduZwm4BXswqOfRWwG9AiQBaXdmPGJFo3w1pzEUxERkmMjcViL6MRM2MCTF69EsWk6rzOFZmaQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 08:59:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 08:59:46 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 2/2] PCI: imx6: Align EP link start behavior with documentation
Date: Mon, 16 Jun 2025 16:57:42 +0800
Message-Id: <20250616085742.2684742-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b55b26-e5d7-434f-70f0-08ddacb4242c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PpxvCKIcrZHAoQD40Lr2CpOAqNURIu5Occs5I1nQL/M73JmxPKHg5S64MF5v?=
 =?us-ascii?Q?YTi9cQjJIYD7aDn3sA+ZLuFe8ad1ZJhMXH+sZ859Fmpjkmf7h4z9TFlTvTXz?=
 =?us-ascii?Q?RGQfWE5aBB5DegIeWsptrMeQdiiOFTQNix+Zn6ckCYPP9wty3a6cDUJe50RP?=
 =?us-ascii?Q?VYUcJvfJdhFpHqqVQ3CN4MOKB49OYqvk5yXM57acIfqK2V5iQU7nSBV4gCq+?=
 =?us-ascii?Q?y3b3P0FhDAuO+DCrgGB+go+D0966w4ChhZ2qxNlwUjGcHcqIjv8hJKG5Cc8Q?=
 =?us-ascii?Q?/1TvnDK+q8ayqd7SMRDMWKb/MEZkbMbVLFuPizDMuwPDwlPCcOsgvcQ/k/Aj?=
 =?us-ascii?Q?5ILlfb9ZutKDh6SDLlTtp2ezhkhKOmtTJmN0rs6GARrg13Xdc+8FtzmR5i9z?=
 =?us-ascii?Q?RUvJqFG0RWJ7BrvFRUPYQHSzcjHUWUpLRiVzD4afsO7ZJq6/fRkAXh8jFJus?=
 =?us-ascii?Q?TbgYKUf5TNfc87gJcQAFAGffpQXMMHcwus0qW2+soT6neb87OzB1hxAJoEGh?=
 =?us-ascii?Q?1LZoZXaiWNipmaXLLbavF5WmcdFGCLu6CfaMnMrZPw2Wkg9O3ZzYlYUS9Lvc?=
 =?us-ascii?Q?kF/GIZw/wivF4YiDS22fs4DQ2ZZJuBPlQH7THtf5sG9at/W0b54hJn14WqpF?=
 =?us-ascii?Q?fgQJHjaaRbwm8LwqPzZO/l59uUkvtVfwnEPjWHaoi4TRBxHFE7ZQA26//cx8?=
 =?us-ascii?Q?F0smvCHv/+gMV7byVyxLluj3lZiYvgCiC/JapeR2Vny1kGfD+8miTeK4dRDU?=
 =?us-ascii?Q?OR/hbetzbuiB/O1lt4OnIUcaWxLuXJjTD7uy53gIVKMgLuX6cPLnHJsBWC+9?=
 =?us-ascii?Q?rJhYIc9rnlc37tGWTMlKX4BRXcjTSN6ykDQ5kcc2nDxV9eHj8AcRPpxfs+MD?=
 =?us-ascii?Q?71uZ8TSO2rK1csZ2vda3Fhz38XwHF7dwuIH8xLpJfQl6cocm0S6nV9XXqhU8?=
 =?us-ascii?Q?y9EG99qzfoRHGpP0j+5Z+qvWNvrdAW0iEeDpPEd0cZNJcDDHOlulF41GRrRj?=
 =?us-ascii?Q?IpYC7oErPNKmm4ZNaAHuhKPBM5kDo4UIV7sZP6ls6ac392vc6Jp2iwUyvB3/?=
 =?us-ascii?Q?AHJXIAwjBKp/uFXxYHxONwG2TR4OBOZZZZ+CvXPAxxXpfaT1BbPZEp3q7GMg?=
 =?us-ascii?Q?bgrKc0xFdRNBT0J4XyY9MdiCpOpe5EEBvecYcBK7qcY3ADl2Hbtz1EW1Xh1c?=
 =?us-ascii?Q?mV+0qu7faakIgZah38VPsLOik68mfJowLZwYWwzem/cNczXkKFKADJUMpZeC?=
 =?us-ascii?Q?cd9d/gbXxPq0R+eQQFzz89ZdI6lS2w5TpQrSoj2O7nWWdpYBNlFWfRAYmrC+?=
 =?us-ascii?Q?E1FhuN24SZNYaXoYeoJ0OWK8MR73dVrL2zkAX8If8xGNoUDZhJ5H4w6502v3?=
 =?us-ascii?Q?Wasq/cE/q/ZWXzaNMGx7xCzgQtF/jIYMOlnMy0VpsQdYw4k+MSlh9xIKBRRc?=
 =?us-ascii?Q?AoKAOkx7FJ/Eg5ILZd07+Ds6/CldFat2yR/rKKIVhD96XTCT3sQbJG9VZB0l?=
 =?us-ascii?Q?UD9UpHphkS68Tx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vh0klUKQKDjdhMvdyqEMBQ8L0a8mHn0z8eOWsqFHv2x+Zzo/Wluc/d888Gh?=
 =?us-ascii?Q?e/uWyiTYyXrhjPMzrP7yJ0naxcsUJpxiET/BaWQdkVGSibf23WfsPWMQLy2Y?=
 =?us-ascii?Q?q+V6zXhl/X0TkpFmkO1dB+UiAvE5jJuTajt8VQZw903mx35ciYt4rdmJIUqc?=
 =?us-ascii?Q?n9lI7fk/IVjmI/Ii6IiEp2ntgdCz8uVyRkjV+5UTWvS+Xwylq//YIRWOJZje?=
 =?us-ascii?Q?vwXsCZ12uBix1k1rUlq/VV1KVRW41+2C0KxNb8wY1ZC+ToIK7SP+g+AXZOaN?=
 =?us-ascii?Q?N/XWR41LK+d2+SRw2epsPOJYfxpIySFFRSU24JaNhcPYp9Pc9LG5Z5Wye/Hs?=
 =?us-ascii?Q?tres9lxHJtvjRDOIa4oa4PBLw7cPyWeVMHO/2mRx/skADsZ4/d2ATSD+Z3ba?=
 =?us-ascii?Q?d0oWrJMQ3YxQTEkYP+warGzoeJ9PhyIZ/3F07BkX7Nnt04JCxMJ/LnJe/s5N?=
 =?us-ascii?Q?1TN2QM5IigM34LN/i9dYbY/0Y83uSpHQUqgF2tslcp15PQk78FmoZdgCv+Bb?=
 =?us-ascii?Q?TKG8Ru9qpakfqQHQT3BFjy6U+T472IqOB9F5d9yGVTPSY+qOcGppxTA5tYPV?=
 =?us-ascii?Q?Unmd7n+byOYUX83tVplze04nzogFvK4SeoZJnfqmNDoZoVrrYSjArGn0rb6N?=
 =?us-ascii?Q?sKP0FThxQyanaz0wKfp4FNwr3ycmII/jMzXk4dY8gBVjU5Xh8QtRJcDvVw2t?=
 =?us-ascii?Q?ZWonCD4FB9DYZtxeBhZB5Ttf14xM8UgLNhWM+c0hdlDq4bACXHqB1WMOa25D?=
 =?us-ascii?Q?pIBv5/ILecGKTgOwl/1N9qy/azGx/j9LMomxo8C724tDMmKHh5FxW/y0Sson?=
 =?us-ascii?Q?SrF8wwI+pEKoG6pXRVgrNT3kZyPBRXXGrvi4pAcKn0PDmDpM8LfgpTxObL/B?=
 =?us-ascii?Q?AHAoD8bugqYO0cQOC5u6S0OdcZnpddfrNjTQEppPCRIMEV/TZylFzKer5h2p?=
 =?us-ascii?Q?NrYLf2fV/nxC40Im5gEgNT64BaUBaw0Nu1tgazJ8DzWJ2drVDaB5bKcgmOC6?=
 =?us-ascii?Q?vTYfhW3aJB+0CAWgqP6c+tTqkSG/ra3N7cZAwItgK9UtaF8MBWbXReP+kJPy?=
 =?us-ascii?Q?rRzivpuHi9eJsQrBpyxdfVkVzn05t8yJ1/HAJF/hSRAdTCWjAV4UXW11XdWP?=
 =?us-ascii?Q?fOIhKRt0GpKPROeGUvItcU6wACcJPK9uSnh/DSiEmH5IuKOQG/vbQkw/9doE?=
 =?us-ascii?Q?J9mjbPpDe4LmkDatTdYyfYUXkXp9jwTkII7iEEXYKnK3gLD3SH+Ybd1XNAkM?=
 =?us-ascii?Q?gAoRk0TZMJLv+Or/5zFnrz4yOP4k0cZA6gMfn/LhKt7bk3/YFqH5FCA1Dvi6?=
 =?us-ascii?Q?s3IRE3NRVfW3YF99I/3LOnFJjn/DlV6jQsWCV40Vjde6SnChtP726RB17dfN?=
 =?us-ascii?Q?WRuWMtGNrab0CxwgNzyvUeL9Y9ZfsTKvHOPnUXa1OH7CbG3hcTH2++CXwXUA?=
 =?us-ascii?Q?OE2LwANlRC7v7JZozrS6C4h02Y/TAHattc1bLNH5F/yVporzGXDZmswOhI6W?=
 =?us-ascii?Q?5VwK9rxM4YfnKRmfO33MFd26dVj+ovnsbvt5BkEjP2HQzcv5zmieVm/CGcoF?=
 =?us-ascii?Q?scwvL8xwb2WY16nM8ECIhFhC84yPiulxRz4VbeuF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b55b26-e5d7-434f-70f0-08ddacb4242c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 08:59:46.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTgoa1yyj9FrwzCCsCVsldzodR9QEfLnQNVCj/fKolaJI0yOYjliU6fKGL9PlBVneiC6oPyIuVfZLBzy8IL02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712

According to PCI/endpoint/pci-endpoint-cfs.rst, the endpoint (EP) should
only link up after `echo 1 > start` is executed.

To match the documented behavior, do not start the link automatically
when adding the EP controller.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f5f2ac638f4b..fda03512944d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1468,9 +1468,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 
 	pci_epc_init_notify(ep->epc);
 
-	/* Start LTSSM. */
-	imx_pcie_ltssm_enable(dev);
-
 	return 0;
 }
 
-- 
2.37.1


