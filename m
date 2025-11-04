Return-Path: <linux-pci+bounces-40165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92807C2E88D
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2A8D4F5255
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7241DA55;
	Tue,  4 Nov 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y3tyMTnH"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B931494CC;
	Tue,  4 Nov 2025 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215116; cv=fail; b=V9Q+iUm9kxkhcqDqCNMXFowoPIkLKftSukaRRTt2msBQD1io1RsTfpQ7MF4W1xJR+PPyOd7zGH5QtvptrMTCRsTgEcXPqC2OjlwYFf6BtH3NHJtiMFnxM81ypNnO3OeXdqd10aIaFImUGodTdTd6s5UzrN7y3QgUN2jxsi+Z/7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215116; c=relaxed/simple;
	bh=LDaQ05vWSrxHjXMoEmyYaBP/ZSEvMr5EAqbHY+OAY5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0ua1/Hxc61GFRO2k4Goyuk1OFUuU+hhE0xs8VmvVnY92x4dvBMGiTrcTAHgbRoNwMDaVsrVKWaVCvm7rl1hvTym0jklUzveEiwUcSLJDLNAjyOvt0LKtj5wXRhCYu9dMClLTvZ0HZIQlQ2eQKZVk563eFBHzJTUxlZ6OVd2PKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y3tyMTnH; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eytEGdsmduPqrZHSbP9xnnTPxhEJI/oG1r7RT/dFfwyUvgjlU9d71iWGryL0TxBRBLbiVwr+EMJiRLn4eCTs7Mxgg/CkuXaoNn44DYdMaUnNsFaZP6emhg8E22o4r+n+P2oJb5rCm3+83fQfAGqrAQZ8RVxO7g94oarPPR2191Urpye4Ywa3mIh5ELlZXuDeliYKqRJtkamIqMWzasxHx36AU8NmRluVrKbiN27y4yP9hn9tf/S+isdgFRm6rVCVfTikQ/mBkDLbPO8q1BtybvnRJXy7NCpYsMOPXuxS0LZSnQBYwK0ZUFzPn9Q4FbDHSXPnwA2zsN57sNkzpPoVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwkFNx7/ZlWByHIut9/gjEHKNHdTxSHDE+sJyi3Sc6w=;
 b=QkkV7fk/ge3skDBBD/Y3JPTnieNK8ZBzZp/5igr4eFgamJg4uQUNAFR69MIiEHkO8AGCO+8vVeujaR3/IzhfsO9wD/V2XsMTNy8TtQtFQIyVfM8bEDWlg0yxOG+xtJRfyXqa5Qgdr8nvDgstCYG6sEtqTe3bhoZJW3sx6XXCOREfnxL4Giah1CJj/izOWr0vdbtZ/J0EdXq2jt59gm4aDLCqgZn0dQ1ufPSezMCna+dPQPmCFL+kttaceN2FHppgzyAdxYUgzxihE5g8u/jrfiCiaK6ESCLp0iWZJ0FBGmLiTIsmMmPnoijmFsxCft9e53D63meVYQGWz4FHU4x/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwkFNx7/ZlWByHIut9/gjEHKNHdTxSHDE+sJyi3Sc6w=;
 b=y3tyMTnHRA54/3n/6uLqUCbPXdeIAM1xdmb0XBQsyFzwERxPLBXikHtehe4Kx0z8LP0fWFzN9O/c/wfgYq9SsnHTZnVcRzrI/F3o2zHF7TjYmPFnWxuH53wA4P2XMtEM0sI70S/bIzPAFihgUdp5rKo8SPfNfWd+VopBAJCUAw4=
Received: from CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Tue, 4 Nov 2025 00:11:48 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::c8) by CH2PR12CA0024.outlook.office365.com
 (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:11:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:11:46 -0800
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
Subject: [PATCH v13 09/25] PCI/AER: Report CXL or PCIe bus error type in trace logging
Date: Mon, 3 Nov 2025 18:09:45 -0600
Message-ID: <20251104001001.3833651-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e47c42-0fe3-48fb-4270-08de1b36beef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ncG3vY7a51IgNqzdiFecZLiUE7mlfLQshm/5Gr+ejRtY0brpXesmQZbXHf+?=
 =?us-ascii?Q?wSAllTC5G5bmoc1CJxRJWcZGdqwuz2A1Ykd5Z1FYOZOhdyqXJ9hBCasGnnLK?=
 =?us-ascii?Q?Ai262BgMiXECGM+JfroXDFXepwjAYV05VuaOXY6vryiM0TveQGHjCFLrXrTm?=
 =?us-ascii?Q?xt9S7scY2wRTJDCX9EaB5zrYC/VkvuGdL3kEr20A2/pjaQe6I88tRgH1QThx?=
 =?us-ascii?Q?5Y7cVC6w4ZOQOEQ5pxJzof4oQA0KPLbuEfXaHvElEKAl/R17DejAxKE3mc4b?=
 =?us-ascii?Q?jJ9kpv6VwkMse4fopqsezNRWqxDod7KPZrekLKExKHyMoTQ452/0XaBmBVtP?=
 =?us-ascii?Q?nj+5ySf5jVMpDe/B9QAAqtpgqXc8Ra8dRkmsxQyQjUjrJ6maaVf24glqwdR4?=
 =?us-ascii?Q?qmbmp5i7lrfp5W32elCB2jVtWErsSrqJ2E5MIOA/1tTr83SS1OHOeZgElknd?=
 =?us-ascii?Q?oS25wL5iDrP3AWbjy7CL7kbDilYijyslGGtLLe2bwzqlrft7ioPsngOsx19L?=
 =?us-ascii?Q?1XxWcPd/2TZxUkLT2YN7HhKCUHFlAJTd9gxzQ8+DlMxS4gDdRS7uBznC1YYH?=
 =?us-ascii?Q?L6Z/gy/DQbTEUW+6ULWfGas5vA3nYkoLeAv3eSsjZsGNXtD0hzcz85vc/LI0?=
 =?us-ascii?Q?EOz/rJLtzq24zqx/0xyuQ6gs1DOqYKSBwP3mUte1FdyIQmhpniGdDG7CFy+8?=
 =?us-ascii?Q?onQtPvn9U1GCTzjN/wECBYyz7s5HZlSP0w4SnUQc5qsRyfNs+oMWJIuDkljb?=
 =?us-ascii?Q?y08oosl34RSwboK6Iwe+NzXK59DWuUvkJ+VEl0dsQFmZCe+NqbxP/6xRarDU?=
 =?us-ascii?Q?zst2mZc9j1Yl/BTksJprGAtegIkGQUa2a+/37TfnCjG3iiirvX23hBBGVlc2?=
 =?us-ascii?Q?T/1MreVBB3m+qPFPic41IT/Z5FNThRwouVrzejTurgVAedMsQSrXrjX+w/8Y?=
 =?us-ascii?Q?mzQ5TFw/8RIhPJ6UHBA2bJHPd2v6HXbfhs3MbaWnKViDIZNC+S25XRCZHQsN?=
 =?us-ascii?Q?aIllDvj0dpzraeXPPRI3lAO4cvfW6DDXv3MaW4UzXMAhWKIBvEp8eq5NZ3HG?=
 =?us-ascii?Q?/XqvWOG9q+u2XPPVKgYX+whxJdceQzuZOW/D9toxDOyJ522BCS8QlGkTE9AO?=
 =?us-ascii?Q?QBwuP/fahsHPVzjtVcP0BJLETfh9Bk2R+issFsQo+zzvCgef8kMJ43Zd6edE?=
 =?us-ascii?Q?/hZf8ckFH6GTV7/VnqoyK5kwAOQZ7FX7jQblRyeDqv9w012hd8Xy0ekZ3XHm?=
 =?us-ascii?Q?I1jqSp1i4AenDR3VIVv12WJQD9v8G20oGsznoDFNsgiq+ZkKlDYWQbKqG19E?=
 =?us-ascii?Q?OD+pnKBru/hA+Ku01toztmyaGGzyTg4HdPUZZi9X6WhobQcutA+3yaoVmPtc?=
 =?us-ascii?Q?scaOiD2dXv9dVy2cw0NytK91bkzU93+VHMIpdm25kPe5nZ4YTswbfQaui/ri?=
 =?us-ascii?Q?p0JI9IRbqhwj+7o6XBmzbwCIxxT4r9Erw4hcHk/dQUD5ho0w8SmibyXgZGud?=
 =?us-ascii?Q?kWe+LL7ZCGpqvMB/Zbh8Qu+hVdBc3yqEDXhWR3yy7XfbwS7HkC1sCYfI42c6?=
 =?us-ascii?Q?yHbt6Sk/nJm9Y0aZllrQWebKDxLNFu9bOTfMSb+e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:11:47.8185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e47c42-0fe3-48fb-4270-08de1b36beef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors. Update the driver and aer_event tracing to log 'CXL Bus
Type' for CXL device errors.

This requires the AER can identify and distinguish between PCIe errors and
CXL errors.

Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
aer_get_device_error_info() and pci_print_aer().

Update the aer_event trace routine to accept a bus type string parameter.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v12->v13:
- Remove duplicated aer_err_info inline comments. Is already in the
  kernel-doc header (Ben)

Changes in v11->v12:
 - Change aer_err_info::is_cxl to be bool a bitfield. Update structure
 padding. (Lukas)
 - Add kernel-doc for 'struct aer_err_info' (Lukas)

Changes in v10->v11:
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
---
 drivers/pci/pci.h       | 37 ++++++++++++++++++++++++++++++-------
 drivers/pci/pcie/aer.c  | 18 ++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d23430e3eea0..446251892bb7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -701,31 +701,54 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
 
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
 
+/**
+ * struct aer_err_info - AER Error Information
+ * @dev: Devices reporting error
+ * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
+ * @error_devnum: Number of devices reporting an error
+ * @level: printk level to use in logging
+ * @id: Value from register PCI_ERR_ROOT_ERR_SRC
+ * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
+ * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
+ * @multi_error_valid: If multiple errors are reported
+ * @first_error: First reported error
+ * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
+ * @tlp_header_valid: Indicates if TLP field contains error information
+ * @status: COR/UNCOR error status
+ * @mask: COR/UNCOR mask
+ * @tlp: Transaction packet information
+ */
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
-	const char *level;		/* printk level */
+	const char *level;
 
 	unsigned int id:16;
 
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
+	unsigned int severity:2;
+	unsigned int root_ratelimit_print:1;
 	unsigned int __pad1:4;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
-	unsigned int __pad2:2;
+	unsigned int __pad2:1;
+	bool is_cxl:1;
 	unsigned int tlp_header_valid:1;
 
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct pcie_tlp_log tlp;	/* TLP Header */
+	unsigned int status;
+	unsigned int mask;
+	struct pcie_tlp_log tlp;
 };
 
 int aer_get_device_error_info(struct aer_err_info *info, int i);
 void aer_print_error(struct aer_err_info *info, int i);
 
+static inline const char *aer_err_bus(struct aer_err_info *info)
+{
+	return info->is_cxl ? "CXL" : "PCIe";
+}
+
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
 		      struct pcie_tlp_log *log);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f5f22216bb41..39e99f438563 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -868,6 +868,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	int layer, agent, id;
 	const char *level = info->level;
+	const char *bus_type = aer_err_bus(info);
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -876,23 +877,23 @@ void aer_print_error(struct aer_err_info *info, int i)
 	id = pci_dev_id(dev);
 
 	pci_dev_aer_stats_incr(dev, info);
-	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
+	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 
 	if (!info->ratelimit_print[i])
 		return;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -926,6 +927,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
@@ -946,9 +948,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_dev_aer_stats_incr(dev, &info);
-	trace_aer_event(pci_name(dev), (status & ~mask),
+	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 
 	if (!aer_ratelimit(dev, info.severity))
@@ -1309,6 +1314,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
+	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
 	if (!aer)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index c8cd0f00c845..85dbafec6ad1 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -298,15 +298,17 @@ TRACE_EVENT(non_standard_event,
 
 TRACE_EVENT(aer_event,
 	TP_PROTO(const char *dev_name,
+		 const char *bus_type,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
 		 struct pcie_tlp_log *tlp),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
+		__string(	bus_type,	bus_type	)
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
@@ -315,6 +317,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -326,8 +329,8 @@ TRACE_EVENT(aer_event,
 		}
 	),
 
-	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
-		__get_str(dev_name),
+	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
+		__get_str(dev_name), __get_str(bus_type),
 		__entry->severity == AER_CORRECTABLE ? "Corrected" :
 			__entry->severity == AER_FATAL ?
 			"Fatal" : "Uncorrected, non-fatal",
-- 
2.34.1


