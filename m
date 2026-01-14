Return-Path: <linux-pci+bounces-44816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 350A6D20C8F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE24300F6B4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB9285CAD;
	Wed, 14 Jan 2026 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bdX4GS2M"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504432FFF8F;
	Wed, 14 Jan 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415165; cv=fail; b=CxpoSWP2FvI77MAww3YNOFIuLz9rQfw4Rcl+qhNfL7e3RqS67a4NWZhYOtltg6SfIQYbi3WIpFYg//AbSC3DlX+gnZmTzaJPT0vMzdKPzbYIFn42Px/uPY0N8OtCbFnVMJbPRlLYK1Nt2CREiTwQu6veB/qNXD6qRAuZvszPYtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415165; c=relaxed/simple;
	bh=JcvTLf7fEUNwQuk0nM8kAlFlXm7okNM5MvRFYNqe66c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx4DOpOjvHlLrURYzk4PfKLsbMh0+4UjshFSPz4nuYo0YKgYRFVGa/7uM5o6djodqXovjOZZV/KxsvLX7CLBQpnND6Y3Pzn9or7OaK4m6/4Zi1wdXTQHpQegkNoGVTQyuOfq/Yc/d5w1jc3lK3BYxyyFfM99pVaqZpN1tlJ6Fvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bdX4GS2M; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNP0eVBUBg4HspMTevU1J5f8VNeUNIUDxT4jUnRvEg2GZXFSIbb6FBeyEQROKk6SreLtf7+c08BjQkdSDF3uRuguPDCVzZoW+z8Xmh4W5MMBykH7+hhbuFIccNLBZq91ryO+lzYYH0Yo4XhuITfXfJvoO25s+hNRN6H4Ed23DC8zisaaKdZ9W6QTVqgOSP390OBf+w9NPU+Vdnbxr8g+EneEwfJ7cM9Wuq/fDEBgKnd3xxpheeQmHBqBiAvMwEe22zIhTiwK96T6ReDB4IHocbqfpI1ltw89B4WywXCkPtplWvUUsym4G+x2DrlFTfoK8JCGHo8tn9nkEiWbkGbcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epbNNu4xLZs6k7pcod3892aOkO1wZU6SKvop7ORPQu0=;
 b=FmqtqSA2Tb9vULRRLTJ13VhBq02Yx/iI9bfgGwgc/z6qZGPO63SZBoR6q/Rvy6/spku8Vt6IamtYeMAZPTdwV7aZJwmmvB5Fqyy8Git3FLsbnlm9rKlEFCoAg/gVrQEUn50AZk38hsGFDru3rHapDFPYIxlsxA2Ww3erGEpFTdZfsAIPttJL9q9t3HGo5otlVFNZckaYVZ4NQ7p22j5E5ER2gaWeVHaqM2K4CIyT4qXknKek0T43ZZBl0sSpYXP2jdPTw1AXSLAPKfS1195b5ltiZzgiXjcQaXC2HKn6Bj2Fl5l76nAu3tPMEh9wF8M7ai3DtS131aquPK1lZEWMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epbNNu4xLZs6k7pcod3892aOkO1wZU6SKvop7ORPQu0=;
 b=bdX4GS2MqXsUWo6Np+XCZ8k3VIRfePybYpwRggemaeQlSgMldTIN5IUkJqYp/2nQFRIOAzDr1k7TnK+h04zSWsxuY3DFljtrYHz24DxMn2ICb/nTbN5A6Bm/lIeF3YY0MDVM9eQJHk7jcmx1tUnoUdSJNVnKDtSOtFiEZd5ULuE=
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 18:25:58 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d4) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 18:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:25:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:25:56 -0600
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
Subject: [PATCH v14 23/34] cxl: Map CXL Endpoint Port and CXL Switch Port RAS registers
Date: Wed, 14 Jan 2026 12:20:44 -0600
Message-ID: <20260114182055.46029-24-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: cb042200-02aa-481d-325e-08de539a5cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WNcXMVhCBfAoPKepqVRDydqnFeO+RVQAUm4fBIjR4BhmjaOb92Ve8gQtAPSm?=
 =?us-ascii?Q?/ZsvzJjJnU1XcJEUUbymmbUL6qA5FhBo3oIaYNHLFiZsa3UCUSlPYN+jdyZ4?=
 =?us-ascii?Q?vIka35hVOLwAjiZ8I9UN4Au86pm5qSvec3fTGKhUeVzATywxxDPJqLDu5hCq?=
 =?us-ascii?Q?TTNfBC68ffaDO1vaW0KQiVcdPPFFOcgScTusmkbpc1xKPRDEhQbW0qKiog8b?=
 =?us-ascii?Q?P+GoS+25Zjhd3hkiaRvav4e9snNUHgjd1romz+dPCoSzl7+fX28mQDOeojBJ?=
 =?us-ascii?Q?vW/p1EACL81LAx1soCVjVKoymN6Q8I2MTPC9FcgOJA+iO2CXkxwD5xb7zV6q?=
 =?us-ascii?Q?JNsrKtFb7U8RCYpCHron7IQw0kzKIem8oxjgIjkM7ale0Kxf918AZDRUd7RP?=
 =?us-ascii?Q?3oksvd+2Mt0nSx+RzrHzuyQwC+szWWe04zVg6lxJVDWDsvLVhJ5jR7IVzZSW?=
 =?us-ascii?Q?tnDGjsq1Dk7RkNNeF1M1+jYjkorV912d8IkFq9JIZvSsmlkwDmNwb0Rhc3tU?=
 =?us-ascii?Q?HbNc722WoHB2Wv79FA0BBpvU/UJAb+nd0Y3H/mIBNUO8TSMEglJO8U0T9/xr?=
 =?us-ascii?Q?vOTWk/nkjo4hWNo6ZZtkvjSdWkXZGUt/LLShgslhSB0mSEkziU4laGJMw9nb?=
 =?us-ascii?Q?ChyJaRxtSSeGWqrHd0UkwqYRsXHgRFtHPgBB3ujCllVYeBPKqrAa2DLQ1Fo0?=
 =?us-ascii?Q?xsBwa28fRCf5emh2FLFx2iUPHmxj4sOKciPkMytodA4fkmMhw2ur85neTwcW?=
 =?us-ascii?Q?RkufyjzP3OcVEeJDheM3K7mIMV/2Vys/Qj2VjXlWEzkq1vPtdWfD2JgzHNwG?=
 =?us-ascii?Q?FfsBGb0sQCiVqf9ImjAmNUUzItZAOpc34Gb3WrfVlitYKVgtp/ELeYCODeiy?=
 =?us-ascii?Q?EGS5AJ7XjdlJVbNTIgGntTSO0SEnxFw4xr6ydm4ybrtxNsRVNLnO7BB/I4Pi?=
 =?us-ascii?Q?oPjX0dS6RC2Tjs6gsmMeJoOd/S1p5CkJ49g4zXFbHQWZLwKSjuEdp0VrssuI?=
 =?us-ascii?Q?7Zt8AHOdJ/+X8JsL8YLiBtKNXbM7m5v3VnZBqq17Dea4aAnLMdTflS6DrWue?=
 =?us-ascii?Q?W84pE9xAqw/U84EwTNcuenPN/AYpb7Wje4Q87yzymSQROhYP7Qn36uAzqK1Z?=
 =?us-ascii?Q?jfPoM6xCZWUTLphLjn1YVnwnw+5EY5WfkpRXa1g1oYtJyeFFYkNDAPOsmnlr?=
 =?us-ascii?Q?og1FXlQunIA+iSDpmuX4oUL2WFsb5ooV0Iski69FX2bEUYWeNh5ACsCpgGGn?=
 =?us-ascii?Q?TKemh/WjKfutj0AXtb8V/KY8OidNQDiYpFsEjyILcmG1rbI9c34wP+u7526w?=
 =?us-ascii?Q?qBbPkduv84oIDkOPUSFle8lYMLyJg8I39sz0dfxopbd5UG9uNfpbBrUh9PVe?=
 =?us-ascii?Q?lWfFoPtXCFHtw10q+bBfTQOxhNNbg/culzxvqmrTZvvsE/khWgDpfbqjsjxS?=
 =?us-ascii?Q?vM37dHMwjo/xT6BJzcbBKsYd0W3MNX46cnfzM1eyMyxlny1/TRCNhIhk8juN?=
 =?us-ascii?Q?8doi1u0HBOkHSJN5TLWb875XXB4zwyJ/IHDDtJL2lpTCX2TdWsH/h5M60LdY?=
 =?us-ascii?Q?VbL/3CgB8IyCb9ro+wAMLBCplYxwovmv4kPDj+L3/Y+fcVmUP1hgM8FTyOnE?=
 =?us-ascii?Q?2Up+ZSiZVA3jjUe30pxBk3D/tCQ5BvPcvZJq/lQmcq2m74a/CnilJIPYjIWP?=
 =?us-ascii?Q?v7vKD+xkiRZYkquC4tpsO0zPjNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:25:57.8547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb042200-02aa-481d-325e-08de539a5cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

In preparation for CXL VH (Virtual Host) topology protocol error handling,
add RAS capability registered mapping for all ports in a CXL VH topology.
This includes the RAS capabilities of Switch Upstream Ports, Switch
Downstream Ports, Host Bridge Ports ("upstream"), and Root Ports
("downstream")

Update cxl_port_add_dport() to map the upstream RAS capability on first
'dport' attach, and downstream RAS capability on each 'dport' attach.
Arrange for dport mappings to be released at del_dport() time.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[djbw: reword changelog, fix devm handling]
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- Correct message spelling (Terry)
---
 drivers/cxl/core/port.c       |  2 +-
 drivers/cxl/core/ras.c        | 11 +++++++++++
 drivers/cxl/cxl.h             |  2 ++
 drivers/cxl/cxlpci.h          |  4 ++++
 drivers/cxl/port.c            | 37 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/mock.c | 12 ++++++++++++
 7 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2184c20af011..2c4e28e7975c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1451,7 +1451,7 @@ static void del_dport(struct cxl_dport *dport)
 {
 	struct cxl_port *port = dport->port;
 
-	devm_release_action(&port->dev, unlink_dport, dport);
+	devres_release_group(&port->dev, dport);
 }
 
 static void del_dports(struct cxl_port *port)
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 84abcf90fa99..76ac567724e3 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -162,6 +162,17 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_ras_setup, "CXL");
 
+void devm_cxl_port_ras_setup(struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	map->host = &port->dev;
+	if (cxl_map_component_regs(map, &port->regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 46491046f101..805923693707 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -607,6 +607,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -628,6 +629,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index e41bb93d583a..ef4496b4e55e 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -82,6 +82,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
+void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
 
@@ -93,6 +94,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 {
 }
+static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
+{
+}
 #endif
 
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 8f8fc98c1428..0d6e010e21ca 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -176,11 +176,29 @@ static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
 DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
 	    if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
 
+static struct cxl_dport *cxl_dport_devres_group(struct cxl_dport *dport)
+{
+	if (!devres_open_group(&dport->port->dev, dport, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+	return dport;
+}
+DEFINE_FREE(cxl_dport_group_free, struct cxl_dport *,
+	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->port->dev, _T))
+
 static void cxl_port_group_close(struct cxl_port *port)
 {
 	devres_remove_group(&port->dev, port);
 }
 
+/*
+ * Unlike the port group, that just facilitates unwind of setup failures, the
+ * dport group needs to stay live for del_dport() to reference.
+ */
+static void cxl_dport_group_close(struct cxl_dport *dport)
+{
+	devres_close_group(&dport->port->dev, dport);
+}
+
 static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 					    struct device *dport_dev)
 {
@@ -209,6 +227,13 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		rc = devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
 			return ERR_PTR(rc);
+
+		/*
+		 * RAS setup is optional, either driver operation can continue
+		 * on failure, or the device does not implement RAS registers.
+		 */
+		devm_cxl_port_ras_setup(port);
+
 		/*
 		 * Note, when nr_dports returns to zero the port is unregistered
 		 * and triggers cleanup. I.e. no need for open-coded release
@@ -220,12 +245,24 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 	if (IS_ERR(new_dport))
 		return new_dport;
 
+	/*
+	 * Establish a group for all dport resources that need to be released
+	 * when the dport is deleted.
+	 */
+	struct cxl_dport *dport_group __free(cxl_dport_group_free) =
+		cxl_dport_devres_group(new_dport);
+	if (IS_ERR(dport_group))
+		return ERR_CAST(dport_group);
+
 	rc = cxl_dport_autoremove(new_dport);
 	if (rc)
 		return ERR_PTR(rc);
 
+	devm_cxl_dport_ras_setup(new_dport);
+
 	cxl_switch_parse_cdat(new_dport);
 
+	cxl_dport_group_close(no_free_ptr(dport_group));
 	cxl_port_group_close(no_free_ptr(port_group));
 
 	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 7250bedf0448..6c516019600e 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -13,6 +13,7 @@ ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
 ldflags-y += --wrap=cxl_add_dport_by_dev
 ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
+ldflags-y += --wrap=devm_cxl_port_ras_setup
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 8883357ee50d..a0b87bbb2f75 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -246,6 +246,18 @@ void __wrap_devm_cxl_dport_ras_setup(struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_ras_setup, "CXL");
 
+void __wrap_devm_cxl_port_ras_setup(struct cxl_port *port)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (!ops || !ops->is_mock_port(port->uport_dev))
+		devm_cxl_port_ras_setup(port);
+
+	put_cxl_mock_ops(index);
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_ras_setup, "CXL");
+
 struct cxl_dport *__wrap_cxl_add_dport_by_dev(struct cxl_port *port,
 					      struct device *dport_dev)
 {
-- 
2.34.1


