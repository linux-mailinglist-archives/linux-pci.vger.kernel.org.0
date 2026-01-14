Return-Path: <linux-pci+bounces-44799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D102BD20C8C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA62307E95D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550723358CF;
	Wed, 14 Jan 2026 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ikV3ybeS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E08335064;
	Wed, 14 Jan 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414947; cv=fail; b=gK86Q+0tcd1VfoRwmUCoZ6zR2W0QAwp0xheySJy6CEEwq8IsAv45wot9W5875HRTiLR8BVLMTQXoDnZ6r07sfsB2tCiuuNmHXN9rAuyOP/d9bjMIdMyimmLnTJuptaaFkaMpOapOUZkAypBKalNKoxG0ZyYdn45wnphz9F3BKgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414947; c=relaxed/simple;
	bh=ODDZnJ2T3GlRk4sZ5tuxXJ3xPBbfJ8N+fT6EYx4VcG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTkjh7Xyy29QNRQeW0ymqqS/4jmEgPciioY6pRxkNdHOc7gVfhPXCWjsipQr91L2NRNHGB9x2+8aAmJqQjtj+41l3OvmeKK/yA2YIf1ntmbCysWUMNlirILldmdpnyVj0a+2+rOvMnWUz+Uixfs11VY6Ncj1kiNRDkP57tUNQJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ikV3ybeS; arc=fail smtp.client-ip=52.101.62.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ukskcw2tkjJcHD4R56ilGlK6J16TfxYu2H74QIiwhrTwpNkJEZwY4kfKeRtg1IxVbaLbrVAGAacfzyaH2lBVevnIcvO7SKnZh9qdztfP679oXxgR/m4z5InFegrIJf0/ukGKS54S2Zyon9WcF59xXEoyxA9Fr27wfXMXjvT3lHHUvKivT/QCYNjLi7eMSW49lYCB1D8RY+iiAgV4nOAIq8HVm0ysLeIOSdnWxmEdVIiMa6w4kdKbCIxB6T1LZH5xAqpg3PHLgPmH/AIQOu3GQak3/k1ZxAKZQjwHXE2QqeS6nLm5DaE8pbBXbGQgYMuw7riMh826jDwPK75vD6SKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVsD6T0XY1lb7jjWdCWNzO+ZsBZd985kBAsNna0G57o=;
 b=m2v0BckNxQNPQNrBw1fCI7Cu0F4qgfybMOGk94DH9zG9J/CZfrmhz/HsoXNSs0JqtsAgrBJF0xKskHRSNIYIDDi8eAKcGD9rpyXacUOH/mWuY/lhqZYWJevOwztNncVkgi9y+9nyqbLzSkZlZkG8t+qwUnmLEFCXwwkPp+w7mAx7qK1oLRib4mEkPf4W6cyVyG+44+fycFSXFN4JGCTnJvDl8NZ2o8LzItjk7uXEgc8ji6wEWhpk7rZLn9A90GMPlXlOGyrdqMk1nzOc0orSpvj6gFnPPLEK+a8CjxZbNn7BkTHv411Dd3GUJaxqAJeqUv0StjbTFfncvLP2ZX+1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVsD6T0XY1lb7jjWdCWNzO+ZsBZd985kBAsNna0G57o=;
 b=ikV3ybeSLfiI9Syg3QiYI4bQZ1J3zUOYza5W0cnpJKwqoq8QEqfLFFgZP11xKLZoX0yF7+m35LnaS76NFxacNcLeCdFs4x4AXYV8rS4ge6nXcX0K36iUiCt0lIYIKfoDc8sdEoQ5BX+opHNeyLRO2ALSlmqvxmtUjWet97mNKK8=
Received: from PH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::6)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:22:12 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::2e) by PH5P222CA0006.outlook.office365.com
 (2603:10b6:510:34b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:22:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:22:06 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 05/34] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Wed, 14 Jan 2026 12:20:26 -0600
Message-ID: <20260114182055.46029-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 298c19cd-b2c5-43a6-7f9c-08de5399d591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5A9RnfTWnMGedSwGTCSHOhlGXMbgXuCEJofV2hY75t9cxY8nIEnTJpG/2+F?=
 =?us-ascii?Q?y7ms/sVPwpQ+8YJ4TP7FbhFAifF1ENmt6QSWt+oyyIPglpNlCg/rB3xZEyq7?=
 =?us-ascii?Q?WYn//328LvBQkY1fEIEc+iMFIX2ICo3Po3x96ldkF5A3rpGbU2RpOKgTk3aN?=
 =?us-ascii?Q?AQTh/wpypObW+T8r1S2kIXp8nHk9GrztJgOuSS7gDTPkMBrT2O0BRcoTPCLS?=
 =?us-ascii?Q?MqA9ebtBdXtLYuMMr2Xz2VJr2wgPyscmXQ368HpQHQ2SSUya9NuxhVajsGoB?=
 =?us-ascii?Q?xdYmLzjrMUPL7iLptq9Cy+y8Q14nw/HnVj8Jc29oCh40XiqodsLnXiL1A0pl?=
 =?us-ascii?Q?DjdZ3v1aO3CxXIvShVAZ+QZf/2WvqZMYHbe2pLwSjPXTPIvTnxVIqbes4yuH?=
 =?us-ascii?Q?F53luwcvJ4Y1puzHo8qm29o1lCeU9n5Gbczg+cPta7QaXzZmN7OKnmvIZyfn?=
 =?us-ascii?Q?HU9ZfTx9AppRbn4qMF/v+Vx0WwUu/SZI35ddiNyejAl+Ne9hN6JHN0f98qI/?=
 =?us-ascii?Q?Aj7Gp5/w8zwLlACbJLrTfvdmLZKb42SMHompoMWMivHQpUALFD4cMqVY+Vo5?=
 =?us-ascii?Q?JMgHxfWun53QQNBotJe2nYTrqpYDZTKg0+caAk7ayU5K/i5c7EJtCVLaZEqK?=
 =?us-ascii?Q?4t15IKuticVEUk/Eo/YC42tMk/0WYHQpmKImYIxB1vgOUl1lVfmCbA4JiZ1g?=
 =?us-ascii?Q?kCbjpCJ/sdBGykc10WDj8cMcD16EKEa29FX74d9Z5iNE9Y4GX540uPo9lXN9?=
 =?us-ascii?Q?6yvIBdC0tB8C2Xw78nVSBh9Xw73bwNx5DJWngyvuitPum3fDe/EfgS38s0Hs?=
 =?us-ascii?Q?Ds3G0DlhpE+S7dSbv2yUFgsj4rF4B1h9NawBN7hdUvFZ7O+dRpznajZIaC99?=
 =?us-ascii?Q?zj3l8FkqZgbpaSHLuIY31aQMga2XRZZoO9Pisn8+aZtrcpehDDmYMIws6uzh?=
 =?us-ascii?Q?UbChHzVfEFj51IF+2hPNWih3J1vG130j7hVgx5OEuDQBJPmq3AjVOKQXxIL7?=
 =?us-ascii?Q?nnmiZBA0NAPMoP4dLVrlnw5MHf6vtEiDfG+k/zLe47t6Mhb+zARwvQBZChKM?=
 =?us-ascii?Q?cZA4St+tsXMv85khvoaMTU77aW4NNqsGK8MT9stH03Jv+kKYBIpVa8dOB47w?=
 =?us-ascii?Q?vqImLZZLs5ZotSvx1rCN3u8aEjBiymnioLv/6g8yM2xEr/Lr5/zlIBWoBFCW?=
 =?us-ascii?Q?DvflexCGOl6XtJb4eCzvKMYoKGN2uMDslc6/hyaHtl64N6MtQ+XDNV18/fzh?=
 =?us-ascii?Q?AW9Zr6jlqzNYF6nLP8/NEG9RFOTHrGWaTTQFJsxwG2rghvmimyafqAfRRcnS?=
 =?us-ascii?Q?ghw3tiVnDiiKW10flok/2DuDuPXKwlJ1a67prq0dvA5n3kWpgr9D4Q/TqU4s?=
 =?us-ascii?Q?I0aVY/DQu1eIiBpXndud+jxgAPtS0+l7eJ1BLmGPDUfDBQ4hSpMp35sKZ18M?=
 =?us-ascii?Q?OYvQ8Fp2Y6MD+OdDZoPrJKVTCLsrQjz1yvTnh13ZDi+1QDttOoRT3eRncjhL?=
 =?us-ascii?Q?a5AlvcGt6QIOyRKhjLqR3uNR9WtRkQdQDzko74x0+1pT/0c3qv3upbtPOI+u?=
 =?us-ascii?Q?Rnq7uAFcV38LxvjSUjyiNODvgZKeu6F9p7CanfCkkNlMIQD4zY97Pe+uLf5J?=
 =?us-ascii?Q?3Vqlyp/TJc/x+IXjt8jbmkvTcu9yYsmDLtv+3ZINgCZ9jum752CwKgO1S8q5?=
 =?us-ascii?Q?MQysxVK/RDwdhHhV8LVC75EzdAY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:22:11.0504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298c19cd-b2c5-43a6-7f9c-08de5399d591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
to Restricted CXL Host (RCH) handling. Improve readability and
maintainability by replacing these and instead using the common
cxl_handle_cor_ras() and cxl_handle_ras() functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- None

Changes in v12->v13:
- None

Changes in v11->v12:
- Add reviewed-by for Alejandro & Dave Jiang
- Moved to front of series

Changes in v10->v11:
- New patch
---
 drivers/cxl/core/pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3ec7407f0c5d..51bb0f372e40 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -779,18 +779,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -860,9 +848,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	pci_print_aer(pdev, severity, &aer_regs);
 
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 #else
-- 
2.34.1


