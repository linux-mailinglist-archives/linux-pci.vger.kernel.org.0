Return-Path: <linux-pci+bounces-34824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFDB3771A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C361BA0FEC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3521D5CD9;
	Wed, 27 Aug 2025 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MteTdH8x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665542080C8;
	Wed, 27 Aug 2025 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258641; cv=fail; b=B0HWjDVK3iBGHFz5IXrAR97EA4ZGSD02h3Ca4G9GfLBTPYHh1rW3P2GqVakj9/hxBvdAw/c2+3NOOeSQONRL0KvilrNV+2hO7F8kvt96MFeCerul1pjjKjybxvvdJl9tYSYvAex9PUuOiVUxv0JPsqi4DUPM0euA9qSJcgbR9Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258641; c=relaxed/simple;
	bh=wHA7C07fpcdPlSUnobRy6iL0ihYkflWrKDKdFbkVrs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvH17PJmVzPxntHvpF2KeJiIi5FwBS4K5sIaeUyxeOE4puyn69wPCOAq44DukUCDF9NFn4hZH0/6B6iy1tNvWOhj30mycG/T0CkJduEI1an9D2cRcO0aRHIfRjF+ZvcBjrfqLPuSeNtbabT+PwiGGQAiendvEzFTR4yW9yLEu1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MteTdH8x; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGWlVLWDFB1vCeMtETFy/ntbldpjKMJxeX5+GJReWa0HWOApaTBZx3csbDPvoH/dBjldhgImvYtvi+4D3M0OIEST1RFERNdw+U8kF4cPJqhCBniAX/M1r1HDFCm5xlJK8+T88getRDY8y+uj8BpeDQQHxpZ9ncvnAQqGu8PnmwOBZv/FWjCpX7faXkNqjX76SW4cGVIdDDruAT6RI877cqJYs+4N//3H7YjvLV62XYcfYNw4g06BWydVPkE46lMwcxg5IM9qKK2hXL66XEb/i6+MrQJzTWT3YWITO51fHuGuO2399uY4Nrh1DGgTPCFFf5OGrabX4zFF33CXw1rPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKH2vhw9zOacSG7WJj9/iwqt3bIMlKvOSsBbgbldlJo=;
 b=mN2L1W3CEr/+LnGorYbrMRxb+uRH/5nCvNlhtCSohmIRo94x+rY/UwxkdDyWoa63GJuIVOTwmXN3loGPzATT/9ULRMVvG2NummXTqf76HSoWQnVB5RNMb1ehhTGrchNMjLwuMq5mTnT/Grwob6OcUX9eO9G41Z4cv89WSWL1/ck2+KMjkB2QIU3lgtJkKlKSr52cI0eiwZN5N6fmPm3wDdTnXsgW88jRkCcROVLQOigztUTjV7AkNcF1J5j344s+dN5GYZOa4y5pZE17oKcTRPgy79KBHHbZisM53hCZIGgWdpwGpG6lNsLbyvqOom+S/8dr6V6rpux7h+dy9Ak98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKH2vhw9zOacSG7WJj9/iwqt3bIMlKvOSsBbgbldlJo=;
 b=MteTdH8xe7ePpvBwHT9kkoESVAHFSrOz61GNWTDit5O1olGPYBGISVUAVmRO00UYX8u4XOoBJKeAutt2Qr8oq/3bidSpnGg0bXOGEdSmW20cdsKg4isIZUG/d8J9hvaOm2xHtkK0mtj/6q5qHMIkzJ0iXpgnegi64OhIrJ0vcRk=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 01:37:15 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::63) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 01:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:37:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:37:13 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 08/23] PCI/CXL: Introduce pcie_is_cxl()
Date: Tue, 26 Aug 2025 20:35:23 -0500
Message-ID: <20250827013539.903682-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: c1672f36-a613-437b-946d-08dde50a4037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DM5otc0aGeCzkYZ32z7gTSgecA+zmrXa3NhZkf2Qtn8K++C6hBCM7djzh0i?=
 =?us-ascii?Q?EwbGfq+7QqbKehtrX6g02DAlOUk91/WH+HSMEDrktGnFs2i9Z5u4kxON5QUX?=
 =?us-ascii?Q?3vAqCwNmdQy5DhvDlhGRbhSfH0y5WcVusPTmbYs5iHeKQKKjLuDidhzl0wi6?=
 =?us-ascii?Q?LJFCI4UZNBPGnLxDQiQYJPP4hm+/mYxIVZ7kw6mkzVrz5t0rDh9lNlU9H9Yj?=
 =?us-ascii?Q?oNMGZNvojRZypuLBDaGTpPrpmuwUoux6Eds5vrQm2YLhMwrq/nGw7pN0c5SZ?=
 =?us-ascii?Q?NyunE2RcA3fC0khYUG/CPT8zhOpLb07ATRDJWOrsj68YUCEm/H3D7HZK5+HI?=
 =?us-ascii?Q?rJlcCLHxv2tFfV0T5+5xD3J5ReFBLBpdr8S2saG6fEWs57yOx2xsnWpYvJOO?=
 =?us-ascii?Q?IAY0NElQOi6EK/d07vkfRCLHXOt+VuiyC/CT82uSUhewaLZ/Ddq1UObkZz52?=
 =?us-ascii?Q?aMlVckuAWrC+UPnkGDn3CXLn/RU7Iox7MymP1zexB/EPnYosdNgnAIxr+++9?=
 =?us-ascii?Q?ubjG72UdjBV582C/691IMJqEIGxX05vxXwNdVkUCZYvWiwyW3eNBu2XnG42A?=
 =?us-ascii?Q?vi0Hh8IYV3Bvr3JQ6q+Ek6Ia7SW8uKEC+OoQdP1mWTvSqKxMFjoDL4zzE82c?=
 =?us-ascii?Q?TQ0gs6v6yyeme0S8KrQgYPQ0+iXp5vlkijdUPkXWBlDEGYzl8QB6nGYL8auK?=
 =?us-ascii?Q?aIVTOS159xUktcA/3ALJPFfxPjFYSFv0+f1ibmN1L2O5OyvuOcqb0mOq6m8b?=
 =?us-ascii?Q?r7yHKd3UitNeRd5tBjrGfJ6lo6GEoNwmNjvPl0yfuw1JgomyskmrWHMHvQgf?=
 =?us-ascii?Q?Q74a/oFyKpQhJk4IfKa/0OQUfw/JhfzYvij20JRulplCu+ktbq1mWtoDi6/e?=
 =?us-ascii?Q?2weVHMVgOwWTUFbuHG0sNFbqrTlfHDPdOsdAc0liA/wrjTwG5yXuaUIl7m4x?=
 =?us-ascii?Q?WOXYGlrHnJuf+TH0kX+Le1cp9I62XhfoBbi1K6ojCXbcJPMqkUFOXJWVr/hi?=
 =?us-ascii?Q?ZIYFZ8CRMhXUbCqknro+Ld8CgCiZPYHvgcmmQ+au1un5/Oy4LiQ6+Fwx5VnC?=
 =?us-ascii?Q?T77dBnZm9XJlsuVldPz2YPtxBAajopdRVUb+NKdY1L/kmkmNoE1kxSGZWcJ7?=
 =?us-ascii?Q?SgwrNv2uAtNKXatH24tAV7zVAcbCrE/YH8Ar9VPPlAGagGlJpf2FMe0jPoa5?=
 =?us-ascii?Q?/vMmlqsHKcaET+Q61fx/e6XnkweuNH/lUIw6AeexuFAg9cOSrgcT4W+KMn1a?=
 =?us-ascii?Q?EP/ApPsnAHfh9VD9sVmMBjTolRVJ+JnFxvq6ef6vhsbPP/DjSdoAYlesnHfN?=
 =?us-ascii?Q?bq4GT+CNdcr7G3yZoIk8/mmj5LYHw4xGZlA2ZXUIFASHKTQrAjU8vdZd6pUz?=
 =?us-ascii?Q?6pvQ/1UgiETNrCLnCofA395ax4C4SwF0nx1iktLPnS+/PM72XkWKpP3oJ7SF?=
 =?us-ascii?Q?1QpjxB1VTBl0uNGdF1O71GR2fmy07cljXCLouhJwjEuWoXKm7IghAqnQgsFO?=
 =?us-ascii?Q?0biOCJWsJjsILtZkp5aTG6oFRKaax2LBg7qQyFjTGt4SI/wxVKwMcKlQCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:37:14.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1672f36-a613-437b-946d-08dde50a4037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049

CXL and AER drivers need the ability to identify CXL devices.

Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
presence is used because it is required for all the CXL PCIe devices.[1]

Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
CXL.cache and CXl.mem status.

In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
the parent downstream device. This will make certain the correct state
is cached.

Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Changes in v10->v11:
- Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
  downstream port by calling set_pcie_cxl(). (Dan)
- Retitle patch: 'Add' -> 'Introduce'
- Add check for CXL.mem and CXL.cache (Alejandro, Dan)
---
 drivers/pci/probe.c           | 25 +++++++++++++++++++++++++
 include/linux/pci.h           |  6 ++++++
 include/uapi/linux/pci_regs.h |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..b08cd0346136 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1691,6 +1691,29 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
+	parent = pci_upstream_bridge(dev);
+	set_pcie_cxl(parent);
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
@@ -2021,6 +2044,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..79878243b681 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -453,6 +453,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -744,6 +745,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
 	return false;
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
index b03244d55aea..252c06402b13 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1274,6 +1274,9 @@
 
 /* CXL 3.2 8.1.8: PCIe DVSEC for Flex Bus Port */
 #define PCI_DVSEC_CXL_FLEXBUS_PORT				7
+#define	  PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET			0xE
+#define	    PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK		BIT(0)
+#define	    PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK		BIT(2)
 
 /* CXL 3.2 8.1.9: Register Locator DVSEC */
 #define PCI_DVSEC_CXL_REG_LOCATOR				8
-- 
2.51.0.rc2.21.ge5ab6b3e5a


