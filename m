Return-Path: <linux-pci+bounces-8880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1590BBAB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 22:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D12828B3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6C18FC90;
	Mon, 17 Jun 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0E4gTj28"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BE18F2DD;
	Mon, 17 Jun 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654698; cv=fail; b=IgM5TctwvPex0KmFJXp61y2vgW26AWeiFjIfpu4zbozGpEFieGzFjcWZgCLDICh2ATrmFPtG1lSovfdTM46ycU0eyWkC06I75eqmP6Tna03XryXej9VIny2kPqH/QhVBluVKoGJM9rasyUxZ1VAzzLRuuX41Ti4AxxOsebcbptE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654698; c=relaxed/simple;
	bh=I8YbldKXiWn3t7cWyoVjtC8qAgtObcRa6GNqAbqkigU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGH+mqHFd5W/T26BrRUoRixbqzFA1Hhs/crZSNPl+P7dQ8htPinaM8hHgCy26flmkwyPtPJiLWdNL2VaAB3kOxopt19cvMfBGgLWlWWVk6rCp1xzAHtiJ7wP7Coi/H7m3KbQhatn1uGwKOpOTO4SOKAzrm8/pOWescS1S/et3wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0E4gTj28; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdHzhDwX9JjzvRCfPPwKASHLHHnJaJll5jUVYTy0186W65yhAMlUdkmZwLNPnUm6nsn4f+EaCj85zRbyHtKX1acmCS9MBRmxb8S08Mgxry337sUmeTtMrNFY/qnDwfMgTgRj0B/wSsIowbE+v6956FcnWOtxGDRsuqfKB35bTyS6ccyyrHFGcQ9GKwPCRf6OSPltpF7tqHUfaTYklVkga4/7Vm/ZmKp/hAU8XQOSZwIjE2M0UUghhQ1jpiQHgp1bFfX+wiGxmiQeQgzZ/LwHsNKLu2PVMuD4r1U9qzq4W7XkwSCYoAWxFgmYHjjXea2NLdIcSzvdFfeNz83FgY4f/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMRJJqWCuuwDTeuS9t112XMcqjKsFD0n0c+Z5H69HRk=;
 b=oBVH8SfGvbFnWc0Z18tV/VLK/fkJerzeWyM6iwT6YR3dLUxtcqTz+wD+Qz88R6kZH6SMMubLQ354J5Dmtj8vpQ6OItWNXV24s3WSP500TXVrB1ucfOb/9VXhO55N+xTYfiOd4vxpeeBYOYjIe092EodEZVdNq81Xng/tVli/fFLG/weSoTfCJARi2jH8MhcONygF81zLbFWMWGKNzkO4WZJN7faEN90yMJWqDIn9BBfPr+OunbRlcGnrQ4n1mBLfhNPR0oX0ehtMH32VCpbBsqRIkixAB/sh4k2+TZT7isOqefG8y+41PDOTM4p24L9SHTCviLyCnEJzlHLnOZT/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMRJJqWCuuwDTeuS9t112XMcqjKsFD0n0c+Z5H69HRk=;
 b=0E4gTj28KMUTwGXAov1VZvfzuqSiakzVjWK17za3/R4GJud46CA9E5deQO2UXzCaWFWB4djwlhI1EaWc+1dVnu3V5/cqLBtHKK0Tv9/bRGgv3SluG/gjxuygLT3+Dk8gunBWZ2/kC/ZnybBoZw0kx3gDn4jYwtdMBQgwXXK73RI=
Received: from BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 20:04:50 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::85) by BYAPR04CA0029.outlook.office365.com
 (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 20:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:04:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:04:45 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <terry.bowman@amd.com>,
	<Yazen.Ghannam@amd.com>, <Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 2/9] PCI/AER: Call AER CE handler before clearing AER CE status register
Date: Mon, 17 Jun 2024 15:04:04 -0500
Message-ID: <20240617200411.1426554-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617200411.1426554-1-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: eefab12b-fdee-46f4-7899-08dc8f08beb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rLfLrvpUkQ1LPlFMrydcq6bAEdhRwrm8FZVITc63Uo3eqzQcHDnU++AHtMDY?=
 =?us-ascii?Q?bKMz5lqfuimZQThzc/cUU+hQtVYDPH5d8P7S70aGadhOEmkLA2miDkCFx3DC?=
 =?us-ascii?Q?Rc8BP5/dD2xKTJJ0e1GfERDh/nFtW4AJc4F6M3GkeKKfOZM6yiincQ9rylVA?=
 =?us-ascii?Q?Ugt47WvNYxhevJkS9C3i3qSPMHg/GZlMR/gqGy8EtRcHVZlTGrtxXbZLHJb9?=
 =?us-ascii?Q?bWE2qvIykM2NGmgmX/whFY1pW2mVZsetC0TmSpwnLT59K+v3ROr+bTEgOJoP?=
 =?us-ascii?Q?NcVR150f5ijcLFTi6AEZX6UCJ9bQB+8S5x7l+QXJegfedpUBm4yiJMymz5um?=
 =?us-ascii?Q?I4LlBhUZy+2Td7PSDlLkzPudazBYKvoegofTg0yJI1+z0BOxGyoqXtt/RJVj?=
 =?us-ascii?Q?xysV6XGss5TG87cmCvphA6Z0nkC6n3/bQQ8OSkegsWpe4ZAEnJpWeuMSoTJL?=
 =?us-ascii?Q?pZWiPaVggY2172uMyl7RbK3qVd5Gqb/Bn0s8mrGfXGrnVlPp8OKIXzknVpu7?=
 =?us-ascii?Q?u8qlbK8+wDAgMM1MBzUNt83tbC5j5EfSdjvTb43rh944BCJgQh7+Os4buVzb?=
 =?us-ascii?Q?rQ8n2J1jChPfJiCJwGtz88E5i5VhOCpz9wiQmWAOPeYKNmhwyF6xeAfuNNuL?=
 =?us-ascii?Q?D0yBtxhmAi8wJdYTseCWFf5GoF7odCKUdKj7EEzrWlX3Kcc9Zg1erF5Schtc?=
 =?us-ascii?Q?f5V3kHvENzVo+vB6k249cf99TzhO07y4maywvz9a1HrAXcmlTKhY3iJnVN6M?=
 =?us-ascii?Q?fld8UA4UrQeVoZAl2iJWqmK6B6LxA9EpexKCPm3vHXkgIt8VQ89qlUiCxgEw?=
 =?us-ascii?Q?3le0VxmUJuQXexRsngi/SU7kMD4oLe7nGy69myQloG9WcjYZ/qFFAz2rnLX7?=
 =?us-ascii?Q?oksRyx2TEBM+zabN0AMBKLmCqIn2LZeZnEe3AVw8hOZIK3OUEginKVDV0u8A?=
 =?us-ascii?Q?NcQdWbqH4m3F0ENv1nMeLCvm/gQvQgzqfFbcvMWxnHBHIuITIISDrl5IMn8Q?=
 =?us-ascii?Q?0unMiq1/Sn3wY5lzIEG13CNm0yM3mEq7vYq/Ce8lsDYChUCdi0fDxCzar4fw?=
 =?us-ascii?Q?wpURbOhdxM/v4PO7h4h7EYxSU6bZk20BrO3yzdNNFxR8nbDKFGcBD2cpIJJe?=
 =?us-ascii?Q?jmGpchVl2e2ebJayPWOChLLJbpBShFpeti8bvARW0Uyco9n7J9LJ+Qrds/7G?=
 =?us-ascii?Q?nKraQDQfYirw7vOPZKGSSqGGSYLt3S6HuOYZQ8hCtsKtHp2LkHQtkq+NIQHV?=
 =?us-ascii?Q?PbHkusrjo/zafCZMDtE6aM6x7m+6FnchiiVFrARaehS4I5+FsRmH4yHANnv7?=
 =?us-ascii?Q?ipt89xj7+OUtKEE6OxLS6qnKLyJaSugzGhat9gzJCJyGMhBUq5OiQ2feq35h?=
 =?us-ascii?Q?tJwXmxRHYst4Kq+zhn69I5g0VywfGdbsxm424Vp07c9k6qw3rusUWJRmvEm8?=
 =?us-ascii?Q?EZH/H14S2sg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:04:50.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefab12b-fdee-46f4-7899-08dc8f08beb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

The AER service driver clears the AER correctable error (CE) status before
calling the correctable error handler. This results in the error's status
not correctly reflected if read from the CE handler.

The AER CE status is needed by the portdrv's CE handler. The portdrv's
CE handler is intended to only call the registered notifier callbacks
if the CE error status has correctable internal error (CIE) set.

This is not a problem for AER uncorrrectbale errors (UCE). The UCE status
is still present in the AER capability and available for reading, if
needed, when the UCE handler is called.

Change the order of clearing the CE status and calling the CE handler.
Make it to call the CE handler first and then clear the CE status
after returning.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/aer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..4dc03cb9aff0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1094,9 +1094,6 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		if (aer)
-			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
-					info->status);
 		if (pcie_aer_is_native(dev)) {
 			struct pci_driver *pdrv = dev->driver;
 
@@ -1105,6 +1102,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 				pdrv->err_handler->cor_error_detected(dev);
 			pcie_clear_device_status(dev);
 		}
+		if (aer)
+			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
+					info->status);
+
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
-- 
2.34.1


