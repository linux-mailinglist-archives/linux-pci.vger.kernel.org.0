Return-Path: <linux-pci+bounces-25467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684CAA7F2F9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5553B6948
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD825EFBC;
	Tue,  8 Apr 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/Qc8HE1"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E425F7A2;
	Tue,  8 Apr 2025 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081270; cv=fail; b=M60yKXm/srYYF9QIwqNY3BT0Z1Rdyl6ZWLR7qpawrEmTn9LNgwKMUUrJpuRBJYO1eJGp+BTUR3oBu73tUSibghGfl7ZCeWCWpcbdg/NWx2WaSas1WoCk3dQBsBuy/U9EuOcDbePzxfqWrusozyeXC0brK3FnuYLyVElEZynDDsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081270; c=relaxed/simple;
	bh=nPzGs4fS1pOjXa60EtFAhn31/6i5bofeWmvfgUsaCf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJZIaWwWYqKUWnyFB+CX/UeuhGjuUOZJ8uMKkDiWjjJ/VuTZ6A0KThiK1cLmlMXRFYrAWp3zxPi+oKiSVhoEH9bPK+Fgnc4r9KI25Rb9uMb1DPcpkk9gNU1NOq5tlA/N5wQ+KMQdicnomQT5KskXuZuqHKXhzN2Ni+om3l6mSrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F/Qc8HE1; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXe8SR20ZVjBl6iUJFVVhVB8PCQkSCkNLZ+A7pWuh8jUczs8VgTE0GoiTLiSWhKzKKKL/sbQb+DpWvZ3te8uboH9NzR2/euCm4euAle+GJXpQdoexMVMZ4wtW4iRMk9Y3iTL5ILABVwBLc7PSVcu5j+CiWRpULSDlB9M7QuT5dbTdCFrqOT0GyplcF54qo2hvqh+Ix8w13ZUizZO4VHVXGvefFyRxD73N7JnH2Zm+fdOm0c3w6qk3tD4clfY7vXNWLJZiynCHx2MDhZJmrWRwmiYBJu07Qyr5nMafz/Enpy3PDKy6iYmsEarjkm0VVNqVuVNGgZG7uciZpo6fHSeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efEvitd2FYcZSyWZ5fqreRfGXp95/be3n61ocZj27PQ=;
 b=derlZW4drbfcFNEjnvEw7fZnWmte1n1Da5aVb09jFDO5+CC5Elqnz96Zn9EzcU3nKCbOVgkatfEBWpp1Cyi+OtmnirSAFpOsngUwnO9pThnjXMwYLj8YduzDPXA0uXHl/xniM2eEPjc65/a3RcQv8+tjKL5Dudd+I9ZqmnTvx842DSoGvYoBcpkRmvHSlkCoVa9IPhAxqlp/73pPl3uWmYLtjCT1AE9tNEJRz7r/t3/5mFzdF/X8CdZKN08Z99SHgGNfuNG/3OI4uhoo8gdJBPG+sZCefrAlAMESFb8hQM6FE2JAxX0YLxE5mJe+fLHPoEWhFV2uvPk4j+DMwJy8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efEvitd2FYcZSyWZ5fqreRfGXp95/be3n61ocZj27PQ=;
 b=F/Qc8HE1oGsI0La4IpQewLV472trXSSjB4UtsxkVrWA3HnMfPTSBP4Zzu6ZIWYskfmMqTt4QgOHrZZvLvRtlL8IwWDyPEaKqaTkGSXOSnZse9/JEayPLcLUACO5KaBVE/q/nYsevV5j2ILP+zoYPVReQiLUTzsHfomLPmdDZgRFBlfCLREFBC1vh7l3hi8JVRTczR0Ft+O8nTwq0B8Dfy5gvkXwQY0ilHShJo75XfbX6hDkIEva32hi6ZVhxccVr3IjClZQHrml7fkEsup9t+5MWAqYJ089CKbw2X0gO62LHV2xMpsET/fxjs9DVxaG5gYk7fZc/SnuC757oVQkFpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:01:06 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:01:06 +0000
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
Subject: [PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Tue,  8 Apr 2025 10:59:26 +0800
Message-Id: <20250408025930.1863551-4-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7caacd9b-11b8-4749-2373-08dd76499ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqc728n43an9EBtAOEGzOZF02kmdXWRMBVqrB3jMOLsR5isGGv2Z/qE73ZSM?=
 =?us-ascii?Q?IFOepd6gQV21KHwH5E4DXl7Xfn1CyCdzcn7uqZbK2FYnrVBMi+cFJBu39U05?=
 =?us-ascii?Q?I47k4rM+nKIO31QYazRFIsJFM3bWkNgj083t/kedL8+zY1wQlm8JNP0g4Zh2?=
 =?us-ascii?Q?3tlAoAmck2drOsqVc5z+GiCFu7KT+RirBAzPuaEzojf0N2aj02bC5MRjLqJA?=
 =?us-ascii?Q?l/cJXdKdPULnLNXXTLSo0ouZZOGvguZXL21QD9UM3KKBlGcTHtfZ51QDWnlk?=
 =?us-ascii?Q?uUelMBfLBF5SOgUUCfc+giQGxOKkXl+x3xO5oaD7qFBGQDmZZtg+H4bhpwN9?=
 =?us-ascii?Q?ZWX1c8eBtAdVL/AiZrJDPyigX/hzmFrIfpO3Gc4viLvWjzhzxFacskdJ2VQp?=
 =?us-ascii?Q?8+kebiKHuFBHAaeSLTeUj8gQeWQH8ok//dBULEVwVXY1JYmapu14zM+RRUeC?=
 =?us-ascii?Q?VG/YY3/cTX8lY7JFuj3GlxzO/ZAWjSUVriHwVqeGqHK9VOGAWCSnT+C1DGp4?=
 =?us-ascii?Q?2pqpbH41df1UuUi+aXkZYpXsjDiqXufTrz4QNbWMdlbTAX5SQ86q8FT1A9mc?=
 =?us-ascii?Q?Nhlezcy7AYDPNKyqlKYgYLYes6EqqNHw1SOfTYFGc6B79lAxt2V8hnv3Ssri?=
 =?us-ascii?Q?jy92chmpeIeNC5D8y9BVO4Ao+g/q/g5LMYAzNqVbV0r9/CI6nhR4j3LvsuIn?=
 =?us-ascii?Q?xe5PRo5ytotKzE9djR33w1Nvc1L4bVjQ89z8rNhpaJsjpng3aCoKyyqCSmpk?=
 =?us-ascii?Q?IpG2+ZgXbqKqowJItlJ1wl6uhrdrogvobBCcIEOzLqjla8XzojELFXrS4zfl?=
 =?us-ascii?Q?XfNveyKpfwTbLas0uN0HT3Am/Jh+DxrmiCcq0LTEFyexNDcK6GKvCAGLChTg?=
 =?us-ascii?Q?C+17Y9blyA201WO1L4bgryNHtTN2s1DYIKNxG43uzRQXnQACxmCcT1TbFVO5?=
 =?us-ascii?Q?e2gTHu2KkWmMy8MFnPFwzmGJ0lYD39bI/qFarw1opqZ7d8ebzMprzfi69NKh?=
 =?us-ascii?Q?E3apwF4KtSBOJZHEzl8FJ4gojDmty3zl6500zYa3CWiObYzNheCnq4CqnUiu?=
 =?us-ascii?Q?od/5kHyyvjhnPdNv2VcEPQQsEbCL9cwgCfXPlq1BDq6pq9NNKHfx/4YtVJfI?=
 =?us-ascii?Q?AO5hFHl7ovVuDViyYwGeyRE2myTVHETxu1Z+LlDeuCIuegi7IDvzga6CLCS+?=
 =?us-ascii?Q?ROLh4mB8PlyIMluNIOMkyaoJL9PEUBOIPZWbRkjl7b06CDNgDiHHAJD4UUTV?=
 =?us-ascii?Q?kxp4Uua47ELFC26Gi0SeczjxYTcpMHpF/POV/Tvzb1LWR40KbLOaDT1ZuI+r?=
 =?us-ascii?Q?dNXrryn5NYY3xi+H6teUTYsr5KxGnrG95uWzvPWq2VAZOZfhdvMCud+9gmNx?=
 =?us-ascii?Q?AMx37IMkL0/+dIbBNr/GjuFdlXnvyxOlult1OfXb8mzawrzEWrVMaLvF/gQq?=
 =?us-ascii?Q?YUyYvRPjvUKNqPl1jMj6QTLRQVQkM04TRsGfwxJTHdwemfRWfk5YJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DX5mXjBk80Xl+ihE2HJprXplEkRXVIiZEUM2OoDOTgdrX51gtTUmY+n9XVO?=
 =?us-ascii?Q?zeO9mtXVZOhMM402KIGTJjQn4SEQ49FCGI3pzFKyzBFY+KUsqoYWNPErJySD?=
 =?us-ascii?Q?D/1u0zclOskN2WYhG+VsV+eaTpWcX+31wqotd2wI7twTSDb0r6T6qMYNBjFl?=
 =?us-ascii?Q?TRUOpQHcKmgiDfa8FFWeJEvITNy1OSnvsZhUlK2Wf2DW+K6atr0JCnql25NK?=
 =?us-ascii?Q?kWx3rJ7UfKvA1jUX5UQSq8GPLqZRI3gdFRify6pkfx6XVV5AO/2R/GAyLuk+?=
 =?us-ascii?Q?0Gz01rZ3qdsc3WbWk9hWcBiCwr9szFZCg8FrW0PHVy1XaoWGOu+9MFATcW1t?=
 =?us-ascii?Q?5+JwoR33FgappNIwq03+dTivi1FWTQIO/TAxjjnM8pj3txoSaGoq6N5jGgm0?=
 =?us-ascii?Q?Ib8XwxG8XVwRLNtDmKlByEsN21NreSJMQtJuiJ5KZyBX1w8LaKRhcN46NjQ3?=
 =?us-ascii?Q?lp+ERM14AwMT6kUazvPPNX1eiAodR6d57oU5mkkjWA86/GlxrYVzWpBcwaER?=
 =?us-ascii?Q?HR+VGnZoR2Nq/OYaYSTkTdaCXyRDzF5y7z0UFDvbSKSAH3u3OMk0FDGbzXGp?=
 =?us-ascii?Q?lVXVkbVQGP6dG9Jc7yC+1E5dFoJn1GukGokCuAPiUroSKnwuSwKNsGDHVC3c?=
 =?us-ascii?Q?eu7gd8T5j53MJulftcoA9hNk+ZOXRhxAi4eIaKmSYkYBwsoI7KG5CG5OusUM?=
 =?us-ascii?Q?FfYQJgGB40th+MssXx7mvR0a3Dba9ZnNggRdD2btuEqBuWZd5Ki7Z9ncYP4P?=
 =?us-ascii?Q?ffD6ARJ9kqS9Unrx+jEbyNQabK6vtejUm7hHpoZZyWt8iL4h8/QpE9lpXFyV?=
 =?us-ascii?Q?CSsPhOaoE5OWHuPL9uZPsyIAIn69/ZchCSYFpWsVOeoqXIx1L43kIDe8Z/uM?=
 =?us-ascii?Q?BrPaAXWNqFCEQN9NLNc8JLRqrL39AZ5r8XU4oGPtaHNF0LrPudVAnIHOw0xy?=
 =?us-ascii?Q?rpgOAgx1WlhJ8zhTCbqdn/5dEG89X888ep4xbL/zqEh9NjoUD0JpVwE2xmvl?=
 =?us-ascii?Q?vLUJ2LnNxoHeIn8U3I9GV1PHZpTFtwr5A/aowhlMsqw5LYarKlPTnu3qR/p3?=
 =?us-ascii?Q?5z8fdyL/bdS8cryN+BvC1zqbEgUkjGsoyBMzm4uSrQl+4GaknHhVNZFbsuy8?=
 =?us-ascii?Q?ZkQOG/coBy0tb2xviiGtKO9cawdzdOqq39V1QY5k6RuJVjZwTcbSbIGSRina?=
 =?us-ascii?Q?F2NnsNiLE3uVIl5h+N2mmrNXgySZRiI5AWH4ktOXRl7lkD9e8Wx7/CApMBdd?=
 =?us-ascii?Q?BNZUeHuMahXlnddswS+izOqXs3dwXDLYeqyY7Fhl5pchTSsLPBPp9RsBuRuH?=
 =?us-ascii?Q?zqbVP1RXA6/PSPxMfMuaevpOq4XBuLbc4sxOv/JiJ2Otiklb6O3qlS454a6M?=
 =?us-ascii?Q?wFMZLMtZ7TQv5d5I5mIAL5AU3vzp7u9SENTg4bdcJiJLoXqL8/yTf2AzkP64?=
 =?us-ascii?Q?lMWWXSZRNv4/R9YBe/vky4mG3X8IJcF6J1xBFiUHPGvznYM3cFU8/nPnreqX?=
 =?us-ascii?Q?VZxwgnKjObvzOlL8D7lKH6wCvSeTnsiG4CTEQw9rOKGk02yrUD9C+OAm353D?=
 =?us-ascii?Q?SZJITZVNHujROTFycVnNESn1scUtrL/kmiSk7cMh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caacd9b-11b8-4749-2373-08dd76499ada
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:01:06.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBHpT7Y58iTlIfu3Tq47KxAG8TBv16bc7DXY9eWltNFgStUb0ammcu59F6ER+GY1VN9tSEYYiNPTV8u9fbpLmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c5871c3d4194..7c60b712480a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -71,6 +71,9 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
+static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				IMX95_PCIE_COLD_RST);
+		/*
+		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
+		 * hardware by doing a read. Otherwise, there is no guarantee
+		 * that the write has reached the hardware before udelay().
+		 */
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST);
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(10);
+	}
+
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
@@ -1739,6 +1779,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1792,6 +1833,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


