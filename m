Return-Path: <linux-pci+bounces-12046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C195BFC7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765B81C23330
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212981D1F6F;
	Thu, 22 Aug 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="joVyEbG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E991D0DF9;
	Thu, 22 Aug 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359374; cv=fail; b=A2htLuxFAVNzHhMKdrhocn3WYB0x/6Dx26pywkzQJJkGzZFe7KTKxVnsyR26eXKsYBSnVn8v0Vq2wq2TCC+Z6Aj6S/fk8O4QyKAjzBSzuxa4RuSOvo1/DoHNoL6jA+tw3TTLoyFSDRQ1DxiB+CTUdB6DBquG0UJbOrbLzdkRORw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359374; c=relaxed/simple;
	bh=ysBYaKmuV2CiAKRG8LXBhMR8hLqWcYsa0EijbBj8O4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0zoD+J4aoQMzU2nSR69vNotHDgYCn0Di2719ZsmVU/Tv2sFdsMXlrHUwSv0JSK8UGAMHLkZvwC1kb4R1u0bQX9CD++auDRfmsqEAUmzCKDwa6rNckSFF/UuP8P8fsDJVs1OBKOf1611OT1LzbdSFcLj7OCx1WRuwUfZVQvLov8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=joVyEbG5; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO81POAIOSEpofIjv30WX8DD4GgL8dr1r3EKo6agMQuWnVW4QM7CH5RjncveAWvFs68sIO1oy44m/W0LB4pNYVLOVmKrC/UZSvw8ZRAGAscnIVqUh7NQkvV565PwDOfJZYDJxFpucgAO+qjrAChA2DT1uMQFS2iGj9MA2cFLUjbK/cxisDA4DK+UPF5Ca9GYzsX2DXDZ4/erFXiSr28R+aV7Zf8o5Zz2pUbVYBBY5Sg1R2U1RnVKzPp2aMHI8b/RvnHo8vKO+YLlgaTZaxPTtluzGPPI73uI6zC7jhaSr0dTJnjh2S8ICBDIO2REHJTYLwTbd5Z4LVbdPg2nsPtxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmxK14t2ZYd+bJqSgCt8gkWac3sxRoapV8YMXB4gn34=;
 b=d7NrDj8du27pvUpYQQZ3OUyBZ3yXt+FkrwxE5pJ4uJDPoDnZwwsNmeyCWreIFSdJswyR0XsxbVvO54/58nITpDm3102AebD1Mpr2vp6xKmRVTVouF1CPnyXVS3feE9nJsr8/s/UpNFIvs7Fv2iDilp4iHEiZiD27mVJzNIeX3E2cV5ipO0B/O6FikPCjB0hz5IO782aiJ+I6TBm8HcM5rGlx1qDJKyzvu68uHiWjqlCqgLdKGQm/NEkPQdZghjb/QXHZkL9HKTzYvWapofdhUmWgvH6E5BPXlG92hPoEGuRiI3aWFxolntG4IzC9w2MuGkfmVc4tT+z3E7kwYVTFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmxK14t2ZYd+bJqSgCt8gkWac3sxRoapV8YMXB4gn34=;
 b=joVyEbG52b1dpaaMdg6gCQGdUj1e73i9ZsP4wfZtcBoTryjZ4/hT4mF76krTctYeyaqjh5Ie78P5gEHLaPRGL4rUK1JMa/Geerm9mSYQTlc1c3G6m62Z83vbSb+JnvLEu9NZ36N468Z+0u7RHenq+bdrEPgLs9LeS+cESN2UHTQ=
Received: from SJ0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:a03:3a1::22)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 20:42:49 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a1) by SJ0PR03CA0377.outlook.office365.com
 (2603:10b6:a03:3a1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Thu, 22 Aug 2024 20:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:42:49 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:42:47 -0500
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
Subject: [PATCH V4 07/12] PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
Date: Thu, 22 Aug 2024 15:41:15 -0500
Message-ID: <20240822204120.3634-8-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: b1829079-1b13-4e00-2137-08dcc2eafc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3Irm1ATT4/oAnFRDAcv1OWCX52jODnnGvSyrOIRahS9zNwnhaZD6/e7hAb9?=
 =?us-ascii?Q?VGG3Y2D/tpWUzGaD53uu+jONJw6LG3WHvNxj+8mH7GTWYL3vhX5xGZxFsntg?=
 =?us-ascii?Q?dbSiyk65nPlXRHT6uPuPmXfsUdcdb/O62S3KIQ4avmF7ORHzQ5UXjg16aYV6?=
 =?us-ascii?Q?LaWGZw6gn+b832lli3sH9ThDzxGLlqYR1JgNAWogfvG4v4s8nz05PNLvKgbg?=
 =?us-ascii?Q?zrclip9zK9ETH6L6aCkCf0cvDgtBluM3lMSfPZH9cWVqpIymA3PcAj/9TDSf?=
 =?us-ascii?Q?9hQAdmW3BjGA8gKRKRoHSHD0n7+IuX8pvqQteg2S2q4ceOUeW7Uge67eHMYr?=
 =?us-ascii?Q?CDkUuoFi3/Xs66ngjpacfqJG/CW5dBKiVnC5sf8oxwg4IYlEToPKI++jYoAm?=
 =?us-ascii?Q?DTESCHW+w1Rj4mRFPCpXz4R3mnRxYGWf23DHy+9uy/K4qs7w3p/MB7bOto61?=
 =?us-ascii?Q?0VTcYJkiAzrmTSveC1uIomF3zflyHcDTmJO3yVIS/y84SEELNGsRBSzyP1JU?=
 =?us-ascii?Q?z2e2rLhB0GnW5ZBtv1vP3o4coiAGXMbIVbq+91SyvzAGjVndTuA0v8tOAhQ2?=
 =?us-ascii?Q?IK7irhnJuZia0IIhfRkNr+5vwiJ1YfljLm2S/sSsZgaLX7c8HJEWnsjr6XaC?=
 =?us-ascii?Q?AXACS8mCzNp/WQ682dc06eiJU5OtvYMQLqSf2qFlT4GUk3f/z4dZt7RCG5kW?=
 =?us-ascii?Q?Q5pCHyGmdRh+fU0xrGc15BFTIfQ1nP6D2hGfItNmaiYL/82stug3a4Ul9kO4?=
 =?us-ascii?Q?EAJwcryhtINGQ8FwDVXfzpC6VSAY/v0yvrJB1NCBwiZLZQc8bepGQgaz3JN9?=
 =?us-ascii?Q?F9+9lz1VcNeZmgG4VUTzLdE7iAM+vlvZlusLYVDVYI8W2bVSUyA/KnDQsq7U?=
 =?us-ascii?Q?4p+7H5wWNBkbH9FUo6GSeY8Dq4eQConQSDBg0p6HBugv2O2rcc6S/Biy0VW1?=
 =?us-ascii?Q?14XutgE7o+f+et8HQhcbKe9sg3k19771YAQyGD18Y5+v1ggJgOQEUA8haGiZ?=
 =?us-ascii?Q?mKQEamxHcx5F/uRfuPGdWZS+HibZg4hh9vmarfmcCgDBZ4V0QvQj4Z4KCBfD?=
 =?us-ascii?Q?l4hQ2jkabnFN9ohTS0ioXLg4jPBLp+HKoqNVkD0SQ4O9euCxHZUQFxvF4W2I?=
 =?us-ascii?Q?nsPiTLj9TfPgaDdLtfQrXqNh7g+P31Hj7c3/LK4BDW0C2elp6SITxjBIUGHW?=
 =?us-ascii?Q?73iXX6G5UoAAtzpmO+ulhJ3O8F0lURkbAxWrqXgm9IokwA6i4XPUOPfS7fv3?=
 =?us-ascii?Q?91+ZZ6HfaIZfof61N3bAniVxw/xCtTaLwyWHcot64AQTEyxI28L4cgnRmiO+?=
 =?us-ascii?Q?12Gc0bi22goSmP3luxlme5Ew7e+Zzrh3kn/i3dYObE+P5TuTpQGTOtnUG7nX?=
 =?us-ascii?Q?K79eOviPnep/gGdiDKcx04q1/3fL/wlcCUFhOI8U4o9rY2yrEpJuEogIhNZ/?=
 =?us-ascii?Q?EBvR0Q77cFNy6ALzdGMlb7mTqEAzHmEM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:42:49.0170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1829079-1b13-4e00-2137-08dcc2eafc5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188

Add a function to update the device's steering tags. Depending on the
ST table location, the tags will be automatically written into the
device's MSI-X table or into the ST table located in the TPH Extended
Capability space.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 161 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |   5 ++
 2 files changed, 166 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index d949930e7e78..82189361a2ee 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -8,10 +8,24 @@
  */
 #include <linux/pci.h>
 #include <linux/bitfield.h>
+#include <linux/msi.h>
 #include <linux/pci-tph.h>
 
 #include "../pci.h"
 
+/* Update the TPH Requester Enable field of TPH Control Register */
+static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
+
+	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
+}
+
 static u8 get_st_modes(struct pci_dev *pdev)
 {
 	u32 reg;
@@ -22,6 +36,37 @@ static u8 get_st_modes(struct pci_dev *pdev)
 	return reg;
 }
 
+static u32 get_st_table_loc(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+
+	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
+}
+
+/*
+ * Return the size of ST table. If ST table is not in TPH Requester Extended
+ * Capability space, return 0. Otherwise return the ST Table Size + 1.
+ */
+static u16 get_st_table_size(struct pci_dev *pdev)
+{
+	u32 reg;
+	u32 loc;
+
+	/* Check ST table location first */
+	loc = get_st_table_loc(pdev);
+
+	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
+	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
+	if (loc != PCI_TPH_LOC_CAP)
+		return 0;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+
+	return FIELD_GET(PCI_TPH_CAP_ST_MASK, reg) + 1;
+}
+
 /* Return device's Root Port completer capability */
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
@@ -40,6 +85,122 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
+/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
+static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
+{
+	struct msi_desc *msi_desc = NULL;
+	void __iomem *vec_ctrl;
+	u32 val, mask;
+	int err = 0;
+
+	msi_lock_descs(&pdev->dev);
+
+	/* Find the msi_desc entry with matching msix_idx */
+	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
+		if (msi_desc->msi_index == msix_idx)
+			break;
+	}
+
+	if (!msi_desc) {
+		err = -ENXIO;
+		goto err_out;
+	}
+
+	/* Get the vector control register (offset 0xc) pointed by msix_idx */
+	vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
+	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	val = readl(vec_ctrl);
+	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
+	val &= ~mask;
+	val |= FIELD_PREP(mask, tag);
+	writel(val, vec_ctrl);
+
+	/* Read back to flush the update */
+	val = readl(vec_ctrl);
+
+err_out:
+	msi_unlock_descs(&pdev->dev);
+	return err;
+}
+
+/* Write tag to ST table - Return 0 if OK, otherwise errno */
+static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
+{
+	int st_table_size;
+	int offset;
+
+	/* Check if index is out of bound */
+	st_table_size = get_st_table_size(pdev);
+	if (index >= st_table_size)
+		return -ENXIO;
+
+	offset = pdev->tph_cap + PCI_TPH_BASE_SIZEOF + index * sizeof(u16);
+
+	return pci_write_config_word(pdev, offset, tag);
+}
+
+/**
+ * pcie_tph_set_st_entry() - Set Steering Tag in the ST table entry
+ * @pdev: PCI device
+ * @index: ST table entry index
+ * @tag: Steering Tag to be written
+ *
+ * This function will figure out the proper location of ST table, either in
+ * the MSI-X table or in the TPH Extended Capability space, and write the
+ * Steering Tag into the ST entry pointed by index.
+ *
+ * Returns: 0 if success, otherwise negative value (-errno)
+ */
+int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	u32 loc;
+	int err = 0;
+
+	if (!pdev->tph_cap)
+		return -EINVAL;
+
+	if (!pdev->tph_enabled)
+		return -EINVAL;
+
+	/* No need to write tag if device is in "No ST Mode" */
+	if (pdev->tph_mode == PCI_TPH_NO_ST_MODE)
+		return 0;
+
+	/* Disable TPH before updating ST to avoid potential instability as
+	 * cautioned in PCIe r6.2, sec 6.17.3, "ST Modes of Operation"
+	 */
+	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
+
+	loc = get_st_table_loc(pdev);
+	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
+	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
+
+	switch (loc) {
+	case PCI_TPH_LOC_MSIX:
+		err = write_tag_to_msix(pdev, index, tag);
+		break;
+	case PCI_TPH_LOC_CAP:
+		err = write_tag_to_st_table(pdev, index, tag);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (err) {
+		pcie_disable_tph(pdev);
+		return err;
+	}
+
+	set_ctrl_reg_req_en(pdev, pdev->tph_mode);
+
+	pci_dbg(pdev, "set steering tag: %s table, index=%d, tag=%#04x\n",
+		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", index, tag);
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_tph_set_st_entry);
+
 /**
  * pcie_tph_enabled - Check whether TPH is enabled in device
  * @pdev: PCI device
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 50e05cdfbc43..a0c93b97090a 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -10,11 +10,16 @@
 #define LINUX_PCI_TPH_H
 
 #ifdef CONFIG_PCIE_TPH
+int pcie_tph_set_st_entry(struct pci_dev *pdev,
+			  unsigned int index, u16 tag);
 bool pcie_tph_enabled(struct pci_dev *pdev);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 int pcie_tph_modes(struct pci_dev *pdev);
 #else
+static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
+					unsigned int index, u16 tag)
+{ return -EINVAL; }
 static inline bool pcie_tph_enabled(struct pci_dev *pdev) { return false; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
-- 
2.45.1


