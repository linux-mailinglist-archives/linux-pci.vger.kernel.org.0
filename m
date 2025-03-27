Return-Path: <linux-pci+bounces-24816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92377A7288B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 02:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DCE8423AB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E371A3163;
	Thu, 27 Mar 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="umfOEVja"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C700155312;
	Thu, 27 Mar 2025 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040238; cv=fail; b=SbDtFgxSHkJuKP3+bXJPJX0egmPw4mCue97qgCV8ICSaf2gZZ585wLKAyOewwxm7iH10AdOxXXI8VYMZ7rlVEaA49rJafAxZcXapx0m2F+xOyRSIM+891Hk1qZWqrul1Td+tzfxwUqngzxDRi2u8hYjEvE7qj/Z3nsOQjkU7MCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040238; c=relaxed/simple;
	bh=yHBaSlWEfdy1u7SWeDPDDA2TIV+AeYPW1bBMdITrQ1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpRqDzUkQBMq5ULTf7quuHGdOqYeTzoy3GB5cieKHd89zDXididgcywEDYB1jzpvgmbe7PjIGnWpUnXFARGv+QVuer2FqoabaKK98ODLfICgriypqW1fHm83iaKe6xnOC9vPV76//QM77sXCn2pQQq6uBNipr4P4x1PDh1ygVbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=umfOEVja; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxoGiidTS1Z0pwimIscpKnRm/sCo/Q9MTSDiMCm+qFVZ6e2/taeFnPnSXq+TsyWMReY1BXztomiNIHZNETxqGWNo087KPAe4/Oc1JlLxxNNCqdImo4Nv8/3v5HaqNUY03FLWJRWW8bniTHuisQG1pPzXvzZCBaFDEgaylEy0/54y+o/OvZk9XAZ7wnUKuRiKR/x0AzYCMYAVjgTKYcwMj74iD4ScVRp8mB2mgCIpyv/kewKTbbbfSzctZQ9JCHTIw7GBJQVI8TivPc7Dx9+hjux2aS7WYMOvBPRq+TrfxT3fi1C05sP8udIXby+2CtP6LOUTtmb+apEhupLE5pj8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJuKtnYZNx7iAixvtqlSRDhMR7Fzck0vwEHY/3dH6BE=;
 b=VxqW/HqRhKhCu3sOYIsPVhQEEVJ0TARceOYUgTxMceYqGJz5hlc8vVcNjZOV6DK/a7Vdea0iBUNYeGDZ6+zyH2jHlvknDNhesWtzTSErrYkW8YRLcxrdMMP/lx1at340D9pKgqSpZuQ7EZAoJPWQmKJHLuCH03xfGArqPPUfMlQtdLFSaCi+w88GyYkRi+CTRo49YbL7083WxdDaKI5uDlXoTdm5Milz3aBHGBI+C+3bKWAp+y6yiX1Ntp3KEmIe5yWrukqc+wSxYr1dZ9aRElqbbpfSMQe5NC2GjmD3HaUj9JhN+C7Ey2vg2+t5n2NuHuaLVeddh3vPdwCX21Qanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJuKtnYZNx7iAixvtqlSRDhMR7Fzck0vwEHY/3dH6BE=;
 b=umfOEVjaaUYSNAbDQxAdoOMDNYMHzAfqIjcYECj/i4wIhSlqB3LpXDH3+AKH41ySqCzU5SbkgV8t2p+xCHvkUXa6Zjh3z4UBkYC2nnv6n16TrdsxKlbiU2thKr6K5nj5SGtVoOHLvABWIhbb5mQopSifLsijQsqbIYynIyXJyIk=
Received: from BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 01:50:27 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::4c) by BL1PR13CA0124.outlook.office365.com
 (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Thu,
 27 Mar 2025 01:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 27 Mar 2025 01:50:26 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 20:50:25 -0500
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
Subject: [PATCH v8 16/16] CXL/PCI: Disable CXL protocol errors during CXL Port cleanup
Date: Wed, 26 Mar 2025 20:47:17 -0500
Message-ID: <20250327014717.2988633-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 513bf1be-d400-4448-5859-08dd6cd1bf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECT1wnSENI/KRc9Mn9jBNOSxt/yTMjrkPiBOS0sa5TW0dwChXTFnBO+Pzx9F?=
 =?us-ascii?Q?k80olVAfXthQyhnPNy9ITNItkQFuca053fcdbQuM8Ea/XBX1c9hw50bNxssG?=
 =?us-ascii?Q?1lZXNsho+ejxm28NcfaRgEjc9veSTMt48MT65G2bK0JHwJxLsheuPD5i8AzK?=
 =?us-ascii?Q?frkz9arfeuQHX0+35tscpam+oJib5jjRPOPyxGj0jZu7NlEoskoVZd03UoGp?=
 =?us-ascii?Q?i/Dy+xU6Wg6IT9xyPe/fHMzLtxIo7TJ4Q3JmV0ZqR5BVM+17sMucYa1yDQmt?=
 =?us-ascii?Q?1XvyoQ56bJpF6OAZ8V8c8LSQGvkd7eSugX4sYtpUlm3m+q76he7xMsdGZC/u?=
 =?us-ascii?Q?zVajj0p/FDZzi7rUWyRaHZQFyVJqiRiveLH5zEso31HJONhWr3z3iLQnPaza?=
 =?us-ascii?Q?nOl65UWQ2iza8ibxoTqqEI7Mumjdrwyt/SOaXUC68uhncY9tm3lw7DnEj29W?=
 =?us-ascii?Q?In8AUge3SUEpknaqvPpZVT9ZIJxaGhsXNGiCe/z0ETLBT/p7JW/jmGoIPv7R?=
 =?us-ascii?Q?/t0LVRthanWilKPtgeMBT4l/uaIl5t1dzgJlJvYDv287nrTGwc9M6aJ/Nwy/?=
 =?us-ascii?Q?efYCNTJ1lxoW+AlsWKgMqJwRWXb4fkMrXf8rWVkmKD6s417++X4oh8wQBUFr?=
 =?us-ascii?Q?odpMvP9a22VO1vNUinyB+eYgzXJSUOCS5au2gPNBoI5nuivTr9Q4gZapcC54?=
 =?us-ascii?Q?DvRsQeutT440dUOcsDesMdY7bLrejb8JeJkiv0v7DhEZCqhS7MWbF65x9umB?=
 =?us-ascii?Q?ae6lt+fWPhyLUcMKIb8zXaZOrCOf8ivrM3bCIJC5/Rgslx9Q05mXAQ+6goq7?=
 =?us-ascii?Q?GX2HBA1ounCcRrIgypbuE9L6BE270XrR1u6YRdSAPSkQ04lzimd5bXcpM9XU?=
 =?us-ascii?Q?lS9VHpS31bn5okSa2hs2bePfwlSIHCUOckKR45dZre+ZDj3gGad2ahdS98ZA?=
 =?us-ascii?Q?51D+GROTxpIHaLUmiKQpOSvxWFdvL0h1HcQGBD5u28apUTNFL/K7bs3Ufmhq?=
 =?us-ascii?Q?7OGSMtNu82eSwD4p+cr+Y6kT9IIFgSLfLRXG3pz/o6+bHgprLhmBZ9tgmEZJ?=
 =?us-ascii?Q?fAp/rtSSmTPgd50GBfnanuWf+PH7gSIRJtxh9W8ZnnAG8mVVlrNBi5SoHBZg?=
 =?us-ascii?Q?NhJDHk4pJlTPVVSIaj2cEnwkp98P3BSgsjQmQy7RgAlWEXNg2frTtVny9m3q?=
 =?us-ascii?Q?/MB1mpzk/elmjUoEdogaIJOmwad6i+Fw4Oq7CdrGXt6zZ3QfG9QmV7Ls3hTb?=
 =?us-ascii?Q?lu2b18Ad84IaX9uG13zfMm3GOvuJdwRG21Z51WiV1u6xJyJzp/gWTqsdQVzk?=
 =?us-ascii?Q?NAb9XuthzfhkpW2tMqTkaSBXPXSFuowjyKaAfnUNdba4SX32UCaiauq8dW54?=
 =?us-ascii?Q?syxcEy4Q/h/s4bQJiIoNW609oes65DvKEndTOyZF3QRr9X1NrAEbt4daHc+d?=
 =?us-ascii?Q?P/CboyaL8eMjTxiMzFBYcZMX99AUpQlj46wLI22/6T/q56CTwBN/mK5RkwxP?=
 =?us-ascii?Q?Ji4rNWqcIIEItJ5Ux1wNdafT8ALgbK7JUHdH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 01:50:26.7853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513bf1be-d400-4448-5859-08dd6cd1bf34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

During CXL device cleanup the CXL PCIe Port device interrupts may remain
enabled. This can potentialy allow unnecessary interrupt processing on
behalf of the CXL errors while the device is destroyed.

Disable CXL protocol errors by setting the CXL devices' AER mask register.

Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().

Next, introduce cxl_disable_prot_errors() to call pci_aer_mask_internal_errors().
Register cxl_disable_prot_errors() to run at CXL device cleanup.
Register for CXL Root Ports, CXL Downstream Ports, CXL Upstream Ports, and
CXL Endpoints.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/port.c     | 18 +++++++++++++++++-
 drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
 include/linux/aer.h    |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index bb7a0526e609..7e3efd8be8eb 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -101,6 +101,19 @@ void cxl_enable_prot_errors(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enable_prot_errors, "CXL");
 
+void cxl_disable_prot_errors(void *_dev)
+{
+	struct device *dev = _dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device *pci_dev __free(put_device) = get_device(&pdev->dev);
+
+	if (!pci_dev || !pdev->aer_cap)
+		return;
+
+	pci_aer_mask_internal_errors(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_disable_prot_errors, "CXL");
+
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	resource_size_t aer_phys;
@@ -166,6 +179,7 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
 
 	cxl_assign_error_handlers(&port->dev, &cxl_port_error_handlers);
 	cxl_enable_prot_errors(port->uport_dev);
+	devm_add_action_or_reset(host, cxl_disable_prot_errors, port->uport_dev);
 }
 
 /**
@@ -197,6 +211,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
 
 	cxl_assign_error_handlers(dport->dport_dev, &cxl_port_error_handlers);
 	cxl_enable_prot_errors(dport->dport_dev);
+	devm_add_action_or_reset(host, cxl_disable_prot_errors, dport->dport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
 
@@ -223,7 +238,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 	struct device *cxlmd_dev __free(put_device) = &cxlmd->dev;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	if (!dport || !dev_is_pci(dport->dport_dev)) {
+	if (!dport || !dev_is_pci(dport->dport_dev) || !dev_is_pci(cxlds->dev)) {
 		dev_err(&port->dev, "CXL port topology not found\n");
 		return;
 	}
@@ -232,6 +247,7 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
 
 	cxl_assign_error_handlers(cxlmd_dev, &cxl_ep_error_handlers);
 	cxl_enable_prot_errors(cxlds->dev);
+	devm_add_action_or_reset(cxlds->dev, cxl_disable_prot_errors, cxlds->dev);
 }
 
 #else
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d3068f5cc767..d1ef0c676ff8 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -977,6 +977,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
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
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask |= PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask |= PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
+
 static bool is_cxl_mem_dev(struct pci_dev *dev)
 {
 	/*
diff --git a/include/linux/aer.h b/include/linux/aer.h
index a65fe324fad2..f0c84db466e5 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -101,5 +101,6 @@ int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #endif //_AER_H_
 
-- 
2.34.1


