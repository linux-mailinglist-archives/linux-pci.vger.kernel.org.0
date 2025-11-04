Return-Path: <linux-pci+bounces-40254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72AC32444
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C921A2097A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311B33E34A;
	Tue,  4 Nov 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcHO+/8+"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8B339B4A;
	Tue,  4 Nov 2025 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276046; cv=fail; b=CFGP/d1yDWfxhcw1GvCE0SE4cHxbCNxvVS5g5lKHmRd0JxA82zP8y8+cVmH+jNMQvtfiNE0yykJ9srd0DMYtKZ5Yl7a3BV+ERZ/GLM/OFF0qD4Y8E9zKHPcAvX82n2Re+kzxLWTSWFF8OuHIN9VfELlp+UVJW0xZN1iCgHMtzN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276046; c=relaxed/simple;
	bh=YJSDxbaho9yS2PjXbJ9GqS3YEMh4qm4yQAW5wwBKEzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nii4QUjmWGIjF4Vf0q8zMdyHRdDww712cVv/uzp4fwyUiHNzPO2cQ5WiRrzi5vgR9B8Kom9XIJjyDoVNA4HyUEfrl6UFixRBGh59qdWVIJeE+yO8s7EbUpFllPIHqpFSFuCGmWwXtFcvtJSuNXzakpEmM+JoWQ27vd9cgU1LnV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XcHO+/8+; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4nd4ASvO2zMgl2fQFzJkQaZ9wxgg4wzYGfeotTJWWbwyXIU/Z87WiJRC2gq4ndNUHOHshroEIRlggBM0eJwgKNX+OgPNxQBGal0getUHywO4JDKlMY7MvizWcKZCu/6Dn9MZfkl01okIjp9nAMuw8f3EF2t7XJE4RVnaK82uE2b++gLWkdLTCuz7b8fXT0QHQhCATIZP94MwVoJy9HtIPjs9T9RLItqyqAC3OUqYsZAtg/h/QFn54MF0llUtKg7ZCK/yowTtTHOLNtoMU16+iTUQPzZ3pEAnCLV9Wg3H0SwBdBtge96zbM5NjMrDPuaS4MeyHBMZdCB5HwSHTcuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQPd7mOURakdzQPyR1ftr6xYSrNlJSQRtnxlVrxMzyQ=;
 b=AVcH/T7d/8IEgbif8Bzj6fpJr+cyo6WAVB1mTvBPE6GLO215wSFDQv/shpfbNYuFXXV1GgcboD+17g6/U5nBlw20fYvmxo39qbJmGuG0DVbRpZMCF2iOEiaKUPjf/Q2P1VK+lQHn4shZJe6uHCpbh+GiQT0ayS6F9qMAexcZUumtu1EBcoUvc2REy0D7s+DmLr1Vlj2YmNPlLMF11vjfhmr00gP411oehQ1aVfWGjIC/A6JfT5bmjdASDLVPjUi9QayeMVXFSkkn5KP5RanUC/UAXB9jFbEMp/Pi8VOPMKx87mZGtSVrxmOfdnbiPiIlukeFiaG/yYlrd9YpXySFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQPd7mOURakdzQPyR1ftr6xYSrNlJSQRtnxlVrxMzyQ=;
 b=XcHO+/8+iOhDzSiuJD2TSaH4fctv8Mi95Lw0PmUV1VcDlqVgXXsODfvb6FYnAoKhBJTmmxrwdrkJO5vBHb914uuxPU6dgtKo2nLtc3L0WCIeJpq4hAWMO7HpwqDvrmzb19DU0/cSQ195CuuihZ0y4OOMDk70PnVqZHOhXgr1Mzc=
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:07:17 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::87) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:07:16 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:07:15 -0800
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
Subject: [RESEND v13 22/25] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
Date: Tue, 4 Nov 2025 11:03:02 -0600
Message-ID: <20251104170305.4163840-23-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 9438ffe6-c2ee-4125-6710-08de1bc49b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akJUFRmd6lFJXGaUIKQoPW6eXhxLtoQbMVYnd6zvQAqqCUL38nYDskdHQThV?=
 =?us-ascii?Q?RU8yFrs8TkFwBJt7R+L/iL6H/jKU79VA5SDN6YmrCwGOmZJYZFJYLQXnf+r1?=
 =?us-ascii?Q?KARqUi0bp9Xsd5/aZX32xc0V2IN2Ba8fMZAHNGtwc0cXS9lV5CuQ+/gFxoKE?=
 =?us-ascii?Q?v1oek9NxanZucHBLuigAK5Rug76aG7+u63j0Fto8unOq2h0/7IKoDcHFKeyi?=
 =?us-ascii?Q?o/HHd3rrPWHw8L6Zt5JoX/by5rY7530OAPfL8YiKyGycW7mFRFU1WVNiXnvM?=
 =?us-ascii?Q?zP0vCUBLFSVI+Ppbo2xE9l0uOqErOFoG0+ma6w93F+8JhBV1uFXMC8Q8DhLd?=
 =?us-ascii?Q?zAQ/nUp4Z3F/N+JEX3scFk6GtCvoUWeoS7qKMDkPrpA2993MRFQuhS1vQnWb?=
 =?us-ascii?Q?trtVOFmOUQyJz/e07yAd9Xxt41TPU+xOMF1KjAApZLkF2yAN/ARSoGSTZaGo?=
 =?us-ascii?Q?e7MBUxAmnc4/6khVMYWPn4BBHld/Tose9K50PwONJ+CQ/1AWfb43N1Bz/FJ7?=
 =?us-ascii?Q?aBxNg1Lsiy9CxFqiPsMfaMSNXohbsWxQ0EHwXOw8TpGIDYOeMu5T6JYM6PrD?=
 =?us-ascii?Q?x7hb5CR9CZDIt4Yjek55XMMkBw40jd07LlVeHLdbmGYF5dHkrqO2CG1dsvFr?=
 =?us-ascii?Q?nwfm9EY5yTylz0i4b3eGPYT4bKcUfpUsY5OTFGOaiXXQyjVRlXlEmIN5zo86?=
 =?us-ascii?Q?xRAwSW7sEUr7TXDz5rN02kEwYMD5ePrLo78dTjfC4YqfxKg7/Ogz/5VS3qRT?=
 =?us-ascii?Q?h5LEVe7FY5aARNAYcxiWUkdDy+BCzaxpolU/HwwSuMTaxpSmac1J9C7xDCmT?=
 =?us-ascii?Q?yDwFWpBRLWHtPXqctV3fIjgfd7NS7gd46M8tFxa7olMQ5xQrhPS14+YDevJu?=
 =?us-ascii?Q?rBjSL5Ugq832F0xdtVt7ZLzSmN1+Gx4JLrQfqqRfY+4qu2XffWCsihJg21u3?=
 =?us-ascii?Q?YQCVD+ljGfY9EDj5s2EcGxeNVb/ETsMhKjy9XfEBpfaWi2vlteHD7NfBXOkc?=
 =?us-ascii?Q?L0XVLLeN7HjAXaRvqQlMlEaVyj8qTlVdDBqm/GCLdLMtXC5OnJQPJOsMe4aP?=
 =?us-ascii?Q?vGOat1CgMc+fbLITqXfujYckOottxenAgK6JnvvTJDhQJXPGTmjf+BvMLVno?=
 =?us-ascii?Q?VATdqJ/LkXesHcQfEUKnmvpYC7M2pssEMzqdoxCu2CI3CeGIpLKDBpHp3wHu?=
 =?us-ascii?Q?CAQwVtf3fTdJcYVra1l0Nnimmh1yuFZFA7Hl5rFvIrS28hNf+1IB2IR94eau?=
 =?us-ascii?Q?rwhcorfdtabK9XU7MTljQ7cxNV0gQR74uPZWsSq9E8Q+g/ob4JvcagZ70FUY?=
 =?us-ascii?Q?ArzdJpKEd5nl2/6i2+dN4F9ftQuZphln2buceOKCTYNWVoAeh13HYH4HhXlB?=
 =?us-ascii?Q?AXWrZPD6JcetneVFC1IwWVRqgH1ZZHgH8HI84WbrmvtPtWTI5wod6h7jStnH?=
 =?us-ascii?Q?Ywf7xmPyQq0SqCZsCMIOAMHZ79gARkpNB1aVcR70qr5S5dkkyPz+GLJZB8GH?=
 =?us-ascii?Q?nX/A8qhkbbT9BPfADHpcR78PmUvOOkK+mCRfHp9hhXXkXsy5ageNtivHkZaz?=
 =?us-ascii?Q?tUKIwJbYHs5JqM4G3mM4z9HcpEdtZmntXI5Xk2Co?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:07:16.3807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9438ffe6-c2ee-4125-6710-08de1bc49b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

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


