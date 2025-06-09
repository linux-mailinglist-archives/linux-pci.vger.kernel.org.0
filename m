Return-Path: <linux-pci+bounces-29258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFAAAD25F7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DF5188443F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280F21FF24;
	Mon,  9 Jun 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gnVhvZVg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948F21D581;
	Mon,  9 Jun 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494746; cv=fail; b=ceZ024LADU1b/MA6k/ygFIA2erVHCzu4iA9ADBW9/05OYHobmwDssMti2QNWw6yovgPdFz37Vscei8jbZXrFtBUtc1XzyreCLlJQuH3RDcRsutDgDPpESXBnIAmh4Npzp+oHaNxNyznyv18sVHgdS2tEU562xEtb0j7peHR1Iu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494746; c=relaxed/simple;
	bh=aRyup2AXGnBBeMGUP5oDORPrO3M2Dg6xdO31PE02zf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlXHqkpKePahwJHS0al3Ehelm8/jcqsyj8oVxsbdO9Hz5k0imUIaDY368PKReP8Q2d6v/2koD6FSRI+rvw78FwJZ4cuvxNwvde77rZBNCObcLETJiqZyk37twyzyrj1WeYbfBP3HPddvuLxkB5pgVvTljMU9LLxShFxay6JJjMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gnVhvZVg; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNVJleDu4DWhA0TTf4xZzKm+GtB+/4AC2kXp6WNNqPp62tshWDwXCJO1o+Jz8UzmeRZ/Dnu2HiSTiwpxjJYCarEUm+Ha8ympacfngYWq8CwUN7OCU8VcVwEpblCjIP0qq/Edk1ijpl5U6vrsdKI3Mk1+X057LcsyZfIo5+i3f9jnxWuRdk3IXZLS3GcXOS3s8AMdbh3XqXFr9CicazbybewwfpVy4tLioQ2hV2kefSlw0wrnGh1BMGpY1rbm2BQ7/asn/ip1LhIEIA8CEDTzBFHL1k5j6UuIk9X/TwCBApHejCiq5U4x7ARpIW8ST72aMguBP4CUrMRtCUwIEtTk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL5dOOTLLPQaxOj6vypBxQbFM19fVrPBTc0ANlQPQ5Q=;
 b=aIiXwWtdqydY1IL2FGSFuioo4ZuzQoQ7gYQMTY6ziWhNAm2m598GtKBiBVSMwvJczbEQ8EfFmm2n5Gb7Rw++K7V+hjN1VmFsANBGTyWuLGJGMmhRRCSWxwD3Rwc/1nkq5GxXYQvvTvIcJvzbyiSIzRjlSavUNyw5Hw6/q93g4FOC/7i7J/BnzLD71PdswgU+bpYdkyTUnwR2PWtLqDRwmEtTYvsW4/0Fa9zIcPdLgo9i326fbVvWdnyEhgP/OeNZLEK17tQFJ6yf2NioGNuS8jkDKAxISHXX+4+dlfe+00Q9QEokpxkvkodu7xtauevERb2neuxRiAnT0c0hWDjh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL5dOOTLLPQaxOj6vypBxQbFM19fVrPBTc0ANlQPQ5Q=;
 b=gnVhvZVgYv/LlnmmSzXvm/1jAVqvm058GP2axk19Nmo4BwodN2+0hqlFB6fre4O82e8BKja2y9dikqhrn1Qb1krsZkKpTfGLJS+/18RtNuvv7fF+AUnK+hBouzXXmBinEQ85uhAK+ywJKsrfUSQSBohXfM4/EeeDcM5jkqMD3szw+TQCACf7dix/hgH2HEYS25WAEMt6SNKcAPrOsbsGi1YsG7LNcM2FGHkWNHVc/Am1dV0yBrixXK/a4cZ+r3WBQzYZiAKnAHkIACeCubC9kBm+KnXqAHRVnFIjuyLVgy+U/zDM/4SQuZa8602MpGu6aREsbhh7fvJm0v3A3bu8TA==
Received: from BN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:e4::32)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 18:45:41 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::a1) by BN0PR02CA0027.outlook.office365.com
 (2603:10b6:408:e4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 18:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 18:45:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 11:45:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 11:45:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 11:45:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
Date: Mon, 9 Jun 2025 11:45:13 -0700
Message-ID: <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749494161.git.nicolinc@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 0353f65a-3bc6-4b25-b3f6-08dda785d5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M4SabehC9aO0LkFGW0v7bR1wFA341E/AjWJMj03IkEd2QckXwgKYlBBqWhnu?=
 =?us-ascii?Q?pKmtEeYsxMDrNiTg2Hrzq79aK7hAT6xBu5pDB9Ou5hM3eSjXXz+XlAXf5iYi?=
 =?us-ascii?Q?0aasjv6YuPymvh8OuQAI9YMLj/z83J8wq3rAayZyPnXHIQtTxcvpMV2m0SFj?=
 =?us-ascii?Q?WGdXzzR8iMxYAoc0Qf8GCQFXd9UFE1NxruMJifTeHePIDhE5DIN2Bn5AiNxS?=
 =?us-ascii?Q?4tMqd/QMlxtyUWMICRINbvhmSuEJGUQg6zn1B81LgPDZNYtymDCigJVn/kTX?=
 =?us-ascii?Q?SNcZ/f96lgD0TFdHMHLD83AZ9e1vxgnY/UGPUNlw4o5dmVjhHG6OTMW6Wpn6?=
 =?us-ascii?Q?5vYgWPoRJJrErzywMRmFJxFo5itLclVhF4f5HTCuZCSv3I849rfua/cKkPhl?=
 =?us-ascii?Q?FQQcGB+cYxkho48W6dXYDlCJeYa7dPyICP78S3nwyTp+m8mBra3fGPRwfWj6?=
 =?us-ascii?Q?/WxCtTmmd4m4GM0q0k7MAE3dv5LuWWoE93tGUUe6ncqGFbUMQzn3XVpTmSpL?=
 =?us-ascii?Q?jEsRlSTGFzSDarzsSYsyqBFM9UEybkSQSfIwio35Y/wLgIMx/pVWip/hNZut?=
 =?us-ascii?Q?TsdD0WL97E7kTQeLd/Xh7WhkqLgE1iXBPX1efVSRMhXPo4IlR2cZtDISi/km?=
 =?us-ascii?Q?QojTKDet2pTCbNnm/THn35paxl1hoVvKKUnmB+nGpXKJmkUm4E85iZbaGpdf?=
 =?us-ascii?Q?XOZDAzvymSx0eCOfWiKx7w+SXIYNWmBIIjARGgzUWLHgMjaDKYOrJmQqTCTH?=
 =?us-ascii?Q?HzP11SxOYOIh6saKlQwxEdgXmcdcMlT80iiAf3m23VrOsDiWCGuNe+UftGEK?=
 =?us-ascii?Q?Z5XYsO0T+AH5EVgQ0eDvCL+EG9+H5ifaxM47KJEdr67LIzKVRcXsLKy1mauV?=
 =?us-ascii?Q?JJ9MSVeOQkVQrK4Go8y+gPMaRlsuQqBV1ayVsMEs27oUgqcDfStij+IJvvHv?=
 =?us-ascii?Q?qZpDt5fTWOh5MX8vK7mYXSRQmjAfpJJIUYwIXXeossJwp1Z4TXqx4NiK1P4R?=
 =?us-ascii?Q?zNmqSYwEzqbBplhY1k0eV43CmJ5Arh3qt1JDXBgSTY7RGY3z4jwN10HvZ9Pz?=
 =?us-ascii?Q?RL/XXjWFQ3CeeQPhWoUv9tXrcqIsY1yyvOgnaRE6vbA/CiOsMPN9paKCzAw2?=
 =?us-ascii?Q?HFHS2fmyEMZUKoKnqGyyia+Q8pBO7gb0OxeBpYDQU5HtiCyXMpZoEWkhVPQf?=
 =?us-ascii?Q?TV3HtD01ou//YJtMlNTH0sbtTGXjlAccwh8vexKMi7B1GouTrcCV1iBZHH7t?=
 =?us-ascii?Q?XQWDtL9K0mMS7iYlP4/91/roZb6vsO2f/IUaSmn5EHRIBTrZARlke3353wRo?=
 =?us-ascii?Q?N5KvuW9M+Gcjbh3iJjaxkjpr0/ThVFBXDPp6iODQwsRX2YvbresA8HkfsXSH?=
 =?us-ascii?Q?oSPjd6R06lI0fZIDsv45I/kVLl+p+TLDPoS99nWZeERdT3CuKs/rmlU+3UwP?=
 =?us-ascii?Q?eiRJritHwPQyhpJo7ooxNp0cBb9TEQZeHuPwDqdN99aisjiPyN/wwH7XjZwU?=
 =?us-ascii?Q?y5W4p5290/k7x53zFWCka5k1YWAXZ24bfPLp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:45:41.1258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0353f65a-3bc6-4b25-b3f6-08dda785d5a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
before initiating a Function Level Reset, and then ensure no invalidation
requests being issued to a device when its ATS capability is disabled.

Since pci_enable_ats() and pci_disable_ats() are called by an IOMMU driver
while an unsolicited FLR can happen at any time in the PCI layer, PCI code
has to notify the IOMMU subsystem about the ongoing FLR. Add a pair of new
IOMMU APIs that will be called by the PCI reset functions before&after the
reset routines.

However, if there is a domain attachment/replacement happening during an
ongoing reset, the ATS might be re-enabled between the two function calls.
So the iommu_dev_reset_prepare() has to hold the group mutex to avoid this
race condition, unitl iommu_dev_reset_done() is finished. Thus, these two
functions are a strong pair that must be used together.

Inside the mutex, these two functions will dock all RID and PASID domains
to an IOMMU_DOMAIN_BLOCKED. This would further disable ATS by two-fold: an
IOMMU driver should disable ATS in its control bits (e.g. SMMU's STE.EATS)
and an IOMMU driver should call pci_disable_ats() as well.

Notes:
 - This only works for IOMMU drivers that implemented ops->blocked_domain
   correctly with pci_disable_ats().
 - This only works for IOMMU drivers that will not issue ATS invalidation
   requests to the device, after it's docked at ops->blocked_domain.
Driver should fix itself to align with the aforementioned notes.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  12 +++++
 drivers/iommu/iommu.c | 106 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

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
index a4b606c591da..3c1854c5e55e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3795,6 +3795,112 @@ int iommu_replace_group_handle(struct iommu_group *group,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 
+/*
+ * Deadlock Alert
+ *
+ * Caller must use iommu_dev_reset_prepare() and iommu_dev_reset_done() together
+ * before/after the core-level reset routine, as iommu_dev_reset_prepare() holds
+ * the group->mutex that will be only released in iommu_dev_reset_done().
+ */
+int iommu_dev_reset_prepare(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	const struct iommu_ops *ops;
+	unsigned long pasid;
+	void *entry;
+	int ret;
+
+	/* Before locking */
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	if (dev->iommu->require_direct) {
+		dev_warn(dev,
+			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
+		return -EINVAL;
+	}
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->blocked_domain) {
+		dev_warn(dev,
+			 "IOMMU driver doesn't support IOMMU_DOMAIN_BLOCKED\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * group->mutex starts
+	 *
+	 * This has to hold the group mutex until the reset is done, to prevent
+	 * any RID or PASID domain attachment/replacement, which otherwise might
+	 * re-enable the ATS during the reset cycle.
+	 */
+	mutex_lock(&group->mutex);
+
+	/* Device is already attached to the blocked_domain. Nothing to do */
+	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
+		return 0;
+
+	/* Dock RID domain to blocked_domain while retaining group->domain */
+	ret = __iommu_attach_device(ops->blocked_domain, dev);
+	if (ret)
+		return ret;
+
+	/* Dock PASID domains to blocked_domain while retaining pasid_array */
+	xa_lock(&group->pasid_array);
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		iommu_remove_dev_pasid(dev, pasid,
+				       pasid_array_entry_to_domain(entry));
+	xa_unlock(&group->pasid_array);
+
+	/* group->mutex is held. Caller must invoke iommu_dev_reset_done() */
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_prepare);
+
+/*
+ * This is the resume routine of iommu_dev_reset_prepare(). It unlocks the group
+ * mutex at end, after all RID/PASID domains are re-attached.
+ *
+ * Note that, although unlikely, there is a risk that re-attaching domains might
+ * fail due to some unexpected happening like OOM.
+ */
+void iommu_dev_reset_done(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	const struct iommu_ops *ops;
+	unsigned long pasid;
+	void *entry;
+
+	/* Previously unlocked */
+	if (!dev_has_iommu(dev))
+		return;
+	ops = dev_iommu_ops(dev);
+	if (!ops->blocked_domain)
+		return;
+
+	/* group->mutex held in iommu_dev_reset_prepare() continues from here */
+	WARN_ON(!lockdep_is_held(&group->mutex));
+
+	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
+		goto unlock;
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
+unlock:
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_done);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
-- 
2.43.0


