Return-Path: <linux-pci+bounces-44796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF91D20C3B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE2AB300B882
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE4733121B;
	Wed, 14 Jan 2026 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g264mH0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F052FFF8F;
	Wed, 14 Jan 2026 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414917; cv=fail; b=KUFy1W4eQdrLsQwVYd3HHlJO9I71kSaIO7BiGXzv/1+UvB9b/JLgl112jzifmsL+ONeqzI/3xaoWJ6isw6Q685bA0/08F301im5HpUkUzyRFM0scVPEFAM6+DqwXsQRDDinC8z9GkAhz7nyxb1FJ0zCWxW+9KeKQFvVAChrES3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414917; c=relaxed/simple;
	bh=JmwN0IEUNf/7KEIHnJP+SCIgMlHGYUWGNIYiT+c7A+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjJGWR22prxUr0fz3CMsjTJklwrMgYOYr+U3awhPrwPdQZ0lG7NRMbKBO7zYPCJ7ZgoL6eL7jZ7Q3ojyItz7A7m/C2mR97zDgh4TFTQcMLzcD9Sj2c9AXukEV8h7UAyiUu5jqK1kmZZpsfUlLhsUWGGoZjVPq8kZV7E4loalah8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g264mH0c; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhEeTVlY2aAidzNQ8P1YpUQmkgaAwnajtxfUHLvVrf1oeozX2s1nj1EKVoRit55r70OyCwl5WA59Lv348Eqtx7N1abC2tsJH0LNJ1X17pHz4OQWVbcU5BVPKsuMCxR3zOVBYzI17046qEzn3fzxEdOsXpE4ZzNoyyfNos1K/iNiwnQFS5/2CtXYWQ3IKbROhIw5BZAM8nKRy3JsZL6ySC25QGSdQNSMe05Bqzh9UEKjEizhdDLWwolVzMXLNdc990u+/uJJ0N4U0W66Kt7c/18aw+PFaa8ic0CFINFLUf7lAoguKqK1ZUKNWv80jRu+wmvRVW8PM2pKUM1oN1f7vSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSsySPeXGyLTu8tPWVTXleH9f34LALcFz3tOyYUjASs=;
 b=CS6+5IJO+eQSEIOdrbls7WLzj7iU040bKuLZ8xnVt64xTO7V11wX/29a3rlrcF/uIYMCnUm3uLWLxSaqnOjE1MqPxfNE5qtgy+kC7ri3JsnpmrGzYWPUGMcwPUMXIjjd8Sugdt5vZRDM7zlSwO6umVsUhTP/FVJpsQGUwEz9yrxgZEu6CPAZmSnfR5NLWK3CNldXbIOBvGfDvxaysgjxz4kBPfMdDUuP9Oz7aje9HFPWTiNt6awAFB2GyAj/senKN4FWjudhPqltx+H07Ztif5dtV3s89MGePkVw/mWm37fWZtr+HznHJnJn41T2rgDJXf7x++V99ptrs6ZmDhZ0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSsySPeXGyLTu8tPWVTXleH9f34LALcFz3tOyYUjASs=;
 b=g264mH0cYhqP02Eqyoyry0mtowi1ZS42MPRFlotwFwEJeYEAOcD+Z9GnAEMTsq47G4VZIYl5qharTJ7Rz1WWND3RTwGXog0NO8DQFAKEc7NWe/hbWGNfqWUc/sLm2iELuvK8RYQyIHjJyeDXF0ATRLHA9c+S/ccueSlfOuJYzeI=
Received: from PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::8)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:21:46 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::dd) by PH8P223CA0002.outlook.office365.com
 (2603:10b6:510:2db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:21:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:21:44 -0600
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
Subject: [PATCH v14 03/34] PCI: Introduce pcie_is_cxl()
Date: Wed, 14 Jan 2026 12:20:24 -0600
Message-ID: <20260114182055.46029-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: febd3ff3-7385-4378-c073-08de5399c6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D9GsuCc70vllrg7+a8LYrGIMV+kzxh5m3Suu8XKOKMnIp8dnHBqhiCgplRt?=
 =?us-ascii?Q?98BQgUHyDv0F1d5Mk/N5FIKWgADxrrTF7AzdTla/XaLTQkQWA0WiTMDB1fIX?=
 =?us-ascii?Q?e+4yUrqtT3K4ZGv/O2AVN5AHBVitEvWyQ4wYtYdkjopOZGYiEGwjK9zzOVzj?=
 =?us-ascii?Q?IHEpVUPjKXFrJUJh6aLoz3OkvDGeJRwy/PcfQIKvcI/s+oKcrmVgxRZgkQ/C?=
 =?us-ascii?Q?PJY/wfmvat15yEPIKxoWH2FxAAtH8xC1ZhZscaueE2dDM6AUtN0epRrSh++A?=
 =?us-ascii?Q?JjuJsiP3QsFbOIuKJwc09fVDo+pZisWna2UD10Cgit+p7QKp/Er2eWzvVjfw?=
 =?us-ascii?Q?3oPzJvzzrRTp9UwidocSzTrjI+jAYyNAAgGWlATbEffq47Wg7sRWUH9NVKwF?=
 =?us-ascii?Q?TIOYn+FTjMSP6I3VitSxcxCK74ciW8INhKUbiHxsTwY6Ne7FYf7jyPVQpk4M?=
 =?us-ascii?Q?QmUBE6h1s+7S8YyfraYF4MieU2wusI4qj4mBpJj+PSWWuPDBdI1qCYNxFK1x?=
 =?us-ascii?Q?SnPCOlXdMcUJJgvcJjjMqUCGwbWYkAInUZ5+Hp33dNjJHhryq2C6xU6k3RFc?=
 =?us-ascii?Q?b804fN/+0Vl5egiIpJQAfedDH8Z2D+T5Ft1spa6jaqSzTTfDmjhLYH5KVt6q?=
 =?us-ascii?Q?MoucgCgDC6ZvLJtDGkuLsCH78whXtzsWiUnXXuAn/hdMydhsWlwFJD6EGOVY?=
 =?us-ascii?Q?r1FxR9cyH+7gj6zzzfLh0TCkv6snC1PBC9YzrMSWO2bYL8W0rztC4dO9vRaG?=
 =?us-ascii?Q?j5tx4RwDQcL41/8V5GIzsSBukyb+HeGVur6DyL0YLDDeF39DkQvGGnqO99Vt?=
 =?us-ascii?Q?Uk3JNC1I+RSAW50tdJADA3W6JmCdXk2Y+oHv0cBLkyXm+20eBSbxEx0x9Vu/?=
 =?us-ascii?Q?ylk6VYaWNyRoH2AcVIDJTMNK9b3CSA9ZgbbSok/wA16pEJrOEfup14lorDKA?=
 =?us-ascii?Q?czFQ4VB/oRzCqCysFhwo4UtrN19IQuC0X4xSF1mzh82M5tUZOij7uFALYUFI?=
 =?us-ascii?Q?04K1NKjNr8tLrbIDbEd5bsDCgmmgT4pq2fUXqjlxcblz+XEGOOlRaS7U+reN?=
 =?us-ascii?Q?hVMKgxzPajfCTPr1oyV3fF4r9xAAaGDV8wahVgD1yDqGfKSMXEo6VpUkDLtd?=
 =?us-ascii?Q?Vrb1VYtus0/LVdms1bc8GnNht/ry8mLbgaiBeDf7qp6or5yyWRiNc5tGcuat?=
 =?us-ascii?Q?bfA3moIitMb4sZDPwTjvBF6/vIfGuugwrwULj8oY8EHbH5wfNrXLF5hiJUw1?=
 =?us-ascii?Q?XV1IUiCuWAOl4eKQlS8WJRcNXLjdvrzuYtr4RME/w0ZBqHXmyKcoLvwjqfOx?=
 =?us-ascii?Q?bzr49yrDvtISGk8xc6p/MZ11meKnP6dgMShcox++Q8vp6GBKXSEoa06S7C4L?=
 =?us-ascii?Q?cKLi9yHiWKIM3BIBapiDyUjJ0cLzvZWf72/sKpj3aOh1YINDjIudwCe1B/cE?=
 =?us-ascii?Q?lRQSMbos48satrbez44Wo6oQUzD+a0oiVWap80GFjsOV/hVjwJtc6qgttuhl?=
 =?us-ascii?Q?xjZOp7OQ73nqB46jQJk8jly2jScK3TIknoDdsaPUqp0K6zjpwcXGKwixaMUB?=
 =?us-ascii?Q?FEGn+GJwz9uTPSpc/XtXLqar6WtzPy2JdtWf8D+hJXoHqdEK8WEYmlD4kb1F?=
 =?us-ascii?Q?/KobHA+qQbJFFF2ehDVTElKexqYrXhf3B5fki+/IgxuVyuqvUO56DgZZPp8m?=
 =?us-ascii?Q?I3aAWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:21:46.4826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febd3ff3-7385-4378-c073-08de5399c6ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

CXL and AER drivers need the ability to identify CXL devices.

Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
status in the CXL Flex Bus DVSEC status register. The CXL Flex Bus DVSEC
presence is used because it is required for all the CXL PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
CXL.cache and CXl.mem status.

Call set_pcie_cxl() for the parent bridge. Once a device is created there
is a possibility the parent training or CXL state was updated as well. This
will make certain the correct parent CXL state is cached.

Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes in v13->v14:
- Move FLEXBUS_STATUS DVSEC here (Jonathan)
- Remove check for EP and USP (Dan)
- Update commit message (Bjorn)
- Fix writing past 80 columns (Bjorn)
- Add pci_is_pcie() parent bridge check at beginning of function (Bjorn)

Changes in v12->v13:
- Add Ben's "reviewed-by"

Changes in v11->v12:
- Add review-by for Alejandro
- Add comment in set_pcie_cxl() explaining why updating parent status.

Changes in v10->v11:
- Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
  downstream port by calling set_pcie_cxl(). (Dan)
- Retitle patch: 'Add' -> 'Introduce'
- Add check for CXL.mem and CXL.cache (Alejandro, Dan)
---
 drivers/pci/probe.c           | 31 +++++++++++++++++++++++++++++++
 include/linux/pci.h           |  6 ++++++
 include/uapi/linux/pci_regs.h |  6 ++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..bd7ce41d0c7a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1735,6 +1735,35 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+static void set_pcie_cxl(struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+	u16 dvsec, cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	/*
+	 * Update parent's CXL state because alternate protocol training
+	 * may have changed
+	 */
+	bridge = pci_upstream_bridge(dev);
+	if (bridge)
+		set_pcie_cxl(bridge);
+
+	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_FLEXBUS_PORT);
+	if (!dvsec)
+		return;
+
+	pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS,
+			     &cap);
+
+	dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, cap) ||
+		FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM, cap);
+
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
@@ -2065,6 +2094,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..f8e8b3df794d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -463,6 +463,7 @@ struct pci_dev {
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -791,6 +792,11 @@ static inline bool pci_is_display(struct pci_dev *pdev)
 	return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
 }
 
+static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
+{
+	return pci_dev->is_cxl;
+}
+
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
 		if (!pci_is_bridge(dev)) {} else
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 662582bdccf0..b6622fd60fd9 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1379,6 +1379,12 @@
 /* CXL r4.0, 8.1.7: GPF DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE_GPF			5
 
+/* CXL r4.0, 8.1.8: Flex Bus DVSEC */
+#define PCI_DVSEC_CXL_FLEXBUS_PORT			7
+#define  PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS		0xE
+#define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE	_BITUL(0)
+#define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM		_BITUL(2)
+
 /* CXL r4.0, 8.1.9: Register Locator DVSEC */
 #define PCI_DVSEC_CXL_REG_LOCATOR			8
 #define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1		0xC
-- 
2.34.1


