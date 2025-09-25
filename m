Return-Path: <linux-pci+bounces-37043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF9BA1D30
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AA254E28A6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92B32142E;
	Thu, 25 Sep 2025 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPbG2nW4"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CD322DC3;
	Thu, 25 Sep 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839794; cv=fail; b=Vr00xw4FOL+pYMUjlEGTHHbo36Ib1TrY5tcZqAvDGAu3SisgUnzdPaKdlqPAKaG1UB+lh8SC6sMW5T7o4F2GNc1wxXSG0S8hFu2gsUmS49Ve5SL8M3ztBRt0CUDnj6YMYvJAMswqXuKt9tVqj1Yaih3K8ecIi1L/aeLL2xWjKfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839794; c=relaxed/simple;
	bh=nAFx8bugYXveqq/Zgh6eK2gt/pNPl2iASlyhH3CjJKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMg3yUrfwZwq8+Da6fbJM8v1yqI2MBc/Vwz5ADotVgyHWHaNaExijhb7/8XglgFrUYmUoqzF81jbB5xQjdgq853QcEZnnjwwJuqHHwAmPTg0E1nPv9hUOLtXmz8p/X9GuhpbFmXLgR77pAMc9ncyiiJB6kz190JSGDFFdF+4HVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPbG2nW4; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwCrFWM+BpLYLhQmXX8IQoX0gEUzT2TAkaM+pTLknxqaaN2HjlAnz+rmQDsUoiwkjejZLfCUquRJHcDlQCvB1aL0glwdgNYxdCXLN/HLTx8AMF+o27VA6WwFrUMSrBNYuExmy9pyA970u1kJR/nVOubRxwtjI8nS/fL29saKi2pkKZkKH8NVLOGc/pcq5fplLPhGYBPQKfQ3QgPbQ6J8UBIlnyeN9i1NyCl9qngJw2K0yPhkiRR/MIlxOnxXYc9R5Qde2m0pKaduusvClXSnxsdMfs4QYpHiknV+zzsADeMUxBLT0gelGcdCdFYlcVOh6gVOmiK86IhVenm5UbxXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOuB8ix39XOfbdCsfXqSXgAToFn7ge3m+Ww2PgdYsNU=;
 b=ShpJPW6eh5JIGGkfL0W2F2k8VVI4c5tGt4ChPOb65PdlC8f/LhnHlMeCUyG9PwAklmjrEb/sTLeraocL2rvXxYkIpPuc8yLIpV+o5m0qPwCFiYMsKJPUPnjYp+6SWbRaDCoYb5HOlYCM8QcFR/0jpyaPyKH6VNjDn8oLn644egXH8ph7gq2RdiPayqfALO2b/rH/brUezmPX+Brew/UHPOvsoZAH4njmCAxsn1K4oWikLCzggNl/xslAMEAbor+8/ZNpLWUyBtVctq0xGi8Q4MaHOp0YIF0OlZUWkX3rEkkVv7FIGKQuyrhEuitjam+FDhBi3YBMbBe1LbcTiozq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOuB8ix39XOfbdCsfXqSXgAToFn7ge3m+Ww2PgdYsNU=;
 b=UPbG2nW4qKBqD0juBy48SJNiE30l6n3wGRiNiUPijk1Y8L/Werl1PLF7oV/0J7Kwmdwm0S500++tgNPKhSvDrizgDnZ7oYdOWBg26W6QyfWB22ADnlfA6FkcvDF8A0o9AqRKX1E81J+0cbn83JAP4UQ+XgV6vB/WlRCQXsF/tpw=
Received: from BY3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:254::16)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:36:29 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::2) by BY3PR05CA0011.outlook.office365.com
 (2603:10b6:a03:254::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Thu,
 25 Sep 2025 22:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:36:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:36:26 -0700
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
Subject: [PATCH v12 09/25] PCI/AER: Report CXL or PCIe bus error type in trace logging
Date: Thu, 25 Sep 2025 17:34:24 -0500
Message-ID: <20250925223440.3539069-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: f542e2fd-a051-4700-2fdc-08ddfc83f7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9vh/RipuqeSL+ZASfZCkGpa2tnEY0LvFbJt3+kjuK1KPWWQbJUrXEYa0aJI?=
 =?us-ascii?Q?PLpNTzUDp2Fg5HOGp2Jn9XGWzNkkI3xpBGsSBxXd7PZVaGL/lcuzLbvL9F+P?=
 =?us-ascii?Q?0ZS3y7ZYxN59FTJern68WUanL2ss4Scbr7jc/8uOx/Ec3SqwQQARs/G9oAQY?=
 =?us-ascii?Q?Ab1cZ4R9eamYAGzEbkgkEYdg0YdGSe0FTZOwNM5bz/fvCZxiPrsrJM/Ben4P?=
 =?us-ascii?Q?jDLBg2mc/WxvId8MCvlztcU8W3A44hQTUCvBlQU7iL6N5MiML1gVUAGda0sV?=
 =?us-ascii?Q?4tvnd9EZZ/01okIRJfmABYAfNxI2jB9VAHxSE75dMyK8ENl2DQLAbLv7L8tG?=
 =?us-ascii?Q?S/MHDIvXmpHBrKtyK5OmLQs8Vmfv9JP3EErqzvPdLA4qhGHG7o9nRJYFWuzB?=
 =?us-ascii?Q?PSMkK3FhSncUzduMldsIbnqam+sqLTCvCq2ETJGG0zyDrilgls+IniFiNp+X?=
 =?us-ascii?Q?D4f9k4yor0R00hzp4rKuFvH1yt/EG7tBjQs9U4nXyG/JyJxPsusDx9eJFWnD?=
 =?us-ascii?Q?Mb7naxjbbWZwSGbuxCyHIv1hgy/TZC0aUZIRvuKkvIogdvYLrDzk4r8PWjCz?=
 =?us-ascii?Q?X6tx0DlCAmP3gtpYb65JBZ0vQWi57n8XkgmUEWjVkEclt6pIoRmNDOewlcXy?=
 =?us-ascii?Q?kMLtcnsP4T2HA/+4/XXTq+gRiwNsfxRPXVE2NmYpQ2tzDjXED2V1DSDsSN7w?=
 =?us-ascii?Q?4GtLwE7SV9yXGLNtC8YLxaB8ClvZeW6b/SibhS6BbRRq4VN6Y35mnLg1sHA0?=
 =?us-ascii?Q?H9dHckVeKnoxh664JpEhZFkmHxwWMOCd/3pROIBdaZxJtCkO3uurtyTeCyEB?=
 =?us-ascii?Q?9dupfne0N1VjiDWljdWjfzOT7GYO1Yat+/yi8xxMF3tsrkgcf9nHFBsTy10q?=
 =?us-ascii?Q?QbX1iT2YV1RrZWJ8Mc0QdnL6KVyMyCZhj4PWeN50XkVR4KxBjsHtn+rKhKM+?=
 =?us-ascii?Q?q3OAvYPMj1zf/bJZFqC09g54VD2hqw7UfyIZ0iALlvK+a3BArFISKJS9CbC7?=
 =?us-ascii?Q?hrNdcHF0IyrmhoD4ZNCpzoHIv5rz7FJpr8tZtcxMWGJoK2NN/VeR+B+YJUQS?=
 =?us-ascii?Q?O4e38EgqFnWznhlFQ712R43Sk6Y8y+cCrSasKLtfNKFMzGLfrLlaqaSZyUFg?=
 =?us-ascii?Q?Tai8XPjchNf/U0NcQve3xG+Y/XeRmFMTbzJXEg64N0RguGcfQh08IjxPpfZM?=
 =?us-ascii?Q?I6I68GmYkHd4zfHEcP2yAPev8N2BuMO4FKVFUcXjQqsskmyaY5YsDMlXx9eg?=
 =?us-ascii?Q?FzTM0DNEP513veuzj61XtVkErkylWRIX8qUUVQ/STsLI6QAW2TBzTMpS3oIs?=
 =?us-ascii?Q?cmLSeFAcvjVyWzBs9IL3qLP22s1IEY3oqXuCiLepCNRBzLUnpe+1H5A6+J+9?=
 =?us-ascii?Q?HjK6Bc9Mw0TJ0BuZMz2DdDD2YG4pz7zjzELv0YRGANA2nG+W6ZrS8u39faY7?=
 =?us-ascii?Q?c+7znwsUVMOEYlgz4ZQOFd2oX3lS1D2Zx2pKurgpPdJlsgI1A7LPuOtM/TyN?=
 =?us-ascii?Q?6z53waqWGEJGrp5pJL+wEs+Px0jN4zzpYQjrVfBH/Fcwc7cug1BFNYleQg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:36:28.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f542e2fd-a051-4700-2fdc-08ddfc83f7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

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

Changes in v11->v12:
 - Change aer_err_info::is_cxl to be bool a bitfield. Update structure
 padding. (Lukas)
 - Add kernel-doc for 'struct aer_err_info' (Lukas)

Changes in v10->v11:
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
---
 drivers/pci/pci.h       | 25 ++++++++++++++++++++++++-
 drivers/pci/pcie/aer.c  | 18 ++++++++++++------
 include/ras/ras_event.h |  9 ++++++---
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0c7178d0ef9d..f7631f40e57c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -607,6 +607,23 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
 
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
@@ -621,7 +638,8 @@ struct aer_err_info {
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
-	unsigned int __pad2:2;
+	unsigned int __pad2:1;
+	bool is_cxl:1;                  /* CXL or PCI bus error? */
 	unsigned int tlp_header_valid:1;
 
 	unsigned int status;		/* COR/UNCOR Error Status */
@@ -632,6 +650,11 @@ struct aer_err_info {
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
index 6e5c9efe2920..befa73ace9bb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	int layer, agent, id;
 	const char *level = info->level;
+	const char *bus_type = aer_err_bus(info);
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
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
@@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
@@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
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
@@ -1278,6 +1283,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
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


