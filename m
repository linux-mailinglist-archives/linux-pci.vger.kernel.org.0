Return-Path: <linux-pci+bounces-21195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90870A31551
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A0D168FE9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D792638BB;
	Tue, 11 Feb 2025 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tM7vbhwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46008263893;
	Tue, 11 Feb 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301948; cv=fail; b=RRmOyk+qKs8Q09IsEUek5ZFSfXHmBV93xVVfjURfxrafYb/ZbmfhIC5HzntWMYMNrLu570igzI5aVXaYIZE9wCjpwXHwjiMZf6ddqSrKZeF8DEgpMx41XsXeJSeY9g5x8NEmDeOy6srJcYum3tPsufsece4jBnWHgArEOSp/5NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301948; c=relaxed/simple;
	bh=iGN2PciLDJC3QtLkp/bPhcK+p2cCJu+4LQkh3JH4O0Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zadmx3tAgvkcGMNVrZe+7xZgA4K/mKEKVev5NjwD0PNSvshrE/358SuWetZiMamtpAklgbYzWGrTlfsjn5PHb9dE2xLEfF6ohWtjRMz1U1ezP4Yk8oWcEb0DxBp9K6gSgWS32lGgyCmD/sdg7t2GqhdJzpzW0zOh91aM114PHxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tM7vbhwq; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O61Z93ZWmkK85RTg9nCRmHIRvlyVHFgDdmDljU9jPI2q9F/4NNZUf+ATnsAWsphbrE2VEI9K5PMgOvkS4uKCECeOdji4D6OFT9miu6voFHs5pDG0C+l8jrrnZG4ToLXGOPhomlZEk8kcUD1nHKAnVsMUk6hDoQ3jX1XQAca+2Gz1OqF59OfKYjjMvnKNYkh70SZ8flJ19WaSGEwIKJ40QpgGdo/H4aap5HjvF1//48CA8SqBT7mSHwCIBL1qKryceK7N06grukun7z4eGgjybbDYSmNlkt7nKEFybFnTphvrMEhKCTd0aE4yR0T+n19b2NhLnYSikjjRDX3TLZbT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvYIiDABzNQ6smzB5WjPLzaMmU1jHms4IeWWFbs5fnU=;
 b=QkYoAoOyW1MznsmbTEuyaHyhqdvqn0x4UocJ00u2VIF5aXPmM0Q6qL0xrkYFr7e8o4ie4MbeQvILWQOJJHO6tsylmPUdtheS2WSfldd1MZIaN0XF+WOEAdvKGQ4jWOc+Et15VjxiL440WfcXAogsCIv+DiL/UgE8lXSlYq07Wn3ff5Tpfp600awwf4hYBWB1DwGVCzYS8q/w0okQrDKe/H7gKaPiTGCkevYTPAHjMy9WdRuRkAHDR3bcCGq6CIgmCk/ghoD22pQFoN1f5fa6t9UBXD4Y4QX1AITV7pE9PNee374JUByx+r1SzX8X+YvkuskIFu+Es3d1cz3sUzADiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvYIiDABzNQ6smzB5WjPLzaMmU1jHms4IeWWFbs5fnU=;
 b=tM7vbhwqGKKxUvevXDxq3j3Io4Ft06FBmWXsG0gbb2nIESb+b/lNbz9GAmV/XzA8BZpyfPKzHsVI7ZmMLMJWwCjTM8QOHfNBhaHuvtw0jY/oziFM6AycJnDiXvR7Mg5+OT8dTfGZXgMOnNWS/JRzNrl5Pv9SPXLi3JoGAWV51SA=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 11 Feb
 2025 19:25:36 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::38) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:25:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:25:34 -0600
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
Subject: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report CXL or PCIe bus error type
Date: Tue, 11 Feb 2025 13:24:31 -0600
Message-ID: <20250211192444.2292833-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 596efb5e-186a-4a50-081c-08dd4ad1dc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TmO1JON+s547jLWeKFmHcQwJcfKYnPSp2NggoW997cMUzsEWCJ79ps2iA5Tr?=
 =?us-ascii?Q?BaoYqZZDGOphPY+0JEWkbW5IYIfkVs7pSoPpt73v9/lBZWNbW5fRq8nNCk1T?=
 =?us-ascii?Q?wVlnHa+JrYt6uPXV4TJWkP+ZpHxeq651kvHu9YwwfEaTe+0Dhh6h8olgtSzo?=
 =?us-ascii?Q?C1SkdkoCAKsoSHbs9PLPvKIsoyW34sTvma1LRWbQkyxsaYgHxxln+t1g+Fkz?=
 =?us-ascii?Q?bUD4pEXYKj5JBT2oBDxS29kLShRAIyapvf/aon8yD2YgJbaSUaUXcg9ezvI1?=
 =?us-ascii?Q?xGVgPUfJwNrQdYpps6JSVrPX0MJ5u1TRiZ9pmX+hDN6lB32eIH/CAW3GfRPs?=
 =?us-ascii?Q?447gBZLmK8FsPZX9oMntxXWxwAGa0m2zs/Uly6WlqQlbJW8SjnrSPruJCvMf?=
 =?us-ascii?Q?GS5qzF33K0jS9inbChHWCTXx7W0VOneZ3++pdx/nwl2TEmm8nWkqFyGmLCNO?=
 =?us-ascii?Q?lj7OprWech3BcZFKi2I60KycuOrZGf7eGgd8QaccRTKVKgaPru9T+uqOSSKU?=
 =?us-ascii?Q?pmvS5t0sOTOtMCr52UwrWiLlkOWe81+hC6fMsg40DRE0//3uk/UdgGUVLqwT?=
 =?us-ascii?Q?baDLOkYg0/PeiTMOCavWtRlDHt8NBJpuRksj2IXAnt9RkK4m1iZuHTo7oG5O?=
 =?us-ascii?Q?rq3i9FGXcG/17Re/u+1ATIKZ6nnKdCu2iyvDcYt1G1Gl2gHdhBcyUBXN+7tO?=
 =?us-ascii?Q?fYqg0dRHC9tKLt/z0AXPy3gaqpCd10YdBmk3Cc35WYeczGhVp6ZzJmJiI6hG?=
 =?us-ascii?Q?WFBNO5j3gKjnqUB9I/fijsE7ObdUAEjqloK+8TsoDM8xPQjTvYgTxQTE5X94?=
 =?us-ascii?Q?9VHx/5jzdh87C35RKGuwVilUKOPQ6Sp9e7qCWHiqKEVHXgCVVf6NQyOUeb35?=
 =?us-ascii?Q?lS+zUBLUiHfqRYIVuSzUyLefVHeR98NyYpCTBTmys6h60uCCjZBZf7EhZaLa?=
 =?us-ascii?Q?tYueoxIkuMoT61x1JppgYhEKbLPvlf6Alt4TwFWCs8AvvocvU57i0XR1ZqXf?=
 =?us-ascii?Q?67lfhPCqe95dxetLLzmoHVVNl8HgG+/SJaXX5QLUmVr453oc1NMtykB4i/3h?=
 =?us-ascii?Q?JtQfJx3GXtVY9lplXt/BOMbtckoo7a2rgMvT74AAKbCdMEQR1pz0FbsN3aSk?=
 =?us-ascii?Q?s1c9OjCogx6lMget2q6aHK1NHSA3GoQNZZ1VfZ9cl+HZ0XeweieFBrUNmEST?=
 =?us-ascii?Q?QKwbnseS/Rpd1uS9r0A+pPfCQKqpojgkWmvjxpG3WF+1BsaJi6bN5ZB0WX8B?=
 =?us-ascii?Q?yk7uzuMD9/z56FSfrQlTU4qPxKiiBdgFGHCMnPDVXw+kEl11QjF/LzevedYY?=
 =?us-ascii?Q?38w0Lhis14k/aBSpCatoKTuMXJ7szuBHehSTj+Vn4AXew20BTdkY24GKpMiM?=
 =?us-ascii?Q?tUWveisCJsgaAVkh6bpGHtA4vwMw/BYLPlSMiYoFGfsWr1Q7qOEyVFaApysP?=
 =?us-ascii?Q?M7rSi96zYfIYvuoCFQH+0IbW3T7or9J/vAvqtqK+4CkirPiRjOYWcqwrJPhC?=
 =?us-ascii?Q?1A8wHF8n+/Vzdfz9vwHtBHSsZl1YkdBcTXym?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:25:35.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596efb5e-186a-4a50-081c-08dd4ad1dc27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306

The AER driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors.

Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL
device errors.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/pcie/aer.c  | 14 ++++++++------
 include/ras/ras_event.h |  9 ++++++---
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6e8de77d0fc4..f99a1c6fb274 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -694,13 +694,14 @@ static void __aer_print_error(struct pci_dev *dev,
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity]);
+		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
@@ -709,8 +710,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
-	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
-		   aer_error_severity_string[info->severity],
+	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
+		   bus_type, aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
@@ -725,7 +726,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -759,6 +760,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info;
@@ -793,7 +795,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
+	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
 EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..1bf8e7050ba8 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
 
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
@@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
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


