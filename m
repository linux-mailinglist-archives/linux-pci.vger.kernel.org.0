Return-Path: <linux-pci+bounces-14020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F7995A05
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2F1C20E10
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 22:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40133218583;
	Tue,  8 Oct 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A60qVngN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78521791F;
	Tue,  8 Oct 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425997; cv=fail; b=c+bjKzPRym+imnbE5liUAeKpPR4oEPx4dvO7H59jHkVmwuvzk3cfq2g5m/Gt8gRXpEfqZFG11lniK6qERKskA6AZAmssqqLnH+8LLgEI3Q0jIugrXwM8ff6URrTSO0ibNT38KEpCjK2OpxLas59ZjlwiKdAsnUoqdFRytdeL138=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425997; c=relaxed/simple;
	bh=fHzw/BDXIHn7QLS7ZvIgVVhno6Co1TBG8mEbhXsLOaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oheVOLcbqgb8KI+W+KuoEaBsVaksOJhgR9eRnThB2THVfJ6wBC7yTqMQ6a2xE90h7X3tvHdZIj1o6EdMBMyYWNz1b1qfJnLu+mx34WQCu25rJovP7aY3830F9AFKn8Oqui5zfk4J/jCAAsUIx3WgzEaHtXuEpR74N4WSJAI34LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A60qVngN; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXUa+onA4IVTY6gtlsFa3HgP5AeFxatMhSiqfA5zjFJB6BFiGme+IsSZjVqmLWrTR5ugARcXOV8nKfazrqe3O6NrPD+IYgLR3Rt4ooxc5B9Hzj53i7C+60OEdKo/tGKDYW04WkLgVzIpL1iLPs1LGSyR7qE02sz39zdxIOx31T1i7M31+4juOIynWy1FGX3B95NwCJd9nfCrovjZZtUvRVgyCckBsV6dDbhRwiLShgUQ0QVT2UfJsUO8MuhFoRyvS7WaqjFYuuKPcHQVQEAvQ7ju8jE48b+pzWAzDwDYTGXC9vpC7661p89ZyZkBAyWFLpxBc1WdIMgJ6JpS/qZhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/1JBAXKH0wP+1tCXCRUlm5/st9vbuvv0hE9F+lBIso=;
 b=Z/eKYX6ySIVA37VQuOIaNPvDPBH97dVVJAZR185YycxOsqo8ZkZGovZlAE+dH+zKO32QHmlEy7rT0P5CLSCd0a4yIDdNkYsmwRmeeMoPWKRrT2O2CTrOrIz7dJD+D4jdq9f09CemQv2keFU3TIyGiR2Uhmt86CrZ07EmI1Dg80+9pl1c06MLwmEIijVZZGGzfUTfSdhSSzES4przc/KyNbHTdUnsei3MKaM1s6qsi0sjZ2vi1H6NeE2KwXZEIIkDlzY8Xdrt3FxvTbeNKEvwC3TzpvqUOzqfoUCReuBw2Yu226yhvqBMtTU1EbqW+fS3JV1Y/5CKt/5kC9A6YmYKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/1JBAXKH0wP+1tCXCRUlm5/st9vbuvv0hE9F+lBIso=;
 b=A60qVngNorjbQ3Sx/tFGdtTQoOPZf8bmVZSl/UlAECIW8blw1xdBHLGOXgp1KWGUR4IN1wwzdK/SFOQpyXLOlJo1fVOwwvCL4EUydqGDq+ESxtFJwv9DBA9WZfSmF9YDIcUZxVixH2qHf7kvowCsjepcLIkoAWfYwbFdF7kTjwA=
Received: from BLAPR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:335::29)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:19:51 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::d6) by BLAPR05CA0048.outlook.office365.com
 (2603:10b6:208:335::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 22:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 22:19:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 17:19:49 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>,
	<terry.bowman@amd.com>
Subject: [PATCH 15/15] cxl/pci: Enable internal CE/UCE interrupts for CXL PCIe port devices
Date: Tue, 8 Oct 2024 17:16:57 -0500
Message-ID: <20241008221657.1130181-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8607cf10-952b-4600-14af-08dce7e753a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICJNj2fPAQfGWJ5wbJsDtJNj8g5xycv1ZPPPIzvFKJBaK9Ceu3hTHPQnxITt?=
 =?us-ascii?Q?cM0ZXPrYSO6KdkkEPzyuCoPTCgE5BnkWzHwqx/oHvWiPYCpriWrtUXDFkb1o?=
 =?us-ascii?Q?UdU1ufrGWAS4nZoDzaW4myY08w/5SCLyI1HFsz3xnE/OD8SKf6eRgCaaCHCj?=
 =?us-ascii?Q?iBfxDrtz7G0bbUKAXOm45elNm0quraDEBaCBFAYQ4S1ZHs5iwqGHzLPVuITC?=
 =?us-ascii?Q?G9DgRcQayf8yO1RI2JCeP617jv3+ddRNMlP/BGT6dwJWrVqPpEHB4N0AWzRe?=
 =?us-ascii?Q?B/lJnNsC7Veqy4naHm4KAj34tIaF346j+VpHtMMnU3Zl69whW+t3wHYlQCvw?=
 =?us-ascii?Q?DjpslGYSceE54USiynzMu/Qo82SKr4yL0VtMmWwuXL5/cwUITCJd+YseeF0a?=
 =?us-ascii?Q?dy/LjIiBYh9tLx0Rw49pieK7uOGB432BCs3VNUiLno7t70Ca7ic2WvN8Mnnx?=
 =?us-ascii?Q?g9ZaS1cE595EcF3W1MniFEqINhoGJlIC8WJ1ndjUShqMNwEElUhCYGapuzYd?=
 =?us-ascii?Q?YuKl0XOmQATM0odSJ7Ep6rV75E3KSAJSwRq8lL1gDNbntZ+4IXzHp6XgCpUq?=
 =?us-ascii?Q?Fmoq0xLXSiEfAGJbfrLgxcWFCLvwx4/ARfNPyYkjn4hm0T2QxAUgRl6fpNlH?=
 =?us-ascii?Q?xhXSqYid7uyvv41IrRJBianeyWoUq9nQ8tNn7yh1HGVyNtL+PQ3kPBwKEvuw?=
 =?us-ascii?Q?aDu4NLQ44274GgOp/koMozekDiwkkMVbQ4c6SJ2X40xB0JXmKziEI8qcuxth?=
 =?us-ascii?Q?OROuZUQARlME5EKqEjH7+VXako1VLB2mJ+ESNeIdvC54Sw9xmoLh2iA3RYhK?=
 =?us-ascii?Q?8FTIvbjmlubVNpA/HaiYvcPA7nxD5S10qkb9YJtUhGK62lgLXSef9iScfc+M?=
 =?us-ascii?Q?qdis72FaUdFrK9v7PXKkFDDUN5GBFaKuI+dPwsg9uM3is7ii/HUSJo2wrktO?=
 =?us-ascii?Q?LEj9zTgP6eLgPmkOrKi46oJ9DKpUPk12xj1JydfyTe9oxtPWXwgL9cvvf5Gj?=
 =?us-ascii?Q?pTYFljrfMieSqmfvo2+XjIosnDR0US19wMPvMDyjFNJpYsxqaMhRlINkQ/pT?=
 =?us-ascii?Q?m/ROE2WcJxBe6xgBP8S8Ar+SezbNZjgU0I3AGMACt2ATUfDwjNuvxuDQ9P12?=
 =?us-ascii?Q?I5f1vZhGj/PxFQKDIQLOmEGh1RHpijsFjJ7trsk8/Zev+y6VsfpecGFD0qs9?=
 =?us-ascii?Q?g0tXMcTGdONXHYVyZ0EfWtcFASUvgGl4nQbbjINst4MyDWRFPw1P2ibZBO22?=
 =?us-ascii?Q?3jwPkrSDbYxhnyAf9sD1HmKqCoJR2MKXC4Ti+WLVAUJcS5EHDWHrPm90HRz7?=
 =?us-ascii?Q?M0hVOq3GnReYaJTeUxfyVnAhpAGHHsCTlxC4dl4ZFH2kAHoJDuZ8ZIqjqsXz?=
 =?us-ascii?Q?rudqcvt3mVQAyrtTOv3HfpEqlIDk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:19:50.5644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8607cf10-952b-4600-14af-08dce7e753a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920

The AER service drivers and CXL drivers are updated to handle PCIe
port protocol errors. But, the PCIe AER correctable and uncorrectable
internal errors are mask disabled for the PCIe port devices.

Enable the AER internal errors for CXL PCIe port devices.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4706113d2582..1d84a7022c4d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -908,6 +908,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_port_err_detected, CXL);
 
 void cxl_uport_init_aer(struct cxl_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
 	/* uport may have more than 1 downstream EP. Check if already mapped. */
 	if (port->uport_regs.ras) {
 		dev_warn(&port->dev, "RAS is already mapped\n");
@@ -920,12 +921,14 @@ void cxl_uport_init_aer(struct cxl_port *port)
 		dev_err(&port->dev, "Failed to map RAS capability.\n");
 		return;
 	}
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_uport_init_aer, CXL);
 
 void cxl_dport_init_aer(struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
+	struct pci_dev *pdev = to_pci_dev(dport_dev);
 
 	if (dport->rch) {
 		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
@@ -949,6 +952,7 @@ void cxl_dport_init_aer(struct cxl_dport *dport)
 		dev_err(dport_dev, "Failed to map RAS capability.\n");
 		return;
 	}
+	pci_aer_unmask_internal_errors(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_init_aer, CXL);
 
-- 
2.34.1


