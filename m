Return-Path: <linux-pci+bounces-8149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F78D6BD3
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122E0B2218D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB1823DC;
	Fri, 31 May 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQdh/sPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E42208D4;
	Fri, 31 May 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191646; cv=fail; b=bEKnshZe4ltE2fQCW/kxoqX5eQHZhUW1TAJye8KhLJwaQtKxkQm+uMflUWKp4hr4/UD+aHyx9xazALGVsNI/4/vxcHgWer9NQQ8U+y+8GKrWsTvgvzupuO3TRjEoh8TFb4sx9Rbw2BTjArn/9BWAgauTzRAskuq/iqkDgeHXBYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191646; c=relaxed/simple;
	bh=3PN6My46xsk5M0E5ymn6jaJxzJz6OEGRK1s+KV31RCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj4m15FF0luKweQ6VhCodq9yhxjpojcX8aYV774vKkZDRfosuk3xxyRLFpdgMUXtDVx5GR2hvE8Rt0z4qAUVdZi09YNhOMRaVO1sQze34v0vXzrgFdBX6w9rMxikyWndnnF0ecIt1VMemsZGpai9RtoVFS6NAbk5rtAwNhWv5xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQdh/sPW; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQUlXRnDt+sUUR8Mlcmtj/ix4VK8uxrVAFcJzaC4AXV4z2S0buHktdQrbVbRKikkjiQ13/hdg0mHRtI+1AJH8qeuEok/wqxQe6ePA8M96TlwbOemcxwlhodRduPdoenmKZmQpUQI8SfdQCMA03PQo9nNRduNCs5dDAwg/JmTk4UhlsCgnRdf/fOqK6JHqa8IFbhsyc3Le5e7pH3NX4sNbPkDelsBsduiODU9TSx5GZXzzfJcdCfEWeEGuOZRyK4qhospjKFaFROLnHgSMlgD7VO0A6a9wVBV9ob9iWW2RYQtjJv1IJBOkWwtUYa4/gPMlWXY5au+jhnXJBqZR9UQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yDcA/qlR2gvxpmAheEqE4dr2AMvLFvdV8bstO6LBBc=;
 b=EJI96UNwxvtfrs2NjLX8OgbUrUqsO4mOUACL3JQV8Kq6GEpRVQ6bmQ0LxEmVjL+304eQBsYbGDZxQr4KHEleqVjwigKhbqC7tty3aB6+CPVbppwrmuQq+huzmkHPM2N7XrvfQ4Vkwk9uF7KjM9aNn+rtt36vF8+lIXPP7Cx/5nYIK8nafR3hFNlYPxckO5Hi/y2aqJdhkRQ2IU3dk8kvSFsZfkTki+i80qZ7cJ+bLicBoMur3MA697V4Dr0q+myBxMtZIMQrTatS44/4vJFu1jmLvkYc2Kciy7gU78Z639BDpnvhjKiV3IYSpL2/wLkoSHGhbjI8dx7JEEp2Vgavmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yDcA/qlR2gvxpmAheEqE4dr2AMvLFvdV8bstO6LBBc=;
 b=SQdh/sPWWX2kFF9rFtJZATVgb7Sll9vAiKblvZapK1YEeInHXCpWWMuWOei7qHWrzCCdnvWTiqlGhWcdeXH4tFn/jBNquoAI+T5acRJQ+Y8Toq6Dr8X4zsEz8jwbeqbh2Cs5SCQDtTPPWoKl4PCtrNod4xYZKfuLP4CGYsA7PjQ=
Received: from BL1PR13CA0297.namprd13.prod.outlook.com (2603:10b6:208:2bc::32)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 21:40:41 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::12) by BL1PR13CA0297.outlook.office365.com
 (2603:10b6:208:2bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.10 via Frontend
 Transport; Fri, 31 May 2024 21:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:40:41 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:40:39 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 7/9] PCI/TPH: Add TPH documentation
Date: Fri, 31 May 2024 16:38:39 -0500
Message-ID: <20240531213841.3246055-8-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dd5628-651f-4842-47b1-08dc81ba51b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ViZuwbrxnM2qEptqEe1cToZJ8DTF6ga3fm3sF6UtUsQdIrUhzoOD6aY7zy4w?=
 =?us-ascii?Q?E0z7AYdkPj48/JMjVYJMcuIygm5SpI8+giuv2KOtg498qiRi5NK/2rAZAXG1?=
 =?us-ascii?Q?J5DJf13W2urYiBfKewaO14/Qy4rWHe5xk369LEbRVYDl8rS+yhUoBTOgp6NM?=
 =?us-ascii?Q?QZjV2ngJmrhsAevTGdMfr2OIGM37bB7Q3mysUewrxaqfnmAUV24/TxeoALPo?=
 =?us-ascii?Q?nUS6HGjQNcMzMKK296KGphdnd7tKUYchNKMxQmarBFZZh1yzWbTAM6gLClH+?=
 =?us-ascii?Q?0dwtU6fQFuuxyeXYuJy5hZ+rSRhFf84nhc9jSqUAgIH2Q97FWW/pTFwDS41W?=
 =?us-ascii?Q?I6bG1bR6jFE+/MODJxHeW2x8MFOHI7EAp1BX5zco4CjjOziCvuy4esNlP3yz?=
 =?us-ascii?Q?iJS+86cf9zjcUhyPZPHgM3WQXwvvAQIW4UkPUG4MuvSRYZjhIPb1Z6uQ0/B4?=
 =?us-ascii?Q?P4RpERxl6C2ZSTbx564yksuu0RyzWLhHSJ28lA4Pa/rhegPnK+Y1eBSLu4Xa?=
 =?us-ascii?Q?Po8ragqE9ABh1HT7rpg994wJOOMxt8Ry/Vxj9xd0JKIoaEMQDRNDBBfzL5wi?=
 =?us-ascii?Q?f2qI4Ah94/DEHqLVHYve77jcEdGgckain3sKxlTXmUyoEnyF6Po6w5LCKMg3?=
 =?us-ascii?Q?/LiFIIMXJ9qcPspWAthgXFpjWJB1xx53T3ZqxFty/moPlZluMD54+sVEyhP8?=
 =?us-ascii?Q?xI3O56xLdjTAIPWBvaO1W6WHFiYfNNnRxFWSs9oYweouXe99ft7w3mlLsiBq?=
 =?us-ascii?Q?VWj2PRqx9GE5b5WThnbwDH68cKbKAjbK1zoJW5yaKeInUFPBnByE4mC0lpNd?=
 =?us-ascii?Q?ytsWoBKRpYTEvw8Extq+iMN5+rcHU9CRsgUJEyUSA+080JO3us+3GOsUExS4?=
 =?us-ascii?Q?U166z+2EjF51Q6zGivz1ixvESoTYCphbrf7Gd2IAZQNj/xmdKrbLpDt1wlSX?=
 =?us-ascii?Q?awC8eFuGI3IZI5JDBn84XMm/SPXDlA0LHUyqxVVzQeGwdJw1vdCG9kX/p1iL?=
 =?us-ascii?Q?j98zBhglBPBKAF+zmhCn/tICXmGTu1nJdN2DS5b3C2cxHRxv8ozxnaUjD5nO?=
 =?us-ascii?Q?nvFOFkuHPjTIisResbCHLpbMBEJdeJHTyjXpyaNsUCVNMlDKtlxVLCh7OSks?=
 =?us-ascii?Q?eXUJB+4g0GEnhZIvhnL+8GTbQKHHPhD2IAYzB/Sq0Cu/unx+3uM/5sQyVcae?=
 =?us-ascii?Q?Gv4eC2VknQI+XOLZ72JVr4IuABMsjH1eVK7u9gKWJDvB7AFeYLbCEfTXEXU9?=
 =?us-ascii?Q?Ni8gzmTTUXdbX28qjMLkfum90IVAz+PZY9bxVc+/lSGW3qsiuXLLIe4uEyU5?=
 =?us-ascii?Q?kcjQSVCkuPWixF9K/xX7bguKsduzN0NNGkH+eIdV/eLq6ZKhbE403XhbMpFb?=
 =?us-ascii?Q?l6tBoWbjJt2Y7kLIzBn/uePc3vRb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:40:41.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd5628-651f-4842-47b1-08dc81ba51b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912

Provide a document for TPH feature, including the description of
kernel options and driver API interface.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
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
+:Copyright: 2024 Advanced Micro Devices, Inc.
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


