Return-Path: <linux-pci+bounces-37042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58370BA1D2A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BC1C81251
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8D321287;
	Thu, 25 Sep 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EJkMo3NB"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F827322C88;
	Thu, 25 Sep 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839785; cv=fail; b=citePIEKOv8wQlkmv6yukKfa9otXoyMq/5nOiLAEXxCkhPI50jzQ9d3xg5ENRTBbX1kToPU5NETrYBngDbWqbuVRqHmJM5HTgRkeWr7sJL4Ml2THciGecsJpVrElP76IAHABYNeH+nsK/CJo2UXkp8zq6kImPiJzghDGnV030gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839785; c=relaxed/simple;
	bh=kE61+r2V3CsGx0Uf+VQSkQZF0t9iOfTkJGVSuD7hs8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4GDVqA7Jd1c8a+eQjP0kRyzzCJQULsIk0Hw9kZXB2xTQBlwGELoQkRxlLZBXjvgPeh07mmZnFXV139TvNKu36HVmGFGvOS8iqGeG7O9ixCTQsUr9yeIVSGkpaEg6IqfidHvcyiu3dvKzsr+sLyPWcBUsx5Av6qMGrAu/WRI/bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EJkMo3NB; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKDvmf++YQVBK0mqW2GYxYlGMzMVCbfuFZi63UdJMvtRVsm6Rihg9SoaHTbv5q/PhL/pA4opaDDVWWxI5UKrXFY/TNQJ4am7AFonF0YxRA9i6KP8vn05UOfA5+nJwrkosfbx5bEehYrnYvq/SjSSKfb5s+vwVSFNlOJdofwd22mDYMY+JVznKn9MUCDYuEhobksnP65QxHoqYu+z3Ypaj1PUtJOa7YX7cIdQJ53wn5/RBrUNohC/d26U/r7AYakmN8B1iG51soJ7bO1rieo2W/hIQBEZpBoxkQuWyDS4PdJeWs+JT/pOSpk59n1NsRXY1WfkPe9BJ9JhltDbKVSXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID5lZ7Lc2VLkhCUdjyDwQbfUHe9oHCM/jlPVaM5nY1Y=;
 b=eykQuTBIYljnxuwjxaJ91xrlsHNNIxH1RqZV3a+1RQSYIGy/TmcAelXEpZP57LyFjlcwr8TTT9WMF3KvEKj+QAxLuAHIx40BsSodigQpW4aV2PWUS0rQhmf6QNwyQSXfV82yV+K7MnLfky1FAnXe+S/iJgfPjb+rGwK3qeFjDYi3cDzSIFSurSkToxoYxuRSDTNCDW2h1ZS9SIGJCp2lgHhWykeNLtHnfp+wo4I2pzypjstgmFcnSn3mL34gEJQpmpsq2brQQZbVbCPSsqYYe0y5JvGziOAhtI9Y/m74OjZm2micyWvd/EuKPyhve5mdY0FjPAPtqPJ+dm9MuzHZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID5lZ7Lc2VLkhCUdjyDwQbfUHe9oHCM/jlPVaM5nY1Y=;
 b=EJkMo3NBg7GuCgcHD2eqBlcPvcX+qNdaYiiKc97HilbV+g0kt/goJdjJMjrnBQBhV+bcEaZsGHxQhZbcQkJJus8L0qVc/VIeNyJ2vGKTiPUDSSxY9G8vaMYNNu2+34FHZNEA1AeDn74zUvsd0+kqMiDH1lGZHRYSXPr0hU85GDw=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 22:36:16 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::5) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 22:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:36:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:36:15 -0700
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
Subject: [PATCH v12 08/25] PCI/CXL: Introduce pcie_is_cxl()
Date: Thu, 25 Sep 2025 17:34:23 -0500
Message-ID: <20250925223440.3539069-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: a8575528-e4c4-4328-31ce-08ddfc83f067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WfsZIlSqAOI3IfJ3sGD/2bZRtEIhJQlFDlBeyiXb3y5YrJmcLSbFKrPqqpAD?=
 =?us-ascii?Q?hiOjx8QOfB5YbqqlH7axG2fHzawXz/LrOXQ84jsFMbxfiIbxo28MqXn6LA5/?=
 =?us-ascii?Q?f30l9CRBiyfxvpi0x87GlwwYvhiodRQ7SE37t6dbbFGeoDp++oXBtcRyETP1?=
 =?us-ascii?Q?nF12JpYlzG9MUuy2hbw56PvGOQf44cxOgI6zf4UvVbzFG5IlTi/5x4VOO6Ax?=
 =?us-ascii?Q?W8DLzx0tjRxO9JN+YvMhZi4CcM09l8ZuQj1WP6nUhKhX63cHXn1H2VkodT8V?=
 =?us-ascii?Q?wGrjOMoUVwmmqp2wptQqfM/+2qm/jzh1XQ6jJ6BS8DW0GmvUTGXjsmkyf2t9?=
 =?us-ascii?Q?mtXWEOGpUa7P0CVOK2vgAHivp8fr1YhTFf/kFwHBgz0ys3+mqifVOfYm8GFB?=
 =?us-ascii?Q?/Gg3vGXxESiWYIzKi4iMcI6GB9fcZ/WETQgYjnPQREqMgIDQ7wdMLnTWlImS?=
 =?us-ascii?Q?7m4UqNbtHCbCbB8ZblNer9Yp5VWNmauQ3B/vqFI82rfrgcsGP5TuBHQ64Llg?=
 =?us-ascii?Q?tCK8eK9G2l35efNCwmkmzzHTtpuK549+kwrEv6VKGIsST7ILDmrJJibjiahK?=
 =?us-ascii?Q?dIP7u0GtdWVcCjXW/L7MvoH0cnFjMc5o2UDZ/yvSu/XcckQ1CPWC6YTShB1x?=
 =?us-ascii?Q?bBL2fjDR8s9uBHbDFj4YEpNNoD6+DHpyjyBUkwUfQ/SkqFODiieN42ExANVs?=
 =?us-ascii?Q?r3fsuuCsVVdomR1lYl9jKNzq1EULWI146cPIFVYPhuxXrd2KYV/OpqvVtELF?=
 =?us-ascii?Q?bAyOLJ8vHano7p+/0YwCASj8lWdzrx1Ev4EaSQ3+Q+KnRYPzS0gcd3owhLHe?=
 =?us-ascii?Q?NggRIGj2o0lOniyYLBwnRwqb1SIk36aDKy+l8mLmNyDGBxB1rIxiNW7K/21V?=
 =?us-ascii?Q?G2+YntVVE4aLwRhKqCY8Qgwq/Wln4YFUvbbaVJWIXeuciqaAdP9mwbIOIyzG?=
 =?us-ascii?Q?QdWMYlnNbU8Dqk9/roB5EGVoahMSido9EtFf98s0ODS/TLyhsJJ0OAIypGTd?=
 =?us-ascii?Q?gyUzHD65IP5Z85LkWB8jd5NRlTd4OZg6nC4pxjRPE4g5D283JGX/325Nf09J?=
 =?us-ascii?Q?hsl9sXKtJU2/E03MJjjB+7hX0T3afyf9jBk6s0BZzplEo2R85h4j64zp9qGp?=
 =?us-ascii?Q?R9NSq3aTnBzAMlT9p3gxqb05sc+sfPQuZYBlzHYMD6KcnOZJuLZXtwxXYSeX?=
 =?us-ascii?Q?DTeHAnGr04zGQe5KCLzZGmm/EoT7ZtOrlLARVNCqnBp4H1wT9NiJoczglh1B?=
 =?us-ascii?Q?aNo6TrT1/Y/das5aOcS6WZgJdUNVZ4jh0V1q7YQvooUel3wdTtHMBt69gFWL?=
 =?us-ascii?Q?BQ2D3MGDr3MZFQADaTdqom2J4yXf76+7G/NYRUPTXsUN+Y7nmx6UV83ItnhX?=
 =?us-ascii?Q?BSWxBJ8+HykdvtD31NiFx1cyPl1oviJcncG0UJ0qM0eSulJR/3nrPaMAUht8?=
 =?us-ascii?Q?vEYG5XRXFBwV94S/Rvg+e67sr21VzP0Y49rdG7GYMXC0yOr0ThbZVQQYToHM?=
 =?us-ascii?Q?6dEpWPzxDUEM58rJ1nXHYehZd1xDtzYCdbyC5Z1rY+GaxrqgI1wp4V3oBnJY?=
 =?us-ascii?Q?2dMliAndvcBSsWE8mDaZuA+o/F7mMAZqOdBPxJXR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:36:15.9430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8575528-e4c4-4328-31ce-08ddfc83f067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

CXL and AER drivers need the ability to identify CXL devices.

Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
presence is used because it is required for all the CXL PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
CXL.cache and CXl.mem status.

In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
the parent downstream device. Once a device is created there is
possibilty the parent training or CXL state was updated as well. This
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

---

Changes in v11->v12:
- Add review-by for Alejandro
- Add comment in set_pcie_cxl() explaining why updating parent status.

Changes in v10->v11:
- Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
  downstream port by calling set_pcie_cxl(). (Dan)
- Retitle patch: 'Add' -> 'Introduce'
- Add check for CXL.mem and CXL.cache (Alejandro, Dan)
---
 drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca7..0a9bdf3dd090 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1691,6 +1691,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+static void set_pcie_cxl(struct pci_dev *dev)
+{
+	struct pci_dev *parent;
+	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					      PCI_DVSEC_CXL_FLEXBUS_PORT);
+	if (dvsec) {
+		u16 cap;
+
+		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
+
+		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
+			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
+	}
+
+	if (!pci_is_pcie(dev) ||
+	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
+	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
+		return;
+
+	/*
+	 * Update parent's CXL state because alternate protocol training
+	 * may have changed
+	 */
+	parent = pci_upstream_bridge(dev);
+	set_pcie_cxl(parent);
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
@@ -2021,6 +2048,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..53a45e92c635 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -459,6 +459,7 @@ struct pci_dev {
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -765,6 +766,11 @@ static inline bool pci_is_display(struct pci_dev *pdev)
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
-- 
2.34.1


