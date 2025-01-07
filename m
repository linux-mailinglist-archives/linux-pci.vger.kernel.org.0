Return-Path: <linux-pci+bounces-19438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC34A042E9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB8D162321
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC71F3D4B;
	Tue,  7 Jan 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WT69BhgE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE51F4727;
	Tue,  7 Jan 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260895; cv=fail; b=RJLKXN0ueP+MGq8Mx9y353rjWxF5WFlL9Ruk03hQXN8ycwcRoPO7povHcM8HDnicHSVZjAT2QFJRyEcCItLDqbtzbbAFPRRpo4IayYyB7oyl1imCegRNQVMr49Pq53imgGliGv0R6utlCuLo2ewK6YNH7n4wjIW2M2brBjMLavo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260895; c=relaxed/simple;
	bh=9sBw8ZyE63yheQodoRhBc44a+y87dUoh4Rrz0pk0+xI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiQr8noM+yZv+X9bPbiTqS9Zf9sy4lu0r43Vgm8ywaen1sS3wb/d9JwhtQ/2iBIFDbcDNkTzeXODKGehY8o3AaSbWGkhEPfSMbVIhBu1aOWrUqy9c+QgQb//jyU1MC0bVr53YXvsl7LXajU4LOc8owVfmOceheJ3i6gzMZitu6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WT69BhgE; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWF+tpSKZbuzVE+/USQ71t6eYM4thYRBDHE0y86GxAaCQXGYcB9ZZxl3WW6rmMHg5VHSqKBATPfq5G/5Vo34U3Ol8tDMcoFOCCz8+sgQ9mxXzVTJHGB4yONE562Rkwk8Jv6A7Ity9TjpSXy0vGl2E/mzT20hBF6lCqgJ1GJ01ZrBiMlSa3Mn3RFYHCVLUD1ongvsjJTHBMEw8nWoCth7ARWNYPS0duCe0bV0HBzZASZBHRxA7rZBVguzI4ah9OI7lGgc6I1n2hfb9xUoa7TtWASDIikB2Qf5vb1nPJ+4dwsje/2wHF608JC/3278ovlIBQzBZgXM7dUrBTwAoVH2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0/bjzeXlzPiSMpNhZKoKRRP0U5O2PtHnzSZ7ntXSkg=;
 b=cEHOlyPOVTDtFAQ1nkuq6jPJi8yYyrNEsLAP12QqCxKhDVZjAo3ZFgtrYR7JEhiFgfViehfGK/yeT20fdfpC9Au0DKvENk5HpPO0k8pa4sa2Iw4hZcIjsmLOmKglzHKMOVBGzDfRSf4URYDORDhfCVT8goFeord6jcuEi20SLGd9exR9jjzBxyrj6Mhq6Rat5ly8ytGFEFTmgE9h6fAZxXbboqkVDgwtHysVd6FsRItllwS+BH4vyyZp6hyospSuji4ha4n1bEqHtCIAqmBEOnXzzTRzIpFBa6MOoSY2iETmYBOuyeCVv9KQBesZ071RsMlxsbHekw/lZuJqObfaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0/bjzeXlzPiSMpNhZKoKRRP0U5O2PtHnzSZ7ntXSkg=;
 b=WT69BhgEqoTXyoFWWi+ZLdCGc4XqpQefVmQQGKn9/MW6sDBd+pLRU0bFEGM6Clvu4RSsRqQqqnLbJd6BqqdnTjnSQL0pkZbzlVZvfS8TX0gx0+eVNLr4htusgGJCM2Kzruc5311xmqfdTZ3Kwx/tYyNQzceerYEk8+mRLZoG1Sg=
Received: from BY3PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:39b::24)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:41:29 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2c) by BY3PR05CA0049.outlook.office365.com
 (2603:10b6:a03:39b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:28 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:41:27 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port RAS errors
Date: Tue, 7 Jan 2025 08:38:49 -0600
Message-ID: <20250107143852.3692571-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c429ed-7b2f-4ddf-1804-08dd2f295ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZqVQHSGhinHi2mim4hONIURuU7MD6NoYUJSs+aDBPXh9YRr7VdJZb7Zl+EtS?=
 =?us-ascii?Q?5vKjfP9QirNMy7pD0lN0+ngFQuzTMcvfTfuqtHpKeDULTZXLK9dQ7yk0LsMq?=
 =?us-ascii?Q?EkpyfbF23MAkFknCqK/XTwX0L/ZFPtcSGKZ9zbtdiheyfUYvQivMi3CxDQ5g?=
 =?us-ascii?Q?je7WO+ni1wjBWyuJf85/+ArwcAHsjFHZL9WIV2zXu4yWax+zZy+PS/HQXfi3?=
 =?us-ascii?Q?OsMxjBWce4PdRrary13SZ7amOhE13u2N0KNU2CFp1HpL1/q5cMrymUCXD1sV?=
 =?us-ascii?Q?Mk8GpaMooQBkMooJheQ9gCUtRw5d+rorXNnkZneLZShnmpe4HYj0WbkaEdup?=
 =?us-ascii?Q?564rP+ikOv3dCcMUjskEig0FVEemFDIGAyma+0KEDtHugWv/5krHP7sEx+Pt?=
 =?us-ascii?Q?Omr8vH2JURwEJeF+j89JJBLMGc/y2Cc3QulWRG641BVRKjt8SsEWSPNVHIG5?=
 =?us-ascii?Q?EMZw7zRQr7GlF8GETBY+7GzKuHFxtGcyttyyDYUZCXoPMa6ISyCwyseEQt8j?=
 =?us-ascii?Q?PUv6kLej9yI3gp5KSSbDdKrH2iTdiN4thXvdXIPQ7SrPON9vOfyEzuY79EDh?=
 =?us-ascii?Q?sQbresKNpBjzCxF0Kq0R62B8msXZpb3bd7o3Bh1YOhNDfFcD3bez2JwcjaLE?=
 =?us-ascii?Q?EHOL9JV/vmE4pdtiyILCeqDj0wd2kuYm+vs9bnt5ehtP912SygByKEsAMtWk?=
 =?us-ascii?Q?XhtbZf5lAtCIf2jU1t3lI4zZrMEaPYw02RxK2La1aN9V+9boePe5y1DRwrub?=
 =?us-ascii?Q?x3fKrutzSi/STMs/B+7TOWpVUiIlTSTn7+G2d8a2Hf4yBqNIFKOCNdp9TEQh?=
 =?us-ascii?Q?MChSQr8uHJKevVS5gc1qcljfPO4Riv2G6U/Grw01QeLAd21D0X6Snfi8ZkFp?=
 =?us-ascii?Q?0jK866wxpjVd76Cp0F1VZvlE+owsnvQdC+PGWB4V+1SnwKUCSoPetG6SUPxL?=
 =?us-ascii?Q?HjUam8MxgwnCJY+HreTEyczbYhTelzt7nZMiFNbVtozoYihTuHpktYl2/tgv?=
 =?us-ascii?Q?XvcMv29TSuqwgSxa6E5xIvosLBap261yuzL+uMDLi9RlECsRNTfjf4BFtT+p?=
 =?us-ascii?Q?tOEK6SkFCbckKoERtX0OlAl6lRbmUXru/dl57anhm/PYOp/Llpr6vJcH3Iqd?=
 =?us-ascii?Q?FkzKX4/EJ+ezXB1CzNseZD/obrIZcslThGZ5reV9j0t9vgDDvk/jVbeM4QIn?=
 =?us-ascii?Q?hWfWTjFgOIAp0k4qEepRdfQMOjquD1FnvL4R8ERkk48C4oyyStXGnk62z5kM?=
 =?us-ascii?Q?BiZE4ym3focYmWPO4AD40j6paAdqqezD7fUeNtHxYKl8ha/OJODZ1dn/9o+y?=
 =?us-ascii?Q?gYDEmwN2I6BcCKQt1zj9dmK0OcAm3Ao1S9XDL/f2A8prJ+ua0bXA+ICgkbW1?=
 =?us-ascii?Q?gLJZiC1BAbzem43l7KkdghG/uIUu1q75jvfPFc3SK5ydbNnvLjo3YzLNhHM+?=
 =?us-ascii?Q?HHZ4LZPUUZCApfqXdG52M6ONvStbd2n65CW15Pal3nTCYFqkcKWlhABQ1lRW?=
 =?us-ascii?Q?XfDOfSw6b868vHBJ3npw2mpAteVOeLHN66xx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:28.6825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c429ed-7b2f-4ddf-1804-08dd2f295ee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

Introduce correctable and uncorrectable CXL PCIe Port Protocol Error
handlers.

The handlers will be called with a 'struct pci_dev' parameter
indicating the CXL Port device requiring handling. The CXL PCIe Port
device's underlying 'struct device' will match the port device in the
CXL topology.

Use the PCIe Port's device object to find the matching CXL Upstream Switch
Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
matching CXL Port device should contain a cached reference to the RAS
register block. The cached RAS block will be used handling the error.

Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
a reference to the RAS registers as a parameter. These functions will use
the RAS register reference to indicate an error and clear the device's RAS
status.

Future patches will assign the error handlers and add trace logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8275b3dc3589..411834f7efe0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -776,6 +776,69 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+static int match_uport(struct device *dev, const void *data)
+{
+	struct device *uport_dev = (struct device *)data;
+	struct cxl_port *port;
+
+	if (!is_cxl_port(dev))
+		return 0;
+
+	port = to_cxl_port(dev);
+
+	return port->uport_dev == uport_dev;
+}
+
+static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
+{
+	struct cxl_port *port;
+
+	if (!pdev)
+		return NULL;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_dport *dport;
+		void __iomem *ras_base;
+
+		port = find_cxl_port(&pdev->dev, &dport);
+		ras_base = dport ? dport->regs.ras : NULL;
+		if (port)
+			put_device(&port->dev);
+		return ras_base;
+	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct device *port_dev;
+
+		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
+					   match_uport);
+		if (!port_dev)
+			return NULL;
+
+		port = to_cxl_port(port_dev);
+		if (!port)
+			return NULL;
+
+		put_device(port_dev);
+		return port->uport_regs.ras;
+	}
+
+	return NULL;
+}
+
+static void cxl_port_cor_error_detected(struct pci_dev *pdev)
+{
+	void __iomem *ras_base = cxl_pci_port_ras(pdev);
+
+	__cxl_handle_cor_ras(&pdev->dev, ras_base);
+}
+
+static bool cxl_port_error_detected(struct pci_dev *pdev)
+{
+	void __iomem *ras_base = cxl_pci_port_ras(pdev);
+
+	return __cxl_handle_ras(&pdev->dev, ras_base);
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
-- 
2.34.1


