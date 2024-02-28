Return-Path: <linux-pci+bounces-4203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3435286B7D8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897ACB215CA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324D15DBC7;
	Wed, 28 Feb 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T8PRR/qG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958015B97D;
	Wed, 28 Feb 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147031; cv=fail; b=t/J9dV7SatqWZuWiWCcFOfL+Oun+om11Jt8KSB5JR6S6begPEXvATMWKOjb/S7RBZSbkWJQZGO9uVq2uTcgSjatsQBKuXKxAEq9OhYHY1HEq1SCL35fsdQHtN5LrZh5k7wkKyF+5EQajcgRuNXX3bIigpZy31kaWmI+6EyEHKhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147031; c=relaxed/simple;
	bh=JUW4w1Lff671/YnzSC7R58aPEooBzPuA4j8lpGuVx6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqpxK2rjxr98SP/pRTWnNPOK1GDF604pVgYVLTRnXENHnkiD2B6Jv7yaGMgxVUbtXeEYvjSaHTz57r0IpG1jnI4MBPTL0r/bSYJ4ZHeFxNbaKTFUYg/nFZCPpYTEtWWm3TjITkivklHTPKbg+y2ZgJ74PlritkwMNKrhPoHItvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T8PRR/qG; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsRpV92lwGycrqQDNG3SrdoBzhVRX+0OHe/TWbpGbQ2dXb2SsgElhvDJiEOqGBXGHX5LoOqZxYOM2Y/KYXsZPewDXazt7V1FI/qHErB4ZrnCYz9zlcyURM2+gEl9R5DRqLy0dEvCXq5gvJe+vj21lbFNZ2vdnC50EgVCRry/XyIZNnfu3sYMp6jDcQtDHvyhcLkqzrDhffCjerhLJJsdgFuX6zeAlJhv32MRqHgy1mZltxXd8zX/DY+CWBJgVq1CKH5iK/5Q9CZPJAWnx+jG7vHZuzbesC+Uw7XWNxPif28xTnLcElSnDCW6L2Gnr4dOawdRBuLu/7Bape46LYP2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9WzD2S6+weQbxgJJsPI+oyrRe18uHmhn2MT2wXY7VE=;
 b=Q8V7mCnQMQ5rS4go2Y8seG+RfO96zvMZiVt2GMlQJV04ps+De2nTP377S9eFJj2KWa5duKS7QZFhB9/8l0+7M32w3v18IcKSk671az9VNzjEbgPrvpa3PtdI4SH5VnJNf4XQ8dqefo1SNs62BVkKGGGOEfO3YGiQJ6AsiXLQcHpTvjii6RWqvNtZrPxihtZOdC7yuonq0S87wk5QZ0t/uMZqG/KBqgYBWlG9ELSf97rHhDSp8a0/JOOXOk2fRUwh/FsX7N2/Y7EYr6/HQy6HiaeLN9yv8D7n/BHuSa0ok75DlqOp5P1Py8FlzDU5PEDVgIPzsuOE1AjToysc/NKLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9WzD2S6+weQbxgJJsPI+oyrRe18uHmhn2MT2wXY7VE=;
 b=T8PRR/qGMbsX3EFUMMPXzfrRFkYMXFDB3NkgDZBokzteojjRXVd/1pioWnCklPVkCIjqOLErSJYi6iEhAGEGCMtmkrYSL7z32OAwMhOnjRR5Ap3puqHVM1an4kxyELFva4JZRwnkKPu+2J68wffweEgM6mq7RNMRjOgje6lR6Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:03:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:03:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 3/5] dt-bindings: pci: layerscape-pci: Remove 'fsl,pcie-scfg' and 'dma-coherence' from required
Date: Wed, 28 Feb 2024 14:03:19 -0500
Message-Id: <20240228190321.580846-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228190321.580846-1-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: e4509bab-1705-42e8-03bc-08dc388ffea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JsW8jEnK7q9Z8k1ZHptIdWcEOC2KWaf1Q03qCkBOTbWzUnZ3hlWTs6JkoYvQdq2dDOxAuAdZNTpasLNP151BbDYRnOxSN4F+jCmisvvV9Oj7LZcYlB+QMWl08Eqpp8Vw3UKxnk/fqff/asrDhExuZ4hzYfoXqkbgaBQ71Ci+l2a7fA09Rx8FLpSLUnH+tVpECDdX5thi8ebNoBO9bLdWx+N8eqv6EuRQ+OJfZ2/Z2Ksn1ijrLlJFwrz+/lQ4y6r8WPlVbXk4gQ1SOe2Z5n/WVnFiZSWMmz6jwod5miLurI2ruOKdAmoFhRtldhbxY2nShj3TPTxXcwu8KyLRm7QXbF9FEX3yIyfan0tj61a/VuhqcBeptD+K2Z24r+SKmD/VGfEI/7GWc4U77siryvPYkzdRFVbGvT6f0m4MTbRiPyKT1uc7uxyWyZjYFY5/FYru9OxgDWnD8Dp5nHTv/ztyTON7bNijCNuXL1gzxypl24Zk3UmW1YwLtp9ZZMnrcp6QS+M2YG4VQfWoOQcOUmY+0HBcjRQZGGKRz2i65zXJHtYx/0MLrFoMKs7ivj1AMaU+qCpLDp7eGikMmw1iegXXkQl0ZmXhgJOKVemHrEELQTLFoH1hFPXuN9bXH975Wkjv6kIWGN5nj6SfMdxlRQePZcnK5ZG0MOXe1ZOFViNr/UIAuOu/4F7beg54cffEbaJR7kRQKJHOpeZWVw9cDk83DOP2kG1f/am5ItjCGNkA6v0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIFhcXeQMZp6bWC4q/QvEeNgwLafIN3I+IPDaq/4CTxdzD7dvXsW6/r3oaBP?=
 =?us-ascii?Q?QgLVTSbyy/VTu+NgQCZsjHeIrn7HpGPi5yfVqpV4Nt6mjFjIwePcCAMD6Q8K?=
 =?us-ascii?Q?rhXiNFEUAiYzaqPCiCy1ICbwmmhp3iykkUhcalX3ziHqinz+qb1e8qg1BdS2?=
 =?us-ascii?Q?pihIVMqltZPYTPrIqVCeAKPCbf6YypDsOHUrAC/O7kDXaCxqS8BLXOKCqJ6s?=
 =?us-ascii?Q?4u969K6OMJOT/xSYXl7Gs15NQuxixOSim4qdLb0Uh14RgCgrBI//2ihxpyNP?=
 =?us-ascii?Q?4u7kb5Dw+PRrx3SO+B8nexY+aX6CVUNqTuEdYpuPXXpzjIYHQWTG2D9JxxLY?=
 =?us-ascii?Q?PSy1W7m2We6wDiBjbfhsJ4hOYDGxEBk62P97aWC+0KilhMucjjEu++5+s4Y1?=
 =?us-ascii?Q?hu/j1QpHhezvEw0QfJiCBFyS32UNoAGJ6hBopcyt8aWbRfJMIOopZKBEsqIe?=
 =?us-ascii?Q?944K8i45UGHHgHjc+KOeOjooyQHUqi7kfqFZX1QzEdn3ISE/vlm/WPrnRp6F?=
 =?us-ascii?Q?PnWtN42BSaHYAcrjyQLXkYhIcU8UM7Qtqog/bO278Yw9bIHOttQCD/PzFU2y?=
 =?us-ascii?Q?ks8OMLqW2a29321nddvC0BEYDXsGFRLiokoNPDzoficbaMnnwmDSQysYlxX7?=
 =?us-ascii?Q?1JyNonq+H8e/NP18AX3iIB0+3ibLh4SGfF26ar3V6La5JGrqtv4QaZ56Anhy?=
 =?us-ascii?Q?cgCpTrrJTaeO2a1WqqCz9lt0oEtxdL6z03iecQQ66nXyY63aHZWkk4IfUWNE?=
 =?us-ascii?Q?amEcYIHkdm0+nfgX7kus+1WPzTas8ppLUTqb1C7NsPFUvB9hYbh6kJa/cQJG?=
 =?us-ascii?Q?Ey00Axv2wdRJXIcnQdm8bYUBWhtcpLJ7zZkRCeUXihClVrPf4iF2TTtrFq5T?=
 =?us-ascii?Q?mtvll2u9vygpK5mblCXNYIqF6mvrIfxh5R83gd5gZbHlrNdRNp7vF4HHqKPG?=
 =?us-ascii?Q?ch7o8jcg6FkKB3bNZsyQ2ZdHAKwkgNCq+oL6JnUkHNRS3E+/8wi/txvhotGI?=
 =?us-ascii?Q?iyrdKO37AxAMhVe/97dmg5DUTE3vpeRy5D8Py5qLpWvl7ZNnsoVYsyjRxJg5?=
 =?us-ascii?Q?2DJkDV+ILsqhRpnSEd9O4ZexA51KLbm0+kopfBq6sN0+kXJ3p5O+4gTX9b2T?=
 =?us-ascii?Q?4ZdYAyF4Wcz72+GvxnuJeXC/H18EGW7vz2i+nh0dPNPIC4m382ZQu4d7Dy1O?=
 =?us-ascii?Q?3yw13joqSIO8NXasdugeCzpgrdFNAQxtawA8/DL52SjjKrEpjO5MB3zQ1m/5?=
 =?us-ascii?Q?WHevDAhI1RTFwNCb01Nv+4nkgoixFnJEg9110u5kFGFtf7wfIYuzfR1vkFuw?=
 =?us-ascii?Q?16lvhQ601bzPy84yHFSlnJvHw5eFHgqySAdfaZWp3mBuhC6B+8qGpPSKcWY6?=
 =?us-ascii?Q?2cmJccZzCYgOiU39vmlKXd/JA36uatDbP47/fiKZkb67nafrH32L3OwRvb0g?=
 =?us-ascii?Q?W/grcWXGhH/tcpHGoUfmG3Ihv5Y3fdjUzw8zLOZyifEjPEfUXq4OM3mHcNtP?=
 =?us-ascii?Q?bv8kcScqJgjoxS7etUgvc3KnFnD4Fplinz1orkD3NATWpywZRZJxndSyZQST?=
 =?us-ascii?Q?giyS1CFDgW+PpSaqGtQKq/AUy0S1cjEwhDmyi1/O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4509bab-1705-42e8-03bc-08dc388ffea7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:03:48.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ABu2a0d1VJQ8HjZ6js177zc7k7eh67fFTY5HsG7gLj/46a72VztyOz7ew/QTRVPSikEYydku6OBXBXzAbw0Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

Remove 'fsl,pcie-scfg' and 'dma-coherence' properties from required because
not all chips is dma coherenced and have supplement configuration unit
(scfg).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index b57b627c18e95..137cc17933a4b 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -72,8 +72,6 @@ required:
   - compatible
   - reg
   - interrupt-names
-  - fsl,pcie-scfg
-  - dma-coherence
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
-- 
2.34.1


