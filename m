Return-Path: <linux-pci+bounces-18204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A339EDC25
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9110B1655BC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D1204C01;
	Wed, 11 Dec 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HxZO8dZy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CF20458A;
	Wed, 11 Dec 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960547; cv=fail; b=mgU/NpfgxHWcF1I8dsqWE11GOL1pVw/g+eUIDkr7Oyee9l4cYhx3LwMfg2TQJTkSLo68qijzR16BpE3/w+HQNHiYAUKFX2OcSQwruehK09o6QApV0l9EamxdrTaUgykyU9MQvqq9qxECMGxVy40yH+Un9wFKCR/YPWp9oDqZMyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960547; c=relaxed/simple;
	bh=4cPsKlFt++zvohsC5rQLAX8JOAKT1LMWaZIAryfgzHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ4y3f1+2kmkUPM0ymiOGF4wM/UGDV2HVn0S2/v2vFx3qiM64TyzXXxlf6TLv2IwFaRl0os5f3ZWG7qFapEzWExtINxISRaU5QgttHeoXcduDjBHHuW0TVKH3ZR0GtlwcgRDbVIOGEr/DO383Z8pv6Lfu25kRXCvWIZVAsTTi2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HxZO8dZy; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHyfXiqx9WhULUMg4iLBFiDXrLYJbwZOIHxUo/8MliRuOhmMo/fHh/CAT+kRwWdnLGfTW7kGxKhKe7Q32zWQAFoBwuksZW3/LROwMjJL4DzNGxaouBuTCOXKRxuqFJFanyjxy5qOLcYgJm11mfUW5lgro8PqC3pAMTbOVbQA0Phkdk/DyxteCLzDduFq5Nspk/x9eyKUdolO9bmBJjs5UwzyaguJloJdhpST0mIA1K3KCYQB17Z1EgMofcpeCJTqhE9ddb+Q66s/HyYJAhFiZFDqy/P9QUAhugRAj3bI9rUnaQTYDawrlZ2jkLeEwDK1jtIMH9kZI/rbDcUdX/iNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXRkULOVSlxF3lmBrBh5OMwDmVOHfpfnq+i/bj/YHKo=;
 b=ORKaqykkGYWw+ZcANzO6YI84SVnto31RGwrjS611oOzOlgGbA3tTKRO9Fujw3zbUdlN2jVerqsQNdlzgKaVBLnw2v0UXXNuZrbgZ7+iHmKEdpWAcXoFoT+l21m6qKBeJ0Ga6zxOQ9ZgX2iHI8bpTz+ESQttMhfEpB1tcu1RTWhMvQepP1t/9Ijhob0cEuBUNqTmU8ENjq32rNipnIQJLMZ7OqaHcE+CpfJ5u8wUWwWkylLQPZbADuAgLYbHFpAXzgK2OZtenO4Ge0FHH4El9gsW1elRIsiGNvtwe4AwJu7Z/C9wXB3K+3qoFsKi1SSNhvd8IAoO3G8P5bGTEpUU6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXRkULOVSlxF3lmBrBh5OMwDmVOHfpfnq+i/bj/YHKo=;
 b=HxZO8dZywOKpxzmM55b+LUz4WwGrikmsgdWSSghOsvGsSouJyQzf0fiDWjTnolMAQ2/FttI5H6AlOKF7KPrfb14Q94CKlgKLLs/2d3b/ka/yhmpkuUthLJhLinvh1sZQBCkDsXRDzVLab8BZZqoFXNXTdGaBZmOPvdSQEJm0N9w=
Received: from BLAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:36e::17)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 23:42:21 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::54) by BLAPR05CA0021.outlook.office365.com
 (2603:10b6:208:36e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Wed,
 11 Dec 2024 23:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:42:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:42:20 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 12/15] cxl/pci: Add error handler for CXL PCIe Port RAS errors
Date: Wed, 11 Dec 2024 17:39:59 -0600
Message-ID: <20241211234002.3728674-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef6ac58-e7a6-471c-0a45-08dd1a3d7517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKbiwenWqDwx1vKveEQv8o0uDVJ/t2u3Pmc8rYCF4l1Ezd9JrjAqR3s/35mR?=
 =?us-ascii?Q?NT0vFOULSY+WIfZ9oJOwJgzfcnLyXSSjEUGBk+8V1iEPK/qHGMHlbitda5gK?=
 =?us-ascii?Q?mTXsMbe/bZO2SpfLDPy61YsmPDGOBARi2uQNLOKtfnyEWy5Oysor0oGGiUOe?=
 =?us-ascii?Q?7dQBp44f7a5pKP0qCXzq57BYGhkdItyjXsxb3LLHZM0Qu0sfAS6EyfIimHdc?=
 =?us-ascii?Q?vz7xdqxE23Najhv80NAA2+0coN4MT7ntWVifuFpOfvtXIRVFOFAFSWqqCWoL?=
 =?us-ascii?Q?GTW3euE+jOmaxrON/SOL/Ro1C2KSzcvN0pcLopKzr7I+JGRl8cVSpJIZWmYY?=
 =?us-ascii?Q?uVRqt9ZVb7/r8vOMW0oQT9UKEMkucQtIcmdWKeaOhpVcxD8qAcduZ8g484mK?=
 =?us-ascii?Q?s7+pfzbEioHBdNHitFoclCxp4xwuK1gcZswF+0spYTShxhEaEgUQAGoV6dKa?=
 =?us-ascii?Q?/0EGom2v/6JniUW7nMYx8jmfMXU7cO0uzPtNrOHaJJpyVPHCuL56MFT8Gsp9?=
 =?us-ascii?Q?ado6DJ59F1DvJIZ9qSvrn91HoUuZ1hpClLbgx1Gg9G9gWHBBBlC5nZDwreTT?=
 =?us-ascii?Q?d+nV8titLB5T99IOAB5CwkqdvCWaj4ocDN1LnDDcKPvC7Z6GqhRIsx9WXEeZ?=
 =?us-ascii?Q?t4CN+ShNcd6CcIJHngirbkECgm3Gk1QIATfAq/Mw+y/1seEIIDzTkxjP2Cko?=
 =?us-ascii?Q?hTfdcFmshcyNK4DEskO3RBy3DtqJU2UY14zU42/sCXgs7CWXxK/43qgVCd6q?=
 =?us-ascii?Q?PXAumqnfe8jsVZafiRN83NPyZqg+0FnYJMiOFOEg04dQ0AzfdnjsAP59nTXG?=
 =?us-ascii?Q?6e1tXqHCiQKrlwbV1H/RxzPI/+h9yWvYYNjilRAt7Pax9fDgD9jAjACcLTsZ?=
 =?us-ascii?Q?aA0t4Dc3RbrglZpbTAsM+/YvB4MUMya6gQJLJr9vVMqEf38RMu3siQk/IOA2?=
 =?us-ascii?Q?YAyTDlRPkP8qnGazEA0CaC0/LjRFdhQcvf9O//aJKnNYkt2Hd2qAB4hkRO9Y?=
 =?us-ascii?Q?aVKTTiKiPBKmRncUmivncfsaCpW2iL7ilD2Bk4CZ3C7tAya/7tuZjswDh7gJ?=
 =?us-ascii?Q?h7s1N4J6jShlAqYygPHXUPtHipnre3c+S/YIQzE4rU5awqSbU8zNaMn+nIk+?=
 =?us-ascii?Q?gQ0XPAPMFFb8X8lAEMXZ6YUuhnULc4ZcZZQbU92rGjEhhcBievIz2gR5hfd2?=
 =?us-ascii?Q?cVNfAnTzu82XODDwJyZDEc4BNFdTQYg6EfPWMzTmbVM+uTdOpOTtY6ACX+oT?=
 =?us-ascii?Q?AgkD+40kVWFFHYRFGXttaoICcOdN3509WmlbcbFaNuIuwp3p4uBb7eDC9236?=
 =?us-ascii?Q?3U8fLoJEz0UV9ogGyF38su3nNe48Md/bf5NHNtWM7flca1bYpdwVVLV5+dg8?=
 =?us-ascii?Q?GG7CqWxuTb9Gjiy4pUyqgwTOytwvRHLjzKiv6I7l8oLd09sOgCyD9BdXZQsB?=
 =?us-ascii?Q?hNEURvLAZmm0/lpeufV0B9dba6ANtGfeH83XLqCrUA2SzSXZyJDrhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:42:21.5468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef6ac58-e7a6-471c-0a45-08dd1a3d7517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403

Introduce correctable and uncorrectable CXL PCIe port protocol error
handlers.

The handlers will be called with a 'struct pci_dev' parameter
indicating the CXL Port device requiring handling. The CXL PCIe Port
device's underlying 'struct device' will match the Port device in the
CXL topology.

Use the PCIe Port's device object to find the matching Upstream Switch
Port, Downstream Switch Port, or Root Port in the CXL topology. The
matching device will contain a reference to the RAS register block used to
handle and log the error.

Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() passing
a reference to the RAS registers as a parameter. These functions will use
the register reference to clear the device's RAS status.

Future patches will assign the error handlers and add trace logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 89f8d65d71ce..52afaedf5171 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -772,6 +772,67 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
+	void __iomem *ras_base;
+	struct cxl_port *port;
+
+	if (!pdev)
+		return NULL;
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_dport *dport;
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
+		ras_base = port ? port->uport_regs.ras : NULL;
+		put_device(port_dev);
+		return ras_base;
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


