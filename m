Return-Path: <linux-pci+bounces-33212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82702B16888
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C0F1897F08
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCBB22068F;
	Wed, 30 Jul 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RbS0nAC0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFF13D246;
	Wed, 30 Jul 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912170; cv=fail; b=kUFjY2OEfxxo7CzCi7ZzIGFpHUdDfTHw+n9VBUhTRICDDHlKTD+wtH5Cq9I6vJ8+54cZVabGgE79DEcVc4Gr55ZZc7u0H/K5+mQALmFAqALpzttF8XXEU5xLMEWc14C2COA78buhNNOldlh1hboc/1VE7IWl7/ORq5TS/9hFHUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912170; c=relaxed/simple;
	bh=cYuwuyJnaL2u3guW9x/PfbxwjGrtibaGJEKv6LUVjjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTG3/UNnVgo9tCaarAskrUUzqHDSLLtOwTtLd8AmrbGcFCCg/sZZY8lBc7mjsnNq3xObmWLkXSiPRvI+g36oR+GUe5EJcQZ0W1myay+8JIsVAy5lWKA3g556hq5m5HbijGPlYVMLskhOk70Qhjy+2Ut7tOb6XUw666g277eif14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RbS0nAC0; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=triLGRaDWdJj/8d2OHezB8IXxehXpslUifFu3dsObIbZGXd+VYLga3RXYtRSXFxpVprFOXUbcn91VxCuf2HoYPkroiy9qpOU1OVWYRvUzebmmpIFWj/Fcp+uvVUOWFGCg+U9a7/TdYcHreqIavigrKjFTfU544MxcdI3xXoL4L2saGcNdled6rCejhJR+Ah5bXOlKTkdwyQwUucNOviPE2FX89Daj7MCKkJ6AtFYppPmiOUfXfOCsfXImSp6cGIqzTePpKjs4yIRYyRbHyZxljc/UNOQPQzeHqgLNnn08BEBFqsRjTm6/Nqz4ZXMLuZXDLLgh42Qg67RK85fsB0FYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4ImSCtJE0dQERHN8UzzhcQVUF1TdNuZ8Zcq0jf9R7A=;
 b=iS51kp8i92GtNmLq9wtCjGgWDHOG8iOtOU/CItFEEltsoQ6ZL33a9GC3mUDr82zJ2FAxI4Gx3lR7PLniCVekoP1iRGP8l9MoqyuaPw9YGXqaDCpGQ7aAhkKeS93c6vPqsJm/YdyKsrSVwzEJnoW0IfCfJxH2XjbPkxDROCZJHKHbrThFTEfkIuhGMNkJZLzT7zCEgbm7uIYqD6bsaimWA4wrc9qZhE6aHZNJfZF1HjN5YLg2dzWLXvWC7ossB1n1jQaq/jWn6W7GE1tfnHOQlk2cdGuElfEhxolPgE6DfEMgtTTCQcNaR68EMvQXXGNkCIUgzre1LUfkqtFh97DBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4ImSCtJE0dQERHN8UzzhcQVUF1TdNuZ8Zcq0jf9R7A=;
 b=RbS0nAC03FqvQesTAX/VRNtaJdlzzmrAFaeqP5W3J4V/38bft+B4qhBLp+gNv1lmpXOCh1ob41II5azVkvLE7g5tH/fqSQL39qxk/hLkKa3Hvy5IfZSOBbzsqx5En2N8xmh9fK9i/FfSohVkTKPm2JvzaJ72d7JXeqc3gRUwIcM=
Received: from BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 21:49:25 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::91) by BL1PR13CA0128.outlook.office365.com
 (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 21:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:49:24 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:49:23 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 08/16] cxl/core: Enable CXL isolation interrupts
Date: Wed, 30 Jul 2025 16:47:10 -0500
Message-ID: <20250730214718.10679-9-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 347adee7-3ee9-4c39-a0a2-08ddcfb2f34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wn2BBHHcrxguIt0A1BtzyUVaJroMqZvbVamtKAcK7R718YglTxITzdfE7/B+?=
 =?us-ascii?Q?STyJko+HFdZ5+h+plLAjVdlYOZ6ZTjehk20a1zPV7x4xhTuxDYi1+51TwoCl?=
 =?us-ascii?Q?XT4Rlrp2HcXpSHB6hMVfIyUXiXd7R8kT1wmyU3peJMqjzDzjKtYI7uwuScTy?=
 =?us-ascii?Q?yNXVpnoV78PcZMlZvA3XMhHqdTaPtzGrU53NS3XmWTrQzjSx9QiwrgI9rRg0?=
 =?us-ascii?Q?Yss7BwFcQVg+nT6N82kXdMQ13Ho3M+XkMw4zoq9uYk30Z+VcV7y9pe/Uffq9?=
 =?us-ascii?Q?P+vWi8x+rVKPMwxsF8bXmLsPBhMK520IkBFDdk06ECog2xINQ4XlxrllPnZZ?=
 =?us-ascii?Q?dK8GpjBobvVlpfKnmjiN78K5y18UhWAouKIZ0jBZcMywtmUOU4w0UinjKHkO?=
 =?us-ascii?Q?GpHKDYphCke65CSi376BXklV8iSiEOSK1TGZPIg4+bm4U/Qg+8Ijwmz2Ga4a?=
 =?us-ascii?Q?EqSGjun7DLt0ymsTh0RgPxv9lq3IXsY74zFHNxR9xh0SE8C6t50Bbf3UkQYF?=
 =?us-ascii?Q?Q57hdJZiTYCU3xZqw8fq4eskdzJTAMgi2Jic6W47QBNxx3XKSD6Wn9aOP1dS?=
 =?us-ascii?Q?LYysLrKdv/da/3sLPkk6dajPcjsgEBSklx2UBrBs0ISedoC7JB3foZGy2A/v?=
 =?us-ascii?Q?BRNqJWZ1rnJIROHzqkl0l/56N7/XVIbsmKi1mTcdRjm7f+3fPDbOOBAcnx+m?=
 =?us-ascii?Q?4cPfgqiBP/X/1rfTcCmVvuqsrPpmTFN+GIguF0Im24Nit5TlGLqcW/U6ET/Y?=
 =?us-ascii?Q?rCil5+820I+GrkfwoyHvjCsapIIXPxzwsXpu4BT1VZtCt4E4JqaxgmMCtFbC?=
 =?us-ascii?Q?5LeNxCgNAH8rnN9BMjnJjpBu/Kg1SaImjHYTpnKpzly1hIZKRngf6200Vcmb?=
 =?us-ascii?Q?42BrpJjBzv7HSX0D/pT99BNqh91wBbCi1376SdgcybmURid124hTfurCNXTT?=
 =?us-ascii?Q?r1mMYgh1DrTbW1SaHdpa3SJ8w/V7PSWtMABIqthyRONpQy4UKbC5ujwDcGMf?=
 =?us-ascii?Q?6glcLtoWyHfI9luA1kNMGz579n+G5AEPZn7tCg3nJlbQzgytcqRlVjnwG0Vz?=
 =?us-ascii?Q?Uo84FQjdHpY3zLK3tj5Rxh9tASvFETJB+ZdpanAqA6OPa7/JEy8V5gg4R7NH?=
 =?us-ascii?Q?NTsZxokL6MpfEatefaS9a51gdiiTRXz/e5rcFRig085B7K4vciw6B0iGpJZp?=
 =?us-ascii?Q?PX+KXHAieJo7PXiaTd/FsiAz1QI8NCY52OFTSAC2uae0JTl4qSarJeKJWy6o?=
 =?us-ascii?Q?+M/XzNd/tnHodVaysWRxeM+eSkNa2bWqqqEjPM0GGufLc0G6SJ4kdkKwguYc?=
 =?us-ascii?Q?giblbdsaWIyrTbW3p/lSTVsT1qFhDDPbbAEmk6M5d5skFY8md+yxhnclKagT?=
 =?us-ascii?Q?3byz5TkW/cE4W9nLaoZuAuZK3dvdcFOVEECAk+930sxIHysXwkrvUs5BMsTy?=
 =?us-ascii?Q?kEHolvPDj7MHlK6mQUWyZwn2v+HZjh9OnB4fYtvkBpZ2jSsAZQT38wMUJ5fU?=
 =?us-ascii?Q?X1gEzbXXaL3aNKdQjdmllMs5lSt8N9/uFeze?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:49:24.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347adee7-3ee9-4c39-a0a2-08ddcfb2f34a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

Add functions to enable and disable CXL isolation interrupts. Use these
functions to enable interrupts as part of isolation set up.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/pci.c  | 22 ++++++++++++++++++++++
 drivers/cxl/core/port.c | 10 +++++++++-
 drivers/cxl/cxl.h       |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a84151238e17..4702a1f27318 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -146,4 +146,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+void cxl_enable_isolation_interrupts(struct cxl_dport *dport);
+void cxl_disable_isolation_interrupts(struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c4d8d9690214..89fb6d3854e3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1172,6 +1172,28 @@ int cxl_port_update_total_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
 
+void cxl_enable_isolation_interrupts(struct cxl_dport *dport)
+{
+	u32 ctrl;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl |= CXL_ISOLATION_CTRL_MEM_INTR_ENABLE;
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+
+	dev_dbg(dport->dport_dev, "Enabled CXL isolation interrupts\n");
+}
+
+void cxl_disable_isolation_interrupts(struct cxl_dport *dport)
+{
+	u32 ctrl;
+
+	ctrl = readl(dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	ctrl &= ~CXL_ISOLATION_CTRL_MEM_INTR_ENABLE;
+	writel(ctrl, dport->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+
+	dev_dbg(dport->dport_dev, "Disabled CXL isolation interrupts\n");
+}
+
 void cxl_enable_isolation(struct cxl_dport *dport)
 {
 	u32 ctrl;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a36440e85647..90588bf927e0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1236,6 +1236,9 @@ static void cxl_dport_free_interrupts(void *data)
 	struct cxl_dport *dport = data;
 	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
 
+	if (dport->regs.isolation)
+		cxl_disable_isolation_interrupts(dport);
+
 	info = pcie_cxl_dport_get_isolation_info(pdev);
 	if (!info)
 		return;
@@ -1272,7 +1275,12 @@ static int cxl_dport_setup_interrupts(struct device *host,
 	if (rc)
 		return rc;
 
-	return devm_add_action_or_reset(host, cxl_dport_free_interrupts, dport);
+	rc = devm_add_action_or_reset(host, cxl_dport_free_interrupts, dport);
+	if (rc)
+		return rc;
+
+	cxl_enable_isolation_interrupts(dport);
+	return 0;
 }
 
 /**
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9e3ca754251d..62b3ed188949 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -141,6 +141,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_ISOLATION_CAP_INTR_MASK GENMASK(31, 27)
 #define CXL_ISOLATION_CTRL_OFFSET 0x8
 #define   CXL_ISOLATION_CTRL_MEM_ISO_ENABLE BIT(16)
+#define   CXL_ISOLATION_CTRL_MEM_INTR_ENABLE BIT(26)
 #define CXL_ISOLATION_STATUS_OFFSET 0xC
 #define   CXL_ISOLATION_STAT_MEM_ISO BIT(8)
 #define   CXL_ISOLATION_STAT_LNK_DOWN BIT(9)
-- 
2.34.1


