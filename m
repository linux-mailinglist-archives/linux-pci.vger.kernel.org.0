Return-Path: <linux-pci+bounces-18200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C69EDBF2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFC8280C9C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D931F2388;
	Wed, 11 Dec 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QV/3LFcY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8591F37A6;
	Wed, 11 Dec 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960504; cv=fail; b=lXuMWTxxUeNSAfUa+iFi2v2+NDrIrH8BKxNdQU0EzJkrCLvpk/3fPMjVGXzaLHAg37lOVcw9rcmSyk3S5lAVv6dMJbZeMA1DGRTKAwdZpizDFj0U5DHVvdD1bKX9/qYgZekHQ1qorY2F/UNIpUKf/7+eUBPj6NSosu4LAq57kkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960504; c=relaxed/simple;
	bh=oiXwLyPZJhvaulF6wrXqKz9z3JWnr7knYWLpCLRwZeY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8SZRltcuybutfP5xKoIel4HGG9tQ0u0M7x2WDb5sybWEO0uW1RJPDRcDYfalJqB+qJGKV5xKv6UcyzGHsP85mqC0DjUngbAWBwC5A/IvzdrROw8vcurwEO4t+ZwGixp2QF8MCFA/Hsk7Dm/UN9RLoJ9G2O9awodT5bkmJYVA80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QV/3LFcY; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffBoSKBj5zmedNfGl47gUEtNUTpTjYHms58bnUVWc06slcbMlhWqRgtbYzG0yjZXy5axg4d3RYuDGLXrOfxfVPEgjNNJ4tqoZbzkJrfsy5ayiCFfGvl/3aNNc63RbbbB4MXeRFyauMFX56cH4eh35Jbo2e0wL89ZwvcJF83eTFC/HUhWtqeRkbkIrRDNhqg1jJ2KNasin6BT3jFd1lzvhiTzky1rDfzqS9ABT1zNwxk/WiNUOwupWMYc5I3kQX5/SWFmiwqnu6mKswPlijlCfAtvcyTTyp02v41Kk0zSQU8FoTq+WKsDP5/YpHzHCQnAai6N1ukZUjk9FGXYHIkAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rFf6Uny1Z+OxZ0tUNapKapwPriwe4ZoZcpUh/xlrkE=;
 b=k9yLulDViqLS1/67fqAHAOcSvSRoYvGrtd88eQ05UYlf+08Dbr/s+o5cU4bILpjWYxCvxgl1cKZhXCOwEOTxzQ/vzeu0w3B/RV6WnkdMEk47PMjT2g5BMFz32hAod/h+tqKBfvGwdX6Ty5zAyTRwxHohWVhaxVTUX7eb2ZWNB4tKPPBkyR0EQ0yLdz9E7l8UL1m/+6eERbtMzWFxpy2yj2cVap72AIJFcf2v4cMnHwzp7XnLp49QjLXukezareJDyo6BU2ppY4EL2Vxz8CCJ7gk/kJRQCWwqhy7Cpa+TsQwD/gK9MKLHdVAWYq3TVuOXyeYmyCTZqXx1GGiF9i2hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rFf6Uny1Z+OxZ0tUNapKapwPriwe4ZoZcpUh/xlrkE=;
 b=QV/3LFcYB7DUFd4yrJ5IxPWS4OmqY6oHblSkL1tCwOIJv4VD7/FnqTDSKb/J1xHO2lr6RLvEfVa9GisO5EzXOFcneU3vwoEyQ81seo/pcNjtPdduK0Hcs2anYCcB43UJloBYYg9f6V4YMNEz7FqT5nt/K8T1iS8bEc4oc5y+XpI=
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 23:41:37 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::20) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 23:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:41:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:41:36 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 08/15] cxl/pci: Map CXL PCIe Root Port and Downstream Switch Port RAS registers
Date: Wed, 11 Dec 2024 17:39:55 -0600
Message-ID: <20241211234002.3728674-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd2c84a-f225-47e3-e5e4-08dd1a3d5aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rl1CP3YDpd339SptAjwCHHHUJxE1i8f/Fws4dZEorJzxKQLoAVRwTJsHPlKY?=
 =?us-ascii?Q?9gSokzlJIjRXQ95Rcgr8y+TIl2q2JAXBK+WP7NKToUNPyxVRfctq9X+2AvKi?=
 =?us-ascii?Q?CNqnnv8l1H4H1L0ekan6ucWsK2/ToZ+6ixBsiBrMqJkQVrn2Qx7/REcW6/36?=
 =?us-ascii?Q?0JKn3qpajd6dTBYE+tmKE4hWlLfcrK0FPz0FyWaTO906pxAu9mQynuBDqlNN?=
 =?us-ascii?Q?/mWLP7OhDUhbYigdVrlz1ioN+z6gFKKVtYR6hIauBmVPEI/NLlKYiS1Z/uSQ?=
 =?us-ascii?Q?K8x6Hb2SHuSntpN0JDUGlE0wfXotrlWjceLU8J9uwLK6eCwtiuaoRPbgYCqn?=
 =?us-ascii?Q?U2/fsuDhsoG4zOu5vep9v64W9EXIb8QHBLpCC2ylb6ZwBbk3lYjMpHTxZCLK?=
 =?us-ascii?Q?sE0NL/09ZONWQVZonxZxjumJp5HdvZBkeMgK/xrzJJLYGeclubNBiaJ5Kx8I?=
 =?us-ascii?Q?dFpYi10s4ResBnrpHCRBeER7y00DYxoFxhrkYG8rLQlF1GBwOuHMNzhgo1xe?=
 =?us-ascii?Q?Rw/flsGXYWmhwRrhcnisw55rpF+jIXmqRqASmeMBQWriw4BAita9aANF95n0?=
 =?us-ascii?Q?HVgzqI4YlwWoswHp2vHHvaDZlm3tp7M8UzOw1aWefmQryTyedKnI8usoG7pb?=
 =?us-ascii?Q?VeFm0NmUFbqRI9sbTRIpBSChJ+NbFKZVKi4pZpU7TIQxeNtyzpH1i43PkVvd?=
 =?us-ascii?Q?hx4YxbV0tEgVkAgMHzJOfFMpD4cGB4E6FO/HST590H4KYsQEln4XUaP7ujxr?=
 =?us-ascii?Q?PYrHXjIrbkCTe+fYCA9yaEKnWjrqVnNSXgr7ltKxX4BAOJ4aTVdXJi8jqH5Y?=
 =?us-ascii?Q?amxemLElooVOHozVsGlgxTjaKBixcXAHRe6HWoaAPY/xh0yZ2XCCrCp07wWf?=
 =?us-ascii?Q?8CSEC1uAi8mY7+YqSUaVS2VmG1rjkEQBC/lmDmyEMMlkG5afAK+9lgeNXrZ0?=
 =?us-ascii?Q?XDusg6kJ/fhJ8B7hxzUk3RH2siPyq4iwd95eg3gYk/aIpPMq5S+1nmda4ALF?=
 =?us-ascii?Q?Ne0A5FNURIHozjooQr7yKQ/QQeIs/bbHcDiOWbefxPPfnb8d8SWhMmk2UWXT?=
 =?us-ascii?Q?xaQcBs74NmBRAKeKBvC4NpVHzL75I7nLXIyXNRDF87uC3o2cJuoZR6oKAupd?=
 =?us-ascii?Q?ctQi6TyfkyHn5K70JL2ONkMzmO+3D3USL30vfmwvZa2JSoJ80rWkCh4N/YO3?=
 =?us-ascii?Q?RoujPDbcdocnukuOVubHIDNtB0eocPewl37n1njoKEZhi8i9dC341twu3EXb?=
 =?us-ascii?Q?zTLtfJccJkVXb8ZVCBn4xgjYCcrr8xgRiTg5lrcuZ5NYjiJcWyDRVyFh2UIh?=
 =?us-ascii?Q?T1rpZyzgHpE8OpSqY6iEeCzx03+NWSgNhj8bYHZb+SZE6lofnRxunI9N39cz?=
 =?us-ascii?Q?p3Lbamo0t69XxQ7kQ0jkAFILqxsl6n9w9BBeZCPd0oQU9PICVW0qhyWwGuAI?=
 =?us-ascii?Q?MotDE2JzSUyen/4ebwnApOUdr8KEn6hejwdmOYJnSgGrZAPXvk/NNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:41:37.2199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2c84a-f225-47e3-e5e4-08dd1a3d5aa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
registers for the endpoint's Root Port. The same needs to be done for
each of the CXL Downstream Switch Ports and CXL Root Ports found between
the endpoint and CXL Host Bridge.

Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
sub-topology between the endpoint and the CXL Host Bridge. This function
will determine if there are CXL Downstream Switch Ports or CXL Root Ports
associated with this Port. The same check will be added in the future for
upstream switch ports.

Move the RAS register map logic from cxl_dport_map_ras() into
cxl_dport_init_ras_reporting(). This eliminates the need for the helper
function, cxl_dport_map_ras().

cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.

cxl_dport_init_ras_reporting() must check for previously mapped registers
before mapping. This is necessary because endpoints under a CXL switch
may share CXL Downstream Switch Ports or CXL Root Ports. Ensure the port
registers are only mapped once.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 37 +++++++++++++++----------------------
 drivers/cxl/cxl.h      |  6 ++----
 drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..8540d1fd2e25 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -749,18 +749,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 	}
 }
 
-static void cxl_dport_map_ras(struct cxl_dport *dport)
-{
-	struct cxl_register_map *map = &dport->reg_map;
-	struct device *dev = dport->dport_dev;
-
-	if (!map->component_map.ras.valid)
-		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
-		dev_dbg(dev, "Failed to map RAS capability.\n");
-}
-
 static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 {
 	void __iomem *aer_base = dport->regs.dport_aer;
@@ -788,22 +776,27 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
- * @host: host device for devm operations
  */
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
-	dport->reg_map.host = host;
-	cxl_dport_map_ras(dport);
-
-	if (dport->rch) {
-		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
-
-		if (!host_bridge->native_aer)
-			return;
+	struct device *dport_dev = dport->dport_dev;
+	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
 
+	dport->reg_map.host = dport_dev;
+	if (dport->rch && host_bridge->native_aer) {
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
 	}
+
+	/* dport may have more than 1 downstream EP. Check if already mapped. */
+	if (dport->regs.ras)
+		return;
+
+	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(dport_dev, "Failed to map RAS capability.\n");
+		return;
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5406e3ab3d4a..51acca3415b4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -763,11 +763,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
-void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
-void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
 #else
-static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
-						struct device *host) { }
+static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index a9fd5cd5a0d2..0ae89c9da71e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,6 +45,31 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return (pci_pcie_type(pdev) == pcie_type);
+}
+
+static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
+{
+	struct cxl_dport *dport = ep->dport;
+
+	if (dport) {
+		struct device *dport_dev = dport->dport_dev;
+
+		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
+		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
+			cxl_dport_init_ras_reporting(dport);
+	}
+}
+
 static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
@@ -52,6 +77,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
+	if (parent_dport->rch)
+		cxl_dport_init_ras_reporting(parent_dport);
+
 	/*
 	 * Now that the path to the root is established record all the
 	 * intervening ports in the chain.
@@ -62,6 +90,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 
 		ep = cxl_ep_load(iter, cxlmd);
 		ep->next = down;
+		cxl_init_ep_ports_aer(ep);
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
@@ -166,8 +195,6 @@ static int cxl_mem_probe(struct device *dev)
 	else
 		endpoint_parent = &parent_port->dev;
 
-	cxl_dport_init_ras_reporting(dport, dev);
-
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
 			dev_err(dev, "CXL port topology %s not enabled\n",
-- 
2.34.1


