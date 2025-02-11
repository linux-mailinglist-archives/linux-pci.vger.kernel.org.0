Return-Path: <linux-pci+bounces-21193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53261A3154D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1913168F51
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAE265CB7;
	Tue, 11 Feb 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="scHtt0Fv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1999265CAF;
	Tue, 11 Feb 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301920; cv=fail; b=jdpybJLPR0gIjOZD3GnY7W/IgJXeOcel4EFcXD4mbRWElZIopFx+1XSn8zFlXCikoUqPpEiwRp1E2WNSYy37Ph3Ho261DTn2pzawvqC2pnRJ4WxXxiHWpXnB2kMyZiEjPX5TUAM0WboE5aDZ8v0E8IkqmQw2lzmrkI+KmSlUQMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301920; c=relaxed/simple;
	bh=J0/fvUBeZlHlrk5KIAQfYTH3wqnVAFm7flSbfR4mvkU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgCAoEDeSeNlRXrg6ICEmBloRUIvXQoIvU7SQNI1L1ao/zVGvUo67KVEYiJs7ulG5zLOrgGjlO8nILcKoGDvu5QBv27gYiJS3blBo2spMwp4BveuBy/WgE3lOZZPH01PrGhvnzUKfkkAxbkkkH7RDJ4gnqNnEkSNGWcjtbO//UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=scHtt0Fv; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBuLpJDH0wUktS/U0sO8z2DjNZmgNwktGkiZ1oeL5sj1aWOlWQp5ex/cHMAGmpO3ifLWynZjaqqCsJMzyE7fdTsXWCE6b4R7tqrAt4OwoNPcTV6gRRGuSipbpm/sRk3AtIBcBXZEwt21Y+kZhTFO20edQlSXCpc1lh+OXWuizSqCMylLlzEzCnMaJ9K+liWG/z+pYFaB2IZ6mKsbWrKPc1SfpNi1M6fmnVcYhvbgJZOLJtkhnMyYUdMraIZHoFuuFAc+wDrIpWSCS8RhqDTxVwTvPgsjwmgl6vbDLgPNkWpp68GrDjblk0qEXXEebyJfxZ74TVF8iiNBygJ0lfXM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgV6JEjETvcIPOU7/SlmAsVk5+HnQ/VW6U8TCD9/9pc=;
 b=NH0Ju2PMJ65uI9t8WKdHimZvT/tEe30GEFTL/A7jBPllUXGF/0Laf7U+vCcqu25FY+s9xHV6vYQG82GU9WJ0k5O2kqeUUUlUWAHJdCnhcU4LjKo5J5zgC3disSuAI8fwiYU/0k7+SpEBT62N96mc+cGN0Ntdo894Wbc00vIlsTWyXrjeiT2G6CHcbYYqr8KzEvvy6PJz0AFs7pshKUcjT/A5s+gWPrat5lUpa2dXbs2F6iVqVDBeJWUz3ABt/VcTyIMpwzZ9/4i5Kmh6YrDUCth1k94FJD75+g0Icmg1j+nUVHGTlfRM82S6Q4qOv0hZbR2qXokDeyJFYwiYFAu6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgV6JEjETvcIPOU7/SlmAsVk5+HnQ/VW6U8TCD9/9pc=;
 b=scHtt0FvqDBVHk1UUw+gOHepJHOjaPbeeYUS56UEPwCEqQ2v83UuAAX/uQxmpA+vpySmWxaf/kCbUHF75WAWybVnURePO2dlaQRmwzVW2RTiCAC7dUWkXfooDgGLrHfzGNtG6LZMsvQtGDMMy0LZkAZ5Bb9qfMgLbHiTE2xQreE=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Tue, 11 Feb 2025 19:25:13 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::be) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 19:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 19:25:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 13:25:12 -0600
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
Subject: [PATCH v7 02/17] PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe Port support
Date: Tue, 11 Feb 2025 13:24:29 -0600
Message-ID: <20250211192444.2292833-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ea35a8-9423-4edd-2f78-08dd4ad1ce88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHCA3VnyYpS2ijYIJc0BjI/hAx80n6WhvXU02sBYY3MNOg8jUTYziyNAN8Y0?=
 =?us-ascii?Q?9QEB83HOVlSBQWTJPt5IcndAwfB61CfCS9wBexVDSrRgZFYob+pqZZ1qqzYW?=
 =?us-ascii?Q?ApBeJHn7HEYXjYpBnmqXJBWO/u46acbg9AKMDKURksbZjoOdIkBxIunwxkEI?=
 =?us-ascii?Q?5iMnuJWWnfQkyez7Hv+eQntqwoWtJZXigrPGoLoi2wZAgMGl2qX6CuhltMzA?=
 =?us-ascii?Q?AY+0p82OT2Mh99F7k/hiPp2OZoRtqqaJK8M+AqprarcY1BkUyYQ2XErS0vr8?=
 =?us-ascii?Q?yLlI60mubowCzuDFSDoLPIWlDvqUDND0ezvysBVguQlpslOz3i1u8hzgoaXa?=
 =?us-ascii?Q?21ifjeBmis9txa+cN1pMmd/2jGvQDbp4g66l+jQJJ6fxqDcGmpA18pPW2/L0?=
 =?us-ascii?Q?+BqU0/rXd6eJyEfP9wtBddhU3mBlR0XYoh/z0hWIY9uAG756rVbVrlOFOPsI?=
 =?us-ascii?Q?NHAVTt9yB/rzUpdaBpZjwZggjGvx3+k9R+HZFoQIRZfTfSrCHHjYexigYCuI?=
 =?us-ascii?Q?5Nzub28VxMSWKrUc7ZwojrsHhuaDeEtcotXLYlbNfpYd+WKr8u3r4aqct7pe?=
 =?us-ascii?Q?9pUJOd35gm2epn0jo+zKejfRs0o+dmxxaLcrkdUQr8v07mOcLGK0R1ZWgoYK?=
 =?us-ascii?Q?4q3n3La5eaXzg/6zrWxnk5tyMByhwN2JzFY3184JPrCyr24wZnecWRbCkp8/?=
 =?us-ascii?Q?sgi/1afwaWFPkNtkZ1UicrzJcTeCBKAie4Zxinp48bS2efLZ6PVtPnXq/2BT?=
 =?us-ascii?Q?P012Ayd599DGA2Tn12NQbRbtICBAmnvhWF1ZLGpLKzCjokPr9Fhu1G8azcap?=
 =?us-ascii?Q?y0c3VyJGFvvmA9k1dGUinu9Ed7cwrqmPUM9k8uHWrVSWuqhyFci57userFYf?=
 =?us-ascii?Q?BUVx8N2aaE4SIGWo3e0e1AdNmREZ5R0AuhGBJgeMRwaQ/0/S7u9BoXPmDbfT?=
 =?us-ascii?Q?Bxs6w/KEtyGGhYhbJJLWEPvPfdoB741ee9yi6nab8wstca2BM9JX7PxPfcim?=
 =?us-ascii?Q?Ou3fDMfBhBZ8HQTE7H+dqUm2nT0WIA+ZDmdipFp6iwGtkz8KNYB1FOzjKBdT?=
 =?us-ascii?Q?HP5vUeVXsUSUnpuNVTfkLb3LxjNbnC4Qo8RuTf5ylACO8LjIHIqFQZ4maoV+?=
 =?us-ascii?Q?/NH68PWCy/r3Fv+7hguigJouCzh9TvFjDov3XxaBLm7wRZj63/qYheMFnN+u?=
 =?us-ascii?Q?DjOwNzQ3xC/hzuILbT2+WXgBS1GBa16iavIxLa+Wamqlwm3fb1eKa6Nk/StO?=
 =?us-ascii?Q?GCw44hGnUEGXGWna4irfPgEY6pDpff03ve9mqiFQMGDYG2+z6Q1mgKE7LRmv?=
 =?us-ascii?Q?wDywRB3qIfj/nszM6+BB4Y8slaVo8VoMDVB61bt1YypUWyVnFXQb7mJh8CfP?=
 =?us-ascii?Q?hmZ346tg9DeEPveH+E/s+0lkip33inadrGsDYe70vyNPpaiCJr4dzDoJveEI?=
 =?us-ascii?Q?iwtjpKHPzd3ks3Up0p+aavuSgGaYanwVv7o3M2FKCLnp256Q6m1p3hVKyjOq?=
 =?us-ascii?Q?vCSMGwP8Z3xOQfgf3su/hX2iZb65zThbM/Fq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:25:12.9505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ea35a8-9423-4edd-2f78-08dd4ad1ce88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

The AER service driver already includes support for Restricted CXL host
(RCH) Downstream Port Protocol Error handling. The current implementation
is based on CXL1.1 using a Root Complex Event Collector.

Rename function interfaces and parameters where necessary to include
virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
handling.[1] The CXL PCIe Port Protocol Error handling support will be
added in a future patch.

Limit changes to renaming variable and function names. No functional
changes are added.

[1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/pcie/aer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..6e8de77d0fc4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1024,7 +1024,7 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	/*
 	 * Internal errors of an RCEC indicate an AER error in an
@@ -1047,30 +1047,30 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
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
 
 /**
@@ -1108,7 +1108,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	cxl_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
@@ -1491,7 +1491,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_internal_errors(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.34.1


