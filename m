Return-Path: <linux-pci+bounces-33805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8087B218E8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2F428331
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BC82E5409;
	Mon, 11 Aug 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W4hzeihI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5F92E425E;
	Mon, 11 Aug 2025 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953249; cv=fail; b=EHWtYLcye9xZR0wrJl+7mH9+VKy5wsIHJGNXNBxNH5WDfAMWdMN2h/KcC+5IuvHSd3GvLccK3sPYKCv5NIb1E60li59lTr0bvZEzj5wV3955t3rzNCJe8CmP54+GvhHm+ueSKoczWhPfxcrOBjSlxDJsanwwa3IFIoeej2QoWwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953249; c=relaxed/simple;
	bh=xNY33sxyY5Wqxvrxt4mB75gDjIp7s/FJTfobqS4P9lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqqud9x1WAaY+lbWrGf1XpYPEyyP7WYIB7fasJqmN4prL92GhAxOt/000yzqTiJkK7YjmjmwY92yZuKsRe6I2BqpX+WK2KOrzymUqTJrjmqU/5QSWVubxSRd9xGxo24u8GWHt4CYiwRJ4106hj/hqwq94/DiRyfF1YczRIYgSvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W4hzeihI; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+HWko8OIWgD+MGQ5lUzyoAoLCXCOJCEplZrrDbav9O3PwYoDI2HIhsvXWPrgD0V/09v5SchIvl82t1i8O0fW5RNlNmY7yezkklw/g1dx8FOM/EJUpv6yUfkwBjDNIXEnaynXmj6lxlTQJjGJB7KBGjNpm4eYkMR5coNauYz5oWzhRVp33XO1/g+Adzx2S+FSYnCCytI0R1pofSFUZF/FWUnxFLdqeFQjnvYDFW7tLhFEShNEjmw7HRYcQ52WZjGYQt3kIOgiiuPfVOi+146XSZYBxBHaOiN+cSjKgEclHrCcRz4+sHon1UcED3yXcQK6UJ6Sj5tgHimIp1QA6J+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guSV3CoJNn8S28wjYeTMi+C+F9OnMjs0LU0FqU2TlFI=;
 b=Q2PvjklTWE5ph4lj8G8W0OrSHMuAvmSosjcSUxhLOkgqsuqU9ho7SqvyBWEeGEiUX8VwMrygqMUEZzKKdIRuQHMjj2FK4AmwF0ZQytwa2LjcdTBUyCKl+gqLKDLEk3U9CANUidfvKITT7rtDhGVz13Gm+DwBlGq+mvG37ZRe/wQOVZe/7mFXPyXawQRAaeNc457uPvyg82qCw5WAJQLyFhhcrUI8N53bCefQF+To1Gl6Gb3P0saHJbwvdJPKAeHoIy6EHetaz6Hlb0TxnHDzz+9yQLQL02BDcF9UY6L3jjRN5GXD74oZ1/pofNWkh6FwwVgjjyff63itYyGEonH84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guSV3CoJNn8S28wjYeTMi+C+F9OnMjs0LU0FqU2TlFI=;
 b=W4hzeihIvK9dw3CxJPuf7vwit0/cQBcaVk4S58vJJFJlucfoFV3uMuHM5MiAhdRgxAG4K51218bGi2bShatXHVF2w8m4/3bcPtsVj6ja6U2rAVP5ZK668Fhrww768Lji6hHGI7dP/bVqpbfZucv8mKsQ99NPnDDl8p9dQnqsHts80Zr4weGG+w2omEnCTV7F8HUD/HAjJjBs6ZgoBtKf8KXlCoLwVPgHAAWmDmxCPbPXkWvpubm2xr+BB0cfcoPVxPNKxW8rCBl05iNmG83k9lsv0JAxyVos0XvTYW/ryPZ4WX+zjAaHf1EmKFa+l6VW+MS8etOz+NfySd9IHx758A==
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 23:00:38 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::c0) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 23:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 23:00:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 16:00:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 16:00:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>
CC: <will@kernel.org>, <robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <etzhao1900@gmail.com>
Subject: [PATCH v3 4/5] iommu: Introduce iommu_dev_reset_prepare() and iommu_dev_reset_done()
Date: Mon, 11 Aug 2025 15:59:11 -0700
Message-ID: <5ba556fc54777853c499186f494f3411d7a4a5a9.1754952762.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754952762.git.nicolinc@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 843fd46d-6d55-4b27-d73f-08ddd92ae314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzqCjATHVYiAqq6QjFRfDndGyFqWuiVhfr6ITPCRLP+3qNvdRXNY/74yy9aJ?=
 =?us-ascii?Q?7Brnc8eKHmjpAN13nQsWkp7DSrMC9wUXbdWvJH7OSDhLtQNAnPoPgnSGTEwI?=
 =?us-ascii?Q?1ci8txtabJVXsugRCaOwtkvzJv9wsyDNZ0OEmjedFFTi0nu/11ghjE4sw1xJ?=
 =?us-ascii?Q?331L1afLeK4m+R9ev5GlUKGvGTnyWzfaBvQ1dqSbMmlS3PoIhN6LlspH9NJ9?=
 =?us-ascii?Q?3+PkbTG2mo2rYvekYR3RNX4xBZkISXb73lwMR8jJJ3l5BjF3h4HKDBIkiqOR?=
 =?us-ascii?Q?2nxVxhxm7D8D2JKGOrT6G1DRrUOfYHnQaHwpzUTL/l6vZhqpBFEc2Cm8+vVq?=
 =?us-ascii?Q?7p4lXyr0GVhoVPZ0izliA7zz0xgCT3KZrrPAMUjXS7d1zdkwbJMwsWWZ6i0e?=
 =?us-ascii?Q?rN8YMSFvgOT1wbeIlSlBW8GNOb6dk1bzvnRp1YWLT+A43S9m5e5Br9i9zXRF?=
 =?us-ascii?Q?mAj5GSZq4tFIU51m/+CGNi4MVJ91pb5cSh8l4U5MxTm3pWW9I5kL7cRMZ5SM?=
 =?us-ascii?Q?RpNqrqjNyigzAPnGNIRWyZdQmIn+qC6DJvcEbw6lRkuhD8lwUiUSgZXJVVPf?=
 =?us-ascii?Q?gxSWDoSQwXjt1UwYvvmFlIeJayPsHY6sej1l+Dh9XJgz46vtf/1r7f9vaLYX?=
 =?us-ascii?Q?QsUaHV2q5MGhrqf5Tj2fGFuJCw0KOa1PHDLn+p6Zv+OE3TW+15OtNHmtgkUK?=
 =?us-ascii?Q?uGIj8lZ5Rqq8F7xPqz8eKHHmbHC1vmsHpec63nwaXfv3CCI3wPyrKIT+Fqik?=
 =?us-ascii?Q?xMgAmGmDtuwnjOCDcC/eZX1c5W32kL8HSqthJ4VicZe9W6qJ5MfpKejP2ga6?=
 =?us-ascii?Q?u5fFNcjg2AnVb5Hcc9QGnlQm29RD/rXhaXeSjUbe9TeN8161T7MhWAa6fDT+?=
 =?us-ascii?Q?Fe+3J5jUu58/k4qmlOy6keMhfbgXvzJvL2fHRqNRwAAibjFsJXhiI6lLj5kK?=
 =?us-ascii?Q?C57q1GvsbzJZ+P/R8+ih+7wel6Q64rmvftGR5wDRalZIfMrrV/5nS6nWbTRm?=
 =?us-ascii?Q?pWSEImO+0exFGrQxaJbcbJXXEKrKiUwMxVJm/yIJ19loyRa63w6iIuU1v2Md?=
 =?us-ascii?Q?ahN8vmrpzZU5IPpJXrLEzJgrRvfkE6mQNE1od/iQPnqdij15khVIeF7TZY+A?=
 =?us-ascii?Q?Hjsfo3TllgI76+Y2gdHvi5+RBUBOEbzSjXE0CKiFU96XlYwe8Ig7GIXW1XPP?=
 =?us-ascii?Q?Tbhm5BZTk24Gm9ZK5xWHiyG1+4puRGwZl8vnHYyyFlZ1StLhaq4fyMQjsFNo?=
 =?us-ascii?Q?TXAujlZQ43GgK2lAP4BjEZW3tY0nRgyhXTZR8ecvE/kseaD/evl++fFGmPs2?=
 =?us-ascii?Q?w7b2mShi/jsxfYYOM7U9JomaoseOnrwjFRaUu1/kz4cYnnF5J34aeJWqWfY8?=
 =?us-ascii?Q?lcAMtciK8mmUdKfUc7QmLESXHycn9CDC2OW3sMs61BQbYSYqLMiqDD4XE+gy?=
 =?us-ascii?Q?qmWNhi72hsq6fJjl5jEJAMw7mYcAITPU7m0BRtd0wkGjRHLXGMYIbfOK3+1B?=
 =?us-ascii?Q?Iy3qoCMnFbaVMJVohueLtkbcaOXiQYzF6r3B?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:00:37.6528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843fd46d-6d55-4b27-d73f-08ddd92ae314
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

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
ongoing reset, ATS routines may be re-activated between the two function
calls. So, introduce a new pending_reset flag in group_device to defer an
attachment during a reset, allowing iommu core to cache target domains in
the SW level while bypassing the driver. The iommu_dev_reset_done() will
re-attach these soft-attached domains, once the device reset is finished.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  12 +++
 drivers/iommu/iommu.c | 166 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 61b17883cb0cb..35181d4d8f302 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1168,6 +1168,9 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
+int iommu_dev_reset_prepare(struct device *dev);
+void iommu_dev_reset_done(struct device *dev);
+
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1452,6 +1455,15 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
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
index 8c277cc8e9750..c1f8aa5d79f8e 100644
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
@@ -2154,6 +2171,12 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 	guard(mutex)(&dev->iommu_group->mutex);
 
+	/*
+	 * There is a concurrent attach while the device is resetting. Defer it
+	 * until iommu_dev_reset_done() attaching the device to group->domain.
+	 */
+	if (device_to_group_device(dev)->pending_reset)
+		return 0;
 	return __iommu_attach_device(domain, dev);
 }
 
@@ -2198,6 +2221,16 @@ struct iommu_domain *iommu_get_domain_for_dev_locked(struct device *dev)
 
 	lockdep_assert_held(&group->mutex);
 
+	/*
+	 * Driver handles the low-level __iommu_attach_device(), including the
+	 * one invoked by iommu_dev_reset_done(), in which case the driver must
+	 * get the blocking domain over group->domain caching the one prior to
+	 * iommu_dev_reset_prepare(), so that it wouldn't end up with attaching
+	 * the device from group->domain (old) to group->domain (new).
+	 */
+	if (device_to_group_device(dev)->pending_reset)
+		return group->blocking_domain;
+
 	return group->domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_locked);
@@ -2305,6 +2338,13 @@ static int __iommu_device_set_domain(struct iommu_group *group,
 		dev->iommu->attach_deferred = 0;
 	}
 
+	/*
+	 * There is a concurrent attach while the device is resetting. Defer it
+	 * until iommu_dev_reset_done() attaching the device to group->domain.
+	 */
+	if (gdev->pending_reset)
+		return 0;
+
 	ret = __iommu_attach_device(new_domain, dev);
 	if (ret) {
 		/*
@@ -3388,6 +3428,13 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
+		/*
+		 * There is a concurrent attach while the device is resetting.
+		 * Defer it until iommu_dev_reset_done() attaching the device to
+		 * group->domain.
+		 */
+		if (device->pending_reset)
+			continue;
 		if (device->dev->iommu->max_pasids > 0) {
 			ret = domain->ops->set_dev_pasid(domain, device->dev,
 							 pasid, old);
@@ -3809,6 +3856,125 @@ int iommu_replace_group_handle(struct iommu_group *group,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 
+/**
+ * iommu_dev_reset_prepare() - Block IOMMU to prepare for a device reset
+ * @dev: device that is going to enter a reset routine
+ *
+ * When certain device is entering a reset routine, it wants to block any IOMMU
+ * activity during the reset routine. This includes blocking any translation as
+ * well as cache invalidation too (especially the device cache).
+ *
+ * This function attaches all RID/PASID of the device's to IOMMU_DOMAIN_BLOCKED
+ * allowing any blocked-domain-supporting IOMMU driver to pause translation and
+ * cahce invalidation, but leaves the software domain pointers intact so later
+ * the iommu_dev_reset_done() can restore everything.
+ *
+ * Return: 0 on success or negative error code if the preparation failed.
+ *
+ * Caller must use iommu_dev_reset_prepare() and iommu_dev_reset_done() together
+ * before/after the core-level reset routine, to unclear the pending_reset flag.
+ *
+ * These two functions are designed to be used by PCI reset functions that would
+ * not invoke any racy iommu_release_device() since PCI sysfs node gets removed
+ * before it notifies with a BUS_NOTIFY_REMOVED_DEVICE. When using them in other
+ * case, callers must ensure there will be no racy iommu_release_device() call,
+ * which otherwise would UAF the dev->iommu_group pointer.
+ */
+int iommu_dev_reset_prepare(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
+	unsigned long pasid;
+	void *entry;
+	int ret = 0;
+
+	if (!dev_has_iommu(dev))
+		return 0;
+
+	mutex_lock(&group->mutex);
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		goto unlock;
+
+	/* Dock RID domain to blocking_domain while retaining group->domain */
+	if (group->domain != group->blocking_domain) {
+		ret = __iommu_attach_device(group->blocking_domain, dev);
+		if (ret)
+			goto unlock;
+	}
+
+	/*
+	 * Dock PASID domains to blocking_domain while retaining pasid_array.
+	 *
+	 * The pasid_array is mostly fenced by group->mutex, except one reader
+	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
+	 */
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		iommu_remove_dev_pasid(dev, pasid,
+				       pasid_array_entry_to_domain(entry));
+
+	device_to_group_device(dev)->pending_reset = true;
+
+unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_prepare);
+
+/**
+ * iommu_dev_reset_done() - Restore IOMMU after a device reset is finished
+ * @dev: device that has finished a reset routine
+ *
+ * When certain device has finished  a reset routine, it wants to restore its
+ * IOMMU activity, including new translation as well as cache invalidation, by
+ * re-attaching all RID/PASID of the device's back to the domains retained in
+ * the core-level structure.
+ *
+ * Caller must pair it with a successfully returned iommu_dev_reset_prepare().
+ *
+ * Note that, although unlikely, there is a risk that re-attaching domains might
+ * fail due to some unexpected happening like OOM.
+ */
+void iommu_dev_reset_done(struct device *dev)
+{
+	struct iommu_group *group = dev->iommu_group;
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
+	/* iommu_dev_reset_prepare() was not successfully called */
+	if (WARN_ON(!group->blocking_domain || !gdev->pending_reset)) {
+		mutex_unlock(&group->mutex);
+		return;
+	}
+
+	/* Shift RID domain back to group->domain */
+	if (group->domain != group->blocking_domain)
+		WARN_ON(__iommu_attach_device(group->domain, dev));
+
+	/*
+	 * Shift PASID domains back to domains retained in pasid_array.
+	 *
+	 * The pasid_array is mostly fenced by group->mutex, except one reader
+	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
+	 */
+	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
+		WARN_ON(__iommu_set_group_pasid(
+			pasid_array_entry_to_domain(entry), group, pasid,
+			group->blocking_domain));
+
+	gdev->pending_reset = false;
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_dev_reset_done);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
-- 
2.43.0


