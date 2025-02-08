Return-Path: <linux-pci+bounces-20996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F07A2D22C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508457A5EC0
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7138BEC;
	Sat,  8 Feb 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UQT5K9hv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CB224D7;
	Sat,  8 Feb 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974643; cv=fail; b=eKsJl7JZIA1yiqThFdcJpu4WBKRS4wLPNXm+/RPPxaGkFLxQ5R15FoYuVSNxMjCOToUiq0U4i+czG1X/B5uAnYTsbrImq/v4uWDnAxBb+DnFBlJRYWUH+yQ4YISdcg4Ta/uadP7BIGkyKnNqiRco3UV7/6w35V7awX/NTw/3JKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974643; c=relaxed/simple;
	bh=J0/fvUBeZlHlrk5KIAQfYTH3wqnVAFm7flSbfR4mvkU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwB/Us2V51Hna+mhkYcV1mKTDCQWah03B9feq3e9oNAZ0hDWor2CG0rDsDxh4XDY7+6z3WgqkQ1nWczDlPPnW4bhauUI9+ylu86CMCALyG/CoOjOVjZiAGjE2Bu84oEan2bqYB/mp/CtrCPvEsGmgeHIG0K2NH0tJNATMLSOz7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UQT5K9hv; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW/voQqQl+4i9F492/vT2EDtEzIgqUF3CClZ9b/FJzDdGUfpgzxFGyMLH8w4EdWFhSSlIL1I7Xyn3IK4kD4BoZeg0f+zDjdViyee/p1Ekq0yFTZ/nDmEa38n2fJHQDTlMEfJT2WzELyOF+byP7sQ1YcjgqVv6jOu+MgPKBKa+ZdOIc+aXvTWb4sbbjPGEqE1axkFz9dk3CExlyWW6F5YRh+j9IX/AnbdVq8/tJeZlNPXN2y6zXtcC2p+9a0OFPrJqOiMCzqujXtFmhfSfSFANAOTQxxwBw3o6zOrJJZ7HVeKBzB6t5RhBaxTQGHBSJSq76k0Ana9ceV7T9KPu6CZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgV6JEjETvcIPOU7/SlmAsVk5+HnQ/VW6U8TCD9/9pc=;
 b=QRZfCCAgUhSzVjO2M9zhXRP7tIn1SAG2u0CdfcvIdzhFm+XdADAqbTWRChZx/G4ZVi05C4CGdM0yELPHQif9T7uD1gvT510M4cKM6xV9VohtHX1B8z9PMggHhKv7af8o7ZiiRi7i0wV2UugF/lD5h0B2CF6/mLgqsJeIzYz9GZOtbIh9YmaoEPyLS3+0X+E9sYJ8dA5WWSCYlpggQqj/MGyeLdFF79zUdOUdnLfI7PogvC/jrUWvicINlNMFsQToA7DLzz6kwfPlNGAKfp7IIdkmOS8xT2wZMoLRtRmO8/bQZkGoJdWrJi49owG7FAWH6b46hxr0xy7YisiuGIVlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgV6JEjETvcIPOU7/SlmAsVk5+HnQ/VW6U8TCD9/9pc=;
 b=UQT5K9hvvgnR23czAjoUH6dFR5QvUzRWBM3OyHIn0P+bO3KemZw1fmrPk/sw3QqJZ50yIH8GN8JQtg7McZ/mC3/0KWu46COp/JnxbnMaUsNAAlAzs7xhUGgjMUJyudalWz5BxypJrZr+RafLu14X+jnK4jr+jO8AmS5ttFPV+iY=
Received: from SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 00:30:11 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::ca) by SJ0PR03CA0290.outlook.office365.com
 (2603:10b6:a03:39e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Sat,
 8 Feb 2025 00:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:30:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:30:09 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v6 02/17] PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe Port support
Date: Fri, 7 Feb 2025 18:29:26 -0600
Message-ID: <20250208002941.4135321-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: e7620966-3e54-4dfa-d911-08dd47d7bf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkbuY22337FpjG+5vVPm0iyB+n9sw7rGMRC6LREdj2aEaENSIzm1RJeoGF7K?=
 =?us-ascii?Q?jUsKwoE2L2aZJR7AlClYgFmt6JeD+9Bc2vmjkcyim0QgmoVF2nnXxT7dpydo?=
 =?us-ascii?Q?G/yVIhq64tCP81kA59JuajEkfpEYzBoW/zho4PKEzfpi4w0X+XZeWmudy+8A?=
 =?us-ascii?Q?5dE9yLqqXJorSGiK2vbBxqpDcR/FW+b8fd/vzregCGz3yeDd1cMv7VYifmSi?=
 =?us-ascii?Q?EaVZYyQm1MOeUUx/YDe7MWVxcsMHaHIB32VGEcMUg2ruKnHSpPIAmfH6l63+?=
 =?us-ascii?Q?Aq6QWhLDQlO9vR22zAOeRMUSAgYxjw/hjnNI1Fcx8Uc3p6CxAiJ7yMGjmkkA?=
 =?us-ascii?Q?T3oXhmPRywI/7o8hyQQBfgM9Xr5NTAmOI71HS30IVjBmG9tfBkucxF6H8A70?=
 =?us-ascii?Q?rle6YD2FkqghX5Pbl5CRG5XWnzmt34UkDAbSGHpj/P6nLtu8PzxmDAF5GgkF?=
 =?us-ascii?Q?Frf7Hkc06tp5MmfAFUvsKjzBVmJeRp0ZdGDse8I6IGcOOpWt1a1iAFG61oqN?=
 =?us-ascii?Q?i+13ffnAot9pwtxRJ1A3gygC8yRh7jdA7G/8x2NIu7Pp0Ex/X3Mowo0FxVjL?=
 =?us-ascii?Q?TqYn0/VcwuJ8I8TVRO5DmxZA4BzwLVmTylz/CJO8eX9cuJK/dg/zXAbC9Tl7?=
 =?us-ascii?Q?rK9S71CqIc+TcWNOh54aRMO/GxiP4EsCdMQn8YFOL23jh1Q/tfFZMUl9xbfE?=
 =?us-ascii?Q?Rqk6PMxmiuWnsqlHe/VRESRqszZUrMXjaWQX+UjD11INbBT6uHwe9wfw5fWu?=
 =?us-ascii?Q?RvQlKr9qpoCRcyPkTpPR9OF0J5tmPSfUYbqgqB044MetuFWJK/9hYDgkguCk?=
 =?us-ascii?Q?+gxGlIa4wXeiREWqwQ6sUdkvTKmYSjEl/eC4m2G7FJQATgiElQ0bxYybD/x0?=
 =?us-ascii?Q?4IZmUHkPY6BPdd019r6dwVsfBp9gcD6AWHrS315JJhnaZjoD4LMqFhseFoaV?=
 =?us-ascii?Q?cQnv7Nhm7Ltl7O9bTbrUY12jCAuMlvcORQ3iGddM1O+udTxU9/ybRE+DMhvG?=
 =?us-ascii?Q?atpXA9jFW6sjcoCB7Vxtl/cb7jaTAp3uyBJNb9DozxQ1OH7RdiYzBfAmn6os?=
 =?us-ascii?Q?kQy8oNnGxa1zQ5j1OZUbH+D/tryUpZNZu4knxJkDsnsi3tm9W/KedBJscE+S?=
 =?us-ascii?Q?a74nHDqMe+H1C6C8+6BE7i0IiTx8QjDs3DAEJ03JAIJr0cHwuFDtsImt/fca?=
 =?us-ascii?Q?a7y4XBUIDerNuw1QIfPgBLIiECE0FdfwjBq54CVSJsreE9K/IJfumls3pL6q?=
 =?us-ascii?Q?aI7lFXxdP/DYnH4JyaYuZT1gtOpvILjbWQZk7hgnjHdJSguecUgJGc+wFXXK?=
 =?us-ascii?Q?7RDht+V0Bj5+Ou3/kA4Rt6ypv499twgwYMga1TRp2IQHSWqaA5WXKHEhgA9l?=
 =?us-ascii?Q?kE6FSqbBeExUISznPVTCfWbXzJFhe7MhTswqYt3WEDIf+IiK9jnCQTeGMdQN?=
 =?us-ascii?Q?ZszRpQofRrj7ZrTiWx/9L/mG3XHyqHG1aid6JJgnktDUkibVXY2XSnTTCOCm?=
 =?us-ascii?Q?XR8DlJ0x1DJkWVKfViLoc926CBBY3Zo8T11q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:30:10.7638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7620966-3e54-4dfa-d911-08dd47d7bf45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926

The AER service driver already includes support for Restricted CXL host
(RCH) Downstream Port Protocol Error handling. The current implementation
is based on CXL1.1 using a Root Complex Event Collector.

Rename function interfaces and parameters where necessary to include
virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
handling.[1] The CXL PCIe Port Protocol Error handling support will be
added in a future patch.

Limit changes to renaming variable and function names. No functional
changes are added.

[1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..6e8de77d0fc4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1024,7 +1024,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
@@ -1047,30 +1047,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	return *handles_cxl;
 }
 
-static bool handles_cxl_errors(struct pci_dev *rcec)
+static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(dev))
+		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
 }
 
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+static void cxl_enable_internal_errors(struct pci_dev *dev)
 {
-	if (!handles_cxl_errors(rcec))
+	if (!handles_cxl_errors(dev))
 		return;
 
-	pci_aer_unmask_internal_errors(rcec);
-	pci_info(rcec, "CXL: Internal errors unmasked");
+	pci_aer_unmask_internal_errors(dev);
+	pci_info(dev, "CXL: Internal errors unmasked");
 }
 
 #else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
+static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
+static inline void cxl_handle_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
 #endif
 
 /**
@@ -1108,7 +1108,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	cxl_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
@@ -1491,7 +1491,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_internal_errors(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1


