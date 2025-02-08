Return-Path: <linux-pci+bounces-21009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6191CA2D248
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 01:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF4188565D
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C3149C69;
	Sat,  8 Feb 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQhUy9YI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95170167DAC;
	Sat,  8 Feb 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974785; cv=fail; b=VIdbMV+OayP0Y5L0P7zjCCrTB5+nPM7p/vytk4oV2e+CYX8n0AB92EqKbuN4cTl2bFJw/0gEvoadGkvJgar+Ad4laMJYkN1ML4hHuKK0IlGkYj9tIfQvK/lAW1llkmO37UZup92lpBdGRIXQHeKxrmml5VJVfJg5Hy6d3tLCybM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974785; c=relaxed/simple;
	bh=Aq3BkqPNtvSEur7bOEGQmsnfFOr5ktBOntDpwAZf2KQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlidQniboLNT+CGTMVhI1qaPkv2z9O2cXB+ktXicxqtZGQzCmV7JTM2DnI+SclvjystH8LzXdinoJKfEKnZdVtIVmBZfnz1J+tp12duGo9o1RcVF9PVdlIDWs7JjWG+8ZjjRUx+PPDVJNKJLI18XniFRT357JJ3skLvX/5IxRcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQhUy9YI; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjWf4R7yPObIixVYDxgycl2+WvQDHlb+m4tp7urvmEEDuIISGmlJNq5uuXKJ87uaNmbDajKKTETewFbt0z/a03E0DG7w3PyE00cmvOuNAvXAimqioza+3su1aP1ze4PUFoCwn6+P9JymbVYSUfhf8GfYSv6HAloIkKFjdyS8lxwHxhOH8k6uflhnhU5kixyW2NtsiUW+PoU5Sre5aAFSfZMwLOmGhsuJaGR7kaHnZ1WqijWklbZ2NUVsUsVB8INwlJOQKq3ehRuRuPTX1we8LxxrFGyeY/rdQJgDttjgu9ad0Uvz45Q9VQZKYX7EQ8FIqSIDmCfaVge9otL6iGXqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxR+/ODf3/oK9gzl/LZvS+5LMHzG2wPJOC6UlAGn4Sw=;
 b=rH30ay5GCnbM6+APj0OTl4cVqtFd5YSz0zjgYTY6eh+mB6J5zoSprV38438E7agqVCohEwkhXwd4Th9Efj3X8wM/WL/jLSRwURAsv6uOx+u0w7vxOE/n6G9a02NBZKsDIg3msQ+WgQfNuxaGt66t4N9zEn7b1COpI/7WwsNweRsP7cJ7MqtXpYjGwtVPPb/PRHX83VD7Ralhz6zqWh4+5STwzRuM43LDV4L2ZYAOkmOZ1vx4iOK1oLgqtYhiqfUjxLlhuSJY5VkRpHnifo5E/MKADnteFB1cSbBWUfJ7zCyJ1p5066UJLLLf/J0e6QGILFW2B1YPQY8Uz8bPshJfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxR+/ODf3/oK9gzl/LZvS+5LMHzG2wPJOC6UlAGn4Sw=;
 b=iQhUy9YIR6sbGlNgoRIxgFcJkB2EP1bjn7wat0uTVGFcFWVcL0/0vWm4NzcglCWkOUZLfwVeFAid72aHZlNNysdPHRrxLIEjH45lawD4Hjiuw+bNk6Kb5UXB5fNSr9rMa4KzwbY5rgEtlKH4gbu9DP9Iipd65d5XSiWrt2qk1jQ=
Received: from SJ0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:a03:39c::27)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 00:32:59 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4) by SJ0PR03CA0352.outlook.office365.com
 (2603:10b6:a03:39c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Sat,
 8 Feb 2025 00:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 8 Feb 2025 00:32:58 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 18:32:56 -0600
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
Subject: [PATCH v6 17/17] cxl/pci: Handle CXL Endpoint and RCH protocol errors separately from PCIe errors
Date: Fri, 7 Feb 2025 18:29:41 -0600
Message-ID: <20250208002941.4135321-18-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208002941.4135321-1-terry.bowman@amd.com>
References: <20250208002941.4135321-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b44729-8082-424f-bc27-08dd47d82323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8hNQ0nRoNsw7VSTOzGL3LkOiZxcZ+xg+aoWT19g7g9BdRL7yGs/fkt557nq?=
 =?us-ascii?Q?mz2Vbgjn31lzAi2Q67czJYCY4aciLhW7q33k/TlxyDHK44tzCHlOvSLNtCP/?=
 =?us-ascii?Q?q/w3KU/T9dbMeM63at2Nr40YOUoVlkn5H2m12zrPn2sAqm7Ii2gpO/ZRfwzU?=
 =?us-ascii?Q?2MxXA2NyMfhF2WsWnih7qYhs3OVDMjx8yt699JJ5Xe8b+p/pYc4adCxTOuQF?=
 =?us-ascii?Q?Ej/nVhwEI/oE+Sz7Lb3B4WKf+/X3A0ulsQimAMRWFV7ZEY9XmxEg44gXTHDX?=
 =?us-ascii?Q?nAuIY3Xc1+8R4fMcK5kzYWN+zIVsdYwoYr59i0Xm4CjG9JRRI9jvmLZrl7Ni?=
 =?us-ascii?Q?bPTT853dVshRZuvCjePvMzLniF7XiDkINQt7wc7mp9MWmdi/mDZfkan/BpG+?=
 =?us-ascii?Q?4vnoGaT3HA4/zkCXOhuMCBlUuX1+MUGDC2YOU15bowegaT8AjWSbWoZko/LF?=
 =?us-ascii?Q?QJh4trCP+8dq038JF0k1fwe20tULaAxEN9csKeP7hdwey891hpZxnMyseiWM?=
 =?us-ascii?Q?hMaGXHbYF56kgWXHQYLdKxj/PLXQy4ftsvaqPrM85hy1F23d1veVcNzNkFIU?=
 =?us-ascii?Q?1HoRfUYAFGTjY4skUyK6a/vruGfCwZAWtRjott2piz1ZRmTXGFg2otzDIM9Q?=
 =?us-ascii?Q?SFJzQiYXmuP+XEIm/nfwU2SlRrVcuLbYvqJBF7CDHjXVZIHHZEtc0+t9TW+Z?=
 =?us-ascii?Q?/VNLC9I7X1ZZvRY+6lA4CFuCzkSZqOZVYmU9crRE6dw7KnKadc1gblObIaC5?=
 =?us-ascii?Q?LhnhwftjdFMN31IGhFzuazg1LF18pe24C7lzFc0a6/swZE0S8ryPje3Z5pvV?=
 =?us-ascii?Q?K97r2cLISIoGxChn1RCeRY4jwmpGaq5be8q+WvOoHZ2Vaed89beuMSUBv8dg?=
 =?us-ascii?Q?nYBun1GW9fPwD2pX/NcKjw1XPXIIILmIYzbO1vsiKO2DrvSUVL0BKwd+6yK4?=
 =?us-ascii?Q?z65rW1+XJMdGWYGYRi6n9zklF7hLieQZgpcabynLsiawPSxqxU9Tq+GRmWTO?=
 =?us-ascii?Q?0qbXiUWCEbYMGKe3zpVI9UsFOtithedl9YGl0svQJ5hQcVreMlCGwfnprvRX?=
 =?us-ascii?Q?Kgn150xJXt9Nir13owlXVyqg1xI0nzbJ7/xLUUzD72Iwx7QPLouR1Vr4iGgz?=
 =?us-ascii?Q?W/CvXGAd5zy5Lvo8aNI92elObHCjM03eCLpS2d/gguJK7YTpny4TurxK3FTQ?=
 =?us-ascii?Q?Q+3i/SUciG8jGoEsLdOkQZuxs4ii30ZE7rp/AbkHXXJ80MWQfwDsvKA1ibK/?=
 =?us-ascii?Q?aeYzgyf4Goi1AZxXS02cseTn4k4aB21XOjKYSFYnd7hh+85QiiFZaR7Pfqph?=
 =?us-ascii?Q?FsEpEk0cY2ztEtDZuFce/sYzgp1lVesWawflN5KquhctnBGxoFaxRgTc7hqS?=
 =?us-ascii?Q?3T4jPXG2IFLNDbgwtucTqkcNLCFUoi7mBmoYVo9dy9uDvEVdAl6oH7HO+VFo?=
 =?us-ascii?Q?FdLOz3ulqMLk70OGtjS7vN6IDVWMKRqW6eJ67txHt6MymDAdn5C78rngMp+Y?=
 =?us-ascii?Q?SYJ0qv52F6NQIxnd95K2fzLvX1cuJwNp77iC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:32:58.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b44729-8082-424f-bc27-08dd47d82323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

CXL Endpoint and Restricted CXL host (RCH) Downstream Port Protocol Errors
are currently treated as PCIe errors, which does not properly process CXL
uncorrectable (UCE) errors. When a CXL device encounters an uncorrectable
protocol error, the system should panic to prevent potential CXL memory
corruption.

Treat CXL Endpoint protocol errors as CXL errors. This requires updates in
the CXL and AER drivers.

Update the CXL Endpoint driver with a new declaration for struct
cxl_error_handlers named cxl_ep_error_handlers. Move the existing CE and
UCE handler assignments from cxl_error_handlers to the new
cxl_ep_error_handlers. Remove the 'state' parameter from the UCE handler
interface because it is not used in CXL recovery.

Update the AER driver to associate CXL Protocol errors with CXL error
handling. Change detection in handles_cxl_errors() from using
pcie_is_cxl_port() to instead use pcie_is_cxl().

Update AER driver to use CXL handlers for RCH handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/pci.c | 26 +++++---------------------
 drivers/cxl/cxlpci.h   |  3 +--
 drivers/cxl/pci.c      | 10 +++++++---
 drivers/pci/pcie/aer.c | 11 ++++++-----
 4 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 36e686a31045..18d47a14959e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1075,8 +1075,7 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+pci_ers_result_t cxl_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	struct cxl_memdev *cxlmd = cxlds->cxlmd;
@@ -1088,7 +1087,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 			dev_warn(&pdev->dev,
 				 "%s: memdev disabled, abort error handling\n",
 				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
+			return PCI_ERS_RESULT_PANIC;
 		}
 
 		if (cxlds->rcd)
@@ -1102,26 +1101,11 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		ue = cxl_handle_endpoint_ras(cxlds);
 	}
 
-
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
+	if (ue) {
 		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
+		return PCI_ERS_RESULT_PANIC;
 	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..4b8910d934d5 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -133,6 +133,5 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+pci_ers_result_t cxl_error_detected(struct pci_dev *pdev);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2c943a4de0a..520570741402 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1104,11 +1104,14 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
+static const struct cxl_error_handlers cxl_ep_error_handlers = {
 	.error_detected	= cxl_error_detected,
+	.cor_error_detected = cxl_cor_error_detected,
+};
+
+static const struct pci_error_handlers pcie_ep_error_handlers = {
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
@@ -1116,7 +1119,8 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pcie_ep_error_handlers,
+	.cxl_err_handler	= &cxl_ep_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8e3a60411610..07c888fd4c08 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -993,7 +993,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *err_handler;
 
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
@@ -1001,7 +1001,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	/* protect dev->driver */
 	device_lock(&dev->dev);
 
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	err_handler = dev->driver ? dev->driver->cxl_err_handler : NULL;
+
 	if (!err_handler)
 		goto out;
 
@@ -1010,9 +1011,9 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 			err_handler->cor_error_detected(dev);
 	} else if (err_handler->error_detected) {
 		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
+			err_handler->error_detected(dev);
 		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
+			err_handler->error_detected(dev);
 
 		cxl_do_recovery(dev);
 	}
@@ -1070,7 +1071,7 @@ static bool handles_cxl_errors(struct pci_dev *dev)
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
 	else
-		handles_cxl = pcie_is_cxl_port(dev);
+		handles_cxl = pcie_is_cxl(dev);
 
 	return handles_cxl;
 }
-- 
2.34.1


