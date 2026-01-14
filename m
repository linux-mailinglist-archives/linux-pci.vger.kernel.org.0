Return-Path: <linux-pci+bounces-44813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EE6D20D2F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33F413099C74
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239073358A0;
	Wed, 14 Jan 2026 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZftAKdNh"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48F285CAD;
	Wed, 14 Jan 2026 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415130; cv=fail; b=FRHVtpBR9+MBKAgeI2WruEa+sO2HOnnksFbv7USZ/gArnt+aATvYQQM2FWyJbWa7M/ECHiKBqAdvB5m/0Az9t+hnZa2QrLvqsAAjuubweYNzhHpSvU3hwE1VJob6QOsxXV3UhJEAWpmvH8ghL4JLwYj0uAgeK035qFdyVhlyBrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415130; c=relaxed/simple;
	bh=OuN/clS1eOXpaR9rAQhArDQN8GXFoBUFh8MAAdQeDxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQaE0NLqbwjUbAvfqoGbyDr3lyiLdl1wIciEDljuc0pU+mBAYYe7Iocwaej9vg14pGIvGx/kX535yGlRiK3RiiJprx9pPXRWdBhxHYH5ofUUUe8hUDRyR0rJMsI4ivE51NHHl0/vpRKw9WtkyointguM4XTA11onEyBRPrOryVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZftAKdNh; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqzMgYReFJvx6KCd1DeCe2Q55ZOaGKP5TNhPDtmwOZOQWmlPibqkf0jG23L7MFKh9GQIgOjaL2EGgxx689r0lrzewBvEGM0v+bkdcKAwWnenDalfP0U2SZDsD5Fw6z7c1vBEA+PP91VZOMLA5P9I+jdxm6q5vKp32h22hkUFRibp5u+t22M0LKBnidS7qqCPbxXhwf1/lJ6k4pjaScMdrxF8eg4tQIZOmYRXGXUCsAkyZhU7pM979jDQc2LdokedTic+U4zdpjJOeBgL9tYocl/lgWJP/32wPyPDTTocj8gsbjruz5ZDL0pmIGv7UvhFfDiC1dKA/GCxm+D+AcuA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tyFQ1geVPUmyZ/96f9iEm1CL6Bs/GxqAyFLqoikJN8=;
 b=dF+KrQFv85q3a0iJfstvmRtu+1h72LtFOxHFBOXzeTOhP89qdJDKZjm3eR4Hm3XpwERo2Et23OHxCx4KSPGKYR8giv42T1DTbFAqjc1bM5V/WCRKFfcgFbOdrjfUAoY3/qQzcxymkdiR09frTXrHXpi9c4xxHxEKgMXK0MsNEyIR7gkx52GLE/zHoLm8wIJzbEJNzpK6WUTmcBjsybx9+gRHphqe+yPK0C6yYCiSpuhEV64afVCd+BZM+rB35qjnd/RsQmm15mmiyC9/Uut7g5tRLjOO28OleiIfO6vOskKAGaPZtFLcY49XB0pRlALaf5TfhjD3aIBhn5aTVPaqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tyFQ1geVPUmyZ/96f9iEm1CL6Bs/GxqAyFLqoikJN8=;
 b=ZftAKdNhL4XkWUAW34sBY/lNs8aL0u+dQVGCALuotHoWE5tx9/izoJbCXfzN/Hc/Oc0vpdkUwV6U+m2OIPpa1oe2nexDwEZLLNuhBipOyQpkMbtWR18SYD4TxLrM5rkYPEfCWy5TGS3ZUisLMrLKEIKydF7o/PE9SmDOzISwfoI=
Received: from SJ0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:a03:3a0::34)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:25:20 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::e0) by SJ0PR03CA0269.outlook.office365.com
 (2603:10b6:a03:3a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:25:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:25:18 -0600
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
Subject: [PATCH v14 20/34] cxl/port: Move dport operations to a driver event
Date: Wed, 14 Jan 2026 12:20:41 -0600
Message-ID: <20260114182055.46029-21-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: d679322b-f156-4195-3052-08de539a45ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iO7Pv4XnENKsjqm//ExShRkM706QT8HXnw3tR7GMH+l1Helbf7lgOK/jxtOS?=
 =?us-ascii?Q?xb2RkQpvIDmE4U96TNpMxle2L6K4I7gFLJ0SFFKAo/FW6tnvl6xlHplpkx7o?=
 =?us-ascii?Q?uqUrmbkvu/CEXC41awRR+5sHpEZQx8g04qHWXPY9rkWiV1GGqieCUFR+4d1G?=
 =?us-ascii?Q?6w4xM4A6T2Pd8BgxZwZbM2aNdiJiYvjc0S/kJbj1mASVXsgo5pXxRMlEKRjg?=
 =?us-ascii?Q?ti5jScIrytyxyOL4QbGhzzGV/yR+aWV63P3Xn8fvyi9/ccbdxkhZQ6R2j/DV?=
 =?us-ascii?Q?MwnqQF+4LTAkGDwroaWj7dAV8tGYjUZOdaTqwNpMwu0H9lCfKm8uuakoSzpZ?=
 =?us-ascii?Q?0XanQ9lhsQKAORYHnjIi6TUQZFspxOgqly2iFi5JKs4vlAnRl/R6geaCXm7N?=
 =?us-ascii?Q?Au6br8Py9n0kreaPJxD/xoTo2L1LsBVQ/t3s9WhDzRqBtbacuAva9lGQTCHJ?=
 =?us-ascii?Q?vrOA/iK8d7h1LBuW5TxDWllkqX3Dmm/N/2WxWyn1YUD1tXPTW9sAc8uciXf6?=
 =?us-ascii?Q?O8RKMunQ1BskqwOlRwC3uzSxrwl91/nJnJBp5fv/DiYuyMJEK8hMkioGLrXY?=
 =?us-ascii?Q?hZR7A4nA7Vjq3nl04wWP+rRZL+WhENTR18BlZxRqyLve9kCj9o2dUEZwIanL?=
 =?us-ascii?Q?szxjKuswUX6w2dsgNlwM8SwVaGKbXY2obQfNu+PQuz/AEJ+O+N2ALEhkZX63?=
 =?us-ascii?Q?mfpM5Yt+L6GXeOUdqMpxZgtaXFibi2h35bBZiObeJZN/aFoLIS+2p2wk41y2?=
 =?us-ascii?Q?D4mP7NWWfLh9vkjLIf8wUjljsIu1q5ORtenB9jXhqYaAIJJnm3V+ba+AlRoS?=
 =?us-ascii?Q?jPmpXTrnQ+7JhACxJ6DeMqnbjTz8/kEPjJNjq1xy/wMeamH9B8NySikNPDHo?=
 =?us-ascii?Q?s/8IeujAOzeJYug921JahxY2eVn4mHjKUkxmtmwPmgbKhAJu7vKf/j3OdaWC?=
 =?us-ascii?Q?asmgJizvBdskct+LMIM2ZwQn47GCVlZuZk75fQRilDcmqHXn2LJA4Q4V4EUO?=
 =?us-ascii?Q?8Zv4c5Ov5ylhHLY5DfqY9huYkys6TQxalwpUDBX2jpJApF3laoUsmkti7G+t?=
 =?us-ascii?Q?016Q+5OuNlgPeS5L6evOL3yRtkgCOG3fzbv5Qbg4RvzswoQ/LLp96DpFGt14?=
 =?us-ascii?Q?Q4Q8OiVx55gZvtPBRxl8ZQ/7ONIXuDLjeE0AzTSnHuN3xzUglvfCkLGbEQW0?=
 =?us-ascii?Q?AHN1q1N8o3J01gVT+IUWagZfnGPxuBke8fpYWJZyZNpdfdKNZbBN7M197/sm?=
 =?us-ascii?Q?7jQYqcMFsmYCvY261z0xJ007GfPc69LNDtvRaozBb2SKEOsoEhQir0zsfe0t?=
 =?us-ascii?Q?Hf5Qm7Wemhs5D1uemWKOT4HlVFyPXABKso2RajE2MQTcvegZUxvfp7Fv1Qx9?=
 =?us-ascii?Q?K7MVuq8x0Q8A/uEoRw+u5ydlVdkvSamrq1jhqR283gRLBSHkBgVj80XSkxje?=
 =?us-ascii?Q?/aMW8+kEdwZv0ma+o1NoxTsSjNnTO3iXEV8gGeG4uyf5OYy5K46hvifqdplt?=
 =?us-ascii?Q?JPyGRQN5MkdotopvIoUMdwq6xCWSCKG0ZgbgC4iKXBCXqSMdHJ9IjjPr/xyf?=
 =?us-ascii?Q?dfyUq1O4uig8+vBlWKhFa1fgnOcaNAx6q6Px7k0fEtGjOP/4lqLaZfgt+peE?=
 =?us-ascii?Q?aSqQdLqpHYcP3r4c2FHfghocCWtFZ4m6wIfvCPpXCfueKVqFzSsGI04J0TYY?=
 =?us-ascii?Q?cQQBB8enoy3tjr/khd6J7pSHsSM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:25:19.1110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d679322b-f156-4195-3052-08de539a45ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663

From: Dan Williams <dan.j.williams@intel.com>

In preparation for adding more register setup to the cxl_port_add_dport()
path (for RAS register mapping), move the dport creation event to a driver
callback. This achieves 2 things it puts driver operations logically where
they belong, in a driver, and it obviates the gymnastics of
DECLARE_TESTABLE() which just makes a mess of grepping for CXL symbols.

In other words, a driver callback is less of an ongoing maintenance burden
than this DECLARE_TESTABLE arrangement that does not scale and diminishes
the grep-ability of the codebase.

cxl_port_add_dport() moves mostly unmodified from drivers/cxl/core/port.c.
The only deliberate change is that it now assumes that the device_lock is
held on entry and the driver is attached (just like cxl_port_probe()).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13 -> v14:
- New patch
---
 drivers/cxl/core/hdm.c               |  6 +--
 drivers/cxl/core/pci.c               |  8 +--
 drivers/cxl/core/port.c              | 79 ++++++----------------------
 drivers/cxl/cxl.h                    | 23 ++------
 drivers/cxl/port.c                   | 71 +++++++++++++++++++++++++
 tools/testing/cxl/Kbuild             |  2 +
 tools/testing/cxl/cxl_core_exports.c | 21 --------
 tools/testing/cxl/exports.h          | 13 -----
 tools/testing/cxl/test/mock.c        | 23 +++-----
 9 files changed, 107 insertions(+), 139 deletions(-)
 delete mode 100644 tools/testing/cxl/exports.h

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1c5d2022c87a..365b02b7a241 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1219,12 +1219,12 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 }
 
 /**
- * __devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
+ * devm_cxl_switch_port_decoders_setup - allocate and setup switch decoders
  * @port: CXL port context
  *
  * Return 0 or -errno on error
  */
-int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
+int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
 
@@ -1248,7 +1248,7 @@ int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 	dev_err(&port->dev, "HDM decoder capability not found\n");
 	return -ENXIO;
 }
-EXPORT_SYMBOL_NS_GPL(__devm_cxl_switch_port_decoders_setup, "CXL");
+EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
 
 /**
  * devm_cxl_endpoint_decoders_setup - allocate and setup endpoint decoders
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 512a3e29a095..8633bfdef38d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -41,14 +41,14 @@ static int pci_get_port_num(struct pci_dev *pdev)
 }
 
 /**
- * __cxl_add_dport_by_dev - allocate a dport by dport device
+ * cxl_add_dport_by_dev - allocate a dport by dport device
  * @port: cxl_port that hosts the dport
  * @dport_dev: 'struct device' of the dport
  *
  * Returns the allocated dport on success or ERR_PTR() of -errno on error
  */
-struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
-					 struct device *dport_dev)
+struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
+				       struct device *dport_dev)
 {
 	struct cxl_register_map map;
 	struct pci_dev *pdev;
@@ -69,7 +69,7 @@ struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
 	device_lock_assert(&port->dev);
 	return cxl_add_dport(port, dport_dev, port_num, map.resource);
 }
-EXPORT_SYMBOL_NS_GPL(__cxl_add_dport_by_dev, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_add_dport_by_dev, "CXL");
 
 struct cxl_walk_context {
 	struct pci_bus *bus;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a05a1812bb6e..2184c20af011 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1603,78 +1603,31 @@ static int update_decoder_targets(struct device *dev, void *data)
 	return 0;
 }
 
-static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
+void cxl_port_update_decoder_targets(struct cxl_port *port,
+				     struct cxl_dport *dport)
 {
-	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
-		return ERR_PTR(-ENOMEM);
-	return port;
+	device_for_each_child(&port->dev, dport, update_decoder_targets);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_port_update_decoder_targets, "CXL");
+
 DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
 	if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
 
-static void cxl_port_group_close(struct cxl_port *port)
-{
-	devres_remove_group(&port->dev, port);
-}
-
-static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
-					    struct device *dport_dev)
+static struct cxl_dport *probe_dport(struct cxl_port *port,
+				     struct device *dport_dev)
 {
-	struct cxl_dport *new_dport;
-	struct cxl_dport *dport;
-	int rc;
+	struct cxl_driver *drv;
 
 	device_lock_assert(&port->dev);
 	if (!port->dev.driver)
 		return ERR_PTR(-ENXIO);
 
-	dport = cxl_find_dport_by_dev(port, dport_dev);
-	if (dport) {
-		dev_dbg(&port->dev, "dport%d:%s already exists\n",
-			dport->port_id, dev_name(dport_dev));
-		return ERR_PTR(-EBUSY);
-	}
-
-	/*
-	 * With the first dport arrival it is now safe to start looking at
-	 * component registers. Be careful to not strand resources if dport
-	 * creation ultimately fails.
-	 */
-	struct cxl_port *port_group __free(cxl_port_group_free) =
-		cxl_port_devres_group(port);
-	if (IS_ERR(port_group))
-		return ERR_CAST(port_group);
-
-	if (port->nr_dports == 0) {
-		rc = devm_cxl_switch_port_decoders_setup(port);
-		if (rc)
-			return ERR_PTR(rc);
-		/*
-		 * Note, when nr_dports returns to zero the port is unregistered
-		 * and triggers cleanup. I.e. no need for open-coded release
-		 * action on dport removal. See cxl_detach_ep() for that logic.
-		 */
-	}
-
-	new_dport = cxl_add_dport_by_dev(port, dport_dev);
-	if (IS_ERR(new_dport))
-		return new_dport;
-
-	rc = cxl_dport_autoremove(new_dport);
-	if (rc)
-		return ERR_PTR(rc);
-
-	cxl_switch_parse_cdat(new_dport);
-
-	cxl_port_group_close(no_free_ptr(port_group));
-
-	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
-		port->nr_dports - 1, new_dport->port_id, dev_name(dport_dev));
-
-	/* New dport added, update the decoder targets */
-	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
+	drv = container_of(port->dev.driver, struct cxl_driver, drv);
+	if (!drv->add_dport)
+		return ERR_PTR(-ENXIO);
 
-	return new_dport;
+	/* see cxl_port_add_dport() */
+	return drv->add_dport(port, dport_dev);
 }
 
 static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
@@ -1721,7 +1674,7 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
 	}
 
 	guard(device)(&port->dev);
-	return cxl_port_add_dport(port, dport_dev);
+	return probe_dport(port, dport_dev);
 }
 
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
@@ -1753,7 +1706,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	scoped_guard(device, &parent_port->dev) {
 		parent_dport = cxl_find_dport_by_dev(parent_port, dparent);
 		if (!parent_dport) {
-			parent_dport = cxl_port_add_dport(parent_port, dparent);
+			parent_dport = probe_dport(parent_port, dparent);
 			if (IS_ERR(parent_dport))
 				return PTR_ERR(parent_dport);
 		}
@@ -1789,7 +1742,7 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
 	device_lock_assert(&port->dev);
 	dport = cxl_find_dport_by_dev(port, dport_dev);
 	if (!dport) {
-		dport = cxl_port_add_dport(port, dport_dev);
+		dport = probe_dport(port, dport_dev);
 		if (IS_ERR(dport))
 			return dport;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 47ee06c95433..46491046f101 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -841,8 +841,9 @@ struct cxl_endpoint_dvsec_info {
 };
 
 int devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
-int __devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
 int devm_cxl_endpoint_decoders_setup(struct cxl_port *port);
+void cxl_port_update_decoder_targets(struct cxl_port *port,
+				     struct cxl_dport *dport);
 
 struct cxl_dev_state;
 int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
@@ -856,6 +857,8 @@ struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
+	struct cxl_dport *(*add_dport)(struct cxl_port *port,
+				       struct device *dport_dev);
 	struct device_driver drv;
 	int id;
 };
@@ -940,8 +943,6 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
 				       struct device *dport_dev);
-struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
-					 struct device *dport_dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
@@ -953,20 +954,4 @@ struct cxl_dport *__cxl_add_dport_by_dev(struct cxl_port *port,
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
 
-/*
- * Declaration for functions that are mocked by cxl_test that are called by
- * cxl_core. The respective functions are defined as __foo() and called by
- * cxl_core as foo(). The macros below ensures that those functions would
- * exist as foo(). See tools/testing/cxl/cxl_core_exports.c and
- * tools/testing/cxl/exports.h for setting up the mock functions. The dance
- * is done to avoid a circular dependency where cxl_core calls a function that
- * ends up being a mock function and goes to * cxl_test where it calls a
- * cxl_core function.
- */
-#ifndef CXL_TEST_ENABLE
-#define DECLARE_TESTABLE(x) __##x
-#define cxl_add_dport_by_dev DECLARE_TESTABLE(cxl_add_dport_by_dev)
-#define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
-#endif
-
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 167cc0a87484..2770bc8520d3 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -155,9 +155,80 @@ static const struct attribute_group *cxl_port_attribute_groups[] = {
 	NULL,
 };
 
+static struct cxl_port *cxl_port_devres_group(struct cxl_port *port)
+{
+	if (!devres_open_group(&port->dev, port, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+	return port;
+}
+DEFINE_FREE(cxl_port_group_free, struct cxl_port *,
+	    if (!IS_ERR_OR_NULL(_T)) devres_release_group(&(_T)->dev, _T))
+
+static void cxl_port_group_close(struct cxl_port *port)
+{
+	devres_remove_group(&port->dev, port);
+}
+
+static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
+					    struct device *dport_dev)
+{
+	struct cxl_dport *new_dport;
+	struct cxl_dport *dport;
+	int rc;
+
+	dport = cxl_find_dport_by_dev(port, dport_dev);
+	if (dport) {
+		dev_dbg(&port->dev, "dport%d:%s already exists\n",
+			dport->port_id, dev_name(dport_dev));
+		return ERR_PTR(-EBUSY);
+	}
+
+	/*
+	 * With the first dport arrival it is now safe to start looking at
+	 * component registers. Be careful to not strand resources if dport
+	 * creation ultimately fails.
+	 */
+	struct cxl_port *port_group __free(cxl_port_group_free) =
+		cxl_port_devres_group(port);
+	if (IS_ERR(port_group))
+		return ERR_CAST(port_group);
+
+	if (port->nr_dports == 0) {
+		rc = devm_cxl_switch_port_decoders_setup(port);
+		if (rc)
+			return ERR_PTR(rc);
+		/*
+		 * Note, when nr_dports returns to zero the port is unregistered
+		 * and triggers cleanup. I.e. no need for open-coded release
+		 * action on dport removal. See cxl_detach_ep() for that logic.
+		 */
+	}
+
+	new_dport = cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(new_dport))
+		return new_dport;
+
+	rc = cxl_dport_autoremove(new_dport);
+	if (rc)
+		return ERR_PTR(rc);
+
+	cxl_switch_parse_cdat(new_dport);
+
+	cxl_port_group_close(no_free_ptr(port_group));
+
+	dev_dbg(&port->dev, "dport[%d] id:%d dport_dev: %s added\n",
+		port->nr_dports - 1, new_dport->port_id, dev_name(dport_dev));
+
+	/* New dport added, update the decoder targets */
+	cxl_port_update_decoder_targets(port, new_dport);
+
+	return new_dport;
+}
+
 static struct cxl_driver cxl_port_driver = {
 	.name = "cxl_port",
 	.probe = cxl_port_probe,
+	.add_dport = cxl_port_add_dport,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
 		.dev_groups = cxl_port_attribute_groups,
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 4d740392aac5..25516728535e 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -11,6 +11,8 @@ ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
+ldflags-y += --wrap=cxl_add_dport_by_dev
+ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 02d479867a12..f088792a8925 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -2,27 +2,6 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include "cxl.h"
-#include "exports.h"
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, "CXL");
-
-cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
-EXPORT_SYMBOL_NS_GPL(_cxl_add_dport_by_dev, "CXL");
-
-struct cxl_dport *cxl_add_dport_by_dev(struct cxl_port *port,
-				       struct device *dport_dev)
-{
-	return _cxl_add_dport_by_dev(port, dport_dev);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_add_dport_by_dev, "CXL");
-
-cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup =
-	__devm_cxl_switch_port_decoders_setup;
-EXPORT_SYMBOL_NS_GPL(_devm_cxl_switch_port_decoders_setup, "CXL");
-
-int devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
-{
-	return _devm_cxl_switch_port_decoders_setup(port);
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_switch_port_decoders_setup, "CXL");
diff --git a/tools/testing/cxl/exports.h b/tools/testing/cxl/exports.h
deleted file mode 100644
index cbb16073be18..000000000000
--- a/tools/testing/cxl/exports.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 2025 Intel Corporation */
-#ifndef __MOCK_CXL_EXPORTS_H_
-#define __MOCK_CXL_EXPORTS_H_
-
-typedef struct cxl_dport *(*cxl_add_dport_by_dev_fn)(struct cxl_port *port,
-						     struct device *dport_dev);
-extern cxl_add_dport_by_dev_fn _cxl_add_dport_by_dev;
-
-typedef int(*cxl_switch_decoders_setup_fn)(struct cxl_port *port);
-extern cxl_switch_decoders_setup_fn _devm_cxl_switch_port_decoders_setup;
-
-#endif
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 660e8402189c..10140a4c5fac 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -10,20 +10,12 @@
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include "mock.h"
-#include "../exports.h"
 
 static LIST_HEAD(mock);
 
-static struct cxl_dport *
-redirect_cxl_add_dport_by_dev(struct cxl_port *port, struct device *dport_dev);
-static int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port);
-
 void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
 	list_add_rcu(&ops->list, &mock);
-	_cxl_add_dport_by_dev = redirect_cxl_add_dport_by_dev;
-	_devm_cxl_switch_port_decoders_setup =
-		redirect_devm_cxl_switch_port_decoders_setup;
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
@@ -31,9 +23,6 @@ DEFINE_STATIC_SRCU(cxl_mock_srcu);
 
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {
-	_devm_cxl_switch_port_decoders_setup =
-		__devm_cxl_switch_port_decoders_setup;
-	_cxl_add_dport_by_dev = __cxl_add_dport_by_dev;
 	list_del_rcu(&ops->list);
 	synchronize_srcu(&cxl_mock_srcu);
 }
@@ -162,7 +151,7 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
-int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
+int __wrap_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 {
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -170,11 +159,12 @@ int redirect_devm_cxl_switch_port_decoders_setup(struct cxl_port *port)
 	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_switch_port_decoders_setup(port);
 	else
-		rc = __devm_cxl_switch_port_decoders_setup(port);
+		rc = devm_cxl_switch_port_decoders_setup(port);
 	put_cxl_mock_ops(index);
 
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_switch_port_decoders_setup, "CXL");
 
 int __wrap_devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
 {
@@ -256,8 +246,8 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
 
-struct cxl_dport *redirect_cxl_add_dport_by_dev(struct cxl_port *port,
-						struct device *dport_dev)
+struct cxl_dport *__wrap_cxl_add_dport_by_dev(struct cxl_port *port,
+					      struct device *dport_dev)
 {
 	int index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
@@ -266,11 +256,12 @@ struct cxl_dport *redirect_cxl_add_dport_by_dev(struct cxl_port *port,
 	if (ops && ops->is_mock_port(port->uport_dev))
 		dport = ops->cxl_add_dport_by_dev(port, dport_dev);
 	else
-		dport = __cxl_add_dport_by_dev(port, dport_dev);
+		dport = cxl_add_dport_by_dev(port, dport_dev);
 	put_cxl_mock_ops(index);
 
 	return dport;
 }
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_add_dport_by_dev, "CXL");
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("cxl_test: emulation module");
-- 
2.34.1


