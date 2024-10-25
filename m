Return-Path: <linux-pci+bounces-15362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A219B1169
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CC41F29EA8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713F01FF04A;
	Fri, 25 Oct 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BOmPutbg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB141D2B04;
	Fri, 25 Oct 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890320; cv=fail; b=Bmc8qH42IkdSpt+REUKgfkPc8XKAHgM1nQmumWByfkhiCPxCxFG4oV37gR/CceTa+lGUFslUFa5n7TLCgPthexYrNtYnZnCUvZ4MUqp526v40Q3b16Xbr2LJE0UxDnfdlqc32EVEUuasrsmO4GeUgQ/DZdCAgsM/V6X02aTOpcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890320; c=relaxed/simple;
	bh=xMPqnjGySRkrlOppPyCgIEcNHzQg+tWfa8dlX+xpcIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHcordWzM2OZ+Bw/v+QIxtq+CzbKWY7mTZf+AgyLfh1bNfN7vOZerYPMGRR3cs5ZYxGsd4+cBwrE58jRh0KsUbyjQDQPQkv9V5S7Pt7Pfz4WBAyFduNFKS5BEiQQGIjFOonHhYAfXahyFAApc6PZX/LGzP/5/XiJttd79cKA2oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BOmPutbg; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO27biXpXQLVgfcb4w4g2zzUE33sWBrJh0tkWH1RAfDyJILMO4xvkl2yNHGHjD3fZ3IDY1/EUKG20Ke5hgQWx8yt3RXKEuQRba1Gsuff5fF/MZGD60O4hunQZZLuMSuIU9dbb8Wtbek7rxtIBPLf3h+tiy9OnUtCKZ3jbW7jAemGLvF9tT+D/Z0ENKjlnQ0f42cdIXwis2/aNBEyycUfyT00HPV8pLgm+f7lXoSZJ8Q4fsGdDzHpKQqb4jI6H0OnFHi5xTHk0dp04qrFJzusddgH/JqD6pNE4Jmex09Qd/ZzhcC2htSqaIK8yWkwxJIFojX/Ei28emaCyikqOavNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCcjp76MfUieof0YgM4NsZcJ6EOCvb3oRjqFA4i2qaw=;
 b=bHpzbfQaFstaod07IM04gsC4rJMr9Mu++imPp8fRXkVgy9PZIJOw7VC1ft1nJ1zSo5kZoHNQaz8S+aUpPhIGBkfkfySUfHLwoO+XcVocbDTTXD4aDJEBha60WpteyuOeCtSrpWTWpcHDV+gYneHcKxY9EAz0GI7s63Hwk/JqCypGUdowljT9n+xAWl/Yi9QePFzS15ZRXOvuAEHXcBo69AUJiB4EXw/ekq1YD+uLJlXySeZ9t/KDR5T38wWGhNL8oQTGNwlUKNbj/fjx8DFvt1SRHb/85NItossgonHY2pO165Fj/w2ssAfjtQWQADQL8IS6/dzZwu44aVqCFIwF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCcjp76MfUieof0YgM4NsZcJ6EOCvb3oRjqFA4i2qaw=;
 b=BOmPutbgtn5tcdwM+avT2sKNPMwq2OK5ALObZUTurFIYjYXlzz0n8YB9V493fwkyPRxBj+9LrzHE4kNZcyKfy2cLSeE5rQtHLzu2o7cmFNqXl4nAJludXF0zhbu5WUVipDnKTMAf9bEwwAooTdRbIODnNlFj9tBUG7YH93ou2J0=
Received: from MW4PR04CA0299.namprd04.prod.outlook.com (2603:10b6:303:89::34)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 21:05:12 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::40) by MW4PR04CA0299.outlook.office365.com
 (2603:10b6:303:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 21:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Fri, 25 Oct 2024 21:05:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 16:05:11 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 11/14] cxl/pci: Rename RAS handler interfaces to also indicate CXL PCIe port support
Date: Fri, 25 Oct 2024 16:03:02 -0500
Message-ID: <20241025210305.27499-12-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 744991a9-6ced-440b-1af6-08dcf538b77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcJWa8Gn/bOIyjV+6Wg0OVFW80g5TZBd5tQ9If60GjTf1LUi8OveisCeRBoo?=
 =?us-ascii?Q?fpDV0iz2+JkqQfuKqi8ITZuLduimtYob2lOU7x1M2/FEp4CMNNpzBfTuPyII?=
 =?us-ascii?Q?3i4cQcX3L9sejXcdZK7bU53TpYwjruLtASHHBPNKJl7eomg1uhaci57aFLH3?=
 =?us-ascii?Q?3yRhyQFSSRumbOr5r0MA9oPSsNwm5pUViU/AAbi7iKiTW1V8j6C7wCg9sbhT?=
 =?us-ascii?Q?vHxYzQZaV78uQkMGE50RgEbQiB5QJmR5waasAHaHwYYY65OAp1YtpMdumnmP?=
 =?us-ascii?Q?0WbWqy6Wtokv0ucf80brx1u9h2E+4OH6V99KpayHiP9lVgafXez5hWSjdQl6?=
 =?us-ascii?Q?fdnUXJTmGiVHxQ0gq+Bqba/VizkHR+Yx9Pk8eaAy3CokhpZNSAI4S9lVQWGT?=
 =?us-ascii?Q?6wrkvR6ASIo8Yx3Jer+7SEyLhengPbUqjw3yGaUE0/5Ym1aoSeh1tLOBUSai?=
 =?us-ascii?Q?lA6iHACx8mZO3FPNgiDwygaK0wF2Du2izVWbaw7pisQcIurF/oIfuTqAYDGF?=
 =?us-ascii?Q?Qyf6EhCj5MM5jWfvyq7izWu6v+XA6dCuSFwERoVauWCAvkCU/dhaBV8odekc?=
 =?us-ascii?Q?vKue3cYj9Yw72UZh0bLyJ5sscTg2EI/XixqFawY7Egs/1xfTLi6wPVjdSb5w?=
 =?us-ascii?Q?3SYKjoosFw/gZfXun6Pd9vALrZmqCuffU5T93qEU/Aa587BOLo9xLdcAuW5a?=
 =?us-ascii?Q?l57nZpPjbT2Xx+CQpayMqsGHtbp357o9lzNkS0Bzt3wFFLG9PAx0ePmOl6xC?=
 =?us-ascii?Q?mKTmgMnyGfB/C0dUjrMYUlfHpuEhr1xwIhHuX1pwhVbEKXvHUw/OaUFLlfQO?=
 =?us-ascii?Q?bRs2WlMR4C+u3rsiQiSN5EaT1jDNT9xMK1t8dDfNzlZHIgi/opm4SyjZTk8X?=
 =?us-ascii?Q?TgT+oxlcsdpLfWyeYre8rHzv4v/Vpf8YTiAYRJwTPqaeSl3Vz4QBWE8bTjEc?=
 =?us-ascii?Q?XLMmaps+579q0AH/cVNdEfJAGH62J54QLKTjiKuRcR0VNCy2DjCGz0FcdC7w?=
 =?us-ascii?Q?ttkmLUZiWk7D54n3OFCob3gBhyfaOqdzIkRK+9JIQjTwe02n3pW2uGJg+ftB?=
 =?us-ascii?Q?stFFLFdb6GkDrsK8SdbyEHOWKT/n9iHvTcIQaQPMHxCZFksLvD2Ed6CR5eXQ?=
 =?us-ascii?Q?H0Jo6JEkNtjtpCEujy56q96nnhmzvo1RZZgF4yw3AGO5PhYwCc7xmWxGaLNU?=
 =?us-ascii?Q?xfubJATYAqCSVJJkgp+xVJvI5ZI9Op0Y9y5papXq63iD7OsD4MIzvBwV18IR?=
 =?us-ascii?Q?F7izGqZ3PlAwqnov9Jp0CE40Zmla0sZg5VBKW0owEK7TpYBn4LVNHoNhoiCI?=
 =?us-ascii?Q?yxUR/a6vJag7DUYlkYW0vn8zAg69Rf6Pkjcy8ks/dNh8ijoi2GcHg6eJ/KIY?=
 =?us-ascii?Q?4tvLDz00J3oq8aOnDa8lxqWdpkTn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:05:12.3427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744991a9-6ced-440b-1af6-08dcf538b77f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680

CXL PCIe port protocol error handling support will be added to the
CXL drivers in the future. In preparation, rename the existing
interfaces to support handling all CXL PCIe port protocol errors.

The driver's RAS support functions currently rely on a 'struct
cxl_dev_state' type parameter, which is not available for CXL port
devices. However, since the same CXL RAS capability structure is
needed across most CXL components and devices, a common handling
approach should be adopted.

To accommodate this, update the __cxl_handle_cor_ras() and
__cxl_handle_ras() functions to use a `struct device` instead of
`struct cxl_dev_state`.

No functional changes are introduced.

[1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 53ca773557f3..bb2fd7d04c4f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -650,7 +650,7 @@ void read_cdat_data(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 
-static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
+static void __cxl_handle_cor_ras(struct device *dev,
 				 void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -663,13 +663,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
+		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
 	}
 }
 
 static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 /* CXL spec rev3.0 8.2.4.16.1 */
@@ -693,8 +693,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
-				  void __iomem *ras_base)
+static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_SIZE_U32];
 	void __iomem *addr;
@@ -721,7 +720,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
@@ -729,7 +728,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
 
 static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 {
-	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
 }
 
 #ifdef CONFIG_PCIEAER_CXL
@@ -823,13 +822,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
 static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
 					  struct cxl_dport *dport)
 {
-	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
 				       struct cxl_dport *dport)
 {
-	return __cxl_handle_ras(cxlds, dport->regs.ras);
+	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
 }
 
 /*
-- 
2.34.1


