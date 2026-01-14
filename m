Return-Path: <linux-pci+bounces-44805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54598D20D01
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5416E30B096C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941C33509E;
	Wed, 14 Jan 2026 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/wdMFph"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FD2FFF8F;
	Wed, 14 Jan 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415030; cv=fail; b=aST6D8F8huPIjgboXQuCcDf/BtpzWvY+U4hMLj/34hR4fk3SwnqoY8GoFGvier3gyCFToEkJztwEhN1DQauMgthoWLjvqhUgcs4o/w/crn0HjwnV77/3phkEr/kjXZyrnl2SmeWWqIDGywxHPDfo8kZLlFLXw9Iu3Q3OKtpOx1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415030; c=relaxed/simple;
	bh=GhTV5azjDUkbShEwKPUdClZVm635N1u8rsjp7ahr5N0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX0b/j8mC/OwzW/PFgwZxPqnLTXB2Ci5L0nyWeGlTCzuHBD4BJNMbdo6eVAQf3kMMMUtlAvghdUfJ7iN/wGfcwXX12hsI+0pkbUjm3m0KUsEHj1PrDm5Iq7Vy89wc5ojaIhby5wqVyMod2KzsbVZzJdigEbq36pWBMSO7xMbpsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/wdMFph; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgU8KEWP/fzaJU4ku3Z8riKBqr3uApfrf1XFYTQdwYtOz3gS3vFARZnaNJesH5Ohmdv7lSdA+iBaRitlpb6uGZ9o5ct5oxI6P4NQ8jRFR9c36GLAKAVS4mHrwPXT3vbjzXDjZksyxlLb9ZrBXSJjQH/H9dQLJnlae7pKSp5RTL+3LclhRcYhvBQnoxvA4/WEvQk9jk484fw7vUNjk+uVtUcaZUWeHMmSyIghhHff60gkrH89J/cFt/IpkgTPbQihR3NA25JPk81Y1g/1KDGf7Mmo0+vVZ9O0vzpf9whCUZ2t4y53xGTFpVGdm18y1S8Adot/xfhdJNY4aPIpi8H1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtJUyP3MX2Cd2/hdqW+GhnZBNVa722buW6Tj2ECTlPs=;
 b=JaignrjGMSZne8CY6PGIE5txrxCS0/hXE8G7iBnYxnLXDivoJdo5WVYY6EmxH8DKv8f0WO36GbOBOpA1PzD69IsFWQ9AnjBAcA3t6+/Cj8BkxODwt6zi0r4SKiUztUgQIyThWcco/AL6d2+rgSg56WVFg/m1gy16YXYGRP2ogZ8vSlb+S+qmOQGzbemA8ppWYf55IQIhPakKNYQsi2Di/1FMjhu0+FvNdLzP5exYydSSsBxMxh+LUsSlw/1luvlgOnBoHt+ochI/Z1Izk83qd8zixyirWEr9NUngj+ETr9l4hlOBOPMLhr2OJkvkSbWiCWC37WL0HiJXmzqsTUrkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtJUyP3MX2Cd2/hdqW+GhnZBNVa722buW6Tj2ECTlPs=;
 b=2/wdMFphvmGJwdijLkAIHPzRXKZGuOoAAJa8nzMxLSmWzgIWObl+Izv1gXDt1gt3TbEF5XnSdUECIu7mgIF4F3W+G7KsW2zEtIcFE1wSa+h+XuQhX+SLpdId0mIiBF5WgDruFmHc/GTs3S1yDANWjlPY3z8Gf3IaO0ttZpCmTlw=
Received: from PH1PEPF00013308.namprd07.prod.outlook.com (2603:10b6:518:1::15)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:23:41 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH1PEPF00013308.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:23:40 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:23:39 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 12/34] PCI/AER: Use guard() in cxl_rch_handle_error_iter()
Date: Wed, 14 Jan 2026 12:20:33 -0600
Message-ID: <20260114182055.46029-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc7a811-dffa-432b-ad47-08de539a0af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nNPtkwW6MCjTw300/leu/9EZWu+JfmJLP7EhYLijxqEteUTBV5Yw5Jx5QvSo?=
 =?us-ascii?Q?ZyCGkUM72MciY9lunXlO/AN2YnNNKfvcS0FItfumrimYXfhpU/2RHS35yBmF?=
 =?us-ascii?Q?zhJLSe36uK5lJ1l88O3xnjw6rwpQ6Unp2i7Bmp9SxWKhLBZtvDufi8fK0Bpe?=
 =?us-ascii?Q?ugj6pbAKpovIkBBKBm2HSmgxKZXzXxN+Fv9SAeFD4efuefJpr3nBoOBkbNZW?=
 =?us-ascii?Q?HdMafB1vM853kUgXZyh5E7HpvN1TP++7sT4vMng5L0fCBBiCoqA582capflu?=
 =?us-ascii?Q?EcMLoUiL1eYz0Qbt3qCQhxgLiaTtVm0eDCabiaIb0da2layzjLp+WkzgU/Fj?=
 =?us-ascii?Q?YEkZ+clYrEi0FXukfd0tRykn08Uf3FRKQOeyZkoCRMofzsj0EbhuHUhqkTV1?=
 =?us-ascii?Q?Im+oKns5rtoKeFhp5PVdHsHWP5qDLYYKXnxmta2SkmeHydXRJBO2LCLRKLbj?=
 =?us-ascii?Q?5Rb245R+CSvu8B73jaKRgPojV2cH5ecosIw/rokqYekwKYV0BFXmRQxYXxb8?=
 =?us-ascii?Q?nROSbDo8+FH+Vrh+lzuCVgLACVRKW6eoI5liUqNb+EVFjw1QW6S5Vpd7eRZK?=
 =?us-ascii?Q?ODxmaqrt+i7bOgGFWE3Q8mwyoQhQy+sCa0kc9L7Ek3uJVURcrJcGgGwGLE3Z?=
 =?us-ascii?Q?Wz1+9Fq3Qk249QvRoqvjyOs6W46Bqe/bs8DuTJMBHQfG3WSvEnYJyGwsIzH9?=
 =?us-ascii?Q?C0AWSe2L9tud3N9lcP+IH77yOGDpYL76DtcObs5bDAn8zc8nHQFxhZGISNv1?=
 =?us-ascii?Q?aapj5jB/eZF1Ee6JBgNrhldEbWyXnE5a13KYyxSIN9M3dJGMcmM5By82yuqB?=
 =?us-ascii?Q?KtbFBrdlSWNgEGMYo0YGHxvl2B/NRLdcbciGYFZc9z2vzohGIeYOs5a5K3Ox?=
 =?us-ascii?Q?006Tcglt2+R9PZdUzT3FfY+gSGnbDOWNwvqBycxKNSc/PSoEBqiSQCERy+iX?=
 =?us-ascii?Q?xHzd4+J5II13U/5EYdBH8TdZNEyE/iQw86ir4pWApqcVWa4NUTh+vD6NSeOv?=
 =?us-ascii?Q?BoeL21K+0nPZ9UoprdWW/OcHggQqpzRxJyKX93MF/zO8dsLuddi6X3mBcicg?=
 =?us-ascii?Q?RgATXBdyKLy+Pzs8oTFm4YJw0X7pmogEfPRAvhRLEXAjV3WsxfHaEMOzQF0t?=
 =?us-ascii?Q?F3HSQq9XmvXsJdiRG0ywBJv2qyyK266OSVD3woPefOcIz1XZZT5vAYy9qq9e?=
 =?us-ascii?Q?RVjEUipfL5O5G9rp7/0J5iV+pjFBTff7XFiAP92ZWSBzE57abXj0drlrMrCR?=
 =?us-ascii?Q?t5sIts8p9AslvXd/xnaC2bauLA4h7yqnModi6Tt+Rh3vOhMOG/k6yROzb06J?=
 =?us-ascii?Q?f2Pxtz1uNL+T5iEaR/7ims4M1iosKWlaF75VjOYpUB8diz6LbCBCNXxzbpI4?=
 =?us-ascii?Q?NEKOHEeF3iqVYmCAGdq9QMEn+rzAaUCWRVO7rrUkmiweqFBD/qb1mR8LbPyI?=
 =?us-ascii?Q?mCYgJDWwwQWBwJ33Fhz4eB4Rr5kdqrJt+UG0B3zKXb4421mxaHJeQsUyBEm1?=
 =?us-ascii?Q?RuXMQfFCF9slKq5F567PqqJlBbM29PXd4zPfCIiWzZm8WdRjdNLt3Vcx0yhQ?=
 =?us-ascii?Q?NoqP/97oYsfafpnepc7CBZW4IzVq5TuX1v1H4VQBOVSIfV6+1OzWJBBasiVW?=
 =?us-ascii?Q?F4b4JnmmF0rUS9tFB0mlhPHC/9Hm8u4UolqJlI8v+eyV7Z9vBQY/r1p7KR46?=
 =?us-ascii?Q?UPxJ5iRKk3LDMTcTvTIR9OfqYmI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:23:40.5921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc7a811-dffa-432b-ad47-08de539a0af0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548

cxl_rch_handle_error_iter() includes a call to device_lock() using a goto
for multiple return paths. Improve readability and maintainability by
using the guard() lock variant.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---

Changes in v13 -> v14:
- Add review-by for Jonathan, Dave Jiang, Dan WIlliams, and Bjorn
- Remove cleanup.h (Jonathan)
- Reverted comment removal (Bjorn)
- Move this patch after pci/pcie/aer_cxl_rch.c creation (Bjorn)

Changes in v12 -> v13:
- New patch
---
 drivers/pci/pcie/aer_cxl_rch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index 6b515edb12c1..e471eefec9c4 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -42,11 +42,11 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	device_lock(&dev->dev);
+	guard(device)(&dev->dev);
 
 	err_handler = dev->driver ? dev->driver->err_handler : NULL;
 	if (!err_handler)
-		goto out;
+		return 0;
 
 	if (info->severity == AER_CORRECTABLE) {
 		if (err_handler->cor_error_detected)
@@ -57,8 +57,6 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 		else if (info->severity == AER_FATAL)
 			err_handler->error_detected(dev, pci_channel_io_frozen);
 	}
-out:
-	device_unlock(&dev->dev);
 	return 0;
 }
 
-- 
2.34.1


