Return-Path: <linux-pci+bounces-7303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949558C12F3
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F9283DE3
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830F171671;
	Thu,  9 May 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D0w3pt4N"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2826171E41;
	Thu,  9 May 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272160; cv=fail; b=DmMke7bjnysFQL4X6LnXbyRkNRAvxO9IwOzUpX/mq6TDdM+PLWA+tZXRDYO242hfdl/5Wl/odFuvJXlrHEdYRxe1Oij6269AvON4vRRQAGI/U2xVoFDeJixUE/OVOGGqTAx8UsS8WM5gLWgg/tPqJPxAleup1rYUwzqOrTCdoFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272160; c=relaxed/simple;
	bh=YjLA+MbfUwCiqqWE3wLmFU1uonFtQNQ1c5U5WHkctqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBuYrODJPJEwdPu6mcO0g5zi/eY/rNwasfgbilvwz9HAZU/ajxOr2pyzcSgBOKusbn/ONsgGMaRx76bDnjXqM1ArDlXub6XhTZwm1YbOJcE4Kb05VI3YLFQroVU8nIGo3PNUTJtlHOHZcqfoYniLm3Vaq7wHWo3Fbu2Czm0iFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D0w3pt4N; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaPlTbLJ91Qg3GOdZz/mHyolK7GsdahJKVnPxK2Vwxo53dReUIhjIMMESxRJ7iRA1RxNpO1cJ4IyIjboH1Hpf6IwwfBaxGTQ0EkAKxLdAhxc61KJ0g9jE8B2MuDKEI25nswF3uATyktSp0pUq6l1//f+kLIdaYFwnYne4glj43Sh6NxvVam4vJW1JIVwc8MQcIGJy7qU9HfzifRe3MS7YhCR68prl4/Zvbl+7UHgJSqMYAckspiweGOFIKIbZpPgCyN9a0GFMTLr8ZH5xa06z8JZ1Y6AIgYOxT0nxpX3g2etNknZyNlwPyDaZoCoL4okCYf7O0HM2CmrIVzSxOZ9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZz7uU7dVhO+zDM0ufsEL8QMSXOoZXkxpNkAdKIcX6s=;
 b=KGQ71zdU/++PBuOU9qoR60rW9+PMSkCMsdwFLKi7sqZhmOIAAn12gVnvxlaR+9Ub1gaSbvDXEDKq5GcTYEoyYX+iQgsr91/6V6V3cIepUy2P1KaBzPAcYTi12vrZ8cDe/9B87oL/dew0M/Cqg9Z1QTen2Ub4WptEoW2HbPPbmPCavSG/bDVJQKDEMfiH7Y2j3szzATmjGN2W6EaHAhT5uoRO3hJaUpHhCGtEkvsm/hRMCDwtGxZu8SYomf/cEHmEfZRZkzq6cEzyL1SnPqxoEC3tn7R9zrHqW6Tbllseg2jSTKiY6GLcQ4l/1Qt7vy7v5IBVADjkFkiVf3uQupqbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZz7uU7dVhO+zDM0ufsEL8QMSXOoZXkxpNkAdKIcX6s=;
 b=D0w3pt4N6xOeWAZu98oJTr3j8IVgljK2AzK3Pn1ll70uet1rz4O9k9ogjAhWkIfqZv8yccxApMUb6PBS7Y+Sb5wlVcsfxLIOhNEYRV0i5Eu/UfRXPYwnEMBy7Ln/xa6m4bXtnmbC3qsen0pm2an7Txxe26rVdDC6x2oVupsUFMg=
Received: from CH2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:610:50::29)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 16:29:15 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com (2603:10b6:610:50::4)
 by CH2PR16CA0019.outlook.office365.com (2603:10b6:610:50::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.45 via Frontend Transport; Thu, 9 May 2024 16:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:29:14 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:29:13 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 7/9] PCI/TPH: Add TPH documentation
Date: Thu, 9 May 2024 11:27:39 -0500
Message-ID: <20240509162741.1937586-8-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: e2364dce-00cd-40c6-0350-08dc70452a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dub8cUhe4RydH7eVov43/uV/NoEw1EmiOwjfzEky5/twtsWLMO9SA/YEfd/I?=
 =?us-ascii?Q?6kgxcd6G/JnCBd5VwUD1yfOKrIyzY7LfMLRrZwZdFI8SrZzUHqeccoySj3oA?=
 =?us-ascii?Q?sPFdRe3oot5fRPV9ZC7hokvzMmowaix5sFnpnperRKvuAFWPbCtXj9NTLjly?=
 =?us-ascii?Q?TuK6ZvplTzzxc1UpGmpzEBqL96SISXYzP3wzQzUOYllLoaSL0pCqK9Kglu04?=
 =?us-ascii?Q?lcLatguxM/CheCjkC0yx51w9w5UC1DITVSt1zG1sXQbM5MXmLzjiJK8nykzv?=
 =?us-ascii?Q?YqN7jcJdD3F7xZt4f+cB7Xo0tMUqkCQXzmbxgqcH8QfZR+PK0Hepz+u//2bU?=
 =?us-ascii?Q?YTR1m3UBpC23chg9LZNj0gWoc4AdRepZtr8VsstHG0BgR0J6Qc6BXGecaJ/H?=
 =?us-ascii?Q?QyAnFCriAQZ2UQ0T1M5363/9dnVWYLLM9oxq35Wgp9ysuO8mMIQwUBWuF7Yn?=
 =?us-ascii?Q?7ypthEA0YleZeRFiakyv0PRs3swQUvvAaF1Nvj40BONj1vPO1s4XW01XBK/h?=
 =?us-ascii?Q?ZhF+u87T8B6Pz25paPslvRwf0nJ8QKW9fKD6e3ULPlyUERB5SD1xqguvGoHl?=
 =?us-ascii?Q?jtokuAy/XiJ9etibXhWH68A+TzICL9JVKhNQBkz9IBtJkxuhJsXhwcBHl/La?=
 =?us-ascii?Q?MK9IUOmUSIx7PZjiwFewZAwF/co+CkrI54eUS8YSKbE/nuxNSudU3XYPgaCa?=
 =?us-ascii?Q?DhK3m6iKxUOhe1EeBj3n8o4ZEDmjan1FAmwy3oJmce4+YB1RLk1aW81IQtJ6?=
 =?us-ascii?Q?36FBXkq4LGM/DML7LUWtsqtGzyzRmmTJf8zPQX7SCHiWwl7eY5n4JpeQkto9?=
 =?us-ascii?Q?r+LIggfRIB1nwCT7JT5yG8ZYSQscdqic6WUzqW/NfSUZvicdYILN/WsAvDu3?=
 =?us-ascii?Q?P7H09zcKzK2kJ++Hexppokl7dHmImpqybe2jziZzcCwGZwDLWvG39ZxTexq+?=
 =?us-ascii?Q?rbq9kYLXAC3WmZ46cI6V7PA1AOmRhKHhsIiWpd0o21n1v3pGJkQDcEdckmyl?=
 =?us-ascii?Q?MvkYvIwM7Hybj72lrmGDceJvoFthFmyW6idmn0cmSrg051NW/Uo1A4JHNRYF?=
 =?us-ascii?Q?boE0E+STSrB6S9cqGysZlU+0YOPYwExnqRXq/dT50kSNzRUZ/B7BPUeb3Nzp?=
 =?us-ascii?Q?6TkrU5VRi0TkW6kB0VSnGE9n4KkfuFCeBuAZJXp01JEXwrL3Zssr6es6DnP3?=
 =?us-ascii?Q?Njxo7ihzOY6NOZ9Ojp74rWWLqs/L3sRVa2e1UIWxNvkJtZUWGXzGWTI9WMEo?=
 =?us-ascii?Q?tNON5vbVkjHOo1YCub8cf7i+FzNkeOFt/XNr9aLe021BjHAkXZHsbFJfza7Q?=
 =?us-ascii?Q?8uwQ3RBTRuE/ZRFLs8CdE1Pu4HcITG7fcl1gQXiyIl+uigZEnsF2wjhOXkO2?=
 =?us-ascii?Q?IhCe+nP7G8aMPkkKVqz4OFqGbAqV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:29:14.6236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2364dce-00cd-40c6-0350-08dc70452a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

Provide a document for TPH feature, including the description of
kernel options and driver API interface.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 Documentation/PCI/index.rst          |  1 +
 Documentation/PCI/tph.rst            | 57 ++++++++++++++++++++++++++++
 Documentation/driver-api/pci/pci.rst |  3 ++
 3 files changed, 61 insertions(+)
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
index 000000000000..ea9c8313f3e4
--- /dev/null
+++ b/Documentation/PCI/tph.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+TPH Support
+===========
+
+
+:Copyright: |copy| 2024 Advanced Micro Devices, Inc.
+:Authors: - Eric van Tassell <eric.vantassell@amd.com>
+          - Wei Huang <wei.huang2@amd.com>
+
+Overview
+========
+TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices
+to provide optimization hints, such as desired caching behavior, for
+requests that target memory space. These hints, in a format called steering
+tags, are provided in the requester's TLP headers and can empower the system
+hardware, including the Root Complex, to optimize the utilization of platform
+resources for the requests.
+
+User Guide
+==========
+
+Kernel Options
+--------------
+There are two kernel command line options available to control TPH feature
+
+   * "notph": TPH will be disabled for all endpoint devices.
+   * "nostmode": TPH will be enabled but the ST Mode will be forced to "No ST Mode".
+
+Device Driver API
+-----------------
+In brief, an endpoint device driver using the TPH interface to configure
+Interrupt Vector Mode will call pcie_tph_set_st() when setting up MSI-X
+interrupts as shown below:
+
+.. code-block:: c
+
+    for (i = 0, j = 0; i < nr_rings; i++) {
+        ...
+        rc = request_irq(irq->vector, irq->handler, flags, irq->name, NULL);
+        ...
+        if (!pcie_tph_set_st(pdev, i, cpumask_first(irq->cpu_mask),
+                             TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
+               pr_err("Error in configuring steering tag\n");
+        ...
+    }
+
+If a device only supports TPH vendor specific mode, its driver can call
+pcie_tph_get_st() to retrieve the steering tag for a specific CPU and uses
+the tag to control TPH behavior.
+
+.. kernel-doc:: drivers/pci/pcie/tph.c
+   :export:
+
+.. kernel-doc:: drivers/pci/pcie/tph.c
+   :identifiers: pcie_tph_set_st
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
2.44.0


