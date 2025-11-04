Return-Path: <linux-pci+bounces-40160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 586CCC2E86F
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 01:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1A064F0FE5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 00:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8E35959;
	Tue,  4 Nov 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZCeQ33t"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0274224FA;
	Tue,  4 Nov 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215061; cv=fail; b=oTsk/0YJY6+UuSwCQ7WzXj1Ch++hrFZrYzZJdjv399AmHdhtFJeM66KgMmgG3ATDrXWLi9W2PfYDWFp9HugkLPwpZLuZLJdQPvfFUwAzscCrmentlvuT7t0H6k7RE6bZeOB5sOsVVfUlV6rhJS7dQukRl4CSTqoksTtct/V+rrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215061; c=relaxed/simple;
	bh=XKw8Xx7eiNLyEYZA/6QVpC1aZmWmFDGjqumrsbiAV9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkesWvgjs3C1b2Yj0nECkm0WXpJq0pNTOENH8e2/yewn/tIvbG8a+C/mbFTw14uLnZ3wbg1cs0dE/u+BAZDqZm5Qv4O9Qy8xwfcJwmnJu/ycWN8mMVZMDx2g+NbNUwUunD3pVhRzW2ljcD5OBxbBVsyxec7MqvMddOFTUEk34xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZCeQ33t; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmCXaXI+uSG+oO8Ds6Qn0RvEi8OV+7/KL8ukff99Y4ijukfPtAsSKPIVT7nEOry88/Sx1M0M60xH86BMJriG7qHQCchH1yyvokBaZdPtIwGxPG3fztHHvM3/LckeA8yFDb3AdaM3iFCYAYnccKGoHJVCVYy3/+aA48f5YR52lI1WEGeI5WloRCx83CTvmYWCfa2QsLGPsEcQg6RsniXSso9kpVlve2kt1nA7nkNUEQuJIPx3uQ5vbz7UUKbhd5RQvpVuqhtrHZq7uRihmyi/cmk9R80Wd90/Sl0Nx2Fi1FY40VAwwjTBqI3ZIATJeQsAK9K2TXip4eH7ZKd1uKAp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZDo8YopKJyFYH1tCwVTcFe7YyO/4DTGdGYM3nTBvmY=;
 b=P6TqLW4qcOJCG1DDz4oamZ2pSjVBAvkLjmE7cUwhveNlCiL3ufc/SaYeE+4EKCWuNa3PEFcY7gZ2phxn2lpY1tcBYxAGhKrDof2DrSxRQj3wy3gYgH1PxrGhfFwaMvzk+HaZq3+QWhvUC+aRFeg4VOwMErczuSTqWqtzJSABDjg8vLVOBffj8T6T6vXlLFWEglNs8N7OV29eUSSg4aC9wYb6Bmc1rLnLpCGPUulz4+JUWuqTDe/AJERGFBvXKQfM1SZG06vC/7yJQK7VYEawuXjC4mWHI+9fUfd37qMIgczXfI5svvWWQweWKGJgi/fmA+BEQVm5Z6WX7lIDSl5m3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZDo8YopKJyFYH1tCwVTcFe7YyO/4DTGdGYM3nTBvmY=;
 b=0ZCeQ33tpSBdGgpoBy3o1We2Ls+4f+o8bt9hX8cnGFc9LTG90+1zHNmZe1uEx+6e4SB916PmWdphXYJdMqxWqr4E1I8y0MBurQsuOyPAKMnmZGpMNZzpFHRAZYOa3Dd3BEyb1r+WzKYwyz9A+rG9LGMDc0JfxXbVt22etWjRGxc=
Received: from CH5PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:1f4::10)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 00:10:52 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::1a) by CH5PR04CA0004.outlook.office365.com
 (2603:10b6:610:1f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 00:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 00:10:52 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 16:10:51 -0800
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
Subject: [PATCH v13 04/25] cxl/pci: Remove unnecessary CXL RCH handling helper functions
Date: Mon, 3 Nov 2025 18:09:40 -0600
Message-ID: <20251104001001.3833651-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: c0edb527-cfc2-4898-042c-08de1b369e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qFnOdD5G0hcQvzsZQ87IjxBBYt0rEL0YMpkpHKDkEKLjw65gep1GVyYGdAx6?=
 =?us-ascii?Q?4WLaHaw21SJ4NYxospK7T38V6y9SjMstyhZ1HNkotu1hLZqBfYfLcPnx+GJF?=
 =?us-ascii?Q?i9POtgOyO8kLKld3eIJBLS4SK/mzbxg05wLONX68H/7MiSplCRLHZbsuqwhq?=
 =?us-ascii?Q?wYCBp5/4hKSBK2CuMGarrKWuEDa/0n9JRM2skfLecihQO8Tq5/eRSCJ+Oc0P?=
 =?us-ascii?Q?9ixsQUyWb6eiX5gM8QNzEXgrhzXWP2+n5Ad1Nj7ykMc5bYGG61OcoI03YM7f?=
 =?us-ascii?Q?UETp+hmua1Sf1V8ykq6abSkxgxm6tS6v1Guk9s+7x4o6b7UN044OThFtXQDi?=
 =?us-ascii?Q?FrXTVP8dqt6qZOQNXnZCILoyo+Cs0l9tvuGYY5tlIIDRaC77Z2RaElKQqmo0?=
 =?us-ascii?Q?E/6gSmW7F5SqBdSf0hXdyEwq2xNuM6MlUv+4HrM5rA/hc3rQhoJzQ8BZ/a5p?=
 =?us-ascii?Q?AKsrU2hSlNRI8jak2+HyII3eh9gwQNb/iKPn2N/lRoJYPG5FVwYZaymFlFbL?=
 =?us-ascii?Q?6yJw+963jZuBmbYrHmWaJWO30yGPMmNTpON4zeveGTlgxcfuNk+cnCcMqXmO?=
 =?us-ascii?Q?ZTifBajWG7QutLhWf5gcKYQhJ6A+hSyDVeg6ByrpETTHWto593tfnIKwilEZ?=
 =?us-ascii?Q?BMcauBvEWGaBY8uvQ0u6wSHrKkcyxnDTITpnq70w3fBsSMrnSbyPV7TtEv1x?=
 =?us-ascii?Q?3y4IUVHKRyRrMFFgpvrDW0rAUMkU4LNbWHIrKCrq1ZqmNVIAtbUhgW41EFL+?=
 =?us-ascii?Q?2z5Yge/hJIfZAZ1/0BB6869p81IB12tHRYpwYEO1v4wCJmy+MDYULy7hWiYJ?=
 =?us-ascii?Q?cufP6A9m9fjWAsZ22gDi1CW1nJ87O3Gi3Z0nD1C8VUhm0PtXLN9INPh8VbdO?=
 =?us-ascii?Q?51BE0dAsLFtj3Lip0ZxzoAonmK+v/b/glyOa+DEp+juaZvvWu/l2KecRvWyM?=
 =?us-ascii?Q?y+g9QqiHDHhe7WLl7geQMRlQZynDkG6n/ii402ZLXYeALXduLvYqs1UIl39U?=
 =?us-ascii?Q?OdlJXm937U7rq4jTu5d2y+SpkJpbBb4a7A3v89qK/4WBwFL+vgktGerLu7xY?=
 =?us-ascii?Q?X33OB/aJi1irFpDAYSrO2mmDR62u9XJHz0rHl2i/6Uv7UVmAuR3FY8NJ81mE?=
 =?us-ascii?Q?yZ4y2wcHUKCilkJWQ06ALlNQ1eMaWbed6Yw/u0G5somUl9UUUrQtmJUfMYyK?=
 =?us-ascii?Q?gXObjTGXT0N3MT/v+RDEnMJYpuJZmNAd7T4ku7m9JiFOh8I18gYiqp0XEOhx?=
 =?us-ascii?Q?oS/9B9qP3DSs5U1cBjyqkDiyAY1tvCMCApoOHmHT5CjxKco9AxMGt5TZ3pfv?=
 =?us-ascii?Q?WcBTHD+GBEQO2Csad2HbuThBVCZ3mEzcVRyekRypDNEN6QfxfCg9nsH/qW8/?=
 =?us-ascii?Q?NVLtCij0f8wDc2D+FjmpwHfVNuGfi4n0ZthfkXsnmMcvGwTBrZPvOUBSA7+V?=
 =?us-ascii?Q?rCgaVfaN/TMVmziSbvkEbbhzWs+XrTAPt2GMQouLp8VSsV/S4XrDdNjBS9Qr?=
 =?us-ascii?Q?Ja55D2lpRk5lbqx0iA3E3YtnROrdd1K25H019x0xbO2dk8w28pDrO93npsfM?=
 =?us-ascii?Q?aytfxtrGJb7PPwsSsNZjeaSI+ccs/jTxfdaopZsY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:10:52.6081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0edb527-cfc2-4898-042c-08de1b369e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
to Restricted CXL Host (RCH) handling. Improve readability and
maintainability by replacing these and instead using the common
cxl_handle_cor_ras() and cxl_handle_ras() functions.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

Changes in v12->v13:
- None

Changes in v11->v12:
- Add reviewed-by for Alejandro & Dave Jiang
- Moved to front of series

Changes in v10->v11:
- New patch
---
 drivers/cxl/core/pci.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3ac90ff6e3d3..a0f53a20fa61 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -858,18 +858,6 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
-					  struct cxl_dport *dport)
-{
-	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
-}
-
-static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
-				       struct cxl_dport *dport)
-{
-	return cxl_handle_ras(cxlds, dport->regs.ras);
-}
-
 /*
  * Copy the AER capability registers using 32 bit read accesses.
  * This is necessary because RCRB AER capability is MMIO mapped. Clear the
@@ -939,9 +927,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	pci_print_aer(pdev, severity, &aer_regs);
 
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_rdport_cor_ras(cxlds, dport);
+		cxl_handle_cor_ras(cxlds, dport->regs.ras);
 	else
-		cxl_handle_rdport_ras(cxlds, dport);
+		cxl_handle_ras(cxlds, dport->regs.ras);
 }
 
 #else
-- 
2.34.1


