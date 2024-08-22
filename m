Return-Path: <linux-pci+bounces-12044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFB95BFC1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA1B238E9
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD651D1743;
	Thu, 22 Aug 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="31TPXwDu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76201D1741;
	Thu, 22 Aug 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359351; cv=fail; b=aYnYC2ixzrGjPki62a0tzg6kRqXNpNedHVMAa2NCKZbv1+J9IciCA4aGBZm0W8UAGQjDwrvHZLH4ZCJbzPA+lVFKAT8+h3F/PXopeSVsaX0e1zhDJxtHVfaUcMK/f9eeHmHbS1xXM1CB/W/Ah7v0GQ/KPefIPezuXaW6FsHcSOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359351; c=relaxed/simple;
	bh=ZQ1lbGBYgAY3im2GAU/D5xjSsCLcdKfecUkc6Qc84FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g16QMbA53mP/YDPolg6YKDsK2yW51A+oNJiFLIFDI7Al2qtaT6Xybn+HUgf044rw5kMi+oqV3xxk8wOz9/xV1fBtpW7MFISy48KYGsejaKlvJPTGHjd2piLEFbFxKilZ365y4s2xvzn+H810N2WtqIGVWoC7G+6ViYb5NR0Jpas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=31TPXwDu; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf8TIHvZGTTLlAwr2/UFcDgMTwMv9wbRZXqQP2WhVz+IG3vSQyYiEhIW/rys7Ze40oE/KQiNJZ7KmHmtNlDtzDfm8PHEYeORvTlmPrjiLCfiHEyH/EMU3ASvoRYfYU7evhaJSHcP7N4PR04F5LHpR+MhiNt16s7VGurzVv92/Gc7bStsR3+v53/IFn8ovry4HNgLkHkLqwnF2ql9O5G9UEMawmMz18G639G1OBZibwVZ5ZnDSo3687xywrZcBVOPcIjTB7RVp9uexb7WdrxunClftwVhSlzhJAzSd/FiNlm1bf+RPugIUueL41Nho/882uu2AiWlgdx6n3MOtE8lSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAHFzz0oA9pHF5G9HIzmwSA3nadkB10mjeoLQtmmgo0=;
 b=Gjt43X+i6LaO8Y/lwVJmcLEqMlLx6XJ6ou17vSSZY4b6DqTgRcaukgXlS7/ZDq2CeiS5d6gOBeLbAd0lMRtnhz8moQlnGaZlFOuRJNfdHX/QoAXSwX+nYxcN0hWFEmToh5PC9vB9AjdlRvj6CnZLlUA4Gb7UJnPrud6ixiUXKqpW0/zLIoueaIJvv7Lvz6xTbwC/vz22WyECNQInlbiWxos0aeFeftQtGmluCeG9vgR1hb/Tw8SgK2ZcXvCuo1aevGB40nOOA3kG4tqses7+vy+Q1MzjWTT+h/IYq4TmNjH/w7DkIQQwBVS1iQEsQhK/CdI4TznjsLtHuHzLTNvHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAHFzz0oA9pHF5G9HIzmwSA3nadkB10mjeoLQtmmgo0=;
 b=31TPXwDu8mSMQ8041nO0L88SkYffntxMHvhMLC4CUABdHc25o34cS37HpA+hX8CIm5jMC/z2ysdNze3sU7m1FZK02iZXgeX4a/kntQaaeVANn/j23WjZSCQTrWs7AJ//zA+Na88EZiT9pqRYf6A3/bese8jypgKr7hYE/WR0SV8=
Received: from BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:42:26 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::d6) by BYAPR03CA0017.outlook.office365.com
 (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:42:25 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:42:24 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 05/12] PCI/TPH: Add pcie_disable_tph() to disable TPH
Date: Thu, 22 Aug 2024 15:41:13 -0500
Message-ID: <20240822204120.3634-6-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bda0eec-2827-4b04-6087-08dcc2eaee8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LRWL3iuNW/YqeUDxa4czB/eWqYJhf8pvx4gbyc4KZIRscwduvxGqC1keEdO9?=
 =?us-ascii?Q?jFRIluHV/5BQ7jcY88hIgCiXTcQxd/24iUmWg5u5W1ZUunDfiC9Fx+NDNwfb?=
 =?us-ascii?Q?ZndVPbOTipFxXH3pBFKKHcnRo1oxURce/YBenAHqaWwi1N4nzNoeSLaFoNUw?=
 =?us-ascii?Q?soY4Pu1pTzUMCv1zxbRjp5M6ZB2u/aI9eZVrikQf+uL10D3aB2+0mc2FlD8g?=
 =?us-ascii?Q?dcdjrCYrOk+/yMcMWzj5gET4cZqnXt+yMhoIKwt80odclUYcuBeQPV+NK9Gf?=
 =?us-ascii?Q?sJF31pB3c6G6ayHKAG1lNNJD4gX5tAyJIxTYq/vokSDpfjkeOj2VifLusLUo?=
 =?us-ascii?Q?w+RogdDVjr8tgUucp1C/K2YzUUSHDG+X/q+wlIwzwyOxIpkfnAxnXBo0bSZ+?=
 =?us-ascii?Q?VedaUi0kJnQDOQcIQ0AUXqD9kfSkgf1Zc54ucyGJGcfvQZXQoS+qRmPanPWV?=
 =?us-ascii?Q?UoUleQ6MZFL3Fi++/yyRo3YoP4Yupm13oOnvKVdDMAUnQUXC0sUXUb7CRhSz?=
 =?us-ascii?Q?zV95UQQWw8VzX4CV6hVjqMVuvLIGbvpdd9+GQO3v4CLfWDMqbEFI8ZcX84bD?=
 =?us-ascii?Q?Al6RdjL9jajIoC+f3h9TABAVWWXfm3bPHeHvCjKsVOmWFS40a6R2R6JWZL4B?=
 =?us-ascii?Q?uf+YPY85nzi/tRz6p2D0XAhxqdhCdrpCJ2rRSsF+r1LfIIMhz/R5axVaKdcE?=
 =?us-ascii?Q?qyCpMtuEI6YtI+3wAka7hncaeERYLIihGShi1mndIw6/zgC2+wJw+I1Vwy6U?=
 =?us-ascii?Q?8s9w4yuXxqym3AyIQ7IIyIlKJ9IBQ4CiG70Sc2buFDgRbh21AguXP7Y+7OQ9?=
 =?us-ascii?Q?kZtpyK13VTE23Uult3eAvue6M+to2nS/gvb0tH7zPSNrdhQ58UhKVd036Ofi?=
 =?us-ascii?Q?TgGAEb2ctrED+vLIBO5eRB0IZk4BwQ23I1E3P3ABtZG2OJ01QHxNI93WbcNS?=
 =?us-ascii?Q?H8o1W0jHMCPSfu+MHaHeSXhp/TDJiuk7dI7YFGMh97p9XO7IfGxq2SQ5YlkB?=
 =?us-ascii?Q?IhlriD8n3bzwMwf8vhLY0qypcm/4rP/iH6HlOu0gfq3GxA6TIwyB5MsRIfxl?=
 =?us-ascii?Q?+s0okJCkOgO6stR5AXaljrR4eIHCKT4w+UvvdbMDfwMAm4B8xRKMr+jceeU1?=
 =?us-ascii?Q?/8umdHsXpoz/i8LsQwaQh8wSh1vVukl+26VUyyBG5e75y7NYzmFaMGy5x2r8?=
 =?us-ascii?Q?ppVFC2ZXL4uGfz13H6YHqJ7iwd2WNnnhHcD69gyBQLK6pl1I066pFK8nu8/D?=
 =?us-ascii?Q?hiEgQCjdW7Sjruo27UWUs9hvktd+EXDrVe8xEwpxRqTFKuQIoXsJ9UKmJtip?=
 =?us-ascii?Q?1wmRWscuU1JtdSrhIqatXt9oJKeh52rfTJzLF4/Gj/AUlNsTYBZorBKlOtQr?=
 =?us-ascii?Q?QeCvzOuYxkS6pTrYUpMO4xfa9XnLV0eKaP3NlgrinoNhOffLiEWA0DwHno7c?=
 =?us-ascii?Q?tDk1arLt8WUuVFAHh6UdaHoyFHl4zAPb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:42:25.8714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda0eec-2827-4b04-6087-08dcc2eaee8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

Turn off TPH support for a device and clean all related states.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 22 ++++++++++++++++++++++
 include/linux/pci-tph.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 14ad8c5e895c..08ce4fdeb160 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -40,6 +40,28 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
+/**
+ * pcie_disable_tph - Turn off TPH support for device
+ * @pdev: PCI device
+ *
+ * Return: none
+ */
+void pcie_disable_tph(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);
+
+	pdev->tph_mode = 0;
+	pdev->tph_req_type = 0;
+	pdev->tph_enabled = 0;
+}
+EXPORT_SYMBOL(pcie_disable_tph);
+
 /**
  * pcie_enable_tph - Enable TPH support for device using a specific ST mode
  * @pdev: PCI device
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index cdf561076484..422d395ade68 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -10,9 +10,11 @@
 #define LINUX_PCI_TPH_H
 
 #ifdef CONFIG_PCIE_TPH
+void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 int pcie_tph_modes(struct pci_dev *pdev);
 #else
+static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
 static inline int pcie_tph_modes(struct pci_dev *pdev) { return 0; }
-- 
2.45.1


