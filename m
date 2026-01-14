Return-Path: <linux-pci+bounces-44803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CCD20CC3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E453082EDD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC733509E;
	Wed, 14 Jan 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K6FHj2Yr"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F98335065;
	Wed, 14 Jan 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415000; cv=fail; b=QkThMVFCpp1HphXe3ATLTTHXGOPY+n9VVv2cSgsSnrK3ND75FG9hOewxDlAXy7vQsFaduf8hFM5o93bfaekptQDO4Zr9TdyiJwga5OwdzFoTOfXth8CT2c+kfyeAWXn4BJ1xumdvqevTdTyiotbHRKrxk25meulWTWcDcEeRfto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415000; c=relaxed/simple;
	bh=qpLKZrFih/5SR/EnvnLy8omYshNYLu6FTxvW4rUrN3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWq01WzZXSMzQrzyT+hyeLaRZjxZ5tWww+fDKj80mflmcSlOEUw66+kkgIcHjqqd8dDaCmGJof15PW38i/FuAvLIZKItA3wUCqj214/NO9DSrNs7EhLYJ8ye3EyDP7IZSQQLTZvxKKCrip9RNZcwqUNGT/Zp84AXPHMasbkAvsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K6FHj2Yr; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5y2mRMr8MGGLOLMO53988Oe7/logbeJKde1rtc1hz0YBD5+3RMqdvTlMrxti8jFOq4OeGjUZAfp5yhzdMn0W7jNlA8tByrSlx9Tq2NNP0R/7MQe4cJKwNz+DH8ToXf7r+aFQIQS2GbomPuVsKLccwON8XqeOmVgW0gJzIuvxHKgJoCIzzZwqz2kvgHgICDRsc+gJ7o9Ed0AXo6YQBGKznM8f18ib65v39/ydNvLhxyBUOfh5Log7CIyHcVA0VJxa7BLvcDsGPCKcIUIzNTpAS3BXnrCz2vPJuza630jCYYt7/ntsa76tvHmVShr/fklghq/9uGFfTeIcAxZYSBG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy/1IiJV8c9ZG0iCw1sOH3bgeSf3UVnMYEDKtafG5xY=;
 b=H+PzehdRaGoS8i9E0ZtvsovsdUWI/WMvTHOEvoie7d7Q+8sq62bzxWsrJNjEfiFJeRnHbPfgWmp+q4LlzpWjb1BOQisha3kXKd7OyBOWjC3Yg0YiC/K3TUrD6GDhOAJNJDz3ufqod3iPp7MO4CS2pL7BY2ArfxQpeNy7+XK0XR6djStGHLtrsJmGBMOGbHMqzh8jFlvhQUdma+KZR7ydAwWxm6I+pnc4RypDlWBBNwVFErpALZYz3aJep6NzS+hyuwQnjKJtDpJJwRn0iUIphkSA4arHsDJS4erWmZEqp9Y0sH21H1N8t31I0knXdRW/SHoJ9goW3IAOUQNUTl/ECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy/1IiJV8c9ZG0iCw1sOH3bgeSf3UVnMYEDKtafG5xY=;
 b=K6FHj2Yr6OUXNgChqk9Zam7Jw1nVN3DJZriQYnL0YoXdURRLRzbVfuQAFoTc2wPXIWHW6vs0r4Pjb0uAGQX8mGy3g3cgl7+w/ubl8wTLGGnwnHDCHvqIJY0mg9reiNYE9N7JNDspJKdrw+5tf2v0OTaRqLpPCvQhv3+wLu0sHBM=
Received: from PH7P220CA0054.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::11)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 18:23:15 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::51) by PH7P220CA0054.outlook.office365.com
 (2603:10b6:510:32b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:23:14 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:23:12 -0600
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
Subject: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
Date: Wed, 14 Jan 2026 12:20:31 -0600
Message-ID: <20260114182055.46029-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0dd86b-37c0-4470-aeef-08de5399fba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWewSAF2unOd+IHQVYNmc7BJ8QbA35ZGYOHkgwLP2Oan/nrm2j82vLqO3SFk?=
 =?us-ascii?Q?MOUOKpnzeS3opxR9C/8El47ywAH4mvyOevrsoll8b9d72mWv+LkynRia4mBU?=
 =?us-ascii?Q?X5HsIBgXleotMdrJvKHQM0Y0kmdHK9mMHYNqCSf82FnYYJ3/5OF/MdsTqWUw?=
 =?us-ascii?Q?CU9JLMsE1qVhUgqFEy/PLozPgDT7DigfUbd2OQzCKF+Y3cDGjkJlXCjST2/v?=
 =?us-ascii?Q?Ado3XgxqEj0oymYXx4KZmeUx+fc40UnpvYvX/srrHWc1YD4RfHI03DsYoaNs?=
 =?us-ascii?Q?3WgQIZb2mK4rr5txNtKYkBYr0axTwYVGX9jxsM0zWxUIaOpe9PhiHgjHL6bF?=
 =?us-ascii?Q?JjNAaWDghdwVH6LrEaf4X3NGb0Vfw690P0t8E2GBJpFr5ahM2vP5WFEK3B2X?=
 =?us-ascii?Q?+xaXBQMt+vAxZKfx91h0TGNrh1Qba4k+LyKRhxPNCqbPmbQ+jX4ZwKK7DmZl?=
 =?us-ascii?Q?iMEqTump22/OsX46zseEhN7fHFMSZviLbM8Zv6OQLbrtRRNUL8nrcLKeAH2Q?=
 =?us-ascii?Q?sM4nOoorspy2Viv24/r0b0TX6jJXQ6JImlGgEBuB+Y1/+DYUCRzaxRWWaFdy?=
 =?us-ascii?Q?pu5scNqDVuRQHE0qA2ZUd33zmzWc9OCUzNAkxhjIhQiXi/PNnnSMxgt++wMN?=
 =?us-ascii?Q?uCdYxP8Ilv3ZjeJtTkvqpA7ML8QTtPTpj6nS2HWuKQz/U1s/HDEA08zoPK+8?=
 =?us-ascii?Q?yqWC54o7fxHH5yCKHSMGvBLECEUWktTPLlVegBPyupYkIS0+ap/N/Az2VrHJ?=
 =?us-ascii?Q?c4ktuocm5NKaS6OExz8niQErSwoetHrXAtHMydJK0YU2i+E9teK/qI2mT43C?=
 =?us-ascii?Q?AZQKemgDyKbPJQSLU91gu7JdBv6RIogYC9GC5AHCdPMtNN5cKYSvOCsRezb1?=
 =?us-ascii?Q?POJ9PJMGCEzdphTpI9GK01TRDu7rHpzX504lXyjNh6eatZ5GKfMb6tb1z8lV?=
 =?us-ascii?Q?VpPiLprWspoaLVh2IHxeA/Y4Di7OluHdUdwLnyVvTuRiiViUsT/H30Fm1tlr?=
 =?us-ascii?Q?4Tt3YiLQTFu24aT7M5iudcKSDJEg2cT3p7mZwF7xgNnXUrxjhEu/ffvl9Deq?=
 =?us-ascii?Q?HjjuXbnr7zAPxfkI+h9QLvPnhya2XnIXx8GpNjHHaHhOUyZAq6nf06AUOd0r?=
 =?us-ascii?Q?te6+bV8voGaOtj80d6A2RdFzhirgG0XJcfIGshiAwpusgP25ogO12ozCFxol?=
 =?us-ascii?Q?cBUdlcBYwxYPckQiR8I8ciYAe6gK8WyfnNgtJCUBdjHBJyDrLSvoGKCSr7oX?=
 =?us-ascii?Q?jaIq4RdPavSxtyomhB1YFWugG2cuFCvvZkFV6G1+SKwyW53PfDwg6ko08joi?=
 =?us-ascii?Q?qaCR92AQHLOB19qFf8veviwFkvi83NPYO7tsX91RC2LCjGBcIR129A8LAv45?=
 =?us-ascii?Q?UNeDMxMMijcpcr+SKgemEN+hcyJzIOv4L2QhxnDZSJGIV8O/CqtnxOKSN3Za?=
 =?us-ascii?Q?5yEq6f2bzMCABPGcJWkp58cFARviUNk46eIvBJwHpIULgpysLM0kd97J+dWx?=
 =?us-ascii?Q?ldTjVdVaXrSyLyndtsc4Z7nDV9q/5nGujAckrYhLTL6jY3mhtZbhWplt+n4S?=
 =?us-ascii?Q?IPKvlfCSRgDnR/m/+iLQ+6vAd10HAuN/lkO5JC+vs+S3P1fZKAVMDViHeLrL?=
 =?us-ascii?Q?Aq1gAEGt//URO+rW5SLo41HZb8HZ2Zgjhz9DLuCXEiR0wxRx0QFeYhoBQIlw?=
 =?us-ascii?Q?kPlRS+JGGwywCdG+SkHOVPgzx1o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:23:14.9098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0dd86b-37c0-4470-aeef-08de5399fba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

The AER driver includes significant logic for handling CXL protocol errors.
The AER driver will be updated in the future to separate the AER and CXL
logic.

Rename the is_internal_error() function to is_aer_internal_error() as it
gives a more precise indication of the purpose. Make is_aer_internal_error()
non-static to allow for other PCI drivers to access.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- New patch
---
 drivers/pci/pcie/aer.c     | 4 ++--
 drivers/pci/pcie/portdrv.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 63658e691aa2..2527e8370186 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1166,7 +1166,7 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
 	return true;
 }
 
-static bool is_internal_error(struct aer_err_info *info)
+bool is_aer_internal_error(struct aer_err_info *info)
 {
 	if (info->severity == AER_CORRECTABLE)
 		return info->status & PCI_ERR_COR_INTERNAL;
@@ -1211,7 +1211,7 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 	 * device driver.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
-	    is_internal_error(info))
+	    is_aer_internal_error(info))
 		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
 }
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index bd29d1cc7b8b..e7a0a2cffea9 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -123,4 +123,13 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
+
+struct aer_err_info;
+
+#ifdef CONFIG_PCIEAER_CXL
+bool is_aer_internal_error(struct aer_err_info *info);
+#else
+static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
+#endif /* CONFIG_PCIEAER_CXL */
+
 #endif /* _PORTDRV_H_ */
-- 
2.34.1


