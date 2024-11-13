Return-Path: <linux-pci+bounces-16710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3AE9C7DFD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B521F239FA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD818BC1D;
	Wed, 13 Nov 2024 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ql8sC8Ct"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3218BC27;
	Wed, 13 Nov 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535015; cv=fail; b=FQx9ZRPqaglZnahzIU22ysckH4PdFm9NHd3+u6NeWVxwuZmCucMC1L+azLM/TVCCKE2ehpmuEB1pE7017nBm26Rh1tmvkkxnhPWwoIJswrcZw/aUdlYy/ErSUiypXUtM8eSoszoGkmMXVsnhJCgoYitB2UDY2v4VPPK1rfAxdBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535015; c=relaxed/simple;
	bh=rXB+kFF2bkM5ZAg/gJmTlyqGe7I8kaqIUmA80iX1O8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1akY1lLpnyMzgiE0neA17xz6VpZNOM9Mx1GPfI++iuIfjc+uZ35M+DbsmirnV2+SUbgFimNFJFPrFyIAqE3j2lIeY4GcSqbqYwKqMlivK4Uka3FU6WwxuLyc18Vno1ZNZLTbevpINh3XIe+Xw066jmyyAzrEK91tUFF7skIDR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ql8sC8Ct; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPRcgPAA7shx3+jkNJ4Rs922YPOGaJzN9sJ3dGWoqMFdPeAB3TK7KkALXTbFMsmoj9LvdPu2aePW+qFSTpxobOTAsOhvyq378sNx90WaPWZd29zE3R0B0vNaiuA7oMrYtTUvvHJdk3pB3GqeaymR//QTqZMQe2tkzwNhadzAzu27t7aJA92w+FUmVYmKEyd/m58dVTXHN69JL4p1fJ8fpk6C/uiAaLJp406f9/23TBRcEeerJHYsRX2h/6czvTuZXmIVHqQwWw3S4ED5ZGyMUR4x+JeobqL9xGfuFQEB38W/ZeebU6swRy7gquKzNXTA/fB1xPU3RJLWls3Sqc/KsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsTiuGtRC6otq2tcWjc9gtJVyvEtjXlzVSzlDPeDmm4=;
 b=unSMELuQOjkCNK44QCFjHH7wLCFJlny60GMUTk4DhPz6KmqQRqDZifm6Qe2tG+LbrU7ho/IEU6zulfFM4H4mMKQHojU4PKf31FFr4m79soMvzcZqIRu/yQTmNP7AKzn9GBKNz9uAv8v9CyvYO306ilc3FK4+nJeiGWByMyiMkZc3y1X+lCbh7Yp37TCz3AOxNYyO1QHiukAoo2sK2LDVCvEvCPC6f2A0GaG9JSVjRlJpGrrWe29wWOc/EDs9DCHiTB5REjUxOk4F+SAyHm1Fy0GZ6D5/d+u8cHLKwlNskikqAUVQogyDq9jJZzKwIqGE2JIX3C7N5amG4xEZUyMXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsTiuGtRC6otq2tcWjc9gtJVyvEtjXlzVSzlDPeDmm4=;
 b=Ql8sC8CtrrmvRMUY1Si4+6Oc7l5hyc5Xataqaj8INpkld9JwGTD2p4DNQ7+Tq3KlkLOH2HoGDBtsyaPKdIyXJQ35Mjl4su9uUb3MHtK5TfAYYQViBKsMUXX4988GTDefmPESrOZWNh1jbDQWiKc/1FiqzirFc8yx5F5fhn9vKjs=
Received: from DS0PR17CA0009.namprd17.prod.outlook.com (2603:10b6:8:191::9) by
 MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 21:56:50 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::32) by DS0PR17CA0009.outlook.office365.com
 (2603:10b6:8:191::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:56:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:56:48 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>
Subject: [PATCH v3 12/15] cxl/pci: Add error handler for CXL PCIe port RAS errors
Date: Wed, 13 Nov 2024 15:54:26 -0600
Message-ID: <20241113215429.3177981-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113215429.3177981-1-terry.bowman@amd.com>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa7ca9e-c4ad-4a9b-32c9-08dd042e1410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xu2bqEV6aQqd6X0m7CxdqiS4Yl47/JPGE1O8aVINC967PLRwdCjyZaI5Ly+Q?=
 =?us-ascii?Q?G5AfZDozNDY+7AbQBVdgUMlUT0EeKftA1X19CQhV2w6n9mt7VnWO2g5WP81A?=
 =?us-ascii?Q?fYk1bANdooAYpGGKX0GCMyV4naw7wzbsMr8jPP1UmpeA3hR2BCunW1PQGLjo?=
 =?us-ascii?Q?N6EUKNa8e0zxjkfVTgmVO6Obp5Hqd1ZS3q2K8zOZtk57dP+O0VIG/Z3LxZC3?=
 =?us-ascii?Q?c4dTfWeoogJGw07PR5wjq5DpbRIe7/pmD9nDAgFlql35kshaw15EIayxKtb1?=
 =?us-ascii?Q?/LILBuDnaJkf3O9qYwaHv+rD+wotzAO4sMm+FNQJhNtFMGb6cc6vvZwW8xGa?=
 =?us-ascii?Q?VjOHhDBQWSJshe1mL51dktoc+7H9dDLGX/IfNon0YPUHx0SRKrAxEqoqycq0?=
 =?us-ascii?Q?d0FjOxFA1zRSoG/d7CLyBhLU6touPA7mUohKQfUiXHBBwOyKNa4VcMk0SgNZ?=
 =?us-ascii?Q?kK4Zx+DFjwe53H3R6Iylp5V1V/CPyeJDbbeMFV0iWLOZ/ZcFaGknXL6CJog7?=
 =?us-ascii?Q?4/JytSXcEBauzBXS0NnEvZmHqrtpmFFNDkX7rAczEBj73HBVRERNqPC8/VWv?=
 =?us-ascii?Q?lxPeRm1d+TGYpP8v2wkeZ0E7AaRaX4MUsPdlmeazwqiqV1CCAmF12JONT3DO?=
 =?us-ascii?Q?6CjzlSKFvFWYO1Z32kkJT124FQ/BGTkt+LfCFqgD7RQKjx0NbOl5FJoMogrH?=
 =?us-ascii?Q?kQAmqsxntIAgnRtkDYQuyRlmOvX8oeKT28D/svVgnfsxpO6zXmH69VNT92bh?=
 =?us-ascii?Q?5H81qZzq49K4hP4nH73ddHXYGyW7K/n/iTd8dDloRpSCZAWMEWgQzFnv6IE3?=
 =?us-ascii?Q?tE5qlZpTNGeSfkGzzHh7Q5ElF8hGLAAf+cR5wvNIqZL+bzPV2ZuSGjXTYU4+?=
 =?us-ascii?Q?WtcIWpdFTiM7OKfQnOeli4mtCAPdELHVHh5N1nbyURNL6mJxCJowTayeH7rM?=
 =?us-ascii?Q?yA/qacH3QRBjHLOMM13QQ3TX8GL05HjKqqBssWDZ1tH2Lm3Xw5XHRSNU++xQ?=
 =?us-ascii?Q?Q5W+ACmmsSdZajVwXqg7j3d5eZaolkm0zxLhSWLk//7a5zJuisjsjFxwzM8L?=
 =?us-ascii?Q?wGEn0EJWPhZomrnIJZ1fOrW7RvScOhYvzjXyO4c6IB2iKngYldx1fHBH9Vgb?=
 =?us-ascii?Q?Sf4pGQ6ezQfCSE3+rrHpYLCC5vBDdxXxVvYjVJS325SU3AcBP67GaqLIOuu6?=
 =?us-ascii?Q?jI3XioB7Is3C3DWb6Wdwb7sq6nNAcqVQMbsMghFqiVF1UhjbV1S4zdWWGEKZ?=
 =?us-ascii?Q?ih1oKV+GJGa+/N1VQwPXx/YDywJ+wMDuAy1fPgun/Zj6fnSamvSkMCTSK4k7?=
 =?us-ascii?Q?q9TATXhBdexeANxqlG6atwI+wQivVES/3sr6qjkTmGXxdskBQrXnhvVPbCzh?=
 =?us-ascii?Q?q66E7nvjP1m0ZGcHhgS5OF8iFrhQn3bfPGNcjzeuYDVm1W7gm7GSLqIMvUOT?=
 =?us-ascii?Q?Nary8NW9kJY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:56:50.4809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa7ca9e-c4ad-4a9b-32c9-08dd042e1410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

Introduce correctable and uncorrectable CXL PCIe port protocol error
handlers.

The handlers will be called with a 'struct pci_dev' parameter
indicating the CXL port device requiring handling. The CXL PCIe port
device's underlying 'struct device' will match the port device in the
CXL topology.

Use the PCIe port's device object to find the matching upstream,
downstream, or root port in the CXL topology. The matching device will
contain a reference to the RAS register block used to handle and log
the error.

Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() passing
a reference to the RAS registers as a parameter. These functions will use
the register reference to clear the device's RAS status.

Future patches will assign the error handlers and add trace logging.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 62d29b5fd8f3..2c5cfc506f74 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -772,6 +772,70 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
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
+	bool ue;
+
+	ue = __cxl_handle_ras(&pdev->dev, ras_base);
+
+	return ue;
+}
+
 void cxl_uport_init_ras_reporting(struct cxl_port *port)
 {
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
-- 
2.34.1


