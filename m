Return-Path: <linux-pci+bounces-18201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A19EDC03
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E914B1622DE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41261F4E5B;
	Wed, 11 Dec 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K9EnAqxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944F1F4E48;
	Wed, 11 Dec 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960515; cv=fail; b=DW4vVUJI8PBlb/QHckfMa8ft9S3Feayfy7j6FD+bSzyQMYQ7imsz0PA6SUbydTR2H8pHb8R4WrvQzNRSXt9B2m/FPU2n6cjx5loOMAsoBl8xcdbtsoN++HxPEgLsKAGll41Ls3r50YakgupRn6/TcJvJS4WqM/sy1bHmmZAoTWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960515; c=relaxed/simple;
	bh=LS726Kr6PYlyEh/1SDVT0wJ9nm1VPbiIG8vukmWhF6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4kscndgHSm0S9TXvuV5ipAtogYkux9KdTKw3+GuxrH4px5R1yzyNKjyjD6NTTMNnJFkRfDKng7K3Ij3g745Vb8/CDK8ekdIirtti9iDP1PtvZPVdk/ZT5zG+Rw1wpjmWr1Kfjp7lpVUM6c0NXjWbsqQbarjdfJm+AgKCdQH37o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K9EnAqxE; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqH328/VXv7NCvesD4uWACy8x1A8Gzh14GJ55bNvLwT1n6JtL27hCh6PIOsxlxbGh4aaPuvJq3DPHvS3PlRXasa9JmwF+796g7aTeJHTi81Q5l/szp68T0WH3OlDBRJxbm4RkA8RVQJk6iB9VruuvuX3SB86bViEzvlucE7zLa5l/ekpcnmjJKICwMmqmD78Cjg318xtBr+JIZyuWcQv+6lE8bbtI5Ob/5ZelEsVEW6TNCAUhNc2vqf6ruoWW6/igdtGjqSH6yqQxK/XJXY+SaqaQI3nKve73VOISb9S7ujOruRV57OCQpIgMVcxZ4B7sa3ACU/2euZkryXEHnmfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uQk5sE1gQAZVT4BOu/7WwDs/4GgHDzNFghqmAF4m/4=;
 b=aqBDcfA4qNrCWN1dUcC/hF1j1q09ybunLWolfbwWs16baXmk+dV5ly/6lxzw3xsfMDJ325l+QPq8el/frBJDNMJ33jlCgWOqF1XGMhpV/umz0Ng/+M5aaMGCqMPaaJ+/gKN5d4sH7kK7rBnWFP5eTOgjMNGQ60VwKqAZkhG6APCqH89tGFy9aa5OWwFqBCord1hzLCw7sTnpXUhsntgRg4VbvWLazCGHgMU89gSpG3p1EvcpIbCvTuXU81pVvQOo58Ft7BNrXcgHxACDI3YIaBm4Ijq9ClH5ePyzk3oBT+R9pJPb9DR9IOwMyAsje576eAeWFD7J+vbxWS2dvbbeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uQk5sE1gQAZVT4BOu/7WwDs/4GgHDzNFghqmAF4m/4=;
 b=K9EnAqxELB09ueL2tujuaIXzTayQr1vgH1LPor8NwUkeY/Ac3EKgro908iTz4vjdt8/f+KatEeFPZo+dZo++omBwPM/ShFnRLvagZ3feEw7LWHmuVR8uRzMHBQ19lJvLYxIaLJ0QijxAkQZ2eKRmMljqyrlE8Yd92xzdjctJ0mE=
Received: from BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::13)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 23:41:49 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::8a) by BLAP220CA0008.outlook.office365.com
 (2603:10b6:208:32c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 23:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:41:48 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:41:47 -0600
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
Subject: [PATCH v4 09/15] cxl/pci: Map CXL PCIe Upstream Switch Port RAS registers
Date: Wed, 11 Dec 2024 17:39:56 -0600
Message-ID: <20241211234002.3728674-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: fd57e1c8-fd97-413e-104f-08dd1a3d6148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JEe7++0Qed5zRBqgfVo+bVsGxhXXhin8E4a6+pwpmtlLnrxQDvd8g38xnuxB?=
 =?us-ascii?Q?BMDD6xBHXFtgeyZf1Qgp/O6S8fWkri4tnYyVKX5Saz41Xlet3G3Ryxwy0dAF?=
 =?us-ascii?Q?PjABqhlnwD4t+P3rzOxvo6ROF5Aq43OIPjyHhK4jwYLzborBaB5PbW6kLgIb?=
 =?us-ascii?Q?xiXT9JJFsmChLjbr8E7SBMyFcrKay4SVpWirC7cm8RuXq5vML9Gs0vLRO22S?=
 =?us-ascii?Q?u3QEBSd7NZn3gEOGMsXE5fkobbIXo/Op/rHHkw9mSUckxRADsaeV1jwXDqUf?=
 =?us-ascii?Q?PUdVa5A/8KmRd6QZTkc1Dzm7qmJnThqhVpBCKCk8yBNq+Vvn8/ozV0aNWbFK?=
 =?us-ascii?Q?fyFg9qC7r+ZdVN0JlGkBz4wuawVHFsOybGhQ1Mq3fkN1Io7BwDVrShXDEues?=
 =?us-ascii?Q?7cEhdB8AMT25YFdWCO53VtJWTYOd+Y5GBLtWLi3tdZIVFd+bYNxkjyuYkjqb?=
 =?us-ascii?Q?SBQdzp+VyeFoTY/1KS0uELMHv6jR3aBRQ323kvx6kfNaG5gvp7BDoWeQOPsf?=
 =?us-ascii?Q?9lqHUnBZsZ0LGiyqY3H5BD+IOPQXQ4KJ8G5fxAuMbEEi9TfYm6yZHA6kpamk?=
 =?us-ascii?Q?PjL0ftyrZ8wJ+V8ZjoMIV5HqOJ+HIKDMTnrdrOHMrJ/zX1LuamR4LF76iAis?=
 =?us-ascii?Q?H6XgKBsibixawFkwzbsm322Py7FADXzwyQysYc3mR/QU40uH/YJ7XdarU1fT?=
 =?us-ascii?Q?eHMH66SUHOIEfwKVph0b6987gkL6uM/yMEwoxJ14zhu1fHZxE4rnK6kO57j3?=
 =?us-ascii?Q?4fxEP3Q4IhfXcoVYlJ+MypB0e0RbLBcAYvDmdH6Jql3jLVcAniOHTcnnUtlt?=
 =?us-ascii?Q?0WI+R3t6+Mfwpktt/tqwUJHXlHUBY4zilGRZEtAKoqxkdoIwTqujYosHGZFP?=
 =?us-ascii?Q?aWxHxTPYUSGU4RTVKAxih5b1ePmN1NMBOixi3V7dT07ZxbcczK6pTUB5k6hN?=
 =?us-ascii?Q?1c1Icc0N04jAWWY69gW6CklyF+qcO7ee/GgGRna4aNlJ6qAeKJTyNK8gmlXX?=
 =?us-ascii?Q?IK45umYAdH1PmDuBP+/uPszTcvohxzwOXmS8r1kt4wKdDTwzSAq4wv5akm7C?=
 =?us-ascii?Q?TZg+EtRkXlCS15oMhlx3TcAd7gJ8gSptDV252WbPBU7wgQGVoHgxKdq8TX7C?=
 =?us-ascii?Q?LKWa3Ctu5nJBZqWGzoPq4bedfWCuJdlLtuNwi6wwJqndIlJjHIrs36gG3x8j?=
 =?us-ascii?Q?FM8FfdQZrYYeTspUi4GOGN4JG4tIgfDEphywBbgZPZDFJN4Czc1aIC7QCgAC?=
 =?us-ascii?Q?Mb+E3w7IDaK0334AysxCclcPG2cGfQT/7O8L8leV5DAH8+Kvphgi7JvZc6ep?=
 =?us-ascii?Q?ASu3Fl6mn0CiekcMtzta3djR9KQmCxwdyDdfSoAoT7u6THiXKrHkrGxE+Bm/?=
 =?us-ascii?Q?Fr1ZN9fdqabZ6Z9CvmlJLGoqjeKLwCAeHC/22w/ZU0rzjvF+Vq9mvQ1yXuXr?=
 =?us-ascii?Q?C+zHK1VnFEn7GBautvKYm9DW5smsC1YML9XeNHH/WuPqELI1VQFVIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:41:48.3293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd57e1c8-fd97-413e-104f-08dd1a3d6148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.

Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
pointer to the CXL Upstream Port's mapped RAS registers.

Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
register mapping. This is similar to the existing
cxl_dport_init_ras_reporting() but for USP devices.

The USP may have multiple downstream endpoints. Before mapping AER
registers check if the registers are already mapped.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 15 +++++++++++++++
 drivers/cxl/cxl.h      |  4 ++++
 drivers/cxl/mem.c      |  8 ++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8540d1fd2e25..08073bbe2697 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+void cxl_uport_init_ras_reporting(struct cxl_port *port)
+{
+	/* uport may have more than 1 downstream EP. Check if already mapped. */
+	if (port->uport_regs.ras)
+		return;
+
+	port->reg_map.host = &port->dev;
+	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
+		dev_err(&port->dev, "Failed to map RAS capability.\n");
+		return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
+
 /**
  * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
  * @dport: the cxl_dport that needs to be initialized
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 51acca3415b4..0cf8d2cfcd8b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -592,6 +592,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -612,6 +613,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -764,8 +766,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
+void cxl_uport_init_ras_reporting(struct cxl_port *port);
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
+static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0ae89c9da71e..0ce71af8ce22 100644
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


