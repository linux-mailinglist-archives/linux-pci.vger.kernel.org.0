Return-Path: <linux-pci+bounces-21000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE36AA2D234
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBEB3A9984
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C931DFCB;
	Sat,  8 Feb 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MyrvIpYd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300013AA5D;
	Sat,  8 Feb 2025 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974684; cv=fail; b=Aa8Z953mGkyE/N/RrmK/pntTnvBddZmgv2jMWqqaTLp7SyTMnwOePWsYtMP4RGZmYfI7NprtkcQUgcTyxXFKki0d3D4ZrR/z/6D+RkODuUg6/OiCsqexw2fYn3tH8qVq6wzS0XBLDSfrr6RgbB+FqWzchIWS2Qlg8ph3EKPVks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974684; c=relaxed/simple;
	bh=P2qXiOrm7/BQ44ytuQ1T8GLl683j6y+k/K325q7DIf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ia6EuoZT6BQ6vZqvHeDBAbTO7S/+FhLX2ZcSqL6rwviyxqxgs2p+uFuQ7x24NCih2SHRPDTCzRTfWljam6uEUoijOMrkT3W1WIMLrNISdW3Jb5ARFei2S+sl0/t4xxsoB5iVEwIKJIkpQ0jlwpstVUGs6r2FPF5T8PmepuCyOvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MyrvIpYd; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r15VC0WvGEP/FzsTRO3OnqPr90hoAfOHyPrfATOleYkDJPyJ6kDYVMQO6QQQM3Ipc/vVinq+hVqPYmjh2itQyUyVjILapO+6s5Alvv2ETtxdFYAna+KEFaDu2U1UdbClQ/qAk2J6LPCOXy/fhR5WzLHjf04q7nCqyTVZSDxzBX/9hzr0MF2SXufah//aob+rM5/Iy/Q+FiHm2P2fC2/nTt3oa4l5Ggcxab2yt+AL9sp4QVAipaPHf49GS01vWeMxTRwN5p3zYanNhkHWDMiX6OvpFP0BlVWMxk7E8erGLbJ55j3TUBfox01Bfk2jNqm/yZUfbVDcg6frJPWWpsltdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCI3236zgJAwX13hZF/cZTdabUxCRSq5spY5bAcMW5w=;
 b=CfjORtX25haAImSjPJ4Co1M+G4xKNhpuOcLT+D/X659YdnZL7tmBgm7NYjGRazeQmPRBdSUAU097XZ7DnycrJvuSzUQzo/Mo8YacYXBUwUV95dmMoh1d9O6IzxLYXIsnslHOcK68Nh7MijIVUkDTNLMCaXEF0iOEAGLyMI9SP91bFqU9CDPGkd+/dF6XqcZobOedHIprqyBDQACNL9sx/FJp9qMDKrbh3ngVwENy85+naREZpln/TgwzH5XeR9kI/1enDVRlXGLHlsqE7xWfVZCUQOXcqYV8Q6XVYbySTe1yakhp2z2seaQ391Sc9RGbvwEdfHo53fJWteYULTjHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCI3236zgJAwX13hZF/cZTdabUxCRSq5spY5bAcMW5w=;
 b=MyrvIpYdzL6aYg1nFq/0zRjLrH1iTztr7V2ubYGAD6zCp1PEnIM9tP8Nb8DW8eryHA0qd6A4UiFm8Z3pqoYtH5i4mR8KfJKjm12nddfrgDprUJ1vsrC+MzeCvkjSYYU/LFoMeO/exJKLCgzKRUaHJblDYxJhRNQFZn+jSYJ+3JA=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Sat, 8 Feb
 2025 00:31:18 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::7b) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Sat,
 8 Feb 2025 00:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:31:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:31:16 -0600
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
Subject: [PATCH v6 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
Date: Fri, 7 Feb 2025 18:29:32 -0600
Message-ID: <20250208002941.4135321-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e56d8d8-28d9-4b25-1dbf-08dd47d7e722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8Sf+MB1RRojlUVOfHggkJKUWzRQq0uEuETfOZl21k7UbH9gl2l4IQN1xUFm?=
 =?us-ascii?Q?MK/bOFvXn2F9d84D/FnYCwF+Hhs9W+XlD6mZC4i85kOC+hx17ACGj2T9njj8?=
 =?us-ascii?Q?4bBtxHMyvI9Gdu30ch906FE4UUMsS7isC+BsjH4EqxnfJZoJE9/4EaT03KVf?=
 =?us-ascii?Q?qGD9efXFAQwxBVskhqQjovLq95K9G/fAzVU+fsTGvYic9wimDo8MxP3qMXec?=
 =?us-ascii?Q?6UQsWc5rpoGaapU1NCPQwDlYproUNTBjrA7EZWtYDcRVZVlNWRjh6im42KO+?=
 =?us-ascii?Q?ckPukTU090vEy8FvE+BLMk8x3haSY7wHRGyoBoOjMcM2h2tL5GnUfafwfnkR?=
 =?us-ascii?Q?nYvpTT9upLH/MvnWYUfXubae5A2kFkpVwz7XuNytVxCIULBZBAmvsZ6mqa78?=
 =?us-ascii?Q?hYhbHnVyQvPA1FxkpUi6THRXxFaGnirGUdOjg6g4wIYN053lqQfKNg5LG4h5?=
 =?us-ascii?Q?IU5cp2Il+MnV5VKh7O+DxZhbW2KUHEEUWEaef4nXgWroFrWUWf2DTVbxNusd?=
 =?us-ascii?Q?+C14k8yj8fK1TPXTweJHGzEYCleRvQJkxykMWKKTk/I5QquEOx278oaYOleg?=
 =?us-ascii?Q?b/v2p1SbfRPxy1/gVWBEX0A9qkpxOtWNHagH3qYVnlMqr+2KBogLxC7DOAKO?=
 =?us-ascii?Q?EqEyi4TttqxdTI8pyx6s2ffWMNKAFWsez/BDAzqdRuG4m48VJL8wAnL7y9ON?=
 =?us-ascii?Q?TALmGxT5SENc2mZli2H1rnTRdITO0PHBJc7jBCa9Y6v9VEjl6HGs+wzpzyHO?=
 =?us-ascii?Q?6gVZNqGCsvBSIEe077vPw9rLDEyZ212LTAfiXKUvtb0oKKXPNqcDIhbDznSn?=
 =?us-ascii?Q?YQ917eZ7lvQZZIQyRu6X/bBI3d2d7rop99TtHzJz+vZ63+ILpocAfQqrcIMT?=
 =?us-ascii?Q?YNlQClzBD0ga4Znvwah64ZoebcwNWHACiuNUeS+Q16sZlfKUaEp2ACsBwa5G?=
 =?us-ascii?Q?oUBVR5eftEZ0KNzv64BjkswlQeSI4lF8CvnHCMsYVB3asPPWSECAymOEKHVA?=
 =?us-ascii?Q?FV1Uu5Hlb9tpnxwPWO4nR05+IY0D4HQkQvRbiVZhXX7DkeNXL5RmY3WizMRQ?=
 =?us-ascii?Q?xfO8a5QT4zl8mlIj8k+kNmBVaGmAzpkCxbRGv4qnXmvEhAux11kqh7m/ViGs?=
 =?us-ascii?Q?Fe1IJqDR1hvlTBGLLz1cBDzEaGPK3k3JsbvdUss0KCDmg2lpoFYnKWq+QSqc?=
 =?us-ascii?Q?6J3RzALCSrphdUf1xz6sDENiCaq0H9nhn8ADsRc1vbQJsckJ/W9S0HS8STsU?=
 =?us-ascii?Q?WVW/teUd3Z0P8UtLJvECIND5WmXPWx+kofN+q0XAxlAbFfIOyC+OwyoDQEa6?=
 =?us-ascii?Q?3bIadMnnmsiFauJp/ronhbwuhKyfNgxg2nyZqnqOd3mQWxRTAL2XkDzH8SHT?=
 =?us-ascii?Q?SL9wYhGAsX0tig4hggLf9mA7l7MsNQhZrJOgeZ/jffZlILyMwaIGSGoUMVjp?=
 =?us-ascii?Q?SGsRs/rz1GWur9OgjpwM6Eo/QhMZdoLQKugQie8vbk8WMBr+X+orfpcxB9CU?=
 =?us-ascii?Q?biyGIoIpN1eHTcp10HLSU3kC98CdnJ/rCOR3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:31:17.6229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e56d8d8-28d9-4b25-1dbf-08dd47d7e722
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.

Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
pointer to the CXL Upstream Port's mapped RAS registers.

Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
register mapping. This is similar to the existing
cxl_dport_init_ras_reporting() but for USP devices.

The USP may have multiple downstream endpoints. Before mapping RAS
registers check if the registers are already mapped.

Introduce a mutex for synchronizing accesses to the cached RAS
mapping.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 19 ++++++++++++++++++-
 drivers/cxl/cxl.h      |  4 ++++
 drivers/cxl/mem.c      |  8 ++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c142d7890bfa..4af39abbfab3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -781,6 +781,24 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+void cxl_uport_init_ras_reporting(struct cxl_port *port)
+{
+
+	/* uport may have more than 1 downstream EP. Check if already mapped. */
+	mutex_lock(&ras_init_mutex);
+	if (port->uport_regs.ras) {
+		mutex_unlock(&ras_init_mutex);
+		return;
+	}
+
+	port->reg_map.host = &port->dev;
+	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_err(&port->dev, "Failed to map RAS capability\n");
+	mutex_unlock(&ras_init_mutex);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
@@ -807,7 +825,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
 		dev_err(dport_dev, "Failed to map RAS capability\n");
 	mutex_unlock(&ras_init_mutex);
-
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 82d0a8555a11..49f29a3ef68e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -581,6 +581,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -602,6 +603,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -755,8 +757,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
+void cxl_uport_init_ras_reporting(struct cxl_port *port);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
+static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8c1144bbc058..541cabca434e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -60,6 +60,7 @@ static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
 static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
 {
 	struct cxl_dport *dport = ep->dport;
+	struct cxl_port *port = ep->next;
 
 	if (dport) {
 		struct device *dport_dev = dport->dport_dev;
@@ -68,6 +69,13 @@ static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
 		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
 			cxl_dport_init_ras_reporting(dport);
 	}
+
+	if (port) {
+		struct device *uport_dev = port->uport_dev;
+
+		if (dev_is_cxl_pci(uport_dev, PCI_EXP_TYPE_UPSTREAM))
+			cxl_uport_init_ras_reporting(port);
+	}
 }
 
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-- 
2.34.1


