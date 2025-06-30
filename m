Return-Path: <linux-pci+bounces-31042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9CAED34E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE2917041D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE901E7C12;
	Mon, 30 Jun 2025 04:16:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022105.outbound.protection.outlook.com [52.101.126.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311C1940A2;
	Mon, 30 Jun 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256977; cv=fail; b=bevJje/Amh0pVddeTVF3hnum9tGloQMzu6MtDxb2jiF05bPmo4gZ8JYyMRgXI+8Bfq37fMcdA6aLUzvS3vC6NmRTrPo53TgJ78MuP0yOO2wabcg3vHctItKOr4nyeEqo45w0Zy5HWorWQug04HSd0jFG72/SJDmrbLiEk5041K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256977; c=relaxed/simple;
	bh=T2mbrcSv/vs8x5MfKDQBOs/p6B5DuhgFnh/Y1RJSQNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAHjPht6R83D8ZNfjP/mMasyEuyMo84kc5u93m/KkK6CKvmQ4zGKuZNSTW7yAAaWcEDr9fjQJnwAaSf6GmsIGVBF4s9Rn0NZf3NsCLbVkto8WMR8AVoIC5mJZWcRbzECFk5Ak2wO2u//PxQifUnqpk8p/PiLUU7qkzHJaXTCBJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzXiryaq1RsN3DZUZB14KQM4jLaqvdBvElABspRI8AvKljNqxqXiyQElIiayCsVg16C5lGHq+Vk1KhEG1nGfzFMBaNIgGlrWYYRV2kG9189YGb/fmtOQPWSGdJey9mm8LpEjXs12ISDXkrkM5WUytjSMJGFe2zoVzQezE5GsZbtg+Tk2jtQZpYLQFKv+qxdhZjv2iB0Z64UwJGzkJaODADW9KGj0N3d0EjRbda+oG01ibFmd6hhAMgPgIvFUlLrNmIerp6YVD5owDUkSqIds5Metdj0moDJTk0HaCfkHNuqn8GauAzJDWr/5byUTDmSuiw8oMwv6YJd7m6pTikOP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhPY/Hi8cYYXF5qNOD/dUX9O9G88sdgtMYq9YFr7R28=;
 b=Yqebf/G1zxjc9QsLru0CMbMeyAZMd4pCaW2KXqWWF6oq97Cg9wC/IXeSr0pxNsD4p/BXGx2C3fO1eDd4w1o0fnzAxDRG9u0M4FPLbFWaDxl447kPeoUFQYQ60LsZ9kDISRVgXSW1uqcNUPFshTlLkGXZnxqYtFBafVpC1/6GLG4pb4tP5z9B41aGW9OUU5JiQKA8RidVIIF7mpvhmMVcgu8D7qyZgZ6rqWjLNYNiKnjd/X7438JDgbQAEx4FjtQ8SPpTrT4gBjYq4pOGqzPZf/9HwaXQ5ba3e83Uy8HLZp/lqPN6k61tr4Pe44+JeyPAQo70YJum2/nc1QwBy4BWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0035.apcprd02.prod.outlook.com (2603:1096:4:1f6::8) by
 SEYPR06MB5061.apcprd06.prod.outlook.com (2603:1096:101:52::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Mon, 30 Jun 2025 04:16:09 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::bf) by SI1PR02CA0035.outlook.office365.com
 (2603:1096:4:1f6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 04:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:07 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 76AD941604E0;
	Mon, 30 Jun 2025 12:16:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/14] dt-bindings: pci: cadence: Extend compatible for new EP configuration
Date: Mon, 30 Jun 2025 12:15:49 +0800
Message-ID: <20250630041601.399921-3-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEYPR06MB5061:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63833e15-d053-4d1a-3377-08ddb78cd640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yLXu1bhsS3FaCrcDGRwmw2G3egoo+hhrNbPYWF6DpHd/Pv3nSIfKBYIhRIzt?=
 =?us-ascii?Q?zskrzTONYYjb3f3CRQl7Qbp1Myt/S76Hxj0FyHfqcWdCairqtQXK+ghzpQBQ?=
 =?us-ascii?Q?ss+P3N+yyLx82gVIDcoEfHnYJPmYm4AYgz6ZmPE3qdx/iFT+F8f9kF91MycG?=
 =?us-ascii?Q?kHJUrR+7REhSGQNzZEhxdyk3NHFDe+WvEGBzl3h2OBy7oUBMmTxQs4HU1OVT?=
 =?us-ascii?Q?FhfPVbA6iWkeD7vKlQoPUTvp4XLK5f3G0eydu9RMuXbJhhGd52q36KF8oQ2B?=
 =?us-ascii?Q?pB8Vhu1IOIRGVf1HY9amHeA1Rn4JgIes5L+kKnjp+hxHk8XaXRVTVsVCQuHM?=
 =?us-ascii?Q?mRIolIpepbHmSJY3qnnlO0/WHJDP/KbtJ2Lm6zK+iXKLDOEbLIUs5hhJNNx+?=
 =?us-ascii?Q?w+WD3IsiOusRXF6IzPGD0o841gzyFFBrWZrQaBM+QPpW/kVTFVxUg3DdWfgT?=
 =?us-ascii?Q?Auw4b/+oNslkINnPP+oGLuQH9ynmCpAYUiSYWeSHI0qP7m5FylvuR0WyXgxR?=
 =?us-ascii?Q?bIca4yJdK2NavlYzLNVk2sw3G8CzLxi3VoxNEorz9o/hxz9s719eXsQoQGDz?=
 =?us-ascii?Q?rra6kI8mob2ZE8e5+bm+IG4oB1tfw7PJRZmiEWdIc5irg/PNZeuCV6V/huv9?=
 =?us-ascii?Q?GSsB6P4vXNo76L2OSO9qxxHAuA+Nu/CnyIpnsQjrIJKCIWUtuJ6YPQQpKj23?=
 =?us-ascii?Q?qb8MJN/piwDLPLzRd+dK+x9jD9puzUxG0h6RcuSRaUEwV9TsYomqfS0C+iir?=
 =?us-ascii?Q?lxmoW6+V6Vv16XTvIcCTIaOS9KNzvJBl8HgxIoYlf8O6RadsqqQLhn73dhVI?=
 =?us-ascii?Q?8kVrJxpv4t+9CsA5E4RI9zptoTppeK0p5NM+Gpf4WoNzey0KJ55yFfCdXWmM?=
 =?us-ascii?Q?hj201820kG3V++4roHYCGSQpp0KqAYAwaS4sNC8kpmMEqNZMYvfl6UFM6vTL?=
 =?us-ascii?Q?ym5OMQYBL6SJbQw1PWg+fgvvpTzs7NzDRNoY1SS6PBmtbHTuPLzILvbzvu17?=
 =?us-ascii?Q?BjT1bbo8Z9WdCI1pioCBH4QN6Lw/D8O4hPZTjKs2EPflEMX1s4m+rtMjSRtO?=
 =?us-ascii?Q?s3906PI5t9W3Q9s6T///ttn90seEH222qwuh3sg2b8bKlUOLLFt4DtSJxxxC?=
 =?us-ascii?Q?g/Vaq6SAaWwekdxCuZ3cS6LMru7P3lny88SpJWCZHB1Gfr9j4bzpKa5rHlr9?=
 =?us-ascii?Q?uEUohzzSQqoS29d6s+BnVzrqLQUqqAhpy8DKg8WsJ70Q+DLPPTxDvipQ5zKJ?=
 =?us-ascii?Q?Q40jWJP+0MIYPxsUNA35CmnH2RR33lU1wZdnWCg6ua4sm2g+wPW9Pr3zEek3?=
 =?us-ascii?Q?NYv/HoDJRoEkOMpzuYISDkscf50cM1I+3K9iWPyQmi9LHverDLt+J8LZI2OY?=
 =?us-ascii?Q?oXeNatSkA57w+9vxrlt+eV9U06r9AlicuVYEH62hZ2P6zmMT8bBSk4+x2J5D?=
 =?us-ascii?Q?EOTTNI+YNTprI+iCqVCdKNgBRBDns6O73z6RlY475veFNLYoXOwwzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:07.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63833e15-d053-4d1a-3377-08ddb78cd640
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5061

From: Manikandan K Pillai <mpillai@cadence.com>

Document the compatible property for HPA (High Performance Architecture)
PCIe controller EP configuration.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 8735293962ee..c3f0a620f1c2 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -7,14 +7,16 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cadence PCIe EP Controller
 
 maintainers:
-  - Tom Joseph <tjoseph@cadence.com>
+  - Manikandan K Pillai <mpillai@cadence.com>
 
 allOf:
   - $ref: cdns-pcie-ep.yaml#
 
 properties:
   compatible:
-    const: cdns,cdns-pcie-ep
+    enum:
+      - cdns,cdns-pcie-ep
+      - cdns,cdns-pcie-hpa-ep
 
   reg:
     maxItems: 2
-- 
2.49.0


