Return-Path: <linux-pci+bounces-22516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5FA47467
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 05:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5D18870ED
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7EC1D63CD;
	Thu, 27 Feb 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEpVKR/7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B921A38E3;
	Thu, 27 Feb 2025 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630371; cv=fail; b=DSzVzYS6z/wqYOhDH3aHcPCdsSwjLx4xGyN5DFdEIylo/+NyWl1pSx4qY5112z3nfoMEdCd6VEdbUk2M7STvABpUVFevqlcsr7B1j8pJPvLRSOWY4dQKUn5K4mnZMA92pIjg4WIuwo2iL5bjesH1FfkotXFJLXJhAJ9wCLh7EiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630371; c=relaxed/simple;
	bh=1QxNH2hHzCn+98tPlBhKUlkpWvjhO6MBMNs5hyZ5r2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGbW99JcgWYPCTVvSY92WU2kIlZIz5P14D6xdkjpty9ShUYX6jrn7J0vNrTqrZTOxxVwbAqMFxqpGTmvUuCF0orrwFYBRf4ybbMiqlvxxD1UsH6yXHtxkuIdIRKpUfH+dyqzqsUKOQINFdH9s+J0LEu8uP7X/nq2U60yfhFv+2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEpVKR/7; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu8V7O7DO+c+LpEr3RCq2EJna3OF5dd0ZEg8cxa6E3TuFMwYE7Q1gfTV7ooJXKuHL7QTFKkzSRBHBWCL9V3vNHtM4NyRqRAwhtRRho6As4zjif+/lmD+kwWyUkL0G6aU9LlxAuCTUXWjSp07ihh33ki3O40pIpLWfIAAUmvganrGrCX9wUJeBvtmKvV1v6uWd9fLj+cfPqxltIZqAaqQvqSJ/xZpwgkIi+aXOaopWKmJ7mnBwnZyg4m24BGPWx6tsca9u46DnPCSqcrRJoeB0IjQG8JAHJZX0jgmeLGItBeZJ3QqFoO2PUd8kzq079xzYtQmE9WSrEiJ5Wm13But/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIX0B9koQD5BnOZeIeeQUrLHR+zWKRrPwdiPtSmXdvI=;
 b=gA08EN9tWbkp6q81rQPXx/WVPKsT+bnC7/Rx922GBvWVqsosmuaJ433bkszk8F/FMq5QEqpgkJxX96D8E1tsiWqCTNtYzxI5GH2jSdOyxoa/bgjMgcyXmBNEzB2TPKi1rUUNT+xUr4/tB+JiU/5ZDh3RJN0CILGqAKxLny9geK4ZCtSn7Er5wQLsYuUWh81jAPDA/xdc9YEz1wH0MAR5VAacf5L/ybLdfRm4Oy7ganh4ERuJDX57IqLCLXx3RKiEK0RmAW1kjLojvI7org47XkgDXn8ZvBGRJcSMdnx1yCbR6+s7FAZsLd0h60BRASrIoiVYxYI2nzy5sWQiDPTiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIX0B9koQD5BnOZeIeeQUrLHR+zWKRrPwdiPtSmXdvI=;
 b=UEpVKR/7GdNbEh3SZEynjXneF3EhtmjiOmWnYeOKm6+RA0GumQykaQG7MTsoxXBV3CgfIQ0Vnlv8bc0n8LcIKirmsVv+XaoG4sfoCRvIrngPqiZm9ktZQ685pLaR1SoQlKkYnyf4jtpDHyri5K4hUWaTV/olWZbJwhPs2PNHcRo=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 04:26:05 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::1a) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 04:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:26:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:26:03 -0600
Received: from xhdlc210316.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Feb 2025 22:25:33 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Thu, 27 Feb 2025 09:54:54 +0530
Message-ID: <20250227042454.907182-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250227042454.907182-1-sai.krishna.musham@amd.com>
References: <20250227042454.907182-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 0890e63f-51c1-4982-57db-08dd56e6d96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BzdMcuy3PSUQxKdy6MRsJc8Qg540g5YIAWfApvqofAPcNjaQTfV+cjw6DhIc?=
 =?us-ascii?Q?K06dkt7S1SVpPsRgIFJRM4lB12cD0FrqJSViUnMaiSBNMhkfBXso8zWwXxoj?=
 =?us-ascii?Q?xdC7y/h2mG9V58mNfa6EFFyEH+ATE+nkxpsOcUJxlkkklLi5yzoHOg3Yxox8?=
 =?us-ascii?Q?uqOpG8lEBRjz+vZfXflLPzKrT1+cLfV5hC1LDTkKbYj7/PejP+8GXmB1Op0r?=
 =?us-ascii?Q?zRBo9Q0eBPV4MOFtdq7KYy7/VtrK2Wxh4drwkMFjh+JWPuvNjg+Z0R+QNtAG?=
 =?us-ascii?Q?phmdh0IJP23HmrJ8PA9seOY6uPZ6Ahhu3eWfRrXz7787SZ4HwVabMBY5Z004?=
 =?us-ascii?Q?UPsIfLexcHV2/FMJdu2LWlkVIB32DTsyp9Ybax+F66mvlvpw39o3o1tjh+q3?=
 =?us-ascii?Q?MGBYyUE0NMfv4Z1a4yfcAx4/tCOnJDRTcS6GSZgZA2mGRmdFSFKZdN8RgmYu?=
 =?us-ascii?Q?NDByRMsgLGYS44ukqhlHmpRg7k+dsERaApWspTs5V+fMdKa6yDia0kwaK/Bx?=
 =?us-ascii?Q?FuL7lqAq2CXaszck5ToiBWgGiqzQjc+7r5idiO7JCsETLngCzyON5RKDmw3k?=
 =?us-ascii?Q?XCH4RZWCYt3YGb3Pwn4+Ych/NzVTnF4lYBWhar7Smb9zXmhA85Yanf71KnB1?=
 =?us-ascii?Q?lRYcb9jDcMasmEbEUvN0fjM4GRsgyRX7/mMpx1CL8nHIgcQJzQdfDrB28MdY?=
 =?us-ascii?Q?Jiu+X8slkBHb4O7vkC/WuhRPnTdURo483q7SY8KVKj4X3WAFRFy5VUweudHk?=
 =?us-ascii?Q?dMUa2ByF3fomO82hqg1vBbMCjOqynYWqz2T0Iius3iIO4aqPd46PvusvQDj1?=
 =?us-ascii?Q?oxzjsI2A0VdQ982yHnMOXyqA9Fz8JTr3bEqrr0LneLkNMEP1hezAtsbXqy7Q?=
 =?us-ascii?Q?17OgUmt0Qdk16QedEyl8+JT0chuwgRavrauRzOuXIr+jyTlPDcdV2J9LlgLa?=
 =?us-ascii?Q?/itIWTJ2SU8w/4/D85Hs3K2eaSxpD01puw9br5wbjTXTCyd/RdUJS5LeaVjj?=
 =?us-ascii?Q?7Sq5za/98yCzH7regzDTsc8nfOm74xswEzfmAmdAYZfND7OAxKnnEMlnHZjb?=
 =?us-ascii?Q?FS3ePY+z0kejOGQZiDY3xtYasTG8kG3jXmpg9kXangjaqSIkh4kmLQrtUPuD?=
 =?us-ascii?Q?6trTSS+iahriOislhO7jNMMNEw0OhlV3+E+or4UBZalGqhS/ekdGLbg/FAVw?=
 =?us-ascii?Q?nuuwzcLwy3sbN/EVrcn7sHKx3s8cqRHbPKfr0e0vq1k+9MiuIAJWUPyI51t+?=
 =?us-ascii?Q?unoI1xJkv0DAugM6ueHayZSD7QFpBJ1biL9pVj0TXsuwjqjVDs8Dcio1lrOA?=
 =?us-ascii?Q?L2g+8EBzPY6nxhbLKlPCz/kdwHp4p1CqKdaB1ap8XTa+DfHZfJuYdKbugG6w?=
 =?us-ascii?Q?T5Tulj43/XPLJrOaNtIsAiWa9zwxk9lvXn41vtbRS4qq++Ar+jqktc3bvnzm?=
 =?us-ascii?Q?sj86ExduexuFwqVzUrjcTK5ifTU8oNIlqr0iyjugNOCO8rKy72FtDb7MeKXF?=
 =?us-ascii?Q?494OljUsFgftctA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:26:04.4982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0890e63f-51c1-4982-57db-08dd56e6d96c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

Add GPIO-based control for the PCIe Root Port PERST# signal.

According to section 2.2 of the PCIe Electromechanical Specification
(Revision 6.0), PERST# signal has to be deasserted after a delay of
100 ms (T_PVPERL) to ensure proper reset sequencing during PCIe
initialization.

Adapt to use the GPIO framework and make reset optional to keep DTB
backward compatibility.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
This patch depends on the following patch series.
https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/

Changes for v3:
- Use PCIE_T_PVPERL_MS define.

Changes for v2:
- Make the request GPIO optional.
- Correct the reset sequence as per PERST#
- Update commit message
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..558f1d602802 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -568,8 +570,24 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *bus;
+	struct gpio_desc *reset_gpio;
 	int err;
 
+	/* Request the GPIO for PCIe reset signal */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		dev_err(dev, "Failed to request reset GPIO\n");
+		return PTR_ERR(reset_gpio);
+	}
+
+	/* Assert the reset signal */
+	gpiod_set_value(reset_gpio, 1);
+
+	msleep(PCIE_T_PVPERL_MS);
+
+	/* Deassert the reset signal */
+	gpiod_set_value(reset_gpio, 0);
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
 	if (!bridge)
 		return -ENODEV;
-- 
2.44.1


