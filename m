Return-Path: <linux-pci+bounces-30989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15DAEC5A3
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 09:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9F93BF217
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9832248A5;
	Sat, 28 Jun 2025 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ffaoo6QW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4504223702;
	Sat, 28 Jun 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096591; cv=fail; b=bhTn3X/vW2VKGT1/zI1myeUNTSHuKUyneWnU/N9D+tWDlVPHTR5Oo+8ImTPcXl35BbFjP5pfmcwRGQ9jGHzhHFQGwmg+eQTA8cpKBxNMi9+bTcoTYmukq8kwI6/yXHuui7at76bdyLUrzHeeJ+EF0cgCjcOEShpOV0G4xKCXYgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096591; c=relaxed/simple;
	bh=y0Lb2eeJETGd7adfYgujEN4XdEDwdQn7CxLYL5cTchY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGJHpUOS/NqZE2/rNKY3BOvtnzEKQslS/4LlF3bQL5cauPOlLhg0MkBKbAfdZJ7bC3XxqpWnpqdkwzSOQkNq4KO2qRwQlk0U4MBU73JsCnpSmZ6EZlv2yqda4epJBfmdSrnCNlRRwd4KLZWysBEq/Qgb1yggSGfZtQ4g7pCb7ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ffaoo6QW; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNySbmo69Z55vQ8qValWh1Rzz52Ge+cQ3D2lK6WK9T9ZWQerL2PXeeWNfCO8pz7KJ5gTeZrCmT+MZidjVwcXSeNO1SyeTqoFToPx3chS7g7/tlD5H8peAx7HdKazbYtPgzM3c6ubMZvjlpc4s/rQOK7ekYXdXtTa9xX1EumB9mXnRJPHE2/nctm7B/sUb2QSf4Eb4qJ9s5ddL7LplJQyuHmXPTTN5fjJpxWIW5eA3SD6zHEysXhVntBawSFM6iE164Qa2tlrrJF2BapnO2ar7rVH4O50+yLGNBX3HzWsj5KZmeLOITcRj6ssnkb7LZCucox9aCPD+qnyNynsP1EN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3he9eaivuTJOJxA9cvv0atC+gKGLtza2iC7DsHC2T4=;
 b=G/PVWab3HgKKcI5QmN1Gtp3QbsJNVpkxm6yOmPr/qeR8WU9k7S3cwXg+w1iD1rE/duBiA9SOp3mz3ZgEEW0R1ednxzioTmNF23tLvqhpteX02qFsLhmdawj/uAQnTNBUrDAp3hPy4s3VCx7b38hxA2n54EPA9bJwhVYOPKnJotmzxw3E2STV7w2A/i0lnRuTesBrnFQSIJmfryaHMTJAIH/+FsaN0eZ2R0zSto6fZVXzn2jbwYs0Em6j3fF+F82LhoFNdmKaVOdBQq0og3kA2lhJid4icent8RsbscXn0EXBAibKJfzV96/WK+cRUFVs85pzY3J2PKabTYiglm43fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3he9eaivuTJOJxA9cvv0atC+gKGLtza2iC7DsHC2T4=;
 b=ffaoo6QW9tmAzTRt2EJPGE4lvk6GDJPrvPZNmvP82xLbL3ZlJy/LdAiyzKjXZGlAf7wUxSXUZSq9ZLmj5fy8Ay2e4rVb+0NbJVaBwC0IJlCvp55eh+Z47wd2195WwDsrAVRvZNIrtoSzFhU1JSg38k6AeS9PmQ+bcugugBYgwjWdOpWeKOCtm9voNOaSTpfbAhrbST19ZRC+G9VddUDWal6sWhQ2kkqdPyg+Uzr40AkgrfrNMk2b4bJ2bHJEzSSqMq0RtG6VYehx10GiVO6L10xvAxgbTkzbUBI6Ekfsyxfj63i9Lc5XyBQDOwc7XY4fE7gYSdZjhNtlDKrwnu5buw==
Received: from SA0PR11CA0169.namprd11.prod.outlook.com (2603:10b6:806:1bb::24)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Sat, 28 Jun
 2025 07:43:05 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::5f) by SA0PR11CA0169.outlook.office365.com
 (2603:10b6:806:1bb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Sat,
 28 Jun 2025 07:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 07:43:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 28 Jun
 2025 00:42:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 28 Jun
 2025 00:42:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 28 Jun 2025 00:42:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
Date: Sat, 28 Jun 2025 00:42:41 -0700
Message-ID: <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751096303.git.nicolinc@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: cb056ebc-f992-48ee-86a2-08ddb6176acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPWzo7OesS5LCSTksMr+0noteUq7OGWgxYRh4wf2WnAOMYovsZe0mTVSk+G9?=
 =?us-ascii?Q?QaCA21Ydk9EkUpv10EtJihKK2bx3ZoY03xNcIj2jkBnCWTWHV9Xy/vJljjLA?=
 =?us-ascii?Q?+3XR9s3cvdtX+QZNwzx4XcglcUNxCB2m6mTUB9sYpMZjurkO8KBD1xKjBJpA?=
 =?us-ascii?Q?I6Mh6ryGKCPkLGBfsfW5BBkpiMY8SMJUrA+08SOJjIQFGdYCTjAdHdngbOBa?=
 =?us-ascii?Q?xUbPOrGQqP4++2d0d/bHJ5Q89/5desDnrj5/8a3yfnc1bfReAZvt0wGFxC0g?=
 =?us-ascii?Q?sCDZEvvgZZT2SetuzhLcMV9vlyMXXfHc/wUZpoP2aru1FPxj7rMsia9NZrNV?=
 =?us-ascii?Q?kR/ZegGrIhscdyiGGloorTZ50+uojJsNt/tGCnYmu+OBuokyAIcNzfLhhvzK?=
 =?us-ascii?Q?uKkiy2+U17s7BAL9W3SQDBDwiY3NRm4zpZ7ISlBM83sIrHuldl0M0dLScvXx?=
 =?us-ascii?Q?YvvEFTypvePWGe6UuF+RlYxt+p0QMCn4gBXdyrnb0LsJLfPsSy92xJCdifCX?=
 =?us-ascii?Q?nMQOWw1VV3g6Ef9V/REd3ZiV+6SfypUlQt5VbZ0ZXiclhpOGnuAcZYtb0V4U?=
 =?us-ascii?Q?m7Q74054ZlBIDeTry8FLLdCZWG1ZAIxGnuCYBcFLVHy/lSHXUTkdP/23NZq5?=
 =?us-ascii?Q?lbtSGtCQwNZXsy2UaGZYqjUXnArMQPceT+TPUKJs4kzNLzhKAop0XcN4DHSu?=
 =?us-ascii?Q?RKMJdPJA/T0qdgWiSC10GxH/d0/4dg/WGxcUWhh/W7mkn2BkFbRxPHVnSuPi?=
 =?us-ascii?Q?Ve+JSXrdIUFchWppknyVt8JwGgnm4JefswVL7L59DAVeEEMWiAJPRq2CNBg0?=
 =?us-ascii?Q?BxsyPqBDFdEdpC+ffj64W5hsz3O6XA1Q2rG7183Mtm5yl7o7kvy0LI0GsUd4?=
 =?us-ascii?Q?D7g5VTPfH9n4dI5YKbGLrAAO+ARmlGBQWFEnHRlzCOszG9CXSs51KoiculKg?=
 =?us-ascii?Q?cVK2i+QbWP1hbsIDMgnxbZ8VE0b0snoJCX8M1OQXRq5KBl3M1itnpcgr3ZNP?=
 =?us-ascii?Q?ToTgGseqw/jOEVDDraDvW6oXgsS+RPalBZzzgmpDikdUpmwcF7ssEJStEu/j?=
 =?us-ascii?Q?sxooj7ENNrz+mkRjoMENa7t6bZ6tYUBmn+JiY25kxDLu3QrO7Pr2eAmvwWna?=
 =?us-ascii?Q?lgsDpQCcU1gX6fCzuYp62SrrCGR3DIUOXGFuNiMFhpHMCGTT5XKL11WpdaWr?=
 =?us-ascii?Q?dEUETQfiRNADbtLWpo4b6SfvBugXVhiO6arGhWrBvBox9b9BZ/S1Oef5p4BO?=
 =?us-ascii?Q?cJqMBfRVexhZQZQeTMgraKPgx8SIUjv8Qc/N1rUyHl4jPPJEkW5fPrFzKEj1?=
 =?us-ascii?Q?iHmdV4MRW+2wx8S0mmSUZll/CtaEYkqPU3lWaiCBr13RGhIIU4vst3vHssRK?=
 =?us-ascii?Q?vORCCfT3t5Jv4hg6R+XowSMea7XfKMGCJhi7rKR26PscfCvQ+zDKybrwF2Gh?=
 =?us-ascii?Q?C7FoMDTjUC1RA3kphVx9fqoIrOjBzTMWw8DgIFXDk3VnfNuvSLT3zhCb/S00?=
 =?us-ascii?Q?w1KSpXdhuLpXylasTsGRV8GZnZ8HcEn77U/x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 07:43:04.7526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb056ebc-f992-48ee-86a2-08ddb6176acf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

PCIe permits a device to ignore ATS invalidation TLPs, while processing a
reset. This creates a problem visible to the OS where an ATS invalidation
command will time out: e.g. an SVA domain will have no coordination with a
reset event and can racily issue ATS invalidations to a resetting device.

The OS should do something to mitigate this as we do not want production
systems to be reporting critical ATS failures, especially in a hypervisor
environment. Broadly, OS could arrange to ignore the timeouts, block page
table mutations to prevent invalidations, or disable and block ATS.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
block ATS before initiating a Function Level Reset. It also mentions that
other reset methods could have the same vulnerability as well.

Provide a callback from the PCI subsystem that will enclose the reset and
have the iommu core temporarily change all the attached domain to BLOCKED.
After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
ATS queries, synchronously stop issuing new ATS invalidations, and wait
for all ATS invalidations to complete. This can avoid any ATS invaliation
timeouts.

However, if there is a domain attachment/replacement happening during an
ongoing reset, the ATS might be re-enabled between the two function calls.
Introduce a new pending_reset flag in group_device to defer an attachment
during a reset, allowing iommu core to cache the target domains in the SW
level but bypassing the driver. The iommu_dev_reset_done() will re-attach
these soft-attached domains via __iommu_attach_device/set_group_pasid().

Notes:
 - This only works for IOMMU drivers that implemented ops->blocked_domain
   correctly with pci_disable_ats().
 - This only works for IOMMU drivers that will not issue ATS invalidation
   requests to the device, after it's docked at ops->blocked_domain.
Driver should fix itself to align with the aforementioned notes.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  12 ++++
 drivers/iommu/iommu.c | 158 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 156732807994..a17161b8625a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1123,6 +1123,9 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
+int iommu_dev_reset_prepare(struct device *dev);
+void iommu_dev_reset_done(struct device *dev);
+
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1407,6 +1410,15 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
+static inline int iommu_dev_reset_prepare(struct device *dev)
+{
+	return 0;
+}
+
+static inline void iommu_dev_reset_done(struct device *dev)
+{
+}
+
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bd3deedcd2de..14bfeaa9ac29 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -71,12 +71,29 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	bool pending_reset : 1;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
 #define for_each_group_device(group, pos) \
 	list_for_each_entry(pos, &(group)->devices, list)
 
+/* Callers must hold the dev->iommu_group->mutex */
+static struct group_device *device_to_group_device(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *gdev;
+
+	lockdep_assert_held(&group->mutex);
+
+	/* gdev must be in the list */
+	for_each_group_device(group, gdev) {
+		if (gdev->dev == dev)
+			break;
+	}
+	return gdev;
+}
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -2155,8 +2172,17 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	int ret = 0;
 
 	mutex_lock(&group->mutex);
+
+	/*
+	 * There is a racy attach while the device is resetting. Defer it until
+	 * the iommu_dev_reset_done() that attaches the device to group->domain.
+	 */
+	if (device_to_group_device(dev)->pending_reset)
+		goto unlock;
+
 	if (dev->iommu && dev->iommu->attach_deferred)
 		ret = __iommu_attach_device(domain, dev);
+unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
 }
@@ -2295,6 +2321,13 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 		dev->iommu->attach_deferred = 0;
 	}
 
+	/*
+	 * There is a racy attach while the device is resetting. Defer it until
+	 * the iommu_dev_reset_done() that attaches the device to group->domain.
+	 */
+	if (gdev->pending_reset)
+		return 0;
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
@@ -3378,6 +3411,13 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
+		/*
+		 * There is a racy attach while the device is resetting. Defer
+		 * it until the iommu_dev_reset_done() that attaches the device
+		 * to group->domain.
+		 */
+		if (device->pending_reset)
+			continue;
 		if (device->dev->iommu->max_pasids > 0) {
 			ret = domain->ops->set_dev_pasid(domain, device->dev,
 							 pasid, old);
@@ -3799,6 +3839,124 @@ int iommu_replace_group_handle(struct iommu_group *group,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 
+/*
+ * Caller must use iommu_dev_reset_prepare() and iommu_dev_reset_done() together
+ * before/after the core-level reset routine, to unclear the pending_reset flag
+ * and to put the iommu_group reference.
+ *
+ * These two functions are designed to be used by PCI reset functions that would
+ * not invoke any racy iommu_release_device() since PCI sysfs node gets removed
+ * before it notifies with a BUS_NOTIFY_REMOVED_DEVICE. When using them in other
+ * case, callers must ensure there will be no racy iommu_release_device() call,
+ * which otherwise would UAF the dev->iommu_group pointer.
+ */
+int iommu_dev_reset_prepare(struct device *dev)
+{
+	const struct iommu_ops *ops;
+	struct iommu_group *group;
+	unsigned long pasid;
+	void *entry;
+	int ret = 0;
+
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	if (dev->iommu->require_direct) {
+		dev_warn(
+			dev,
+			"Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
+		return -EINVAL;
+	}
+
+	/* group will be put in iommu_dev_reset_done() */
+	group = iommu_group_get(dev);
+
+	/* Caller ensures no racy iommu_release_device(), so this won't UAF */
+	mutex_lock(&group->mutex);
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->blocked_domain) {
+		dev_warn(dev,
+			 "IOMMU driver doesn't support IOMMU_DOMAIN_BLOCKED\n");
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	device_to_group_device(dev)->pending_reset = true;
+
+	/* Device is already attached to the blocked_domain. Nothing to do */
+	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
+		goto unlock;
+
+	/* Dock RID domain to blocked_domain while retaining group->domain */
+	ret = __iommu_attach_device(ops->blocked_domain, dev);
+	if (ret)
+		goto unlock;
+
+	/* Dock PASID domains to blocked_domain while retaining pasid_array */
+	xa_lock(&group->pasid_array);
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		iommu_remove_dev_pasid(dev, pasid,
+				       pasid_array_entry_to_domain(entry));
+	xa_unlock(&group->pasid_array);
+
+unlock:
+	mutex_unlock(&group->mutex);
+	if (ret)
+		iommu_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_prepare);
+
+/*
+ * Pair with a previous iommu_dev_reset_prepare() that was successfully returned
+ *
+ * Note that, although unlikely, there is a risk that re-attaching domains might
+ * fail due to some unexpected happening like OOM.
+ */
+void iommu_dev_reset_done(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	const struct iommu_ops *ops;
+	struct group_device *gdev;
+	unsigned long pasid;
+	void *entry;
+
+	if (!dev_has_iommu(dev))
+		return;
+
+	mutex_lock(&group->mutex);
+
+	gdev = device_to_group_device(dev);
+
+	ops = dev_iommu_ops(dev);
+	/* iommu_dev_reset_prepare() was not successfully called */
+	if (WARN_ON(!ops->blocked_domain || !gdev->pending_reset)) {
+		mutex_unlock(&group->mutex);
+		return;
+	}
+
+	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
+		goto done;
+
+	/* Shift RID domain back to group->domain */
+	WARN_ON(__iommu_attach_device(group->domain, dev));
+
+	/* Shift PASID domains back to domains retained in pasid_array */
+	xa_lock(&group->pasid_array);
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		WARN_ON(__iommu_set_group_pasid(
+			pasid_array_entry_to_domain(entry), group, pasid,
+			ops->blocked_domain));
+	xa_unlock(&group->pasid_array);
+
+done:
+	gdev->pending_reset = false;
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_done);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
-- 
2.43.0


