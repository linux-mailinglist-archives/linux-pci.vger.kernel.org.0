Return-Path: <linux-pci+bounces-44825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883CDD20D85
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8016930200B9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAA233509E;
	Wed, 14 Jan 2026 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhqP/20P"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A5335554;
	Wed, 14 Jan 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415291; cv=fail; b=UJTsF9qzfTn8dkUlZ2naNBiEtc8MKQfeD0x29iNfN97JYrWubmTCHEIv9T1wjl1K94LZbGVSCT/I0wKheDia1480aNp1sZ74PqTCuuEpWwbaRAMHf+TeKzEAgHFHkZNpWR+2jUZKPpO6jLhf2RN5aqWEZMpLU7ozawN1P3mWilc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415291; c=relaxed/simple;
	bh=7DLVXvaQwGEmyAycyrXJGBEbbqBJrJrmm2xH5qDly0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcbacAEp/ZdClLnlyx5B9g2BANTp5x+WzikOXKp8oDI11Un23t8q9L3SU/CLJfkDjLJlc/fRU4+v74NYrzst0v0sPm/p9DSVv5kBTdyUC6UVwMDIkd4Egv6D+CEkN9gTzKetDFFnUR+9Xa03hWqulfKKfejsd3gTZxiMMIPUl0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BhqP/20P; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6WC4W7cZ3+hmuwr42gF9wY/jbLxs3FIJwY52IfI0/rsTG89VrHXxwvpyvtMGN238uWSQ6YiqdipKwQ6+o6YO9sc2veJDIK9vOAkbqPgn8v0AoFXdqtjG1Nyvqvmi9zWr/SOGCjKxLVopSh3dU/d/uibIbn5S/Ic+YDboFmD2FOWHT0Hsg/AyDqJKzW04H60lc+T/JLH1cfmRVQSD63cLqTCv7VFpCdrF4jg4mjQqCx6XbjbKOqg0XvOizFKIpjGSi7P91lBmBqPh9rVpf+K8Z7ocVsioOOBuo52uId6GhhhkBqoLNxCxY+aagdPnJKfw4DjQAfk3W/CRC8uoZzneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KtZQQZCDhIPdl75l8p+KpjXmtR4ARbySc3mg5pioLE=;
 b=khFo93RUWQp6/9+jhyQdD3kurdMZYL++HtDwUQLKGAYA7Te8ChEjS3f9HZVY5ELTX08Tey4dLL9aq4acyE59ayzTvLgbo9zjM8FKY72e0hkJWniYXL11QwXmfPF0H3fWbZb1yy5+ciLxFBo3ZvEQNCWXf4YQhX118ks6l+6sgMhde8QcEgpbFCIMCNWl38BdCn4b2bxI7mN3L9DNcUCblIEqxp4NAPUcTJOUq7CJVqHOIXH6xnJVuO1kTOU16uMtwtKIGOIUFjT4x7OfdMr2VOI8gwyYqbIkiUROJr0Itw1XaLlzAF1+bMza7RCTndcKVg29ss0skmF6qHpV8vRlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KtZQQZCDhIPdl75l8p+KpjXmtR4ARbySc3mg5pioLE=;
 b=BhqP/20P5AQo0xJyDBzlgAovlQbwhFQS9Siz3X38HNDakICiP+7zY4BYsaWIn6quE9Jimg3hoINismjEp6MX3qht7z53k4VakfLGEHXtvx6XPp84Q7Lkia2e4gPEfiVQSYaOtDyuQeTVRmr6WVgeVmvyZeyPrI/1V7drVbtBCPw=
Received: from SJ0PR03CA0358.namprd03.prod.outlook.com (2603:10b6:a03:39c::33)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:27:57 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::2b) by SJ0PR03CA0358.outlook.office365.com
 (2603:10b6:a03:39c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:27:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:27:56 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 32/34] cxl: Update Endpoint uncorrectable protocol error handling
Date: Wed, 14 Jan 2026 12:20:53 -0600
Message-ID: <20260114182055.46029-33-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: bea2b466-fd31-4ded-710a-08de539aa421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4uinVppPhZw//6kQ+OrCuldKtTYLPJnXIsV5FOTtO9xZHQRyOkaA1FTkq2q?=
 =?us-ascii?Q?7X7qBPq+OUf87FqK+K56vf28aS/hu6o86+tLrdlN1HvPVJzzfCD2KbbFUadb?=
 =?us-ascii?Q?6jgc1nxGWcJpcOB/np2YImGPa0O6raDcYVjf8GdCyrTeolYKC8WFYoB26M/z?=
 =?us-ascii?Q?Qb4UTH9Zl0JUtTUis6s2tXMwdb7yFTA6Dg/kJk6wzqippr/XRrWpFSGQ1nc1?=
 =?us-ascii?Q?YFENnOt+wqlFpP2ZvKcyv/5xWkmTCNm0nYjg/WsxjYdtysEOUVaL9OsHnPoE?=
 =?us-ascii?Q?K2f/ljbjJbxuZvzCAh9ZnE9FJHjS1YOeYfvAtbdVtF11rj2rZZWOm18yFekK?=
 =?us-ascii?Q?hZccg3OaqOgOUjzApoAJDFBckUc9y/bfszF3pO8oVtuBDOH9mtwVW94jIUz6?=
 =?us-ascii?Q?i4H8LFMBUkBxEZzkk5XeQ0toeRV8ugpQN6t2j2TIYz1C0+MfDYKU6FJxARzA?=
 =?us-ascii?Q?oDEBBYcfcjbsGJBRHvkZcdBCTBY78ST7yKIyjF78TYms6dzufT12aeR9mUyn?=
 =?us-ascii?Q?yTMcaKaA215TqMzRq0OIDv2LFNEYv9jhcrJTUoUq8nG61TOJJXTPsqBcpM6H?=
 =?us-ascii?Q?KnerYgyUQv1M5SHauYA3KQClnFWo7kyyid9/4ZyJWQhRnMGdYthLQ0PWlu5T?=
 =?us-ascii?Q?7YIV4F5Ne2O1WtEAU6iQ4xq77U4KH1CIw8N9BX022zVWRDVI3TBQ33K4iSw/?=
 =?us-ascii?Q?z82JJ+HbILOc1El4Vsu9g+yS8XfJVBdXvwbJMym+bmPSbnsW9zw1K+acz7c5?=
 =?us-ascii?Q?0hZBpqgjeosUBI1b3fFJHSp85HwHJxfJMnVb0cx8PeCHBGwn+RS2Q5snD8bh?=
 =?us-ascii?Q?cqeSx2JPogG9CPmWHcZpn8AcHoU0Ol7nc9OjQ1apyX35ZesIXQjtrA3jmdpL?=
 =?us-ascii?Q?cZiBPygy80iegS/IYEO3iHubb9u2c59d++pfX3hQGJWaH3PwLV8vgdmalTnD?=
 =?us-ascii?Q?4/ZaGDgiIDtSjp/qO+vfSShX6GGG1zR18DgAvbQRaLWpukowk5K4WvmEL5N8?=
 =?us-ascii?Q?YnysGSKQU9mGkRU+GRiy+JXrALPWUppCep97ZyO8U087qIkLPGAxpqpVA6HR?=
 =?us-ascii?Q?39iMmoMhJ2uqGnnqAJn75IHG8a4FMyvs2o7b50WyihOe4Q252r4TmJA/4pwl?=
 =?us-ascii?Q?zYAcGCNZRoij1A+MFSKLwcqRVA2gi1eajINe3EQbl50NN9elAwsaXaq16VhU?=
 =?us-ascii?Q?+yMv7S5Ky3QjiQCyGQ+HGtNddfkY+EFBS0+vwcbcigIYq0DX4fmFZUb8y/I4?=
 =?us-ascii?Q?m0gMkFGwCHkQnm2/W9QFo1Tom1eh2NXiVxT3fiI3ufSiQq+7T95KtJdQY7IQ?=
 =?us-ascii?Q?s9Ljlz7xIy9+lWcIndnaP+8qsAA1SXam5i5WuwMHFU9ckqV3fviBBVYiCq2a?=
 =?us-ascii?Q?d8jm9kB7ayJaw7MQBSMMeHojd2R0zuYn6NywpeetsIr5ZEd3Ux9UzweV8zMi?=
 =?us-ascii?Q?GbEvZNexf6CfOjOfmfUmF8WOuE7WUdQTOct2lpJg1KIHL4n5B26wq9GivCxd?=
 =?us-ascii?Q?mnqbzc1gvDJqVIEQ9FUYb0bO2A6sfo59KF+UaukaZgO7c3kFtWOb1laxmuDz?=
 =?us-ascii?Q?XMyCHXX4TXZxYPIudi/YwNpIFi6mMbFoOuhC99WV99z4ZZNTNBCU4NwDBnZF?=
 =?us-ascii?Q?LNdGWce9S0cUnnH87mzHnIBx7HfqrqRFM0TqmqDMbGFVRggDpni+diAOteAJ?=
 =?us-ascii?Q?PgoXdY0RyqtTFArgrcqH7JfUiVs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:27:57.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2b466-fd31-4ded-710a-08de539aa421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

The CXL drivers must support handling Endpoint CXL and PCI uncorrectable
(UCE) protocol errors. Update the drivers to support both.

Introduce cxl_pci_error_detected() to handle PCI correctable errors,
replacing cxl_error_detected(). Implement this new function to call
the existing CXL Port uncorrectable handler, cxl_port_error_detected().

Update cxl_port_error_detected() for Endpoint handling. Take the CXL
memory device lock, check for a valid driver, and handle restricted
CXL device (RCH) if needed. This is the same sequence initially in
cxl_error_detected(). But, the UCE handler's logic for the returned
result errors is simplified because recovery will not be tried and
instead UCE's will result in the CXL driver invoking system panic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- Update commit headline (Bjorn)
- Rename pci_error_detected()/pci_cor_error_detected() ->
  cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
- Remove now-invalid comment in cxl_error_detected() (Jonathan)
- Split into separate patches for UCE and CE (Terry)

Changes in v12->v13:
- Update commit messaqge (Terry)
- Updated all the implementation and commit message. (Terry)
- Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
  pdev (Dave Jiang)

Changes in v11->v12:
- None

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/cxl/core/core.h |  9 ++--
 drivers/cxl/core/ras.c  | 92 +++++++++++++++++++----------------------
 drivers/cxl/cxlpci.h    | 15 ++++---
 drivers/cxl/pci.c       |  6 +--
 4 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 39324e1b8940..96c6cf478427 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -4,6 +4,7 @@
 #ifndef __CXL_CORE_H__
 #define __CXL_CORE_H__
 
+#include <linux/pci.h>
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
 
@@ -147,7 +148,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 #ifdef CONFIG_CXL_RAS
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
+pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
@@ -158,11 +159,11 @@ static inline int cxl_ras_init(void)
 	return 0;
 }
 static inline void cxl_ras_exit(void) { }
-static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static inline pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
-	return false;
+	return PCI_ERS_RESULT_NONE;
 }
-static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 96ce85cc0a46..dc6e02d64821 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -218,6 +218,7 @@ static void __iomem *cxl_get_ras_base(struct device *dev)
 		return dport->regs.ras;
 	}
 	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
 	{
 		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
 
@@ -302,20 +303,22 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
+pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
-		return false;
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
+		return PCI_ERS_RESULT_NONE;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -337,7 +340,7 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
 static void cxl_port_cor_error_detected(struct device *dev)
@@ -347,7 +350,30 @@ static void cxl_port_cor_error_detected(struct device *dev)
 
 static pci_ers_result_t cxl_port_error_detected(struct device *dev)
 {
-	return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	u64 serial = 0;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		guard(device)(&cxlmd->dev);
+
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return PCI_ERS_RESULT_NONE;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+
+		serial = cxlds->serial;
+	}
+
+	return cxl_handle_ras(dev, serial, cxl_get_ras_base(dev));
 }
 
 void cxl_cor_error_detected(struct pci_dev *pdev)
@@ -373,55 +399,21 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t error)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	pci_ers_result_t rc;
 
-	guard(device)(dev);
+	guard(device)(&port->dev);
 
-	if (!dev->driver) {
-		dev_warn(&pdev->dev,
-			 "%s: memdev disabled, abort error handling\n",
-			 dev_name(dev));
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
+	rc = cxl_port_error_detected(&pdev->dev);
+	if (rc == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
 
-	if (cxlds->rcd)
-		cxl_handle_rdport_errors(cxlds);
-	/*
-	 * A frozen channel indicates an impending reset which is fatal to
-	 * CXL.mem operation, and will likely crash the system. On the off
-	 * chance the situation is recoverable dump the status of the RAS
-	 * capability registers and bounce the active state of the memdev.
-	 */
-	ue = cxl_handle_ras(&cxlmd->dev, cxlds->serial,
-			    cxlmd->endpoint->regs.ras);
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 532506595d0f..f218b343e179 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,15 +79,20 @@ void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
 void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t error);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
+void __cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+void __cxl_uport_init_ras_reporting(struct cxl_port *port,
+				    struct device *host);
+int __cxl_await_media_ready(struct cxl_dev_state *cxlds);
+resource_size_t __cxl_rcd_component_reg_phys(struct device *dev,
+					     struct cxl_dport *dport);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
+static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
 {
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index acb0eb2a13c3..ff741adc7c7f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.cor_error_detected	= cxl_cor_error_detected,
@@ -1063,7 +1063,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1


