Return-Path: <linux-pci+bounces-10470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC27934386
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC6F1F20FCA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D25187857;
	Wed, 17 Jul 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eXQxabPt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55DB187337;
	Wed, 17 Jul 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249822; cv=fail; b=sncooAGnpIQ3IjGsveD2j9WmI1nUAx9/7UDQFa/jG0qIBdRIhyQwbtuNfCafoyth/3RhVZRb/huBWvvGpA/QxhiMNBm02aCylGjgQWzTdNDYFkEoRtt2HotA+ND/tDokd7kuBRg8YJ+P4gsWwNKon0RY7wFj0eMda558ez4wZ+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249822; c=relaxed/simple;
	bh=+AYVrkf/vXF6tqaYHJG5jiTeg4Un5iZDQMyk8ujNbmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPLNb3J2SHBcryXvRuWfbeo6CpQaRQ4YL0jqVAQWkYL6aoKmTCnTWKSqvi+yYfDFnF0qOHqXdkUq4AQR2/k5rzfeuHs0GhLEG/BehHZ/aAcxWxTGKHG6X5rasxilEBT+DsAbeJVfL29fGcDBC8EQmSUh8zqqGPH1NzsigRcyCas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eXQxabPt; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clP0rM/ZNXdop32R5t/mwRIZxUvz7piwgJN66o1PIXYiY22qe61AQ1ubAgabNKq72uPRNndjcORkU9P4H2IQGNzvyrWm4O0BYUFaUb7F5pk+eBeNwbAgH1ciETrDsO00Q5eF7fi/Wvab2+65l5TOe9q3IQk2qvao5yeqUzi1ceJnribph5XKYnjSRmQ5SMN0N4zgAeWJ/Q7hZjAIGwJI4rXbw+EhLfWL2RmZQ4b/ee+ixqqWp+50c0Z03eeGYe77VYyckmjLg1pSsbXwcQ2Eq7gyG5jn2Gi+UGNVOWAgqJbLNxgFXyA91qYlsc9rL2khTWqvBmdsL/LkYNxNXun9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzbGmQwNy+B6qdVbX7tLgb7HImx3+ahhqYac/WXoTB0=;
 b=sXxttxcYEQfq8QSuDOM7ctB4/5YQ7B1B1Bo9qioHXOuXrR+RW8TP7LRgxnWma5AxhpUH8tOaPnsc4/1Su7Qxxaf22tZ/Dwe188L+uhNilb4BjS0ZYlSOH2gFVFlVYUe6YJWUipLgbb71Wko4q+sPGNVPYoJzgek4CEkSLxV5f0yO84yJ9UVxim/B06aDGh9n0sshxpCwyh8TGy7svrDgozWhXDJrKX4Q/Ci7t48yOSaJXlUoRITjFzUO6sIDMOFHcJmhCBujBWwjI0Gq6/9aHa2HUTf3Xesp/6Zg2R3LHDQapTE+pr70eCywEUSUxIkSsfJP1hhouG28D6I07He/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzbGmQwNy+B6qdVbX7tLgb7HImx3+ahhqYac/WXoTB0=;
 b=eXQxabPtDFub5dCLXEh1sjlXldlAoXbakgvnyMnXkRLHAKytJWBtZLKIAb5bNXdyYXPzpEOwfqelTmKlD4P9MSh+9TVwd7eNj1xgMRFuLWOWpn2VH+UL0C6+H7UhNpnLWm64zuLt/hWXT25A16uUSgJkc2OPGWe2WnvnvbPMXyo=
Received: from PH8PR21CA0011.namprd21.prod.outlook.com (2603:10b6:510:2ce::19)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 17 Jul
 2024 20:56:56 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::bf) by PH8PR21CA0011.outlook.office365.com
 (2603:10b6:510:2ce::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 20:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:56:55 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:56:54 -0500
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
	<bhelgaas@google.com>
Subject: [PATCH V3 08/10] PCI/TPH: Add TPH documentation
Date: Wed, 17 Jul 2024 15:55:09 -0500
Message-ID: <20240717205511.2541693-9-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 39493087-cf27-4ac7-6219-08dca6a2fe3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVgakjGk316Agv8lG2LLYQZk65PUvl1HDmzSsgGoWDK1l3gYvqlTnAEF1cDI?=
 =?us-ascii?Q?UUlXTC011gG8mvcLSSx6CQ3T9JpbcucHoCcY7sVHJ+myY97xKrn9/Aw9BVlA?=
 =?us-ascii?Q?PqoJo0jdCjvxrlD9jZRgzhNoRZey2hR4wkR5t+hOjXsVrnJo5UjtbyUmMLSj?=
 =?us-ascii?Q?b4Fo83AViczr0cwNg2fKEDzNvS2GvhoV6hGzdsyicf0YcXwxn1OVz9T/31Rg?=
 =?us-ascii?Q?1GDd98CjTlkujgh9YUE03T6jQrlypT9ObsNUv3gY6BVQ977923DCI1y76/J2?=
 =?us-ascii?Q?FbEObJdISgXR93FoMQVvF9aGegeKGS1DY/NZrTSNycC2do2JnuP/KTh2Pdng?=
 =?us-ascii?Q?KxFrP97pWvgvCTXUS8PSBwVN4dRAkzC7xqzosj22rZOLhhh2cPsH8V80GvZ8?=
 =?us-ascii?Q?uJI4ILr48BRtHr4mD7Woiy5y17PSMCdEcnNnmRwr7Vzd+1BKB+vDYlw8HuLz?=
 =?us-ascii?Q?LR04BcmZYrxhGbJInKrqi7EpG1L4iXe+L68IAwECH8PQSVkuEgFniW4nVewJ?=
 =?us-ascii?Q?T1m5fWYk1Ano7oEVHbWNMChbd+2+onp4iP9GkZ3fkJdMinxoJJMz+jZpyhx9?=
 =?us-ascii?Q?uotpI5Sq7GLowjog2lPOM8ysHD0ImBBOvaDB+OiIeUNHht769Z4jnuE7YAWk?=
 =?us-ascii?Q?KAEtGObD2nYyLqOAJvf6FKsCPo6m4hhtl9oFqB0vJewpySllbeVapXPWaoEe?=
 =?us-ascii?Q?s+Fuwv1pDy/XYwlfEihwdlPJwOXVKQhz539u0efVP3Sw3FYt8hnFE7XhPH3E?=
 =?us-ascii?Q?LwICykoisLifyEqus8JLvvev0Q2lAVkkQ3qFDA6VAQVh/6Ks7zzHf4FYtmaA?=
 =?us-ascii?Q?Kpo2c0hs6ybwGw18/rMjtNIbG3Ti2YyHaeyitP1AFXoAaYP0bvBCjAJz/vnM?=
 =?us-ascii?Q?ALmyWwRlKjxgoE6m8tgdBUJnFihnj7lbrX5SQUg3aKlrVY+qn3wN1cDPzoho?=
 =?us-ascii?Q?e9QVF0gumSckVIdtGi24MQsZAMDYxvocD0z0eXMcOPW3hxwagv8Nm95vBZyy?=
 =?us-ascii?Q?wnmpH4bwO0Zx1JEBi1baK4PWeg3NK/s0k7Y4vN9xUqiq1gkhukY8rXfs2pNE?=
 =?us-ascii?Q?i1k+8GG7x8FXAFE9lX7gHv77xTeZytO2lJGHoDoUao+3QbWuPBgFK3qtFhYD?=
 =?us-ascii?Q?gzx2ugSFBx420lE9KULyyAXMxl2GnX7V4gheXQ4eevq/rwVLed+uwM12mcRH?=
 =?us-ascii?Q?GNmgtJJyJQ9saj1O6aJL0c9riGCg4QZTdZ/5DNfWVqBBgKOwUWinWksateKI?=
 =?us-ascii?Q?Lr58kpUOp82lVX98oEvzf381Ucqhf89ZAesjEKNWePEnP6m7cPl7rv6jZWoB?=
 =?us-ascii?Q?YV1rPMX1CH9E1RhV7His8ebSfFF07cmvjNRGh+ZjL0Q1MWDa0gfYmAdzsJac?=
 =?us-ascii?Q?LCcMIwzs+hVajF4tuYRIt8QfbHzvRyKDctCcUndAd9jbbmZ2js5FiPnBSeHm?=
 =?us-ascii?Q?KxaPnN980oXPgfld/GZJHa12fFm8mPq1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:56:55.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39493087-cf27-4ac7-6219-08dca6a2fe3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860

Provide a document for TPH feature, including the description of
kernel options and driver API interface.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index 000000000000..103f4c3251e2
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
+The caller is suggested to check if interrupt vector mode is supported using
+pcie_tph_intr_vec_supported() before updating the steering tags. If a device only
+supports TPH vendor specific mode, its driver can call pcie_tph_get_st_from_acpi()
+to retrieve the steering tag for a specific CPU and uses the tag to control TPH
+behavior.
+
+.. kernel-doc:: drivers/pci/pcie/tph.c
+   :export:
+   :identifiers: pcie_tph_intr_vec_supported pcie_tph_get_st_from_acpi pcie_tph_set_st
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


