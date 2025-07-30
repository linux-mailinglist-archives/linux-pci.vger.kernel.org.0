Return-Path: <linux-pci+bounces-33208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6341CB16880
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 23:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E3170ABA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252702222D8;
	Wed, 30 Jul 2025 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jtm2Uhiv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06E13D246;
	Wed, 30 Jul 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912122; cv=fail; b=kuF7BhSjSt60k86Kr64s2F5KA1StJ07h3zeGSn+CyyyksFsHJIvocfKlxffkpyyKg08eCnyBGc9Iu69HEfYSYDxjtA0YJIzYD3UX6yZ6fgGU32e2b0wAeSkfIBD/J+amXEObcJLgNZEbmeR0aJYnXkxiAuMGcRSfgawqAWVxXrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912122; c=relaxed/simple;
	bh=vJJuI8qlxqRXISCvRTdd5owh5hDSlF7cxMLY6VgnIoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQvD/fvwvyMPOvRghuBFJwoxh9YN2I1kR7jRNuVEHmXHLJCGrXkVOlAObWGC/j1jkFGiMxDacakF2mAHgf02YEF40EEko081P9yZdln/bNgdqirBLCy0B1Ly1jgfCkJ4dQSM+mEJXz+sBAF6UD/nBBJbo07k/KnvLKJXGLGazfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jtm2Uhiv; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKTrIst9Xe/S0RuQYENypD+ATdYK05+Bxl0SqFJqCTYkGsaLlGyL0eNkrfOgZWWu488lf8eVzv7bs3vBdgY/xOjoy9zstAlVwmnRIfRAHLwGjCsGTN8KOY9O+eE9tr39cSHQ2U3yLGeTPDbDplB3+3uDU8S5H09IQIVwmOGYyXxrV+ZtqDl6P8Gbls8j9wQkZeazbO6xSfFedn4BTxkdZ4TWiv0LYSG9uK00Ngjoa2u+LRJQ9wyvB93B2lv5dSYPHnZT134Xx+q/wDjydlrpn9HyQamTCQOc895RLnXcihgmlZMT7tA1jO3TkI5+GA8L8xQjqnBOWvB7+6bIXgWPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r76PmnDf5NxIh+YyK3CAyrYFwd2UPmlEm1axAvSfzU=;
 b=KaMnsX3vislsGhG/ER5IewHS7UFO78z+F2khBzfFOGaNwiFTRg/394M9PuNWr8P7k3AwGJpTzLKG2BPPZjY5dnWW3yFh/Tv3/XeF5MdLBzOZ8jk7z2pkvvEEsvwYq+SGpkwapdGOwyJvfwN0Gvkfla9OpG8rzKoxWTiRWKhD3B1n/th0gZyqUzeCuybIRI7kRcyX6r+AIiaZHMjMrpl5MNXllEa6N0D9x9J+c3tyQBM3j9DSm3ieHGYD4uzf1UipGQ8NID/gZw3oF4SXot3uI9lIa3KKZJqy/vf4qwv4K6trV8JccQj4JicvwcfzgMk7uN8r8yebbnaL7bnv/3CM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r76PmnDf5NxIh+YyK3CAyrYFwd2UPmlEm1axAvSfzU=;
 b=Jtm2UhivzfBFnf+82UdHZe60m8at9V0siYnbyL8pq/0rIT6aCa/LHaAqoygOxnZ11x6UP8oEHm0v71rYk5i5raao3Dhl5hDTSBnfAiEKaxQgfCz+TlcjX8GJl6/X2zXIaXIOIhCcaz7g4d9kSEU63s3vCS/jfdGCVtPOm2Z+HO0=
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.27; Wed, 30 Jul 2025 21:48:35 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com (2603:10b6:207:18::4)
 by BL0PR0102CA0014.outlook.office365.com (2603:10b6:207:18::27) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.8989.11 via Frontend Transport; Wed, 30 Jul 2025 21:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 21:48:34 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 16:48:34 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 04/16] PCI: PCIe portdrv: Allocate CXL isolation MSI/-X vector
Date: Wed, 30 Jul 2025 16:47:06 -0500
Message-ID: <20250730214718.10679-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c2fe3c-ca82-4b21-3654-08ddcfb2d571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UouuPZ4M1Xtv5LFxI+shFimcXZvmFZI1FUVwbSU80SNPPle12cCDdsgdCOU?=
 =?us-ascii?Q?echPIajaEQWVJQLbE/WGS5OlFOA/zNCNbNYZLdwjXP6sRFdMnBwEGbrYwOQw?=
 =?us-ascii?Q?7OS1b9chPuDMaGuQUyA0YeIPyHa2XMqDfB/KQg/sL0CbOz//eZoRGWBz/Bil?=
 =?us-ascii?Q?U4ouEr5cv6y6uD6NuNLEz60ptHa/1jTzH6JZ06wQwSIncQ8DqIYPVGVQ4eyU?=
 =?us-ascii?Q?xeeIAFUBLoAKixuVSIjqRLR+uD7NW0d3NWcjYdZzh/zwI2lW5x8xsimWG8nq?=
 =?us-ascii?Q?OLbZBTA8wv8PWraHpcXDy1dUh1Ux9oATrZp+cF3qaJMk18if5a1hEEr7S1IW?=
 =?us-ascii?Q?+AuzqsH7eRhpU/sLmqg3YeZQigOi9YIQmEUEh9SMMkABz1P3Z7v+kwl3gOIx?=
 =?us-ascii?Q?VEidgwmdjLDeTnzY18cSG35uaaE/yIgV5YdmUbHhJPfy8VvN7WzgrGWkuMwP?=
 =?us-ascii?Q?2aq7tTXK6cZ/Uqn2rgl+nLQesvcF/Vc5Y5nEmMMdk7rdwNkJrr3o/7dPkl+r?=
 =?us-ascii?Q?LV2iEFoVA3WOpseZ1WOqpY8jTSvWTH3QIqQmLEwx/atr9zqKM2l11G0MUKfG?=
 =?us-ascii?Q?uRJ9eCPFGzDoNY+UL8IF3xr2gYv3Fmuar0SEGOqV4MiSo3adhKVrad+MDM/d?=
 =?us-ascii?Q?Wl6FXgRNafa3lUyXopNDL18m7D/L/k2Fl+p6+jBDkyYnNY0I7fAyUBHTmZz9?=
 =?us-ascii?Q?07qrIfGp5Iu4jyD/MGzN4WJcgsjx67QvZZ85EUJs1WOwVBTf9wbfrbSmFL15?=
 =?us-ascii?Q?7SlcwK+5q3+zuR3hQEuInEGQNk7Va/Mo/k+x5cjOw6QmxHBiu7U2IT2fpld1?=
 =?us-ascii?Q?vlMAv318fIg0W/ChuqHT5sWQM7e/XDV+Y4H9/gjZy08XxVi57NjxFawBljEh?=
 =?us-ascii?Q?WfsGKJHTuR/makqQey/OXmQ+eS8EXnI6+QZZCdQM4/uwWs/EnEWewHhRCka2?=
 =?us-ascii?Q?dxto52pF+tfmeMaQcgVhkGloNTZJkPgHYFuDuPE1+3DMNb0LA+TPgohCemeV?=
 =?us-ascii?Q?HgZgP2jf8lqmhqqTJGn6YLNUYzCVuGp5SJPO/5X23zJRR5C06JI5IXC6oknu?=
 =?us-ascii?Q?X4nSwmqZChg+FJ7W2Z2SGoIsQQVpDoQ0TBDcPhN8lEE0+3zZjUGqGrS4/fVx?=
 =?us-ascii?Q?z7PzZW7ppAkygPwjpwGT2qeLZaDzLxhDtMhArCzDkRJMN6FPon6WZh5064UB?=
 =?us-ascii?Q?yxUsm779ZbKIhuHZ6QTeUsCsvB6iARu45+BiUowvCxiAGGY0PWcAvPWa7mcm?=
 =?us-ascii?Q?Wrm6KF3+/qPnIJ7p0vPX1x2C+EZ0m3hoPbZf09d8955mYZKjrDxLVeiGokSx?=
 =?us-ascii?Q?B04SKZUiKBiaYZKi1XlGGamf8M98E9pmTvnUboO6nR4YuFuCZLSgJsw9RynM?=
 =?us-ascii?Q?5GYAEFh21MU+YHLcK3ZvofTUq5CCB/yxAovezsMoQofOV5wILfA7wjvYa+Uu?=
 =?us-ascii?Q?KztjMuozDbWao1HQtQ5ms5q0renfOZIHWCM/GV0cxxyAIXQpzgF2RilR7hAZ?=
 =?us-ascii?Q?BB8BYV+/ltHJYysg23YDVoKfdACF3zNNP0vm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 21:48:34.8128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c2fe3c-ca82-4b21-3654-08ddcfb2d571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

Update the PCIe portdrv MSI/-X vector allocation code to include the CXL
isolation service.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/pci/pcie/portdrv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 465d1aec4ca6..6119e2e25ad2 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -50,12 +50,12 @@ static void release_pcie_device(struct device *dev)
 }
 
 /*
- * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
+ * Fill in *pme, *aer, *dpc, *iso with the relevant Interrupt Message Numbers if
  * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
  * required to accommodate the largest Message Number.
  */
 static int pcie_message_numbers(struct pci_dev *dev, int mask,
-				u32 *pme, u32 *aer, u32 *dpc)
+				u32 *pme, u32 *aer, u32 *dpc, u32 *iso)
 {
 	u32 nvec = 0, pos;
 	u16 reg16;
@@ -98,6 +98,11 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		}
 	}
 
+	if (mask & PCIE_PORT_SERVICE_CXLISO) {
+		if (pcie_cxliso_get_intr_vec(dev, iso) == 0)
+			nvec = max(nvec, *iso + 1);
+	}
+
 	return nvec;
 }
 
@@ -113,7 +118,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, nvec, pcie_irq;
-	u32 pme = 0, aer = 0, dpc = 0;
+	u32 pme = 0, aer = 0, dpc = 0, iso = 0;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
@@ -122,7 +127,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		return nr_entries;
 
 	/* See how many and which Interrupt Message Numbers we actually use */
-	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
+	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc, &iso);
 	if (nvec > nr_entries) {
 		pci_free_irq_vectors(dev);
 		return -EIO;
@@ -163,6 +168,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (mask & PCIE_PORT_SERVICE_DPC)
 		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
 
+	if (mask & PCIE_PORT_SERVICE_CXLISO)
+		irqs[PCIE_PORT_SERVICE_CXLISO_SHIFT] = pci_irq_vector(dev, iso);
+
 	return 0;
 }
 
@@ -278,6 +286,10 @@ static int get_port_device_capability(struct pci_dev *dev)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pcie_cxliso_get_intr_vec(dev, NULL) == 0)
+			services |= PCIE_PORT_SERVICE_CXLISO;
+
 	return services;
 }
 
-- 
2.34.1


