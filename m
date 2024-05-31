Return-Path: <linux-pci+bounces-8147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2068D6BC9
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EC1C23DD6
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184A78C9C;
	Fri, 31 May 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u3U0tzpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A412F59C;
	Fri, 31 May 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191621; cv=fail; b=XYGrTTBWVU+vMcu3JzVrTJOJLEUTA9N5EZaCmKcUVHLUJamYWYCV+Ejcv2FIU5baxMm/PY3fjMPg058Llcr8C6vW3nzhH8LJojoQssRvcbe60l4XgWzFft7krVRIxAWN6hSHdrL0LkklGlfHKt+lwj7DrAcmNUCrBCqyxub0DJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191621; c=relaxed/simple;
	bh=fN1/SnMOUSpE6+Yk9dJGV+MassN9C624pORQd/UNf0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HriFZil2cSDW+gHE9zR7k+gh+JFgMz0UoGcDD/3frpArYEJ6/eYamuOhNioixMzHEEDk5tDhzPmEhpfnABnXEVlVJbCKJvleGQ0fXyKchrNKGG55Fsj11SxL8opJOqT9uIBKvO1enHdkXXl7V6cOeX9xI2ctQTXsxhyEdcy1FbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u3U0tzpD; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oStHU+trlBhnJoaZOfuq47k1Vk83mOpaP0FcE69eBEgL6mtzSc1YRklVmKlDLkBteKMKPalw23xhiMLn86uzKs2TdAodVI+vFC7eJ5wReFtN6ySwgn4U4nE5QOjQLfo/nipsjakpjeckTcrJSeRsKGDFWrMH4u5M/YLJdeO4MRg5O6YJJs31fSutjDWYuu+U1H1oKiFdnDuJXplt5ywn4yz8yvFlAWZMlFPE2W/L/lvdOY7TaCmcFQBTgWYzwTVPu5hEIhhpbAcTl4sxgbAmABdJH8ubzwCBvQG621fNoe9TrP0ViFuM5Dy1rMDySQFurDhJ8XYZfC2kuzMGpsFNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnTAkJwl0BgHNN/haqCAdMLfzMbgPq6y+j7SX5sJJww=;
 b=f2Jb0iT9owlh2Hx07gvUpQ9vWluPqkHdM5jaEvOgBFa/A0hKuavdSW+3qyBqat9lB8lg9GLiXU/1/MNNBdWFp9POONwtylCQmUFJyZlA8U6v0VVWpplykac/obj+1lKG2itofENU1DRUW490l7rXZXS5i6MPXlRuf4feSOyD7CqcAhb11kvV7cIvvMbayXRFFU3dc/rOFC/c8pZO4R7U31c0X+jTKfqjaFWdEqUmrkaFcmHRr1YMoz1zmF5wfsE0LTt7IqgQ/auHOfvEJ0AvM+5bDO1VRI3HieBDkMORBhhn+GzNoLEkVNjBCvHb/oq0hcwfR3Tq7IF32esgaCUM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnTAkJwl0BgHNN/haqCAdMLfzMbgPq6y+j7SX5sJJww=;
 b=u3U0tzpDNLf6SCkrou4wY9TLIO6odYShzR0eGuK34uHw0B3dc+7wwvtdYGXMgUo1vx9ijiAMyCY4zhvp/21GaPotzWmLPfsf6w1fv/0Z4lEZLZjGsFuNNphaTJwuNB9cHCwMiySFiG1yr9d9xnysAQe/NTv+0qzY7fN/p2kbQ9g=
Received: from BY3PR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:39b::19)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 21:40:14 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::32) by BY3PR05CA0044.outlook.office365.com
 (2603:10b6:a03:39b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.9 via Frontend
 Transport; Fri, 31 May 2024 21:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 21:40:12 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 16:40:08 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>
Subject: [PATCH V2 5/9] PCI/TPH: Introduce API functions to manage steering tags
Date: Fri, 31 May 2024 16:38:37 -0500
Message-ID: <20240531213841.3246055-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531213841.3246055-1-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bb4b88-2e90-4217-4a33-08dc81ba40d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rgs2vUBqQTOLlPGNwK15T/tdmty4mjZtKUlEun/B7K6Z2su+csD6vKegeTQr?=
 =?us-ascii?Q?vvvVcxLZzETd4TuNASvyavgj4Gf5QpAKtnReyaG7GavBH3ig2wQgUJl+nBm1?=
 =?us-ascii?Q?pBwl75B0yj1u1LObpDhC0hXZS7o7Uw02V1IG2/PwbUakilhh43mwlaAWpL8y?=
 =?us-ascii?Q?PgDgXy6BtOXTr6/iTUUbYy4OBYLCTTUPcI0z7qklMkarfXQLD9ncV/UPlk25?=
 =?us-ascii?Q?zV40ElSZmV/ebuLego7llZ/TrxhaGBUcxzZm2BhjiHaKHTdaqKaTsq4hNBSp?=
 =?us-ascii?Q?HsUSxJTmEQSe+ssSQiuqcQJ1rjG29mlr869+VdXI1psiXtM7u86mHp/kls6P?=
 =?us-ascii?Q?PMumffVHW9nWQfe8L+YL3uQ3Ab5Z6f0JVtErtmuIcNdsHxjbOsI5x6mnZbD5?=
 =?us-ascii?Q?Ga+WcBaT2AQn/hbkLFTNKsvAzlsmxA527SINCf8NLAm7M8GzN2vEqzRAvPBL?=
 =?us-ascii?Q?esJtGgvvKMlrMT+zwfeEJCJD5r3FBMr82VYdK5JclnZivBBJ6G3a5cV8SZan?=
 =?us-ascii?Q?A4eD+8RXEW7zfP85H2MWIi70n0EqDubr4dfRXsVUKsZbt8Tw84o7lYGgofyW?=
 =?us-ascii?Q?dfbS3NUjwXNJ/hQlkHDDlp0lVkBWVO3IfmC10ssAtkX6OPos92Ty36OLo/vg?=
 =?us-ascii?Q?QZdj3DUHc3VJ7FNdphpDi84YL3NlSs7FIxe3LBuE216kjalbJW1fmh214pOJ?=
 =?us-ascii?Q?FI98tLCvEO7kOP2Yd1XZm+u+66V1oiVSMMD6h0aOj1ulbb4w4JOpbvveoyXe?=
 =?us-ascii?Q?Nyhfwmp47rRl/+mR/sOnuC4E6G1a26SY9cGmkRFk83mdUKQMLI72BZmlZBM2?=
 =?us-ascii?Q?tavm2QQIvM6rCBhciPPatRYROBSGjQOu7UJSDkU9VKxx49oUn97iv1U6UcqS?=
 =?us-ascii?Q?A9ynwlLIMeFiAIO9ZHtn/WKZdGDb/TpgQ7GxPKkOWSr/nivAz9jWiRwhkw0V?=
 =?us-ascii?Q?Btj3/zqxPUIbuzeTKR0hgEyVTUmjQ+36uLuPe1tu6/kqwg43IEW8LuG1a99a?=
 =?us-ascii?Q?GxQxAHARoPA4aCXOUHAuOq0dL0HLajBwUN2ZWYu/ANLVySQnJiXEReHnGRmo?=
 =?us-ascii?Q?0KFPaTeV1I38INcrou1bsjz7hGIYJ0zhCVKHdEeIVJ4bo+08bxrAJH+S1Uei?=
 =?us-ascii?Q?JILS49Za9mg6Tb8Rpg4iNZ5AsK5P4Hhs5wRQ7Ac5+znV1fGGjqUSHbOMCsAy?=
 =?us-ascii?Q?XETavKPintRmgQXttXPckmo1bnWOX6TdjzKg/7TG5gsD1whl6t10knqvLAWj?=
 =?us-ascii?Q?IP51LzaS5FGwZufT7Y+E8AJarcJjgwbW9Dt6P/ww71qSAic0dR7nKB5HOuNO?=
 =?us-ascii?Q?UEyL/AW9q8MvSTm+b4KdtBv/sRZzMC8a/xmXZCOEhu8pJqC0KYA1NnhlvOru?=
 =?us-ascii?Q?FBlYxFVRtpRygG0LxdjyypjlSvho?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:40:12.9407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bb4b88-2e90-4217-4a33-08dc81ba40d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

This patch introduces three API functions, pcie_tph_intr_vec_supported(),
pcie_tph_get_st() and pcie_tph_set_st(), for a driver to query, retrieve
or configure device's steering tags. There are two possible locations for
steering tag table and the code automatically figure out the right
location to set the tags if pcie_tph_set_st() is called. Note the tag
value is always zero currently and will be extended in the follow-up
patches.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 402 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  22 +++
 2 files changed, 424 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index d5f7309fdf52..320b99c60365 100644
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
+					  u16 msi_index)
+{
+	void __iomem *entry;
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
+					     u16 msi_index)
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
@@ -77,3 +407,75 @@ void pcie_tph_init(struct pci_dev *dev)
 	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
 }
 
+/**
+ * pcie_tph_intr_vec_supported() - Check if interrupt vector mode supported for dev
+ * @dev: pci device
+ *
+ * Return:
+ *        true : intr vector mode supported
+ *        false: intr vector mode not supported
+ */
+bool pcie_tph_intr_vec_supported(struct pci_dev *dev)
+{
+	if (!dev->tph_cap || pci_tph_disabled() || !dev->msix_enabled ||
+	    !tph_int_vec_mode_supported(dev))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(pcie_tph_intr_vec_supported);
+
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
+EXPORT_SYMBOL(pcie_tph_get_st);
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
index 95269afc8b7d..4fbd1e2fd98c 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -9,14 +9,36 @@
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
+bool pcie_tph_intr_vec_supported(struct pci_dev *dev);
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
+static inline bool pcie_tph_intr_vec_supported(struct pci_dev *dev)
+{ return false; }
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


