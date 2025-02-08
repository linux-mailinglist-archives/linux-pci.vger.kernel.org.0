Return-Path: <linux-pci+bounces-21004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537FBA2D23E
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5703ADA0D
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B541DA3D;
	Sat,  8 Feb 2025 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydIcAP5i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2014D2A0;
	Sat,  8 Feb 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974731; cv=fail; b=Cq+SyLCnysY5v3wr/QbIHaMCTbiKHN84LqUg6ooTI24UnpvFvDCdsB4A+0B+SpIEsRyYcb+IcShgVvn90dHKeh6KSLQcghqHZBYREjoys2Xy/oWNSXiUeM36lpY7ohAys4gaWDyxQ7Joc0cnZM2nKt2pRGlWPSF5wrXZoju/UuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974731; c=relaxed/simple;
	bh=MfhJO4/r63dMuxqxp8ntx7WN4dl51i+tzmTCWlBhrPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ1XRq1qydFZvHnkQfjHTJ2RpczOfMUIBhQWU8UCFQQinSeATfMG0+sgVxDscZw0UWtpbvFUOHfbmW7rfFFkxmoXonrlS2CZAJ7HKUKPHD/IybjCaqVXoJYUk0bEP02+QQT/eOdMP9YxCgc7RGcGJ64Uf2s0eipZBMakL5K/2Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydIcAP5i; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRX8q8RS0EiDDzP4bkwrPKgW7resugICZV6nl7QKjnsg+MwRaXgFOsCV0MtafytR8y8NzoRw2h18qOg04wL30QU6NGh3+SbK3nqNXMUabb6aKFmUCfVmUAsd7BHjxE/YavoUFnLGCCn37yh3tJyRALQ0IRHCABc6wGBPNvDgPlSNwEvHiWHLxoihbdaFknZIii5I1DuAJEHCtLSPQe+iChRPoy4dExZzQD2e7YbbagokZcOE2RaCDtw1M73cGDigaKbYMKR5GGINjvhAInX+ceTSf5RHK59v9+iVNQiiAv4SZDXGg1MAc5Y8pUTY0QBNliQSWWGCkedBKxfG56KfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYpqtFwAvR8UPCOHcovv7wDmTp+UleHYqrlMPvCYNqk=;
 b=yYbsdlzy1bwCnnXNcWS7Q4pXwCqqUf4MX5oVOoYIkC5zjkM6zyaZyyBGmRsFANMBDVfcmB5h3u4YH5fKU9KT2gK/L4/Nrl1D6bJZV/H27n5mYdWF2tkz5s2A5kJaghORABOsZaeRI48ZEhMVf+5T6+DJQ+V1AAmxi+zB4ymYI1VE9ZmHkeir0Nm0GKjZPOApgLoHSGHlanNAV3yj+Wvl4AvvqiNjcdXhRpzFKOISIUlIJl9TjY3slU2bQPam0Ljkws4yvdtRxnYpKCaSPGapesAoQuv6vf0sU3YHt4UCWoyRG1hVsvcrMXpUKjO25w3G6RiCRRt00f2EzfM1yAw1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYpqtFwAvR8UPCOHcovv7wDmTp+UleHYqrlMPvCYNqk=;
 b=ydIcAP5i9mYzSJi9xGgZ5Mo3AcqvPadfeU0kWlQg4cL60RERNaoo/FAl1opQLlJUYjCnkyG7eTT5tt2dMISlrygejWw+VASR39b4X4yTtwmQni/vF/TkuvBPM8psFUbAZdDiH0fiGZkb2TzKUapodWNT5USOi6c+M1K4DFkktSg=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Sat, 8 Feb
 2025 00:32:05 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::35) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Sat,
 8 Feb 2025 00:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:32:05 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:32:00 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v6 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS errors
Date: Fri, 7 Feb 2025 18:29:36 -0600
Message-ID: <20250208002941.4135321-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: b9188a84-38b6-4400-b19d-08dd47d80372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?asqYjmtCIMSDZxRfJVz7sERmpBFO20ibg0LJc/EazVx9nZtA732tAXDQaXdY?=
 =?us-ascii?Q?iirYeLb08myWXdW3MgCxd83lKJ+U0V/yX5u6MA8lwtb2BCm8o6AN2fGUr2Uw?=
 =?us-ascii?Q?hp7PqtLkB6qTSTotQhBOnX3AGCDgzZmADQJj5A9SxpPMPsSdHpjIE41DP5XV?=
 =?us-ascii?Q?V2QWBCekE87MU+12GDiNhWfr7W+9T+G9OVBXBz16+ClKIuKvJ5igcUW4y4yu?=
 =?us-ascii?Q?O6rHI7GeXPVMsSqpAtaUzNAaAKzCihV+Rej5coIF+XA6Lq3Blf33H6m4jiXz?=
 =?us-ascii?Q?QiPLtS5yyhpMRtnfBBoBlynx3EWMHbHrz+AKRXL6rIQVey63uoX3BTjKmYEt?=
 =?us-ascii?Q?SDqPzgC8rhey66acShdNYWPmq4rmoDTgFEf7+/Bl10+tipJ7Ed0MQHBZ6T2P?=
 =?us-ascii?Q?ZZ2KWXmHGHBou2za7DMvq6sOZ2Ee8P0ZAXruiQ0aK/vQg4PJp4whbfGIVOGN?=
 =?us-ascii?Q?pbeJYD/jA4+QyQJWlN4FWoCTt30OG7BFWvBZ0bEOH+XegLC8kyUXfs6VJdgw?=
 =?us-ascii?Q?7rjB/hORAptx7zbB0yvx1xFkE8+IS8OwQs6UTVuYkRpbZUxPqoGw8jtcHhd6?=
 =?us-ascii?Q?maeMHkNHlgKQyuVeq91epaRIOGQFod5YKYhIODd8tAPEzo+729Khe3h9qw5U?=
 =?us-ascii?Q?H2Pb8Y/f6jUmMVavJ4Cj7oTelz91edMWUor1y1Lfd4hAlAwog7q7agmfskdG?=
 =?us-ascii?Q?tUe5tNSbSgV9x92dJ1epO0DzFpPdzAGwiyZ3SRgGHfMJ5xmPr7oLUbScxccM?=
 =?us-ascii?Q?dYaXD2O1HzH3XnOPgM9mXJokfQgDpAcVUsmexLMwIrv7IhLc2OGKz0CwbI2U?=
 =?us-ascii?Q?8kYVeodpEcatdjDM7h7wzwQXNq2GW2Wx9hW2Jh+Wd/rJOq8cAj9wuasYi4X5?=
 =?us-ascii?Q?Lsk3yRGuBoZ6BqQQrt8nyfOoSTig9jrb4pgd1BFf/C8OpW467QoT9T7VjGTB?=
 =?us-ascii?Q?bwAVJXlomIBp9tcC+cL2TTuiS3qXk2XcbMZL8z1F03m3JXHvKimps1EJeqYI?=
 =?us-ascii?Q?OCqzUeiz7B7yRpwy+kew3tTcaJNIgyUlNP4BxgRe/ZVGmSS/slQKlMbvWKws?=
 =?us-ascii?Q?mxYDsPaUAQmh941dwnMRAvTnMkHHrBh1MXfxNXOtkl3Ab/OmaAsSKjFt1VVW?=
 =?us-ascii?Q?5OwtzDJjUTsl+xzbLAZtboTB+RiLDOoYw2EbVx3pzDvA593u4abi8A+He4ST?=
 =?us-ascii?Q?LgxS1InMWsOGGIwrMCyW/WTyEjhf4pqreRf2kprp0t1RPI23kJ6xJC9KRVwG?=
 =?us-ascii?Q?W1bZHsAf4CYUkMZNrDYfkaoSYdnICEFpakMPv8cFhwRHDTnM27khN7ow9Jib?=
 =?us-ascii?Q?4MHzpWOvRixQJOywWS8M65jsKqtZ5S2Q2v0/Q57tIEhly7kNdbnyVUn9kG/x?=
 =?us-ascii?Q?4OlNzwmsDCHXrRf2bBU8E00p0bRtF/l9dZOKyDR0BfLrIDtNNk4oGQ4fU3CW?=
 =?us-ascii?Q?SWTPIOBuvmaR7tmQinWaM14Lut5YTEFfmiLZLpulEpW06+sHfjBQvFnOZRdJ?=
 =?us-ascii?Q?BgroV0GjtjR19MyvYcQwEKyY+WAbbxkDx/Yb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:32:05.1272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9188a84-38b6-4400-b19d-08dd47d80372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827

Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
handlers.

The handlers will be called with a 'struct pci_dev' parameter
indicating the CXL Port device requiring handling. The CXL PCIe Port
device's underlying 'struct device' will match the port device in the
CXL topology.

Use the PCIe Port's device object to find the matching CXL Upstream Switch
Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
matching CXL Port device should contain a cached reference to the RAS
register block. The cached RAS block will be used in handling the error.

Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
a reference to the RAS registers as a parameter. These functions will use
the RAS register reference to indicate an error and clear the device's RAS
status.

Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
an error is present in the RAS status. Otherwise, return
PCI_ERS_RESULT_NONE.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 81 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a99ba1d6821d..4ebc4a344242 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -701,7 +701,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -710,13 +710,13 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 
 	if (!ras_base) {
 		dev_warn_once(dev, "CXL RAS register block is not mapped");
-		return false;
+		return PCI_ERS_RESULT_NONE;
 	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
 	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
-		return false;
+		return PCI_ERS_RESULT_NONE;
 
 	/* If multiple errors, log header points to first error from ctrl reg */
 	if (hweight32(status) > 1) {
@@ -733,7 +733,7 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
-	return true;
+	return PCI_ERS_RESULT_PANIC;
 }
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
@@ -782,6 +782,79 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
 }
 
+static int match_uport(struct device *dev, const void *data)
+{
+	const struct device *uport_dev = data;
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
+static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev, struct device **dev)
+{
+	void __iomem *ras_base;
+
+	if (!pdev || !*dev) {
+		pr_err("Failed, parameter is NULL");
+		return NULL;
+	}
+
+	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		struct cxl_port *port __free(put_cxl_port);
+		struct cxl_dport *dport = NULL;
+
+		port = find_cxl_port(&pdev->dev, &dport);
+		if (!port) {
+			pci_err(pdev, "Failed to find root/dport in CXL topology\n");
+			return NULL;
+		}
+
+		ras_base = dport ? dport->regs.ras : NULL;
+		*dev = &port->dev;
+	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
+		struct device *port_dev __free(put_device);
+		struct cxl_port *port;
+
+		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
+					   match_uport);
+		if (!port_dev || !is_cxl_port(port_dev)) {
+			pci_err(pdev, "Failed to find uport in CXL topology\n");
+			return NULL;
+		}
+
+		port = to_cxl_port(port_dev);
+		ras_base = port ? port->uport_regs.ras : NULL;
+		*dev = port_dev;
+	} else {
+		pci_err(pdev, "Unsupported device type\n");
+		ras_base = NULL;
+	}
+
+	return ras_base;
+}
+
+static void cxl_port_cor_error_detected(struct pci_dev *pdev)
+{
+	struct device *dev;
+	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
+
+	__cxl_handle_cor_ras(dev, ras_base);
+}
+
+static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
+{
+	struct device *dev;
+	void __iomem *ras_base = cxl_pci_port_ras(pdev, &dev);
+
+	return __cxl_handle_ras(dev, ras_base);
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
 
-- 
2.34.1


