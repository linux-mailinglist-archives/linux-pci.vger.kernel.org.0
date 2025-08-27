Return-Path: <linux-pci+bounces-34819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFAB3770A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571EB7C3F25
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7DA1FDE31;
	Wed, 27 Aug 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xH6paSZg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80251F8747;
	Wed, 27 Aug 2025 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258576; cv=fail; b=PTA2oiF7DT3AE6nQyKyAJjRwQBe3CxHZytOnphGKjTQM/SaXtM8VPsMZkTp/zwGGM6ybiyHC8zVrNYP+x4edc4KPmQiSxFpKVesQJKF9AOAzQ5fjro+Mke5bd3XZ6hRezCLp/WkuHCOyxN6GQNABXy3y5DeUzuVB3ShiPotWw44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258576; c=relaxed/simple;
	bh=TEhmvsb607cohboULhRKjD84Jh/ie+ccPcWk6oYNMqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtXwxlCfujknDkGLg4bpe159hNSIvffEqPCbPcKDhTOxCPh0Ui+XL+AxI4fyJNe6FABfn+hko71ZdJu4W5DUaZjIAvc46qqWNmDXTWywyli/RyqbJNG1OKVEOnKlL2YiZQDlgKRAreSV8cRDkO6Bfln+VqavaK+81ZbtlZdd6x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xH6paSZg; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFrYOakG7kTfweJrtYIhYLTl7DnoCjePJlhH+WCDMRJxoatxN4zlQ0ZX0TJKfca8/162Knm3g84ABotOECgiNGQnv5S+v/4y2dnVUysI0CiNGycFtwC+Yz/zbHJUEGYwpIZCMQllpXqKx+kRO1ynwtMS01BNtJe+zXuvsS4C4gJ5QHVihiLTK8mihgPGeAnQlI+Usc7JAC4yLftUxmyq3K+5YOLT/SCo8zFk0iYiCJdhG7e95skNgIjx74heawE84D32BFrywhLTiTwnR0ycfRkJ8At0G85UROdjvo4ye+Bq58DUkJ3VdDr9WfK62XzRXRA8KdpfR+OUVdCGh1kufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x6bC01g7GTnsd55Digg57hoAxIgt/us4X41B5j4Z1g=;
 b=w0t1NsQ+d92LVXLFtL6QIKMGrFQK5P77DRXwm7JsoFNEaVsibRRighY0gO+pJMhvxsJIPUjitDSoFnqIQ/30RYuKms6R6IEAz7UvHO0t6rVkq3Rxa4H6YLpQ+AacfWhIgr/YPTVOx88I8juNtxD3q1QLBl8Z8VhiF9lgjOcaMMKtXmpYCk6UUBZa2KW/JLSSntekEYPdur9Y52q1/LeR3PKmaHyiSEWXsWPf6TaPdOAXy9dkE9SomBibiMzsOvsrQ71fM8uRgHtFjLGoluImPs4Ww7HSM6iZOxh/YJUnBVLnLExrKadtU8ZUwXPOCATk+0x2PuzroOyzyvwkarwGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x6bC01g7GTnsd55Digg57hoAxIgt/us4X41B5j4Z1g=;
 b=xH6paSZgbBUnoVR/ioBeeTEZVMcGM1dtYbAHz4MuzBDcQBgNc/ibU5r6oGvGGPnZo/Hzhv0p3v8DOQ2wNyB/+qSOLRraUZDpB7+q7KFD48mUEZuOeqUOIlaIh5WylDy3DlgzUBiBse1UwB8z0UtaBlkKsVRGIWkVeW9afUy38CE=
Received: from SJ0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:2c0::23)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 01:36:08 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ed) by SJ0PR13CA0018.outlook.office365.com
 (2603:10b6:a03:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 01:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 01:36:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 20:36:06 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 02/23] CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
Date: Tue, 26 Aug 2025 20:35:17 -0500
Message-ID: <20250827013539.903682-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.51.0.rc2.21.ge5ab6b3e5a
In-Reply-To: <20250827013539.903682-1-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf547ee-3428-42cc-76e4-08dde50a1888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PIiUXO8XvWr8rp9SwFEm6jS2cTsAvFUtAYd5vkQAunGgemVIKb+nKBlLru9M?=
 =?us-ascii?Q?XypvJKLkZc12jVBTd5sTg6YDT9P3Lplgdg0AHqZ4tTElDKqJj8ahheipEhxF?=
 =?us-ascii?Q?yPefN+vcTZge9BevLdxa42Zfk3m95obscrkUzEQjO0+C7UprIUQalC47ie1T?=
 =?us-ascii?Q?QmnLSTS4ipGINaHb27Pl3BYKhd7w1tthMAPWbpHVKTomW+YHDO/OlAN5t+HX?=
 =?us-ascii?Q?8+2lD1cmagxjEM7NxK+bXesSN8oS5AIDwfR1npAt34RG2H+Mz1wZ4QjoIVfX?=
 =?us-ascii?Q?2FlsjOZyXsIF/dxy3HQHY5WTOWRiubNXMeeYgL6ffSmNhehb9/yGhSnh1gDk?=
 =?us-ascii?Q?xvGGhOjM6CDkhkhR8pFBKI3OCil/VFxbrP5ExW6BlKIBVFIVW88dWqoTOIVV?=
 =?us-ascii?Q?SHg/DwMdU7LphDOJHKfYBnaRPN3zaoK0AVL3zN7OJDapxJODWpzHoSuj5D9q?=
 =?us-ascii?Q?xFw7KzxlfhQhryiMSz7ZVlamA2kml4Yf9uunhEi4+g2Ubu9avvahrY2TheX4?=
 =?us-ascii?Q?PulOWlT+f9+idutAqVobquA0VTz3XudwfJSQIpbYKvgWZcoL6D6N8Ah7qdlk?=
 =?us-ascii?Q?Zsn6SP/wxe9eym+kwjPxO1d4jDz+dIxfvO+I0twM6gOOliAqUpzO4JixLPPX?=
 =?us-ascii?Q?TyKZzwxFXIUpzXo+XxzSD3wXqHU2YLIE35A91Yny32Ekk+jPjHs2fbjIa69y?=
 =?us-ascii?Q?rSkiCfk614f4Uk+gNqdvu/N0cS/tj4R6jvfSiBhflmccHpsMP30UkXY6+MSJ?=
 =?us-ascii?Q?mDqd5xZcYwFTbAlfXEQRlx2q7o2nEDlN8T0VBZv387I/1CbeoO6BKioGXKue?=
 =?us-ascii?Q?MFFk31I4AMRWQMOYwL53d3Yx3m5lTgth2JdHVL1JPdtjV7Qjjkxsw5XRvwpv?=
 =?us-ascii?Q?mCERuATGIzL/EvkuNnlakM6JNILikOWc+XvXhBhtx2SjJiVx8KSkYsQIB2WJ?=
 =?us-ascii?Q?yebEjQTDZp2drFZaa6twRwjEr5fWsCxlsr0nOX+5+FGvnFkYqsqhPSzuZ/TC?=
 =?us-ascii?Q?V0P8Qu+DVvuGJquuYWExkGSUHLIP3NWzLw6QC88mIp7/lxW8yhJZVV9giCPK?=
 =?us-ascii?Q?a0Em4OfwGU5V4AdWu3wLt8OF09cdH6AgeM1jV/oauc9PhQiWWKZVWJyPAu7K?=
 =?us-ascii?Q?YPse0gYB6ABUzpymtnV9zamVW54BKhKUNzn9waXl57WScS89Nc74pYMQu/II?=
 =?us-ascii?Q?AA19GKiKt6hhZ7PfPAtAKdIPb7H98qwxU9WLqT/0GeAHGPHUE1ldo+RJpAXT?=
 =?us-ascii?Q?MbJT6g/2YPS4u3FXxSrEq25lSOihq32GmGeftVeeSLoJRPYR6ViLLZdUCSb5?=
 =?us-ascii?Q?wcxtr4Fvh7V1Zb8ifxfbqMhjsgPKHDTKRuLwMdxIWx0/ObiNGgJwntdXAiHU?=
 =?us-ascii?Q?N/001aM7Lsoz3iki/bRDPAPwGmq1wzuNchISYKoDjGahmTURnWA0/UxHv1yD?=
 =?us-ascii?Q?nmtURlab2tOHkDUgo7zIDDKLIkjZ571j9fx9XL1U+N4DvhFtcEWFM0ouuz3l?=
 =?us-ascii?Q?81Ipqm+5CHJtHGUEJVueW7MZ+meN3n6LL2AUvWPKPDVNvnroX0psCmlBgg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:36:07.9154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf547ee-3428-42cc-76e4-08dde50a1888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

CXL RAS compilation is enabled using CONFIG_CXL_RAS while the AER CXL logic
uses CONFIG_PCIEAER_CXL. The 2 share the same dependencies and can be
combined. The 2 kernel configs are unnecessary and are problematic for the
user because of the duplication. Replace occurrences of CONFIG_PCIEAER_CXL
to be CONFIG_CXL_RAS.

Update the CONFIG_CXL_RAS Kconfig definition to include dependencies 'PCIEAER
&& CXL_PCI' taken from the CONFIG_PCIEAER_CXL definition.

Remove the Kconfig CONFIG_PCIEAER_CXL definition.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---
Changes in v10 -> v11:
- New patch
---
 drivers/pci/pcie/Kconfig | 9 ---------
 drivers/pci/pcie/aer.c   | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..207c2deae35f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -49,15 +49,6 @@ config PCIEAER_INJECT
 	  gotten from:
 	     https://github.com/intel/aer-inject.git
 
-config PCIEAER_CXL
-	bool "PCI Express CXL RAS support"
-	default y
-	depends on PCIEAER && CXL_PCI
-	help
-	  Enables CXL error handling.
-
-	  If unsure, say Y.
-
 #
 # PCI Express ECRC
 #
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac66188367..7fe9f883f5c5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1086,7 +1086,7 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
+#ifdef CONFIG_CXL_RAS
 
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
-- 
2.51.0.rc2.21.ge5ab6b3e5a


