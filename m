Return-Path: <linux-pci+bounces-12048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978F95BFD3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1813B22FCF
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433691D2F78;
	Thu, 22 Aug 2024 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5sjDDvQ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585B1D1F4C;
	Thu, 22 Aug 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359398; cv=fail; b=s8+T/pS+aWHHdxH3v/AZevH/JJvtvtd3SBzhM0Gyq4HuEA0BNg9JcsIizXuY5lWLUEPEapMSdUxuybUgjMngsYp116vvEE/y4GtXt/2fW5Z3NPHukRzTJkShTFNL9znMy376BY9ITUtluw49mjP7+iZi/hzV1mecX5uYb3cnOCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359398; c=relaxed/simple;
	bh=kVgWI7X5t9BwUKtMkwSy1K2pMBwxdUOBS+x2JO2o/TY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qubO9oFl1LXWGL+Gn3tuSOaNxZZVo9fQXNPE5VTnL4QQNvtgiIKw0+bx0i+tACWyIZJXjUOp/IV9tYmCyQ8OA2iSFT2bl8Zcpaxzu3g6pHKpgFbMPW/fiY42DYWBlCKIsAjtcQ1mm+zHQjdpKqquJxK9mrWikJqxGHV8czTlwTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5sjDDvQ0; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2+Q8l/nRljVmrPj60EjQk/LC3IxlZDiVvnuISoDD3/AuOmtA5RSyMDWxi6DAHNt1SJoqnxHXhislg3b94mvyulDqAN5f5mm30IO2RxxnzjLpIoY0HROnbIYPCPq6fXOKY01vFyQKcvJXFHc56/mEGRtwxtj74FsPorbSOuGBK/xoj6Nu560y87zhUs/+VBSoQFoP9mmmGQcVBIJJPPrImWzF2ZyskrX2bMEkn0gSm1Ch9pBPd/IozpiF8jMeg7HUhH1IXpWPvXcX0UynY4jgV2ih3dBS8J3mI2qg+o8M60zwqtD9Bo/Q0ld3M6Suw5kO1vN3YBWUajGo1QfiPv6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8+wjjQWSuFUEWnxu2YLMGcrlUzuzhg00LNygpB8jVQ=;
 b=hutk2SQx4FB++M4Gtsm0jTstvguj+ZXvaYU4RQx34FUBEvbdXkZfm+myjr6x9HbAzqpe0ViV92aBFKtqrzPmorepsp1gu/i1WGVCyi8Dx1t2SdEL7DhODo/8o6AjtTnJndMaNex+sbE6L7CGv84yS+/EsGJdflO3V7kgVMKxSCbnwa600Din/eK+jJHRbfZhWMFrTqaNtrK7nnaUnVXeIPZTxeO4LT4cxf8GAWrRZhQrVOPBrkQv/0wUDmR/q7lOqv5pDzxXEA9pW+0UFKhXiv1GAJMud3kw/OeGAwn+Gnvy51PPqdzX2+6HYDymNG1KeulI1i+Yd2+mV+WDSoJNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8+wjjQWSuFUEWnxu2YLMGcrlUzuzhg00LNygpB8jVQ=;
 b=5sjDDvQ06TmjJTnsVAs8FfSdcGAaOYJhAihOPZd7jiR8p6DAU6Ojv0Jtl55CRg/anr8C8E71o+zUbAYsadfH8qraYlZcehhAbNBRxVwjm3fegXUth9VfSpgzZoaSb6WwSvgMojeA7OXcBelryhGoCJ0up3Oq15cTZziSAtJg1tk=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 20:43:12 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::5c) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:43:11 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:43:10 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 09/12] PCI/TPH: Add save/restore support for TPH
Date: Thu, 22 Aug 2024 15:41:17 -0500
Message-ID: <20240822204120.3634-10-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8110dab8-7f6c-4a4e-93b5-08dcc2eb0a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsAZy2qflMc7eaVpv/lb7qT80GrxO45enJy3nMO4hfVmQyVS8zCFXbyVPOBl?=
 =?us-ascii?Q?8rKMWbna9QLOa+ZhMfYqJ0OrPcvIlx67zVb0E37wsZvnQKbNPFOSRKJn57xj?=
 =?us-ascii?Q?BW5XXAZEIKj6J6WogDOQdFdfXih9K3x5MAIYl8DYoRN2dXiuIBF+gd4kMlQI?=
 =?us-ascii?Q?Mzy/1LwYEoETT6Lh3XBMhF6HawWSBEWK7TAp2g2cwGoa/dknGhLVkR0aYrrg?=
 =?us-ascii?Q?v7Ro3GJT1vXGz8J+8VpHzLV/w7dvq6igMppXWgIsxuRDvpKQT36FTDz4lV7p?=
 =?us-ascii?Q?275RdR9YVb4ZE5aGkqC6afCSQ7QzX6er/gOic42pEnttwDapHJAgG9kO8jmr?=
 =?us-ascii?Q?t7woiWawgLxo3K4e/A4+CtCrhCCp9sr1FhkbIDptHtusID2gzLAStRtbhg+/?=
 =?us-ascii?Q?upRPCqD8Qc2+rjBIJsmxZA+ZOHhaT8IfBmaSwSguiAKOym7H8+cgNrRXH2HK?=
 =?us-ascii?Q?k4Zy016cENbGPKiwYe/rW5dFlW5zUhGmu0/C9gMHl/M6tq9+7gNVKyQr7FHE?=
 =?us-ascii?Q?zst6xihPj5JjW00VPA//BLZjMOBKzlnflo34++YKa1K06aUXLsBaz1Oj+oYC?=
 =?us-ascii?Q?LlVR7+DRkW9EoE93fIv12HRZTebim4lsu/SrpkkI9f5o5Dh1y6bTQWp6WqPa?=
 =?us-ascii?Q?XQ/3YUeLzy51di2pnedFIbEPEuF74BxG3PaxHz5/8KVBeN3v/1FsXCeoI0dz?=
 =?us-ascii?Q?+W7Sg9ufyUB1I/4QfumLs3xSSrRrsNNqwmFeZxNsh5jEDPmL7tfxXomDJGHV?=
 =?us-ascii?Q?4XYyhGRqijLueyd4ugQ/LOxJXecZczGZqc/xeUHe4iXaBodN9sC7RdMx+zqW?=
 =?us-ascii?Q?vTXNra2WT6UvdAeicWHvZij9d5gi0TcXpXcyw3iuAhUP8bAWh7dgVc5GW4QU?=
 =?us-ascii?Q?RMSy9oJNsw9fzOcEGSkQLKkAEVrbCuRnMJp1g/o5udYPuioCRCWwIyPd2+IS?=
 =?us-ascii?Q?g6dKxNrh4EIMZc1QUxQooem8j97pDOBcnSN1emm8tQXByt6CRsxZMqRneEmx?=
 =?us-ascii?Q?t4l4dCjz5UjY+xZaqx4Jx+hg8sIV6rLctj1Z5jqcLa8ih/O0DnMRWn1r61YV?=
 =?us-ascii?Q?RZzW+aiff5DWfphkXV+ohNkkxVdO3pNGIvun2MpKhywfblSIPjIwfvbgzwiR?=
 =?us-ascii?Q?73MVKJ4mRwtcPIso56wrRlku0msW7DB3nIQcYHTZA+yjuYzvqHE4GnCwv+fS?=
 =?us-ascii?Q?ba/HVCsI6q7b7nny8eHbmvv9ZAm9155wczFo7kvmJvNGRGALRr1BBXaI8A+c?=
 =?us-ascii?Q?9eNxXYr7oFMszzxbZYIkOBNn8HoviCQHb/9NCtL1nSmAkbk7gEkJWhIMnzJX?=
 =?us-ascii?Q?NKvt3x+B9zSfakCqF+HcMyLew8oRrbpdiu8/uWrYrxKAUC778o7UAOiEjlv7?=
 =?us-ascii?Q?PowD1k1eOKJcRPF4bBvPJ8MZODaUZina8H7Ly1DoNBcNbCui2mByq5xWXiUC?=
 =?us-ascii?Q?AukymEYZK2Up74zkGFFH/7Al33PIs2aJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:43:11.9920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8110dab8-7f6c-4a4e-93b5-08dcc2eb0a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

From: Paul Luse <paul.e.luse@linux.intel.com>

Save and restore the configuration space for TPH capability to preserve
the settings during PCI reset. The settings include the TPH control
register and the ST table if present.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
---
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pci.h      |  4 +++
 drivers/pci/pcie/tph.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..1e4960994b1a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1813,6 +1813,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
+	pci_save_tph_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1917,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
+	pci_restore_tph_state(dev);
 	pci_restore_ptm_state(dev);
 
 	pci_aer_clear_status(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 289eddfe350b..d7c7f86e8705 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -572,8 +572,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #endif /* CONFIG_PCI_IOV */
 
 #ifdef CONFIG_PCIE_TPH
+void pci_restore_tph_state(struct pci_dev *dev);
+void pci_save_tph_state(struct pci_dev *dev);
 void pci_tph_init(struct pci_dev *dev);
 #else
+static inline void pci_restore_tph_state(struct pci_dev *dev) { }
+static inline void pci_save_tph_state(struct pci_dev *dev) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
 
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 5bd194fb425e..b228ef5b7948 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -483,6 +483,68 @@ int pcie_tph_modes(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_modes);
 
+void pci_restore_tph_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry;
+	u32 *cap;
+
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Restore control register and all ST entries */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
+	st_entry = (u16 *)cap;
+	offset = PCI_TPH_BASE_SIZEOF;
+	num_entries = get_st_table_size(pdev);
+	for (i = 0; i < num_entries; i++) {
+		pci_write_config_word(pdev, pdev->tph_cap + offset,
+				      *st_entry++);
+		offset += sizeof(u16);
+	}
+}
+
+void pci_save_tph_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	int num_entries, i, offset;
+	u16 *st_entry;
+	u32 *cap;
+
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Save control register */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+
+	/* Save all ST entries in extended capability structure */
+	st_entry = (u16 *)cap;
+	offset = PCI_TPH_BASE_SIZEOF;
+	num_entries = get_st_table_size(pdev);
+	for (i = 0; i < num_entries; i++) {
+		pci_read_config_word(pdev, pdev->tph_cap + offset,
+				     st_entry++);
+		offset += sizeof(u16);
+	}
+}
+
 void pci_tph_init(struct pci_dev *pdev)
 {
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
-- 
2.45.1


