Return-Path: <linux-pci+bounces-40166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B968C2E881
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD101889EDD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D51CAA7B;
	Tue,  4 Nov 2025 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7dtpHB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A918FDBE;
	Tue,  4 Nov 2025 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215124; cv=fail; b=qQcX+dN65wojtBvbAaICAPqrcNIKX7itEnHErkW2VF1Gatii46LwWtUAvF+DjcXpiL7Ck5MvwwfiERAZ2TtbArYK0Jz2PwEMcXWFP3rzwOZDvWhMjWMr6r+xBfsPgK3G6CMuUirU4XeviJnSkrD8JZ1SKMBaMJMv3R1zGEHNkCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215124; c=relaxed/simple;
	bh=DI1ql1FTb+fWeuvGT50ltJcAMdBGnnsj7UYribF+QXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4Pdj2OhUnZKj7wUUKrC4Lb5kbYOEQHkZEsyTDFtfgr9pOvy0WsrCQTcYmBHEIuJaPXHVMKbhkkGCBAws6IbOXs6aJa1xqt7OOQuRnnfPVs+VRmkVwdpDB1fuHvkVT4z/SDbONaC46RQ58l8xkJpteNeby5m+SFbLERdVf2A45U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7dtpHB5; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4jvkcmJWQwp3yzJ1jMmDATx+cWHxSpW8UNqQ/ZbvlEuTw41DtLOeFRGP54uMo7m3QNck3f1z/k2oFypink7mcP/5BWnDH6Zq9AHpYhzoTxA8asyjlPtca3ZtmwTA7D6PIrmggruQvpModMIGpTwcVhWoryeiWFkPveQVMugaZ0+pj9CB+zIwgPLYg4TDi7E40T5wVVKBD9S8Y3OfTLxZqv96nv3AufW+YmZO13qegAxik5Prk8WUPWd0BCzCyAYq2AhaI6qdjqt2YVzGj8/P8EewxZvEhpzZHiBe8FRBk22Ti3vbGSDgTcQ168sOE7loV3kd6/yTHEb8CpaIwhHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd2krjXdlLHo2GJs8ggVn3OcMNU4jcNukXzFx+slKdY=;
 b=KnT8UHA7qOwDJpKnhusLsuKWPc26dx7Nbs0/bhDRsfCT8mGs1E/ExgTzgPf4XUObNJgaQSHhVi8PEyIq3RsClfJL8KmVBkF3wNylwVKNF0VCIM24FMhqxxM0iOMAKm9wu91bSqZzuxXK076si8qnfpeFEhAEM71ohWEVwQ//KnCV38Dt1LBiOjyWpFbZ40BMq0IGOTWLoQY3wBaqvbf9Gil9yyshhBgMYdw7zrw6fNrL5Zoqu7rErZvwiYv4bB6r+q0Omsx9LRWCxnA6aR1e3+AqrpuEspHkyjoN2ceKXZQSdM7uThqEtxJiEPKL+eKQVVIt/BFYOkUtqmmQSBkvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd2krjXdlLHo2GJs8ggVn3OcMNU4jcNukXzFx+slKdY=;
 b=B7dtpHB5GmuGkipcZEadupq1LaAnhEHhuXbs+9jIHotgAlZyZ50r5EaGSmpEG4mNjl/7OSQeJxbB1GlHPS5GPxPdQak35Ei3E7gzqKOPhYd0T+N+H83yv16u364mhpwhG6RgtScNhqrqDHWDgnlq/1MYWeC8CjzKmyDy2OfI5is=
Received: from CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:11:59 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::58) by CH0PR03CA0086.outlook.office365.com
 (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:11:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:11:57 -0800
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v13 10/25] cxl/pci: Update RAS handler interfaces to also support CXL Ports
Date: Mon, 3 Nov 2025 18:09:46 -0600
Message-ID: <20251104001001.3833651-11-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad2d769-2cc4-4e85-906c-08de1b36c587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6sNiWcLt6lwk3QpuQ9WVVRk6cLTbm/RF5Pp2hw70FR7yqMbToz8ZmewqP4H?=
 =?us-ascii?Q?aH0TmuOQBEQDWgxps2ohFSobqrximEUfILDq7SAMztOAGX2AZXrsNSFoEJOe?=
 =?us-ascii?Q?GtJ0sIGtOBINkmF9S9qZUMaC5ZcIVSWPYqRy3bc2Q6Y/BCRCuIw9GpGnvLbZ?=
 =?us-ascii?Q?O6ZwSjt/NGO0Onspec4b0W+c9S53bLtoNFg8j60G9be0AZlq6jDrW7YXnZ9E?=
 =?us-ascii?Q?JzSzHJSar5fXgK9H+XM3zy2tpC190HLGKPw4/LBwczrHmIvzozsMD3jk+wT5?=
 =?us-ascii?Q?V4HEwImnju3iA2Ki4jFTiCJGYLWridGzpk8+DTJ+rsKiSch0ufHXGHEKFbze?=
 =?us-ascii?Q?7Nv/xEuRbqMJbNnyhJnMpe7kZLqlxFn0JHIxlI0Hu+ID64FleUTlDy9uPjIM?=
 =?us-ascii?Q?5DiU0IFt19r8dKi26wmxOvfYBaY4Wm2ZxEC1tO0BTcEWgoaZZeR5sCZWKdVa?=
 =?us-ascii?Q?6rOXVkmvLBJcxQWRdwnhsYrWxp72v4AKCG88YW/8xo5x/c+QEdJtaKghOS7q?=
 =?us-ascii?Q?n9FrCjFAAchqnYcNmA5TDMK+QRXK/OAheooVfrTLm0HFcf9TBBiGEWx9ThO7?=
 =?us-ascii?Q?HS7pugVGlH2CenpFCHgHz75+NUigDIh2C70mKAV+Jv/tu+SV2wH1EYVdku4Y?=
 =?us-ascii?Q?sTjlPL0yHc/NxO2Q7h1E94Wod2XhAnJUALBjXN7Xue9g8oG2HIXeIT0lMF/j?=
 =?us-ascii?Q?J/2hB6BLR96X1N5W/9ZSV05qvzjTUlOyRtu3/GPT9DwSu5mZ5WryXK1Sl0yg?=
 =?us-ascii?Q?MFM8qenFAqquc/8W7rrihle4Ba0L04UNJg2iSx+x1H0LFK8k8zVInMjqu1zr?=
 =?us-ascii?Q?IO4Ax7B4TGEoZXZZFLfREi3rbV5zGtP9jT9U4Uvd4ZLiIw7qfPe/I19iFuVT?=
 =?us-ascii?Q?xqj2JbfQu4nNMPhooa/sDkmaFcV2O9b2W5UkhASNtoD7pxgA5av0Ay7tVtwc?=
 =?us-ascii?Q?T9zoWUchOaQHAPmohsJFHe1eB2EnEpfkkcvnMfzy/F+XlceJrEZwj/Z2aOxN?=
 =?us-ascii?Q?JIIl9g8csCLhaVkYUWuf9BNpka4WlRTqv0o5xKnV9L8GaekIHIa3dYOnZJim?=
 =?us-ascii?Q?X12H2+CuI6gf9sg96xgjUAJ46om+FkqXHAasYXPX8l3vME3IuLohNaw5QD2z?=
 =?us-ascii?Q?3350WxSTY1O5ed4mBLK/0O5RA4TQZhV7KwqoIGSQIVqbfvwvtdJj2LerUX81?=
 =?us-ascii?Q?2eoluLAvMeAJJGJDVLOZXHgBjVrtciY+3c7VZ/ojplHCtICpMWtFt9O2dEpe?=
 =?us-ascii?Q?tX8R0Pq83d1m4EEHzm9mZ9P6kUiS+dQk8zNeeyBBGGCeb9tanzlxM+a3OJkY?=
 =?us-ascii?Q?gdYk5TNt617Az/QNqi0CEtwJ0pR8edY0GAfHdwlLw5zcUmchn97kBTwSTWs6?=
 =?us-ascii?Q?sjq7VeROJ8B10kOXHod+ccADau2YE2CdlkIuf/59Dg1Imv8XUqwhE/hHSeks?=
 =?us-ascii?Q?YzClr3IdEAOAV10PNWtnOu7HpU7ITPPdw6pcJv9sur8q1C0SpJV3vLf2uC3h?=
 =?us-ascii?Q?/f0Pmh0RMXq+HianWEYUA4QgRWDUxR96b280+H2S3S7ZCvE4ofGytrggiTqX?=
 =?us-ascii?Q?v7XCbI901/dkR0xj6GuBRxaZnR7VsIS+iOEQngax?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:11:58.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad2d769-2cc4-4e85-906c-08de1b36c587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

CXL PCIe Port Protocol Error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe Port Protocol Errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL Port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes in v12->v13:
- Added Ben's review-by
---
 drivers/cxl/core/core.h    | 15 ++++++---------
 drivers/cxl/core/ras.c     | 12 ++++++------
 drivers/cxl/core/ras_rch.c |  4 ++--
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c30ab7c25a92..1a419b35fa59 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/pci.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -148,23 +149,19 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
-void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
+bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 #else
 static inline int cxl_ras_init(void)
 {
 	return 0;
 }
-
-static inline void cxl_ras_exit(void)
-{
-}
-
-static inline bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+static inline void cxl_ras_exit(void) { }
+static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	return false;
 }
-static inline void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
 #endif /* CONFIG_CXL_RAS */
 
 /* Restricted CXL Host specific RAS functions */
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b933030b8e1e..72908f3ced77 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -160,7 +160,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
 	u32 status;
@@ -172,7 +172,7 @@ void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
@@ -197,7 +197,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
+bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -224,7 +224,7 @@ bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -246,7 +246,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 		if (cxlds->rcd)
 			cxl_handle_rdport_errors(cxlds);
 
-		cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
@@ -275,7 +275,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(cxlds, cxlds->regs.ras);
+		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 	}
 
 
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index f6de5492a8b7..4d2babe8d206 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -114,7 +114,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(cxlds, dport->regs.ras);
+		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 	else
-		cxl_handle_ras(cxlds, dport->regs.ras);
+		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
-- 
2.34.1


