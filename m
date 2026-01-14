Return-Path: <linux-pci+bounces-44807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A3DD20C50
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 331EB3007C22
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD82335554;
	Wed, 14 Jan 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qNMuZPqo"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53432FFF8F;
	Wed, 14 Jan 2026 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415053; cv=fail; b=EnbC5a3Jziv4py3kAg/2mNVuigzQDc78kbjazpAXnsM+7uYDxBLZCw2PvqB6pGatpn9fXxdGCzVTjpy+n7lIeT7yrOO4SG7YtZZTDn7qs0OIXGwxs+ZOkLQNwp5SLxXPbG+ydJKUltVwkwS9Oby7pTxzgbD+QSCuiWTz5mcosjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415053; c=relaxed/simple;
	bh=4lOLDHKSO3n1AmFx0v5LCNYof28l9RI6aYhMFonxYhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQg/0sIXlcOgKt/WpNeD1b9OZ5RTphMe8X5Pci3n93R67u5dJ+C3ysNpTLoeeZ225+cZ95uwRp96wQ191JdjmelY2Gs8Z4Q2swIoHz+XjBQrx6AeAQ4ieAqgtJWUa1ptnfDM1LeDbF3wdyVZ4VHUaOoXjQicS9+cEh9dH5bS+hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNMuZPqo; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/AkmGF4SVj2Crxux+kFf5t0satmJsHRlvrRcFJZHKHcuYAF5Its06gD6fND3sc5iFKQ/y55vRvaCYncmCBcfdjLfVu/LS9RezwvoD0zbjcMK2L9hKTJ5DibbxjJ6dESYXbmegxFb9RGfpE6hONTwxQEI85hfFu1DD6wY7QJd2pZUBRu5unttnXWaGyoyWvFGfuVA5/1Mg+CWCM+jwp7QhXqkF5BCRHk+fFd2pr3WKcFsl8cRbtCWF9INNMo4qPKroCQo8s82H5Y+16/0o/uhDRyJ9qAMDXKhEZtauz5q8DnApjZ+wDkrzq7wrjQbTuNKbtv8BBLHWfXm5joOgeU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx4KNGb8N7kxgkSMsHRRFGkiA6Dn9/htDYvfc3BxdXw=;
 b=oyyXQQS3FjKHT3uuGQ2jSiPVHYHkw/MRF8eUS3zPQQR8yb7rwcIh774/5WFe6bnEpdd2gF4yDSiCJDa1qL07ReDqBDV7lcEp46yurLUfTVKSVkG3NuM+wP10s7An4pQfv0UP5CCtVHhVaBra/VuICEGD55JadHJh2cc+lU70LAnVyARyE28ApWUGEVyNfS8F55iNLlIAeYct0bURKzwcrAGekJD9vpJVntrcTvmFIH3Ge3rX0s9WqAlhNHNgANhYSeIKZ4Nl33Okl0TN7M53RDjRL320O2xuRhJQMNZfqf2A1hLjVn7Lu5VSRqN83BvQTzcZyoqgXmJ51j0y78hWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx4KNGb8N7kxgkSMsHRRFGkiA6Dn9/htDYvfc3BxdXw=;
 b=qNMuZPqo6rv0fXJc9Iyzgj+49++1cLbzL+ODKpaiKteEOQFItK82vN0YPyJ7fp41D6afgjKdb5H/9gwbowdS0ZDpFL4NWe9gvL1MRStc6+Xnl6Ce1sIpVT86P4Ebi0wza8+hJ/TbleEmKuGZwY4e4P+BRuAWR9HL0rCcUteTxfA=
Received: from PH8P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::35)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:24:04 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::79) by PH8P223CA0016.outlook.office365.com
 (2603:10b6:510:2db::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:24:04 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:24:01 -0600
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
Subject: [PATCH v14 14/34] PCI/AER: Report CXL or PCIe bus type in AER trace logging
Date: Wed, 14 Jan 2026 12:20:35 -0600
Message-ID: <20260114182055.46029-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4b87a8-13b1-4113-ce23-08de539a18ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z51cwl4xaMOH4eq50ZP/kxzJTrVwLeQVi07/Gq1YRDPYcXXoCNN5gQf1j6xR?=
 =?us-ascii?Q?9SUf6FvloTiqvqxd+uw0Uqs6SWAFNI8kxhZcsrCqC/kG7Ez6CfT7K5mJwwT+?=
 =?us-ascii?Q?gVMqiXNtHSAUqJpSk0E6bDXfQIk+9Nm+q3mlha3ls2NL62d21TesdLvLQaB9?=
 =?us-ascii?Q?Zl6AM+MOJGJn1LTnKMj3z+9gZDaJQvk27anVkE/Z80xtHVR1c2wfEDelr8pQ?=
 =?us-ascii?Q?Ybk7vhGNgwGBiFWykRst8ps+BezTgDs7Dze15Jz5XUVVGzFzLIYTkV6bsd9d?=
 =?us-ascii?Q?l0fEuK7Du0rLdSsYzHyIjx92QiH8uhN3GtxC/MX0awUCyBKHQ7kBd0MzCunC?=
 =?us-ascii?Q?ESzCJ8YmYgt3YrFCL6Pw/3bebpFKdF84oodIzN+b6FTH8+v+6POCJMZFPHuH?=
 =?us-ascii?Q?7Nt4fLcwdEnjqxxGeC77Q6bF2RmfTx5Ffsze0s4uO248TrSKFFfISZO9mQdP?=
 =?us-ascii?Q?kuG3vzcdSkrHXYNuQKNOBbtAMSoNidkjB/bdTEx4seyLmh8Pil4i6vG6ryHD?=
 =?us-ascii?Q?x4zq0B9K96WyRfy9a27oDCIQ1QuDozK6yXfBZfsgnWAYKdxsCsWuaGujqhbS?=
 =?us-ascii?Q?ivHkZvyuInag29mXIVVqraB+VLqKbPQk5CWjngTwy6sUz+yu55eTDcClW0Ec?=
 =?us-ascii?Q?cJNkFpS1L78oVmQdrU6wG2SqAcSpQwR+nZprnUPbXlpucCefrjzRo6F4zkkO?=
 =?us-ascii?Q?Ma5GNvv/dmII84ONIpRc1eTK1bVAbl3nAz97lkYy22aEwDCpoNieMSJRtUKM?=
 =?us-ascii?Q?+SLRNGsXXvwqzIz9/vnXzqtLYHrXLzJTRBtw7QvScNeab4s65zY/wshM3zxA?=
 =?us-ascii?Q?tr493MHnCc7PO7maoL5udswyRl+EgCVtwYJftQIpU7G0tclju6pUTZokbo75?=
 =?us-ascii?Q?wOOh1Warmc5DeK6LADxaZpUGShbWsvkv5begQlEPp9evFFkYcUsZ3FN99On8?=
 =?us-ascii?Q?rd+lEGdynDfVqXAzTgUOYMSAXmnxoT9wx6qchW5zcAt66rtKsQWdntsgN0bP?=
 =?us-ascii?Q?x2P5yMkINgHJfrvTHqI2JAP3pkAmU2YxVeGn8Mf7j3HsMQ0QeteCaNtmUMf4?=
 =?us-ascii?Q?fHPiqSdXLQokZhGs1EBqew2Nw4L7xkGZIcyRx5Q071Y6K7CARBy+gG3s1wPH?=
 =?us-ascii?Q?5xyYrpGoF0PozcUEvVUkjMMl1tNPQNdraTG0qgRC8Wx8ZLCgyCO5cWBbZDW/?=
 =?us-ascii?Q?85L+EuO7TDEK9uf5TUeUWKDzmoxBc4g2dAOrTMa/gn8hbKdyzF1mL/9p2Unr?=
 =?us-ascii?Q?G8TzytZJI6xZyA7cExrpzWnqZZ+Yo+ZvI0CtdXZBRcvcMre9Tvk7imVQ2Bu6?=
 =?us-ascii?Q?cq7/xAr+sqFInyHlLZiif7VHQ55tWVZDdYqnSuZn+sdnEknMrol7jaF557wT?=
 =?us-ascii?Q?Txon002JC3Dy/Y5ysI/5Lhk0r9nKAplS/ji3ITj+cQcGgpHTxJMJPLh7dggQ?=
 =?us-ascii?Q?9/sHD31DKC8NZtjcUWckDjdQDOrG1kKx4XfSKYIdfk/G00UGOdQuTFH75pL7?=
 =?us-ascii?Q?vehLy32swTZvaE7UO/sICroHCV0eF5JTlOfr9BhJyO5cGAAvWVnpGZiZhAph?=
 =?us-ascii?Q?FskKlaXen1lIhswD6+EA69Pr6H5+ycPMoh/W900T5aSBohJr1z8azoCBdTKo?=
 =?us-ascii?Q?QMFCc46sa8tg+IKwQv6g4paJG2Wt9rZ2NcOMf/aETE+jY5jKS+29T7nm2kbh?=
 =?us-ascii?Q?D/gsR8xrZG4fajpsbciXaDHmzWk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:24:04.0369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4b87a8-13b1-4113-ce23-08de539a18ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
for all errors. Update the driver and aer_event tracing to log 'CXL Bus
Type' for CXL device errors.

This requires that AER can identify and distinguish between PCIe errors and
CXL errors.

Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
aer_get_device_error_info() and pci_print_aer().

Update the aer_event trace routine to accept a bus type string parameter.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---

Changes in v13->v14:
- Merged with Dan's commit. Changes are moving bus_type the last
  parameter in function calls (Dan)
- Removed all DCOs because of changes (Terry)
- Update commit message (Bjorn)
- Add Bjorn's ack-by

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
 drivers/pci/pci.h       |  8 +++++++-
 drivers/pci/pcie/aer.c  | 20 +++++++++++++-------
 include/ras/ras_event.h | 12 ++++++++----
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa001..41ec38e82c08 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -738,7 +738,8 @@ struct aer_err_info {
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
-	unsigned int __pad2:2;
+	unsigned int __pad2:1;
+	unsigned int is_cxl:1;
 	unsigned int tlp_header_valid:1;
 
 	unsigned int status;		/* COR/UNCOR Error Status */
@@ -749,6 +750,11 @@ struct aer_err_info {
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
index b1e6ee7468b9..d30a217fae46 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -870,6 +870,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	int layer, agent, id;
 	const char *level = info->level;
+	const char *bus_type = aer_err_bus(info);
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -879,22 +880,22 @@ void aer_print_error(struct aer_err_info *info, int i)
 
 	pci_dev_aer_stats_incr(dev, info);
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp);
+			info->severity, info->tlp_header_valid, &info->tlp, bus_type);
 
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
@@ -928,6 +929,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type;
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
@@ -948,10 +950,13 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	info.status = status;
 	info.mask = mask;
+	info.is_cxl = pcie_is_cxl(dev);
+
+	bus_type = aer_err_bus(&info);
 
 	pci_dev_aer_stats_incr(dev, &info);
-	trace_aer_event(pci_name(dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
+	trace_aer_event(pci_name(dev), (status & ~mask), aer_severity,
+			tlp_header_valid, &aer->header_log, bus_type);
 
 	if (!aer_ratelimit(dev, info.severity))
 		return;
@@ -1301,6 +1306,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 	/* Must reset in this function */
 	info->status = 0;
 	info->tlp_header_valid = 0;
+	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
 	if (!aer)
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index eaecc3c5f772..fdb785fa4613 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -339,9 +339,11 @@ TRACE_EVENT(aer_event,
 		 const u32 status,
 		 const u8 severity,
 		 const u8 tlp_header_valid,
-		 struct pcie_tlp_log *tlp),
+		 struct pcie_tlp_log *tlp,
+		 const char *bus_type),
 
-	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
+
+	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp, bus_type),
 
 	TP_STRUCT__entry(
 		__string(	dev_name,	dev_name	)
@@ -349,10 +351,12 @@ TRACE_EVENT(aer_event,
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
 		__array(	u32, 		tlp_header, PCIE_STD_MAX_TLP_HEADERLOG)
+		__string(	bus_type,	bus_type	)
 	),
 
 	TP_fast_assign(
 		__assign_str(dev_name);
+		__assign_str(bus_type);
 		__entry->status		= status;
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
@@ -364,8 +368,8 @@ TRACE_EVENT(aer_event,
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


