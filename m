Return-Path: <linux-pci+bounces-13608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B958988C1C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 23:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A731F226BD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEA18EFF1;
	Fri, 27 Sep 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdgQFEuH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4718E037;
	Fri, 27 Sep 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474264; cv=fail; b=Os5+KcNrqvqN3bSnOX0NeEYwJnSMQwG070y6CFh1LJpXNLzI33zPJy1xdd4urD3C0lZ0cnjGWYljQIIylDkX2X0o/wekEB2T9u/V0IlMOezMJG2fd20n5yqudnzZ6OM4lDpP71iF9TyhZk1oG+rt8FFTp+wZgEtmgd7khm8u610=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474264; c=relaxed/simple;
	bh=aCQBjdTIz8KLRsgZ2hOl+QnuZ7c4b4kJX0w+Kh02nRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJ0JER6Jj6xw7DAr0DAkZxyKuv1nSY4JCbRmWklrejXgyJoOauVgeG3GvX6jx5dwRN8m0SgOV6zecSF/hnrga0j6BPYB3iXHftAfNA9HOoPsPZOoMhhzM+8GrUQA5ad6ZuOp7w1Igru/HQSsRPLc4JwcmSWA/F6a8L/p2tVK8Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdgQFEuH; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ8TclPbW8M9ClLe83zYS7a+ve7meVirTdtDGGQKCD0ZW6M6ZUknpKzZ/yggHB3w4P1kfDF8H4dBO1rf6QpXxxy1eZZeAxlJ5xWW/e+kq3BgVXiCqG5vtfFZkvHWKUd0bfscRqA8Mnc0WYNfKY/w7Qd3es3ZHGZ2NtwJYqQ5AiKM4Btt4KfmLVKXd+gSwckvTEiK2Cd7zBIjN4wTqzzC+rm92pQsAjaWocUn/wlBW2vH2TSZB7FeVMG61uI1pZNdOJL2StwDphqDsrbjjbCX1ypiO4zWr2YAvoo+Rp2I5yGzrGHhLonHicKkEWmJT4GghbKdjMYjKOXhK3AAb407uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i8TJCIt+LXWvUebhfguj+j5UDkelQGwSXKmGqvV7Bg=;
 b=bEB3fAO/rtwWfak8k8PWfmWG/X/DSzdzbYaOAj8ABiLdrCtrRnT7DDtkLjfsPQijgs4XwOFitpDB9HiBMbGfvKT7bxATRRvjWJHa5PKZu0Dl2hkIyFBPzPsSmmSCN31WOzFERejqwP80UL6tZCoTq0tKe9C1asAcgNk9w+iXJfXx61BJ4vcqoMUNRvZVCjgAnqnMhLpibt4XiC47ZXcJUJKfI2+5eGoaxQT6YC4i/ym3kdJeyGkf1+6oxRyv0/cKHPB80PDl+l/XYGIDPs8U83kTPlwv4KMOs9qt9O5jT19tOYHQssAFtwrcdKWzrP9LViRonjRxv+34SRHoXDHXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i8TJCIt+LXWvUebhfguj+j5UDkelQGwSXKmGqvV7Bg=;
 b=LdgQFEuH3jXeHV+WfUEFR2y7pHSsnleHD8MAdONWCy1zVBe7+2+fKJ6wmHIEu9jiLBHaMbcZCz6mkofeBAfF3OS2Eq0dDztuoReCCThbNpfoX4ojPaa9USwi/NhgWFL+bAjkKIRXG1cMr/QSl5MY9s9lM7s4dWMhcHe/s8rVqcM=
Received: from MW2PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:302:1::21)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 21:57:37 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::8) by MW2PR2101CA0008.outlook.office365.com
 (2603:10b6:302:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Fri, 27 Sep 2024 21:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 21:57:36 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 16:57:34 -0500
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
Subject: [PATCH V6 3/5] PCI/TPH: Add TPH documentation
Date: Fri, 27 Sep 2024 16:56:51 -0500
Message-ID: <20240927215653.1552411-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240927215653.1552411-1-wei.huang2@amd.com>
References: <20240927215653.1552411-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e02b97-be9d-448d-a814-08dcdf3f65c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fl+YPFo3bKfcrOITns60ETq52HIZWPjkRCkOD0QtnGQOUATpBX52mgt9BqZE?=
 =?us-ascii?Q?0ZB7y1OP4UgVQ3o82rMcWYqzNCjill8dii18sV7TVMqvqP+/Lr5ugK7nusyl?=
 =?us-ascii?Q?nZjTsSYV9UbPjpbMtJshxmRJ7I4k8/oQa3pvEy9+Z9XhQl/82N/iFkEzEUU5?=
 =?us-ascii?Q?uZWAeLsFpw1ANaAusR7Krnzc7h7tLt7QgCgC0m/47hQelC2PrfUNuLRsRLXI?=
 =?us-ascii?Q?2+OBpzyVp4LrhhE6VcgPUrfaFOjoYCMRxRu6MnevPQ2mGMUYtbXkkg07Btt+?=
 =?us-ascii?Q?Peuk04Nid+V/qNpCMoff5QvJZ+nSP8DlCopAktRUFBcJj/2UJlR97Q1megSQ?=
 =?us-ascii?Q?qSIzons+QAK4dduQlkPcmx1vXJbMjdfN/KetxMJrOJs/4GGHab/3nbycLNEH?=
 =?us-ascii?Q?2Ktk09QldkPcXzugr+Nrgch/gsw3cCNGpgEdrqASfvguyZ+EDDcbrKq7UgoF?=
 =?us-ascii?Q?NSdrZ181HJ3npkPLfnkTltaTV+Oau4Il0LY+cwFKQz88YMwlcuKlKUJjSsAG?=
 =?us-ascii?Q?lFGUXNTBvz1ttx85z8H9o+WvvB7unvojQsYHTsQ2YW3R6PZwPRsEE/Hq+v9q?=
 =?us-ascii?Q?ATQJF8zRELe2hDSR4OYYwMVANZ7cHY4i1Ksb/JpggKhSMu9FKxUoO+hRM6Cd?=
 =?us-ascii?Q?BFFkbboiU9qqzzxc0MvzH5gjUXf3YWOCQ5+K+vGj+/4RqbThqpBOpxmNupTS?=
 =?us-ascii?Q?fHHayRIzZOxgRfSj0gUnU/txanCFdEJY8vS8+dvZIRXxDYV8mCk8uTdGv3iz?=
 =?us-ascii?Q?PLS0HxuxOomoz4spxfrnwlp7x9RN/kris6ZZlqixL3vdNzWBfrOQfo+8tMZc?=
 =?us-ascii?Q?XgnBEBRhhKwEr9yo43peAKptU1b+JYIbkYFxVpPWGrYik+zcddV8oFxlE131?=
 =?us-ascii?Q?v4XSZc8KRzMIP1my0cgBtymVJII7RwCSJ2UbJQa8/WnOe+L8NrDaoOrz67iA?=
 =?us-ascii?Q?J4l6LBdoZmnpWA9D0iBJohlKEVBj1Pix1JD325Td+RCSsevpNX6oM7CvQbWP?=
 =?us-ascii?Q?k8UW2UaoXGkrYo8ypHJtmXxJLmX60kMgqKZlv0qRgSjLyCcxHmR8bE52to6i?=
 =?us-ascii?Q?5xR5AixzG2vt5cy2ZE2dQ6xFU7Lch5E2BY7xFxbl4qa/Sfj+QNx3JwTGD0cU?=
 =?us-ascii?Q?xu7uQJ+cx/jf/T0FWXrPyzc4Lm8/FxdZ33RqjnorT8Ivw5ivb5ebn8vtl36Y?=
 =?us-ascii?Q?5edLhyL/e7K1uL1rWhJj2e41geh95DlpPkkV+4ivoVAFbdoEuX/Ptd4oJPA+?=
 =?us-ascii?Q?o23SCbZPWGVfqZkpn1D4EH6KhWlzLNF7wYSRAxmq/0FFo47NBtOWqY9DA9ep?=
 =?us-ascii?Q?b/dTwSnabsKETGDhwu+fGxD8xK486smFbsDwnaAOPqZHXHfzEZQtlqhzgBic?=
 =?us-ascii?Q?D+vYZG++a7K9Q0Hr0AWJF3pXnfcio8Mo/WSvB0iCc0IR10oK8SB959IeIonM?=
 =?us-ascii?Q?JzwAbIgQvJRnO3HlGxY/4HDaOneEdLeT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 21:57:36.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e02b97-be9d-448d-a814-08dcdf3f65c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

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


