Return-Path: <linux-pci+bounces-40158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFACC2E857
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482683B9833
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5B42A8B;
	Tue,  4 Nov 2025 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kS0TE/P+"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5F42A80;
	Tue,  4 Nov 2025 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215038; cv=fail; b=Sm2Vxa7Ab4YV8zaKutAZ+cc8yMM4sVuXGHREx7SXYnb8Mxz0QRRbkbpld5VyHgZiq0rPqiOKpVs7Ixo49RzTK7tXAOslodub+vqdO+drN79Q3CA2CQEASYOWu8UeZDBWBuhwH+EAIiPyATMaG0mrBMgaFQENFW6ddYPGmAHldZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215038; c=relaxed/simple;
	bh=YjTnPAaZRcASf1PIPvV97zwtPsElk+KMkf1ygXH7jSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvffCk9QGBxDmqvVEctOwGLAPhxFTC2RDyqhudTidAN00/ZNqTn3RW94T1giCG3Ne1jAieV1Rs9ab3uAr3Udd8EwVWTOBCFFfwKPC+5NRm2/OKH39jveUFNuwYnuM0nKCFHaUoV42++baTGqi/Ynn5w/2DYBGnD6gZlm7y9ZUTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kS0TE/P+; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwY1GpaVLqlejBykN4ne/jJLbDI6N1P4MMt64m06xactk0QSZwjQLsrithH+MCE8b4a2Uf/tK6FhLHVSgW0jn5qfsmVR+P1V+QUkyTeBVoH7GMQFjtoY3acHDwPCOonwdJ1awN9dXMtH0zk60juL6e3LGEdXZEm6z6uFSjGh9q7BGTE216SSj5ES8O7qR9kJaOfMyANLvP0Tji0vxGEtzhegpUz242z7HpiJZdwKReVB3G3wAOZtx7gltNp2te5NXZOXyVvE8CeQoyn9umUgZNTe0LKPB27VnrULn+xOb9zckyTyAgyH7oQf16LGI1eO0Qd25Hno8OPgsKQ7mbKzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvqNzQsJ6B9iXo+8j27zQ0Ze117L+Fbgx0KgynH0z+o=;
 b=FcAb3J4ti2orAtPJeN9ztC8AJogldgiZuYeAYjpBAGOVA/1eQiyumtrUHgJywDnqH5tSEhHvqSDU6R85HROKS/1AVuiWOx3rnDwtE2VzgV7BDwCHQkv21zmaR1EB1Uki/Z/flExmPXeOFGaTCfyZcRMNn1yZyhC4xmiibUfizncumcVzGKnKaad4kZfxgnhbiCrlDrYZe6KmUe66/lugSMm3lDQh5LPAUrvJKLkP7ntVUUE4Qh1x89VhC7obHMZ8FVcLazLsEg8bfa2td9zWXeB2mY9zL3mDia83i9cMas+5JSBOy29s3g3yUoJ6Sup3TlVGzqrgyvtKqYhNJVjLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvqNzQsJ6B9iXo+8j27zQ0Ze117L+Fbgx0KgynH0z+o=;
 b=kS0TE/P+tPNxrnpKdtSMM+EWbp/5m4av/EnHcw+jt7xSVhXpuv+HOWhERZqnWHMqxxG9qF1pGnFPCk93Fj6EfGIh91uDtQUYvOaXhcKKBi7PL4ZAjHHZGkTB4ZJt/DnKeh2wzMsINTM0ndg1QV6lhiIAiiIN0qmO4G+Ea2rR+IQ=
Received: from CH2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:59::27)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:10:30 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::8c) by CH2PR03CA0017.outlook.office365.com
 (2603:10b6:610:59::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:10:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:10:29 -0800
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
Subject: [PATCH v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Date: Mon, 3 Nov 2025 18:09:38 -0600
Message-ID: <20251104001001.3833651-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104001001.3833651-1-terry.bowman@amd.com>
References: <20251104001001.3833651-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: c3007926-e1c4-47ae-4735-08de1b369085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSgWR6HjDGOqQ+E3i8J2MC6aB7OI0p4BpS5tFXg133/Y00RDvzzpnDI6LI2C?=
 =?us-ascii?Q?GayBpfJHugfVm3ejsKm6Ofw7CA/qaEclYpXkwp88SNDoMO6niuQum54uSPGC?=
 =?us-ascii?Q?Cixfm8U+qycJsku8qJsTziLNiugkoVrmoIimYXOWpbljHCD+zBqs8dPYyRZR?=
 =?us-ascii?Q?G0EeyAFWI5RM0hhd9XswuTlhSZzibaxDQ21/9e+PwE2vMEdqn3AD1nUSPI8p?=
 =?us-ascii?Q?ShoB/OuBfUN91aawVBRbelj8D5piMteLRFHnfSxYV8FVZoXXgRNBXYDnasVB?=
 =?us-ascii?Q?vH2+kobwphBsPnLwfniZ4D2UM4qTz/T35CnsH7w1PXnFZCTE/BpYT1jbBQ68?=
 =?us-ascii?Q?q//uawMk/vsce+vNcuPlrRfuH3Z+smCkxPYLYsOETbDPI5Z6zxJjEPH5bC6P?=
 =?us-ascii?Q?Q3CeRgMYIaqPfebBWTyJNmNK0XD/4wboFc2pyEXUZbvZTK9c3uEDOjUFUyj4?=
 =?us-ascii?Q?MuW7GffyzC+UQO1/T+fTMzg9g6wcmVIJkyJYtn+P/reJE6ZCtJIfyLpMSXGC?=
 =?us-ascii?Q?Fmz1e2ZqqLZDGbksl09Fs7FwxKzLgkHDpTxVpRa50G2CDFynwoDBiXZOxXRX?=
 =?us-ascii?Q?/+IWDviKIeNNRxTl//wmu8yzbMgXwRY6cRwcZPQMZxdD9Gd9AtL37YWtpTZh?=
 =?us-ascii?Q?+Vsuw4u+/1+w+UshTdoSsmorqlgLF2+40un2+6ZpWL/DnqDAjIt80pBvYZBW?=
 =?us-ascii?Q?yp/tJcnf2p+7JXxcfBH6aanD+KoE17YbKZIeA8bn8ZClrsL5kIjhSjTgTi3y?=
 =?us-ascii?Q?amIMHEmEc4anc+Kgw0BtHU5bGz3nu5mKaULzHRO7jZ1E/LoqzGhKbTLsdCdS?=
 =?us-ascii?Q?8kDGihsTFmfVPa8Xsxz3H3CEUop5JvqIcSb4yZ5iPgJYFHuQafZAX25kWBo9?=
 =?us-ascii?Q?CzyYgLtZcp8Zw6QQKZV4ON/6Fm1WmCI6Vz3+8oXYYoaZUteEcK8EvZDRWtfU?=
 =?us-ascii?Q?7Xl1HwHmj0UJz041pnnyU0WsiVJJaST81ls5dIGhm8jfzftjYeLV7VVHzGSl?=
 =?us-ascii?Q?Cc5OROx0X9Ab+80QqGrX90cfnR0sBqKZ9GiguhE9NW5Ma+FcYkh1RVes9n3Q?=
 =?us-ascii?Q?0fNRljrIog1XqfPPJCFBIKgUpGOUu0YpccmZTdY8IAh7qPJtVIW6cJS7/Ga1?=
 =?us-ascii?Q?338scxJxbCdkO+FprR+Wm2c/CtyEuBdMFcRdyZMKVNtsXV4xnYNdjBim6+Lo?=
 =?us-ascii?Q?tO5/sNgOhT3teTj+ZE1Dwc839AT4dG45n49ONORKnfRmaBlPGnFkYJ4foftM?=
 =?us-ascii?Q?bcmkCnFerga6Ol1XxQyQY5WLG9BPxZ+Ogxi2LxfFxgJwahclSpSYGwcJ57IU?=
 =?us-ascii?Q?MzKSFWlnJhqFPHrMLc4Ocq0bRqdVteKw7L7Afnx4sxqMRnNJGHRwovEFTyYv?=
 =?us-ascii?Q?tIX7Z+4a6s1sYIfGSuWhzokZO0rk38WKfnTNGencRCjxt0JBKHhiD8/bivlK?=
 =?us-ascii?Q?6qu9wm67YxR9CEG65+sfNE4umG4eKfEI5xhQuiohcmZmb9tm2PdPBEChoNIg?=
 =?us-ascii?Q?5iX+XVhPWG7Sy33A1WT/lTf+5zSFLdZcKIVgqCwmfYtC8HRNlCqVgMPKX5Lf?=
 =?us-ascii?Q?CRytwvWC6Rz1agJscEHLhyxvi4ZSuAg/uW4qjSrQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:10:29.9489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3007926-e1c4-47ae-4735-08de1b369085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

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
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

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
 drivers/pci/probe.c | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a8..63124651f865 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
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
@@ -2039,6 +2066,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_cxl(dev);
+
 	set_pcie_untrusted(dev);
 
 	if (pci_is_pcie(dev))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..5c4759078d2f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -460,6 +460,7 @@ struct pci_dev {
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
@@ -766,6 +767,11 @@ static inline bool pci_is_display(struct pci_dev *pdev)
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


