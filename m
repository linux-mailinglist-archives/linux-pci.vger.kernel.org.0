Return-Path: <linux-pci+bounces-37050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E20BA1D66
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CAE74178F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458C4322A18;
	Thu, 25 Sep 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zt9YkmDF"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198F322757;
	Thu, 25 Sep 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839879; cv=fail; b=Zmjb0tlZF94EO2yM1qk4ezEdZioraECETlen+uLye5SAKV9kN9YZAj/kECYUFDQbvVrUEvHFnodjLmT9gHburbtn4yF5RwxNEuMc+Yz5EqnuJ8HZarYNLFHgPtIt/V+4zQK0xdXw5e1ETto9ShZNWIBywH+g/Nw99uXYgQzU0bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839879; c=relaxed/simple;
	bh=kJwBv840LwnQFSY+wQTR/PiJclOf4GRvUzKwFluHq4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tc65/BGqz4Cs/rR/VTHMgpSO5YarkZLv1Hk0H8HC/z/5S+sAqyMHBHKQRc8/zYlCRql5b63bbyh/EvLINl8dIWHfG3LQ7SpPzfSCqaV772XinA8Fi2mvwLHDHh9V1T1siLh0KByOIoBwesWSo+H6N2wpLhq/3u1AzqY/nLaRpXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zt9YkmDF; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5W/Oc+bDU8PWx/DSRMApZveravG4eC0hAglGJrhHGb1DlbANil299XyaId/7CKohOTCsOolKq+S/PCNFhvdqb4Ln6YTDmGI1njiQYzT+I0OXNzC6zD1fsRTjisN18v9yj21R4v2UNRSpU7lkO/pc+tajYEgvOGHoCB5WQyeFTpk4Ra7Wzn5/7tdoiSKHW61VqpDW+uK9XN0bGR+HfNxe/uRMzynsUZAJaHbRMcgcuQtfyjc1uF2EsPCRs6fmNHIz7r/07iCHvvPqjxp5rNPf5jgroACxz+3HgehVS8zPPbCQxQAKDSvaBuAaqFELszJ25PdmwzRkTqqigU8zBa7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vn5FqJChwO7gEHoS1+fu2rNOxj/PB9OFm6vcTJd5eE=;
 b=VOWgJsqBLHonkTBUnSqyq269lEIYrQ4NssVtcw7xizfg1Q9c0veYb3vEYBC8oRnmLiNj6YxSajwwtJUW+PFLYk4yquDyLMl8ZuAk+s0B/JUanX6P0KtMyciNwqVEDjirhDTpWAajMeynn2xLm+d6/MpHCeu+Bus/8ZIZjR1pTmr7tBJExTIS4qDtZgrccqCTjTe9uUp7PUl82RkLFbKz90iwsXz1vENOL1gB1otNoWhzJe6lDNYO4ihtSs7y21R2L1jIeaFHoJbmJvAEc1NdTmNVTwAW9oJqS7iLQsCcNsyxB/roAbUFAxmhKm0Pk0IItWnb4fuDid7eD9pkNcGw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vn5FqJChwO7gEHoS1+fu2rNOxj/PB9OFm6vcTJd5eE=;
 b=Zt9YkmDFrQ9NIyASMaODybL0stnbYQGX/pW0XZtZdlAAgTPLBJltpOn5mAhSGIax/JCE5ZZNiYh6MY+hwMaM0oYR9bXkLkbaeVIxhvi5D5BKp5sA+KTO/hVjiqajK1R5u1M/oripV7k68oqD0W8QLkXcmft6RtTx3vHEJ3ZOZsE=
Received: from BY5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:180::17)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:37:44 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::8) by BY5PR13CA0004.outlook.office365.com
 (2603:10b6:a03:180::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:37:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:37:43 -0700
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
Subject: [PATCH v12 16/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
Date: Thu, 25 Sep 2025 17:34:31 -0500
Message-ID: <20250925223440.3539069-17-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f844601-b888-4f75-c909-08ddfc842516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nYr5G007oI0Pq0CSyLv1A5yFSGZKngb6/CDUHYY+mLWMk82U4svh1I+ga2rJ?=
 =?us-ascii?Q?1PVYkAnPURYWV1m+KXI9CxCV9MKG1i+Wlv3ezah0WMK9w6mylBTm3M+klzgf?=
 =?us-ascii?Q?8du/lB+LHr42K4kMN8UDoA/PY8lRU89FwZyDyq8eaOeKeMOG+CsIXwb8L6Ah?=
 =?us-ascii?Q?ApMb9OviYUXZ1mWIgZzoDORHIJjT1VoG8xM9l35KS33dPpB1tI6Dib1ZLSWY?=
 =?us-ascii?Q?przfkYyJVsDw7Mcp33S4DE3hpG2rFCozbfNuT5AaPb7jL7xjuIjisgcFbybX?=
 =?us-ascii?Q?0ILTMTETpazNvwxD/4IOe+e9kv+E0UbOmx9c7HPtn0DckQ4lOTCIIpv3oxtu?=
 =?us-ascii?Q?M9WSW0O1MI0pdSx17TMEg/02LmMTDaTaECLWEWKLXMdnDko/hbMvIb+ao6vq?=
 =?us-ascii?Q?0W6L/8aP6fzx25QFa8KVSUEpNtlGTiHRXPlRhKBeQb3io1Xkp8Q1YZ7an6TD?=
 =?us-ascii?Q?EijMAmJyxcmq0xLCoowieYd8NZ5wqcsjWcaTIhdkiIA9lo4/3YwMHJXfhAQH?=
 =?us-ascii?Q?iywDR2c/wBy8gzilPLQjJ8lSeufLiKI+VIWluxJDUyB7J4jzbiMikJCAtzX9?=
 =?us-ascii?Q?OD4CQhBG9RK6sQNKovA8/WSyo5MXMwE7Un2UYH1nb1pWMsMc4CaLl9QrQuOU?=
 =?us-ascii?Q?bRaROFisvwVfwNlVdZ8+7MCuqZ6CvuCPwKsXlp5NwkPuDVkbh63kweEhGABE?=
 =?us-ascii?Q?mGtRHtSUnf1ZcfJb4WQhwGvht5wMY+rJCtfp/vWQR3DLB6ErW3BCA1wYqI0Y?=
 =?us-ascii?Q?+5akPa6k+kei1ud7a+oBcErQwlv4MfT+Yi+XNz/WBikPx28Q+3HjbWC9LLgm?=
 =?us-ascii?Q?Q6i2e60Ppn/bQW4QvROYJvPndIVSBpwm3W4clSdL+t9KNtPxxW9iwul+6iy0?=
 =?us-ascii?Q?OXbnfwB8w07G74NhI8XzaTnjQ6Uk7jE+B8seyp5Big9H8rDtcIZpKgwyFp3s?=
 =?us-ascii?Q?91jKCrZaUxntdDasA7GKZTsJxfxVnMMHAvKx1HWBlUvhlXVI4Glx7h6gNCpc?=
 =?us-ascii?Q?6EqIqHLdGB3sNaRtsNuVyHX2ZkUXT5KsuFI7rigH6vBCIB5aQVprvG51iMrs?=
 =?us-ascii?Q?oU5G94QBAB3Yu+gFxKOHluiTikDFDc3XQ2uUV099RjOYqBpEFZH5BbBpk2F/?=
 =?us-ascii?Q?fObIj+JMh3jxngVAzJ029Mj2//E05dFqftu6QDyau4/54mFbfUvX5RABMaYv?=
 =?us-ascii?Q?Sw1iAA67+Ypo77TXJRTR/qs+7eriie4c1qdTPbwntefMeoNPgLNXwdieFV2n?=
 =?us-ascii?Q?smriiRnBTWAFpCkDT+esIr9m/YpGWZ7HAWoPS5X3A+pXG+dAmc4HbXqMqyUP?=
 =?us-ascii?Q?/70o3QNqHtlvfuS37fqY6OPnvw7HSv9LSWDgwCqKoJRB//Y7OOcF1yQp5TC2?=
 =?us-ascii?Q?gyoQaXMNu8T+FKBHkw6r7IhSTKKc7GyCCEjpcdoMas0dX5/fFf01QHRCre82?=
 =?us-ascii?Q?yQC6KC/ODeIEhdJBscI/hCMrotcfjwaZHy9vRVF4Aq09iqqod4c3GCylTmUF?=
 =?us-ascii?Q?7WNVuTIC0rYZnv3xUXGR/K2a9OBFRnWSFrhlDiBjYmyhvbPksZcbjxhtmA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:37:44.3346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f844601-b888-4f75-c909-08ddfc842516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666

The CXL driver's error handling for uncorrectable errors (UCE) will be
updated in the future. A required change is for the error handlers to
to force a system panic when a UCE is detected.

Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
be used by CXL UCE fatal and non-fatal recovery in future patches. Update
PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes v11 -> v12:
- Documentation requested by (Lukas)
---
 Documentation/PCI/pci-error-recovery.rst | 6 ++++++
 include/linux/pci.h                      | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 42e1e78353f3..f823a6c1fb23 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -102,6 +102,8 @@ Possible return values are::
 		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
 		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
 		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
+		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
+		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
 	};
 
 A driver does not have to implement all of these callbacks; however,
@@ -116,6 +118,10 @@ The actual steps taken by a platform to recover from a PCI error
 event will be platform-dependent, but will follow the general
 sequence described below.
 
+PCI_ERS_RESULT_PANIC is currently unique to CXL and handled in CXL
+cxl_do_recdovery(). The PCI pcie_do_recovery() routine does not report or
+handle PCI_ERS_RESULT_PANIC.
+
 STEP 0: Error Event
 -------------------
 A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 53a45e92c635..bc3a7b6d0f94 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -889,6 +889,9 @@ enum pci_ers_result {
 
 	/* No AER capabilities registered for the driver */
 	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
+
+	/* System is unstable, panic. Is CXL specific */
+	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
 };
 
 /* PCI bus error event callbacks */
-- 
2.34.1


