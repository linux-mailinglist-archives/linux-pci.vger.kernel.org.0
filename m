Return-Path: <linux-pci+bounces-36836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F7B9883A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 09:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F742E4101
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 07:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58619274B56;
	Wed, 24 Sep 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZxgrNqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD52274B23;
	Wed, 24 Sep 2025 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698652; cv=fail; b=FhNzEfvJwj1SOXR0xhnYVh2YOi8mpfrP8NhIuCNYnsV9b3jo478otgW07MQbQsLujgzLWLncuIj9G0l8f1BzowmhIHFLHPhN95SGf/ty5SaDiiIIqZPelXcNYrwuCQsjcxIhm+xHI5tMFbq4erRaZ7mh+pNvl3DgOel7BwrNLWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698652; c=relaxed/simple;
	bh=7HAu+0iz6I0fk6YjWQPvKw8lTqjS/LEzmQxbfoda0G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hGLKloayQMlYSLvh5jMlecOI1qdZlCjBe0yrcVKbtKBDY6HpziHKFBIt6L//EmJ/AcRLSDRRu1OuMejE+Ag8ahcZ+aJKErM+XnG/Siyt8ZtRJJB4HoYnngjvAwB6WY5Ykx7/cYqvr+iTi/nE4uXojaLIU3nmGZ7SVPA+XZFmxqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZxgrNqP; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI6w9hlrCmNaasxAH6hY5W/2J77y/lfuttuzGuekHq5pq7KWvDyUv1fBa14jmI0Y1MlX2gTY3odn/S9koDPIHB1n3SSKPxL+OShJXB1LM4KBRAYaZi/OvXAju6D0GIA7sI1Tm6s6kTQ0+NnAjawYTptykSTlqn/+W4A6w6YSxswfdj2DeHWAnb6r30hyo4caY8SnfAkikno6pZ3MCe7E74WBVP55DI5f8v8Xxh/3xAV2/WBVoLB32mx2k/EziXaHJiN5LsfRKnlhB4JMqc4TFRiTGebcBIb4ED3j/SYtu1fEASOzDdwJdKqrtIynLTZ3KGQeuAF+BIX7/TN++ehXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koNm1Wvf7AYgnnGhRSlUQo39+fYd9F7f2/jyF/oILUM=;
 b=kcjC+YLF26jT/2C2uTZpHDEUEGf9hKyyYaKZRiUZ6B8o94d6NMggh5A7DfRoyFPhSbiXcka+tLfnOYb9SIcuZd1o016rkLYnFzy6DA+tZCpbZSpgb3Dl8xoDx+m4RgcX6D3zxcGh9+pViIj1brXOi7X2eVT5aeQzS4x92qipwKQJNI27srgdbgx6tM+tbUrKamn/d6Go2tUIfN0tB9QXaz8EXfGNF67GQGUbNAYSeeeS7vxqUw+0MHMgUNjpW3nflGq4qvQ3+lAd6Cfq2luXDq4ZBcU/5FRaYCBITvONGJZ6KGAVhdLd1oa8HGuQHbzS6pOD/NGrnxEvtVTyVIhE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koNm1Wvf7AYgnnGhRSlUQo39+fYd9F7f2/jyF/oILUM=;
 b=mZxgrNqPdWyWAt6JPOV5JVVrw8QsW66/TEJVZOxGXPp+0W5u4uxkTxWSpQf2Pwvm18SroalESknM7S9g37ToG3CDhkMSmHOp5m563PhPJ4AZUn44VBaerKSWbYPIIkcxrQwoiSYRz8VHc89lGLSwjRC9S7xrz8R1npXtG3yCZjvc08Ks5hD76QJcQrMyiQhafhFycsiSkd4sYFD8iI+DpOJVUqUESqWbzGF9Wje7b1HCqV91mFivQSYZV2TZlcivM63t9AvkA/3soePc/HlTcTOJPQTuYVy2FVOosq7iHXwZZ/tV1Hs1yFXWRmM/x8dGcWY9ov2cQmeD0J6EaJ78YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:24:07 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:24:06 +0000
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
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 3/4] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Wed, 24 Sep 2025 15:23:23 +0800
Message-Id: <20250924072324.3046687-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
References: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dce475b-0466-4f63-0a8d-08ddfb3b58a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p5EGFqP25a7lC9BSI5OfkKzTRgbeRtyUu6L2zLYPQU57DffQw2N9WiFTLjjr?=
 =?us-ascii?Q?GotBWMnBSkPOSPclnplMhmcEd7qPf4Zldx6CywV5hxYRkw/QyqC9YDs/muaX?=
 =?us-ascii?Q?APn5FavXkqHYW2WyZpe1mNLy1URxb9rKoAs8lWeIU1bCo7yzTQQD+RRprX55?=
 =?us-ascii?Q?hzr13i/aKyzzWZ+Hm1RlrfgQQqVhukdOfEw4oOdQkC779DZFQsAi6mNliVnK?=
 =?us-ascii?Q?w8KB6+UcYhy+Mj674+OhFv4STCCNbJcNHogD3XLvRMENjSO0McsDdHE3w2vh?=
 =?us-ascii?Q?HGLI7sd9oMgAOuw5Xm8U1sydLm6Y1kLIw0K9vIRBYrdHjQYfMFAr6aBwvg/H?=
 =?us-ascii?Q?CrHvAY5u8PS2PtioJHZPAoVL1DvWbCywzPnv2RHBdM+iaeQXefs6B2AOiB8X?=
 =?us-ascii?Q?9wf0SaXVxKUOcgnOuwzyvZ1rGYAJEPuhKgKNvh3Zpc3axs77q8bEc2wwV7EQ?=
 =?us-ascii?Q?B+DboxBgoxo8XzWCSTDFvNxwo3Q4LU2kjfVUkHrsQNpaHSSWY8yo/X8uhvhB?=
 =?us-ascii?Q?4yUTxMc3eOoO/aLDVEZWcQ7UKr4vjn+J6Nx05o/Eu3/vDd4Z2QB2ISXyNXFk?=
 =?us-ascii?Q?6IzsEglfotMKsr1/xpdDRaNLfhe3jhZKmZ5e/cSGK1DCm3MxHr8ZvRytERqF?=
 =?us-ascii?Q?UAnaI/XbVxNrAZXZS9aimqopQgGmTYtLqnMps5UZgj92nf1PmckNR1XWwtqR?=
 =?us-ascii?Q?vGtxPnjrh7QXVWyjKb0k0KLeHXZisqL/EGQ9cuSiNVCay2e2TA7xSic73QWL?=
 =?us-ascii?Q?JSaCIAk0PVpNrhXQ5XmUhPLtF1kMhV4UOo8BwtyW4qt2sF6cs+jPQLR73Fhl?=
 =?us-ascii?Q?ZSHV+kdjs0rYRcpEcPWEbe5FfdiR24MXAHDqWHkGweQ2WfNKgTxK2q0jd0aP?=
 =?us-ascii?Q?sTvI8T22ii4Mz1Pooa3Omj1+4CYRu4YcQ0yZ7NDc9Nr+TEsk8gSvZ9h7WRVx?=
 =?us-ascii?Q?t6lXaC4pg0CPdAb6pOVsIlNQTVUGVgR/NxN9yCYQFKnJfUJ4mOPpDHLGcPVo?=
 =?us-ascii?Q?6DprOkkHhRoZGG6t8IB01Tpr0uhpXPvpT4VzKybpxU+loYLbVAjlsxqXKTZB?=
 =?us-ascii?Q?W5G6qz7r6TXivdRw62m7hd56R0eAadGbUO86I4TJW3foUmkZiQKzYzRAeFrF?=
 =?us-ascii?Q?Ia6ZPzU9R6t+VWnfbd0s8Vncdqn0t83Wu2kczXG7rpI2qSSYE5ejlDcC+1Ts?=
 =?us-ascii?Q?P7vGcqBQ8XQZOZdIOHJSeagP8tJn8Y10wZk13cJWg3K1CSlG4nBzvU4nQpX7?=
 =?us-ascii?Q?WjRZA/En+gWNikeQXWH3Bb/qQzwHF5WSG6cK8S93gn5nNbAs+h9ctOUacBJO?=
 =?us-ascii?Q?I6byKTLA0w0edZyWkTNWWyR+pW21C7n+nsrTmXm1NLc+CIXCnyhsENCgUSEe?=
 =?us-ascii?Q?y6/VWdQptHg5Fch57EaCl3PTOeW6y2zwQ9qg5+AXQToBN/4j/ZIBBvrhHUDb?=
 =?us-ascii?Q?qKLWpXOVOiX9GoODfD6p0bJylHjkxkF+dZaleWwBvR532EJ8gDLVoljQioUb?=
 =?us-ascii?Q?nZswRf7y6LMiLng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCVr6p39ete9mvStsGoFNP9+LB0j2xVH3w0KSKlzfkNs61czVWtYbLLMbMyT?=
 =?us-ascii?Q?H1UuA6j0k4C7tXFxUDfnDcU6wsDpgCWa5yMOjiRSOPvQZXryOulmDnH94thT?=
 =?us-ascii?Q?S/ieEzerYplNiA6XF7H2qy1p4O6K00iI/fRjpf5g/tZFaou39ld86DNoF07D?=
 =?us-ascii?Q?TqgQ7HwT7NCwF0e+KKq250iEjlPsexNA8KkHlil6UdFzOT1tFiD2m2yOk8+r?=
 =?us-ascii?Q?ijtXbNrRWtluTWVjXmLpP7N9LvCbZA/Omx7BHvz5Sh+eLwoz0sHIymvp9Mgb?=
 =?us-ascii?Q?IMf2tT/9RZfMCGotyEdZ4HdUFhV6msFsKD/qYs3QAI6tunYqeBOyoa8nrAZX?=
 =?us-ascii?Q?dkUJJpM+9KkAEdYzqLSBR+SY7mr+XhfI1mQjf30vv26ErowBw2zNQCjINXUx?=
 =?us-ascii?Q?y3MrgP+qVlp6GoIVzvKkuteejRhp0cZRLwCwh7udMgYm46t6I04Yh5DKEgg2?=
 =?us-ascii?Q?putJmtUIFtzJMODN83Ir192cATJ6ZSTnFhL2YfFh29VYT6BdswMpE2PkPuQC?=
 =?us-ascii?Q?lB9k9d4GwVvHymKWtok+pB4sodVrNFZRlsbNZoZrV19Ja4vw7NBhMcqTwozb?=
 =?us-ascii?Q?Mr4mQmcwe2kkEAQ5iKkc/4bZR/w+2HFlVgSl1kYgkJD4DwoJM9MOSQM3ITqZ?=
 =?us-ascii?Q?cIwu+rGamxodr0w3jfQUh3vrLnZboqQxmKn6fZeL5OE78xJuZBcBPDypN/ak?=
 =?us-ascii?Q?2yx93T9QxByLnxO9qdY/k9sR2NDeNTtEVEfP74ZizS33884pKH4tNBRs5W2l?=
 =?us-ascii?Q?jkXmGUVcjuBDeIWa3ESL8QJU/KnD8WIrwfVDzF39iTNz8Zr0x0QUcc3ETN45?=
 =?us-ascii?Q?6TXGvWjUHtERbHGRALVcyqLjLaeyK1eGqA/WuCclHwJxYj+iVucwvz+kUFfF?=
 =?us-ascii?Q?6Q6gQnKjXgA64GWs3fSJ/yrsNIcxm9ndRtLaIC/OfRXN7F1zmjFKe46yUTSI?=
 =?us-ascii?Q?90DZReb+6jwiV7hmkw3I3iVaHMChTSn9lK857aQeTMk7ppc+8alHnd5Mo9tZ?=
 =?us-ascii?Q?oCSksLGnEGyVyuh6J0d1qKr0CKZRUf1x5rQ8my2bhWeuF/XP6gOrBE4hGW+d?=
 =?us-ascii?Q?oKwqOecvw+dLUriO90VNqD1hsU5iqI/Y6S4I67BrQGWsc3vswid2iZM1Cy/I?=
 =?us-ascii?Q?n0JQ5yDoUqSY22jqo+eNkURr8bDA6BB0y5oivmucE9+iY/ZGSh8EGibRTRLY?=
 =?us-ascii?Q?tNanYjlfJmcxR4Sm+mc7/J9emX61/ZsSyRc2KVEXRHW0xA1mKYykt4dpJwMD?=
 =?us-ascii?Q?KOjDpRlhDRkDAMeCOFomRuDthWkilM3DLoYt4YuVlTSV461yztKEdUvFJuSb?=
 =?us-ascii?Q?wOhC2w3wiNwdd9mUaPcPv61Ri70HOMwTJS3HqhU2La3mQkkNIu8q2Ge+6Mds?=
 =?us-ascii?Q?AP/lDo+jVhv7qoGNWpmAfCArc3UFIHLU/1MbSw0eqtsvm9cazjAqjk4ghNrb?=
 =?us-ascii?Q?qQEDKt54cHYPgEwFzO4Wmx8zAc7YHtrwoCKDDxQoaN1di4evezrn06VDjwx1?=
 =?us-ascii?Q?jBN4ODQSChVS5puf7dzYqSlKUrKk6LUgaJDBcROz+XkTmdoyvIvI9VH/gLBd?=
 =?us-ascii?Q?Jm1Fgestm8GnnXDp1pu0BcPS5Rt05yayFda5CPZ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dce475b-0466-4f63-0a8d-08ddfb3b58a8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:24:06.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apamTG/RhAACb+kae2x8prII3Lxg5+AzCYX7v1+xvbfYdwBteoWNR2SX6b3oF+lyQAyZx/yss7NQrMlMfFODFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME
message and no any devices are connected on the port.

To workaroud such kind of issue, skip PME_Turn_Off message if there is
no endpoint connected.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 57a1ba08c427..b303a74b0fd7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1008,12 +1008,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
-	if (pci->pp.ops->pme_turn_off) {
-		pci->pp.ops->pme_turn_off(&pci->pp);
-	} else {
-		ret = dw_pcie_pme_turn_off(pci);
-		if (ret)
-			return ret;
+	/* Skip PME_Turn_Off message if there is no endpoint connected */
+	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {
+		if (pci->pp.ops->pme_turn_off) {
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		} else {
+			ret = dw_pcie_pme_turn_off(pci);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
-- 
2.37.1


