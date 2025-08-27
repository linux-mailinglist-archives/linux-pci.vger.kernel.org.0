Return-Path: <linux-pci+bounces-34821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F36B37710
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53EEF4E286F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868BF1CD208;
	Wed, 27 Aug 2025 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c4b0D+xy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDC1D63F5;
	Wed, 27 Aug 2025 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258607; cv=fail; b=Q6KqR/plqHNqJZC2v0NIL2ijiwLiM4YoxY9WkQbIqVH4ztUU8MNFIpX7QKG9nD7EOB8f47n8n1nMP047aQVhefjXl5gFfy3NAkYUZ6sayL3S8O8HaDsH85t4irRzdg4IIyFjBXuIF5hZLz4ARpVzyVrWJmwEIZjbK9jODews2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258607; c=relaxed/simple;
	bh=K7POOJTlJNWfmeLeQ/UOa8K/n7SCcyePLJALUbQQHUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1FGEhgR/Y6zfa+iTgqMmcdbO8SMfo7lN6F+3KWOuoQHj6+wWSotFBbxdaCYXxKEhRETMUoKVh0DPiX8xzZfKZXlCDxeEu+7Y9e4kSYu4IDg1lRluSQpjI8PRRvEnR3BDQljUr2YbBGoQMsHlwgkoddflV32EP2FgySSJqgWYXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c4b0D+xy; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb0y6UKebUwm2qpCVzTB+ks/GZZdMGqANH1sMZ61B466ewcMwHsuvmzdYyYO2k/QFjRrii3ao7yMQA0Yef9wRSNrMCK5EMtqjL6W/wgceORMRJqVQwkMrnB7F12vs35U+yU5YuZICmDcbKLOMVf8hlZTQ9VVDlZQXLlRdpF5AT28JpPrQhCfa3DoLsz6Sgd4KebYMtaffrnttRphaOK2sNoDKjShR2z/KIXq1h1hhLd7aFhOh4UBFL4w1hbRVDvPuoOzCLIjeyoHVYiA87/RfZvd/BLT2RtKN1lTWafO3xn00euQtws4gemXmg0grqvtMFWrPqOP4voIWJB+XltpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlvO4griV3A6f7aO3E/Q68khjyf2e98RfN+DNibtUoo=;
 b=QUBe4sDlM4E1Ol8n8gPMQuRSxgtoaC5fKtAsw7FEGox8OFCICh9leSzkVb2/iVgigneL1zxBfusXSauDUCVGiom+3d4KY31kdc75mPY/mdYQcp1/njqQfsCCUUS/R1Es8vUI+8r6j2ik92dYpetlyUijnn1t3Hw8X0d5IExc2LnA3q/Ij6cFlim4BZ8308C22tpK2jdPzi4/1YLqdwWx3VzmYSnWvM74dElPHSSnj3uGQut7tIA+0fjp+X9xmb1CdGKlQXoiqGXWFWk6w/Xxmf6pnDolIUy2RtHh2YHCn4bClROhKVjrgy4tOWkO4G5PiYa/3sOqrGOLNnMVotJ3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlvO4griV3A6f7aO3E/Q68khjyf2e98RfN+DNibtUoo=;
 b=c4b0D+xy0XDNAKqU2RJOZvpo526/FzEBciuS2z43nu2vHj22S7Q9/RECpy344el1Mohq7SCd8urTxNzwbJNJCQXqaB6MhdSndqpuOp1Ho2QW9rCyWZyWVHY+pyNtIdGYWa3IKhX0kxEgPP5FhN23yVK6zkgPsRiFw1MN9hniXTU=
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 01:36:31 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::f5) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 01:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:36:30 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:36:29 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 04/23] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Tue, 26 Aug 2025 20:35:19 -0500
Message-ID: <20250827013539.903682-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 8570c809-5f44-4e82-a499-08dde50a2634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npfz0LZmLmi5KIZxCduML5S4bke8C4W35bO9Oikt2nWX6h/s/9qeSXXFwPaX?=
 =?us-ascii?Q?nkj/i3JSIj5e5zg6LclLjcWfSjt3rVQdgBOyKeFZ+0uq+ooQ28FYdSip9J9c?=
 =?us-ascii?Q?lDs9WIuRInn7AiEqPVvUpjc85kbNI3am8hI+/Q6ARlx664WJdZcQUwRbCn4U?=
 =?us-ascii?Q?22c9oJMUU0bAhJXQ9qAEqgTuOsNLK0LCgwm7edxAjwJPmBQXQ0GNMV3sY2zf?=
 =?us-ascii?Q?JC9w0K3fzh9S/DOzJ+gWuPkmIM38SarvFxzOZ0/2byoHcLsxZ2rH+kIzsCBs?=
 =?us-ascii?Q?7SqDx7a4zqlucF1bTTtFqMdfoTMl4uAu0w8b0xoynx8fjevaGoIeBBplyfiw?=
 =?us-ascii?Q?E92oeVjMcQXg7S8B/aSsLJwXbqOKawWuBhSoq8AiFo32IT6O9EyBH5w3LLfW?=
 =?us-ascii?Q?rmjvrZlYKBhw6ZjFPOsS5ZMQzP1BmATx5+4YJM2PWA52zBbQEr0XN7e+F1k7?=
 =?us-ascii?Q?AYK5sEiw16sIcYdGgxAz7UneJBPznEUl8SB5ACg9ClfR7CbKIk6l0LsDqCCq?=
 =?us-ascii?Q?M+ga6qNmQ+RHWomgYtOscJugCJBvr4KI8iryutSKF2LdxNd+sHCWGNWN8vQ5?=
 =?us-ascii?Q?v0UQQioNl6tiC5UJ2y0MCUA4h81329ilIiOKby8QBpS0vb9kywhpY77p3nuh?=
 =?us-ascii?Q?3F1HcrCl6C95EjDbeBAX9z8brC625bzhHyqkES4YHFRNMKK/j12vLYud/cG5?=
 =?us-ascii?Q?S4SQkmw8dNAQyYy1BovtAH8vY0xBZOz3QSzcj6LIpA9twrU5oithPy4cHzNS?=
 =?us-ascii?Q?lLBjIkcbNeD7Gv2I6+QePJKle7xLiOxwPP5KkQgcQs2XphrYjsyK92g0yrff?=
 =?us-ascii?Q?BA7G51TNqWARr8V8XRNWKbGTKGDjmhU8EdXZ2yEfzQ5oJQeRMDRfjZTIit1/?=
 =?us-ascii?Q?ZTdEdg9/iGDwvGDHR4kuPp+rWbItLBE3nS7TnT403GBk03pPIHSshk7KARP6?=
 =?us-ascii?Q?CFEc+DX5dJBwwz5MHe3K2KomvhQV6+qXInXI7II/jK0YC9BKE/91PyNNYwHT?=
 =?us-ascii?Q?dIvrXi9IkuFBSwIjZESFDpHWIopjLNbgEUy1B4Lnoi0OrFQFnCsD++Tw29JR?=
 =?us-ascii?Q?JoQ/sKHGRkfDB9lVUaqCVkEkp/jZFwQj08NjdQAQMSeeGfEjChSySBYJ7QQx?=
 =?us-ascii?Q?zvPOW1PAZvT9nig7vHZZ3dA7Q+5HeP1RjOCA7P/mC+qQSFfTexGdOfi+8szq?=
 =?us-ascii?Q?kk+/aUCZcLpX7FQMxK88JC3JUFShwrdbF5r+n8Y9PIzJCGvgXo7X0VJ68MIC?=
 =?us-ascii?Q?R8TDVv/MQaKvAx0U46q32XbFzIjSc3+b3Zp1/l+zgkQ09BZRlWpG4c5YaPpp?=
 =?us-ascii?Q?9OipT5e0Pe9FztTM3MN9q8IQCIebQZeMZ3HWfApIKo0phe44rBHNNFLxlWrv?=
 =?us-ascii?Q?FDfYyc6enR+uVfBmak56tr5rk8vGR+wLzOmlUdM2daZhS4MGEx5QIIu5YUY8?=
 =?us-ascii?Q?//u4M10UvAQ1lpi92t5HbOM9UFdptI+9huINTrHzCYApAauor6923kFD65EV?=
 =?us-ascii?Q?xS25K8LDQqy5lLOJ7auI0ysDLZutm//2wVJnZVJa1PJPRl1K+iag+0IXKg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:36:30.8553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8570c809-5f44-4e82-a499-08dde50a2634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
to Restricted CXL Host (RCH) handling. Improve readability and
maintainability by replacing these and instead using the common
cxl_handle_cor_ras() and cxl_handle_ras() functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v10->v11:
- New patch
---
 drivers/cxl/core/ras.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 544a0d8773fa..0875ce8116ff 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -233,12 +233,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
 	}
 }
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-				      struct cxl_dport *dport)
-{
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
@@ -276,12 +270,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	return true;
 }
 
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				  struct cxl_dport *dport)
-{
-	return cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -350,9 +338,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 void cxl_cor_error_detected(struct pci_dev *pdev)
-- 
2.51.0.rc2.21.ge5ab6b3e5a


