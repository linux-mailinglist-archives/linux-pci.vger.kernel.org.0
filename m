Return-Path: <linux-pci+bounces-28903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CCACCC39
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7EE188CEC6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E61EC006;
	Tue,  3 Jun 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jtC7K3Ge"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E423C8BE;
	Tue,  3 Jun 2025 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971552; cv=fail; b=l12rbJAuLpJm4yVTkdACsfKjyu3tdwIdmsmMt/Gll31L87Ryf++ztyaxWBYtkxeJwucd2jcNGSpuwtLiJySNwh0mvHfUqDQ1SQJuZjUs0jN6iqJ3irdgIWEKHEsxYYgT5kN//bIZBUEoKd8YmWfU1PVNB5LqPiF3txXgB/kV+To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971552; c=relaxed/simple;
	bh=gRUkO5oviJDwNNl9/+IAHfExVxAKXOZ6b6rGmTwm174=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDv1WIuNkTifWZC/XaMJa8x5dYIAW+7yyicYy1ay7w8YRlFcnUkrzGXGu8Ug0JvibbIY+5Shdkl40Q6rBT6vr8jpD1uukXkCCZgtEGAkVXqkrBoZiwheheTh3OZIq3zmtzJ+gUa++wafuRIw9KfsTlOE5A/4ZvxVsChnpHggn04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jtC7K3Ge; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZNDZJZgRCNcvKGl7sRdVruN/uv7J/qTjxNCU8z0B+b4031TyI0aHIPuSB7Hdg9gLkuowkfleRBkZCPn5bgt5qLismumcorrYs7Im1BmAGmHEwgphVziTx7GHNAgo6Bv+6cwnZOo62CvxWucbDUm59mr78qmzz1hs+I1gLbRUSZDRsMf7FOZ+q/z6qfoPj4SUsCGrVSuVPLhBexj3vpPTxylMILvUUn9m4/WSuxVHWbfqDP8cFZsIS5SC1aZMGrLV9xXH1RnMtm2qtqrEEJmn3QSJWe7dEVzeeHUc9t37KitwiP5PSxH/Eu1zDDfySPqVj76nDm2ASFTEbcckMuibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Sp1cLMGjpVBT+T+z3A/NkgYK82ptv1cbgcPyB0pQ/8=;
 b=SgDeT8Dc4P5V2YcpMz7p6jnbpsVNCJRG/R0J2NHRhfgNM/E5FWnHuvOkUu/My3mlti/FeYUPW7Z7qmJAzV6eFLEXFBgCQzNsJEuIjL2TFqUylt7I//7cVFjPv8BODPsMet7DulWRRgZpcNI7d3lYBW2ocvqfeSXweZxoe9SZMh6CETSst230fP4Ki3XNdEAphRw2nT0OFnHTc6KniJmyO1s/Tuwry1RToLfp+dO3DChD+5+N4ZUAxuHVdYRQ3FIsCu9v3cmGitH3hI6MvGNwXDn+b7j2gCfksTuH8M0X5SxOn0b24ECCndxNeTdk1GBuKXU1MCoMsn+tXLxDSFgmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sp1cLMGjpVBT+T+z3A/NkgYK82ptv1cbgcPyB0pQ/8=;
 b=jtC7K3GetCtEOTxeL8dT7TCFcEqvo+P2wlIFKWaGfFjc52kMF2X68eQfpynEQaDUIz7QJLmOzzqYuYNgEmsy23Qe5cb61dzEhJoNH5sDY8tdeXF8QAZkzX8H/TXAUj7Ryozoc1ecW4TR2zjHVujqtbV+03NSKmmOULU+sMUy4pQ=
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Tue, 3 Jun
 2025 17:25:46 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::a4) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Tue,
 3 Jun 2025 17:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 17:25:46 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 12:25:45 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<bp@alien8.de>, <ming.li@zohomail.com>, <shiju.jose@huawei.com>,
	<dan.carpenter@linaro.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<kobayashi.da-06@fujitsu.com>, <terry.bowman@amd.com>, <yanfei.xu@intel.com>,
	<rrichter@amd.com>, <peterz@infradead.org>, <colyli@suse.de>,
	<uaisheng.ye@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v9 16/16] CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
Date: Tue, 3 Jun 2025 12:22:39 -0500
Message-ID: <20250603172239.159260-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603172239.159260-1-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 881aff2a-ced9-4a04-aa76-08dda2c3ad48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ClvlW14cBoAES73kOp3L8RPwqPz//tOqQzvlchh7DSj9EeSCLd36cK6Vw+D?=
 =?us-ascii?Q?Pvmhf/4VVKRQvQuPHAMqxrVDwf03VFiqjLg6c7W+UzH2RtVAa9SdbW9nUgc0?=
 =?us-ascii?Q?q77rf6m99sestHu/wLIBxmZWt2WCCREmjWPE+sK7GsBESCEAIHD/yvq5+d1p?=
 =?us-ascii?Q?ysIVlCglkPHNIIPjBPplgzbxHkWa6mpNJXSyvv7aciADje4oo3smwFEOKvC+?=
 =?us-ascii?Q?5tAmIFgtoLzH+VgZ4o8Xl+W7zM4BBp1s8IxWGZ7/+dF9PyjhhdueEfTqNg4z?=
 =?us-ascii?Q?LZ69TAJYBWNW4PIlkRn5plvG4CffGp5ZtLlCYRiXly73Z+XYe26Vvkd1i3B2?=
 =?us-ascii?Q?qjzGezFq5rC5W59NOHWCuMMTKtDnUye3kxtT7FFvFw94XK0uKNoOZI+VVtPo?=
 =?us-ascii?Q?ea7C0o+TvZ4rzpu55MvKJgeEPJDhjGld++guOZ9LQBUZZ66BX5n+rTdcAtzG?=
 =?us-ascii?Q?V5NnDmy+0+glK74fe+ZZMostNnm70U881MkAblSmDDs712GcXC0tHZ1M73i3?=
 =?us-ascii?Q?Ojh4Us4oPju3UuUs5qmMHkxj0bpQtGZo6GbhPKfJCpCr1nwne+K/WSQiXUSQ?=
 =?us-ascii?Q?P79f7OxsA1hOflHv6f1QJtvEbPzcBYi7EG3AI1NlQZ5iSRVolF08oe++Jv/G?=
 =?us-ascii?Q?+dYHh8iR50rA/KQs673+ajTZfvdLjUpp3DM+z0ZQ4j7PjVh0wp4U0CXqbrHo?=
 =?us-ascii?Q?kzfibZCp756OucMBF+8NP4CiUUlg6XLZyOsZB8imwUM1Ezp/cOiIjr4SFNlY?=
 =?us-ascii?Q?qnyT8eWIRjw6dpXC/9tSr9mEVJXVDkrh4egQPduvhA3vTHigbMwJgV5Gs164?=
 =?us-ascii?Q?aNb33WN7PYvIvtlCjgTTUqhLw6woNmk8xBzr+lgVkzOn02BoAg8VC0JZO+09?=
 =?us-ascii?Q?SPpPMiP18Y26Xlq117gBO4c1zV5WXQ2fLA0/M7iDEdrYjx3UUEsR3MfI2qO8?=
 =?us-ascii?Q?jYIhdX7Vn8YQUJ80fNFSODnrhAzZH71qP75pyJjvl2U2s4tOnt544+nYtb2D?=
 =?us-ascii?Q?ZSqUPzY0Nm3Rgb6XGqIfjLgD+CHUmGfTehvj12CiiXlzmUFl3yE1BkMAAXhu?=
 =?us-ascii?Q?cxE0GsvfOkpM+8u8XfwmsnXKzUtkZ/ylN7UbSEs+9lDrFqK9vryPbDbnGjlZ?=
 =?us-ascii?Q?Lh6Da43e+V82h5osJPH26Ur5WMbO06pY/Z9lMuDZ//ljtg7jlI+dQ7EzOyY+?=
 =?us-ascii?Q?HUP88d66Ftl7GVQ8FPmFh0kPyuiJa7txp2hWh+vp0FZM2u3hYK30Dj3zioM+?=
 =?us-ascii?Q?Nb7quY1NIBvThlezhyuBIygSyxeqXuPN6cL7Y8kwyWyYo0hWKd8QbTUckY1J?=
 =?us-ascii?Q?P/UquwDAgTAMvJThJWm14v1T7EFkVmaOiUAmJvN00Yeo0NZ06tQq7gPB2VBi?=
 =?us-ascii?Q?uQnNK802s19vJCFSncT3TKhv/U2DjK2qPfnUCMPMXB77Mua9cnvjlhJ/UiAc?=
 =?us-ascii?Q?EJ44EhHN/uAFuxD4ePAd88CwzLlh/9Jm7dO/7nceKZsBBIXpL9bXTgq+ObO8?=
 =?us-ascii?Q?Pho/ANfkrd8YXMSvleSBOheCjYVe2hExzqdR6GbnZZ7ZzpXZyIMWe1+1Ew?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:25:46.5567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881aff2a-ced9-4a04-aa76-08dda2c3ad48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

During CXL device cleanup the CXL PCIe Port device interrupts remain
enabled. This potentially allows unnecessary interrupt processing on
behalf of the CXL errors while the device is destroyed.

Disable CXL protocol errors by setting the CXL devices' AER mask register.

Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().

Introduce cxl_mask_prot_interrupts() to call pci_aer_mask_internal_errors().
Add calls to cxl_mask_prot_interrupts() within CXL Port teardown for CXL
Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
Endpoints. Follow the same "bottom-up" approach used during CXL Port
teardown.

Implement cxl_mask_prot_interrupts() in a header file to avoid introducing
Kconfig ifdefs in cxl/core/port.c.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/port.c |  6 ++++++
 drivers/cxl/cxl.h       |  8 ++++++++
 drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
 include/linux/aer.h     |  1 +
 4 files changed, 36 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 07b9bb0f601f..6aaaad002a7f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1433,6 +1433,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
  */
 static void delete_switch_port(struct cxl_port *port)
 {
+	cxl_mask_prot_interrupts(port->uport_dev);
+	cxl_mask_prot_interrupts(port->parent_dport->dport_dev);
+
 	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
 	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
 	devm_release_action(port->dev.parent, unregister_port, port);
@@ -1446,6 +1449,7 @@ static void reap_dports(struct cxl_port *port)
 	device_lock_assert(&port->dev);
 
 	xa_for_each(&port->dports, index, dport) {
+		cxl_mask_prot_interrupts(dport->dport_dev);
 		devm_release_action(&port->dev, cxl_dport_unlink, dport);
 		devm_release_action(&port->dev, cxl_dport_remove, dport);
 		devm_kfree(&port->dev, dport);
@@ -1476,6 +1480,8 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	cxl_mask_prot_interrupts(cxlmd->cxlds->dev);
+
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2c1c00466a25..2753db3d473e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
@@ -771,9 +772,16 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
 void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
+static inline void cxl_mask_prot_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
+
+	pci_aer_mask_internal_errors(pdev);
+}
 #else
 static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
+static inline void cxl_mask_prot_interrupts(struct device *dev) { }
 #endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2d202ad1453a..69230cf87d79 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -979,6 +979,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
 
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Masks internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+				       0, PCI_ERR_UNC_INTN);
+	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
+				       0, PCI_ERR_COR_INTERNAL);
+}
+EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 74600e75705f..41167ad3797a 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -108,5 +108,6 @@ int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


