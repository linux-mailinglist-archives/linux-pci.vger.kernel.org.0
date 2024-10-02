Return-Path: <linux-pci+bounces-13721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7AD98E15C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE781C235C7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB81D1514;
	Wed,  2 Oct 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZJDRneSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D971C36;
	Wed,  2 Oct 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888446; cv=fail; b=ZekjCt3kxSw0rJK18h8mqfxIeLVlubUS0IXp/UKpdB/ypzeJFOwJDRDAbLyifUvs3TptylsaNGA/panikwrPDf1DMzTM3ep9fgprI7DXaB1j08ix8I22hj/KXkgMrM2BCYRj9oTuJR+RDvU2MsPBPbvXMfu9eqh/LSvT2q7TswQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888446; c=relaxed/simple;
	bh=aCQBjdTIz8KLRsgZ2hOl+QnuZ7c4b4kJX0w+Kh02nRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5jFuU5CKD1oS/1tR/B/eZ5e1HhElYUsRYaMkmzdJSCFg/D4g/WpZMAVUqRhYSBBEgtKsDxCsg3qN2vJFZFj5gtzCscOD4QUyL/ZSlrOgDugT+H5z0llI6ukMYg7jEYLa61f3KbfSdi9gYUOAWFsIYPtZ1Gtd21x0K+ahW8xzAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZJDRneSN; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYtgXd52KoIq0uWIwn040AdQYgkQKigHVq1lL94/x7wHhNqbVHBLBuMZT8TzDnJAJ6fmZ4BuYhc1152VKRYa9NrfJ5373zOKDBulYqjtDZBickT03+fLxhdGsRzFMFXfcOhhoiKfOXT4/FGH8Be1wmQjwLAfoLMLcKYXvacxn6Z2Q+ybJiqc6UTqOPmR9YdsM1NqIduV2bSJclaDFB5KxelFOCZW3sdAN/bUbImw4DNtBNE9DtzLyQJ4lzyjoa5bBSMypf6+VPm+3cZcySsUhuCjI57om8zISEpDsFYfkDdqoCyDhQWp9U4Pb/XfAZHIftdaA4/qIyO0j4OcvP3Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i8TJCIt+LXWvUebhfguj+j5UDkelQGwSXKmGqvV7Bg=;
 b=wOwp9eJcENLwvbRg35rFl1qjTTgZCWpahifya8pXcUDW78AfZn9M3zVoXkkzjH6NwnOr5S9B4iM+4Qmd5GhO+8f/z2+g6WSpOsSW6BcYBML2oz2L4WU0Z4sz7wFBOFEpqQLaxBMB6bUI9HGGybJw2nM5J/2p4WQYm7RacLrUrgzJhFtKVzhLx9Qj12SO+pHqAojHH6mMItuYBGGirzmDEyE9olmxN8G5VfCbb0AwY57N4ZzHJWtjUOf/SWh6TQPUH1Hkob0luHuVtVeUBPfJkrfqQIMALgkubct5bg+7sTvmZcEj0IKY+/VdmHh9KCxTh8zrPmL+JuQ085kj1JBpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i8TJCIt+LXWvUebhfguj+j5UDkelQGwSXKmGqvV7Bg=;
 b=ZJDRneSNxgZp1fs+RpahGoNRUJJh3nm3bmB7FZBIOHJtqoWyR1QRNBEoyg1Mex/kX5v0Rr9gFwqqm0SlzCmBaLqagsQmbyyYaRJyk17Jz1GIOHlMGWLPMZ0/Ut1kml+Q8CPnF0H1ZA9lGE2TCzpaCTJ/FgbHSZANv5+UkYxE+OA=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 17:00:37 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d0) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Wed, 2 Oct 2024 17:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:00:36 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 12:00:34 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V7 3/5] PCI/TPH: Add TPH documentation
Date: Wed, 2 Oct 2024 11:59:52 -0500
Message-ID: <20241002165954.128085-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002165954.128085-1-wei.huang2@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: f6826e96-375e-450a-4a25-08dce303bcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TrYrJ2Waw1B3CXzd6d2J40p0DAJKkoTMOQq3RtF8tqlYZUjtRCYSwwyrrxY0?=
 =?us-ascii?Q?gXel6DkWN8UQsoMHGqEfJ/tG5/peeGxvAerDacYVmQLhPOelyxSPekPN/co1?=
 =?us-ascii?Q?WVVWfy04N0aBMMfkwTPtt76ciIJxYGnORaAVqFQvwLYy9WmPTodrV6KDXXoI?=
 =?us-ascii?Q?wGfCFxLtGlYyvY2AOROJ2eHd7bEgBzcS6vh/+ivyoZf8DgRSNyBVDTI+NF10?=
 =?us-ascii?Q?rGeswJR4ckXLI0ceM5txPghzZTE+xQig+PxKJSlOIeIVHLzKRhQmPYtQGD/g?=
 =?us-ascii?Q?ULkb/PAjAo8pTM7rg94sMXtzgrcpKi6uOoZPLMHQu50GV5C2ZpmcTRNewndg?=
 =?us-ascii?Q?QkLqeW+byr7smE61CRFJ/3b/nRNxCI7VDW8jBhcPlDc06wfDIb+B1xsiwUUX?=
 =?us-ascii?Q?A0zfXReX2so/31kDNEue1m6fqP7gtFFW+swT3fuvXLL616mS6t2M4q0whqln?=
 =?us-ascii?Q?zlMW243Ui9q0Z4eNrUGFi01j+2/h0Rheqb21h4cOHQMXkxGPqvBZC4AP/abC?=
 =?us-ascii?Q?gszhEALQ6QJEF4u3JePbAiMSUaV4jGAm+BwBiGYgSQZAt89oTD8lr0w9sd0z?=
 =?us-ascii?Q?jwceEIi2ec+RXjBL64HxYVieEGNCsvshN/n+C2joKHPNtkqQiAShckxE9F09?=
 =?us-ascii?Q?vLI7FPhEe2PD4oSs1h1YMPxFIZjIMo/qRjktTQgNvzCkdDpdyzVPVzr9wq+6?=
 =?us-ascii?Q?KzuagudXzRI3+PDD3pjAjR7FFmCkfWsjbYA1R17IIoAgJRfexGjmtpwzZWf6?=
 =?us-ascii?Q?KGzJVFQWiWCZ/KUgLSx3b6ohiwEIRq2X5/E5VWdBUPUPFsWqKtLxg+nw1nA9?=
 =?us-ascii?Q?NKqUFpETfkDELdClWdZHSXANLTx/TrPZL0imOoww0CfL2Hq6VKgnCWRLSqyE?=
 =?us-ascii?Q?mNqGK4zRUIiK/IPORhyi482+v9+jKWVmJYzv10oat9vwDb7NYkpb9U7yjd58?=
 =?us-ascii?Q?SO3YwJSybaCUzZ6jfyzs3KsEmh3J5EcYkeEgrODcrOw1VgrtqkekXNMERSuX?=
 =?us-ascii?Q?VxG0Z8MJDBxePV0Zwg5PZDb0M7R08wLVTuiAlUyZYXgUqC/XsmAhw80x/WhT?=
 =?us-ascii?Q?XHkNsTelDDI6yaOlcl4D0B60+b8EW8YKJy6EKUNvKq9Ka0yRYLu3UjkJ5Fzb?=
 =?us-ascii?Q?tpDdSg1FANcZ9Pn1kvP6h3+cOSv4Xz5U9+LnFG+o36ayiV6xYN9UbAbrmrvp?=
 =?us-ascii?Q?iBoeclp1JBOBRsI2rMV9IoQYUtEwWjWfZlELKhxoMJYIvHkuUg4IAw+BPH78?=
 =?us-ascii?Q?V7Ao8aXVX/O42xXqhymnj+jEW7EgIucehBPiWY6lbFPOuMFq9WjKBebwoanf?=
 =?us-ascii?Q?TP02207WPL45p5xcDdogc/CqFeORtzzek8L6imNTcPRHz08LW5U2UKvQsyce?=
 =?us-ascii?Q?ADFgMAis4n3yyfFZtVmSNxvA0BMh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:00:36.9971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6826e96-375e-450a-4a25-08dce303bcc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

Provide a document for TPH feature, including the description of "notph"
kernel parameter and the API interface.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 Documentation/PCI/index.rst          |   1 +
 Documentation/PCI/tph.rst            | 132 +++++++++++++++++++++++++++
 Documentation/driver-api/pci/pci.rst |   3 +
 3 files changed, 136 insertions(+)
 create mode 100644 Documentation/PCI/tph.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index e73f84aebde3..5e7c4e6e726b 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -18,3 +18,4 @@ PCI Bus Subsystem
    pcieaer-howto
    endpoint/index
    boot-interrupts
+   tph
diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
new file mode 100644
index 000000000000..e8993be64fd6
--- /dev/null
+++ b/Documentation/PCI/tph.rst
@@ -0,0 +1,132 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+
+===========
+TPH Support
+===========
+
+:Copyright: 2024 Advanced Micro Devices, Inc.
+:Authors: - Eric van Tassell <eric.vantassell@amd.com>
+          - Wei Huang <wei.huang2@amd.com>
+
+
+Overview
+========
+
+TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices
+to provide optimization hints for requests that target memory space.
+These hints, in a format called Steering Tags (STs), are embedded in the
+requester's TLP headers, enabling the system hardware, such as the Root
+Complex, to better manage platform resources for these requests.
+
+For example, on platforms with TPH-based direct data cache injection
+support, an endpoint device can include appropriate STs in its DMA
+traffic to specify which cache the data should be written to. This allows
+the CPU core to have a higher probability of getting data from cache,
+potentially improving performance and reducing latency in data
+processing.
+
+
+How to Use TPH
+==============
+
+TPH is presented as an optional extended capability in PCIe. The Linux
+kernel handles TPH discovery during boot, but it is up to the device
+driver to request TPH enablement if it is to be utilized. Once enabled,
+the driver uses the provided API to obtain the Steering Tag for the
+target memory and to program the ST into the device's ST table.
+
+Enable TPH support in Linux
+---------------------------
+
+To support TPH, the kernel must be built with the CONFIG_PCIE_TPH option
+enabled.
+
+Manage TPH
+----------
+
+To enable TPH for a device, use the following function::
+
+  int pcie_enable_tph(struct pci_dev *pdev, int mode);
+
+This function enables TPH support for device with a specific ST mode.
+Current supported modes include:
+
+  * PCI_TPH_ST_NS_MODE - NO ST Mode
+  * PCI_TPH_ST_IV_MODE - Interrupt Vector Mode
+  * PCI_TPH_ST_DS_MODE - Device Specific Mode
+
+`pcie_enable_tph()` checks whether the requested mode is actually
+supported by the device before enabling. The device driver can figure out
+which TPH mode is supported and can be properly enabled based on the
+return value of `pcie_enable_tph()`.
+
+To disable TPH, use the following function::
+
+  void pcie_disable_tph(struct pci_dev *pdev);
+
+Manage ST
+---------
+
+Steering Tags are platform specific. PCIe spec does not specify where STs
+are from. Instead PCI Firmware Specification defines an ACPI _DSM method
+(see the `Revised _DSM for Cache Locality TPH Features ECN
+<https://members.pcisig.com/wg/PCI-SIG/document/15470>`_) for retrieving
+STs for a target memory of various properties. This method is what is
+supported in this implementation.
+
+To retrieve a Steering Tag for a target memory associated with a specific
+CPU, use the following function::
+
+  int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type type,
+                          unsigned int cpu_uid, u16 *tag);
+
+The `type` argument is used to specify the memory type, either volatile
+or persistent, of the target memory. The `cpu_uid` argument specifies the
+CPU where the memory is associated to.
+
+After the ST value is retrieved, the device driver can use the following
+function to write the ST into the device::
+
+  int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index,
+                            u16 tag);
+
+The `index` argument is the ST table entry index the ST tag will be
+written into. `pcie_tph_set_st_entry()` will figure out the proper
+location of ST table, either in the MSI-X table or in the TPH Extended
+Capability space, and write the Steering Tag into the ST entry pointed by
+the `index` argument.
+
+It is completely up to the driver to decide how to use these TPH
+functions. For example a network device driver can use the TPH APIs above
+to update the Steering Tag when interrupt affinity of a RX/TX queue has
+been changed. Here is a sample code for IRQ affinity notifier:
+
+.. code-block:: c
+
+    static void irq_affinity_notified(struct irq_affinity_notify *notify,
+                                      const cpumask_t *mask)
+    {
+         struct drv_irq *irq;
+         unsigned int cpu_id;
+         u16 tag;
+
+         irq = container_of(notify, struct drv_irq, affinity_notify);
+         cpumask_copy(irq->cpu_mask, mask);
+
+         /* Pick a right CPU as the target - here is just an example */
+         cpu_id = cpumask_first(irq->cpu_mask);
+
+         if (pcie_tph_get_cpu_st(irq->pdev, TPH_MEM_TYPE_VM, cpu_id,
+                                 &tag))
+             return;
+
+         if (pcie_tph_set_st_entry(irq->pdev, irq->msix_nr, tag))
+             return;
+    }
+
+Disable TPH system-wide
+-----------------------
+
+There is a kernel command line option available to control TPH feature:
+    * "notph": TPH will be disabled for all endpoint devices.
diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/pci/pci.rst
index aa40b1cc243b..59d86e827198 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -46,6 +46,9 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/pci-sysfs.c
    :internal:
 
+.. kernel-doc:: drivers/pci/tph.c
+   :export:
+
 PCI Hotplug Support Library
 ---------------------------
 
-- 
2.46.0


