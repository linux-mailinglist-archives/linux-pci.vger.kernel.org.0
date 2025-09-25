Return-Path: <linux-pci+bounces-37056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3FBA1D8D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EA81643FB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BE324B30;
	Thu, 25 Sep 2025 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GLWNO8XV"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE7322C99;
	Thu, 25 Sep 2025 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839936; cv=fail; b=CJ0YTXVAR44ozIQNTNFWVFaYapOxmI/KHEs6RbkMIg1PhH2yliOTr+a8BkH1b0N3tCI9snySJq+Zb3L9H8/aKTQsDuOa57wdXgIpoacfYuCjTcxmT/aNMgKYuSriPYEWbNSnx+eo2Nd7nF8awVpknY/gn9C7ZrC72ALRs4s6usU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839936; c=relaxed/simple;
	bh=zEDufYZDmSgUz+gIQrRVz5s3HbwRqzhgKLMxTnUzcak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LW6FcEe8AH+nu/c9UmjoECH9vCvGIGKmVwLWiPnegFlg7ZWX2t2qqNUhELPxLfwN/XR5luf8TS4DdF64c3dwHwuzeetuMIwZyiDhLGWKm7QVRobEG9CC9BC3gRenCpktF9/Xp20hSFB+E57P5YVsDpnH/Hej3ievXRIs/8a82RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GLWNO8XV; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3RpX+Q4Xt/N4P2ysg7DL+jOL3A2oJER6YjiZ70AcdJ8ykxJaipT2mB5sRaaaqTTFI5vDRzp48EkO/ehs/KzN5slkiId4onT2y/lbMhOvsuo2wKQr98+7TjoWE8BNdVDayNc+qiIX4NfzOKEOOmVCUT5D5WDfMv14+DwE2QFyECOkf27bBt/xval/zGXWiM54cvMTWe3mfJck/ff/KFvHum4PAcayCpgiNJ74v+BLYLwI8hyRbYbP36eW4ANi+zbADDHZmBybC5bwPLdtGFUge2QclBzUWWesn1OJyMKV18cq9cZ1BIci8XfVA6C/r+m4MZJMVHgbEKirAJ6K1k/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vm3Y4z6Mv9DGrm74lAijUyjt4oYlifFpKnSulvd4CE=;
 b=KgQc4euowDyexX7fi04Nc2l5uhKau2HTBXaebm+5kQ3AbMW+JBgGoqpiS+3vZCcYHVcPyu2AWiv9BDXwCIJRtY+Nm+pjASl/TruPLB+b5gS/NQogbXfrUenplPLV6nSYezCYuzAqY+WktHhW+hRfdKCXkWK8Psh9IAtXWVh1T4jc2bscuUWJHYH9STYpZETSU4aX0r+3VVEBJokOcv0w9TlsuM+Pz5buPMpMQ2T/AORm2M4frDR71Q8FlKyD1Ksqw1QuL+18wFUFswNtpXLvAGKuYOA/Dr91wiLZQPc9wWoVMTFFBXVbYp/TxeKtHGkWryXdwEJnjyowj95x/pvUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vm3Y4z6Mv9DGrm74lAijUyjt4oYlifFpKnSulvd4CE=;
 b=GLWNO8XVRaS3Ebww1QMFAxGY+0TRIczuYng/csLtouZUFt+GQlTsJJFxFtD2y22MaklXg87ZsFACEKJrgf7fNfFYIdImHUnTmlk6WOAZL7+5nik5kAnVBLb2TaN9+K4TrIFUZuST+WH8tINxPbx9MaON8aO1FEH0vAqzgnIgRI8=
Received: from PH7P220CA0062.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::28)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 22:38:51 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::ac) by PH7P220CA0062.outlook.office365.com
 (2603:10b6:510:32c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Thu,
 25 Sep 2025 22:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:38:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:38:49 -0700
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
Subject: [PATCH v12 22/25] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
Date: Thu, 25 Sep 2025 17:34:37 -0500
Message-ID: <20250925223440.3539069-23-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c9b344-3f4a-4291-8367-08ddfc844d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rnr4+VaiS7s94yEvYmSuGNw02cTcWZWCBF3Uzw6FhHJw/TVwhdeJQXUYaEt5?=
 =?us-ascii?Q?IejgZ8DYInmw3XNLm4f74TCpDEfEGHVzRAemYuqwQzb4igq7xYGBwOBLmrSi?=
 =?us-ascii?Q?uP9hCgwB491SdfHiG8K+jTMsM4GeObxQxkM8lRHB/pjXWZQqP0AUS6TdHAGP?=
 =?us-ascii?Q?Hlpg9SRDiRr6+OUCfl7qE8PCbDZ9j1S7Aw13PHo5JW2CNMxcimfcx52KBEmS?=
 =?us-ascii?Q?9WWM3QGUepkCXJY0ARzvPTfc3hVvyfA8ofUwLnjCxF8TvZh8Gjaf2e7BzRzp?=
 =?us-ascii?Q?iVpvf9WTTUAYrWvITGvhNtpC3zLlwebS8+jFHEIHl+r3kwRGY6dnjMqmGq/F?=
 =?us-ascii?Q?iXAMskkxUQPT3/JlhDfh4n5qnAL4hrnsV/uZz5PmKn0H6QbOBhLdSA0puyXZ?=
 =?us-ascii?Q?4MA+yPn2hePkUg8JxXgeKYl+icmlFVeXD+h2AGjGgNtX8esnOJcnJ4m1Bgar?=
 =?us-ascii?Q?jn+H5WcFZoaQCXmdExFSr8sDUd2ocBE855JzPh3w6t42YKWmyB3PioozAb8x?=
 =?us-ascii?Q?714twCa26gYMFznNNz2tEO9yHvzxkz/P5+eTD808AfChbfxnoEGnrQ3PgfYx?=
 =?us-ascii?Q?OUFam0wfAU6SHDo9oSYE0Z4LFsiRzNCu24PF83ncLMw+SwbzutH2zCyPKZ7u?=
 =?us-ascii?Q?nVz5L4JOJnvYHCrvz365VavmRetiIhgoUIEoEWmGbP2eJ/YWoHUhjURZCL10?=
 =?us-ascii?Q?sMqXh9P7tsMj8zaleGGZFspjbj5vVCdCgVxL0gHMWpo6HfuG+vZA/KS+iT+H?=
 =?us-ascii?Q?5znlwblMVkM335FhNlvoG++oiW6r8P1iiST3kIGKPR4FotY/2GMo6xcvn9i2?=
 =?us-ascii?Q?nXLuu402Ce0GKyGO9niX9DZlTgHnRYQWMSeaQ9T1MA9BH3cKUDWkZGgUKoYU?=
 =?us-ascii?Q?4fMRRcqp8Fg61Rp5lOW60xESkzOTzJRNj0WIAB66DVVGbTNux6mSK8pZZtpo?=
 =?us-ascii?Q?FxB5FBAAwJfer8dyQlbCenjCeHbKuw/G4jubfQUHTbVVUj77qhcl6YvRrZ/f?=
 =?us-ascii?Q?GWeuNsJV90QgguXEj3iAxOi4xgaw0AbXx9MbB+WHz+Pv1bP54UN/fCy5hd7W?=
 =?us-ascii?Q?8yuKgYNHcViKDZfByxhkQ0ijxPhWJCd9eR77qdtkAo7sOgzy7O0up+3+ylsU?=
 =?us-ascii?Q?zKaB9nOWDUwNS5qKxwLQrIIk3NeSN/0OxVcaab6bl4MlvA/cANFtTpHeq1vQ?=
 =?us-ascii?Q?UXmeWP58lVa58dG/efc7khZXe0ReDzWoSW4AOH3+o+bZuT+MfuXnfZ9PNGo6?=
 =?us-ascii?Q?+W6ZcEtauMeLXklCAy+QUrBf4Au7tmaxWcPulp1kMhmzQv4zUe6jTHgd88uM?=
 =?us-ascii?Q?kMWE8veKXhMXd5SRYinTRqFfzSzIqRlytmK0d4U5fZN02GLwKsIFSZo+ErtY?=
 =?us-ascii?Q?lw3ZpJa/s/esgY75t5Ave1Yj+A4Yaiv32ZpptLK04nOH4dSXMRqtD6F9kHsW?=
 =?us-ascii?Q?DADGPP1XNGxo5UJAuY5YErpSzKjnWu5D0T4I0Y621k/mfZO9yP2yoYXWVYI1?=
 =?us-ascii?Q?dieJDrgFfBocaFp4JxNVmJXPN3aAe54hANd7F/CFqr3GHEr6LxELEZBibN1A?=
 =?us-ascii?Q?kB6iaVI77ctagO4bHvC2GT/UZ65rrB7avAlE9cfg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:38:51.3431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c9b344-3f4a-4291-8367-08ddfc844d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

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
 include/linux/pci.h    |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index de6381c690f5..368bad0cb90e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,9 +21,12 @@
 #include "portdrv.h"
 #include "../pci.h"
 
-static pci_ers_result_t merge_result(enum pci_ers_result orig,
-				  enum pci_ers_result new)
+pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
+				      enum pci_ers_result new)
 {
+	if (new == PCI_ERS_RESULT_PANIC)
+		return PCI_ERS_RESULT_PANIC;
+
 	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
 		return PCI_ERS_RESULT_NO_AER_DRIVER;
 
@@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
 
 	return orig;
 }
+EXPORT_SYMBOL(pci_ers_merge_result);
 
 static int report_error_detected(struct pci_dev *dev,
 				 pci_channel_state_t state,
@@ -81,7 +85,7 @@ static int report_error_detected(struct pci_dev *dev,
 		vote = err_handler->error_detected(dev, state);
 	}
 	pci_uevent_ers(dev, vote);
-	*result = merge_result(*result, vote);
+	*result = pci_ers_merge_result(*result, vote);
 	device_unlock(&dev->dev);
 	return 0;
 }
@@ -121,7 +125,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
 
 	err_handler = pdrv->err_handler;
 	vote = err_handler->mmio_enabled(dev);
-	*result = merge_result(*result, vote);
+	*result = pci_ers_merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
@@ -140,7 +144,7 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 
 	err_handler = pdrv->err_handler;
 	vote = err_handler->slot_reset(dev);
-	*result = merge_result(*result, vote);
+	*result = pci_ers_merge_result(*result, vote);
 out:
 	device_unlock(&dev->dev);
 	return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b8e36bde346c..c7e8c9c5fda8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1894,6 +1894,8 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
+pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
+				      enum pci_ers_result new);
 #else
 static inline bool pci_aer_available(void) { return false; }
 #endif
-- 
2.34.1


