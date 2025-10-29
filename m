Return-Path: <linux-pci+bounces-39613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA4C18E29
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891DC1C61AE1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D25314A9F;
	Wed, 29 Oct 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GR26Y+FF"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azhn15010055.outbound.protection.outlook.com [52.102.136.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB031353A;
	Wed, 29 Oct 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725153; cv=fail; b=UlCeE/nX4qqmZvPd/fKpUGHOz2RBU0fg0iFxs22deps8v1NvQ6t7Ro1RgQRitmMjNxtD2bBvBuVrneH/enLto86P1OeLNV39sMiVWtOSRefHGCszNaTgU0vb4p3ZRTTxy6msqv9lonHN0Fp/+/RdlzZn0sZFtGrFKMmD45B0roA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725153; c=relaxed/simple;
	bh=BGSnz3fxcRyE69v7ZEQ0XTYMrSifd4aYstzCSNL0OUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cHJu9BfTwnFU1SNVveiZEi0rBYUZuQjL316866hPtXcUhSmY8c86DduxJaZtSbxrLE5AWivyFlGRcQMKT4H2dHe4f5oEeyLq0lPM61fYwNUjRp+MsGkvU+og0Kb2E3VqQ+skjJFK2jfAbzDv8iG5J9qu/E9dtIRTSqbttqikTdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GR26Y+FF; arc=fail smtp.client-ip=52.102.136.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbws/4SOzMo1kAhqGCkXq0+vrQ1maBEBUwka57Q4WgrS9lDcN2OaUgWFF9zz0vN8iEyCi3B7JjXP9XePBQ67lagF1zYL/6e1kg8W4TjrrNXRgOREePOYM+h0ryAN/5BZW3VhKnx3VVza/TQ0AunK6eYLdx6QDc/QYBcULrzJdTjiUWJDR+Eq/sjQHmeiQsrlM2t9576V+yi93SqdqbUPEknH+PylRB7Jpufh/klbuznVB/xeI+FcY7kMkPyYfT0hfRkb2i6trbmMwyi/2A5MSlWBge2aO+qib2raTIMT9+g1OUaraKQ+jFJGNF3xf/Cy/37ER7vDCagjqzZo5E1kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Tg8KB+oWP39584Biu85pITgu4AS7WxhSTTBatYleUs=;
 b=giGKd9uFJtcpmYF3KhGqVMuLZQVj/9TZsZ3Zy5xCZ0Ln5/0JCUBMDuPvpKhCuSl57TVv2GiHNAGjcXm9BCr4R06mMt/0Jrx3g7fz8ckxxmJbn7OaTdvpSzFwj0W8XnpksopC3h+E8yBT9O6QmPIZ0vu9O8eW7sw9UQxBQJiEAs/vpO2udkuSi+aTDQuXUsA32Cxi+udiqWGnS0E3T0IrXFDqHnwPvc5VfmW5v8tRtExg04zqYg95CLjSfa1RqHyhlH7ZZ/exI++3qqMDJ3PnuZrR6feHZohKF7acdZMcB8rQHC/4AwTncmBIhZFMpThq3tnllmx99eTbkRZINmt3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tg8KB+oWP39584Biu85pITgu4AS7WxhSTTBatYleUs=;
 b=GR26Y+FFzV7FOd3A3pQYmCy32zYoAIr7keyoE3IyTX8rx/h2ocrc2PzJUGXVPAYtyhyuWIrXwixmeLQRhEa2wzoB42Uq1KaOmEcci7FvXZkNq3YzRmrfok1U8+pvirTiUs2zPzZMEscX/HQtGql6brgWs0MIKyMwnSgBqVqb/0A=
Received: from CH2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:610:54::31)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:05:46 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::80) by CH2PR11CA0021.outlook.office365.com
 (2603:10b6:610:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:05:45 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:05:43 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:05:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:05:42 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T85aXe3704660;
	Wed, 29 Oct 2025 03:05:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<christian.bruel@foss.st.com>, <krishna.chundru@oss.qualcomm.com>,
	<qiang.yu@oss.qualcomm.com>, <shradha.t@samsung.com>,
	<thippeswamy.havalige@amd.com>, <inochiama@gmail.com>, <fan.ni@samsung.com>,
	<cassel@kernel.org>, <kishon@kernel.org>, <18255117159@163.com>,
	<rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 0/4] PCI: Keystone: Enable loadable module support
Date: Wed, 29 Oct 2025 13:34:48 +0530
Message-ID: <20251029080547.1253757-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d40094-5b79-48f6-d65f-08de16c1f697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|34020700016|36860700013|82310400026|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aMrZFZV1loZspd1E+uMirt2ZNDib5sLI22+N3LWWVaiE5OThCIAcWNjlfD+p?=
 =?us-ascii?Q?wqGk6Tlokm3a2Cs/OH4ajQ+/rSMF+WvdbFRaKU2ClQll4BBfrMsBkYY6EtNN?=
 =?us-ascii?Q?gVxl7EDzaUj0cOhyqZMsE2jp2ZK5qT1R0RgPBPf22TbLzquRfxi1BsMbxt/O?=
 =?us-ascii?Q?gJPqPw2n7qigF1FiuH2BEk/KhpIRgSXntyz7qYMj1aOr9rSAz50aA5a1oYsl?=
 =?us-ascii?Q?uBDR25sl0WksR2T8eiK9fDqZeOWmm1Ihfs4DUWF6pcp04Y80WYmv0mczwd87?=
 =?us-ascii?Q?ibFCJJmGNPmckB88vFRZq5hGSGfTI1t3iEXK/8IAsR9PI1nvU9+TWKjmvClo?=
 =?us-ascii?Q?tYpEX3e4Bn/lpVOpKhfF18sQlO56CDgKGiBQJInLkTZQmx1+A7g8Yskhu2Hu?=
 =?us-ascii?Q?scXoEo4uIlywtSKiLAbcjYiTEXiT3bRZN6nm655a7XTehSNT7PTyGq1EFlFP?=
 =?us-ascii?Q?wA3TT0fbEUrUzv2dral3j6jzKN9fvIwvRummsA/BU0PUVaHsNXKGK0M8/tmt?=
 =?us-ascii?Q?H9hV15PEq5S2IYzmq9zSi/mqxniWN80Te3XPoAhWuQNRciP/6EDKaJ2aSJ93?=
 =?us-ascii?Q?Skfc7WUyfDebe/kslnpOCOHR1lPQOx5Dwb/Hi7DYAhCUQ+EawRibghKyijH9?=
 =?us-ascii?Q?v9CNw101ZjeCOz/dUuta++XTig53pY+m7wo2qAPY8hAfn1n6LCzGUTQpGVlW?=
 =?us-ascii?Q?b7rG5ynHOqLBpmDzjeMGrvxfbCNA7Y+Pjdj79ux5USwbZsrQnnIcEGlQNX+7?=
 =?us-ascii?Q?J5pz0S4TrTI7qzozNYVXyz4tHECkj7y1ue71X1FATSsuVfHz0eIJQbtCpOnC?=
 =?us-ascii?Q?9vIZ04XMkAHJru++YThai4EUWwhixl3sL1r+ftS/tCUIDm8SwRQVlBKL6W9u?=
 =?us-ascii?Q?SrowKO3RdIiIvsZb3PudE1GewY4SwDes6tgSc3jQh7EmVO/j/1R7kmVzdWuH?=
 =?us-ascii?Q?BRKY8A3JSJZHtrFBCdcKhIANdyZrMSdY+Z3IqgNYYwTez72cq2kZu06OyKkt?=
 =?us-ascii?Q?UzNK7GbpQlCQEN4EeHZaI2Q8is7PhW9GWErNRZj9nML3F0vRbdciEDFYM8Z7?=
 =?us-ascii?Q?sS8yfR9p2JXgAnYEM5lj7EqTJUsF0BVGvWl8hnO0vtPwi7SyPeOTalskSBz6?=
 =?us-ascii?Q?bz4FPgF11uJwIisfriPZun72RdGw/gcy/woVk4jsjV9kS6czJt70hJbYFVTj?=
 =?us-ascii?Q?6P3Q7Y7xGwJIGGFsi/k1TmFkxUMajHWdbR7p6fXpHfpzQvSPBRP9N6HMqM0/?=
 =?us-ascii?Q?M/trMNLQrrPzsjxyfC1KdgFSMR3Cu2nSDPTG1HkUF+2Vh81fqUlODhm8/5GO?=
 =?us-ascii?Q?7R0rfzB7LABL2l1MA/PiqUS5bKW7xLnFFsMYV41nLGbSnmFejILG7WMpQ2Tu?=
 =?us-ascii?Q?69kcdFLzrYmNCpgh/HcCaVh7Jb5Kw2Um4QX0gfqToVhPwQE2TuOekX75BAZx?=
 =?us-ascii?Q?b/xRflaZUSOr4FzaBebjZvCBUOI3BOJCFOeBnnM/nBDPHa5QfLrooCKhF8DV?=
 =?us-ascii?Q?ZxRcXdLusztaBovP5gxUohFUTB7tKQ8PRE4w?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(34020700016)(36860700013)(82310400026)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:05:45.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d40094-5b79-48f6-d65f-08de16c1f697
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695

Hello,

This series enables support for the 'pci-keystone.c' driver to be built
as a loadable module. The motivation for the series is that PCIe is not
a necessity for booting Linux due to which the 'pci-keystone.c' driver
does not need to be built-in.

Series is based on 6.18-rc1 tag of Mainline Linux.

This series has __NO__ dependencies.

v4:
https://lore.kernel.org/r/20251022095724.997218-1-s-vadapalli@ti.com/
Changes since v4:
- To fix the build error on ARM32 platforms as reported at:
  https://lore.kernel.org/r/202510281008.jw19XuyP-lkp@intel.com/
  patch 4 in the series has been updated by introducing a new config
  named "PCI_KEYSTONE_TRISTATE" which allows building the driver as
  a loadable module. Additionally, this newly introduced config can
  be enabled only for non-ARM32 platforms. As a result, ARM32 platforms
  continue using the existing PCI_KEYSTONE config which is a bool, while
  ARM64 platforms can use PCI_KEYSTONE_TRISTATE which is a tristate, and
  can optionally enabled loadable module support being enabled by this
  series.

Series has been compile tested with W=1 for ARM32 using
arm-none-linux-gnueabihf-gcc

Series has been tested for functionality on an ARM64 platform (AM65 SoC):
AM654-EVM with an NVMe SSD connected to the PCIe Connector of the EVM.
Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/474a16037d990206e1d22399a93dfee7

Regards,
Siddharth.

Siddharth Vadapalli (4):
  PCI: Export pci_get_host_bridge_device() for use by pci-keystone
  PCI: dwc: Export dw_pcie_allocate_domains() and
    dw_pcie_ep_raise_msix_irq()
  PCI: keystone: Exit ks_pcie_probe() for invalid mode
  PCI: keystone: Add support to build as a loadable module

 drivers/pci/controller/dwc/Kconfig            | 15 +++-
 drivers/pci/controller/dwc/Makefile           |  3 +
 drivers/pci/controller/dwc/pci-keystone.c     | 80 +++++++++++--------
 .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
 .../pci/controller/dwc/pcie-designware-host.c |  1 +
 drivers/pci/host-bridge.c                     |  1 +
 include/linux/pci.h                           |  1 +
 7 files changed, 65 insertions(+), 37 deletions(-)

-- 
2.51.0


