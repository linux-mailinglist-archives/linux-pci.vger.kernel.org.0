Return-Path: <linux-pci+bounces-40179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D1C2E8BD
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8615334C12F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F61C54A9;
	Tue,  4 Nov 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ueW/G+yq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC119C553;
	Tue,  4 Nov 2025 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215258; cv=fail; b=BadR1WQqDMmtifzHJURGbB3q+BuBReXpl7fSE5p8+XksjC8KV9GWpjPXbwnQ6q8Ck1Qj8DjKFrK+mx4rBnj4OtwVsIpZxdY+4vkqebTXPHe6sqw2kaVLmw8BF6pYAuisPFbQi/JzlCEwVk+en3V6PHA80dYhAR5SWr3LOpimZgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215258; c=relaxed/simple;
	bh=YJSDxbaho9yS2PjXbJ9GqS3YEMh4qm4yQAW5wwBKEzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7FC6H2uxJGDdcQThQAqsUNHLKHEoZmETAVa7JTaP4dgjzOl+LMPmNF+thZ6OSpl+XiNjWjiPuGYGzc7fuZAH32K3duRXNh3OzcgJR3bSwx8OxoE6JpPR+jcEThGT3lwZw93RR2478pXmqIsBZgPpmCFXchwFN55bIiQ9M/QvTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ueW/G+yq; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB6BJytLntGnTTFWs45ZEj8uR2/KkGsEgQIkogcseviWIuQRdzXgaEewJpLIvI0KjPn9lFc1HYJ3sHaaUtJ5DMDi+3ywYWcWoFAUdGfbT4GLFP0cT19i/h9u3UqNBkr77DRUzlM2ZxIOJW1+VsdDmfDmihRQmg+stFug6vJ1ZoTh5RwmUWB+d7lZB33rNcEDVm05pWlX6QHWmQ2PFsMXkI8bj+NYxny6/d2rzhiX0ZWOe6f2lMKdV8hbH5wVtSa7vxjVJPO2NcLg1vLX5JqvrumsrtdpfYyDiGSVJdzEY8hc8XDHTgogUSo85L0+E7sjfg4nqLZPbyOlEcNVAxWzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQPd7mOURakdzQPyR1ftr6xYSrNlJSQRtnxlVrxMzyQ=;
 b=iKzS4Q7O/uEXlGP/tbsvtmI6fWC9HoIRInNQvTfMq4iQ77vmCWGgL2lzxDW4DLkrFYTMYcMKht5dzvXmWPsroJbsXa4AghLHA767Nf3mCCGcPyy6sE0+CRAUZEh3s81s9RWmlMBKGaqyRWHkmiiuJytc34DLMi5h0A1apulJcrJs2gJ5oPw3YX9ikpRcnCaUaL0MCrM7WVSC7H2mxjY6sATUdCu4MD1JMyjh+ksJynmruvaRtZSBHXh0gk2Nkd+ZR/Dcvcs/W85Oti6aZupfWZjcoYlgPQudd+k5xvcW0i8+thW1dwl3ySTuOC+pzXwWBI+b+25WhNMw7HAkH7G14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQPd7mOURakdzQPyR1ftr6xYSrNlJSQRtnxlVrxMzyQ=;
 b=ueW/G+yqLgI4vv4vX38b4tDVmfFpp1GzHngpivVFHEzaSBvyKlLSZAq4qbkM/ll2HgmqUBWFZXRFUN7m9aLVbfmiRLos5u6jp0mEPfLfMC5SAt/vf+e2kOpIW9J2bety+vTlt/7F1rTLwJELegK66Y/h8k1K8CANFd4mWQASyY8=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 00:14:12 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ec) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:14:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:14:11 -0800
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
Subject: [PATCH v13 22/25] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
Date: Mon, 3 Nov 2025 18:09:58 -0600
Message-ID: <20251104001001.3833651-23-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: f565619d-4994-4a39-ca24-08de1b3714eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?imWq83Tud8dNjChdyDCX0BGDC2s9CdalfuiboDUlMlA5hkEM2AWKufCFu+YA?=
 =?us-ascii?Q?bZ26C+hDxHScCR7U7qE5eJUJPk/68E3drwB7q93SUlmxjVln4Gk5AHoUdaHm?=
 =?us-ascii?Q?lvyi+B8NpL2JeNo7TOackF1HCFhGDRYRov+K+vgzJ0kA7v+cvOchX+YC/FU5?=
 =?us-ascii?Q?5z6R8GvfIIYAV6c/KwFnC5RjIWlvpuR8iap4P+4WAz1SjHarp8Z1wvlzJRpe?=
 =?us-ascii?Q?ziKjGB14E/UQNN+4LqmvIn0/fuWLuMh4eVidSafICblQ3swwwgC5+xfNd67h?=
 =?us-ascii?Q?NYaxQnQNTzxvFgLcLat5FnGpyfkMHA8OrWYVf06i/iQoGCuJy7V3tfhpYQv7?=
 =?us-ascii?Q?hLFB/tHGy2o1b79yi4XMtxNQb+xI+z6h1zvXYRhdj9tmD9FRh7O4QCjppZ8n?=
 =?us-ascii?Q?DpuKZZzr9bqaYQmNZ5hM/VIbZeWStpbzCMW45BQHSTVZjpaGJBdnRF3smvvk?=
 =?us-ascii?Q?Oyg/zXWnDvxICxdfMlVUtFtDqfkTdegqPr8bwA1ZAe7jKOHQj71ZblnIKLHJ?=
 =?us-ascii?Q?4YtkioPmb7HMdXNfOALYV6b50bFv95KjxFKuik0kKtBR6bGNNx1+I5zxxFyb?=
 =?us-ascii?Q?cvOS2E6IyzVtRgidbNffeObgJ3XH/wmz2FRkzEHdZMRS+6eeDs/A4YQMUVqM?=
 =?us-ascii?Q?HIoZG3bFpfqHD4OZqwtxjnNEujRGALeQSfWxwMTRV3g0gDmEr1jVqSQ+rUVe?=
 =?us-ascii?Q?VYNr0baU7ITi10MwSdGs4RxwlzGHxnHfZDdJ3ADvQMHo+RDpbXtIyg+XD9lr?=
 =?us-ascii?Q?4/D2q3nN+3khd3eGGUOAbifLwuPxaEa1AHHN2rtAfzEwHbFjg81GG7Hy4Dtc?=
 =?us-ascii?Q?KhvJxXMN2dl3Fn5Hr+91dE8TJZeZiEY7fJAsEWBBJs8QldVBPwP00GG9gyw2?=
 =?us-ascii?Q?C4y9eTkx6F/+pqqWEx+C12xUtWT/Rm2B/r5Ya+xqBDPEB7NhHncBxwRcrHEZ?=
 =?us-ascii?Q?WYjnsgMLdNtnyW5Mez+6JHogaeNFVxrSRDSKJyrUM+G7IOlBMU83qfn69zks?=
 =?us-ascii?Q?hmFH07OFzpiM6VezPdRZ/0fqsDW7Eqr+Rled171XiB5OLZ/GaVYopWb5eCku?=
 =?us-ascii?Q?55VI/zmU9xAVfOgjEsUUqy9owIKtjLAsNbyXuDrQUCBGxE9sA2dImJ6JdLSp?=
 =?us-ascii?Q?gLVpU/zIVw4QpDqNnSf34qCoTTtb6eO4LYXKoaVHMEwQjhAXGImT2mBs0BNs?=
 =?us-ascii?Q?5azeVXe0ipxvclbWGk1n16yngZDwdwP3qN4BZXnHemfHc31F4tc8XeCJtosN?=
 =?us-ascii?Q?YFk3QAXz9L6fn7YAxW1jKdxERAZHetbpDamKj2H82lGfBZ7M16ZcKCRbWrvM?=
 =?us-ascii?Q?3e8wsAJsYtxUGglytYeTUxA38Z9tjs/ULcFKv2OcEidpxnY4IqRI+QloYtNG?=
 =?us-ascii?Q?Y04eoaIsbYu8V+xw5QhLeyuo7LPF3vXSVtNwONAr+kZM7PrXko1wUT+505Tg?=
 =?us-ascii?Q?wp+0mLt/ZVBTMMqoHnEZwXURCMkSu7hGpvzgRunsBofmvj+YsexH3+GdCxko?=
 =?us-ascii?Q?+PA1V0brccapJLmu2KRJpVTr2KP3GtYmrgpqJRAjvZN9ACTpY5TjEWb7hd6t?=
 =?us-ascii?Q?cw0UnoZpGVt2k78LecXSFHehaOxrGabLhLJ/5V2X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:14:12.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f565619d-4994-4a39-ca24-08de1b3714eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050

CXL uncorrectable errors (UCE) will soon be handled separately from the PCI
AER handling. The merge_result() function can be made common to use in both
handling paths.

Rename the PCI subsystem's merge_result() to be pci_ers_merge_result().
Export pci_ers_merge_result() to make available for the CXL and other
drivers to use.

Update pci_ers_merge_result() to support recently introduced PCI_ERS_RESULT_PANIC
result.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v12->v13:
- Renamed pci_ers_merge_result() to pcie_ers_merge_result().
  pci_ers_merge_result() is already used in eeh driver. (Bot)

Changes in v11->v12:
- Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER.
  Is not needed. (Lukas)

Changes in v10->v11:
- New patch
- pci_ers_merge_result() - Change export to non-namespace and rename
  to be pci_ers_merge_result()
- Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result
---
 drivers/pci/pcie/err.c | 14 +++++++++-----
 include/linux/pci.h    |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d7..9394bbdcf0fb 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,9 +21,12 @@
 #include "portdrv.h"
 #include "../pci.h"
 
-static pci_ers_result_t merge_result(enum pci_ers_result orig,
-				  enum pci_ers_result new)
+pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
+				       enum pci_ers_result new)
 {
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
 	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
 		return PCI_ERS_RESULT_NO_AER_DRIVER;
 
@@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
 
 	return orig;
 }
+EXPORT_SYMBOL(pcie_ers_merge_result);
 
 static int report_error_detected(struct pci_dev *dev,
 				 pci_channel_state_t state,
@@ -81,7 +85,7 @@ static int report_error_detected(struct pci_dev *dev,
 		vote = err_handler->error_detected(dev, state);
 	}
 	pci_uevent_ers(dev, vote);
-	*result = merge_result(*result, vote);
+	*result = pcie_ers_merge_result(*result, vote);
 	device_unlock(&dev->dev);
 	return 0;
 }
@@ -139,7 +143,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 
 	err_handler = pdrv->err_handler;
 	vote = err_handler->mmio_enabled(dev);
-	*result = merge_result(*result, vote);
+	*result = pcie_ers_merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
@@ -159,7 +163,7 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 
 	err_handler = pdrv->err_handler;
 	vote = err_handler->slot_reset(dev);
-	*result = merge_result(*result, vote);
+	*result = pcie_ers_merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33d16b212e0d..d3e3300f79ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1887,9 +1887,16 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
 void pcie_clear_device_status(struct pci_dev *dev);
+pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
+				       enum pci_ers_result new);
 #else
 static inline bool pci_aer_available(void) { return false; }
 static inline void pcie_clear_device_status(struct pci_dev *dev) { }
+static inline pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
+						     enum pci_ers_result new)
+{
+	return PCI_ERS_RESULT_NONE;
+}
 #endif
 
 bool pci_ats_disabled(void);
-- 
2.34.1


