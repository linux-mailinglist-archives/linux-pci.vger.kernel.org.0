Return-Path: <linux-pci+bounces-21963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26EAA3EBE8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 05:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77873ABB6A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1521FA16B;
	Fri, 21 Feb 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGw2CtPx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFC1D7E4C;
	Fri, 21 Feb 2025 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112803; cv=fail; b=cHLWRVFEsQ/cFFJO9/UdTiRly87c7H+j92bBJyKoDZsc8anKZsHQQBTnMZ290y6ksDzaImPO1B+KoztN/yCRNL60Dau605q6yRcVDWfYICDcAaS7X5PR1EY7FjECEuiHcsvbV89jjdaA8bIRdUHLNzJL/MU0YQBG86m5kN5P5aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112803; c=relaxed/simple;
	bh=FoQxGyDo6BOA9tlk6p+eOkZfajsQGbXByIcVCxxFWnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km6UjGaBopK3n4AvbygzTeQZJhk7fDq+aV20JYfD/7LQNg2uWSNVyEgbp7e0FBTXU1hT6Vs3vPDs9TxFGhDL5UZbakNt2zv0Kh+eXJJUdryUyQg2iN34ye//URXLLhlSkcqjqUbhax7I83KAmxdb12sSt26xrprcq/9cxw/wmIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGw2CtPx; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lciJ+peFKHIdfQRJd0p7+R31QAMDUG8HDC1OBZch+vmZFKFa+CswwtEocOQD+1IJJkrF3Ks0HR/LBteoBeym7H2Y9LGuiZyQ4MUEJVN6C2UxGKyJbHbWHgg15NYtTI7RcJHM9ma59+VZLQCD2vRtm+2jStRNxtyZFj8FAK9fdXRUljbmXwRVAhTi7S1KUOtL/7ijyNdbPf866RAZjuRHTU3rfc82Pi5axNqTOzhu422M/E4sx8YevlNyTqWisIaPDNQG+yLvkMNxCV/r3TTst0PjL9jFY23n/Vc5XFwnbtxZBCuySe/5d9mmJkK3eAbuDGeCzFtEriNO3u28RAKRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN/9tcwKy3GATCsCTWLdbGvpgCX8QNsVYSKLW+Iux58=;
 b=xzXkicUtACyFXYdE87Hon7o2p2udyvEOr+9S6K3+4RgaiDtn40CZ4ZJ7qgc9ehTpBnq6IsIj0Qa/MJiLj7IBgXF3c6UPhiJL3VLUAAQOdldGTJFX4boxVEIrDn4rQAJGT5luTZjXyHjrM24u8O0rL5TjvZe+KGh9oapFHmnzf3XIxbFJLx1tGB+ZEroysCCnqBh4/Jjp4c9O95F24Un3M2tdzJyBKPmiPMKAa7QC4jcB+LNomuPSSpZwHK+2uERQnnMp7s8FVByPQy0oHf4wQvDurSBufKiYTO4ofXWSjnEcKCvIuzMco8dvkB4U0tsh7b7Fepf5S+smVt2ExUylBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN/9tcwKy3GATCsCTWLdbGvpgCX8QNsVYSKLW+Iux58=;
 b=aGw2CtPx+7d3x+0oI1l1u8IO2G3qSgFrS6syaAdyTZICR13uduldt/KUEAUcqUJ7fHZB27CFQ50FQsG8QCPPJ2rE8DbAr5AOsF8f/BwhdKCDOaw7FMsFoXf4ZejAhVb9qJAODkKO4mNpMmYcNt33cWQCxsvSF2AFNFSZ4v5OXEmilTyZyrVuiKM0B0CtDTDGi0C+Y2eEh3A31E2OGMTfe4z7euf0FCd80+S+12Xtcu+TSck91cv0QowyhixFV83SX+D79YYV2IjvS3h+ZFxqg5ImJf3uLfeXWyeNQjPd9vewrWtbrAa4tUD10F/d/0iOM3yw/izdcMmUjHE7/WMHMw==
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 04:39:53 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::27) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Fri,
 21 Feb 2025 04:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 04:39:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 20:39:38 -0800
Received: from 181d492-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 20:39:38 -0800
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, <linux-cxl@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/2] cxl: de-duplicate cxl DVSEC reg defines
Date: Thu, 20 Feb 2025 20:39:05 -0800
Message-ID: <20250221043906.1593189-2-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221043906.1593189-1-smadhavan@nvidia.com>
References: <20250221043906.1593189-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4a6aae-6ac3-4152-65b6-08dd5231c8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bmxeg4vvfhf+6Uk5RM/sjpN3ZTHnsnWNYIFNTx20OALLc4Zdlcbgran7s3cI?=
 =?us-ascii?Q?WKGgPAZAfzApIs1yxZTj+wZDFgvYAiVk5eo2/nebbKiXNbLu/+HqLDmvnGdL?=
 =?us-ascii?Q?HJ8EmkrkRdasXAxW4W3WVfLjQyXdHhjaVrNiRmXsYa3vM3Mc7HXW04Int2iW?=
 =?us-ascii?Q?0IBSVbsN53MTDUPKtfGk0wOz2m2FYTpYax06De7nsdwCG2+8+KwAy/XGy7t0?=
 =?us-ascii?Q?z4YCPmtN3uQbhwKJKQOivC2X5VMdY/iXM3a8RTO62/Hvdfy4e0rpUUMMAg3k?=
 =?us-ascii?Q?ltimSlpsVj20MkKyC8QHksumbPvcw7+d/y4efG59+OpOn9azv0gDVIv/zEFG?=
 =?us-ascii?Q?cIpmjbiMk1fzYH147Mxt6/1EBPcXkvBA8IutLJhy8e7q0bo259j1ukBs3aod?=
 =?us-ascii?Q?yGbV9ragkBDKh24K+ZBU/JKQpabMz7qW2hofboPlChQI9yBk5HPHNSbirbu3?=
 =?us-ascii?Q?Uh2+anFIQlXwb8wwH+qdcWyX7j6Q8b+Lp46fhyPhtgRrmeMRFaRkCKh4VfnB?=
 =?us-ascii?Q?4z2Vo9bWEfHSGP5ZcaotnbPkAlvDkkZkL2nQ1FA93Sk2UR3dOGORzr4sZEcx?=
 =?us-ascii?Q?+czgn7QVNTZdbTVxos/h5o/HKrvousq6WqFiTNZTa4albly7ql0RYaMmUB96?=
 =?us-ascii?Q?TIghVczG5yVn/aNIeiSTwmdiLj9vJebrUlla7AUhVKx5qpkZGKw5tSq6Kb4J?=
 =?us-ascii?Q?pl8DkQetZb/Rjw7TbdRbWg8t9WK4rhWu71O9BVO4BsZRNHDDEOrn/PxKIrMH?=
 =?us-ascii?Q?dUZAppuEdhXUMphl/LJMhfA/njPBX/nK136lOQt8FRUGHh5H9mKC/JTrH6Sk?=
 =?us-ascii?Q?YYUlXpioeDXKjYOigh3PWNxrCXwKosxcb0hp2RyLCg/ZsR3CMIJrKgAZDYCI?=
 =?us-ascii?Q?R6nIs8jsEJUIaNIH4mlqmpzBjS4wtF1stMkCXgLgGFGzKoVvWP0UTytKi0S2?=
 =?us-ascii?Q?yV1VVfs1+ZjHxc+KDTeft8rOxEgOSW69NpKZTZxHPCHmf411dFLDucDfsijS?=
 =?us-ascii?Q?5LgBgCjKDv24caGA5iJp48IQMfprh2d9TUs/5C9yJcPw42g+g5IY2068C2QD?=
 =?us-ascii?Q?ZzIJC+MKTFJjG4xb5k4IDbLI4dpqdlsEnUxt0zoXJWK4s5ck79tzPse2sqfH?=
 =?us-ascii?Q?i6vuFMA4QXO1rU4lHL0i2cghmizDWYiYN1zUiW8AcxiRpGbxYyJcs06kNEjT?=
 =?us-ascii?Q?bPjhDcZh8/duKxqheiA0ZXnCfkEmIElWJO2K+1zc+0wSTuNLtgWSQMRgDFFZ?=
 =?us-ascii?Q?uUFLw7JYbhzk/8DtegqlgFsAg9Cu+s6ud0BwKdOwm6xH6Hn/xzhrBcGD5CvE?=
 =?us-ascii?Q?lmcpgm4XUltgX/hZHJ8Qsx0MwznShTy4mi1mxwAw7QbepWn8yn5cKUVP3o2Q?=
 =?us-ascii?Q?OaCrVQbvCAEpdp84+ImDejh2jOU3POOdqNGn3dy/qNVehpsZ2b2RWkBuTmub?=
 =?us-ascii?Q?5Em/ui1CbgPsjYavcnYUhDKHcxnexcVcugWpBXHeA3j0B8Xk36hQ9rJxiG2w?=
 =?us-ascii?Q?t26kBlufltBSbbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 04:39:53.1385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4a6aae-6ac3-4152-65b6-08dd5231c8ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093

There are two set of CXL DVSEC register defines in
uapi/linux/pci_regs.h as PCI_DVSEC_CXL* and in cxl/cxlpci.h as
CXL_DVSEC_*.

Consolidate the defines under include/cxl/ accessible by both
pci core and cxl. Also fix any references to the deprecated copy
of these defines.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c        |  1 +
 drivers/cxl/core/regs.c       |  1 +
 drivers/cxl/cxlpci.h          | 53 ------------------------------
 drivers/cxl/pci.c             |  1 +
 drivers/pci/pci.c             | 17 +++++-----
 include/cxl/pci.h             | 62 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  5 ---
 7 files changed, 74 insertions(+), 66 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..afa2c85fc6fd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/pci.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 117c2e94c761..58a942a4946c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 54e219b0049e..24c06eca8a68 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,59 +7,6 @@
 
 #define CXL_MEMORY_PROGIF	0x10
 
-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
-#define CXL_DVSEC_RANGE_MAX		2
-
-/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP					2
-
-/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT_EXTENSIONS				3
-
-/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF					4
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
-
-/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF					5
-
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
-
-/* CXL 2.0 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR					8
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
-#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
-#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
-
 /*
  * NOTE: Currently all the functions which are enabled for CXL require their
  * vectors to be in the first 16.  Use this as the default max.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2c943a4de0a..1f802b7cd65d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -12,6 +12,7 @@
 #include <linux/aer.h>
 #include <linux/io.h>
 #include <cxl/mailbox.h>
+#include <cxl/pci.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..3ab1871ecf8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -30,6 +30,7 @@
 #include <asm/dma.h>
 #include <linux/aer.h>
 #include <linux/bitfield.h>
+#include <cxl/pci.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5029,7 +5030,7 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
-					 PCI_DVSEC_CXL_PORT);
+					 CXL_DVSEC_PORT_EXTENSIONS);
 }
 
 static bool cxl_sbr_masked(struct pci_dev *dev)
@@ -5041,7 +5042,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	if (!dvsec)
 		return false;
 
-	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CTL, &reg);
 	if (rc || PCI_POSSIBLE_ERROR(reg))
 		return false;
 
@@ -5050,7 +5051,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	 * bit in Bridge Control has no effect.  When 1, the Port generates
 	 * hot reset when the SBR bit is set to 1.
 	 */
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
+	if (reg & CXL_DVSEC_UNMASK_SBR)
 		return false;
 
 	return true;
@@ -5095,22 +5096,22 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	rc = pci_read_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL, &reg);
 	if (rc)
 		return -ENOTTY;
 
-	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
+	if (reg & CXL_DVSEC_UNMASK_SBR) {
 		val = reg;
 	} else {
-		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		val = reg | CXL_DVSEC_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
 				      val);
 	}
 
 	rc = pci_reset_bus_function(dev, probe);
 
 	if (reg != val)
-		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CTL,
 				      reg);
 
 	return rc;
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..3977425ec477
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_ACCEL_PCI_H
+#define __CXL_ACCEL_PCI_H
+
+/*
+ * See section 8.1 Configuration Space Registers in the CXL 2.0
+ * Specification. Names are taken straight from the specification with "CXL" and
+ * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
+ */
+#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#define CXL_DVSEC_RANGE_MAX		2
+
+/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
+#define CXL_DVSEC_FUNCTION_MAP					2
+
+/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
+#define CXL_DVSEC_PORT_EXTENSIONS				3
+#define   CXL_DVSEC_PORT_CTL			0xC
+#define     CXL_DVSEC_UNMASK_SBR		BIT(0)
+
+/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
+#define CXL_DVSEC_PORT_GPF					4
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
+
+/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
+#define CXL_DVSEC_DEVICE_GPF					5
+
+/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+
+/* CXL 2.0 8.1.9: Register Locator DVSEC */
+#define CXL_DVSEC_REG_LOCATOR					8
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
+#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
+#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
+#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
+
+#endif
\ No newline at end of file
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..02844c20c527 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1208,9 +1208,4 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-
 #endif /* LINUX_PCI_REGS_H */
-- 
2.25.1


