Return-Path: <linux-pci+bounces-37048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3513BA1D57
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5DB57AE51A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47E322768;
	Thu, 25 Sep 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="muRt+USX"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683F322DB2;
	Thu, 25 Sep 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839846; cv=fail; b=vEAxYxSM2dhtZQASdkmMDFvxqGY1emn6tU8wSp3p+J3r7sFNrl8dTcZsIChzdVdkWojBjkwL5qE6H5+eZQBUxniVfcsfPGDsAdo00PHuCtAQK2f4gU8qtLIlkXlD4QmJd/lQbEXywdy1rQGGH/7YfsoEDJoXuNN+N2f+VLleTsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839846; c=relaxed/simple;
	bh=5VKuajHw1hVLLnl8E9rA0/hYNtMU6JO5Ru4T7rhqKNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMn+XPxoGbpadDYciTP+BIbNX2HrMZ3g5saTp/dhw0qNwTAVbocgKm7tpoPrR899Z+Q3rqFeIejIIAYdHs1uQZTucSdoF1KhWvAW76FZrUDQVQQYxUir+xkoRj758fNTTdB6xIpeaGiyHJwcFSfQnZGCReB9sF5pk9xR+iYizdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=muRt+USX; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcWu958rX0Z0b1EvfwOBwNE9Y/2d19f7B2LMft85chcx9Sz1I2d90diB3uH5bvaYYJfEvvbWvOMZe1ubEJJKmDO6FCSLsskpjHQPCtK0/zP3gd7QC4dmJICObCov+5Vzpo9969S3QbPn6Jx7EwCU6LBRXwOQ3VbHuUKoJ3c7vp3ciEHcw+U4x2OMONtB7wThRstcPpO10dmKn8Z/IgcP6vuoRnOZjMkj992hiwaPN4Fh5Ry7VXzno1rHFDQHBwEA8tb/51L0kLm8E1HVhHTIkHu/YNloWZRtJnzWvgyFqiX+r3SCV7xLu6mh0V5BT7h/uPbPyxlbjV2qai/TImsW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgXP4STDBF4F6vyOgTayXtt35NnZrbOImFKjycFPIto=;
 b=GYQmYYtDVStzjUgxCG25QObXr0HnRTJTOclEguEL1fhqxepvk2XPbiEqXbDCJ44mbx3I+aTW6dGjZJOuBVLDI+GdJo/ZKas0I2rcGbvV8527ZzMwBKrJ5m24LO1lTBGUrncXPY3D90lrcKQboQ2hg7DI9btNmB/Db3FGhKRkML9RrJbKQh3BoofCkzWUGekGREayD7alAfldCpNjTz92cYP7LUssU+3D15jJ9DY1e4F+p+aWlvHYTmX7biZy7Soefznm5ndPo2xFP+ppArno6NXI9FCtrbcdh1h8BRr0w83Ag5H6wRISl+m9aMltdHIXSFl8/+0UFgNEnn/sHiZA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgXP4STDBF4F6vyOgTayXtt35NnZrbOImFKjycFPIto=;
 b=muRt+USXHxjT6bM+/+xMUMe5klBuJbMK9y3eqRo59mJM8zyxtLyOSRwPBq61k2o6u3Fc13YLztWWnyQY6bOeUQZy9VXuM+p25dmzvyiKADuB45iMJvCh8mZI3EcwPANM5eiRdaL52qgFU+x0o/klcjHT+52XhQbU4YusPb+0FWY=
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 22:37:22 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::66) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:37:22 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:37:21 -0700
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
Subject: [PATCH v12 14/25] cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
Date: Thu, 25 Sep 2025 17:34:29 -0500
Message-ID: <20250925223440.3539069-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f5e2cb-e166-407c-dd1d-08ddfc8417e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cDlAa9Ao8nlNQtUXy9vS9G3pni5csTEUTLLGj7giMQqRqUUsMqOy3fL0i+/V?=
 =?us-ascii?Q?KjZ7IL1puVS1l5gppUMXxK8sq2YWLjIZvLbj0Fk47mPaCRu54OZxKPLMSMVa?=
 =?us-ascii?Q?6fYe2VRfYpMR5PoKMhArVf8LaZmlSiW+r8zjEv7Sj/k43factRBgsGfcxMWe?=
 =?us-ascii?Q?DN/2rlrdqnrmvIAJIfY+pw2LB202rRH7LqWBK21OeFFGz/bjZBQ2SFkmYfzL?=
 =?us-ascii?Q?xBYTgpumu/xXn+m0oaI7y5KQfOuAdeNPjmDdOG6qEJPeHvrWC5X7USnDzPur?=
 =?us-ascii?Q?/wFwaNg4ql9hKEYwNSywfvB42fPjF/E3UsblEUrf1qJaGRzORY6uDoiAtroJ?=
 =?us-ascii?Q?HkUkFcRJ4FfwdEcwuLf6SjEMUk0Xhh9WkNPxA/Btkf1py/toCtitGS7ZtKX5?=
 =?us-ascii?Q?4oERDkYkQ2EsAGlsxV7mMTaGPZiG6aPC8gDTExdT5kycBB7VaDB+OBauNDtL?=
 =?us-ascii?Q?VaXGA5KYoR1eu+hOfiatndkXOX8XvnCBHBGfJo0aU/D2PDHgdAk+WWE2ZhG/?=
 =?us-ascii?Q?PYgSPD6BSRNTAEzf4poL/QQdK/czdOXaHjdMTt7w4KsMfuInGgV3a80ykPeq?=
 =?us-ascii?Q?SkVby/tiJIU2dRnpE82t/KMeudUQvpMn+9aIA3gr2ibzGyRs+unYYwStVRVh?=
 =?us-ascii?Q?srlWEaBKG/w5/auSMsG6091i3A0F92j946HaN2jMIE65HWVRWoZ+jb/6A7ej?=
 =?us-ascii?Q?gL+6w/04tq8hietHnNEch0zurWBxc0zB2yRMichsyBU1c61HTf2Pptj89Tum?=
 =?us-ascii?Q?t0ye/+yyBSIrIy9n+G/0thjH01P5DUQtq9U552Rzms+UdKKK/vN/+z0j0Nkj?=
 =?us-ascii?Q?3TBuIlvRu3TFdAzCsXCLoQgRjlOc6Qv5fE4gZiZSp/8O/ArvWrstFnCErs7w?=
 =?us-ascii?Q?gmOMPA9hK/elxMZNfelQRfQx8Fq/sAl3DrLpuGEnlPTwOrJdDHPfeq1O4nMh?=
 =?us-ascii?Q?El6rElMjtc3n6Gru9eyMb37OJff/nS//TPe5b9+6d1if7sQga4TBCj5v6LlK?=
 =?us-ascii?Q?wa1wJJ6bH3zuoyDKVacepRgCtHqvxxVbT+bm/Il8AhKFDxmD0eclp3gebnbX?=
 =?us-ascii?Q?nposIcEYXVqMWixXMgupgCKT1Kizivg7emiWfGiJfKJ7MGZAZabbxvHrfbVq?=
 =?us-ascii?Q?UEDVe3zmhVCGHxSyNkvRI83qkS3GdCAHXKFrZSeFWaAB3/XaJuJVaiPN2BVf?=
 =?us-ascii?Q?wJ6WQLOqliWjTjZTxuWl9+uKTvjuHwBcCxvTkqSVVZ6O3a/j+ko33j+m5NFH?=
 =?us-ascii?Q?HSDhAnJ562c3smyKnvpv4paetqST5NOfcwdYKailPqNno3vQfh+UqvfrpUkG?=
 =?us-ascii?Q?3Qdzio4uKXC4LrfolM5vmgbTnj24pYaXkBX9ymh0fSwqEnDuita1JmTE9lRD?=
 =?us-ascii?Q?qlAQJdZZfzSjPS5oLt3pW/DC2Jr7nAAD978rQZgESKpyyIxPtoXcTHOpzfDx?=
 =?us-ascii?Q?RAJ3Fqe2s92nYi6VmW31dBh8vVthlT4l4huBNMZUb4s1HKNJP4Eb1GdZoGc4?=
 =?us-ascii?Q?VMUHkPHJ5hJRmnVJ+pGN0KWtp0OCyll/4xW3PSCD1Z2gGJgNEIfKw8KjxpHf?=
 =?us-ascii?Q?Q8HH1LfT4uiqEJIClBLHn3z9paxBYn3v4F1iWwVj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:37:22.2244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f5e2cb-e166-407c-dd1d-08ddfc8417e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064

Update cxl_handle_cor_ras() to exit early in the case there is no RAS
errors detected after applying the status mask. This change will make
the correctable handler's implementation consistent with the uncorrectable
handler, cxl_handle_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes v11->v12:
- None

Changes v10->v11:
- Added Dave Jiang and Jonathan Cameron's review-by
- Changes moved to core/ras.c
---
 drivers/cxl/core/ras.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 8a3fbc41b51f..97a5a5c3910f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -295,10 +295,11 @@ static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
-		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(dev, status, serial);
-	}
+	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
+		return;
+	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+
+	trace_cxl_aer_correctable_error(dev, status, serial);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
-- 
2.34.1


