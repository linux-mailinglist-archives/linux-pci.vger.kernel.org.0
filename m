Return-Path: <linux-pci+bounces-18206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E111F9EDC2A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB48D1886BCA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67061F4E55;
	Wed, 11 Dec 2024 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DZtbma46"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A91F4E4A;
	Wed, 11 Dec 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960570; cv=fail; b=VhY3CrPAWAoE1UHC6gx7NrH59eA2fJ6+M4B7F2RUG2EozZzXXUloNjRha48bA4/dqFjUjB0tbIe91l8VHK2A9I5msd+vaqdG24UoWXd/tbTUdZT9VsQB0qJMkYMsnOx6b/dhTnrLDPuUtn7dDuuhh+0+5H/XZXTj982vDO38TgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960570; c=relaxed/simple;
	bh=s8m/gTDZ/ukh5YECRk+9O2l+bpcmrGDWsewg/ITepb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbMLxWK17ATo/iYe6De9VH8ion6mWLqJEgofAakDx3z84sUUdLCsdtXjJjATEpm1mt7cE7x/5SkgJMeK6e9eS747VvNrvId2NwNS3dsoNDDiS1d3iRCv4jKX0QRl6I1gszPf4TealnMLhEFlCdsjK7fzCAOz+8LS9vjMKUrC6PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DZtbma46; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYFJ4i/nN4EFIepdxJFuRg1T9hS8mcqaYCOY1o6IhpZQYiS9MDO63ILdgTyaJyF7f44IHGO1Ad0TkIfgJdJnE/Kxvol0IVn0SKc5vAiKVG1nKTbWDFyz6CzsG97Ve7duD8FBAq2H19PMspSHWW0cqR0aEOmkmvHZREBEMGdpLDA91rioPM+Aset/tqyGn04vaIO3Osd0kkhe2UsdChYpbVJB77/WUUrGidff98EYvtJUyR/RqEqy7JlShfL4GNnuSDwqRgA66lo48Jed17QDh6FvCBp+p5vq2pEfv1fgYHrrxOxj8BMxT9iOb9r85BtyHKCifTwywWKwwNOeKTeZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkG43q+qqCNUFDjYbxstmwCKvZ/MzsP0P/HPxBZSk60=;
 b=JnMadKMhjzgwasw9ZLqozYjLRD2cCKfjmHRuuhvhknbP1pzL4EMyPFqv8kb/Hhlg8YRm/tITxtbWNMIxGgv1yacH8BORifb/uL4j5WednNSabrFbeAQsSee4GfNfp7mJbRRZW1RWb2cG8V+qbQMXQqPX2+NghV8S2+tnWaBaYbgxgrz85MyEZZgSf/qjk1cL5jWyTjlrd/LLKW9emrqtrZQ8zJEyCrYz8Ees3Z3yXrwjv5kDIIho5F09+JT/gSsOnBA/wjr1UgoiGCa9h/fYL6bP7nj59TTh6x6M6JYhsaYhvl8hSE4GhcnZuTdS8JiGiKuiRasQvNX/ShMWdPJxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkG43q+qqCNUFDjYbxstmwCKvZ/MzsP0P/HPxBZSk60=;
 b=DZtbma46uZ+AURHMtxUlpV69HcZYDraRAujmJJlh6XhtNZwXiycfYXTX3638yK0bzI3OO+i4ODUdwXWpwGapOdsICCdJeGmZXcghb1jyfMFyGtR/RLIg06on6HWcOwK5OCTx3quHfsUeX38WXLgNyJulAn2MCpgmj6y7NkLeD5s=
Received: from BN9PR03CA0759.namprd03.prod.outlook.com (2603:10b6:408:13a::14)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 23:42:43 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::fe) by BN9PR03CA0759.outlook.office365.com
 (2603:10b6:408:13a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 23:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:42:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:42:42 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 14/15] cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
Date: Wed, 11 Dec 2024 17:40:01 -0600
Message-ID: <20241211234002.3728674-15-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: d19605c3-19a8-4472-fc54-08dd1a3d8249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RTo8qDvHcgeOiWD6HWOABSct8hKtEIrCeirz3jU47rNASTMRJNBNAb5mO2Nf?=
 =?us-ascii?Q?1XUBlnmCjOd/HrAmizC4OWnR2sZjgIlB9oMkgi2UF3W0XqVAMKOVliD/w7M7?=
 =?us-ascii?Q?BvlJn85N3OZcuFxHDPZXx5JpNO5H0Y2C3cSvuX9rcbJyglZAKzM0b+ylGW1L?=
 =?us-ascii?Q?Fp9UIoi5KSPxczlOr54uYjl8BiNakZPy4ot/1TmCLYh68LDOsNTImA4hJPK8?=
 =?us-ascii?Q?XCY/6hAjswZyBnc+FfFNe/dfaauueDER34e+aJCNSXnxJ7C0Kzid31NwUlAQ?=
 =?us-ascii?Q?d/SzE+tmwVX/vMakFMwGOQ29zyIp5x7BgNb9zujXqY76LHkenVhPfmtE6yks?=
 =?us-ascii?Q?kLr4DOOhE14BpQCaYRFExnCLZ+I1/WWRiZx6TRw6NgcW7qcbqO6bjWlZMPVc?=
 =?us-ascii?Q?ll3dDl4AoTwcpQqXK0sc6dwhDTFrPdKzgRswiQckjnvfdmJpVUN/b2bIg9Vq?=
 =?us-ascii?Q?pzv6IDp9iEN2FlUIu/BJaoxut/Kx547kI+j2+zsW7QuvCeFkCbe8gdln6KqY?=
 =?us-ascii?Q?jDXwpCZwA6bsXUl06M52M50uZzTBkkjJhWE56yDzTThI+dUZsxKyoMVRPihS?=
 =?us-ascii?Q?5b1QGfJ7e8/jUczjKrDCnGNwmEqKbl9BI5DXHpER5DJA/Mf8dISKApwZnApa?=
 =?us-ascii?Q?C4YkHj+MEf+JbKdjfOyC/mDpfYAYeayUOYbFrY3mpjfWk1B2M38Xng5UUGwd?=
 =?us-ascii?Q?NVWGUWNfRi5Oz3y7aeeuoSjzQmXYQuLOaPr1EBzPa513sEAU8rc5/4TLx5Wb?=
 =?us-ascii?Q?FznIBl8OcjIUnQTwzZ9zbCCaAF/xT5U5eYH59S8YsrXVrTM5N4uwhIbjBwM8?=
 =?us-ascii?Q?+nbGIB06AL0TFYLEvsTg5glVI3R5c3oCtOjNpRGSOMamIPG0WK8trZ7dhGPS?=
 =?us-ascii?Q?kXMI4gsoo9oK4KXGEjtvZEI6/AqtCtzz+TvvyTWL6MP3mZO0DxLIeOuAf8OO?=
 =?us-ascii?Q?DqbGOSFXZLFdVSFXED5OBsumkdRN/g3zwY4TnKN+gMZ1Kj25jNxYX0pGQxyf?=
 =?us-ascii?Q?IHdM2qs5nvegEfIznHUlvXnzKSHRWTWdlAL0kaGsXNBKaaMbeq7VY4klkEUT?=
 =?us-ascii?Q?0ZmvvCsiFS68kHWrdrq2AC2LhUYbMHpynr23hUZNNS25l8i+NMShv+KeZlDh?=
 =?us-ascii?Q?lGSdsAVtzJjj0F2/X6Ye4+053ycsj9XOMy1HTqffUtPqOD+vJwrOKqOjGEcJ?=
 =?us-ascii?Q?pzhtrvADpkNK/UkayaCaC9zaDe7k9LLQkK/BtNyga3oGrV1kUl5/DvpgJ2uu?=
 =?us-ascii?Q?BAtWK7tEKfRih3I9ddwGsFaD/xY3zqJfM5mgO8NEORiwbP3HPRfGNS43NSYR?=
 =?us-ascii?Q?0lwUvLJN6FrKczip23ocQJJUoM/9pTVn2yJYmVU2fTo5Lsc+7WSjAIhLeoyW?=
 =?us-ascii?Q?8Q/X9GpGkj+oVSRs+FjBViFIuDsORuzx18liv/2TRgwEAbuiUSIRgiI5qfYk?=
 =?us-ascii?Q?HdDPtQ3EIu/3NsIJzJ01SIrk1cvTxGlCPtv+jb6rgFyWCjKq6yas4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:42:43.7067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19605c3-19a8-4472-fc54-08dd1a3d8249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
The handlers can't be set in the pci_driver static definition because the
CXL PCIe Port devices are bound to the portdrv driver which is not CXL
driver aware.

Add cxl_assign_port_error_handlers() in the cxl_core module. This
function will assign the default handlers for a CXL PCIe Port device.

When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
pci_driver::cxl_err_handlers must be set to NULL indicating they should no
longer be used.

Create cxl_clear_port_error_handlers() and register it to be called
when the CXL Port device (cxl_port or cxl_dport) is destroyed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3294ad5ff28f..9734a4c55b29 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -841,8 +841,38 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
 	return __cxl_handle_ras(&pdev->dev, ras_base);
 }
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected	= cxl_port_error_detected,
+	.cor_error_detected = cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
+{
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver)
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = &cxl_port_error_handlers;
+}
+
+static void cxl_clear_port_error_handlers(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver)
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = NULL;
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
+
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	if (port->uport_regs.ras)
 		return;
@@ -853,6 +883,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 		dev_err(&port->dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
 
@@ -864,6 +897,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
 
 	dport->reg_map.host = dport_dev;
 	if (dport->rch && host_bridge->native_aer) {
@@ -880,6 +914,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 		dev_err(dport_dev, "Failed to map RAS capability.\n");
 		return;
 	}
+
+	if (dport->rch)
+		return;
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 
-- 
2.34.1


