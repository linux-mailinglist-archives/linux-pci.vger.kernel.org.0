Return-Path: <linux-pci+bounces-21199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6043A31559
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B991885D1C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14814267B97;
	Tue, 11 Feb 2025 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5i1JFITi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F301263893;
	Tue, 11 Feb 2025 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301987; cv=fail; b=Jf/RN/oXgaQkONi+XgIWvyVku/tUUVAO1PVduD0oV6XtHb7e+GRfp8IxRK/o1Oitddwhq08rOwkjtv0ALLX3sfTnYDryQpiGIzEBinlT4OPPQ1buCuevPdZK3IIIkGXOOUREgJCfKFYeilow31R4QAbBOP5hYtg5SJfQopZfpbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301987; c=relaxed/simple;
	bh=RDnlACLA9hYGQrZdKA0HgeO6V/B9Pb1OlTGKkqvADYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVqtRcvwtO2ZwEDV7JXOJvdAHCdRCAk+MJRVND0yhVrqVpDCg7yDwk/1cuu+o+leAn4+3Iaflcs6T6xAEmrbM+Idyz1HSd4H+5kdWFS56TB+obR+fkBoHPyFJ4JP2S/tbmdnmufoQO2gCz5IDzBhttrzmtHE9GdOjceWiuA7xvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5i1JFITi; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXZLTcVteX959XKH7+4FQeI96p54ZOTezEzy/ryY6VrlybIu2ufLp1JaMBce7f8IRiJY+hFX4RjDH7mAwrB+j2ziSlTF7rB+pexFsbZer2L7Wg40okjr0kPAk+WcEZKUWsH+sgJjv167Gwv9IN2bGh0wtkwJUT152nTuQZFWtLIe8H0NX14pVi/ZMlooWNrRTIRhzCQhP74Z4oG9kMZgedwpJ9XVjVhMwQ6pq83iezqXfH6uA7VxyLV8fTW4yu6IyrnyB5Fz8g/diqs1/ZtXfhvw63v2eE+puCM5RBcfG++2pTe7ZaNrp+JtTFjXrB+wC/c4EvdGKLXwc0nmsEOcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBqzTPDCPdP0wsSxtD7NqVdU1IyrExzdnpEuhpksHSM=;
 b=YMRQYwhOGTjgO1o7TE1NBrOvPbatvTAJSOH6OEo+0RbQyvQsBXs08iP9jzgGJRO3xbqjOjZLUDY4QWRE0uolpkuUvZWKQIKOvmhMnIFydIQ7X2GSnPJMW/qbwrJFjBP7VhFBAlhk10Mj382fPJpHI3NsHO6/Xij97+Jt5AQeS2fjQkVEpRrZTk/S7ROPCJZGKNLkI8L5W9jDb0Foijmz3TYwJKM2O5Uh0M9cUd4BPdLo2JM1kUqpI9u7U3HoNTjc7YWj5Et1u/BCnEIcfTXRMxacgLTL0bDDnmEDQf8V0Yq9OrXQjHt1shVFO/CqJmgcjIZdXVGNsRHNSyShwF2I7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBqzTPDCPdP0wsSxtD7NqVdU1IyrExzdnpEuhpksHSM=;
 b=5i1JFITiSPLCHXsJMAKR2T+2/hPq4/5dLObqGbJwV+Xg4PAOQBUQBo5eR1O7C5brBxaF9LnRhMHhZeTgdwKJg5Z3kOf0dsWDLGiuddyzFIv9LWK2NKWXMGTOPu9ZGqm2gEN4E8Hl1UOaYLPpEUvMRycmoCEGJaJjPB+DpILPYZE=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:26:21 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e3) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:26:20 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:26:18 -0600
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
Subject: [PATCH v7 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
Date: Tue, 11 Feb 2025 13:24:35 -0600
Message-ID: <20250211192444.2292833-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: f2274020-e6f6-4cc5-6025-08dd4ad1f69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqo9HoULtYEJ/vNKZK2oK87eI3lDzP+q/4IV+J68UFdwzX0KkG5c9W8yDFxN?=
 =?us-ascii?Q?IJsh4cnK6mtu3MM0JI8GUeBBK/46B6t54YgO0diYesOwBmfYNWwFL+GwmJBO?=
 =?us-ascii?Q?BHuKg/ObAmSbSWH3TEmkJ/VkAfxW4DZVYPBaTipPFt/whI//8bp94N/hnInb?=
 =?us-ascii?Q?p1vKOryVq/BN1A6pbkOyd9JGMDGEbDDiyLJILmfi82i2WrVwr1j27EXavBgE?=
 =?us-ascii?Q?0LLmVOiR8VXAJJysRtLgWpAYmkvpj8yydO/RIKXdcwfwFDEX9py0dc2vSAmw?=
 =?us-ascii?Q?9myosquS+We62RQKkDRT6Nf8q68a5dw+ovj8T5CgcDs2lNxKmTOHFhJffmEB?=
 =?us-ascii?Q?c82DEKhOiBreafxJqGlsEx2ZJ76h98G6IpwpTbteau4brFvFNwM3W/Rof8LU?=
 =?us-ascii?Q?zCmiD3f+zETsprtXrJIh1+f6lFCIxr7AGp2hrAnrQXbduGSxcnTLvO0p9ukP?=
 =?us-ascii?Q?LsdDF7SPnLKcKYGjjCmp+jznIjPcrjb12ZcOHqZ4NuoBpjBwyqwHKSrkEt4M?=
 =?us-ascii?Q?lK2fEXaEnQcrwKcTGsoMzHykv0fDczCBPl7hX6I3WU8SlzDsRxBhIzgVsh0S?=
 =?us-ascii?Q?FDW2RtrxGBjdygnQcneJ7++FVG5O3cwjnSwcO0dA8UMH8eNs4MLTZGisttFB?=
 =?us-ascii?Q?doJxQK4DUOm5was1ZT35+Ywm5mV5OgGQaURC0Uaf3QPzhQXHRNzOonU1Mg0D?=
 =?us-ascii?Q?1aAUDUh6jwfwK9VLXYXfIjU+sboTvHvthFM/mXk2P2afTQ986Bs8QdA3/DXB?=
 =?us-ascii?Q?7BwQCylF9H0kCknoM0QrqOfangkR1GpNJ6g8iu0ndAgGyNMquBkLkUpRUoCl?=
 =?us-ascii?Q?otGZ08c6nm42XFwzcn7nKXpSiIzPHtSwDajrtbmGMG/OodMKWjvKDdbk1/MO?=
 =?us-ascii?Q?ClpiBNihez7aYN2Nqp9GGdpqP5sITaVF3NcZb8FblaIQ/szWChVoZp9lN0SA?=
 =?us-ascii?Q?H4zkZnBZrYsIZY2IRinlH8wIOGhQRAsM4R+xQdnRcWnq6Mj4doffv8NjZIzI?=
 =?us-ascii?Q?Tn1iVmSzoOCM0v37DmCPXtR89UD7Ta00BUNjOKWN9sZqU2eZs4BnyswxDzyu?=
 =?us-ascii?Q?woDF2drZFZr3/UkXqdMeMxS2ttmD1ypcdrCbJWWEWJxP6NByyam6eAa5TDUO?=
 =?us-ascii?Q?IUQhRiTk6I3ophs3ceEY4pMCvFq5/u5vJwL++mle2NHwLg+dIm3vj5DrUdVR?=
 =?us-ascii?Q?gBN6XWDjRgbyEyVdvYnM9Is0vbvuHzsRhNgMP3A5ES7N9OUNCKqfmNJEg4V1?=
 =?us-ascii?Q?kA9Bt9Kznz3h6aB6LkYcjYILamW+A+wwjr40mMiEMAkDjGnoNp0HhRZzdtJj?=
 =?us-ascii?Q?eMMbDeQPiFUtjTxnf1PuIlHLZuGN3JwGzSpu2PwRCzyQaZPKOeLOfJw0W99f?=
 =?us-ascii?Q?3m0keG6vTyaD8q63inA3hhPdWXnYrcSKJ8KkatcgTkSQxmIgkGXSauIDSIQK?=
 =?us-ascii?Q?8Elsl8690cgAJzhy9mu4qELXfnE2jNgdCk40ktGKtYPSBwpbQPtYAsCiiB9+?=
 =?us-ascii?Q?iLjo2X48k2MSO82HiNAeqmciPaknbJsGx2yV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:26:20.1201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2274020-e6f6-4cc5-6025-08dd4ad1f69d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

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
index 143c853a52c4..25513b9a8aff 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -775,6 +775,24 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
@@ -801,7 +819,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
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


