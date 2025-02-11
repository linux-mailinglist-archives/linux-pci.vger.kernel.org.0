Return-Path: <linux-pci+bounces-21206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA3A3156A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842823A0FDB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4C26E625;
	Tue, 11 Feb 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PjYonuuT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6326E62D;
	Tue, 11 Feb 2025 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302067; cv=fail; b=oovakyBHAsQfkEg1tS2sabNWVcD8Aezxs+mXvr48bF29ld3+dCucHC+RDp0Oc9vvDSXrcFjRzbpG4fROdU2pqROEowCGNnVDbG23OL0honKQPPme4sa4NZrHOeYGqpjvcEtpqlgbhiQGswYVASxwbXKGuGD0Td3KtVJSHImq4YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302067; c=relaxed/simple;
	bh=0ntoOUn+r6Po/Gqrl52ELdIZ5Du3B0P/l7LgzwvZbFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bdo9xwFQSVHs5SXQCvEq2snIqbmPl7kxzXIAZ30jjUourFhQsVYjS7WXUinwC9ShUkXTfF1ZHPSeMGN5zmnA1P+KqhkmOyRlLbSkEHnxGmaZ4zqd7AsI7lICCqBPsj6LpiHlnDpJOtB3LAWZje5AafzHdV3s3wnLMrq3HYGOzxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PjYonuuT; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwgaMbUf1PTjcjMihqOicYUXjrRBz9FVy7TPLUF348NcomiB8wtJO/pBKJx138UFWBSYpLe/lUdBfa7SW6k1RVO5SJN3cggty3tELMXxLvEllqr06HNiXeDYRgUEFlyWM6KnzJeRmYQN5ympQ3I/0LHS9oZe5Rkc6/wE0HTkM7dJ4kdmGBFHFNxiYiMQMrzM4CwSe/IrhtrJpnlHVK6fQYUMr/BVaAL1DfBoYbqbozWVFdZ5vNTkqIKVQeaEqT8EkN8tGrQHIled+z9KNM+gioY0X7v7KeTydaohpVFKpD6cY626qW8lIkal6N1uOqMU38dR6cfldYVZkcgMbs4Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvhTLc+jPoHYjGbJCgrTb2mvlZY993cTERpJ22pq16U=;
 b=e24mOqPquhqI9HzRAA3yWUlQGjMc5fr6mPPavmtDG+lVtX8Kj9d49PAxln/QFmvcVY6N8PMLK+n1zKtAMSKdxtSpF6GQePuoc07fuA2sp32chZcSVbDEqou4fLu+ldk0GCwnDr94mOLdVhPKpCv6k7aoSGktArpKsFn9mmVff7RPyQdtr8Y0fsp383O+WDsfqQdVIX5LNHcdnk8f0qjca2NWOxp6ccyNx84QNnkwVYwGQ2ekb8M15r6Ebkb/0Km3xSJhAHbdurHrYcqgHUrvZIvbvU2ohjLONkEcco5yoikV2AozGNqF8Tjb8baFEUltlyGe2u7BYYOTDoknVNVLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvhTLc+jPoHYjGbJCgrTb2mvlZY993cTERpJ22pq16U=;
 b=PjYonuuTpWQyGgHf9d6SiZyCmrAIhgvisB5nEcrNw/qe6vlQxdbCFmONOds7VsmQXywZPY+8mEYvfgmBAQesnyYUGQDMRH35jP2Grmzi5eLPZGdYW8Xz3oF4IDfFZv8ojHtiFjUUnDh9R+0npbAufNLkHi7f64fcLLD2nD5+8UE=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 19:27:38 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::94) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:27:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:27:36 -0600
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
Subject: [PATCH v7 15/17] cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
Date: Tue, 11 Feb 2025 13:24:42 -0600
Message-ID: <20250211192444.2292833-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 306a9ac8-adf5-4d16-9144-08dd4ad2253c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnx5pdveFxOPMp+6pRihQFyIZzsorQSodFQQuFg6cxhI2X99Y7UwRjJROW7f?=
 =?us-ascii?Q?MYlqyLa2DbU0nSz1QOn2fI1Ylcpgj88nFPNgsAe4V6wSU+B+2xbor9InLjNR?=
 =?us-ascii?Q?shxyIBobUp2p1P913n78ne57I1sE/9qXGGXmVeGW6ukV6V6Re26j1reDbKqU?=
 =?us-ascii?Q?zNOWlSVIPRw3jghH5ALjylNgrVkUaYkG0zW1pWIR2eCGNcVFP9wOblH9ivDg?=
 =?us-ascii?Q?bywo+QYL+wopDdEstoYe5gHy4T18SYKE14kryM1JIvcYvijJ0h7qZ05jXuxB?=
 =?us-ascii?Q?t36n4OOAKZwweLQZsitBoRyUvAQI8JhclqTSBZWD0sQt3IejKSM++i0clKZd?=
 =?us-ascii?Q?MoXff/7dO/tvVrdJId8L02gfjYpRNtgeVcEWh922jbLErPkfF0Hkn1tZRf8h?=
 =?us-ascii?Q?aoEbKbwP+hq84XruXJWATYOKus6K4vrXdXBX9XMVKRtroiGpt08sznoxeHHU?=
 =?us-ascii?Q?WUMhxXlf1I+CXKqHdS4JlVKSRHqKZhG4dCYdjFBNug0len0w/G0qpvUZT+Gm?=
 =?us-ascii?Q?JHnvbthV85/zEE6cxfuR3pqVlZ4Adk31mXZHa36jyLSsbXBOjwB4EikaDiOR?=
 =?us-ascii?Q?A5ucFTNofWIvfeClgyUpnrbR3YVg8W1x9E9Qv0plwqCuvH1vzhSnUUcsHEEk?=
 =?us-ascii?Q?z6y7gl/tFy+uFN4KdkqfiPxhnWOJv09C4oNOHjIfLQdkWQPsK5tzh/YVZUab?=
 =?us-ascii?Q?WpN2zA8TfmCA36fXX9tY9dqP+A2ZtEWcS0MoleZs81lmkY66skbPX6GyXIPn?=
 =?us-ascii?Q?Eh8qbGVUxpYMip7WxZtR6J6AxUOYqzg8/HbnDxDjCeLswbxlP+QLvA6lgaWa?=
 =?us-ascii?Q?XJUiZZNgiFZMxG4gMrWTwBRxd/G2vfXE1D5zIq+P1MWphuYzUHlg2xwUgIZP?=
 =?us-ascii?Q?UMbr7FLZV5jdqLZ2xDFmR0Yl2IRSwzDF7GVOYrf/pnE5BWZZQSvCijXpmtJ+?=
 =?us-ascii?Q?wiORxiHrd9+TBeWXdfaTK98zqqQwZnquclpN+F11+kHqGbTUBBaryT0puI40?=
 =?us-ascii?Q?djnaxcFMtBbfkwoISNSG+Pl7dp50hdL5+EcBRM8psWyAfKCU7DwtVOcmRXpi?=
 =?us-ascii?Q?uccdlcc2OaNrOLEARBQ2tN4d09dxTm0OcA8RloQXNWCXhVUOIusHI0sIRZW1?=
 =?us-ascii?Q?dJ8ocBX4OyISo824hJ0z9qXhKRMdOCtvJgVVYaTSNhHuTWuudKk4yzhQMw6Z?=
 =?us-ascii?Q?IUji040scLMZe/sQeJZGRWf/nQ3fBz3kljtl+9iaLUF69uU3WA5ltXuoT0ch?=
 =?us-ascii?Q?E0uNK1/sLWMMztYWjfPoOEJBLskZC1cCMe0Gw7vcuGVkBeGryjBynyFUJ+Xz?=
 =?us-ascii?Q?2dTh3/kwMk/dUcUJnnkjA38I2GLPTD8VPRt15VmkQ4pBQW/I98rW4jvxezbV?=
 =?us-ascii?Q?OsYmhD7d8bQFvgNB+NaaecZdZQxAIb9zGj6Oh9Ayv00qJ5go+m6xbpMjJBc7?=
 =?us-ascii?Q?8G5Fsi0aibGb48wiPor81DfR8clkNWmMgr4A+qNzHBKzz1xHIkCWeZOUuXmF?=
 =?us-ascii?Q?/fWUzWiienN+BgqQUc6L/I+JO1pWjXxZSc0o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:27:38.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 306a9ac8-adf5-4d16-9144-08dd4ad2253c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
The handlers can't be set in the pci_driver static definition because the
CXL PCIe Port devices are bound to the portdrv driver which is not CXL
driver aware.

Add cxl_assign_port_error_handlers() in the cxl_core module. This
function will assign the default handlers for a CXL PCIe Port device.

When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
pci_driver::cxl_err_handlers must be set to NULL indicating they should no
longer be used.

Create cxl_clear_port_error_handlers() and register it to be called
when the CXL Port device (cxl_port or cxl_dport) is destroyed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 59 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f154dcf6dfda..03ae21a944e0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -860,8 +860,39 @@ static pci_ers_result_t cxl_port_error_detected(struct pci_dev *pdev)
 	return __cxl_handle_ras(dev, &pdev->dev, ras_base);
 }
 
+static const struct cxl_error_handlers cxl_port_error_handlers = {
+	.error_detected	= cxl_port_error_detected,
+	.cor_error_detected = cxl_port_cor_error_detected,
+};
+
+static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
+{
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = &cxl_port_error_handlers;
+	put_device(&pdev->dev);
+}
+
+static void cxl_clear_port_error_handlers(void *data)
+{
+	struct pci_dev *pdev = data;
+	struct pci_driver *pdrv;
+
+	if (!pdev || !pdev->driver || !get_device(&pdev->dev))
+		return;
+
+	pdrv = pdev->driver;
+	pdrv->cxl_err_handler = NULL;
+	put_device(&pdev->dev);
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
 
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	mutex_lock(&ras_init_mutex);
@@ -872,9 +903,15 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
 
 	port->reg_map.host = &port->dev;
 	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_err(&port->dev, "Failed to map RAS capability\n");
+		mutex_unlock(&ras_init_mutex);
+		return;
+	}
 	mutex_unlock(&ras_init_mutex);
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
 
@@ -886,6 +923,8 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
+	struct cxl_port *port;
 
 	dport->reg_map.host = dport_dev;
 	if (dport->rch && host_bridge->native_aer) {
@@ -901,9 +940,25 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
 	}
 
 	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_err(dport_dev, "Failed to map RAS capability\n");
+		mutex_unlock(&ras_init_mutex);
+		return;
+	}
 	mutex_unlock(&ras_init_mutex);
+
+	if (dport->rch)
+		return;
+
+	port = find_cxl_port(dport_dev, NULL);
+	if (!port) {
+		dev_err(dport_dev, "Failed to find upstream port\n");
+		return;
+	}
+
+	cxl_assign_port_error_handlers(pdev);
+	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
+	put_device(&port->dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
-- 
2.34.1


