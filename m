Return-Path: <linux-pci+bounces-13247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA497A87C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 22:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F83B28D46E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B5101EE;
	Mon, 16 Sep 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QPVYeqS/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206513A86A;
	Mon, 16 Sep 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519911; cv=fail; b=CzY4qg8IivmC/sl6ytSLRsLJ2/NbirbUAo4KrSCZmOWQSMVgxItcEEQhhRxROnqs086pXRuPRlHxCDW43VWD37uaHqWqbLPuy8W+nbsA+1dYnMFtUzWkpVg/2ZugzdLRgK5dmn8+tRrGHz7/WOT90QDQDawOQyZiUbNkrwOUdNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519911; c=relaxed/simple;
	bh=F8nKWDdjldVlhOb9xZycwYYTCYjYKKf5IK4O7Ls+5gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2l4ioCAVSOD4tf5OrtCP4gYpNz+IwsbF9QrtUqjECJ1CXyxOhmU1GgOlM+g+bJIzKliPbwud5BULIH8lPF48pKWqNMpoHPvVPUiSO9p1dL0P1jpPm/PlGO/uwkOjFqXkN5u4uNOsxAneG9UDli7r8YP7y2v2pfHqw4XWry5l1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QPVYeqS/; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmHUh/0vr5GJGS6EpR5E7ydlYC8Sie1WSRaS/tAAIveFhoe7vN43Ahq/kDzSXRwy3GqLCfEeD0oTfJ9jrHB0lwAq+Cb9rLUkK8b7ccrubVNPtDBHb1dYf8XhB60oVJLoMdwZoXRgh33QoTD4qEVqndrXrm35K177MZMlJ4Cl0BydQN3W41ukO2gwSKgY5B5PL2BL4xtWL4/m3dBQLzgVUzUgAWAaHT69NGNtHpmvjSJXM37VzIsIgmIyfRO+w3aJHRCthRtnEKvidL2TtscC8Mn7Kgt7sz9Poz7VbunU1r5g9oHpYd3k75erMRGUYNkULmeUGrqaWBRAKp53xaSc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUrvCAuSCUQhItX8VKljviXxPJ8ev70dZEI9tr4LzwE=;
 b=D8m2Cbe52Yv4g4U+mhq7KrezE9ImUDB9FSI8B/VM4HjHbfXj1aRytg5Fgi/HeREepRT7pklDgcRPEr9vA+GHmzX1SDmVVRVwnA2Y06aAb7TyIurQPPM619Q8BSQGvpLh5azUJavwAVTMwTw5rMTQBEw9QcHRR2F4PeKnFE0eFoklC30+qxJ2uYmffZbSzq0CnLm4GHIoWeLg4GdfQisnkoVvrjjHY8yixdk/MQGzQwhea/rgnOU5RSp+vSKURYgJzAKTGyb5jC6B88WyqL6Y9lTqmrlMr+KprgtRsLg3gAWTZZc2eucqa3BaqESJhjiDHybK9TlFQfZDHE9PKxp5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUrvCAuSCUQhItX8VKljviXxPJ8ev70dZEI9tr4LzwE=;
 b=QPVYeqS/UxsZ2Tnc1C0hgflaqFLrEgB9N4YoMMdzu4jUPq6ltcftKSwI5AHaWxG4olbpl4CHuldguEe4yzrdqkqFV++mTVA9X+FkHdonk2s6v4AL3aNpDVrDv3KNXzE12vcilSYN0xN3hTyCEwKj+pSYXqFV6C9eUeCEE7+djV4=
Received: from BN9P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::7)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Mon, 16 Sep 2024 20:51:45 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::bd) by BN9P222CA0002.outlook.office365.com
 (2603:10b6:408:10c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Mon, 16 Sep 2024 20:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:51:45 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:51:43 -0500
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
Subject: [PATCH V5 3/5] PCI/TPH: Add TPH documentation
Date: Mon, 16 Sep 2024 15:51:01 -0500
Message-ID: <20240916205103.3882081-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916205103.3882081-1-wei.huang2@amd.com>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd2e683-76ab-4259-4b5f-08dcd6916048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TMTUz+JDlPRlHJvCCpcOJ9J1fUzlaWfln9gbYN59Hbr6Ax3tV1l+hmqAilLQ?=
 =?us-ascii?Q?4Wxe49k5QuBd/ZZG8joJXThFXNoISUK3dW/ac0evzxWiF/6lWEkGscKFF9U3?=
 =?us-ascii?Q?hHkPzriR7FcknElXAKBwbENtbqLJjob3N4WDfNh9368cCZdFTVpbEnfEEalh?=
 =?us-ascii?Q?e1/57xMXlocSvWEwvNM2dmkOkr3W6/NMy0kx86dulbvGqUF4sf8+iyqzcAMu?=
 =?us-ascii?Q?xnBF5MHmxhstPRp0PbO/C0DOojvfNEXiiGgK9AVJ1AfxjWRxfG3+w5l3pyHn?=
 =?us-ascii?Q?dJ/HIJNmBtOqYBL/+mcKIH5J9Dafw1hmBHbXb8iGnQQAgYAT4dz5rx4EjS1W?=
 =?us-ascii?Q?4/Dds8gZbUW9T1AmBtow95L3PTcs6ub3eSOEsrYPGzu6eLJ9PdfVyFoojc7a?=
 =?us-ascii?Q?Gd/hECH6+VbQJri51tc9ZbnwebEkNf7p6K8xEtpltaHVc3qmcZvFqnAPoqMs?=
 =?us-ascii?Q?2rVuX3ntMSEy+SJIZpGEibPMYmZWZNq48yex63YWULT0iJxvlf8zQhY0s765?=
 =?us-ascii?Q?hZutEYxSWvHWUOVmhRYqh6htomSK42xSMd2M2nGVqalLbgoZiGFcDQ9gRSpG?=
 =?us-ascii?Q?uRusSPcdIjMTF9Hee9SZ/qGRP2bil5NGjJD8VmY7/41bWw8qrjgUOSAWEPLj?=
 =?us-ascii?Q?WrqjvkqIBFrUZFFppWI9Cmx/JHCg5yN2qfx/x4E94yIkKyw2pDfx+FwzNsEu?=
 =?us-ascii?Q?5e1zeKvIjBjP0OU0JF4gTPO3kHCURYrVz5DnDss7CjHckzj3K8yfuRtj7PvY?=
 =?us-ascii?Q?nwUhc9SrbKMYZqyoecInxCPGcNzvAqdKEw7K0gNpEC+q1VEqbYyAnEfOFmai?=
 =?us-ascii?Q?jhx9N+mXrTGDJF6U6UxryOkK5VfBmA32SmqveHlXDzdBvgT2080iWrmAlOQ1?=
 =?us-ascii?Q?ZUYBd+NjDhaV3Q6YDqb0ZmdjraTLxADVjiZ93fK5LdB+IuZcufZRdnLlCA5I?=
 =?us-ascii?Q?bl9If8/8kN5dgBTdh/OlzLs8L0+YQRMe/S2WbC+Ms35h+jJlFLe652boTPtK?=
 =?us-ascii?Q?2XRWXi1TVLRjkL7GA2yZCjjAjc9S0LhE4KfHXF3z3fBm02hiG9iE8+NdJWL0?=
 =?us-ascii?Q?Lszs69e9LjMGWeX1kYQHFbDQTz0dq13t7dzdDBNJpJKB67WXUZ8CxiZ7XtTk?=
 =?us-ascii?Q?H0Vbtam6PMOuN2LAN+xPSLOMW09OsP2XXDd6UspApzHk0tzuOFyOpXs8PeuS?=
 =?us-ascii?Q?LUWpfGbayoZ6OHhsuclOfrslp38u0lexpLuEM+Xu/OCredsKnj6hVRBG0KtK?=
 =?us-ascii?Q?/nw7TDzK2yLH6pTxZHvuOnqtnyzfGEk4/9Yxg6ecNx2JWGh60BTuOw25TCjf?=
 =?us-ascii?Q?bwl2ojfj3yMwVrC3qgBW/fr/iHCjgaG6TkJCURP9UWlNDa5kR3vxSNAlSMKr?=
 =?us-ascii?Q?oYpVBmegztnundVvhNIxKSCFvW/8X/txSJLOxw/n16cLc3CMwFs8KTIVVR1S?=
 =?us-ascii?Q?VXmELJk+DVPOJvfnCvZI262YRasleMCH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:51:45.1376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd2e683-76ab-4259-4b5f-08dcd6916048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

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
index 000000000000..7c4b27789f87
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
+the CPU core to have a higher probablity of getting data from cache,
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
index aa40b1cc243b..3d896b2cf16e 100644
--- a/Documentation/driver-api/pci/pci.rst
+++ b/Documentation/driver-api/pci/pci.rst
@@ -46,6 +46,9 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/pci-sysfs.c
    :internal:
 
+.. kernel-doc:: drivers/pci/pcie/tph.c
+   :export:
+
 PCI Hotplug Support Library
 ---------------------------
 
-- 
2.45.1


