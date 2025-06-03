Return-Path: <linux-pci+bounces-28896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DDACCC0A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6A83A7420
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCA221280;
	Tue,  3 Jun 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="37BAwVJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FF1F4C8C;
	Tue,  3 Jun 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971497; cv=fail; b=Cv9POotVz0WpHIrSohkE1EAyRjLXBdEcDHF3/WeuORJBv2jpnDt/Z6+zkUix063ppHnF4vLlV02KddQyDcIS3jTw624GQbizM2lfbTjk4jBSUwVaAy+vlAJVxAl6Ui4flcLOZMz7ZgTK03vJOh0pqc+os+YQwgrMV/lXLIqEiXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971497; c=relaxed/simple;
	bh=5Ob5lDqm2IBdhcRJVuC8Iq47QenJgA02VTeY3HwSup8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+ccpHu66PRWD3wxQ+bwnVnPdE+BE08Dki43Ekt8aies0F41MRQGeYDsFtUeo3TZF49kv0CGC4PCgyiHO7ZxibGxKlvjUOR+YS6REVekrf0hDB/4YzkjJd6rcODlkkWgz+iVOB9a4OGYbfSkrfns+Afxhx1kxu/0ehxqRO6asJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=37BAwVJr; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIKV2zyyhBO119o8PfJDtXSVVWi+HoZVxoigttQBsPyKTmX079jFIw/a1fIp43A7cn7lsK8tI5JY3VREEQB8VNT95Btz7wkrqKuNP2hlGwu3GvyZz/iLxsGwaATJkCxlZyCTgyIRlYiezocSEoYDi0yjpvyGtH0ev10w/3jGs3LSzCUxBUiyKf/L7mfLZ5KEaf/Sq/A+xqJdXE3QvidHHykBkJRHAiRnCaUUeVnMfXNs9biPAKqj85809mmnoWC0JrMabq1L8gJO3833joKw9NukSalc081ewWxSuxvIhdPo6OGdko8MuNmRffnki9+JVIlY2L8YdBqpeHY/VfRa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJWq8kxUMgTDAG0DNXx57XXasyowSKzMwqiPFuHACeo=;
 b=QlUUeoOxgykCrix2UOQjBMho7BOM7uFUnk5328g7RFfAqo0ubGyhaJJWUzcAmtEzKe49cj0Ors3wCQ6IXKopINjz5CnP8CpG6BGM5hqq2sxVohTNae1nFIkYRtNaDQG8JwpoXLP4JyXQ3esGSTmeyJz5skDMdmho6Mf9VFjpRHaesIcF7uxAfhgrN8r5TAAH+ITdxEhxrhE2vY7A3hKIFpaW4uclaGSLDfAyqGQbOQhkc3sIGb++NNgfRhMD3kcXOssLbdcjiZJdFc2x3KbdEly67oh9PzpVEryXpBUTrYH8rI82ID7qxLk51JdqoxtW+cDaBvYiJUg/Q91LK1HrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJWq8kxUMgTDAG0DNXx57XXasyowSKzMwqiPFuHACeo=;
 b=37BAwVJrOjCvq6TT5my055jsHs33mlAl0DMzcW1OrLJBtOrgAHfL2+YSr58pU31f/s0O/UWHwG6KEyuV/diufistG17XLK0q1QQloUGv9z4Eq8RmQqGRTyLmLZDIoENFkA8hZHW7jmXfasNWcmV3CpWcwQzVEIqec1hi1TXOvMY=
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 3 Jun
 2025 17:24:52 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::39) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 3 Jun 2025 17:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:24:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:24:26 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 09/16] cxl/pci: Log message if RAS registers are unmapped
Date: Tue, 3 Jun 2025 12:22:32 -0500
Message-ID: <20250603172239.159260-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b1a1ee-5318-4467-0ddb-08dda2c38c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYJavWLNnubiaPB4gxQPxGu1eLp3+/t3K1LEKuWR73wI/RGbQET963rn2T1b?=
 =?us-ascii?Q?FTtwk+88Hm99rbWOomjVp593mBJCJH68dWozcXsYivbeXwwXmU45K/fnRjH0?=
 =?us-ascii?Q?A41rrkSmpLOyU6A1xa26UorxO9yIf2y+jzgoWELNUy/kyJfgbiM9JTaFtEKH?=
 =?us-ascii?Q?IBqWpoysqrE9FB4jyk139W+C5axegMzUgHHdhphGuM3X4lbmRVPkHpYbjx2R?=
 =?us-ascii?Q?jmTnkcOQuGRvfqUwflEbzZhU1lSaNCYOqiDfCogusStf1sZrnurGusTK5/LP?=
 =?us-ascii?Q?Yx3WRwyJghuY1xVoLb6hw4atMDheuvpCZ55c9lT97Rq9lfx47dUvykqZcq1p?=
 =?us-ascii?Q?WyY7RXcSYJdk4vZxB+M6BbtvuQnxnTTqCIcCGpwKTxenx4rTV4pXpcgvIZjL?=
 =?us-ascii?Q?oHCeeI6WlmRBqiLbAgcXdEdwrm/0IrGVkEqAF0A0KVu3ifFDiG1360B9uhWp?=
 =?us-ascii?Q?rXN/r3p0PCvQtBtTejLvoEySr4ObOvaEt+m/dy4UORCTesqE0gxOyzGNiaYN?=
 =?us-ascii?Q?yLVKO711Sa5/yV2YjbVJXFU6D1WBP8iqjE8lJ4zLZFQGX7aPR+vsNKVUFWeo?=
 =?us-ascii?Q?xrH4W5NDC1PuWz8ywVy051tq+58mzPdEcUA9B08drWzyfAn5yJKmq7tKT7t5?=
 =?us-ascii?Q?hd+tGYnR/Yu1DtsClVfC2L64GlyzkoUfMgJDIj9d5HWmPqcc5eFXLq0U9YPk?=
 =?us-ascii?Q?00Qqwh2ekk0U/aRT5/o/1v9+PRSIEFOp3FJSWgmMNWmYR/CNTXUQQRtGmc6P?=
 =?us-ascii?Q?1c/IKyq5fMqkLiA2kxiixgQV4CBpZTGtVLH6zSoEq2eRBI5NjQpKZzmkp+m9?=
 =?us-ascii?Q?Dj1fQvOIJPjNVcukYW/PhCuLz5pfBsE6Rq0Wl5w28vuD62IDN5Lk/nmIkIH8?=
 =?us-ascii?Q?mpkCKwbh7/YtTsZtIDB4e2yJy2TttXwNEUqLjJqHoHRiTkTOgJIwb8oW2LxF?=
 =?us-ascii?Q?R9FriL/IWMKAZDG8j4DkvVlTVDnfDUEjsx5FgGpUkubr3kPh0CkXauWZlVo2?=
 =?us-ascii?Q?QAVBFv09K+OHGjhL6QM3hiyd7tn76Mf7oV2no2TTUQeOudOJLMJ6jBoacbtN?=
 =?us-ascii?Q?udl8fgyZqpR10Zx0ofjhitFEwAacKcwrmbP7bMgvIy5/bw86G/Bh9LN3oy9l?=
 =?us-ascii?Q?nx14nNG658QiGxSbzOFcWH8vsGVajBkmnPNrqZRTXbuPtehY/krIYLumwbCW?=
 =?us-ascii?Q?Do9PJSqnDiIXNy+1ybRGHmGVgFSlly7mQuSYfxMq18ZEPULVUooAUtHjp7Vx?=
 =?us-ascii?Q?NG4+clli8qjdFmkXmTGfStkmEWo8gDF7cl2LfdZFjM71rQjODi4qdtz8htVZ?=
 =?us-ascii?Q?wwExulbIHr3RfTssT3GSl3PZ0NtXeWd1cORjz11VrTa36ykKUEknM3nEGPRQ?=
 =?us-ascii?Q?VJd/4ymcEO28/WhKIGj4fsU0xcXJH18A53x7DPEbUiLOxEgFaxSMFBLBMAUD?=
 =?us-ascii?Q?6KnEyLXL97uGLOl1Gw5tTSrynd/mcJEvH4jHzkkAUHUkFWjO+nUlPJn3oJPK?=
 =?us-ascii?Q?Axclv2JxHgFW94gwuHrDufPB8YYP7YF37im0lbMD6yUJu1vAvnuV38eV6Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:24:50.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b1a1ee-5318-4467-0ddb-08dda2c38c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 78735da7e63d..186a5a20b951 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -670,8 +670,10 @@ static void __cxl_handle_cor_ras(struct device *dev,
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -714,8 +716,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


