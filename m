Return-Path: <linux-pci+bounces-21203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E617BA31563
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2871882FF9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E0269CF0;
	Tue, 11 Feb 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hYqCEYxh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD32690F6;
	Tue, 11 Feb 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302032; cv=fail; b=lOqWO7xpYCSXesPwW7IvwS/16IbqYNPr/L7uLcZFJ6koCrGgNVBupSD6fI/FSkxqhYbM5PsfA5LY5pGTHCAGaAY+qCaWaJtkOtWOsjSZfyaiYeLuXL99KWmoYlo+pwYy3uU8boj7MLFhAUQIRxFLNR5Umqco8ud9EeaYl/jccbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302032; c=relaxed/simple;
	bh=anfToLSmOnUnuKlTpMLjZYZoWoP1vYOUMzmXWm66ftk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjWfxbpNAe7LaDYwo+x2SIe6/dnyD/9h56n3GCt5cUYmSpi1AyTj3vI/nlPOWbawD3lxgAIYsjBNZPSpRTYFMLPa3Q8cp/l1r4W+ZbwjBq1dBWAnHa4MeBhmqsvR5WGxMo1BCbJKcb1hnEVxg4S9tXBWi9x65f7snhpp2EaZxqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hYqCEYxh; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJDpIwZ/GKSduOmnerGlDugqfWB5Pfuk+QBrh6IaBiqgezljD4B3MPHelexOqW/Xl/CzGt6bu8Fab5PhyzU4tofD+A9YbMGLcG/WDqm89hMSZyY+73EMYOaJ8tptFBQ1XMG7hdihtcdcUEev1sIjSY+Ih2Pa4oKlrOvQyJtoY9e8Qkvd8fa2XefjtqS9kBjDtwrI4v7k3cQ0JZzb2MYS/U51FwDKu9d9JcWjqWapNfeencTiMcDLyJNs1Wur0DDDYxU3/qf1nFfuaOhS5j7lLzp0p036ibnCEv2Hf4TdlRjOwRUkjL68BcN97n3hDHfhkzZnWOsOlLSiHCQaO88mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug4d0TJnQuazr32MurarXimbzWuYNY4wHy9mu+2L7q4=;
 b=wwq/rIFru0pgwhda/jX8Ffv9G82THZaAbJX5oaHoZa/wu4ylkSy8mrSnhDUOb6kGCF0uEZKYlQa5BeYQDr+sU/p39b1kNFz6Z23rwCfdn+VR404wxyFowXOIHfEbPXDS6WEOYsAYabYzryBzS3aG41nYkUlkLHF409VAmg8eD1u2bzkw4UFwIsEfLSBGdRszdS/Dllni1ktfNg7nxx2YFyq/S3ynD85VpWm+y5B/EATZAaLigjb6A5IupxCgfOu4weY64ZGgSItqX/s1UPQBS0753AfJ5vx5Q1fnrn9h3Ho8iVR/nAaGnDHRhXqDYveDUhkzaDHUF9/PaTplo3PYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug4d0TJnQuazr32MurarXimbzWuYNY4wHy9mu+2L7q4=;
 b=hYqCEYxhNQID3KTDx+z+nSF4q+hU8w12j19qKhX7hNpTbVLpvA1YyydDNMlTDCpQ6vtEtBLMn2M/oEmcHax+9iVd2zxZBabwY2/Bl6k3FfmyTLzOfD8j1BHj2mX5+1PKSm2TmyUiSgMLJy857pBsSeNf2as8/rSVFqexdYVNDyo=
Received: from BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 19:27:05 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::86) by BY5PR03CA0008.outlook.office365.com
 (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Tue,
 11 Feb 2025 19:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:27:04 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:27:03 -0600
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
Subject: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS errors
Date: Tue, 11 Feb 2025 13:24:39 -0600
Message-ID: <20250211192444.2292833-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192444.2292833-1-terry.bowman@amd.com>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 64459de9-e4db-4472-a8a3-08dd4ad2115c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LsexekdQnCOpsX0cNGUA9Vfa883l8US7D6LjegfME7wlIoTDryMjBkj996uM?=
 =?us-ascii?Q?HMazu/rsDFzutmMXT5b3cDdvP0azDYIIhc0FH+ii3wisj/gGLCk5pWE+SXv3?=
 =?us-ascii?Q?6xGjdjfqKhJuL0wLh/SLWdoaKVEXwd5xrgmJl+YU4xk2wBHpkI4uxCtyV3ZP?=
 =?us-ascii?Q?lFL58bUiEZztJLntUJtRr10LBbAI0j+qWoMb2dc4EJ4yn+OAQrQKBgZh4w4P?=
 =?us-ascii?Q?AgKGXiR2aMnqMWhb2Jq8BzDvO9j3zYFm/iEsTbWivVotY3/+w8qFwRIXSof9?=
 =?us-ascii?Q?3/KBRQUxLqdYYdpiydFB9D/2VWy5M0V7U8s1DQzNJLs2yKNbQ8BHdq7ESKTG?=
 =?us-ascii?Q?N6unC4nwJEIoZSixA1mQncHgqFFkCin3JRczM1ud2ozcVART/DsrGNuCNFKz?=
 =?us-ascii?Q?E9qKzLqX98hc9DFBGPCDStx+rdAmctwNHQdgd97yY5QTZ4/zgV1St6Kn9bp1?=
 =?us-ascii?Q?1NikmlaauUgn3AyjQ/VcMHmsSRAqRTN5dB7sx91S1ZaeoOdGHmNekOcNSMrA?=
 =?us-ascii?Q?hxaph4rdPGwONnzgqjBEr8GpgxxFxU6nNr/n8NRq2qfLRfowhrSWMRyduHL8?=
 =?us-ascii?Q?d+DZlJbKUAj4/+9S77GMlNqYSmDASZ8+OJV1oAQ4pBQSwnn1EkN55WDKfxKH?=
 =?us-ascii?Q?dN0/C37Q6thcUl5aYuKKdjR1/9mnkKx65zpyqd7hZTpSWObK4jNJ9Ucn5XEX?=
 =?us-ascii?Q?zvisqE9eBZCuPEUQHDF0VSnsRaJJLv0nVLjX2fWn8Sei94CLt3hBFMKsdmYq?=
 =?us-ascii?Q?gCT7/ukMYQ9sREQwj14E9sfYzW7sn8kZcmtVSmfrQvdxFwEwuKUZN3Yz/XWQ?=
 =?us-ascii?Q?fAT8bCFOgbH3iqwknoy2aOc9WBupuNxxpxYfZFKAXeUp7NZ+eFrPKDbb/4wy?=
 =?us-ascii?Q?e4YX6xNUp2PBn/FtJYQpxriziE2mDXm3sQ0q1tmMTgjWEENe0i8TweLJ4efI?=
 =?us-ascii?Q?dpkTLlCAAVVg9rTU1ph0zMIB2dpKz1sO8AJojol9JvaA21kJMbIJ4bEy43cz?=
 =?us-ascii?Q?j2c2QqXqkah90sisdZIcY2BY7RBPTSQxxrw6T4nPeAOiSaIva6uaXfpxlxNP?=
 =?us-ascii?Q?pPSkSUiryIhKcRcJL9ssW82kLh8Hfcu5q9O2GyvzCiK64+MK//E4WoYhoF6/?=
 =?us-ascii?Q?tn8MZ3Jmt3Da9LRNkh2MuB3r2yP5Rqw//j7HpHw5i9UeB0vuiEjiDHAPwt0Q?=
 =?us-ascii?Q?xT/RfTwYy0dkHWEaYCxqGhqBhsJqhWvOh/v9d5oJhKzt+QAAM9zYe/KqwO9j?=
 =?us-ascii?Q?nzQdz3ldcDc1hBwgafiYlX03R1RKGRe1zkQ9joHWLMBvF7Xd4bua0ZmRVoXT?=
 =?us-ascii?Q?nZ5z7hFMwJzCtcKdk1D/C+EeFeT7hrInk3vkdmLLvyK4nKtVugRxpKTKLsiB?=
 =?us-ascii?Q?OTeCGTZc968lbgs0Tr9uCOQ7ui8FvHWFL/4d7v5zAf0tFDwAWKw84C4FYRVk?=
 =?us-ascii?Q?O1QoIuhVaXFHKH8nR+npEWgVD2L4QlDpdQ/ov7owakqSW1I6gZ5WAbmzqVmG?=
 =?us-ascii?Q?C9cVi3yQJWQmmd7QKjGRw3P+ZJlJ6prEkH6R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:27:04.9632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64459de9-e4db-4472-a8a3-08dd4ad2115c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

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
index af809e7cbe3b..3f13d9dfb610 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -699,7 +699,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -708,13 +708,13 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 
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


