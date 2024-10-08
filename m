Return-Path: <linux-pci+bounces-14008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727C9959EA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B018EB23A40
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAE215024;
	Tue,  8 Oct 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LQNYyFOt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E614A82;
	Tue,  8 Oct 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425862; cv=fail; b=hT2AG6YkaMgbLHgiArSSalGkRYJjU6i5f0nkReNxPc63xL4psT7bmUWydlJNTnBSxIovz7PLEBVqiRwJ5YJfAtCHd66xDFU/ECOlbQCiVm0ZMvZIjcrEeFsunLTvkzmptRrz5xqBJgUOGKAvyksWlf4Ug/OWwnuV0tre8EKAHxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425862; c=relaxed/simple;
	bh=Khez0xSxToTOHyrUaMypy7f4f6wN+rGwB6rWgLhZF6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4OCc1AbKgXsm0+IElkc85gYbmjKjkJpq4heInwhl3biu+Q5GtFD4k+W01t2byXCWbiZZnUrBge/yuPSD1ckxfWKnSf5Xvs6tB4Dwy+OXyo2gQDgtOx0xcZh1osVr0043cvNli9fo0xRZ4WdJz/dG1qGP+Ojysjd6Y1u6IoJmio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LQNYyFOt; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As5RFjVD5M++K1fPAtq2MVuqkkn+LbYLHsMg4j9yatopdXqp73gjzBqhpxxCQfghF7QihRlCZQxSBrFLpmaTMya0c3u0OB39R+x5fN4ZGshllXnKqeoM+KVhmOyiLOeirMGlzvmxiPHxgaEjh7n39o1fn3lnpfhovu97Lf6th6JJTZPqUTSCtQjV5YYth8Vm/bh+TdLqE+gyKulaRNX+NxQgD27M1hvhdcfSa7vX2Wjg5VVpCSdjYdmgYmRrg5hmuIxufKKWpDi92A9slFMVfsDx9EULavu5v4auEtdAGb52STOUUR3N1KZHKzmdMdqFq3YCUEc2ayrBtpCiFNQA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUox8n1qf0eOfn8XyU10gGsVoUogdkhUmvwdICPzxJ4=;
 b=bpkUWUYHEqIpY6Mg/xRSriPt+5CvY2iUzqH3tf0rhuu//WFRsZ2eSzrMWIvG9BeWSRo8+omIAl2MD6oCEZD2wukMAqQlz7o/PJtynkLIyWVKmNYZSgNnsmG5cd/Nvt80HzHLTIL/2cpOhiwSQtFbq/hmGH+fyQg3sQX1lP8xjwAgGGXo1UAh9XjPwTirhvSb8OaTlN0cS3Wa8QcVgVEVfM5DyIG9eXU/SYAzll5g8FMtdTx6gB51gBht5V3WgEl2F2J/tFvQfz1afIpzHRgcptSsiXMqrQrDqVpxzcPYpReT8bbEyIoViW3HpmGnRUnpXthP3CcGKD7d+rHteGTQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUox8n1qf0eOfn8XyU10gGsVoUogdkhUmvwdICPzxJ4=;
 b=LQNYyFOtFCk3uetBIu64p7vQFBsyj16mXJmwpqXIT1cONdKuZDOqDqe4GaAAw0Yn43BR2nm+FJbHiroye746JxPiVOeW12leYH1t4HoW0+xRwHnTymwLy1ldIS0QnDf3UqtIKix/AuVo3axSSykpuu/1jYzUj0O/T3T1FipTtDU=
Received: from BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 22:17:37 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::79) by BL1PR13CA0209.outlook.office365.com
 (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 22:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:17:37 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:36 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 03/15] cxl/aer/pci: Refactor AER driver's existing interfaces to support CXL PCIe ports
Date: Tue, 8 Oct 2024 17:16:45 -0500
Message-ID: <20241008221657.1130181-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b04c59c-d6fa-4eb6-dab5-08dce7e7042d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92+ywI60a9IBg63an+fu9jwmtD+AaXrnzl9YXN6B+Pd1u8Dz97wi1oBn3Bxr?=
 =?us-ascii?Q?mEWVK6oI9d6eJwefa9yBzqzVUCUoVskGmAWqZ1CbY4na2gux8B6faFZOWg51?=
 =?us-ascii?Q?q8r3qIa9lo+8HV3SzJly2dCXpkRvE++CSxoweg0cKpQ9TD6gwonHi7Z/kN8i?=
 =?us-ascii?Q?NnVHhq0wv3E6JcRe4jbYTTYDqsQ8E5ZGcPd8i5eti9uZGsprpJWyGPm3g2wh?=
 =?us-ascii?Q?LGzXpkD+ojjLuHjy/A+UbfgSDdCluRQilyjsFGE21bYnSa3PqOvq2KHq2gJy?=
 =?us-ascii?Q?SmyndaxH5L+v8P/tutBrjc8vzwJV7U1MJgIBbK9vKTlmbO+vRIuHSrZUFdEY?=
 =?us-ascii?Q?QNjhJqMT5ijue3LogpC2hBPJLyQ81CJ900JdY15eYJ0NV0trx2q28YfM9U14?=
 =?us-ascii?Q?3IZs3oLLqmvmKA4EZ1kvvfAgpBbNrXuy8E0wWlOkJgeiUherGvXuVGDgl7qf?=
 =?us-ascii?Q?82KA1LH2T61+u87E6GIQX2TRFAWRqpFFTz4AmrIC0WZpAfYNDVXQ8bp4QaKj?=
 =?us-ascii?Q?YtyXhdFi+ZGI/NpsDifD5BbGM8eKY6Uc+G88JNlssWYtLXvNBNjkkm2kd9KO?=
 =?us-ascii?Q?bv7kMyQdZGaRhZs79gcUDu5GNSuaN7qG2WzI+m7kQair4364x3nYFuYBJ6xz?=
 =?us-ascii?Q?CZ76juDsBCfEykBU3nAxredDratlTP+oV54r8Pvl6HXz3QoaKu+j6D5PNnKd?=
 =?us-ascii?Q?aCnvYxzHr46HO+K8IOUUniHcpXZH6yteVu7TA9B84Dedg1BNZqwe6bWzcSdi?=
 =?us-ascii?Q?pCE5DvppBe2/ALkr3ldpijNLdFephlNxy5je9Kn2xOxLMOHnck6MWGspkSvb?=
 =?us-ascii?Q?T4EvYOiI9akJlbVSQmbnL09ztq3s+OyVtUCqfuC2DXUVxFfXZy9z5Q6zrJeI?=
 =?us-ascii?Q?qxgZ3ZrsJatYlNdZtot2W6Gi2wugdZzkQvFJKWoaJ3kY4+9yZU36Pa6szaQp?=
 =?us-ascii?Q?TiQYQ6tf9ouhs2nSDG8b2XdTYYuzYwpDv7HZXbjhXHE78VYSCXNIju+HXLwp?=
 =?us-ascii?Q?8Qgolu+E8RvYob9O5gRozX1yHe6u5/SWK/rC6oW4s8gdiaREwBV32NgTpbr1?=
 =?us-ascii?Q?DR7jqgc7MKEixj7WVCXXtOVLm9QfTHs0VN85ROYXcv5k78u1MAEbWkKuKiR3?=
 =?us-ascii?Q?C0YDm4/s06XIYRL0OLQO4P+SDbZshQ3BESveWb29VHb/uvhz5TVAENyICT/Y?=
 =?us-ascii?Q?C0QZysZAszn+m6oZxzzqclfSYnMubY99KE+kObUb/z0EX+DozbheN36X+DGH?=
 =?us-ascii?Q?4IKt8CyhhBL9gNDMHClHi831KMARd3GGA12AIF6/gvtYpps44i4cSOGeRI2x?=
 =?us-ascii?Q?j7mbuyzVkqtCc9mnI0+vvMRXIx28o1pm6aNNpoihTVup0GJPgULRi/zWcJHF?=
 =?us-ascii?Q?IeE6//RyYB7eVOze/bUN5vWr1cLB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:17:37.2562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04c59c-d6fa-4eb6-dab5-08dce7e7042d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

The AER service driver already includes support for CXL restricted host
(RCH) downstream port error handling. The current implementation is based
CXl1.1 using a root complex event collector.

Update the function interfaces and parameters where necessary to add
virtual hierarchy (VH) mode CXL PCIe port error handling alongside the RCH
handling. The CXL PCIe port error handling will be added in a future patch.

Limit changes to refactoring variable and function names. No
functional changes are added.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1e72829a249f..dc8b17999001 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1030,7 +1030,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
@@ -1053,30 +1053,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	return *handles_cxl;
 }
 
-static bool handles_cxl_errors(struct pci_dev *rcec)
+static bool handles_cxl_errors(struct pci_dev *dev)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    pcie_aer_is_native(dev))
+		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
 }
 
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+static void cxl_enable_internal_errors(struct pci_dev *dev)
 {
-	if (!handles_cxl_errors(rcec))
+	if (!handles_cxl_errors(dev))
 		return;
 
-	pci_aer_unmask_internal_errors(rcec);
-	pci_info(rcec, "CXL: Internal errors unmasked");
+	pci_aer_unmask_internal_errors(dev);
+	pci_info(dev, "CXL: Internal errors unmasked");
 }
 
 #else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
+static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
+static inline void cxl_handle_error(struct pci_dev *dev,
+				    struct aer_err_info *info) { }
 #endif
 
 void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
@@ -1134,7 +1134,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	cxl_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
@@ -1512,7 +1512,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_internal_errors(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1


