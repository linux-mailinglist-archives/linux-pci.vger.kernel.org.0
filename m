Return-Path: <linux-pci+bounces-8702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C5906388
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7541F236CF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A811369B0;
	Thu, 13 Jun 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="No38GzsA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB213698E;
	Thu, 13 Jun 2024 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257369; cv=fail; b=IaaqqaX4q//2MdKFRd7Il+jI+meWShY90WUy5r/65Qaxo14bo6IzmHu7gG0i6NhZ5lP+KGIyrmYhRa9RWIuAtiEDHKYPUIPCuTMpoIYsu4iPeVimxKm3jId7QsoO6j6VdRWytlxTDi2N1UcoUGO1v97D4sqbmW024bgRvycGytA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257369; c=relaxed/simple;
	bh=Dc7fpULQmfMuKBnCfk95qpC5rQUO319FIEnAwKPpWcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3UvgSj2YVfvNTxhD+cgcqAmFi5fEe71tnHprUO3Xm+4zfct4qHVG9aQVMjVg1VgNIex8sonPqnvxFyl6Z2QEcnIPO3UGlQef/I2GZvB2rqVml61TAEhJHAf7zlCZVOj90C0f1fEsDqW+7xbDHmtsN8lKNG8CzmMFNOPLHxmT3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=No38GzsA; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFP+PrAKN7xlWQvRurmMMbcynz7a+iKZT/4hT7T+8OkDuNVMjlrNSUtO2ukGGFulkUTurciInaqbYDh6InBYH60dbN4VTRCCUAPPEHlhQ//X6vPKtmkc1tUbW0C87wKoh4u6+P6kV/ALqq8jEXRqe4rjMG8cQCa5o9o6MBVZtqs0rkTun3MENqQi0lRTU8+np618h3+5BJVgTg90aPIdLF8fvYIsqbikZZKRNPst7veoDN12jmDnqU8HXyIHjOIQuo/gpPcYGoOnhOyQ3Qeven6/08rYAsTOAaLExNJRVTRgladFMUD4CPrZw7ZwlmFFZwgmkL4dqIqSZQrODvj7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rs8T5c63sm0wncwtwBR0Sq14oq3H/A0RwZOMXr6IlQ=;
 b=NN30fqN+ZKeeIBPfurtXzpMJqCEyNM6N58QVwA5B0PVIyc4j00EGSyEq/5wKUp0Vi0FQFTMii64iAt8yV37169FVMn/tkVBoDt86kFNEXePZkIZ4Y1X2kEq8SEUkMJePLvjeE+WpSbePUsjyJy0MJjW4cfuhMZktlSq8WZF2B9/FbJtSeZA4y1T1dbfyfge/sysrYYMoOqSwNVxft7wNxa3WimjNVNADvQncYscP3UzorCxiHH9t56vPL7NCG4aYxtajSwqesOwGZww1EyMYQh7iWlwM9gnBrCM9VrXzo/uX93/swufeZu+T8e0Qfz8eyqmgzX++RUtW+Ydn9JiuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rs8T5c63sm0wncwtwBR0Sq14oq3H/A0RwZOMXr6IlQ=;
 b=No38GzsAr4l4EZR4yVgNsrlbnM5HyfQLK9UB87pp+8PaAVF1PKXHuSpSolTSHbItDNVbznIRleAiJnPZ5PqYXLtv18Nr/E83pxx5E5xRy3sXDn27mf26H5LCpSCk+mB0XwolmRI7pl68PUAmFjEcNPTS+BXI3E3GO/Od8mtnU+U=
Received: from PH7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:510:339::17)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 05:42:44 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::f1) by PH7PR03CA0025.outlook.office365.com
 (2603:10b6:510:339::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 05:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 05:42:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 00:42:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
	<mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, Daniel Drake <drake@endlessos.org>, Gary Li
	<Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/4] PCI: Check PCI_PM_CTRL in pci_dev_wait()
Date: Thu, 13 Jun 2024 00:42:01 -0500
Message-ID: <20240613054204.5850-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613054204.5850-1-mario.limonciello@amd.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: e21549a5-0634-40bd-d504-08dc8b6ba5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0quFrxkHT24bE2trO7g3ojhZ56/uOp1fDgWVraPZZM6GNa1dImW3U44YcWRE?=
 =?us-ascii?Q?Z+p+8y66joxNKwsnmPbY5Xbwq5msQed6PtCs2iQHmU50eSKkL7OIReLN1SXj?=
 =?us-ascii?Q?uVzE5+WAzM9zATUsC1WxcWf+gnur2YAS1JFrUOXD4fBzJfBROGX3ziYF9L+c?=
 =?us-ascii?Q?zYAiWReqn4DA0WQoLceYmECmTeHkcuTrVdX6t8vxqM7Brxl4POnot4dkQaLZ?=
 =?us-ascii?Q?DLdNiXwSnLdLr3n6CbT8grtrfWIx87cdSj+WzJPkFh+xdgYkfqYkf8zCGHRE?=
 =?us-ascii?Q?gdDK8okOcpDOnn6GZmPzFj90g3skrlHZSZdONMFUQ5nNIpLT7IL3HlLLxDKo?=
 =?us-ascii?Q?ZGwg/klPiNFzR2cO2nNBK7dVHjJ+jrM5le2zNqcvlbLSxs1j+K5L1r9ohYrN?=
 =?us-ascii?Q?5rW8T/S9QIdtvclIT5amycMk0JZ6VXOb1gh4nOQCaC7dET2Lcu4kb3QbEM8n?=
 =?us-ascii?Q?IYgSEr56v7GYKRRvDB0AKyWxJ4r4BoJVg7qIy7jTiAg4CFXuxwaABfoLE08e?=
 =?us-ascii?Q?6wPws36UQbYtCsQ3AXTWIhRip3CEX2cHIxEhHFa8rvu+HLmHfyevf9DQahfk?=
 =?us-ascii?Q?R5jWfDw3EH6AfS+xBp0xZt7KI84sqo/buvpztsqrghBN5rSWoHrBWHtc7VcI?=
 =?us-ascii?Q?AYJCg8S/YqEcAow6pWxL/HPPr1RBGXa63odADHmhtFtn9nHEJBC0lWIeay5W?=
 =?us-ascii?Q?qDCHAhmAAUfVHH/W7KBsP8zc+uuzb+i7nSoLMMEGC0eKvF7o5eDQukawbl8C?=
 =?us-ascii?Q?NRj6PBGeKTX/vexKR3c9M6ChasRssJFS8cq76nmu3iFpux+CstOZsxDntbIO?=
 =?us-ascii?Q?aiqFc3Av2OsF6RUY29sn4CKXoQyntGAUp+zfjWxtJhwslQq8TRbZg2j8EqNF?=
 =?us-ascii?Q?yRzduKmrCgL5V2bV6iJwbwHPr7j3UIeaT1+V27LX+JC/g9NtRl8QblzvsrO4?=
 =?us-ascii?Q?jz1zi+I1EdtR/6+4csiAWO9r6lZR4hgB7Hw07It3iQk1x+TLUR5MsXrNCJ91?=
 =?us-ascii?Q?k/+P3XXNXLPMLcGQy4eh29Lj0Msum+UdjR/NlfSLAulBpn+AK5yXsLa10HTk?=
 =?us-ascii?Q?HuiAN1OFkzTooYTGRbZq/dlYGJBImRy1W8mRu2l5UCERAmMtArUmsDOfTKmO?=
 =?us-ascii?Q?8YvdJrr13TjakY9SbSHqtNkL4eAHOtsY0Mskom5sLg/bBtlzU3gSBQA8ND6r?=
 =?us-ascii?Q?MJfxYpE7nlohsr90f1YAKnH6eb0A7npqVOfio+AV6pClKdnpmYhWfjTDoG99?=
 =?us-ascii?Q?ny9fyzsK0rX7PWce9nLL/pl7C+qMBRW28eiBCHz3aUzhYAgz/9WAt2oJQktt?=
 =?us-ascii?Q?8lyyQhwqrwVz8quFA0hZC07olTPzzQjMc1sTmFLj6+RHX7Jq7JPk7Ad30Btk?=
 =?us-ascii?Q?ZMEYGbmSXAiOFrdx0WRB8HUYYnKFjmpSXL3d0y+evPQ2r8tJgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 05:42:43.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e21549a5-0634-40bd-d504-08dc8b6ba5d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

A device that has gone through a reset may return a value in PCI_COMMAND
but that doesn't mean it's finished transitioning to D0.  On devices that
support power management explicitly check PCI_PM_CTRL to ensure the
transition happened.  Devicees that don't support power management will
continue to use PCI_COMMAND.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59e0949fb079..41961e28a86c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1270,21 +1270,33 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * the read (except when CRS SV is enabled and the read was for the
 	 * Vendor ID; in that case it synthesizes 0x0001 data).
 	 *
-	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
+	 * Wait for the device to return a non-CRS completion.  On devices
+	 * that support PM control read the PM control register to ensure
+	 * the device has transitioned to D0.  On devices that don't support
+	 * PM control, read the command register to instead of Vendor ID so
+	 * we don't have to contend with the CRS SV value.
 	 */
 	for (;;) {
-		u32 id;
 
 		if (pci_dev_is_disconnected(dev)) {
 			pci_dbg(dev, "disconnected; not waiting\n");
 			return -ENOTTY;
 		}
 
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
-		if (!PCI_POSSIBLE_ERROR(id))
-			break;
+		if (dev->pm_cap) {
+			u16 pmcsr;
+
+			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
+			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
+				break;
+		} else {
+			u32 id;
+
+			pci_read_config_dword(dev, PCI_COMMAND, &id);
+			if (!PCI_POSSIBLE_ERROR(id))
+				break;
+		}
 
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-- 
2.43.0


