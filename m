Return-Path: <linux-pci+bounces-10469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171E934383
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1977A28521E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74C188CA1;
	Wed, 17 Jul 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xnmk/tRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CE186E3A;
	Wed, 17 Jul 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249810; cv=fail; b=tYMQO3N9qY/RePlus4YUdKfhodWJtM5Jph2GYEtsg7KCCEUB0d8OHulC/vyfyJcdAcdUBWeC7BlH00Dr5Qv/E/vwVVBfGgc4+2N2an3O/gtxnfI66asEJejSNYYr82U266cinrNVDSl8NyzeugMLa1WiDc+G0ItVs51gkVMbZiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249810; c=relaxed/simple;
	bh=e3o1qNXybyr/BUADudtoJkg5e3j6RBoAVhCiB7iCMiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhBKbepoQx3qRdDtaN+sU5h88Yr4rpMXntDOIFIU81YYW+fBc9OBgc+LbAqeQ3AR213SOb3JrmScNZLWy+pQR8YC0CzCXDiqq9GsKQj/vFyBp3C67wtrJR+jqI4uU5KF2vSANTeiVoUpv0+hDNgO6gnULlPOtaNkEzJ4F19U6Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xnmk/tRt; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKd/SU8m+RYP6kqz7Y96KudhEM2Vz3wJc8RlhcUkYi8mMMvRFLOeUczyjQ0QSeGzVCk6wSRU2fZtCOCn6y1SI3w0PVpS18jNkziGC/BjPr5XlnzuZB9JXwaRaPIU12puqyd6XzybIiZOE7TftOp6cFfg2m4MDcEk9tCmmiLmp98OO18QKJvhxYQWutyVhBpien9SRX4/LbdJNw7kZvgoFf7Q2WEpnXrxaDc0Z4aTPxNRmQs8hmTYswtVsDDHq1tUXVO7FVQgP17DH7l2D1b6k1xdabnB+iiuZ7DB1qZo94K9IfhpJwY2XHAca7PFhAIDNXxC9RRiAYNg58ZKsV1YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpPu0pE3/qglR1AANMpf39Ux0ylYC94TsOCuzccfySY=;
 b=f8xumUkbt6HDaFGHZjcXInF6xVA7GF38xMLee3JIwGOSxA+i21jWUBE3x+eb0OcZkTBGgz8z8Ml6QvbZ8SGU1xZ6v6oOJM4QGHigSClAREm3zyJsDwyyDh6puXXQpGLiSiVluq2ulIXIr6jmJLR7ruv26FKHGywXopFcJJOmNuZJtga+QyDRmc3FhsgmfRNqGUdfEZJa5ZEjne2hpOQz2Wf5o1FjHzIYPylL1kzbTI9dBpxnXx+Fsfy0vbObE1/EJ+DlHtl9yklvgPGjIDGjhQ+2GjVRnBkgoIEvemAXRS0jxGmovGiV7R1zf5VO49/voPjBfogWJlpoXANdayT6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpPu0pE3/qglR1AANMpf39Ux0ylYC94TsOCuzccfySY=;
 b=Xnmk/tRtEMkXkjXGvaOrCkTjW//dR+EgO1KctcGf3c5Jb25tb/OOoqUT31mKoglaid0HKckHJ2FoCbslvz3dGm/32As+SC51rdiW3dJFzyzTGRiSZvWLe+bFMFxV8Y4Jjg9yVLTMQowCORRfBMqYdcO6PaLuGIm677ptqhgxKng=
Received: from PH7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::26)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 20:56:45 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::cf) by PH7P222CA0006.outlook.office365.com
 (2603:10b6:510:33a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 20:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:56:44 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:56:42 -0500
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
	<bhelgaas@google.com>
Subject: [PATCH V3 07/10] PCI/TPH: Introduce API to update TPH steering tags in PCIe devices
Date: Wed, 17 Jul 2024 15:55:08 -0500
Message-ID: <20240717205511.2541693-8-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b55367-5aff-447a-2ac4-08dca6a2f76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bN6L+2D6wqrK77fBtANuUcTetlpc2nCgr6ginSMpwfFyvKgAXDiYMYvS8xXA?=
 =?us-ascii?Q?003+Ilf+98eUGGGYiD9bAny7ZIOzU/YRsJuC0zBw3/EK4DkTURNDPSRBsXYr?=
 =?us-ascii?Q?gJ5bERIbubLuZc6ZEADcxAvcSvkbK6e9LSohN7qY2d2ICtVroTNjTxPiMYSA?=
 =?us-ascii?Q?pna7Iu2Veq4UtUk5SeMVlG2CqpoEGE6w5O0K7yWIhn5yQ88lSTELg5WQR5Xy?=
 =?us-ascii?Q?8itDW4SuKvOBDZQYte6WiACeuczePacWk0etNBGNKClKynXV/wcSKl7nr9mA?=
 =?us-ascii?Q?Tza9Z3yvOtS7+u+ucMJUngo+sf4u9PiSYBR6Jxsbw1DtPQzjqjKFwdtBDAof?=
 =?us-ascii?Q?wh5awubLD/fHkr5zQ0WocSQZ8mIgWNkbrxOFH6OCRvzqSYfk0S0u9DlxVc7w?=
 =?us-ascii?Q?bj7cXCdC1wSpYhYk7V36FiJqBxxs7dm6XDb7yDJDR8FbczW3AldVA5FlEe0K?=
 =?us-ascii?Q?u+HHT+bI5KApmjr5FoMAcL/eeiTVM5gRIlUQMUEC8ctkyeWCWDhk+zki+3Kz?=
 =?us-ascii?Q?MTy6kLWhgMi9M8R23HlWpyO6BmFiVzqPCGiGgDr2m4J7P+O5NK7BzJ7SRfBZ?=
 =?us-ascii?Q?2PA9D3NY79WEl5XnhiHBQEw2YsaurZQClKZ39t1TsgoAoZ1s4Tle+pRvzCV/?=
 =?us-ascii?Q?DZc+SKxxuHIAfss1PL/BrAp5igskWYNuDsFdljWCFcbZMCFX+f28Sp/N5URp?=
 =?us-ascii?Q?3N02zyptDI8WIG7lsgO/dAnHEIwYIO5G64aL23I0Y1yLeWSBq8ZTiwZ4bsTp?=
 =?us-ascii?Q?oYY7b/LScYPWD3mCm4Tlgpyb4KQEjPW8fdf8iWuGZrdzjHCyIbVK/i2eRjih?=
 =?us-ascii?Q?oN9qha52eCawqh0LdQ4o9FXF2lUG5ooI9iRYLmg/FRDG3REQmZG56iUlWTTr?=
 =?us-ascii?Q?EH+y4QaCLljn74UVZc7rUsX7K5dGnQvnD/8tCWj3iqz4ciFJFEvP2exB78KP?=
 =?us-ascii?Q?A3gfG2wg3m8efrnnglXYX8n+l05Y1OLHB6LTDJGu3Hw+Rxkb1Tjl0W2yQNZW?=
 =?us-ascii?Q?vGiwFnCeRjWg5UAXwC+QjJj7CTjbLSRpKw+N7z5UGxo8i4sNs9KmQGjPtdqN?=
 =?us-ascii?Q?eYp9pgPm01E0sdDokYws7MkEXw5dmZr0NwCph2278iUd2w60Kc0/OL6WnnJT?=
 =?us-ascii?Q?V75YDvL6MGlwF18XoGtXaVbTUPO2g8+OU+V+7bwo7AggJb2SWKCIeH6hhewy?=
 =?us-ascii?Q?t93m1rZdyg8kw2hPAK4jJ1gNSR0MJL3STs6rRTcAbqgIhOeDtqyo0Zhp82lH?=
 =?us-ascii?Q?2JYgfnHix+ylrUgGmHt6KOi9pFxETyoTqtpY/EqcdprNzWr4u3+XjdQtbfS3?=
 =?us-ascii?Q?AVqJ6m6yDCt1koSP9B789KPzFyMWucRyexjNEzIglwNyBK1wB+9efcmfL1Zi?=
 =?us-ascii?Q?F9DpUCb2xPRZ9wIgaOqQP4y4PknFTBtN1Vh/Gd+pdqW5Lk9pLmuNwjh9Su02?=
 =?us-ascii?Q?VsBK9JIa6k8b/I4VjkCqls36VOk25zYj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:56:44.4491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b55367-5aff-447a-2ac4-08dca6a2f76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

Add an API function, pcie_tph_set_st(), to allow endpoint device driver
to update the steering tags. Depending on ST table location, the tags
will be written into device's MSI-X table or TPH Requester Extended
Capability structure.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 190 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |   7 ++
 2 files changed, 197 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index c805c8b1a7d2..8a0e48c913cf 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/bitfield.h>
+#include <linux/msi.h>
 #include <linux/pci-tph.h>
 
 #include "../pci.h"
@@ -171,6 +172,160 @@ static bool int_vec_mode_supported(struct pci_dev *pdev)
 	return !!mode;
 }
 
+static u32 get_st_table_loc(struct pci_dev *pdev)
+{
+	u32 reg_val;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg_val);
+
+	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg_val);
+}
+
+static bool msix_index_in_bound(struct pci_dev *pdev, int msi_idx)
+{
+	u32 reg_val;
+	u16 st_tbl_sz;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg_val);
+	st_tbl_sz = FIELD_GET(PCI_TPH_CAP_ST_MASK, reg_val);
+
+	return msi_idx <= st_tbl_sz;
+}
+
+/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise errno */
+static int tph_write_tag_to_msix(struct pci_dev *pdev, int msi_idx, u16 tag)
+{
+	struct msi_desc *msi_desc = NULL;
+	void __iomem *vec_ctrl;
+	u32 val;
+	int err = 0;
+
+	if (!msix_index_in_bound(pdev, msi_idx))
+		return -EINVAL;
+
+	msi_lock_descs(&pdev->dev);
+
+	/* find the msi_desc entry with matching msi_idx */
+	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
+		if (msi_desc->msi_index == msi_idx)
+			break;
+	}
+
+	if (!msi_desc) {
+		pci_err(pdev, "MSI-X descriptor for #%d not found\n", msi_idx);
+		err = -ENXIO;
+		goto err_out;
+	}
+
+	/* get the vector control register (offset 0xc) pointed by msi_idx */
+	vec_ctrl = pdev->msix_base + msi_idx * PCI_MSIX_ENTRY_SIZE;
+	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	val = readl(vec_ctrl);
+	val &= 0xffff;
+	val |= (tag << 16);
+	writel(val, vec_ctrl);
+
+	/* read back to flush the update */
+	val = readl(vec_ctrl);
+
+err_out:
+	msi_unlock_descs(&pdev->dev);
+	return err;
+}
+
+/* Return root port TPH completer capability - 0 means none */
+static u8 get_rp_completer_support(struct pci_dev *pdev)
+{
+	struct pci_dev *rp;
+	u32 reg_val;
+	int ret;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp) {
+		pci_err(pdev, "cannot find root port of %s\n", dev_name(&pdev->dev));
+		return 0;
+	}
+
+	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &reg_val);
+	if (ret) {
+		pci_err(pdev, "cannot read device capabilities 2\n");
+		return 0;
+	}
+
+	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg_val);
+}
+
+/*
+ * TPH device needs to be below a rootport with the TPH Completer and
+ * the completer must offer a compatible level of completer support to that
+ * requested by the device driver.
+ */
+static bool rp_completer_support_ok(struct pci_dev *pdev, u8 req_cap)
+{
+	u8 rp_cap;
+
+	rp_cap = get_rp_completer_support(pdev);
+
+	if (req_cap > rp_cap) {
+		pci_err(pdev, "root port lacks proper TPH completer capability\n");
+		return false;
+	}
+
+	return true;
+}
+
+/* Return 0 if OK, otherwise errno on failure */
+static int pcie_tph_write_st(struct pci_dev *pdev, unsigned int msix_idx,
+			     u8 req_type, u16 tag)
+{
+	int offset;
+	u32 loc;
+	int err = 0;
+
+	/* setting ST isn't needed - not an error, just return OK */
+	if (!pdev->tph_cap || pci_tph_disabled() || pci_tph_nostmode() ||
+	    !pdev->msix_enabled || !int_vec_mode_supported(pdev))
+		return 0;
+
+	/* setting ST is incorrect in the following cases - return error */
+	if (!msix_index_in_bound(pdev, msix_idx) || !rp_completer_support_ok(pdev, req_type))
+		return -EINVAL;
+
+	/*
+	 * disable TPH before updating the tag to avoid potential instability
+	 * as cautioned in PCIE Base Spec r6.2, sect 6.17.3 "ST Modes of Operation"
+	 */
+	pcie_tph_disable(pdev);
+
+	loc = get_st_table_loc(pdev);
+	/* Note: use FIELD_PREP to match PCI_TPH_LOC_* definitions in header */
+	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
+
+	switch (loc) {
+	case PCI_TPH_LOC_MSIX:
+		err = tph_write_tag_to_msix(pdev, msix_idx, tag);
+		break;
+	case PCI_TPH_LOC_CAP:
+		offset = pdev->tph_cap + PCI_TPH_BASE_SIZEOF + msix_idx * sizeof(u16);
+		err = pci_write_config_word(pdev, offset, tag);
+		break;
+	default:
+		pci_err(pdev, "unable to write steering tag for device %s\n",
+			dev_name(&pdev->dev));
+		err = -EINVAL;
+		break;
+	}
+
+	if (!err) {
+		/* re-enable interrupt vector mode */
+		set_ctrl_reg_mode_sel(pdev, PCI_TPH_INT_VEC_MODE);
+		set_ctrl_reg_req_en(pdev, req_type);
+	}
+
+	return err;
+}
+
 void pcie_tph_set_nostmode(struct pci_dev *pdev)
 {
 	if (!pdev->tph_cap)
@@ -251,3 +406,38 @@ int pcie_tph_get_st_from_acpi(struct pci_dev *pdev, unsigned int cpu_acpi_uid,
 	return 0;
 }
 EXPORT_SYMBOL(pcie_tph_get_st_from_acpi);
+
+/**
+ * pcie_tph_set_st() - Set steering tag in ST table entry
+ * @pdev: pci device
+ * @msix_idx: ordinal number of msix interrupt.
+ * @cpu_acpi_uid: the acpi cpu_uid.
+ * @mem_type: memory type (vram, nvram)
+ * @req_type: request type (disable, tph, extended tph)
+ *
+ * Return: 0 if success, otherwise errno
+ */
+int pcie_tph_set_st(struct pci_dev *pdev, unsigned int msix_idx,
+		    unsigned int cpu_acpi_uid, enum tph_mem_type mem_type,
+		    u8 req_type)
+{
+	u16 tag;
+	int err = 0;
+
+	if (!pdev->tph_cap)
+		return -ENODEV;
+
+	err = pcie_tph_get_st_from_acpi(pdev, cpu_acpi_uid, mem_type,
+					req_type, &tag);
+
+	if (err)
+		return err;
+
+	pci_dbg(pdev, "%s: writing tag %d for msi-x intr %d (cpu: %d)\n",
+		__func__, tag, msix_idx, cpu_acpi_uid);
+
+	err = pcie_tph_write_st(pdev, msix_idx, req_type, tag);
+
+	return err;
+}
+EXPORT_SYMBOL(pcie_tph_set_st);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index b12a592f3d49..1cc99cc528bd 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -21,6 +21,9 @@ bool pcie_tph_intr_vec_supported(struct pci_dev *dev);
 int pcie_tph_get_st_from_acpi(struct pci_dev *dev, unsigned int cpu_acpi_uid,
 			      enum tph_mem_type tag_type, u8 req_enable,
 			      u16 *tag);
+int pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
+		    unsigned int cpu, enum tph_mem_type tag_type,
+		    u8 req_enable);
 #else
 static inline void pcie_tph_disable(struct pci_dev *dev) {}
 static inline void pcie_tph_set_nostmode(struct pci_dev *dev) {}
@@ -30,6 +33,10 @@ static inline int pcie_tph_get_st_from_acpi(struct pci_dev *dev, unsigned int cp
 					    enum tph_mem_type tag_type, u8 req_enable,
 					    u16 *tag)
 { return false; }
+static inline int pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
+				   unsigned int cpu, enum tph_mem_type tag_type,
+				   u8 req_enable)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.45.1


