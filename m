Return-Path: <linux-pci+bounces-40245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434CC323ED
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C873A8365
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46733B6CB;
	Tue,  4 Nov 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V20vUP0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6C33B6EA;
	Tue,  4 Nov 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275940; cv=fail; b=odC8Oz1EOC7iIRRxF7siCK2xMoeQaXVfEVRwPbaloFvpQPbogj5pWts4S6hgH6KBuQPXBvod7VcVwS+u5ZnedlUOKEEN6kTcNJmWD6Yhn9vk3f4FBbd6VKvxiUD8QBZpFFXA/JkYkFS3d/MNwan/E2MhrPI8N7bDsrpnbG0+EJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275940; c=relaxed/simple;
	bh=S1GJOFDvnJn33tqp9bq0GYHvEvujlUKcT87DgMEnM3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8PrI/0Hcc9tecds/ja0BKMpjT3l1F8iSGV29IsYO5BuT5sBaqzMPuJUaqO3YuYwbPoujfa9KESESF1k0oj+8bqiTiQ+POX/T/Rp32yPLEGhHy429mpps4IFrK/CRmuOSWKI61CPBuYSahpxUnez5g+B34KG0X/ESHF74hCF03A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V20vUP0V; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb+ouiaVleB1JFpx879GZmS1s5rncTqUrRHvpb8Wlvkxib92iBenfRhHjiHAspZNcP6PZFYKBPhZFBnkkg80c3CcLSLtV+fG1UVomTX9zvLIMltDqtQ/LheBkGnvh/A5tf1SVwjGUQf8KETO9WSSHVDGAV6IP+52B9vdGPifvMYP1iXElTSFVlYKR6np1dSQFf9vu70J39gAzrgYppna6dA+97z91jZEzHsicfX3zti50eynDffcyVyI8xQdv1H1Oj1bBCEcIqehBUs1tHhuctva2OJOih37bJZVMNAmb/Xu2YD+UgQJI+M4vLJlqwzeZlPtmeeHeHLUJRNw6nUeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SQw6cY4AnYl4qnREhFU0Y/DyMgjNSKH2BQMxNAAyX4=;
 b=pQCfGvrnBBgJ2FeztF2pRugIU93oV7qhHT8c/5LEhPSU2ODsP5Xe8kBIudeZ3tZf3KaTj8E+svLoYN1PR4T8TDzOrodrWBdqwmaCnluHw/0PkTeVGZsJnIxlcGsGfDURebmZsr/ZBXrHzhsM6cQIDF+HtJz4F6go1SdDX2bcPu2DZZ+sbwVb4Xa2m0TjTZOYOt163Cgs4d5mivRp431RqyJj+Vhwo4LNH8NOCrWMA8uJg7ISG1R7o6vxsRdnfbbwgpUNgZ67gMTwk1CNS+gpamgacWzSUIShBshzSg170ra1p0Q/Tg8kFOP9AV3i9EGCKaMaBZabNgQ6B2Vzg4a3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SQw6cY4AnYl4qnREhFU0Y/DyMgjNSKH2BQMxNAAyX4=;
 b=V20vUP0VGE/8wXCR5debkmx8B/Q1BC/WFW1NUDgid68uIqUuFZdumBuJytxI13KQj/QMxN+BJ98i9xUwFWbbT5Fc3QoR7pzKIRfHpzms1+2RgXU1J3YoGGWJngF0HhQ6W1y3g7/2jZRxIBVHFgbRlmWlmewuPmUYchwNgsJAGSY=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:05:36 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::18) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:05:36 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 09:05:35 -0800
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
Subject: [RESEND v13 13/25] cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
Date: Tue, 4 Nov 2025 11:02:53 -0600
Message-ID: <20251104170305.4163840-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 45977830-92df-4a95-c103-08de1bc45f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPwJqvbZTBTpxJKi/dQycRRxmps2iidcYP22EAhaVfsmUvococJRz9cwuzfk?=
 =?us-ascii?Q?OOVB6lJpmBZc6yu6JVmBvuK7iNukvqhwFI+qiXgeyH5Sias2VgR1ZcvloQDX?=
 =?us-ascii?Q?YeFKXTBKhH/nLzDguQ/IgRtOjnGrPNibDxOUX4yYZr+LeMjdlwhJG6bOvGyB?=
 =?us-ascii?Q?gVrS1D6YvtZpRjNNhiw8KawRI9jxDNYyEPAVXIMptRdgKXIfss8jMX9OFYCS?=
 =?us-ascii?Q?WSwZk6Ta95RXji/7tEFwfwvRnz+Vr3VnMQtnH7B55BigAVTR5+kLV33ESW28?=
 =?us-ascii?Q?+ex9YWlevZXNRExHkzHmEPBLIMFoOkDJO2qaL+2cPgX/hW5MhID3g/0nmmMh?=
 =?us-ascii?Q?lZxT8e0UCdqESu7VhH9Vci7uu9057cRxApjI95t4tvtbqLpIC4feWgQCxcvT?=
 =?us-ascii?Q?FnMOc9AH7NFs2EI9bU8xPkXI2so++9yC1/+CziP+/YaK4ixlOm9qYOgu5bIK?=
 =?us-ascii?Q?4hBJ+LNmm+WuK4kOUauTC9tcGQKjEZws+ASbTmVVqrnMOMBOpp1+KLTvVvRq?=
 =?us-ascii?Q?1a07QrO8bcFJZpEelehOqUkwTOpXBixgmiQqXBBAELHDTu3jnRTBf+v3HWgR?=
 =?us-ascii?Q?rpLx74FaCJSGRsOZeTSEB3gJqzqpnpyBJtf665Qype8S0jyJk14T5vTTXkbJ?=
 =?us-ascii?Q?uT87myckYy2hrOL9oRV8azKzCcFigrJzHzQCM7sddesMvSMlw7NKhe/bHUFe?=
 =?us-ascii?Q?lgNrhMpiC+LLtOOwdCWAl5fznl2sW2oybx68Uq4CzhKday412D/mtS0+YTOZ?=
 =?us-ascii?Q?g8prcc9acsyM3OqZFkBUb1LUSEWA0zbhE9bZVjv8g+3SR8TT0l5Ivm7ztZ7J?=
 =?us-ascii?Q?MCRc1yMdS/ZxXRnuzVMhDo35WNBSXwk4v+J0DyFblLqZ4HeN1qliDrnDslNg?=
 =?us-ascii?Q?5WVNPZiVEbe55EYXRxPyP8GHCnhIVTsnZl1yyyU68sIBV4o90YQsudci1eQ1?=
 =?us-ascii?Q?N1849t/QXjpNxhiuYNEwQ9MkYUV2znZN1s8O1+rbpDdnIrolKNTGor9vNPCR?=
 =?us-ascii?Q?XaWYoKzfIzGxwmBL0RyZnNJx9BluBYadtTvmDD2kln5PsQe+W+yDj/dsffL0?=
 =?us-ascii?Q?3FDsVWSNhgGekXJARbDKHwfuBbKdSDYrEAQNIqX+IxAtX1msutCo70xeQRFR?=
 =?us-ascii?Q?R73lolFBbsKLmdX9TzTkDE/pqiAqlxg8AnbSMWsGWV8KK/u3B+v9aiFL0aUB?=
 =?us-ascii?Q?WpB5KLnxcZL2mSghp6si6mWT7hoEYfwgpj37DdX2lkiKFuYt5qB2ef5d+2OD?=
 =?us-ascii?Q?j1mjMlmKXxlIrTGTz7bC9eEHgJAHfoB/Y7d1eoHih1fLhwERDkVa8DpLeN9F?=
 =?us-ascii?Q?xiNRRbTZ90SZpTbfm4YrJTP5qaiOGX9xoaooyYeos894JHbO3J/uzPfjCzN6?=
 =?us-ascii?Q?nOmfXQlL9dRljcUr9yprDLd7jm8pQkg42ACKqmBJOYV6IEaZjZ4tDGigkQyl?=
 =?us-ascii?Q?9UJRW0oSVZ3Ypuehyq/RcQXzTHna85yftLr1xtC9TdZnfABedSt+D/N6jQsZ?=
 =?us-ascii?Q?f8qdOobC6HfJ99DyfSzlTEqykc4vdvmgH8sseuMpsRIIstJSe+nkkOJ7vuQU?=
 =?us-ascii?Q?LhRvQx+sQ2BKs7p5jvBVwtigJQrHWOqjahDWRDJ2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:05:36.2954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45977830-92df-4a95-c103-08de1bc45f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

Update cxl_handle_cor_ras() to exit early in the case there is no RAS
errors detected after applying the status mask. This change will make
the correctable handler's implementation consistent with the uncorrectable
handler, cxl_handle_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

---

Changes v12->v13:
- Added Ben's review-by

Changes v11->v12:
- None

Changes v10->v11:
- Added Dave Jiang and Jonathan Cameron's review-by
- Changes moved to core/ras.c
---
 drivers/cxl/core/ras.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 599c88f0b376..246dfe56617a 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -174,10 +174,11 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 
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


