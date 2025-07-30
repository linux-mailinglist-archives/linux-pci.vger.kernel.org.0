Return-Path: <linux-pci+bounces-33216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 430BDB16890
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E954188AF2A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719DA224249;
	Wed, 30 Jul 2025 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xJH7+eDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66331E1A05;
	Wed, 30 Jul 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912226; cv=fail; b=f18Xm9uNgSB45jm3mUwr/ou3nyMXObA5CyT9SBN1z2HEQLFBH2j8cqQz/YsyQMnj94b5SvcqXrf5BmMsNJM2WCeI7XTavUi8AA4RS32GErmN9UplzxnKr+zEnel6Ooe/+C0hpSCDP8QsDmULXA7Di+5Lp9Cifq/pm4//jhXxRFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912226; c=relaxed/simple;
	bh=mWP4VO0UsH5XVAcgnd1KrOmIbEntR7iwVasgQbowuec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpN0IGNbDabd4GedisLvA4AziVwu3HNmAdzw7BVudzbASrY/tYMRS5QUjy+CszWtlmNaxXeNiVcajKAvRYsVCdW7l4p7LmpffQvN5q0b3RiX72J6aYpETdmASlpxx6qRdk0mdVD6Uz9Xjv6AOHznRa3kf69yWK9oXxWYQesXelQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xJH7+eDo; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP/DlyzZoG3yqFVhoOarWIuphldAxFvgKZF1zrarul8OBwE0LomsC7rvM77bU/pkwD54MslGirI1gtWm8B0UPGXO+0IiW7vetJLUhihd0DWKITr+eXFb0+wU+dI+rbSQk4tHUetE0UieyJmXgMXwmgvQGiNn+6i1kUYx7ADIGAJQUzdUzs7c078OPhyxfLqKp0W5m8IFuKj/hA9UXBi+3IC3kX3OelA3YajlVdcD/4XFZtmyk7luE8dL35WUkwujJg/rMS11hQOhFUyhdUpEtz76bhynXFJ7sZUjqAdvgxp/wR4xBBJiT3wNXm5ynMGgqEcJadc9mqdumEK5CrLeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XBr1fAez3VDNvplE7+dvMOUyys35RFj0pgLLN1j/sQ=;
 b=Bp93ZnI8IH4yG7B4s/BiPiDZ5QsjkbdvPZTfldNIwtHGsNVOydInyvfyVolcPkiWBRFW8IHZ4cpBl4gGtPDKPyGKu90vxt92TxjsvfUNznQLZS7bPJhedrmdmvNyi4lPWdDSTh8CinRpMbDkVEaXd8s/pfi8sP1KEbGlEXyjErdCL+m1MngRKvN8wh/T5235IDUrgZZpscA5R1pDsIYSw2oQjhD39HIG2DPEKgtXFgEiq2whuGLHLPQSCklXOpr60aoAlMWxHnNF4nuY0s+FqpglmCByUIYHgCDJAaSUSLAtNC0wpot+A9tRaVPzeP/f3aALpMP79KL8fjS59K7Xsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XBr1fAez3VDNvplE7+dvMOUyys35RFj0pgLLN1j/sQ=;
 b=xJH7+eDoVFYzbevfw8mddUqHXhd4VrYM/L04/AARAfSk72gFeeFCzkMF3VOdG01cwU4N7paqOidDFTjZCo1PT8bN0CZUDfOrJlASP8MWIl0ONNfP3/jUBByvzqLSpP3lDJx5ChuJfixeka3L4tgYxlM+0SetrL5KsFgrriIRuNQ=
Received: from BN0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:408:142::28)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 21:50:19 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::d7) by BN0PR08CA0026.outlook.office365.com
 (2603:10b6:408:142::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Wed,
 30 Jul 2025 21:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:50:19 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:50:18 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 12/16] PCI: PCIe portdrv: Add cxl_isolation sysfs attributes
Date: Wed, 30 Jul 2025 16:47:14 -0500
Message-ID: <20250730214718.10679-13-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: c8745b11-fedb-4b4d-576b-08ddcfb313d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oe5/FeyGzUupHQt3PEMY/Ey6n1Rp9aN+xeSYYAIBFStmtenr9QKe98VWu1eW?=
 =?us-ascii?Q?IN/IU6lyTQH/TLlwSV+dGWG/72PuoQaWPcSez0GBiZ4vD2l7Nok/PSOh7i/Q?=
 =?us-ascii?Q?CIsxHEQxAwE+s1MTs2ZGNhqCdHyKRm8xmwZwnqddGKIuoxrwlhTt1S0xWZfu?=
 =?us-ascii?Q?DWqoAtDuuTEcqHWolZ6cKmIUXAN/Sie2I2dex4yjKYsNIWnQPoZlzI9SbQSE?=
 =?us-ascii?Q?o17Tn23XRP9/nquf6TTC1BBUhm7EQQ7f9Ho4UkYY8iggUNakQ/0JWI8aZZ57?=
 =?us-ascii?Q?YDGlYwvoRzGRfRX06YaWP68uB94y4oAuRd76d3jQGC0DnAL3QMJMgDY027Hn?=
 =?us-ascii?Q?OPLGbgj124KfRGxO/A38QFDBxtcVs1NBHZxmGKdUm8XG9OjuC0H69/Fym/ky?=
 =?us-ascii?Q?rx+hZD3tt+6aNIILJN/lc7l7TKyc8NvuZvsh0U/obXKd0yY5uo2hX6rPlIgz?=
 =?us-ascii?Q?eRXxKu62gye8N2UgiOaWVnFEX/W1pQ/BE+1uoh5B9IFKS4oAhjjPX3SKIjIZ?=
 =?us-ascii?Q?2gDfzlxKiIGWYZcR3M/kXh1WcjJKP+Y2BJ/fMUXp7KNOg+f0rQiwP0H2pSsY?=
 =?us-ascii?Q?MLrGPWI/9JFCaQmNbSB+QCNt/x3AXNv6G/cax0a7CMiC7JsR2NaLoH0Is5m6?=
 =?us-ascii?Q?oz8EJrNWitGIkda4RTozhlg1Hk/jtqO3xCXOMf4IubCKsjV4zt+8pNmmElP2?=
 =?us-ascii?Q?mwdgU1XrJPxz7eRHbH08ZdVjlQatqjjiTkJx4mPofGaJCFb3w/6gpV2RvSns?=
 =?us-ascii?Q?XOLMv0ng4KQ3x+WSMuKPk6KVR5RpncQwpWD9lPNDAM+7LIdU430Y1yYMhrGe?=
 =?us-ascii?Q?j0u79qOauzZ95FQdVHqKLipJ6d8CwnEuCkkwRvUFpVNpyU2nGYhfLHkABkVs?=
 =?us-ascii?Q?ts14pIZX24BtMBjFQYVI/IWg99PYgY2eTuyM2WUWqsXIZXM3X0IYa3M73dwD?=
 =?us-ascii?Q?ED4jRjmNnTmdXrQ61OTWaplJoKkZSnTsbQL8jQ7O/enlZrWT+hYxWD08YwVs?=
 =?us-ascii?Q?a5/gg2lEUfH0JXaptG/rHgUxIEJtpWfG28ZDNqpzfCl8bdE1H+kn3VkFFMFF?=
 =?us-ascii?Q?SXU7EF5o2tKxl/Kej7PQn3sKRnl3ZwTnuB0kNxGc/Cozxx3nD1PREZexYrUV?=
 =?us-ascii?Q?VHSWSdowwX2Y2+W/R8yZTcVFF7aMF6Lcls6vC2CRb3gwDz3tCSEKCNvZN6za?=
 =?us-ascii?Q?EvvGlGSK+4YTY/L6wCmQj2MnzkPd6hi/moEKPdM8wcO+jAB9hiyNmMoAZQge?=
 =?us-ascii?Q?TLDq6yNYC7F5tjCYBiqTtyxe7FQr8uaOE7j5e3K/UpOBKCWn5v/RRAox4NNK?=
 =?us-ascii?Q?ikhuQ94S4fgNqKHla9NFl5xrE48NGAkSMh61Z3pv9M8IhDu4NRmFmP3qNMpv?=
 =?us-ascii?Q?L/LLSPHFm+xLHGZEnJ3PLfPqPmwA7lkIYSaEymWfVHeDKuIg3bjL3t+4WTu8?=
 =?us-ascii?Q?2ysjq0BbLWI0AwV4LzUZZs2VjKeq36jcpcQdXVWNdKARK9Lo30pb/kfdLQlg?=
 =?us-ascii?Q?MRP+tzHttvow4yjCmO6oC7quDRkLj8g9Kjmz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:50:19.4879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8745b11-fedb-4b4d-576b-08ddcfb313d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

Add sysfs attributes to enable/disable CXL isolation and transaction
timeout. The intended use for these attributes is to disable isolation
and/or timeout as part of device maintenance or hotplug.

The attributes are added under a new "cxl_isolation" group on the PCIe
Root Port device.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c          |  29 ++++++
 drivers/pci/pci-sysfs.c          |   3 +
 drivers/pci/pci.h                |   4 +
 drivers/pci/pcie/cxl_isolation.c | 158 +++++++++++++++++++++++++++++++
 include/cxl/isolation.h          |   8 ++
 5 files changed, 202 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6591e83e719c..b5a306341bb2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1346,6 +1346,7 @@ static int cxl_dport_enable_timeout_isolation(struct device *host,
 	if (!(cap & CXL_ISOLATION_CAP_MEM_TIME_SUPP))
 		cxl_enable_timeout(dport);
 
+	pcie_update_cxl_isolation_group(dport->dport_dev);
 	return 0;
 }
 
@@ -1598,6 +1599,34 @@ struct cxl_port *find_cxl_port(struct device *dport_dev,
 	return port;
 }
 
+/**
+ * cxl_find_pcie_rp - Find CXL port that contains a CXL-capable PCIe Root Port
+ * @dport_dev: CXL-capable PCIe Root Port device
+ * @rp: Pointer to store found dport in
+ *
+ * Returns CXL port with elevated reference count if @dport_dev is found
+ */
+struct cxl_port *cxl_find_pcie_rp(struct pci_dev *dport_dev,
+				  struct cxl_dport **rp)
+{
+	struct cxl_dport *dport;
+	struct cxl_port *parent;
+
+	struct cxl_port *hb __free(put_cxl_port) =
+		find_cxl_port(&dport_dev->dev, &dport);
+	if (!hb || !dport)
+		return NULL;
+
+	parent = parent_port_of(hb);
+	if (!parent || !is_cxl_root(parent))
+		return NULL;
+
+	if (rp)
+		*rp = dport;
+
+	return_ptr(hb);
+}
+
 static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
 					 struct device *dport_dev,
 					 struct cxl_dport **dport)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..86e8d8d918cf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1815,6 +1815,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCI_DOE
 	&pci_doe_sysfs_group,
+#endif
+#ifdef CONFIG_CXL_ISOLATION
+	&cxl_isolation_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c7fc86d93bea..3510a75c880b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -677,6 +677,10 @@ static inline void pci_rcec_exit(struct pci_dev *dev) { }
 static inline void pcie_link_rcec(struct pci_dev *rcec) { }
 #endif
 
+#ifdef CONFIG_CXL_ISOLATION
+extern struct attribute_group cxl_isolation_attr_group;
+#endif
+
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
 void pci_ats_init(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
index 5a56a327b599..9d2ad14810e8 100644
--- a/drivers/pci/pcie/cxl_isolation.c
+++ b/drivers/pci/pcie/cxl_isolation.c
@@ -77,6 +77,164 @@ pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev)
 	return get_service_data(to_pcie_device(dev));
 }
 
+static ssize_t isolation_ctrl_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t n)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port;
+	bool enable;
+	int rc;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	struct cxl_dport **dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return -ENOMEM;
+
+	port = cxl_find_pcie_rp(pdev, dport);
+	if (!port || !(*dport))
+		return -ENODEV;
+
+	if (enable)
+		cxl_enable_isolation(*dport);
+	else
+		rc = cxl_disable_isolation(*dport);
+
+	put_device(&port->dev);
+	return rc ? rc : n;
+}
+
+static ssize_t isolation_ctrl_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port;
+	u32 ctrl;
+
+	struct cxl_dport **dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return -ENOMEM;
+
+	port = cxl_find_pcie_rp(pdev, dport);
+	if (!port || !(*dport))
+		return -ENODEV;
+
+	if (!(*dport)->regs.isolation)
+		return -ENXIO;
+
+	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	put_device(&port->dev);
+
+	return sysfs_emit(buf, "%lu\n",
+			  FIELD_GET(CXL_ISOLATION_CTRL_MEM_ISO_ENABLE, ctrl));
+}
+DEVICE_ATTR_RW(isolation_ctrl);
+
+static ssize_t timeout_ctrl_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t n)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port;
+	bool enable;
+	int rc;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	struct cxl_dport **dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return -ENOMEM;
+
+	port = cxl_find_pcie_rp(pdev, dport);
+	if (!port || !(*dport))
+		return -ENODEV;
+
+	if (enable)
+		cxl_enable_timeout(*dport);
+	else
+		cxl_disable_timeout(*dport);
+
+	put_device(&port->dev);
+	return n;
+}
+
+static ssize_t timeout_ctrl_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port;
+	u32 ctrl;
+
+	struct cxl_dport **dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return -ENOMEM;
+
+	port = cxl_find_pcie_rp(pdev, dport);
+	if (!port || !(*dport))
+		return -ENODEV;
+
+	if (!(*dport)->regs.isolation)
+		return -ENXIO;
+
+	ctrl = readl((*dport)->regs.isolation + CXL_ISOLATION_CTRL_OFFSET);
+	put_device(&port->dev);
+
+	return sysfs_emit(buf, "%lu\n",
+			  FIELD_GET(CXL_ISOLATION_CTRL_MEM_TIME_ENABLE, ctrl));
+}
+DEVICE_ATTR_RW(timeout_ctrl);
+
+static struct attribute *isolation_attrs[] = {
+	&dev_attr_timeout_ctrl.attr,
+	&dev_attr_isolation_ctrl.attr,
+	NULL,
+};
+
+static umode_t cxl_isolation_attrs_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pcie_is_cxl(pdev) || pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+
+	if (pcie_port_find_device(pdev, PCIE_PORT_SERVICE_CXLISO))
+		return a->mode;
+	return 0;
+}
+
+const struct attribute_group cxl_isolation_attr_group = {
+	.name = "cxl_isolation",
+	.attrs = isolation_attrs,
+	.is_visible = cxl_isolation_attrs_visible,
+};
+
+void
+pcie_update_cxl_isolation_group(struct device *dport_dev)
+{
+	struct device *dev;
+
+	if (!dev_is_pci(dport_dev))
+		return;
+
+	dev = pcie_port_find_device(to_pci_dev(dport_dev),
+				    PCIE_PORT_SERVICE_CXLISO);
+	if (!dev)
+		return;
+
+	sysfs_update_group(&dport_dev->kobj, &cxl_isolation_attr_group);
+}
+
 static int cxl_isolation_probe(struct pcie_device *dev)
 {
 	struct cxl_isolation_info *info;
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
index 73282ac262a6..0b6e4f0160a8 100644
--- a/include/cxl/isolation.h
+++ b/include/cxl/isolation.h
@@ -31,21 +31,29 @@ int cxl_disable_isolation(struct cxl_dport *dport);
 void cxl_enable_timeout(struct cxl_dport *dport);
 void cxl_disable_timeout(struct cxl_dport *dport);
 
+struct cxl_port *cxl_find_pcie_rp(struct pci_dev *pdev,
+				  struct cxl_dport **dport);
 #else /* !CONFIG_CXL_BUS */
 static inline void cxl_enable_isolation(struct cxl_dport *dport) {}
 static inline int cxl_disable_isolation(struct cxl_dport *dport)
 { return -ENXIO; }
 static inline void cxl_enable_timeout(struct cxl_dport *dport) {}
 static inline void cxl_disable_timeout(struct cxl_dport *dport) {}
+
+static inline struct cxl_port *cxl_find_pcie_rp(struct pci_dev *pdev,
+						struct cxl_dport **dport);
+{ return NULL; }
 #endif /* !CONFIG_CXL_BUS */
 
 #ifdef CONFIG_CXL_ISOLATION
 struct cxl_isolation_info *
 pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev);
+void pcie_update_cxl_isolation_group(struct device *dport_dev);
 #else /* !CONFIG_CXL_ISOLATION */
 static inline struct cxl_isolation_info *
 pcie_cxl_dport_get_isolation_info(struct pci_dev *dport_dev)
 { return NULL; }
+static inline void pcie_update_cxl_isolation_group(struct device *dport_dev) {}
 #endif /* !CONFIG_CXL_ISOLATION */
 
 #endif
-- 
2.34.1


