Return-Path: <linux-pci+bounces-33211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F75B16887
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D1E16A416
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94812222D8;
	Wed, 30 Jul 2025 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="08lvMuTM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF713D246;
	Wed, 30 Jul 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912164; cv=fail; b=qcP6lmycqHDNPA4dLaXhoItYjjuo8lrQBEnVAhjnN1jNPSxoJfpMRi9iP3pWfZfZf6FAEXlDUpx9JVZVSJBTAKoqXXMmzNfQW3z1PtWtr/iz7wNLeNVCZqH+11EA3at9Afi1VfljIpLah8yzdZRNsj1jKJ6GzIzkrknwThph7Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912164; c=relaxed/simple;
	bh=uMVQ69iLrEAjiWj95b63CYwHT7RaK4bUkCdnyBLaofY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjBrKyPBxnzHWrClwTFI0a3o+8rRQpy9Yhaqnpm/LFT15p3ntoFOX+ijd57H5noQ9dCEAOZbwOfj9bdibMhYE0nnRNcrtWuFJ2/9XsV8ozkiL0JF/5h7W6duHswGZGvyITh24xmA00Lks22Guvb7QEUTh2KHBhpGnMmYG0Bc9yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=08lvMuTM; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIawKT2pCJGZ5J40LtQdxksdbymNGBMg6CyomGIalqPJunK3khnRFWLDfareSLsDVg0bKeo1e8TZZ9UvrP5RvviPUMY41g/axU3Cv6uSt84vKpLQ7X1DOZed21M1g3H3smijQ9ND10za6pzAlcGTzvcUFwywePXhYH6GsxoAszTIzHFfylmVWMpgIui38DDKYsUbjRU35upyY2g27lp4I977w1154cWpoFQPIZ5zhGioklihE9lbrLrWxt+9GJdOIAGqACm7Bykyu4glEixXSQPDr4rivj/FEBFBoriP04clvvEWVZXuK5E3Y+Dzugx1/tffeptHucJidovrQGr8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFQIf0+RMinruZ8NCmAJg6DW4GEDcJwovcKGDqayu7I=;
 b=Jj+jiCVWLZm+Cy3qVzmpjWYt4kVNq20LHor1osBZ4q8afayYoQ9+rWwbAscjdvP3EfdQF6twJ3DIKURvPIGDFnc/O6gMemGWe+LPSe8Qpvbp9i4gHBpjDP/u5NSQw3OqAXMQzkJT+Dt+1oAbcUmI01Hen/1drUbIv384DPt1xpUtHE7Xdb9k3sjNuzhL8we2o0E4cxBSdYn/dhadssBjAmWoSLwcu8lUFUZRT1lrCzWh1KqTDOB85w1hFGHMKvj5xeJ5C+RMa76yhJDZQjX8zIM5Cfno8Wd7tb2qTlnvIZHpua3AV8lhhGUh+m8vbFSG3bvbURqlbSzQ09H99eB1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFQIf0+RMinruZ8NCmAJg6DW4GEDcJwovcKGDqayu7I=;
 b=08lvMuTMHFo1+eb+AXUllZMp2ntrlqCFMUq+bpczqu2BWDs06Mf2XI9lL1SL9euRc6ryl5EZxo/Vfznx8awQeUYGx18xsSmBFv7zyO7k1YmXtU9G0u796oU48dGJsXvoaDC/hMkTPfcmR7NlMrjtghnfUFN/Bv9yxvm+R3AEDUE=
Received: from BL1PR13CA0420.namprd13.prod.outlook.com (2603:10b6:208:2c2::35)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 21:49:15 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::f) by BL1PR13CA0420.outlook.office365.com
 (2603:10b6:208:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Wed,
 30 Jul 2025 21:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:49:13 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:49:12 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 07/16] cxl/core: Set up isolation interrupts
Date: Wed, 30 Jul 2025 16:47:09 -0500
Message-ID: <20250730214718.10679-8-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: b68d38d6-76fc-4fe2-acea-08ddcfb2eca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yaHW/gODRM2TqsNYESCWCqx8JIeGzTCtV2o5c8Q1AKqt7sUWf2/tL+T6iubE?=
 =?us-ascii?Q?Gyh60Y+0D1Z/mxRQufV81Ay3BfD26VtM7Gx0hC5oGB69Z7sMBToC4rjKEwT3?=
 =?us-ascii?Q?TNSoP0wpW9/myRmGfRTL/gXI2EjPvujna6eqdVZFwDybOufUalQazdpNSzmR?=
 =?us-ascii?Q?J4atad7rcIu+04+N8AXsnfLpRL9wk+5wVr8q2r1iAFr4fT/tUCLBgMAxysGd?=
 =?us-ascii?Q?llqAUrm/8005gn94a7T8vw99LFCgtY69/iry+eKjCHtkyulNw9MnhBFTHod0?=
 =?us-ascii?Q?leRQFAeZY+Bncn1hQ3tfpzZ/4NrB0jcyac0zXKSEMThP+/2yECIuiorAXcJf?=
 =?us-ascii?Q?TziBHuu0s5v/j8gNT7BqBkY48ptR0eD8ROpCp5OrdPS2vLYn2Lo4aPsKIe8i?=
 =?us-ascii?Q?hC1m+S1t4crxHaGO4cg5h7muMc55kK3aPWurxybpBXEkRhhu0nO03lo4r9Us?=
 =?us-ascii?Q?qgxFPkM6J3DEPE+7wm+OSB+fgSkkxv7mzHyUod3KA71MtB6CGie1pN+ZvsV8?=
 =?us-ascii?Q?ZmjXXm80ryEK2ymD1MNhk3O6PcK7VdBKDJMyrpPTEZm3I9VwcpEk6swRdm11?=
 =?us-ascii?Q?k8uwujvBY4SWqKsBZZu5Hj+ThZvtp5mPMbdZkNr8sM/5kdC5+sXt7AQ+0oqf?=
 =?us-ascii?Q?jZ/F8IdND2quiI5C2gSdY85e/lBKT4pJbVueQK7m1UmDwUBwo98ARVNPkFzj?=
 =?us-ascii?Q?fS9W+trQwOr9Xt4a8mFTZz9O8KzB9u3wrF4j6KbZTo3WSVWHJzB2eaOT38hC?=
 =?us-ascii?Q?SzXsD2711bsjxwL9/GQ1CltUkmPVSXzJUBZrlFEz5tXy2gewMVWiGTkuJtuJ?=
 =?us-ascii?Q?mVHfnkl29DqrqjF1/yCha7SjuTR7TlSUttoA9nJ0mExZX4ViLgSNw5LCwpiQ?=
 =?us-ascii?Q?jQ7m/letu/pOkqHUZ+DavnVH3SquX9S/qCzHaqP7dhA9ovQwoH5LVBXrq6KJ?=
 =?us-ascii?Q?8vkXA5HzovS0w0h+XFqUj83lge403kM4lp/+mH2HNNqoiWZiAO463cwLjd9w?=
 =?us-ascii?Q?H23ZZSmY4RrXb0kNfAGJJ0trRbUzCdgcQqjXHZexgEfHyT0hXEyQJvlUIvub?=
 =?us-ascii?Q?nQXzM+3G2aq6PYDCxrPVrx+SXHPGfMIxUaTzQApJQ8UcYc7N6227mkRWuNih?=
 =?us-ascii?Q?/7m1JUIDvv/nF+4UMjgafYJD37Dd21Dhv420kSMAivVPIZe4cTVLgLuRsLEf?=
 =?us-ascii?Q?nztx3DZdZjNZrgM01DJAJWCksXZNtkx/OM3cz8Y+RLoqlboj4hombKKmhHyK?=
 =?us-ascii?Q?CAUgrsyU0ijaS2h9D3/Rhhc0pGs2zhe2iw0v0B8bw8bhjtT99amftAAa+OLO?=
 =?us-ascii?Q?bF+VF2hl2dgICLsojgCuZpIRF0zljtJ2Iaq5/lHiV7Z/Vv5El7VVame8zmXc?=
 =?us-ascii?Q?VaWjSuEzgVXclzFpz/cRsiycGBs2+4RfqwAVUiakV/LKwZqvDH9PdyIuitX5?=
 =?us-ascii?Q?a47dYYtSbzOqxysoVn7D1xyJ/+EmsD/Trzo9qkRXEQi10rE+bCtZ5+Je5xxI?=
 =?us-ascii?Q?GXPmPWHcnjrpfEGjbJVxRl2mrvT6WkAolOD0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:49:13.7716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68d38d6-76fc-4fe2-acea-08ddcfb2eca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791

Register a CXL isolation interrupt handler as part of cxl_dport set up.
Only CXL-capable PCIe Root Ports have CXL.mem isolation interrupt support.
The interrupts are left masked and will be unmasked in a later commit.

A CXL-capable PCIe Root Port that has CXL.mem isolation support and no
interrupt support will have any isolation support enabled. If
isolation were enabled without interrupts CXL.mem transactions could
return poisoned data. This could cause data/system corruption if left
unhandled, so the capability is left disabled in this case.

CXL endpoint drivers can add an isolation handler for a device through
the isolation_handler member of struct cxl_dev_state. If this handler
is not present, the system will panic. If the handler opts to not panic
(i.e. returns "CXL_ERR_NONE"), the endpoint driver is charged with
maintaining system reliability (cleaning up CXL memory, disabling device
state, etc.).

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 113 ++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h       |   1 +
 drivers/cxl/cxlmem.h    |   4 ++
 include/cxl/isolation.h |  10 ++++
 4 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 71e954ebc5aa..a36440e85647 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1174,15 +1174,117 @@ static void cxl_dport_unlink(void *data)
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+struct isolation_intr_data {
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+};
+
+static irqreturn_t cxl_isolation_thread(int irq, void *_data)
+{
+	struct isolation_intr_data *data = _data;
+	struct cxl_dport *dport = data->dport;
+	struct cxl_port *port = data->port;
+	enum cxl_err_results res, acc;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_dport *iter;
+	unsigned long index;
+	struct cxl_ep *ep;
+	bool lnk_down;
+	u32 status;
+
+	if (!dport || !port)
+		return IRQ_NONE;
+
+	guard(device)(&port->dev);
+	if (!dport->regs.isolation)
+		goto panic;
+
+	status = readl(dport->regs.isolation + CXL_ISOLATION_STATUS_OFFSET);
+	lnk_down = FIELD_GET(CXL_ISOLATION_STAT_LNK_DOWN, status);
+
+	acc = CXL_ERR_NONE;
+	xa_for_each(&port->endpoints, index, ep) {
+		iter = ep->dport;
+		while (iter && (&iter->port->dev != &port->dev))
+			iter = iter->port->parent_dport;
+
+		res = CXL_ERR_PANIC;
+		if (iter->dport_dev == dport->dport_dev) {
+			cxlmd = to_cxl_memdev(ep->ep);
+			cxlds = cxlmd->cxlds;
+
+			if (cxlds && cxlds->isolation_handler)
+				res = cxlds->isolation_handler(cxlds, lnk_down);
+		}
+
+		acc = max(res, acc);
+	}
+
+	if (acc == CXL_ERR_NONE)
+		return IRQ_HANDLED;
+
+panic:
+	panic("%s: downstream devices could not recover from CXL.mem link down\n",
+	      dev_name(dport->dport_dev));
+	return IRQ_NONE;
+}
+
+static void cxl_dport_free_interrupts(void *data)
+{
+	struct cxl_isolation_info *info;
+	struct cxl_dport *dport = data;
+	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
+
+	info = pcie_cxl_dport_get_isolation_info(pdev);
+	if (!info)
+		return;
+
+	devm_free_irq(info->dev, info->irq, dport);
+}
+
+static int cxl_dport_setup_interrupts(struct device *host,
+				      struct cxl_dport *dport)
+{
+	struct isolation_intr_data *data;
+	struct cxl_isolation_info *info;
+	u32 cap;
+	int rc;
+
+	cap = readl(dport->regs.isolation + CXL_ISOLATION_CAPABILITY_OFFSET);
+	if (!(cap & CXL_ISOLATION_CAP_INTR_SUPP))
+		return -ENXIO;
+
+	info = pcie_cxl_dport_get_isolation_info(to_pci_dev(dport->dport_dev));
+	if (!info)
+		return -ENXIO;
+
+	data = devm_kmalloc(host, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->port = dport->port;
+	data->dport = dport;
+
+	rc = devm_request_threaded_irq(info->dev, info->irq, NULL,
+				       cxl_isolation_thread,
+				       IRQF_SHARED | IRQF_ONESHOT,
+				       "cxl_isolation", data);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, cxl_dport_free_interrupts, dport);
+}
+
 /**
  * cxl_dport_enable_isolation - Enable CXL Isolation for a CXL dport. This is
  * an optional capability only supported by PCIe Root Ports.
- *
+ * @host: Host device for @dport
  * @dport: CXL-capable PCIe Root Port
  *
  * Returns 0 if capability unsupported, or when enabled.
  */
-static int cxl_dport_enable_isolation(struct cxl_dport *dport)
+static int cxl_dport_enable_isolation(struct device *host,
+				      struct cxl_dport *dport)
 {
 	u32 cap;
 	int rc;
@@ -1199,6 +1301,10 @@ static int cxl_dport_enable_isolation(struct cxl_dport *dport)
 	if (!(cap & CXL_ISOLATION_CAP_MEM_ISO_SUPP))
 		return 0;
 
+	rc = cxl_dport_setup_interrupts(host, dport);
+	if (rc)
+		return rc == -ENXIO ? 0 : rc;
+
 	cxl_enable_isolation(dport);
 	return 0;
 }
@@ -1266,7 +1372,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 			&component_reg_phys);
 
 	if (IS_ENABLED(CONFIG_CXL_ISOLATION)) {
-		rc = cxl_dport_enable_isolation(dport);
+		rc = cxl_dport_enable_isolation(host, dport);
 		if (rc)
 			return ERR_PTR(rc);
 	}
@@ -1543,6 +1649,7 @@ static void reap_dport(struct cxl_port *port, struct cxl_dport *dport)
 {
 	devm_release_action(&port->dev, cxl_dport_unlink, dport);
 	devm_release_action(&port->dev, cxl_dport_remove, dport);
+	devm_release_action(&port->dev, cxl_dport_free_interrupts, dport);
 	devm_kfree(&port->dev, dport);
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 999ffa05b68f..9e3ca754251d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -143,6 +143,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXL_ISOLATION_CTRL_MEM_ISO_ENABLE BIT(16)
 #define CXL_ISOLATION_STATUS_OFFSET 0xC
 #define   CXL_ISOLATION_STAT_MEM_ISO BIT(8)
+#define   CXL_ISOLATION_STAT_LNK_DOWN BIT(9)
 #define   CXL_ISOLATION_STAT_RP_BUSY BIT(14)
 #define CXL_ISOLATION_CAPABILITY_LENGTH 0x10
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 551b0ba2caa1..fbe64c580785 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -9,6 +9,7 @@
 #include <linux/node.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
+#include <cxl/isolation.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -426,6 +427,7 @@ struct cxl_dpa_partition {
  * @type: Generic Memory Class device or Vendor Specific Memory device
  * @cxl_mbox: CXL mailbox context
  * @cxlfs: CXL features context
+ * @isolation_handler: CXL isolation CXL.mem link down handler
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -444,6 +446,8 @@ struct cxl_dev_state {
 #ifdef CONFIG_CXL_FEATURES
 	struct cxl_features_state *cxlfs;
 #endif
+	enum cxl_err_results (*isolation_handler)(struct cxl_dev_state *cxlds,
+						  bool lnk_down);
 };
 
 static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
diff --git a/include/cxl/isolation.h b/include/cxl/isolation.h
index 429501a655dd..3ad05ccc5e01 100644
--- a/include/cxl/isolation.h
+++ b/include/cxl/isolation.h
@@ -4,6 +4,16 @@
 
 #include <linux/pci.h>
 
+/**
+ * enum cxl_err_results - Possible results of an CXL isolation handler
+ * @CXL_ERR_NONE: Device can recover without CXL core intervention
+ * @CXL_ERR_PANIC: Device can't recover
+ */
+enum cxl_err_results {
+	CXL_ERR_NONE = 0,
+	CXL_ERR_PANIC,
+};
+
 /**
  * struct cxl_isolation_info - Information for mapping CXL Isolation interrupts
  * @dev: PCIe portdrv service device associated with IRQ
-- 
2.34.1


