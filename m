Return-Path: <linux-pci+bounces-34837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30FB37736
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45B84E3036
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01BC21D3E8;
	Wed, 27 Aug 2025 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JFN6zyMT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2111F4162;
	Wed, 27 Aug 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258775; cv=fail; b=mHig2w3aa+s5PokvP6nQLC1ZpTHBXAhYGaYGGwSq35Ol0slV3xotGZnfzct/PiYUq+uAtj5o8W9lGu8jIQBwuXUsYDkPDMVMvymWWmVv9xHvSw7buJCN/J34YBNiTO3esGEvD9nw1JoM4ehbmi4UDBtubd5ROUH2ljwUvm3nOxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258775; c=relaxed/simple;
	bh=2erO+IGwseaOAl2nlACqulOK/cyNy/tK36u3kDpdAxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Caxhu7Smm2PV7y+NE+P/oTjjJLW2pBTpLtA22CA7ZRRN0i1EvXVboTptvdspfkj9T7nTrQFu96vzsPjBqSMXDBE1j7M65sftIpGUz6ga7KMHOmsCofll0L6rGdVWMC27tNLtedVHBVwmvD4KEPaYM+3hcfFazDiLV4i+fsMyBjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JFN6zyMT; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvnEblagecLg7gMl0mFBDeHfgXkFhcAU8sDvRdZ/ExnC7cW+SvyGF5FvcK1zJFL1VjpOg9jLLwkIro9wuWFeSWkxJ2ljBPRpcn1qRIsKAiGoytHhyIB8eWAmFpxoaMq86Z/9jAA7e38u0hb6Jq/3iOTNO0uXJC+8efwLsxhQJOOYovhCYOk5X8o8PGGLAd7lGE9O2Z5MvDTaT2E57LI6bO+LPvsjGnDjn06DVWJVf0MwyIHr0FSbCjY4NjArYFoNcpQVCR6SbiNnR4OR9ihaZZB1WAwapoImOBJKUv3LjX1wfpY5w7Jbjs3mKwpVwodkhkbrE+gtIdZqRLRwXXFY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ombJm88ywBztVUcj4jCGuDDICzEnfspcxOelxAC6npY=;
 b=dSHatghmHPp8z9y+JpPP5SXhxo5a28KxJzHPalePxOcHsSHdhd5NiTXyq13JlQ56AwjwJ+f6Hkz2J1TocAry/vl0rL/pdekOkFvhYTr/Piaf4fagFSAQM0W+0Uj962TAj3IMtvKl+VfrmozsBSQHnyjMYC53jdVZnuxdIKQ4aZwg2xOu4Eq+uPXPyMT4mgJs2cPSwYGvChRR2CMAdgeSwCGIIEVSSzQrU9ZjanK8M4jG4a3LAW4mviWSL6gcP+IOlrE+JpRUpMSVGMFyKBgXX7WaqZ2kS/0+by2C3nb1nMBNbT1U6aalsGjji92TvxjnG0ry5FN1HRl9cWlsmIf0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ombJm88ywBztVUcj4jCGuDDICzEnfspcxOelxAC6npY=;
 b=JFN6zyMTDQEUSQ2YHr1YmQr7jk4xBQlF93U/nHX5Y7qWweOE9hxA90725GT1LwQ0XilXOHXfVKPHc5DDPh9WLcWkPzKW02vwATsbQJM2uHtOSa1dK9qhtKFwXpwoKoXfN71WjgSUoBevhOSf2u3WMHZ88/h23urHDihfUHSAw78=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 01:39:28 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::6b) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 01:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:39:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:39:27 -0500
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
Subject: [PATCH v11 20/23] CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
Date: Tue, 26 Aug 2025 20:35:35 -0500
Message-ID: <20250827013539.903682-21-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: a20f5348-7bb7-4a4e-3e00-08dde50a900b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTt8HiAjNfmk4r/HfmVc2KTEidAsxJhPvBnjPRlf6+9Q1fu7NGaS+IuSz3lU?=
 =?us-ascii?Q?PzYHXHnMfA66lHbvzZfhk9Q5h5igg5UyrTBSt0Z14DjGdTpgahpOWu9fC4QA?=
 =?us-ascii?Q?Z1sbCSJ731+R3sll2ltwtP9OfBCe1CYOmC9fGIw8QyIYiRzuZz9lpkwHpBIN?=
 =?us-ascii?Q?qIs20SxALrYKbZenEZ6+36BcSoO5I9fVXB8j3bGGo3v+TJ5KfeeSOCqVtvDg?=
 =?us-ascii?Q?VXKCxP/likk8AwdV17KexerhajI7JvSQ+2d8bfp4YzJzTjtM6aWIGuRVHeub?=
 =?us-ascii?Q?iY0LW2Rxy6f/4B9ZMGaaDP76auQv8Z/wb3GLGL2WM2NGhDFUOhBx4ch2IT1v?=
 =?us-ascii?Q?uLeJ50D2CpK3JXnXPnXLkxPgIkZTqnaz6DrImSSl+RA3hWspxRW0VkzAH8BD?=
 =?us-ascii?Q?bprvoNvE4Rok2pAK6zIFi7oEJkwWGF3v4Y27ueRp6gYRK3U+g39qaXTfRQra?=
 =?us-ascii?Q?frjgjpcEKC28awQrEI7zv31o0Maw09eSmOc0m82SjJ5udHkaJHgO7nsWLGtO?=
 =?us-ascii?Q?7OwPgZuA1EKR/DW1RAwgk0Zg69iN9Lh6ewJpEhgC/5haGXazrY/TGR3+RXGa?=
 =?us-ascii?Q?ohh1tjecO17Xo4C80MEry02gqVVcfBL7YsEsAqYG5L/w2IOe+ANKnVNv4BpP?=
 =?us-ascii?Q?v9FBdXrVz2+qUdBNMfEnFb0/Vnn/9xf+nXXQpCxA/V+MR3mtCvUn+YjXu+WT?=
 =?us-ascii?Q?kqycyWoQnnXXiIXTivN2zMZYvKYQsv5zvIa0JHt+OM9I7TouH/W+3R6mgEiW?=
 =?us-ascii?Q?Gu1fSrDlE7xdinJbLulVsf+Zu3HJ3WJ0dri01bYqS/SzCAmQzEvxAOnAY2k6?=
 =?us-ascii?Q?atdwThrPpHo2K7CPUJcURz+3o9RJcoy5v7n/1Jci+H6kGj5IrZh5irajAoWB?=
 =?us-ascii?Q?gzrNrymvdYTnfOM3JSe5ZTrdSmVHg9qnGdGA35LVxEneak6m7hFdpX/yiGfu?=
 =?us-ascii?Q?F5V1eVSQ1ilyAE3G0kU8r6DjHH0hAdHfXQsVEL5lRuz3thAk+d3qad+vNcRf?=
 =?us-ascii?Q?qkCQyyAfyVa0iWbnua5y165ei6tjYmIVwH0D3ifwRvcU9x+4HZ/1p9bZ26Wx?=
 =?us-ascii?Q?bCvQuReRLu2uOuGBFyZHWuBMf6NLw6QMHcvkqJd2Rkl4tRySIDR+F3mHhPeI?=
 =?us-ascii?Q?mVkUWsp5PG2w/OI/S5wC5mytNIPItmXdC1lXw3Z2L7ehG+t9KTqmcV+9dF0F?=
 =?us-ascii?Q?WjwxgvE/2GhQh3/EoLcsyT+lD/U/92DuSM7aiYIfBk/QtnFJgCZy4aaDwx2M?=
 =?us-ascii?Q?uoHOV0NyWlNDNpNANlaPp4bl7suf89ecywLtwPEC8Emd9yUFzUGRDAIABuKS?=
 =?us-ascii?Q?LLyNOImuRXp27OEd1ox73wnX9M56Aw3wmRgNICTp2u3yuPtfne5gM405nc/m?=
 =?us-ascii?Q?wI/KB2Ap4hYGhICU3Y3IPCCDB0//tU8Fc0u1RZ8XmN35otDR1ZDyrenJ7mWL?=
 =?us-ascii?Q?EawQ7UXIcNEmYSMw2BARCo4vELgKn1110zazlLdylW7/EBXEMTuj6S9Xuyum?=
 =?us-ascii?Q?uJf7q6tOUdGKJ9XmMwGni7dQq3RCq5sDLJhaKVofkWu1tKtVm8XI87nWgQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:39:28.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20f5348-7bb7-4a4e-3e00-08dde50a900b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

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
Changes in v10->v11:
- New patch
- pci_ers_merge_result() - Change export to non-namespace and rename
  to be pci_ers_merge_result()
- Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result
---
 drivers/pci/pcie/err.c | 14 +++++++++-----
 include/linux/pci.h    | 11 +++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

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
index 3407d687459d..ff6812b2b9b6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2760,6 +2760,17 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+#if defined(CONFIG_PCIEAER)
+pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
+				      enum pci_ers_result new);
+#else
+static inline pci_ers_result_t pci_ers_merge_result(enum pci_ers_result orig,
+						    enum pci_ers_result new)
+{
+	return PCI_ERS_RESULT_NONE;
+}
+#endif
+
 #include <linux/dma-mapping.h>
 
 #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
-- 
2.51.0.rc2.21.ge5ab6b3e5a


