Return-Path: <linux-pci+bounces-15673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368209B75D0
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597B41C2186A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A79914B976;
	Thu, 31 Oct 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="akIsEDW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87598146019;
	Thu, 31 Oct 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361421; cv=fail; b=M1kOqmcnKB1BTY6JwNaMz1GYWaGJoqfF5JIK6NNK8AK3Oi9v94ocqSgexedlmRf3dsgIXBO1kf9zQiUOQ2LtT6vWAuHoM11kplHmbJHY86v7Txe1/XdEyBee4DseQp2fz9XMIPKLHu7H3F7uPeOYVRhoi+rjkKlC/zUOvyqvbRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361421; c=relaxed/simple;
	bh=UGkz9aDtWAYAKFI8faI6kYDF/f9IwcrWClKOTXfhITs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l7skmb3aydANzEmCLZ6dD+QwDvK4LoFz7jJmlqoSJHSFW2DVcWLv5fX5IZTvZS6v4SLvqqZDIenlKma43CVEwNKMIsAQIse4+01lBXAR0YYMhEd2aN89vGY3cvTIMnSRzOZWBdDaqq+Sz0ipQMLLEFbjXqT4ggLg5t6pb55YL7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=akIsEDW7; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH8fEyBRDurRn+77l8Ve/QU0b5g1k2cs+DbToY1uwcVbBloCArxNuRillgNbWF8e47AfOk9+I+MWQ84wpKvPEMieTb5DMivQskNd2sPiS1f/nq0s+CqFPRGd4pQO2KuNOUHQEfQa1D/NKJSC2A2ibTohx4/ruLeanRIBhmzeewOle7zHZwHYlAOWpedU9OoIm0vC7ZBZLSk0QMEeKlIIPFXW5xwZFkGG+Mz1Z0Ae05jpfH1Bgxf0XmBYXoIF/YoONvLJnJ/ruNtL4PUFtzWTgwQaisFGfQkkurFVDXYQuFWezzyCZobkuvLooJgldfbzxYNfqrnwpcPa3JgRGXGnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dam89QmvakeaUAPIUndfpOFHWi/Ev7M3/3Knm7kg2J0=;
 b=aP6SSo/ga5bGWGHRGTBzywPG2zegGXRtrQqIXyHCwk+1EAJodIhuc2XFC7O+O2Zqg4iaw0gJTcniq8Np86hzs8VzpySHgSEUK3ixUQvwziD5Jd2K52A53kSXHM/P7PGDYH1AExmZsjf0fsi6yf6HO7zfPuwHlc6SYiGWVF0v0+DGSCciPHPtcK2GfpWcVblSrC3JfasmD3mb3zLJnv2gz33vt0fXrksplEeiD/xMRWg+LO3S1GIGyqQCqT+BofloAy+dx8UCmZ/1i/f6FRpxuC//+OsZuQI35hdTY5Ir5a1G2V9T3OX1BaQJtpMUqx1dQAgl4jVlpkj65Zctq0F2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dam89QmvakeaUAPIUndfpOFHWi/Ev7M3/3Knm7kg2J0=;
 b=akIsEDW7I/4GgRItopU3lKfrr0galxUV2QlLmIb3lSWRrkt0XwsLIBMwXdPGuc3523Q7jvGjumiPSaEcqNLs2m4wo4SM8r9zkC+UuiRYGt+zW+sBuOjNAcY91o3UYiXOrO1DLibT1+YM4CcrRJgJH/YIR5F97LNRDo/qSmkJs8onBHygiAgOj2rmk1Jm/38XBZ98VNjCN97cx2Go7QVFQYJ8da8C0JkGbR5TdxVJZS9f/nHDXCTfdnj1axf7qAZ/aGp9Gsiz0XYrp7gLKH8wM7nGa52dNwZXXbc2nw50Z4fJSc5nwePzGhnjYT5DFksAOa3MWx+E32dzrQ6BleEolg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:56:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:56:54 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/10] A bunch of changes to refine i.MX PCIe driver
Date: Thu, 31 Oct 2024 16:06:45 +0800
Message-Id: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b6f965-5c86-405a-4243-08dcf9819610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3pVXA21CNNL4Hqn0vpGwtgc1grZrgVXPOEaikAJ2tnDz9I+UIDig6Rdj9zo?=
 =?us-ascii?Q?si+czcyVqVIFElo/bIjBgtxh8ilk0OBYUt8Bm7fXOQzVLKLm0TGWDogknnrL?=
 =?us-ascii?Q?d1Bn6q/V7zQ0K1s5qz1ho1z3kOJ4GRH+DJ2r2/tW/sx+twVZLQsATDIQPDNr?=
 =?us-ascii?Q?Ra9YHQBotiCB3bPx9cd3/pCtZ0NTbYmxoHcVT1bi9CMSCSsl6dDqBKA6K5dI?=
 =?us-ascii?Q?BFswZ3nGj5i+wnak6Z6P8cX16rybNRI3n0SBMIVUW7CLXSNFOPW8rjrgRdwj?=
 =?us-ascii?Q?h6tgkkLw6MJ/6b5ueMjQutXdcidtg93HP3+5vsqYfWmN1jXXt1nHX6X4OwpT?=
 =?us-ascii?Q?Mcb/D1M3/OZljKuO1IpPi/I29poOnk9NXuIYcz8JmMMn8ZLeAXFIKnrWt3gm?=
 =?us-ascii?Q?7Fe6gPqeH90nbfSTV8pNBcowSQtwZLZ9aa3qRab9bycJXI2PXJnDVjQhdzz4?=
 =?us-ascii?Q?pGeXERxafCYUL9311MrC/ZId1Ysc0jK9U67lp64pXwKUsXs73NqaWtPnz5ER?=
 =?us-ascii?Q?bAJXIaW9+kjZpw2eKYwz7r8yZSOpV0qdPjY6F/p/dbE+e8XzuylsyvMTHe7d?=
 =?us-ascii?Q?71FJWCvFiEHm/0Wyu+xwH2R8T95Nk9nBvSauMyp/4gKcIvev/cu2y4vWjUsU?=
 =?us-ascii?Q?A48z1VZaEnsvtu0PL1SpsRr+vECNZjTmTIal+C6JSx+35zfwn+IVisqUZxbi?=
 =?us-ascii?Q?9kPzKdLcgH15zJ8YXaD6DVuAFVO1DCU2xH5q8FRZl66+NgqFPBHowZGyd/dJ?=
 =?us-ascii?Q?k5XY4rJtJ2MkKOZ6d1rjuEszQycT50FvVQ4DFEfuxqVeJEzTunmbpaCgmH3D?=
 =?us-ascii?Q?Uf00jIUKdzSy3TjGMrTr146FEDx6OpByE+6bxdFtbsJqSd5H8u6bZgRkcOJz?=
 =?us-ascii?Q?SpNjlD++kjMWqZh2K0kz8V2enf3YfqBCq/uZJlEA1PQUTkAwa4/gXbQhJAW0?=
 =?us-ascii?Q?j+7pGZBziDmOoxTddEEBv6Juvsc/RnfjgkCJqRVuUE9O2HYyqgbiG2aXwNR5?=
 =?us-ascii?Q?hBmmWsYfF9OHU2KQtABz9EErb0sRUNXWINb6O05iDGbkCfNcIrFGxRO0d7TT?=
 =?us-ascii?Q?JiuhEWI/IK275qSJlcAzL1gITYSae4hAiJB7wGpG5UsgJzR5iY7TdVad2yjE?=
 =?us-ascii?Q?aZSoijnfHHRVNklqemhYSbTG7eE3+HLCgkKPb5vdJmhQ8/TeauS+7YMjCesa?=
 =?us-ascii?Q?CpZguj5CsaA9AtbF2616+KQqi9mRGNDcRNnGrexGq3laeKs7DGatlCzH+Ux1?=
 =?us-ascii?Q?F922F+x91xuh6o9YXWIBgjkH4ByEgpyLAgHyaMDxEIkiukyUUv2XnGhFsrsD?=
 =?us-ascii?Q?4/di37o+U1nGktYduN3jG5CLQ8s1c3THw+NWei1PYOoXnJHNcaOFUEbzaRoU?=
 =?us-ascii?Q?N5vFG/IyRpDUexxm4Qc1XCRImhQD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uTygge5OU/4YEM3TwoOmN0VURKbOyYAk4UkRMKSa/kaeKee1Gbsfk3UNpIQm?=
 =?us-ascii?Q?hT+xw6EN9fhwBJnh6dFFk4dgPCCS7S7/kbYaiit6qQGYuZoTZvaJ5r3cV8yq?=
 =?us-ascii?Q?VWAXPJfKlguxU3sUrvHHDniAIQe+3IE7kQAIWMXJi2bL6K34Yv7MWDhdnXbk?=
 =?us-ascii?Q?KYylkUbuiGPRU90eoet0vDHQfB9NYYnIdCiv0NI23WWwQBPa9vpnXPHl/puP?=
 =?us-ascii?Q?UsXjGjAPWK19YOdRxhHzuHeUoKA9GG/K9YRmR8oa/gWDXdCfcpsUJU7Voe2w?=
 =?us-ascii?Q?AO1aSyGmhe4Q8ZrU6tyed0yFx5ZkfOLNUWDYgriv9mIT2XTgeuV0B1JvpFG4?=
 =?us-ascii?Q?kdFrAPt2uQKpDkWrsoxd3WsjIKTIXW5sFfMh4wFON2qAtyMfrHbE3Xwav7hb?=
 =?us-ascii?Q?P0MebwjZNu1Gw3Q3IN6gwb5J4Zm6Bzil0hRGEkXnof+nXjVfuCRMjsaW87Gf?=
 =?us-ascii?Q?sb1bYIiZuy/dJ6UlnwHMwxCwrH9PZZ0zHSETtHxLVF1zbnn8yd1GnEcW5xiW?=
 =?us-ascii?Q?dr0RoSEBeE8lxi0FK6n5lKjsK5+Y64sbnx0rjJfovabRHP0m5IHfvP4mwoZe?=
 =?us-ascii?Q?HtfqZpZ4OwneW4IrfC+Z2Grxivyc5TqSMrsZNlRjYCR4/qY5Mqs4BKrYW+Za?=
 =?us-ascii?Q?pu3wMsbs0dwmjZJRtQfWat2OX8mZ86MaXq/PUScXK9zrJp7EwVrflxvJVOaQ?=
 =?us-ascii?Q?N+YcnL1MpNRHWUWDutP+nOtuR9TxJ/eskhs9HNkvaPPBvQthqgGUYmTz0n95?=
 =?us-ascii?Q?NQvvMhWbnI+PIloRTGY2QpdG3HY7D5czg8AEFJAv+0QqT9pzsSF53HKwc8yI?=
 =?us-ascii?Q?ZPSQLaNLp6gC/+3CHt9rdLZGKS3CmV7uiY15RVjhlnYHaF/tC5lx+MPdbori?=
 =?us-ascii?Q?bfYzXQ5R484snDvRcDELXtdDPd+vM/C/bsIeScDTlhXRHFJJMXI1UhgEnvjo?=
 =?us-ascii?Q?bTfJkoPknPoCtV6jPVOzdMJUlFbmyt2E9wP56t4T3lpxELGwpJL+TqAAqFzZ?=
 =?us-ascii?Q?qocACL3/0xkwpDRwBbrmpXdk1hF+Zhq82RBezDDdJaGD8mJw7ijVZqbxDiIl?=
 =?us-ascii?Q?3fnUnBAio49Yb5lZeOFXoymrpdp2lOKKEzcF4bUYPht/dlnr3aU6jCwacILw?=
 =?us-ascii?Q?k6Phxgo802Ryi0bxzFD3gtYGINLnclIFXkqOJJCtLKg0MUSEkPpuWIR9/VfH?=
 =?us-ascii?Q?F6uKkX8AVYXeTPYKyxq+2obgty2QsgE5e95ovygOQlfMWM155bYNOmjvRcRK?=
 =?us-ascii?Q?ihoE5ywE53IiUrxpNcIn6EvdENUXWvn+pX+EbYzQ/xB2XYiKD8s9iSeZJUaV?=
 =?us-ascii?Q?tmJkma4ZuMEzx3KTof7aC9p7Uo1g5wGDnBpencrpo5Wdzi3HdAJvSYMlNAuk?=
 =?us-ascii?Q?L6O8k5N9tIxe96vNXiOVlQi/dDSO7zeuaXvtD72s2V/BShqI2lsl6AkDvWEH?=
 =?us-ascii?Q?pcEKkYU0sFSpkS7x+ytRi320w6LYJX5pNxnTDJjOBe+wrl8oqUIeE14pO4U6?=
 =?us-ascii?Q?uPoxwlbzp9X2jGpU3BEGhJKnxCPI3F3W7AEdriUjSx3b60iGq17F8TBgqHt5?=
 =?us-ascii?Q?SqlFrkZZXxKIUVnLJIY2cKjKyynkIKHoB2dd9l3E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b6f965-5c86-405a-4243-08dcf9819610
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:56:54.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o8RQwxJJJ31x8q6JpKkOayYXZRPLWPsHhcZ2928Eqa+0fXCr8V2k9HKa5UfFxwEw34mw5PfS5U/8a5aPXuZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

A bunch of changes to refine i.MX PCIe driver.
- Add ref clock gate for i.MX95 PCIe.
  The changes of clock part are here [1], and had been applied by Abel.
  [1] https://lkml.org/lkml/2024/10/15/390
- Clean i.MX PCIe driver by removing useless codes.
  Patch #3 depends on dts changes. And the dts changes had been applied
  by Shawn, there is no dependecy now.
- Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
- Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
  i.MX95 PCIe PM supports.

v5 changes:
Thanks for Manivannan's review.
- To avoid the DT compatibility on i.MX95, let to fetch i.MX95 PCIe clocks be
  optinal in driver.
- Add Fixes tags into #5 and #6 patches.
- Split the clean up codes into #7.
- Update the commit message in #10, and #8
  "PCI: imx6: Use dwc common suspend resume method" patches.

v4 changes:
It's my fault that I missing Manivannan in the reviewer list.
I'm sorry about that.
- Rebase to v6.12-rc3, and resolve the dtsi conflictions.
  Add Manivannan into reviewer list.

v3 changes:
- Update EP binding refer to comments provided by Krzysztof Kozlowski.
  Thanks.

v2 changes:
- Add the reasons why one more clock is added for i.MX95 PCIe in patch #1.
- Add the "Reviewed-by: Frank Li <Frank.Li@nxp.com>" into patch #2, #4, #5,
  #6, #8 and #9.

[PATCH v5 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
[PATCH v5 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
[PATCH v5 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
[PATCH v5 04/10] PCI: imx6: Correct controller_id generation logic
[PATCH v5 05/10] PCI: imx6: Make core reset assertion deassertion
[PATCH v5 06/10] PCI: imx6: Fix the missing reference clock disable
[PATCH v5 07/10] PCI: imx6: Clean up codes by removing
[PATCH v5 08/10] PCI: imx6: Use dwc common suspend resume method
[PATCH v5 09/10] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM
[PATCH v5 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |   1 +
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 +++++++++--
arch/arm64/boot/dts/freescale/imx95.dtsi                         |  18 ++++++--
drivers/pci/controller/dwc/pci-imx6.c                            | 174 +++++++++++++++++++++++++++++-----------------------------------------------
5 files changed, 104 insertions(+), 118 deletions(-)


