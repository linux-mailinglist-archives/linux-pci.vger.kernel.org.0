Return-Path: <linux-pci+bounces-3546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C3856DF7
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D651C23F32
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BE13A86E;
	Thu, 15 Feb 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0WVzKEvZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761013A252;
	Thu, 15 Feb 2024 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026155; cv=fail; b=XXDtaRuwMRCghGLBxocuRJVdOrAQB6PsTrLnMLkP35rVWJUQ9hEx7ZpAAyjWwlvFCKCtfsNchwm6BLH4Y2a9VL6I03PulgIDmTtSqCRC8k2jTVQi5yVNMvBm/I4vr/hOUXdgZmxYGKDm3oMEcR6dyz+N4LOUdDHNI2vngNT1h8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026155; c=relaxed/simple;
	bh=54Ah9Hs+wkzd2tS0lC8L8jQv3/Oig/BiWEB2YKKujDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCZbatMFACL+xkIiW9FwOce7jzojq+Zft2evrAtnq6MnVb1W+PAXtcMFk26DC82LtplvIyX86/FaPGMjDyIXD6z7f+H1svUPpGkk/DJSIlKdwLTmhVJWeJK+0Dlqr/Jb0MRUfpAOj8kDxo2iWIuTgA5VmtpJXKoIffTvWS+jut0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0WVzKEvZ; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvPPArnh4pzeZKaOslbNykeA/vpZ2ycXJsZkBgU8By/DFj8MD+MTOzbPi69kDLQHSA1L62VJEKnwvCmrpbiMJon9IyaztHMgXXOZsv2eX1D6fi65NA9nY7knKF1sN8BVbsnXGFja8jbDC3wkZBFEujp1w7DK1Wz+PNPqGIQ3/T91wqorfo09SS6A66VGZdNqysnoX3zJuvBJm0c7bBsytqbS5YKV7JZI2PDPjhyO74NgC6U4Hr83u/vyMDa6BVQAypIqoaBnxAD5WO/npU2ldlh3XZs3T1g+brcP7iEu4ZapO6LI4moykqZFl+VRoxkKfASkQJsPIR2pRSdj5Lzabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBCpy1ba+liQwVfBJNEFy00uRsvnYTBZXzxQ+rorSPI=;
 b=I7Ch6FYplc/GHOoo/yKM2qPTJ5iHa/4iRW6u7ohWT/bwmffEo7dowFZ+TAIZQYCWuQ5TmVUuW+sJhjueQz7bAFrVqayKbtGjAW0b20dvqjHYn7/y31iazec/XShT+ZhkGBh/q81ON3BBwEbUcZAj7T53fqEqp3xF974I5Jou6VK2AuOs5wyhFHW2mmLaYselzuq8xZK4CerJjtij63ZadbzM6hRJfQBgB/8zeNGHVv4H6x0vGkaYo2jsNGiFCqnIql2bqdHkUOd8KLlmKxLdh2PZND99GGb+FdGrjNzrrC3Fl6wYMghdR8ZGE09PMgHgzFPPAIsJh4F7VcQDmJ0sOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBCpy1ba+liQwVfBJNEFy00uRsvnYTBZXzxQ+rorSPI=;
 b=0WVzKEvZozdTOpMa9YN0F2eHsINSGMDrwQDeUmuLGrngvaUPYRFH8bdnG+bROJkQ205Ysj/J67I5rT5utTh11nEZWnMv4wWZZ9CuVFD4zKTwZ9Bx+YF6xe1QwUcLQ2u7IUYDuywwOaJ3lVcOdk2jjkZrMyjAy1X67cIa5spR/ZE=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 19:42:30 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::3d) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 19:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:42:30 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:42:28 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 6/6] pcie/cxl_timeout: Add CXL.mem Timeout & Isolation interrupt support
Date: Thu, 15 Feb 2024 13:40:48 -0600
Message-ID: <20240215194048.141411-7-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: c32f69c3-2ab5-4cd0-0a76-08dc2e5e3f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cbrNBVBZSNDuHTe5cXNEzDt/xtpttUpt6RfLspUo4CgBXMz9SIvOXBd2NzkM+PH8CbbNme1TGpiSurEvrbnIFJSyMPjrsM3pnidOfM0XYjF9jtlqq/wf2EZqfs/lKu9toqVGRPn0ih8ujInEE4xAHLlckzwqEtu/G2c8lBsxG4oM2OH6kPJQY6Bj3JpR6M2dhiE1wQ1aVWr9DDgruRrA+wziVKwGO4aqMelhlIzxyGEZlUg5/wb3EwJbOv2sGkedRe4K8PvNJcukQZaU+9Jm0G9C/Eg1v3i+fgK476L3cyVR2Sp8WOsUdF6GCokJfrAnesnUo/uNyVHVdPIZcVUCh9g2w8ewR7XlDBJ3MxORsz3QsbzzJOiYJ6GbqdnRUq1sKclFM0HIYai0ZWCQgjsX9deUXTa164Nm1zCuJ52TOUPwVpHe9pNVOyZz4xKYNiJ9drpcZSb+jNLGvuJrxTaTHSSYMYm9esDVlePq2NK2932KErG96xRDD9IjdXbyrXtBmg1MSd4lhiF1BLdERPPa2NYNIqgbf2DwNy9yRzpDEetE9Impxk9Bv1lKMxHAZ0g7LrkcvPpX4XkfbMLwN4tkPoFjADWW31xHbFweGHq73imJG2Fn3QooR7OGYyjN9ohLOcM/Ak+NAdDbJAkR+EMsqrvYO/IMj+mtaFNjgmVc9s8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799012)(36860700004)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(8676002)(70206006)(336012)(2616005)(41300700001)(83380400001)(16526019)(70586007)(4326008)(8936002)(316002)(6666004)(54906003)(110136005)(478600001)(7696005)(36756003)(82740400003)(356005)(81166007)(86362001)(1076003)(426003)(26005)(2906002)(7416002)(30864003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:42:30.4361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32f69c3-2ab5-4cd0-0a76-08dc2e5e3f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Add support for CXL.mem Timeout & Isolation interrupts. A CXL root port
under isolation will not complete writes and will return an exception
response (i.e. poison) on reads (CXL 3.0 12.3.2). Therefore, when a
CXL-enabled PCIe root port enters isolation, we assume that the memory
under the port is unreachable and will need to be unmapped.

When an isolation interrupt occurs, the CXL Timeout & Isolation service
driver will mark the port (cxl_dport) as isolated, destroy any CXL memory
regions under the *bridge* (cxl_port), and attempt to unmap the memory
backing the CXL region(s). If the memory was already in use, the mapping
is not guaranteed to succeed.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/pci.c         |   5 +
 drivers/cxl/core/port.c        |  80 ++++++++++++++++
 drivers/cxl/core/region.c      |   9 ++
 drivers/cxl/cxl.h              |  10 ++
 drivers/cxl/cxlpci.h           |   9 ++
 drivers/pci/pcie/cxl_timeout.c | 165 ++++++++++++++++++++++++++++++++-
 drivers/pci/pcie/portdrv.h     |   1 +
 7 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..95b6a5f0d0cc 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -64,6 +64,11 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	}
 	ctx->count++;
 
+	if (type == PCI_EXP_TYPE_ROOT_PORT && !pcie_cxlt_register_dport(dport))
+		return devm_add_action_or_reset(dport->dport_dev,
+						pcie_cxlt_unregister_dport,
+						dport);
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..88d114c67596 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2000,6 +2000,86 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, CXL);
 
+/* Checks to see if a dport is above an endpoint */
+static bool cxl_dport_is_parent(struct cxl_dport *parent, struct cxl_ep *ep)
+{
+	struct cxl_dport *ep_dport = ep->dport;
+	struct cxl_port *ep_port = ep_dport->port;
+
+	while (!is_cxl_root(ep_port)) {
+		if (ep_dport == parent)
+			return true;
+
+		ep_dport = ep_port->parent_dport;
+		ep_port = ep_dport->port;
+	}
+
+	return false;
+}
+
+bool cxl_dport_is_in_region(struct cxl_dport *dport,
+			   struct cxl_region_ref *rr)
+{
+	struct cxl_region_params *p = &rr->region->params;
+	struct cxl_ep *ep;
+	int i;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		if (!p->targets[i])
+			continue;
+
+		ep = cxl_ep_load(dport->port, cxled_to_memdev(p->targets[i]));
+
+		if (ep && cxl_dport_is_parent(dport, ep))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_is_in_region, CXL);
+
+void cxl_port_kill_regions(struct cxl_port *port)
+{
+	struct cxl_endpoint_decoder *ep_decoder;
+	struct cxl_region_params *p;
+	struct cxl_region_ref *ref;
+	unsigned long index;
+	struct cxl_ep *ep;
+	int i;
+
+	xa_for_each(&port->regions, index, ref) {
+		p = &ref->region->params;
+
+		for (i = 0; i < p->nr_targets; i++) {
+			ep_decoder = p->targets[i];
+			if (!ep_decoder)
+				continue;
+
+			ep = cxl_ep_load(port, cxled_to_memdev(ep_decoder));
+			if (ep)
+				cxl_decoder_kill_region(ep_decoder);
+		}
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_kill_regions, CXL);
+
+bool cxl_port_is_isolated(struct cxl_port *port)
+{
+	struct cxl_dport *dport = port->parent_dport;
+
+	while (!is_cxl_root(port) && dport) {
+		if (dport->isolated || !dport->port)
+			return true;
+
+		dport = dport->port->parent_dport;
+		port = dport->port;
+	}
+
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_is_isolated, CXL);
+
 /**
  * __cxl_driver_register - register a driver for the cxl bus
  * @cxl_drv: cxl driver structure to attach
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..f9aef17db26c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1699,6 +1699,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	if (cxl_port_is_isolated(ep_port)) {
+		dev_err(&cxlr->dev, "%s:%s endpoint is under a dport in error isolation\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -EBUSY;
+	}
+
 	if (cxled->cxld.target_type != cxlr->type) {
 		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -2782,6 +2788,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct resource *res;
 	int rc;
 
+	if (cxl_port_is_isolated(cxlmd->endpoint))
+		return ERR_PTR(-EBUSY);
+
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
 				       atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3b5645ec95b9..1bee2560446a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -138,6 +138,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_MASK GENMASK(3, 0)
 #define   CXL_TIMEOUT_CONTROL_MEM_TIMEOUT_ENABLE BIT(4)
 #define   CXL_TIMEOUT_CONTROL_MEM_ISO_ENABLE BIT(16)
+#define   CXL_TIMEOUT_CONTROL_MEM_INTR_ENABLE BIT(26)
+#define CXL_TIMEOUT_STATUS_OFFSET 0xC
+#define   CXL_TIMEOUT_STATUS_MEM_TIMEOUT BIT(0)
+#define   CXL_TIMEOUT_STATUS_MEM_ISO BIT(8)
 #define CXL_TIMEOUT_CAPABILITY_LENGTH 0x10
 
 /* CXL 3.0 8.2.4.23.2 CXL Timeout and Isolation Control Register, bits 3:0 */
@@ -700,8 +704,11 @@ struct cxl_dport {
 	struct access_coordinate sw_coord;
 	struct access_coordinate hb_coord;
 	long link_latency;
+	bool isolated;
 };
 
+bool cxl_port_is_isolated(struct cxl_port *port);
+
 /**
  * struct cxl_ep - track an endpoint's interest in a port
  * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
@@ -735,6 +742,9 @@ struct cxl_region_ref {
 	int nr_targets;
 };
 
+bool cxl_dport_is_in_region(struct cxl_dport *dport, struct cxl_region_ref *ref);
+void cxl_port_kill_regions(struct cxl_port *port);
+
 /*
  * The platform firmware device hosting the root is also the top of the
  * CXL port topology. All other CXL ports have another CXL port as their
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 711b05d9a370..7100e23a1819 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -106,4 +106,13 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+#ifdef CONFIG_PCIE_CXL_TIMEOUT
+int pcie_cxlt_register_dport(struct cxl_dport *dport);
+void pcie_cxlt_unregister_dport(struct cxl_dport *dport);
+#else
+int pcie_cxlt_register_dport(void *dport) { return -ENXIO; }
+void pcie_cxlt_unregister_dport(void *dport) {}
+#endif
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/pci/pcie/cxl_timeout.c b/drivers/pci/pcie/cxl_timeout.c
index 352d9370a999..2193e872b4b7 100644
--- a/drivers/pci/pcie/cxl_timeout.c
+++ b/drivers/pci/pcie/cxl_timeout.c
@@ -22,6 +22,8 @@
 
 #define NUM_CXL_TIMEOUT_RANGES 9
 
+static u32 num_cxlt_devs;
+
 struct cxl_timeout {
 	struct pcie_device *dev;
 	void __iomem *regs;
@@ -141,6 +143,141 @@ static struct pcie_cxlt_data *cxlt_create_pdata(struct pcie_device *dev)
 	return data;
 }
 
+int pcie_cxlt_register_dport(struct cxl_dport *dport)
+{
+	struct device *dev = dport->dport_dev;
+	struct pcie_device *pcie_dev;
+	struct pcie_cxlt_data *pdata;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return -ENXIO;
+
+	pdev = to_pci_dev(dev);
+
+	dev = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_CXLT);
+	if (!dev) {
+		dev_warn(dev,
+			 "Device is not registered with cxl_timeout driver.\n");
+		return -ENODEV;
+	}
+
+	pcie_dev = to_pcie_device(dev);
+
+	pdata = get_service_data(pcie_dev);
+	pdata->dport = dport;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pcie_cxlt_register_dport);
+
+void pcie_cxlt_unregister_dport(struct cxl_dport *dport)
+{
+	struct device *dev = dport->dport_dev;
+	struct pcie_device *pcie_dev;
+	struct pcie_cxlt_data *pdata;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	dev = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_CXLT);
+	if (!dev) {
+		dev_dbg(dev,
+			"Device was not registered with cxl_timeout driver.\n");
+		return;
+	}
+
+	pcie_dev = to_pcie_device(dev);
+	pdata = get_service_data(pcie_dev);
+	pdata->dport = NULL;
+}
+EXPORT_SYMBOL_GPL(pcie_cxlt_unregister_dport);
+
+struct cxl_timeout_wq_data {
+	struct work_struct w;
+	struct cxl_dport *dport;
+};
+
+static struct workqueue_struct *cxl_timeout_wq;
+
+static void cxl_timeout_handler(struct work_struct *w)
+{
+	struct cxl_timeout_wq_data *data =
+		container_of(w, struct cxl_timeout_wq_data, w);
+	struct cxl_dport *dport = data->dport;
+	struct cxl_port *port;
+	struct cxl_region_ref *ref;
+	unsigned long index;
+	bool kill_regions;
+
+	if (!dport || !dport->port)
+		return;
+
+	port = dport->port;
+
+	xa_for_each(&port->regions, index, ref)
+		if (cxl_dport_is_in_region(dport, ref))
+			kill_regions = true;
+
+	if (kill_regions)
+		cxl_port_kill_regions(port);
+
+	kfree(data);
+}
+
+irqreturn_t cxl_timeout_thread(int irq, void *data)
+{
+	struct cxl_timeout_wq_data *wq_data;
+	struct cxl_timeout *cxlt = data;
+	struct pcie_device *pcie_dev = cxlt->dev;
+	struct pcie_cxlt_data *pdata;
+	struct cxl_dport *dport;
+	u32 status;
+
+	/*
+	 * If the CXL core didn't register a cxl_dport with this PCIe device,
+	 * then dport enumeration failed and there's nothing to do CXL-wise.
+	 */
+	pdata = get_service_data(pcie_dev);
+	if (!pdata || !pdata->dport)
+		return IRQ_HANDLED;
+
+	dport = pdata->dport;
+
+	status = readl(cxlt->regs + CXL_TIMEOUT_STATUS_OFFSET);
+	if (!(status & CXL_TIMEOUT_STATUS_MEM_ISO
+	      || status & CXL_TIMEOUT_STATUS_MEM_TIMEOUT))
+		return IRQ_HANDLED;
+
+	dport->isolated = true;
+
+	wq_data = kzalloc(sizeof(struct cxl_timeout_wq_data), GFP_NOWAIT);
+	if (!wq_data)
+		return IRQ_NONE;
+
+	wq_data->dport = dport;
+
+	INIT_WORK(&wq_data->w, cxl_timeout_handler);
+	queue_work(cxl_timeout_wq, &wq_data->w);
+
+	return IRQ_HANDLED;
+}
+
+static int cxl_enable_interrupts(struct pcie_device *dev,
+				 struct cxl_timeout *cxlt)
+{
+	if (!cxlt || !FIELD_GET(CXL_TIMEOUT_CAP_INTR_SUPP, cxlt->cap))
+		return -ENXIO;
+
+	return devm_request_threaded_irq(&dev->device, dev->irq, NULL,
+					 cxl_timeout_thread,
+					 IRQF_SHARED | IRQF_ONESHOT, "cxltdrv",
+					 cxlt);
+}
+
 static bool cxl_validate_timeout_range(struct cxl_timeout *cxlt, u8 range)
 {
 	u8 timeout_ranges = FIELD_GET(CXL_TIMEOUT_CAP_MEM_TIMEOUT_MASK,
@@ -405,9 +542,28 @@ static int cxl_timeout_probe(struct pcie_device *dev)
 	if (rc && !timeout_enabled) {
 		pci_info(dev->port,
 			 "Failed to enable CXL.mem timeout and isolation.\n");
+		return rc;
 	}
 
-	return rc;
+	rc = cxl_enable_interrupts(dev, cxlt);
+	if (rc) {
+		pci_info(dev->port,
+			"Failed to enable CXL.mem timeout & isolation interrupts: %d\n",
+			rc);
+	} else {
+		pci_info(port, "enabled with IRQ %d\n", dev->irq);
+	}
+
+	num_cxlt_devs++;
+	return 0;
+}
+
+static void cxl_timeout_remove(struct pcie_device *dev)
+{
+	num_cxlt_devs--;
+
+	if (!num_cxlt_devs)
+		destroy_workqueue(cxl_timeout_wq);
 }
 
 static struct pcie_port_service_driver cxltdriver = {
@@ -416,6 +572,7 @@ static struct pcie_port_service_driver cxltdriver = {
 	.service	= PCIE_PORT_SERVICE_CXLT,
 
 	.probe		= cxl_timeout_probe,
+	.remove		= cxl_timeout_remove,
 	.driver		= {
 		.dev_groups = cxl_timeout_attribute_groups,
 	},
@@ -423,6 +580,12 @@ static struct pcie_port_service_driver cxltdriver = {
 
 int __init pcie_cxlt_init(void)
 {
+	cxl_timeout_wq = alloc_ordered_workqueue("cxl_timeout", 0);
+	if (!cxl_timeout_wq)
+		return -ENOMEM;
+
+	num_cxlt_devs = 0;
+
 	return pcie_port_service_register(&cxltdriver);
 }
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index f89e7366e986..c56c629cf563 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -10,6 +10,7 @@
 #define _PORTDRV_H_
 
 #include <linux/compiler.h>
+#include <linux/errno.h>
 
 /* Service Type */
 #define PCIE_PORT_SERVICE_PME_SHIFT	0	/* Power Management Event */
-- 
2.34.1


