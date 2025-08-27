Return-Path: <linux-pci+bounces-34831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F4B37729
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F6118972CA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C51FBCAE;
	Wed, 27 Aug 2025 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uk/kR7Eq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938D214228;
	Wed, 27 Aug 2025 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258709; cv=fail; b=ETLNK1LXob0g53vi9EWZ7y8JZY11BCR02EMAFfDaaqfrhONEXC7ExweLo7GanMPq0VkQIB3L3u6Ver1keHPhJj6df8BWLC7odCrdJfp0MLtTEcWHVII3ajaUV4lzpSwLUOCyvixYTA4jJI7Haki/RM+SzC7GjetFzxBKe+L1YT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258709; c=relaxed/simple;
	bh=4/vf07zb1R1DhZIFFjFIT8PzPV61nGzfUc7UKTQziuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC0dkKgrDjE/5LT/ZyX/zirk4oi17AM5MxPWqR26dxdXW4DBw0jwRbvK1nEJwAXlZvLV+j7VTheqtWtEGT5orDVkdUD5BYRagmxz78Htz3rWPx65Om5pGFhYb++/XRms7uthpAjCjmRRZOxseGN1d2HQxN9+55WbgJPjTflxgQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uk/kR7Eq; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAvu5QNSaWpsxbAS80YPqQhSNt8+zbMzldhDhdP9azO8SnPwezJvJoA3wLTr1Pi7bKGjjSDPhjA9JFutUkPoDaaVbPBUy8W8u1mIyMHHxpkAbvGfZ4PUdh9qthd24z+4BAtONiyRltgafSseyqWIGqNP957GFHM6or7VTxQJNx6KBLTXliUXryXTs9tYY452AMpZy0l3sRNzyqzdYOqXHPc0t5gFojoj+hFZq3toq12zsc91q92zzSwMZLfyAuSx1wuwF2HY7fmUllHwY6AeDXyqAm6g23J6DaKw1AHVQNA0HfL2lSKCTxztdr+iMPV+3KQzQ5Ykzc0/QoLklJHPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqdYEwHjo4G7E+RmEfy3nafTCSB/7rIRVNluQcIkKFs=;
 b=vUYuhp8wEII9mqCGdrs7J0i3eX6XjSDjGcqO6iqY9lCEVNjV4MFYwAEPrWErSNVDEHcbYegzBN5GpWufBlzkyWXcMLAqgyaT+59CYaApLYuFMYA5DwoPqxBR1crX1cnoT7Cy8SoT1wa9iLtwk4kox/+xWsREhycxGPWqLV/rP84zKkWj9VzNtWpgi3P62EQn9xD7h739Gv8CqcAaI85zirdjvWXHQdiIhQA/hq54zo6v0SOaSwyc//FECrrVbbwGHpDam05jWzuTr8jmPGXL3w2n+NKEhbtw2qC3OsN16zj/mPYIscz5J1ACGE4qtRp1vgWzDraR2xc4VrHAnfF6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqdYEwHjo4G7E+RmEfy3nafTCSB/7rIRVNluQcIkKFs=;
 b=uk/kR7EqAluy5Ut/ykb6zUoHVXn7RHyV9seiyMKMeGqXYhA1DmFVrKJnoSAX6le3xR9JbcTAtuKs3ofSO4lITxnOvCyTV1uT6hU+Pv2ZCYXQlJUbrD1UyYlgoRLRLqiTAfc8FQFuOFuwt2OJpu5unuWChS7VMu0gORhY1aCOPLk=
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 01:38:22 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::d1) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:38:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:38:20 -0500
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
Subject: [PATCH v11 14/23] cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
Date: Tue, 26 Aug 2025 20:35:29 -0500
Message-ID: <20250827013539.903682-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: df1455ad-6662-4a79-8a54-08dde50a6838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrTslnlctGuBl88no/iC7Bg1DyBWbQSWPzFjc6IMx1ABo84TP6XgLPuJLeFw?=
 =?us-ascii?Q?4EP3V6/hBFf8jD1TkUwEUz5LpaqN8vuAT9DZ6MJMyoSsmVpzNPknZy0mDhBJ?=
 =?us-ascii?Q?LOkIGwgcUqgkZvUgIH/x8PfKi8XEg6ylf6cyhAGVx2mCInv38MfQYgTc7fh2?=
 =?us-ascii?Q?JfuyAEstzbnK4pmrAcg2Ms8Z+A5TD24wrrla/tpMn363gGh32JDvNFswhlPw?=
 =?us-ascii?Q?JUzbkZXRw7KjGo8v6mmNr6mR576r9OsiRiKkqO+gJTN8u76Dxz3knj/7CR4D?=
 =?us-ascii?Q?QqHge7+FWs+qwv5u1xjxK5wjG9LZcVWrR6VYXHSAoH5aGWhsDCCeMZCr5mT3?=
 =?us-ascii?Q?jgSM9wuGRn+HDgMsjEQuXGiVk+ITMwtbBAFR7cVT9iE8rUHUNxSHujQnPYmf?=
 =?us-ascii?Q?zdlEsEejkz4DKFDUsplFce8fX1X7H05HDWJpxaLYDxken/iTO21NTWBvFexA?=
 =?us-ascii?Q?8W4PQWzuSCK4UMqiVPnSH8u+CNaDEYPrXqoPDLhtvRHtQfX0/Zsteo88+uvT?=
 =?us-ascii?Q?VdYkJBoh6Wpxv2l2ynOkJWO9GdeI84rPwuDESbhrxnGEZB2V1xcmRaO+VCa2?=
 =?us-ascii?Q?6SLel7fmhJEKiMVzMJSn9y2lBDjyKXzcDFXjAnxsC/txW1/h5DT1+18N0jyo?=
 =?us-ascii?Q?Fik9IkGuGFPabAaNFRUVKRmdn95fYt1NZM01YH7WeUCGBpdzje5rdPCBewNs?=
 =?us-ascii?Q?Y83Ko2pQVFu1+o1eSdp1CorCL0wJuyqKfISfvL1sFvXhXhts2WquJ70MGxhp?=
 =?us-ascii?Q?hbM/n23gNkV/e6iYMUBt5KJfUQuDLd1HgA5kBqjP01B6FK5QQN5OtYAkmG3S?=
 =?us-ascii?Q?zwz8Xbt7FWt31i8PWCjeUH455udt8aFrM0e3xZxYbqHCYHlhQpmUKHIiOupw?=
 =?us-ascii?Q?hKhrMJbdOwA5Ehm2jugu0j+iFpHgIsyR4wg7e1kmZeaTp2NAzV7RbO6RGm45?=
 =?us-ascii?Q?ZgKOI2bJqdgGapKT0JIdfmjZiddjxf3hvkYjOyxdSmmP8k2p+MCs9JVMFEoI?=
 =?us-ascii?Q?sXhk+bw0L8hy2HhhQ2Jf/AdswXuMOTj5NMeOWl6MUkFiSjztw8HW2YdZBHTU?=
 =?us-ascii?Q?liyRBcGaXzMubR25CAIiQLbGKR3H/jtf5Kxr+SXwDQRRQffl6llUWBp388hU?=
 =?us-ascii?Q?7QMIp7+TfhaAlHrThe4ZllW1KpPD3WkWK9cOkGdJ1yRFyp69rhPF8t11/o4W?=
 =?us-ascii?Q?ZwAAtTJhAjIq2hJf8/EeDgLrXByaBiI8fZZrph0gNYVaHEygp0IQiF+Eyym1?=
 =?us-ascii?Q?a937t7z3OrLYiEavVBZzO2lmcjVI6NhoYoBISF8Vmw0kZkZQdznLAIH+xDo7?=
 =?us-ascii?Q?sMr9Vc5MRZzN9pnODQ58sDjrsGiCzLYAI8OAEwr2ho5iEmwxU0dx9+rjWr8S?=
 =?us-ascii?Q?rFI8yaiwmWiKUbyYdzBWIaMLazjS/CQK1gZM8fK2uDyRaJNvfjAEY8p7gXI2?=
 =?us-ascii?Q?5CTNYgwGoW1sDad5Ws3XSsIo39vcoi58a5XSle2lHMZmvSeMd7f61EAL+wdW?=
 =?us-ascii?Q?he2dcNbDM187t7NZVIw7FXYovCE4M0W/KozAoMsNlwsNHvoopsXShq+eJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:38:21.6048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1455ad-6662-4a79-8a54-08dde50a6838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

Update cxl_handle_cor_ras() to exit early in the case there is no RAS
errors detected after applying the status mask. This change will make
the correctable handler's implementation consistent with the uncorrectable
handler, cxl_handle_ras().

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
Changes v10->v11:
- Added Dave Jiang and Jonathan Cameron's review-by
- Changes moved to core/ras.c
---
 drivers/cxl/core/ras.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index fda3b0a64dab..69559043b772 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -296,10 +296,11 @@ static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras
 
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
2.51.0.rc2.21.ge5ab6b3e5a


