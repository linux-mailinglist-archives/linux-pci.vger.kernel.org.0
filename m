Return-Path: <linux-pci+bounces-40234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B332FC32375
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC07C4EC993
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161E33B6E4;
	Tue,  4 Nov 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D9LDLdH6"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B033A03C;
	Tue,  4 Nov 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275819; cv=fail; b=HAlZhknK0FpmXM463Tb9sDzP0V4jUbJHB82flUnNE0838B+0CQdeWL9XIzzV5j9Gxim9Y6TUMyBy+xOAP631PDbZcKS7w/FoQvi0wZh263oWmrrK6KDWH77r1nOwQBk6HwiDgmo7lPOjc43ZGvUwX5CxdxIegjLga025e3Eo3T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275819; c=relaxed/simple;
	bh=YjTnPAaZRcASf1PIPvV97zwtPsElk+KMkf1ygXH7jSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNcku97/Bo0LctFKAyxEo/0cH4pdfmMkZ+3KGMwiZPnez3w+YwnG61B6Pw6dxH2ODQdozhrn8xDTyH6au7xSUAfPDVxzR4WwkniRxJsogi7TVVohmie8PKqIcbfrvFayS8oOMB0Z79wXYJgyCSJWInuyvajeHey2F7/+d9mFON8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D9LDLdH6; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5RJPZwGpY9RDmfns8FNi7UMJBXpnw6K0r3IFshLd3y24LNzU5uKw8yjci9N//JZCHErF34WkOYgxt4MVOzAQJieVoIsad0kbOzaQXIFpO+Xis98RBKxTHpUuJtXmcGKDwYHq+3DpGdmfwNWvk4ZEe4WY34bJk42BwM2tpZSyUACdxwN+EmX+TfmAz16w1IjSx2NxOURzZUS+7hImAdObNC31h1gyYGRlk0g+WM5njke610G6YA3SMFKAPKROYgs/izmRXmz9aZwHahbA774YJsfQXhZ5bE5RbZhoV9+40q/gO/djojRiZ7JtLzssEifmhu0qiMW/CDMAMIWJdlzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvqNzQsJ6B9iXo+8j27zQ0Ze117L+Fbgx0KgynH0z+o=;
 b=sFYvv2bfVUW7l5kcu5irKBSiDHewUB9IYje9jvgFqN6fu2eU5BPiS/+m1mROG7c11nGrVSpFp481DNxVFMsGI7AohmhFD7BxjcBdENlUnMSPfxOhP53BRhy2MiIYAf+TrTm9Aan5ct+qGic5FimrVPHiHN8FimegiAs7VyEknsmMay8ERHQ2bmRhDd7Gi8xb7P4n1d+CNDsCntMoW9TwJUhxRVtfFTpXx7KW0VHsuO6sjEruzcCVtUy9B4sRnk6pMCfR7AxI7ZkyqumB75BrnJVZ8H3iKv7bs8qdPHp6Bw7KuH2Q05IAC2VTPl7bdfU3UJ7j7iAovQmTUAAWF8Fgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvqNzQsJ6B9iXo+8j27zQ0Ze117L+Fbgx0KgynH0z+o=;
 b=D9LDLdH6RXI7b7TmCeKuLApihDfy6vvDrWjWfoAekA5ZoKms6LkJZhPzU2lJI2qqqm18TuuEURKURKVRKn0Wk1ZNyKzNIwYEn66GWnlyUfLx8S9Q9oZS/8vsvg4R/cRvU8AXE7km8Xj0QQB4pYVM9WqWeqZDF81RIu1YJdo4NO0=
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:03:34 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::9f) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 17:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:03:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:03:33 -0800
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
Subject: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Date: Tue, 4 Nov 2025 11:02:42 -0600
Message-ID: <20251104170305.4163840-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 156d7740-001b-42dd-a532-08de1bc416bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIoJ9jbCJ2J8Oq3Ao8z0fYmP7iCszx9GDA4k/D5QtioKFDgC+409r9mUC8Qb?=
 =?us-ascii?Q?2bsqeijYokOMBiMUhyXYUBc9uiPmGW+iHdmO2MMpXzvSLe0QabuJ98R/yLm5?=
 =?us-ascii?Q?mh7xjFgvkN+D3R62AknejTOPZ2EOZGpfUh26IV6X9wvf+7nthoOKGIouX1Gs?=
 =?us-ascii?Q?KdFYnINzyvZJuyICUS+LLvFHvo6UnNkOXJX1605WxsxBFLciTgB/2o/wDsQO?=
 =?us-ascii?Q?qyNHS3Futuuf4Idp4vb1AwAb3Eh/mpV2N4JbWi/VFlG5O8Gcr6cIUV1UTEOb?=
 =?us-ascii?Q?DH8BBwyfSOyGwyvF0HztEl4ZpZ1L3RhgjJPtSP4DEEr6XrHzSK1kl/13G5/w?=
 =?us-ascii?Q?imciaS6Gr9W8gpWYh57dwmvNKL3d/hpdcqP5OPHtvZIC/EzIM05fYR3wlzIl?=
 =?us-ascii?Q?RhNc1wbOZriiRFFwJRMuzoxaQ7DHurI7ddYBcPOu1PN3LdYhcvTkFvOtwvhl?=
 =?us-ascii?Q?R7PsqacvdS4YNZ999UCDx8ChHfVhqtWRJxHm4+R3aJa4nFI9kEWIRQlPb6RN?=
 =?us-ascii?Q?Bd6IEGGzjMGN1THJIz9Igin/szcfl8zVOfY5aUiCFIq340cjUi+O5J8s6UOx?=
 =?us-ascii?Q?RpYpk8qtzd/rnCguTdehbXv+Sr8QccpBCNpBeD2Xnox0ekgCrATBoWqv85Nm?=
 =?us-ascii?Q?aTsE/ew+obX1XggsNjuUJtwlG6S+YnKpmRas/aSJlcN0c1OAfE8wikIOnk4m?=
 =?us-ascii?Q?U1Re/3E99XGhPevThZzkDpEum17wotOmb3G1jkOrSkxlN8sNaERrio29Tb5F?=
 =?us-ascii?Q?AR0yuiX7RIoJG1WSQt97faNa0Jf42ecaCn7Cp2zch+SBL+NLWnhFnBXqsnnB?=
 =?us-ascii?Q?Fe1PSKC57FhTeFobSGos0lJezjhyU1O43DyY3acLLntF8z6rcX3sjm6IiZ/Q?=
 =?us-ascii?Q?RQQgda9IYxq0sJ/nOTXFNyVuTy5LDSBoRBKR95bI1ycQLYeQI7QRzI5YjUiy?=
 =?us-ascii?Q?UwAiGXUB27D25WNWV224oNzkaxVL+L5ovKTqEWHLhRcTb7yTNa0xmbYBj+aW?=
 =?us-ascii?Q?RPTSyjFhWLXbGpi1Cg2ZMNV2gjwik+8jgatx5CiT036BF7csV1mUSrdGnppx?=
 =?us-ascii?Q?8uHuT8NCEc6YVWQHES83tE0/HqpPyisEA9z7MKHUdogh7Tom3jeTXBaW/Qmr?=
 =?us-ascii?Q?hahcXbpkVly5OQQ77WLcUljImFFomArq3un+8EyWDRrQ05RI8ApRg44LPAy5?=
 =?us-ascii?Q?r2TIIrYuj5+Y3fQmDkDFBwFIAeRugkvg0pfpTohVIDuwy+pfYVl7larmW1LC?=
 =?us-ascii?Q?SUGEgWJB1uYDnWITW9Xr/XFc+7EysKfDw59sitTEqpBA9umQ5FsLDh0lGhV/?=
 =?us-ascii?Q?OJIONVZ6qSE9w90vNRnrL4xPTvSUXrCvl+5jfiNuD6wGXNEUWKobv7czRPHD?=
 =?us-ascii?Q?gwBNX+SlwqVGA4PrqIiIWcV8koV1eUllrfKfiMe3h37PmS7hDfysFB7KeMff?=
 =?us-ascii?Q?ONC09KsjeLyS+k5U9PP/aFuaW9LcWy9NU8PHKwKnHlRhnM64dtWbR+FZgonG?=
 =?us-ascii?Q?P2krtc5ytd3ujxFdsEqjLDv3zlsTGgrVnAIZB9u49PWwebLiZgIJDYs97H3b?=
 =?us-ascii?Q?c9MNdTJegsqdAuQcOicZsXjPOW2V3acbayQFK8Dq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:03:34.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156d7740-001b-42dd-a532-08de1bc416bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

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


