Return-Path: <linux-pci+bounces-37051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49115BA1D6F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DD6741837
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062FF323402;
	Thu, 25 Sep 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16HzpZOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7F3233F8;
	Thu, 25 Sep 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839884; cv=fail; b=PdOpk0y031NyNQDiQUMEliLiAGy0heMhjUfK/HMMWs57+/znr+1Erp1xDONtvbqqsv2vd0ekYtLQxa0aOGtCyiBxUFexc7Gec1tB8l/67Awsg3oxy6wxq1ODFphgZtytbuVJx2BFv4GOA0e/voKSyhLEC3AWnwh1Dx6wYmArIME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839884; c=relaxed/simple;
	bh=42W3az/IipoDFZeddz7g/vfvSsjOAruO9cyxK2q5UPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN7tdRoZXfBRZ51MFMoh6iYOx3pb8LgQNynTYjnp3DFQ1XtIbuh0rxURyN5A9+qrs8SV3563Lso7/jF4MferZyzQJKfnoixrxldldK6BedQrkNwQ3gsqHpS8bmTR1BtPFU4eNEGEntYQYSCZ0r1JcCZiUfzcgGdQTxylztCJ7oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16HzpZOk; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7dq5GK8bn0qcwyvQCJht/3wivtlsfggyI2MDFpPDli79spM6z9X5P02mQD3DKdk1tinFbOHeRBzmtl7PLPQTwKEckHbdXcs6Xo38SWmMR1+n6WMZiPRDU0htl35eQIDBJ0EVn1KskUxqFV6ZwhPCFUVoDcAbFLyMNswQs1iq/3kCpSe/gvmx+Z4Xa0hnfOTmhiAbxleN8EkoA6TtxXGbIis6DuhCG2jmlP78g0yoxR1SYrPej2aDYxNh+nUSk8IKVVMOn4+C9zz8AJ9fYlyQ40ACzQ0Q6UkjXfQILC49oeqRq8E0Nm3R9X65Wwh8CGlKt4joJY9BTqO/JjMtp+vMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3fy0ards3g96w0aKCF+/jKIPMyrOJhNLT6wWNkHkbU=;
 b=n5rTffiEOgXKsmQjiqPvGJTnKnwuuhDyujEgQaEjXi3w0t2i6QFABy1I4L+nQ9hjK42bVFhdYZKgYSd9aDG1aB1FMcglUMLbfDYDheHSVF2jTL4//WEoug4Gt3eofWYLKjJz6Dt4LVJlwaRaQP0h6D3eDV7bMeq0Qe+/ZoVJtoQqvtpfVWx5dVsZOkd6bPpSOC0IoXArr8zFhZsHWqERz1vLhN8ZtC0QOOthebn4o2TsC0cYqOiQsAbdT2dpfnoYIlhbgnZEvkrQgPoiUKHdXu0Io4j+W1a8d4eTXApCDOmO/46Tr0zeBvKGj2whvXNdeXs7s+qg14rGBelJKDNfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3fy0ards3g96w0aKCF+/jKIPMyrOJhNLT6wWNkHkbU=;
 b=16HzpZOk5HhZZPoXPOdwBjmyoaEYBPWKclrUkneb+NO8gTFKoOCyxkUf7dJFwH1+CvAjaSCwV+HhiDXtNmuZb1/ENfldkz8CFvCB13tfOVtc2MJyQ+mP3xyV3f35pcpLJOXO5i1xVY8/IiC5jQy0Q//k9CvOPg5NF8m37sTbWDc=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 22:37:56 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::8d) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:37:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:37:54 -0700
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
Subject: [PATCH v12 17/25] cxl/pci: Introduce CXL Endpoint protocol error handlers
Date: Thu, 25 Sep 2025 17:34:32 -0500
Message-ID: <20250925223440.3539069-18-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: bd67f50a-e882-40e0-997f-08ddfc842be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ezdtlVYnVzuLVQn2xotxdtQCdwZOCT7ys5/YomqKW7P0Gkz44QvZNQi+k/US?=
 =?us-ascii?Q?DfLpqbiZBfqVnr0YF1H0+VYaBi1xR4d6sn5doFV5BT2qryF5EPIX6zlMBZDR?=
 =?us-ascii?Q?hxe3MDYwc43ZIqNrqtc/zzbwZaS7icRZBNsz2Tg229vjG63OKdaW7aLZZxlE?=
 =?us-ascii?Q?JzGcgxnQASEyiubNwaLNgZFdrTCsk0jXGesBurW50RYXpEFWjj+PSiIwiCNQ?=
 =?us-ascii?Q?6o67R2r8zUVkFX8MzbTIlgpt3aM+8rx3V7iDdCQju89mRowUm2A1ewxyP3dr?=
 =?us-ascii?Q?XkJAOOdUJpiq2Ol3lz/E8aIe3KgccOMRNW2Mxxd10QKpaytNvRksv2UFAbS1?=
 =?us-ascii?Q?s8/aJA8u1RUX6xWRbdyXjqi3qqVfS8k/Qo8Pu8yYq8k3P57lL5gXINZPriqL?=
 =?us-ascii?Q?oceXWy2ez9OOc1H0fDdovKRkmDifalIhkzVXY2g68a7OGR20zywURMAklQCh?=
 =?us-ascii?Q?8FpD39/YWCB9VS642Ra6HVL8XrqAakk6jJuRcB/Um//9M3qEz+HDNgPf9U4W?=
 =?us-ascii?Q?3FF1HOmfMijBPxvInXWF5MN+g737DfYJEprZ8qtOiuIytir2NKORKYmJV0Fm?=
 =?us-ascii?Q?jJlWukXReUUj/uooqLY2P2Fgs78kvh2/TkYRI6QpNLh36RX/xeekYDy1pNzL?=
 =?us-ascii?Q?ETVsetQ1G+eZfvPhK38Riqbl+QxuuJoyTdZGhDBuK8RPlqWUwVTOgKNEiR92?=
 =?us-ascii?Q?vBZIXcA0RGselwEUmT5bvrx3IYAjrPs1r7yWZOajCSJHVHB0x6BqHquFsOXX?=
 =?us-ascii?Q?KArGIkaw+Za684pn/VpPuvlQEgdsF4Dhg16sJ0YLbYh3QLBxCwqvYfpjRxGh?=
 =?us-ascii?Q?5McA8FE2OYw8pq23EyzmcDkELw/S8aA7gWUgyJ0d3DUvnBktJrI7jwDRmJ3R?=
 =?us-ascii?Q?JRnaoIK1zZ9FevwCXXYYlDBYPc+vY8MsW/3izu4MitfGzuAsR0FFrRrrLmdK?=
 =?us-ascii?Q?K+eEQVUM9qUodDnkrltgIRUfCv0cR9w2cibt0t5sRYTIqoGqSDfX3GB6bgIR?=
 =?us-ascii?Q?sZu7x1bPZxPhxxLr+ajsO0WiOpAKIvc7sS3p/sa7LbUEeTOVPoR3R1YOteC9?=
 =?us-ascii?Q?rFS7iFJeRTYGDFPS/ofOPFctl5VlhLFn3PoDrFv8lyEBCLg/xIaGE7MsFKjO?=
 =?us-ascii?Q?2B3RhqsAnGw6VTjJjl7n9E7XWpNyh+saV28fuc1axtyzQmd6BR/PTT7PZM3y?=
 =?us-ascii?Q?smIQhtY/vkhun3Bk9kL6hByeUmsrSSSiV3FnWGFxs1wXsWFpIzIRqDN+g8Eg?=
 =?us-ascii?Q?+NMw0GTNKWqV+lbv4JGRIa03tcgsUDzoCCwzoSLmQlnzOCiXOxBH7W5+Z1WN?=
 =?us-ascii?Q?Jp1oOXhvArFbnkFIFtk4lNTlX1/MJQk9dD/yMXtLSLMzg9jiNpzvibAo6Uke?=
 =?us-ascii?Q?VU2knyBpjE4sVCWvNJTcXgiD3Eyh7SAj74d9w062cAFZhUpXbcs4Rr+oXH8E?=
 =?us-ascii?Q?lumAJdL6lwa0XmH4TO9Q9HpGn3mMCkf+cTJHWXmYwbB6gIyTE7ple+z5jett?=
 =?us-ascii?Q?bT9AF2b6FqzC1QcWNfw8iyLzGnNiiCZTXEIYKortp0znz8HW2Mrr/UYSaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:37:55.7158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd67f50a-e882-40e0-997f-08ddfc842be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

CXL Endpoint protocol errors are currently handled using PCI error
handlers. The CXL Endpoint requires CXL specific handling in the case of
uncorrectable error (UCE) handling not provided by the PCI handlers.

Add CXL specific handlers for CXL Endpoints. Rename the existing
cxl_error_handlers to be pci_error_handlers to more correctly indicate
the error type and follow naming consistency.

The PCI handlers will be called if the CXL device is not trained for
alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
CXL UCE handlers.

The existing EP UCE handler includes checks for various results. These are
no longer needed because CXL UCE recovery will not be attempted. Implement
cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
CXL UCE handler is called by cxl_do_recovery() that acts on the return
value. In the case of the PCI handler path, call panic() if the result is
PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v11->v12:
- None

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/cxl/core/core.h |  17 +++++++
 drivers/cxl/core/ras.c  | 110 +++++++++++++++++++---------------------
 drivers/cxl/cxlpci.h    |  15 ------
 drivers/cxl/pci.c       |   9 ++--
 4 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8c51a2631716..74c64d458f12 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <linux/pci.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -150,6 +151,11 @@ void cxl_ras_exit(void);
 void cxl_switch_port_init_ras(struct cxl_port *port);
 void cxl_endpoint_port_init_ras(struct cxl_port *ep);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error);
+void pci_cor_error_detected(struct pci_dev *pdev);
+void cxl_cor_error_detected(struct device *dev);
+pci_ers_result_t cxl_error_detected(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -163,6 +169,17 @@ static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
 static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
+static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+						  pci_channel_state_t error)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
+static inline void cxl_cor_error_detected(struct device *dev) { }
+static inline pci_ers_result_t cxl_error_detected(struct device *dev)
+{
+	return PCI_ERS_RESULT_NONE;
+}
 #endif // CONFIG_CXL_RAS
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 14a434bd68f0..39472d82d586 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -129,7 +129,7 @@ void cxl_ras_exit(void)
 }
 
 static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
-static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 
 #ifdef CONFIG_CXL_RCH_RAS
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
@@ -371,7 +371,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -380,13 +380,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
 
 	if (!ras_base) {
 		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -403,76 +403,72 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
 	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_cor_error_detected(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct device *dev = &cxlds->cxlmd->dev;
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
+	guard(device)(cxlmd_dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
+	if (!cxlmd_dev->driver) {
+		dev_warn(&pdev->dev, "%s: memdev disabled, abort error handling", dev_name(dev));
+		return;
 	}
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+void pci_cor_error_detected(struct pci_dev *pdev)
 {
+	cxl_cor_error_detected(&pdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
+
+pci_ers_result_t cxl_error_detected(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	guard(device)(cxlmd_dev);
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
-	}
-
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
+	if (!dev->driver) {
 		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
+			 "%s: memdev disabled, abort error handling\n",
 			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
-	return PCI_ERS_RESULT_NEED_RESET;
+
+	if (cxlds->rcd)
+		cxl_handle_rdport_errors(cxlds);
+
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
+				    pci_channel_state_t error)
+{
+	pci_ers_result_t rc;
+
+	rc = cxl_error_detected(&pdev->dev);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 3882a089ae77..189cd8fabc2c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -77,19 +77,4 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
-
-#ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
-#else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
-{
-	return PCI_ERS_RESULT_NONE;
-}
-#endif
-
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd95be1f3d5c..71fb8709081e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -16,6 +16,7 @@
 #include "cxlpci.h"
 #include "cxl.h"
 #include "pmu.h"
+#include "core/core.h"
 
 /**
  * DOC: cxl pci
@@ -1112,11 +1113,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected	= pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1124,7 +1125,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1


