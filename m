Return-Path: <linux-pci+bounces-8703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258890638A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D186A284251
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49296136E38;
	Thu, 13 Jun 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nBlHpOnf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D741369A5;
	Thu, 13 Jun 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257370; cv=fail; b=JlDBeAEC9YYuEoifDfPaSVXntEGtLVyVqS/aYxEblvcIKpgqSySw+0m9utmMgC65cIZNQI7F+6gjalLISVflEZf0646Cn+tFrdObzgLbo6FsPclCRuneCdmHLfS95LvqNWNcEveDy8f83JYEQbyGRi8HCeAwTc5URfhONdKYZcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257370; c=relaxed/simple;
	bh=pRVjKIJGALJ6M5iK/kB6RyzC6HZmWUj2WFH25gwfIVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/mITFj9bEbaAnHFDQAJbl16Lc0mR8usz6D/bQFSg4UkwMHO8kII/0isHEELnweR3YfiZX7U+ruH91uWeSyEygaUg8uZp18ef2aLG+FkoXjvPm+QuH/nM5lOoI91ZrkN25DGTgSiV82fJ3Gx0ysUCYDxpttW2j/Th5vUkOpcklk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nBlHpOnf; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDXjPm1mWuUVcqfhfhwUyb4QuBud5Pg1dmX3AR1ya1daIeJ2YxEQANQDuquFpWZWsrmAGR0mtw7Lxa/9hmaR0NJRg53Ln0V0O+zYxLyIjuTIJQIMQIm9v0nbtFHYDEDqrRvcOlDmJUOvAE3cjMLMDK4BlrdMD8scd6T2YEWdta+zLDIALJwJY+Arg+p7qc7W43j6+sbQ4ku2WB6buRdhos8kW08F1PUpPsp5Ogx77I+MML5TKLXJ49+Sh7d+ra6YgTM3pL6OYxrBmFjAvs2Jgq3+Vz7zfm9LQ2SHW3NX9X6M6qoN9dfT4FvQRSIMZ6ahBxesUfrakDZ1E4GRiGOWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vn1vebuzNfIWvPy14bk9ZTF1ZTEtYT1OoAf+ZclpxM=;
 b=NJlEnggldpGijJHE1jmfkgqpmrMiGQkWahiVWsnVU1f+W6CShg/nCI+d1zEZmEY5Ergz6QD/1Fisj5J9cQ+zuNsgn8LQi9lXHaxiSfZYeI7phMKCWT4T2z4FXgfymL1sDu0i2QE4j2XKpj1OtU1SnR01gcP3mD5PWoUGOPZ310Lu9IyMH3rJ2fgIJkNRY0QxmSUD0barBAv38fKgve40R9cPP9pqnGfZuCkW5dsPIbrjitLe5YR7BzQKKlYSVMNEyZiReH4pEinOjHUy8+xpfETK2pL3LW8K1+BwZxH/LPBU8lWY3mjM9LEHdnutjA0OOa4xKGSVXw5LPjZHnPrHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vn1vebuzNfIWvPy14bk9ZTF1ZTEtYT1OoAf+ZclpxM=;
 b=nBlHpOnfGdOtU8zKy/uPozzmxJbgXlnzvt1aKRsjlCi0/ZxZEJ6ZNpLmTFy7/nyg6lHl+7OSxZHWqQGqgebAroNMPyK9jS0PE8vZkkyQhWiCW1TRRPyBc1lqlQdiJxHNZyb933TbY2RnTOMx6SNl+++2pInFuVPWVe65QyI5/sE=
Received: from PH7PR03CA0012.namprd03.prod.outlook.com (2603:10b6:510:339::24)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 05:42:45 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::e3) by PH7PR03CA0012.outlook.office365.com
 (2603:10b6:510:339::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 05:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 05:42:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 00:42:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
	<mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, Daniel Drake <drake@endlessos.org>, Gary Li
	<Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/4] PCI: Verify functions currently in D3cold have entered D0
Date: Thu, 13 Jun 2024 00:42:02 -0500
Message-ID: <20240613054204.5850-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb381eb-3c59-433b-2d97-08dc8b6ba6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Adp1qeqc2zYztbwR0ajh+vcqaK64/2K+HYUAo4b30UR54mvoYgVGTpcX5RMk?=
 =?us-ascii?Q?4kEbwP7u7cZ8WlsV5MqrGXLSR/2XnBGa9wHN28TuELCe5SmN6cOK7xV4Fthe?=
 =?us-ascii?Q?koMklei6IRRJu8B7njG9svMfiFaX7V4M290c6R0tmlQFf6alrffc/7mzZdZA?=
 =?us-ascii?Q?BaHm7tKrK0PNnOnVwCThRPKEg8tppYda4U/1sJZfi4vo5JkAtnQMhCTfzGWw?=
 =?us-ascii?Q?UmRwsoNSXbO3zXpa4SQNqFExgCuK9y9Q2q/IzIhB4Le+3RP6xMc8X7HkRov6?=
 =?us-ascii?Q?hDN+zYBZAMBvEr0bjNCJScScVoZOYFuSUfsP+fX4u3UjAhrM8DnQwqE42yVK?=
 =?us-ascii?Q?9RAYuUJb7Y0uD8/LH/eOY9+aCjbb9C9GPLVFuipgVHjRKPhqRKKMNJ4XUMIc?=
 =?us-ascii?Q?VDu6D0hUEZa0h1ziLkIEPiACYTj6fl0V1Eewf9ja/HUjKrnseh/oDJiNeI0S?=
 =?us-ascii?Q?vJF2lkspBPJEjmCHXwbs8QZmkHBROjxl/cUx+GfanLa7dqzewHPy6eyNifRH?=
 =?us-ascii?Q?1g1nyR0dPir5XsV/5wNBkciiXwlga5zm1L+80cSXQLcMMYMcNQcsY2fbEimg?=
 =?us-ascii?Q?zt7ZYr6bpcLvFJW+LQBCNjArWkuGLXpHAp0RwHt60oNw6qzowqDucitX65Tw?=
 =?us-ascii?Q?CoaICkGlh4IXdmu23bOJHcxd6OHawOwMDsGk0kyK36SsFfSiHdOHL9f9q95A?=
 =?us-ascii?Q?9rJ5G4jMQM6RuFx09JC15W9YJ8einLiZxiS/7+Q6O62YV4Py36UC3Bq4VyyA?=
 =?us-ascii?Q?JJ31WYaAsj51vC6iS1HVGrNSnVnGu/0Ix0TKPtT7BEQW/tgZa20JYQAguF6R?=
 =?us-ascii?Q?IHJw89rFOY4Uh3RUJjpdXLfnD6AQd9ovk7HYgi93FrJsK8HUpxUS7pSlkKsm?=
 =?us-ascii?Q?2FfPJnkwgfmbHOheS1V0J5XEnhF46u67QrG2WvA+JVdllzyYhIkTpKy3KzuX?=
 =?us-ascii?Q?odMkP7O+6QKaP2JzFFZFZZbsy4f7tHVTskTPdZiAC5OtZN3bNsyxc2GpnHW5?=
 =?us-ascii?Q?6QYYP7LLX0kIXE5Lo3887OkcaTvf5rBVE23o6m2Vibi0KOjPwxk2UzLj4rBa?=
 =?us-ascii?Q?dRuCtG7yWGWvhUhvsVdt3J/owCmqJ7XbxeUE/U2+MPvp4v/yLcT/NuNHsbTI?=
 =?us-ascii?Q?CwrdiH524hCpmFHkcfMSCqgxQo9fTKaYpnRdJ3sztyDFLXdJVaU2VQVoewbe?=
 =?us-ascii?Q?GAPlB36y4qjv68J54rOg/uD/eq4FjiduruJ07fuo60SYWbtrqmeszPJ6ZdJ4?=
 =?us-ascii?Q?mRb+LXCiESquz3sjXNYeV8401NPWs/1bdlW1pIS0iP9LQiiUt9IEUoaBE0No?=
 =?us-ascii?Q?6YdNdb5uW89sMRt59zbZ5Foazr4efXkUyWa2F//V1jLCOpZ12L/BTMoJHxq9?=
 =?us-ascii?Q?f93cPLETphPmM1QlQEmTf1UVBwpqCFCht/QzDFACnD9tT9/rzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 05:42:45.1371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb381eb-3c59-433b-2d97-08dc8b6ba6af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821

It is reported that USB4 routers and downstream devices may behave
incorrectly if a dock cable is plugged in at approximately the time that
the autosuspend_delay is configured. In this situation the device has
attempted to enter D3cold, but didn't finish D3cold entry when the PCI
core tried to transition it back to D0.

Empirically measuring this situation an "aborted" D3cold exit takes
~60ms and a "normal" D3cold exit takes ~10ms.

The PCI-PM 1.2 spec specifies that the restore time for functions
in D3cold is either 'Full context restore or boot latency'.

As PCIe r6.0 sec 5.8 specifies that the device will have gone
through a conventional reset it may take some time for the
device to be ready.

Wait up to 1 sec as specified in PCIe r6.0 sec 6.6.1 for a device
in D3cold to return to D0.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 41961e28a86c..a6ed85dd8d92 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1387,6 +1387,17 @@ int pci_power_up(struct pci_dev *dev)
 	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
+	/*
+	 * D3cold -> D0 will have gone through a conventional reset and may need
+	 * time to be ready.
+	 */
+	if (dev->current_state == PCI_D3cold) {
+		int ret;
+
+		ret = pci_dev_wait(dev, "D3cold->D0", PCI_RESET_WAIT);
+		if (ret)
+			return ret;
+	}
 end:
 	dev->current_state = PCI_D0;
 	if (need_restore)
-- 
2.43.0


