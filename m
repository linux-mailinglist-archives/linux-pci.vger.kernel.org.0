Return-Path: <linux-pci+bounces-7301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A088D8C12EA
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD8D1F225F2
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D839170837;
	Thu,  9 May 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3+NieaQD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C71171085;
	Thu,  9 May 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272134; cv=fail; b=koWYJ0DNpdziiGUWRHV6FXV2QEJV3kBOKKAu/hdYZzO4vMPXYG7H/5sGlRoNZOn1suCLgoe+ODApo20k4Elq/Gn2CsQWU5t+qe5BNuC7WFXGh+JBpKU+7rS3EE56W9hm0YLC+sLUclfIcL3788H/jjp8aVZWZ2eJf5RN5hoyywM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272134; c=relaxed/simple;
	bh=QANFEGymyNpQUiaAGV4sD/tLR77mcAhBix6xshVksnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTrdnRJRM417QKxmGFFaOFz4x6qjGGieNIe+A7dsTi4kHa4gQ/ag0D99LVOG8E4JcCloSxgSG1rYqG6I0VKt/nPx57G6WmBPDlqUJxAVQ+W52d06j8pZbng5zFH84jbUSfA9oRk6Oma9Q8Dvh3bEqT3UmKjEVKVpoxtVKXOJGSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3+NieaQD; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOpgtS5t8sSDDvXJyywWW0SwO1MXzNqcSmp74IGbezBt0Gsk4hKhgjFu0UNsgNAfAoCjbezH3hc8bBq+MNjaauIqrZelddDMLU/2vq6OlXtYXWSxKYmKk4be4zwcalKCP5ZnW/DcQM4CGM3FirF3lr2xpR66H9CGynvfu2ikjMMjZ0cqCVGlaqprnVOhx9Lku9wr21jPFkZaC9tga+JCVXl1RMPGUcj56z6SamVZIcXfJ6/IgahDi9WchZsYv5p68RyblZOy4AzkzITCJlWdRkXf1VLtaXMEjdZEDfqGd3g1antPR5PySLOM4oQAYQ0wlXMavFjdyFieLxj2y44LPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/cVdpr78IkToACdzs0G86EgxND+1os60xbsbZz+cgQ=;
 b=XGK7XrF0PDD/jQpyI7WCnwKIsV6j4W/YpyN9kFLDOxQc4tISCTRoKUI3esYcFBXnp1p8TJQQorS+SK5z3vKfpmU/FtmSAtpid5WP9aM4mmIszWAknS0nuSOUx0C+ANhz3i21/QTKzb0m8gCa/OAbgP8Pmpb9Rc5MqQAiHd02L3D+eNoLJCetdV6WJ7OY9fNvvJfhrKOCDw/Ij25udINF6Sn+sl7XlDZPmDNWatZblbQOvGZqJwZAJ4j35myn52kz68OgVRTa7hlR3zkJRG8jQ9ejegNBbvfAmP50QV6lFf6vVw57h7WCSsUkXpfJsptu/vhubwbrY6FZtHrS/yW6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/cVdpr78IkToACdzs0G86EgxND+1os60xbsbZz+cgQ=;
 b=3+NieaQD4HSUf8vA9S3FVy7XTOZQLek2yZyBGo9/plhWwX9zBOi9LF8GMPCX+bBJ7bdYMPLD6fYK7AG2OsYHpR5b5PI5lbzGMqLYHCo9yoV/YktKbdhSVjOLPzEc8AvpL8z0mVSLiFenqSzyAnA/axbj/jabmY54n7YkslVbBCY=
Received: from CH2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:610:50::24)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 16:28:49 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::9b) by CH2PR16CA0014.outlook.office365.com
 (2603:10b6:610:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 16:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:28:49 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:28:48 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 5/9] PCI/TPH: Introduce API functions to get/set steering tags
Date: Thu, 9 May 2024 11:27:37 -0500
Message-ID: <20240509162741.1937586-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 75be4544-1236-4d91-bda6-08dc70451b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzK0A3mjo6A/xJVY8XPHaS+n+R7QPxAqlJqf8pZw3p8N112LHMv3LoyZ4ydp?=
 =?us-ascii?Q?Z5DGfi4Ftv+dzyfgmgmxyW3QfDQCimzUtlGNgdKbu2VFjx+8u45cDw2rvChv?=
 =?us-ascii?Q?Dz5SmCSQ5bdLSAYAOSXSzGvkM3Q33cLoNh1VKspOMN8Fv1I32FmvxNTAvU4d?=
 =?us-ascii?Q?YRqGShzhEPGIb7sAt+YGfhcYMkB52d0DRj4iLOAu+feNPiV4kmbH/YP1egtf?=
 =?us-ascii?Q?zxnVeRYU2w2EvBACzTAhLS3T8hVZ7iv9tNsz9u4uhQdJ9eH1iRomOBQz983d?=
 =?us-ascii?Q?mD58XVEAwgXuo9cvvlFYciwL8wzH88Xv/e+ROluLALn2tCvpNfugYyEmiFq6?=
 =?us-ascii?Q?WrbyjKASagedXpRX5dVYWPfjC1XvMYIPIC+P20kAfrOyCB3fQLuWt4MlcFWC?=
 =?us-ascii?Q?0eDE+p8AI9ehSS8U2gRS/hvzEyTolcNsL/A/+mAtFRwn5d+4dzQLdqHBfYss?=
 =?us-ascii?Q?Qrpc3Ex1UcfgypOG01ZuR3szva7b3H8sjmCUAYMpaeCtL2b8hqq9fXju+cle?=
 =?us-ascii?Q?wM3kPFyKQPF3P1NOJrtnfOKBVqlte1rZMbqzfnArs40dSaWOTDY9g80Prx7b?=
 =?us-ascii?Q?5ikh7ZfCYGnOlIkMxgLLMh52AE2jV5Elnzfn6NGuoY+hm2jfDJIbepWn6HXK?=
 =?us-ascii?Q?VpDQf0w06+clh1gPp74CUMwcehZBcFWTiniyL7B/fKNgdX+FijQZocDo93G6?=
 =?us-ascii?Q?zJk6IOeKRvlcZMXUAO95YVtqt4AhiKolO9NHxfPBmMZCIxkNG1M2wAL03YJp?=
 =?us-ascii?Q?QKNLco1Y0+aXtHyzxmj9ZV6qZoBwyK8nlIcVHLpS+O/J+cCoq/T2vKqV7ULp?=
 =?us-ascii?Q?v7VN2/z94Q3lg2EZTNtrCtZxkUfKM8/ypzpCMUh13bnms8TODfpVPcNcl1WX?=
 =?us-ascii?Q?avtrhNA77PuF1+lGeHkTjrztVo01GxWKt3PR4NQXN1IHRzBYSoN8U2apIK/b?=
 =?us-ascii?Q?fPsmbe4YrMmt+Fs9AYWLTusoWZSp2sEnn9nGkBm+fVCd983yryYLcSFVPwFa?=
 =?us-ascii?Q?5Ath8J6HjT9bkfhkLgAr6kAd8v4Aq0j/6bzXmc+jiXNlRc4ttt3/EjcbFDvM?=
 =?us-ascii?Q?3EpWibCTrG7og7YgiOv6AmSzT/1A1tEnUZjh/PVOFypwy6j9IuD1NyM/9hUS?=
 =?us-ascii?Q?NRnRxCXXdF7cCzzRvw16rK9/qiX905AuLeh0xDfbM/BD9JXqk0wGtUcgP9cW?=
 =?us-ascii?Q?tzC8xP44bMdNE4G/tzs7iINShNOuz77HGyMDNqjtEnj+mNDwWgUYyoNkhIkB?=
 =?us-ascii?Q?9XcJKTCq20JZnmXuNzxLLR819+MoxOQATmHE6KKL7wIk1ZfgGIoWtXRse+sa?=
 =?us-ascii?Q?W7ZEh9fkMaAAICbvisTTvs0d75ofj3JRy5I+P6vgzWneFTixz3Y8OHd7LRp2?=
 =?us-ascii?Q?hkQV8pE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:28:49.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75be4544-1236-4d91-bda6-08dc70451b74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

This patch introduces two API functions, pcie_tph_get_st() and
pcie_tph_set_st(), for a driver to retrieve or configure device's
steering tags. There are two possible locations for steering tag
table and the code automatically figure out the right location to
set the tags if pcie_tph_set_st() is called. Note the tag value is
always zero currently and will be extended in the follow-up patches.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/pci/pcie/tph.c  | 383 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  19 ++
 2 files changed, 402 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index d5f7309fdf52..50451a0a32ff 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -43,6 +43,336 @@ static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
 	return ret;
 }
 
+static int tph_get_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
+				 u8 shift, u32 *field)
+{
+	u32 reg_val;
+	int ret;
+
+	if (!dev->tph_cap)
+		return -EINVAL;
+
+	ret = pci_read_config_dword(dev, dev->tph_cap + offset, &reg_val);
+	if (ret)
+		return ret;
+
+	*field = (reg_val & mask) >> shift;
+
+	return 0;
+}
+
+static int tph_get_table_size(struct pci_dev *dev, u16 *size_out)
+{
+	int ret;
+	u32 tmp;
+
+	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP,
+				    PCI_TPH_CAP_ST_MASK,
+				    PCI_TPH_CAP_ST_SHIFT, &tmp);
+
+	if (ret)
+		return ret;
+
+	*size_out = (u16)tmp;
+
+	return 0;
+}
+
+/*
+ * For a given device, return a pointer to the MSI table entry at msi_index.
+ */
+static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
+					  __le16 msi_index)
+{
+	void *entry;
+	u16 tbl_sz;
+	int ret;
+
+	ret = tph_get_table_size(dev, &tbl_sz);
+	if (ret || msi_index > tbl_sz)
+		return NULL;
+
+	entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
+
+	return entry;
+}
+
+/*
+ * For a given device, return a pointer to the vector control register at
+ * offset 0xc of MSI table entry at msi_index.
+ */
+static void __iomem *tph_msix_vector_control(struct pci_dev *dev,
+					     __le16 msi_index)
+{
+	void __iomem *vec_ctrl_addr = tph_msix_table_entry(dev, msi_index);
+
+	if (vec_ctrl_addr)
+		vec_ctrl_addr += PCI_MSIX_ENTRY_VECTOR_CTRL;
+
+	return vec_ctrl_addr;
+}
+
+/*
+ * Translate from MSI-X interrupt index to struct msi_desc *
+ */
+static struct msi_desc *tph_msix_index_to_desc(struct pci_dev *dev, int index)
+{
+	struct msi_desc *entry;
+
+	msi_lock_descs(&dev->dev);
+	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
+		if (entry->msi_index == index)
+			return entry;
+	}
+	msi_unlock_descs(&dev->dev);
+
+	return NULL;
+}
+
+static bool tph_int_vec_mode_supported(struct pci_dev *dev)
+{
+	u32 mode = 0;
+	int ret;
+
+	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP,
+				    PCI_TPH_CAP_INT_VEC,
+				    PCI_TPH_CAP_INT_VEC_SHIFT, &mode);
+	if (ret)
+		return false;
+
+	return !!mode;
+}
+
+static int tph_get_table_location(struct pci_dev *dev, u8 *loc_out)
+{
+	u32 loc;
+	int ret;
+
+	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP, PCI_TPH_CAP_LOC_MASK,
+				    PCI_TPH_CAP_LOC_SHIFT, &loc);
+	if (ret)
+		return ret;
+
+	*loc_out = (u8)loc;
+
+	return 0;
+}
+
+static bool msix_nr_in_bounds(struct pci_dev *dev, int msix_nr)
+{
+	u16 tbl_sz;
+
+	if (tph_get_table_size(dev, &tbl_sz))
+		return false;
+
+	return msix_nr <= tbl_sz;
+}
+
+/* Return root port capability - 0 means none */
+static int get_root_port_completer_cap(struct pci_dev *dev)
+{
+	struct pci_dev *rp;
+	int ret;
+	int val;
+
+	rp = pcie_find_root_port(dev);
+	if (!rp) {
+		pr_err("cannot find root port of %s\n", dev_name(&dev->dev));
+		return 0;
+	}
+
+	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &val);
+	if (ret) {
+		pr_err("cannot read device capabilities 2 of %s\n",
+		       dev_name(&dev->dev));
+		return 0;
+	}
+
+	val &= PCI_EXP_DEVCAP2_TPH_COMP;
+
+	return val >> PCI_EXP_DEVCAP2_TPH_COMP_SHIFT;
+}
+
+/*
+ * TPH device needs to be below a rootport with the TPH Completer and
+ * the completer must offer a compatible level of completer support to that
+ * requested by the device driver.
+ */
+static bool completer_support_ok(struct pci_dev *dev, u8 req)
+{
+	int rp_cap;
+
+	rp_cap = get_root_port_completer_cap(dev);
+
+	if (req > rp_cap) {
+		pr_err("root port lacks proper TPH completer capability\n");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * The PCI Specification version 5.0 requires the "No ST Mode" mode
+ * be supported by any compatible device.
+ */
+static bool no_st_mode_supported(struct pci_dev *dev)
+{
+	bool no_st;
+	int ret;
+	u32 tmp;
+
+	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP, PCI_TPH_CAP_NO_ST,
+				    PCI_TPH_CAP_NO_ST_SHIFT, &tmp);
+	if (ret)
+		return false;
+
+	no_st = !!tmp;
+
+	if (!no_st) {
+		pr_err("TPH devices must support no ST mode\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int tph_write_ctrl_reg(struct pci_dev *dev, u32 value)
+{
+	int ret;
+
+	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL, ~0L, 0, value);
+
+	if (ret)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	/* minimizing possible harm by disabling TPH */
+	pcie_tph_disable(dev);
+	return ret;
+}
+
+/* Update the ST Mode Select field of the TPH Control Register */
+static int tph_set_ctrl_reg_mode_sel(struct pci_dev *dev, u8 st_mode)
+{
+	int ret;
+	u32 ctrl_reg;
+
+	ret = tph_get_reg_field_u32(dev, PCI_TPH_CTRL, ~0L, 0, &ctrl_reg);
+	if (ret)
+		return ret;
+
+	/* clear the mode select and enable fields */
+	ctrl_reg &= ~(PCI_TPH_CTRL_MODE_SEL_MASK);
+	ctrl_reg |= ((u32)(st_mode << PCI_TPH_CTRL_MODE_SEL_SHIFT) &
+		     PCI_TPH_CTRL_MODE_SEL_MASK);
+
+	ret = tph_write_ctrl_reg(dev, ctrl_reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Write the steering tag to MSI-X vector control register */
+static void tph_write_tag_to_msix(struct pci_dev *dev, int msix_nr, u16 tag)
+{
+	u32 val;
+	void __iomem *vec_ctrl;
+	struct msi_desc *msi_desc;
+
+	msi_desc = tph_msix_index_to_desc(dev, msix_nr);
+	if (!msi_desc) {
+		pr_err("MSI-X descriptor for #%d not found\n", msix_nr);
+		return;
+	}
+
+	vec_ctrl = tph_msix_vector_control(dev, msi_desc->msi_index);
+
+	val = readl(vec_ctrl);
+	val &= 0xffff;
+	val |= (tag << 16);
+	writel(val, vec_ctrl);
+
+	/* read back to flush the update */
+	val = readl(vec_ctrl);
+	msi_unlock_descs(&dev->dev);
+}
+
+/* Update the TPH Requester Enable field of the TPH Control Register */
+static int tph_set_ctrl_reg_en(struct pci_dev *dev, u8 req_type)
+{
+	int ret;
+	u32 ctrl_reg;
+
+	ret = tph_get_reg_field_u32(dev, PCI_TPH_CTRL, ~0L, 0,
+				    &ctrl_reg);
+	if (ret)
+		return ret;
+
+	/* clear the mode select and enable fields and set new values*/
+	ctrl_reg &= ~(PCI_TPH_CTRL_REQ_EN_MASK);
+	ctrl_reg |= (((u32)req_type << PCI_TPH_CTRL_REQ_EN_SHIFT) &
+			PCI_TPH_CTRL_REQ_EN_MASK);
+
+	ret = tph_write_ctrl_reg(dev, ctrl_reg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static bool pcie_tph_write_st(struct pci_dev *dev, unsigned int msix_nr,
+			      u8 req_type, u16 tag)
+{
+	int offset;
+	u8  loc;
+	int ret;
+
+	/* setting ST isn't needed - not an error, just return true */
+	if (!dev->tph_cap || pci_tph_disabled() || pci_tph_nostmode() ||
+	    !dev->msix_enabled || !tph_int_vec_mode_supported(dev))
+		return true;
+
+	/* setting ST is incorrect in the following cases - return error */
+	if (!no_st_mode_supported(dev) || !msix_nr_in_bounds(dev, msix_nr) ||
+	    !completer_support_ok(dev, req_type))
+		return false;
+
+	/*
+	 * disable TPH before updating the tag to avoid potential instability
+	 * as cautioned about in the "ST Table Programming" of PCI-E spec
+	 */
+	pcie_tph_disable(dev);
+
+	ret = tph_get_table_location(dev, &loc);
+	if (ret)
+		return false;
+
+	switch (loc) {
+	case PCI_TPH_LOC_MSIX:
+		tph_write_tag_to_msix(dev, msix_nr, tag);
+		break;
+	case PCI_TPH_LOC_CAP:
+		offset = dev->tph_cap + PCI_TPH_ST_TABLE
+			  + msix_nr * sizeof(u16);
+		pci_write_config_word(dev, offset, tag);
+		break;
+	default:
+		pr_err("unable to write steering tag for device %s\n",
+		       dev_name(&dev->dev));
+		return false;
+	}
+
+	/* select interrupt vector mode */
+	tph_set_ctrl_reg_mode_sel(dev, PCI_TPH_INT_VEC_MODE);
+	tph_set_ctrl_reg_en(dev, req_type);
+
+	return true;
+}
+
 int tph_set_dev_nostmode(struct pci_dev *dev)
 {
 	int ret;
@@ -77,3 +407,56 @@ void pcie_tph_init(struct pci_dev *dev)
 	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
 }
 
+/**
+ * pcie_tph_get_st() - Retrieve steering tag for a specific CPU
+ * @dev: pci device
+ * @cpu: the acpi cpu_uid.
+ * @mem_type: memory type (vram, nvram)
+ * @req_type: request type (disable, tph, extended tph)
+ * @tag: steering tag return value
+ *
+ * Return:
+ *        true : success
+ *        false: failed
+ */
+bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,
+		    enum tph_mem_type mem_type, u8 req_type,
+		    u16 *tag)
+{
+	*tag = 0;
+
+	return true;
+}
+
+/**
+ * pcie_tph_set_st() - Set steering tag in ST table entry
+ * @dev: pci device
+ * @msix_nr: ordinal number of msix interrupt.
+ * @cpu: the acpi cpu_uid.
+ * @mem_type: memory type (vram, nvram)
+ * @req_type: request type (disable, tph, extended tph)
+ *
+ * Return:
+ *        true : success
+ *        false: failed
+ */
+bool pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
+		     unsigned int cpu, enum tph_mem_type mem_type,
+		     u8 req_type)
+{
+	u16 tag;
+	bool ret = true;
+
+	ret = pcie_tph_get_st(dev, cpu, mem_type, req_type, &tag);
+
+	if (!ret)
+		return false;
+
+	pr_debug("%s: writing tag %d for msi-x intr %d (cpu: %d)\n",
+		 __func__, tag, msix_nr, cpu);
+
+	ret = pcie_tph_write_st(dev, msix_nr, req_type, tag);
+
+	return ret;
+}
+EXPORT_SYMBOL(pcie_tph_set_st);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 95269afc8b7d..42ecd6192e69 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,14 +9,33 @@
 #ifndef LINUX_PCI_TPH_H
 #define LINUX_PCI_TPH_H
 
+enum tph_mem_type {
+	TPH_MEM_TYPE_VM,	/* volatile memory type */
+	TPH_MEM_TYPE_PM		/* persistent memory type */
+};
+
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_disable(struct pci_dev *dev);
 int tph_set_dev_nostmode(struct pci_dev *dev);
+bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,
+		     enum tph_mem_type tag_type, u8 req_enable,
+		     u16 *tag);
+bool pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
+		     unsigned int cpu, enum tph_mem_type tag_type,
+		     u8 req_enable);
 #else
 static inline int pcie_tph_disable(struct pci_dev *dev)
 { return -EOPNOTSUPP; }
 static inline int tph_set_dev_nostmode(struct pci_dev *dev)
 { return -EOPNOTSUPP; }
+static inline bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,
+				   enum tph_mem_type tag_type, u8 req_enable,
+				   u16 *tag)
+{ return false; }
+static inline bool pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
+				   unsigned int cpu, enum tph_mem_type tag_type,
+				   u8 req_enable)
+{ return true; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.44.0


