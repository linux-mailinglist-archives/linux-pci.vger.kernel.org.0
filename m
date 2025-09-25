Return-Path: <linux-pci+bounces-37058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C90EBA1D99
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2876F178DEA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5996322770;
	Thu, 25 Sep 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QHafW3Zr"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E732255F;
	Thu, 25 Sep 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839959; cv=fail; b=oOQ6eQW80h3TNhTI7pPaX3EqmgQoX6iiS7NaXB+Wceyl11igtaYUNeo5qlCOzn167KBxaaSUzlY51houVUTh9Er3z2UJdqETnw/egRTXwwDLkgsLQbn71MdwI9XOn4cBnEADSHtQsBWR8lcxlWlt5pS+tsj49zfNpNFdbV8RTZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839959; c=relaxed/simple;
	bh=h4dg/ge2NznoAneUGTJ7IxLp78E1E6MJioH3d/tKtx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsOQaz4QH5IpeAXkWQNihn48oMlrJMxHxNNgywWCdBDPmMbwHCuNa+cAWvy8D+LI6chq23TMsRxEpOWPAMmRbIW9n5/tnIBZES5+yGCFvZLuZmdo2G6VnW7YhwmMcv1CZa2FPA0DJvOu+k2E6VCbSm+29DEe79D+H5fK1aqVDak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QHafW3Zr; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzsFUOtO16QEunlpnRXwfwWelyVZzOxKJ+mx/XSFv/5+gPXGHwNV6g0pLq8EJYsVjJ3VylHn0IU/ibpH31VdT4NVpH0YDRLYuF01UeTfK55l+taPc0YVyVO2Acyml/aadO3Pq4B3N7mVsBuejC2Ppw3vHn7xtd4JEV5LYok7ySGVLUPjoTev9M1ozFlqeoxuh5ijdVmTII1cWrPSiP+wkAbynJX9SgBmTS8RobybXKX5ca0jGCLB7ZI9Q/3rZTLT1ivvhfZ209ed3C7+gHHlCqt7yeUeqg5tPZmVopio4/oO4uRanu7bXt+wMXUXCz0bqdgcDdE9XJJCB7QphmuJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuQ9uO0+p8XHKYUCcCMFCqlE/46xEYxZvvOpfhRg1fc=;
 b=RJD7C0tzSL1TvQtgDKaXFsdpKu1JpqjbuETBgvBnQw00JVwz85CrxPTG7dgkQha3Z+nvWsyWKfazs2naWiD8OAoZSUCefd/bjc9cOUaYBpF56m/2jQDYr7yugp8D9t9Dp7E/TNB12o2psgUW+/XbaHT4fsWNsipherBBaaiNYJD/RsiDXb7ogwymDWKeOPNRU4SkWMpBcap1BXuBC4AXFfXaUb8Uz99EzHMzCGiHaX0Q36PqjzsAJIVnGhnLb4zIfbtXUvGTlL1A5ov+l+UZVQqeRNfmGM2n/EJk0S2mkKTDxk46bj92feL1x3xLD2HYPThyymIyr/XmpWqtZDlHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuQ9uO0+p8XHKYUCcCMFCqlE/46xEYxZvvOpfhRg1fc=;
 b=QHafW3ZrHF+5k9X8nDZUggHNqT5+wB03PHT0XwUyC/QxvNUJJqC+WWyZWGQVJeXBKqQ/9wjfzWwRGqbdfLeagyuEes8f3A247p9bjcvqD53bLVKRYV7a7r75G6SAgR/TZGuvldj5nxifjqx57j2WD5RrRahPzbBH5DNgj0hd3/0=
Received: from PH7P220CA0066.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::21)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 22:39:14 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::a2) by PH7P220CA0066.outlook.office365.com
 (2603:10b6:510:32c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 22:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:39:13 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:39:11 -0700
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
Subject: [PATCH v12 24/25] CXL/PCI: Enable CXL protocol errors during CXL Port probe
Date: Thu, 25 Sep 2025 17:34:39 -0500
Message-ID: <20250925223440.3539069-25-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e9b114-64b1-419c-71bf-08ddfc845a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vkFniI3QDzDJJqmhIWyZD1nbD0et/eJFjFW86ZUSrD8kplnb9fIuLLPApfN?=
 =?us-ascii?Q?cYLi4r6lYvl7C4zConHHb3EHFowaSGkjjLHcfxPzhvnTwLQq0HpJ8ADhp9OB?=
 =?us-ascii?Q?EXNwbB2xHu2Dk60BVsvD++u7NJAd2EpWeVVPjw7QJwB24XA9v3MSAluGufdv?=
 =?us-ascii?Q?8h0DSAP1P8gGINPTA9rRra1ivHiygNa4vAeprnomay4Uy0KixPGKaCtSPiaQ?=
 =?us-ascii?Q?jrZEf5iW0Hx35IQKK3yOsAJ5RjNCiK1FdznDaMBQQRdlQB+oS8gCYKgkTaF/?=
 =?us-ascii?Q?C1Skflvyg5uINOveVRmwTBiz9Ea6tDSRKpJSaF0k3qAyq7x25TOF8YL2H1fn?=
 =?us-ascii?Q?hQjdfzYAarKni5vYRk9tGlxlmEqvr/6AQ4cEwtotuuY1ZyJxa4GjaWPPauAz?=
 =?us-ascii?Q?dj1OBkhELH1zglWf/EuOlyT//yPGtmIhzRlCFKNxBl4C9tUzrIgVZ2D+zWpM?=
 =?us-ascii?Q?whPGJv4plVzEi1GBl4f142OPMDy4euENDqD7ZK3U9fgG2CQtthZh88peEk6k?=
 =?us-ascii?Q?cRg01qyK39FfNmygh+ISbjK0xL8gkHgkcZOy/4UXwzwYGtH6m9qthJ8bDxtB?=
 =?us-ascii?Q?zhB73SaPMJqLzesis0gLSUx6Tip6JvflqlC7mow4Ot9CHUJyAnAOvYWO3SF2?=
 =?us-ascii?Q?Xa7K7oyHb9tWswhTKPbRkyqvUyc3EX0ir2SHdvWop8IPxED2jOPli37eRv3I?=
 =?us-ascii?Q?WrTu41V2vqkKiEv0toBjhsSbsiHsSUe0Ku2qTCbnwCl8Omqylj3npX2RTEPN?=
 =?us-ascii?Q?qLAovMzfaOG8D/iHSM51XCQdFHcALq4SLoOhH13IYdcpkTZsktDFhtAKc9cV?=
 =?us-ascii?Q?ouL2+HAHFy/bFY4bA3q4SHTEx6zbwhA+fo7Ep09wWUVdPeEd1OOwCWVVO57Q?=
 =?us-ascii?Q?KviJ+Cp3Ss7vlcQmTdwd4zQEsc4km2P1iHAIrwlknRaSP5+cc4xIolwFE7cB?=
 =?us-ascii?Q?7YaGWm+VdyBHAT0NLjtP7xQXtOlkZl8Zt0vkVbJli5hQRLnWlv7CY0DgWq4Z?=
 =?us-ascii?Q?BU/H9gknDhoSLjExKnp8R0B7hjv1QIjxtuB5gHa4MEDOqR8xrcIYrUq9B/Fq?=
 =?us-ascii?Q?shwbBTYWWTVIOkPz4kdL0ze91+eke4ZRkSihqx8YrvKQgSZNwzmbeDTeEMtb?=
 =?us-ascii?Q?GXHVNgd1Zaz/vCoRhMwr5w5lKiTwnq1PtjKo30Md7Xnj5JcHWshpwDVIwy2c?=
 =?us-ascii?Q?b1ceoJl1IpOwvM3LAMW5wVWP9JZCtd1AquyknlYZsMpnRbJ8/5z8stoM2nAF?=
 =?us-ascii?Q?tzJBwm8qXaOsVosGUnRJXz5Rew3yurls+C5zqIxhPf1TTnShUkYxCFwPc+BG?=
 =?us-ascii?Q?HYIfQRyidla15nYrDxuDUJxgnPNTP3kU8sCIf+pqtE4LNjHRlW08sEferlkU?=
 =?us-ascii?Q?HASnsXelUmjOczDESq2EWN9qFtpAAlzHnHnzHmrbcolhaJMrWOBPjFVH6rrf?=
 =?us-ascii?Q?vrs4FiVoIYnM2zzJ6+qLqU3edWrBy2GzOhcnUz9uITybs5JCcZXXKWAaFLm6?=
 =?us-ascii?Q?0t/EaPpWXNRQZaVYThakCWA4ifOWnb3I12vvJQfD5nUhR1oRlDTgASkgvQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:39:13.2123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e9b114-64b1-419c-71bf-08ddfc845a0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

CXL protocol errors are not enabled for all CXL devices after boot. These
must be enabled inorder to process CXL protocol errors.

Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
correctable internal errors and uncorrectable internal errors for all CXL
devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---
Changes in v11->v12:
- None

Changes in v10->v11:
- Added check for valid PCI devices in is_cxl_error() (Terry)
- Removed check for RCiEP in cxl_handle_proto_err() and
  cxl_report_error_detected() (Terry)
---
 drivers/cxl/core/ras.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 45f92defca64..ea65001daba1 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -238,6 +238,21 @@ static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
 #endif
 
+static void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_dev_get(to_pci_dev(dev));
+
+	if (!pdev->aer_cap) {
+		pdev->aer_cap = pci_find_ext_capability(pdev,
+							PCI_EXT_CAP_ID_ERR);
+		if (!pdev->aer_cap)
+			return;
+	}
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -391,7 +406,10 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 
 		cxl_dport_map_rch_aer(dport);
 		cxl_disable_rch_root_ints(dport);
+		return;
 	}
+
+	cxl_unmask_proto_interrupts(dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -402,8 +420,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	map->host = host;
 	if (cxl_map_component_regs(map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	cxl_unmask_proto_interrupts(port->uport_dev);
 }
 
 void cxl_switch_port_init_ras(struct cxl_port *port)
@@ -440,6 +462,8 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
 	}
 
 	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
+
+	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
 
-- 
2.34.1


