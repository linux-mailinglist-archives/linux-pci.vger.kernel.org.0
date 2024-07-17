Return-Path: <linux-pci+bounces-10465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2DC934373
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16081C21630
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14790186294;
	Wed, 17 Jul 2024 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4invbDNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877C24205;
	Wed, 17 Jul 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249768; cv=fail; b=RSj1tC5SntVD96qak2jJVls7K6+cdQzaVJiY8q8P/7NbD0gBhyv33I4QxXb46mdy5wxDUwT5SijdLT/K5NrlgtXrHN/1l2+KxtCgoS12zP//e8PjygiSr+V4ltkLXb7O9mg9dpLygoRnJRhFym8MLEWLASRnXryyXx4Ps2DCENc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249768; c=relaxed/simple;
	bh=wlpOh7uoFADCFWH3si725EfhXyyMZiD75iFuf+fA+xE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUqUMp64PebhFzyh1VbjWDM2rt33ImJIiQ95o3nGxFYc3sNCQuGzqTDSz4feY/RZxjwvuUYVTjUASiiYNFm5/CDYysLc4FbTAYQorpBVOg1/+K98F2kdhn2eUpcrhsIBlgERfE5rBgTCSkchghiqHEPsb7GjywnEAoHBlwps6yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4invbDNl; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtPH4maRdtctFp2KZdQc34lXILGDsmKDLkfftt4iNktioxa8WMFFsy3Oe4ZuWeeYZYtJ90h2Up29f8AxDRRqGMuPrjdVHgKaMuH2rQsrZjCbHin0RZWBXpeeVJnRaitS1AJ4GI+2/JBy8BPiI9Zv/KcF8w3W0foRVSXFiWE9OKlr0iZlLe39niFNHOlT5Nb3ENM9O7tUIaWLulLhd8uC/Ph2jrGCQhi6vMiyPhyk+dGF3oxOlSge+w4+xmmfD3623ZNQhY5jCLsHOtLVsNBNPu370XwSZJj/mGweAE96ot884cg2s2LpcqbNBmd57Aqbyb3lTDb9XaqgvHRlq1DkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPjXrAL0Flw/jweWnBdRzaMxg2DHUSM96K/MkR8UrKc=;
 b=oOamNhFKuFA+W6mzjiC/ouP9JPRiynD3EE+Xk0RxtkSo/iFkXd9O4j8KaY543L7fkdmouduvNLe1A5uCfW+xmcDIQCeqOZwqlEvB83+DgTcGqMq0mCtjc+vn54Q7wmgy9xK4+qt0rY1SOLQIEFPHb8STnhgFCDJ3zRZGbgSXszpKjThCPNyFFLPinU1ZtPRb9CluaqzTEabDAM7pozZu0O5FZHM/ggmwFPK0dGkdgcHOeJeX3Ax14wkegfcgdJjVWg9FtR9s5sU5rSgnm+2saAuhK+lZtJr+g22NzCrXB4AeV+Ywtkm92cTryyWcdSqbqsiFC26EHDu8tSEKFK8Grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPjXrAL0Flw/jweWnBdRzaMxg2DHUSM96K/MkR8UrKc=;
 b=4invbDNlwYo904WSCCf2kw6U0U8nzppkHlcMefetTG4C9dhKo2YwOHMpHXF9g0A9aKG5lJFWMNQ2AFIPDONPLuICqmBRXXumnbgD7RYv67ZiV1AtsPzfvnfMtuzfQFikpYXOsTTLBuXvwJZFq7yO+1HVuCsMGGZHId4x+bd033c=
Received: from DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9) by
 SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.25; Wed, 17 Jul 2024 20:55:59 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::9c) by DS7P222CA0023.outlook.office365.com
 (2603:10b6:8:2e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:55:58 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:55:57 -0500
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
Subject: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
Date: Wed, 17 Jul 2024 15:55:04 -0500
Message-ID: <20240717205511.2541693-4-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: db3faf63-9371-4892-425d-08dca6a2dc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdE3XjaojvPUmzpZfNfxmcuwhXzwvpfw7ROoEEcsBj4AN7hLIg5+h8tHVZAp?=
 =?us-ascii?Q?dvhg2/cEtzdgKPOZaDWQbqNRxDF57PB53WIwbtri6DN6Xr01WyJ7xevuUD1w?=
 =?us-ascii?Q?betUqnuCJwOBl2SVNnsPx6JPW7WsJucUgNSuICZw+CS9UqT5zwEjGJXVBkjd?=
 =?us-ascii?Q?BKJEShWUST+aqH6n5qRgIjIujYFjX5J3HtUhNLeEmBuKT4w5rxI24J/9YXcF?=
 =?us-ascii?Q?UEdCHzDnDwB0zEhBTUn3luEqYMxPmMiSFc/nOWJxRcVpCpxk0JOywsO7JXuD?=
 =?us-ascii?Q?El8MDVDqfN/C0I4eRWgnC0RoaHOgadR39/l8xrPVw8sIqn1NGTsibJk5P2Jo?=
 =?us-ascii?Q?7ZDbJMW5y3Kp5TfK05JSoXdjvYb+cfvfx+35cwdWY8t8KgkIZIzD9bovhDKM?=
 =?us-ascii?Q?RRTiJgfCl6eMVUMK0QC+skTGYduuKTX+QUEVSlYnHQPyvC96Hq3csItYktHp?=
 =?us-ascii?Q?VWqE+hGqkX0XlEJ8nonJQ6sDeRcSXOyiGNw1+/9cpCoG/p5hfgTz905AQacP?=
 =?us-ascii?Q?w+BgO1LnaK85n/8uGczzkVpE3LA2gBkCEx4XANXlZbr+4zrqB8fkyK/DWItw?=
 =?us-ascii?Q?/ovYNCh9TeiYg3awoObpVwrqm1NkLzrFgkbcWHIvvBh//02icIaIsR27jWb1?=
 =?us-ascii?Q?qnNmgTEj/CxlnBJaon0guL5/KL98uTVLdtkVbgWf5WV+jT/xdzrmx4qUduvB?=
 =?us-ascii?Q?Bllg0GN/vyZyshfv3BAKirBHY+mICE/mTVcz9G2rOvtJQ/D5MgtqHrpB3G6+?=
 =?us-ascii?Q?DrO7TgWNim2fFb5VboZx1KV7fJn3marTM75d/q1mpLHeqSAjJyh5qhwZKC8j?=
 =?us-ascii?Q?1CPTz095mQqCXb/RNC2lh0oFAQZss3jzo2LUTphZkOXc0Qkgsr16fv2GkPf8?=
 =?us-ascii?Q?XqBEyFtu4r89veDMk4Nhqj/6RQ2QZtH+sdnPKl1f+mSHGrKDwVsIhpY6GA5D?=
 =?us-ascii?Q?D6AVxIOr40/TWKj2sORk5XI12t5UTgoJYxCXM2TSRb7AL1y0h339CwIiEN26?=
 =?us-ascii?Q?hlAsnnSyiOPEMlhf3NeKwS4smMD0RHYXLkkZLutGeGE87YJ4pwnOFVKBNHSp?=
 =?us-ascii?Q?izMi1Sa5VNQ+OYxkjxzvxUcWWn0xwApNX0ZOejGshzUuE9RXHid2OaD1itVh?=
 =?us-ascii?Q?i+dt3EgerDqJuemfOnylEsBwiwMZzfM8Bt7lLsEgbG8DZW+hVO1zNegPfB1I?=
 =?us-ascii?Q?YLQXwc3PbdyFIOfgATegbypXayzgzMZgxCT2oNgxu89+sismpv1D4iC1E1mh?=
 =?us-ascii?Q?dRxogzFMKKu1buBg1uFvADXkTa97wai2N32DnR17K2+75NCZ+YdgzjWqzeQ4?=
 =?us-ascii?Q?H9ELcFEAdU4+JLpaEZTjfJ0I/0XlvC+Th9VZUX2dEVXOjHZ751lI+MMwuFiR?=
 =?us-ascii?Q?fM+NMZmiRmpPffSUhLV3gCR8DxEYpXO+dOrOLNTf3OUvC8jQI8mAXryJ9jI/?=
 =?us-ascii?Q?tI5S9OziEC8p9tagnZV639EDAyhPuj8G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:55:58.8170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3faf63-9371-4892-425d-08dca6a2dc39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865

TLP headers with incorrect steering tags (e.g. caused by buggy driver)
can potentially cause issues when the system hardware consumes the tags.
Provide a kernel option, with related helper functions, to completely
prevent TPH from being enabled.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/pci/pci-driver.c                      |  7 +++++-
 drivers/pci/pci.c                             | 12 +++++++++
 drivers/pci/pcie/tph.c                        | 25 +++++++++++++++++++
 include/linux/pci-tph.h                       | 18 +++++++++++++
 include/linux/pci.h                           |  1 +
 6 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pci-tph.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b2057241ea6c..65581ebd9b50 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4655,6 +4655,7 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		notph		[PCIE] Do not use PCIe TPH
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..9722d070c0ca 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -21,6 +21,7 @@
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu.h>
+#include <linux/pci-tph.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -322,8 +323,12 @@ static long local_pci_probe(void *_ddi)
 	pm_runtime_get_sync(dev);
 	pci_dev->driver = pci_drv;
 	rc = pci_drv->probe(pci_dev, ddi->id);
-	if (!rc)
+	if (!rc) {
+		if (pci_tph_disabled())
+			pcie_tph_disable(pci_dev);
+
 		return rc;
+	}
 	if (rc < 0) {
 		pci_dev->driver = NULL;
 		pm_runtime_put_sync(dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 02b1d81b1419..4cbfd5b53be8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -157,6 +157,9 @@ static bool pcie_ari_disabled;
 /* If set, the PCIe ATS capability will not be used. */
 static bool pcie_ats_disabled;
 
+/* If set, the PCIe TPH capability will not be used. */
+static bool pcie_tph_disabled;
+
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
@@ -166,6 +169,12 @@ bool pci_ats_disabled(void)
 }
 EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
+bool pci_tph_disabled(void)
+{
+	return pcie_tph_disabled;
+}
+EXPORT_SYMBOL_GPL(pci_tph_disabled);
+
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
@@ -6869,6 +6878,9 @@ static int __init pci_setup(char *str)
 				pci_no_domains();
 			} else if (!strncmp(str, "noari", 5)) {
 				pcie_ari_disabled = true;
+			} else if (!strcmp(str, "notph")) {
+				pr_info("PCIe: TPH is disabled\n");
+				pcie_tph_disabled = true;
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index e385b871333e..ad58a892792c 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -7,8 +7,33 @@
  *     Wei Huang <wei.huang2@amd.com>
  */
 
+#include <linux/pci.h>
+#include <linux/bitfield.h>
+#include <linux/pci-tph.h>
+
 #include "../pci.h"
 
+/* Update the TPH Requester Enable field of TPH Control Register */
+static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
+{
+	u32 reg_val;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg_val);
+
+	reg_val &= ~PCI_TPH_CTRL_REQ_EN_MASK;
+	reg_val |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg_val);
+}
+
+void pcie_tph_disable(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap)
+		return;
+
+	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
+}
+
 void pcie_tph_init(struct pci_dev *pdev)
 {
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
new file mode 100644
index 000000000000..e0b782bda929
--- /dev/null
+++ b/include/linux/pci-tph.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TPH (TLP Processing Hints)
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+#ifndef LINUX_PCI_TPH_H
+#define LINUX_PCI_TPH_H
+
+#ifdef CONFIG_PCIE_TPH
+void pcie_tph_disable(struct pci_dev *dev);
+#else
+static inline void pcie_tph_disable(struct pci_dev *dev) {}
+#endif
+
+#endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6631ebe80ca9..05fbbd9ad6b4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1840,6 +1840,7 @@ static inline bool pci_aer_available(void) { return false; }
 #endif
 
 bool pci_ats_disabled(void);
+bool pci_tph_disabled(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-- 
2.45.1


