Return-Path: <linux-pci+bounces-22148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0EA41561
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DB93B415A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010D31DC9A2;
	Mon, 24 Feb 2025 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5RmSyG2W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2ED1EDA0C;
	Mon, 24 Feb 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378674; cv=fail; b=bbLVu/EFH5avX7dU75BReKkpTGtnT6OSVwM7jwAmtfFSeUgPqoBcBjtYiAuENh1NxpaYePvh/YCLTSXHvkoM7uBNjhOwpF03tbAh2u/9/uXLgBNZrp6xDDQvD3mYZa9Ij/xeLmCHHx8LbWQQASVy9DajIeo9/2o//oX9Pri3zWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378674; c=relaxed/simple;
	bh=dels0NW9FnYN4X03k6hHsWAFjzoDnmp0cD+ZbNsSOdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuSTRjZQx0Dzk1SQebkM1deo35aboPq5TQshx04YHAz7pdTvFCx3+qGoMoCsUtPLlbidmylesaAryUgUlw3GqooWkDxQMkfvc1aF6rmu7KiYmMCrlxWFXOW9WTfKK1s9a651C4HqRRc/Gf5tv57ecfoG4fBx1Su2F0gP3K8RmPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5RmSyG2W; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMONwvH53svxBzfZ6c17fCKRzQIY35uofOigLQNWYMZQonTlQt0dILuz+Oooyb0txdASBSi9YwkgDbOJqOiTYlDcoWMRy6UEUtWwLbhJWrTdQCu+GlIlBdAFOBG6t3qOF18LWp3tMHk2bAAiBvdl27jYyVEmRZ24PSFf2ELcfLVJRO5BLs+0aaH2GGoHp8vPa5ai0Gkv2UZjr780Xu0yDL/7NOgEviHX7ZHYLw1/tkKHPDw9Yo4TMxpyfRs0DRC43Ds3hvZi9m1E/gXq4rgKkRyuKAkjeM6b62mWnDdvaSzUH8v5nKj/9rM+bLzSNFsn9L+unAlynu3dnbBERUUMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuqSGBzuXd0IwP10W2+zNoB8RolFIgBn/1xUC73hFvI=;
 b=BAgIbxM7Yi1q7vh+hJln+5jed79nnzcdMV+FHJbj9ygA88EqVx/ZHrWa71d2TD/QnH4t93ayPPiPzaFRE+AHJqe1dsOP57XLNmRzxk8FdzaD75MtUJSDrkMVcPVMEHbp5QDJrQ9e1gitYeT3CxiSvwBMQkG05OgaqiD3mi9hFZbwWvqFlyiS9Tq+Ywi4EN2jxOtyjnWAxGlk63RRgDocm5yw9RbrE5eDzZdVduNbUXEXWd1ZeYkdLQQPWvW336hvZHUFi9P4px8Rp/QBAcAklPwvg9Wmsbe9ryE+e7pl7UiC6Vsi5kTgwtEFXYJ7bk/FAD2GG9bB4+TOdUa6M3nY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuqSGBzuXd0IwP10W2+zNoB8RolFIgBn/1xUC73hFvI=;
 b=5RmSyG2WQ5a2Cy6tXAdBEZc4ToZ67770ieRDu1DKI7gg5PX97I5nj8bDRGzUOq9boOyGK/bBiPRjrkURRxLJ0ohqGmeamPEJ7/sjygi87kYrGx3+zIF0lYsA3gdsqh+BRP8JLduEY52NUSR3hZJz+uU5APpkhEGs8eUgKuy3HEA=
Received: from BN9PR03CA0191.namprd03.prod.outlook.com (2603:10b6:408:f9::16)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:31:07 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::ce) by BN9PR03CA0191.outlook.office365.com
 (2603:10b6:408:f9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 06:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 06:31:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 00:31:07 -0600
Received: from xhdlc240022.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 00:31:03 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Mon, 24 Feb 2025 12:00:46 +0530
Message-ID: <20250224063046.1438006-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250224063046.1438006-1-sai.krishna.musham@amd.com>
References: <20250224063046.1438006-1-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7fa751-971a-408d-a19c-08dd549cd25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RnC2zHV8AKdwmGS6CCkbnAI+3t8f8iAUbcAM2ZBjNimf5V3kHhGzVMt0dOvo?=
 =?us-ascii?Q?KByClhl+ncVWpZAX3yZuIZQuJbliMHV8ugo+yQVkbQY1LlZQSqg0zC9jUhO1?=
 =?us-ascii?Q?63J/MNV2e6272SkOCrQPDVP/TnN+ayiAPITBMwq274d26YBvSeIlEXogJP70?=
 =?us-ascii?Q?NZj4l6xPaioE16c1mD2LKXoacZVDtdD5KLHhE2XU1nYOb2o9bOmPQOr/Ea2R?=
 =?us-ascii?Q?6gl3HJZIbff7jz3nZkHLyBQ5/OqXUQ8nvNjcxQ55zWAzeLZmhUYgEfeOkFni?=
 =?us-ascii?Q?j8KiTSgr6LwqdXvWgZIi6fv4uVoRhyNjuc+4wRBPFs3t4NEpsSi9q01nAlLc?=
 =?us-ascii?Q?4DNFElo8J6f02DkC5vp9luH0tNNG989vcSG3xYGb6s0eeOCoL9z7q93qMPhR?=
 =?us-ascii?Q?zAXlBgTeMU4Tm9ayoabyQbzVcoB7cOJ08bcD/7DfRITebazk4VyDyP4veYBQ?=
 =?us-ascii?Q?Bn9auuKjOCTJXJ18gtFjUi8NS9TWjD6q0gBe27P7hzQuJlvDTMBnji82WG5H?=
 =?us-ascii?Q?NjWPAW2bKKxxoh2vMI6JhFG/giowCpLbOIcN7bWTQT3MDs22ed8WdZX5g1fk?=
 =?us-ascii?Q?N40GHnIoDI3qKySBUHlOVhwLGzScfUeho8GoK6K0TFZE7qUBbMsIcDG7ou63?=
 =?us-ascii?Q?FpvOMEMCZpLle21WSYGHnszFtWf45YprwyI0hgzDiIozBMwa37xQA6F9wA/g?=
 =?us-ascii?Q?ip6gxIrW1R+gPfENSVLd2RDACjby2qfiFX7apXzOl9GCahkCzIJqng556YXS?=
 =?us-ascii?Q?iQtmd2ZcKXeuwT9BwPk/iBa8y8X+lSOR6Klxm3ZKdfOTVrVFvKejaTIfvbUL?=
 =?us-ascii?Q?W7r1Iv8gWdgd68qIYHNR4j9Qu7tPW115Qx8KaNB0dvg1FVL2B2Gfso+wWJ46?=
 =?us-ascii?Q?QrgXYt0FZYoAAHJ2DSsfly+zO9qXzwz/UZZwqM/k1K4AdQxcnjjjoCeJHY7F?=
 =?us-ascii?Q?FYxM9yezbo2zw8qwNkZPfCQM78buntWS1GQ+hzo4myQci0xgFXmqRXkdgopu?=
 =?us-ascii?Q?WI+sxCWw4s8jTOPoVKa6r4aWE67l8EUJoz4QP9N0AGIzYawelQxYLjJx1lUC?=
 =?us-ascii?Q?5UrpwQxg4jhLK4y5sUKBXALYnPSVEqqVIt6Q7fj8vDJ+iYO+esUm3WIawP6X?=
 =?us-ascii?Q?EptTuKf8bsNfOVGDzknfQbycmyukkUVP9OJVW2f5jPaRpBK0ah87jc+QCoxt?=
 =?us-ascii?Q?6Zqw7ES+fdUGDaqNugYGlXMYZYrjtKgoUErvPIqA6+Gy35KmA7D8k90Hp98W?=
 =?us-ascii?Q?7RJadqb4bzIeF31YjEWNud548BX6oRUWqCXAI2h+iPObuX2+sJaCJyeS8hpd?=
 =?us-ascii?Q?3uFLF++zms98w7L1WgEMZpVQBbO8vyAnIt1trhvtgpZyMbu+mMq9X3UfoSja?=
 =?us-ascii?Q?BUVxocfpOviy4CTedjdW1Rrd5LtUR+jB6jNY3RHfSOy9El/Yv3lYomVoqyLA?=
 =?us-ascii?Q?wKZGjyKICZeYxzHVLcg/lWqRnvy3Vz5HS49MLPgDVrubn/1qjPo6bzbY083g?=
 =?us-ascii?Q?2ZB4x8hXuMbIXK4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:31:07.6796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7fa751-971a-408d-a19c-08dd549cd25a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

Add GPIO-based control for the PCIe Root Port PERST# signal.

According to section 2.2 of the PCIe Electromechanical Specification
(Revision 6.0), PERST# signal has to be deasserted after a delay of
100 ms (TPVPERL) to ensure proper reset sequencing during PCIe
initialization.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
This patch depends on the following patch series.
https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..0e31b85658e6 100644
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
@@ -568,8 +570,29 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *bus;
+	struct gpio_desc *reset_gpio;
 	int err;
 
+	/* Request the GPIO for PCIe reset signal */
+	reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		dev_err(dev, "Failed to request reset GPIO\n");
+		return PTR_ERR(reset_gpio);
+	}
+
+	/* Assert the reset signal */
+	gpiod_set_value(reset_gpio, 0);
+
+	/*
+	 * As per section 2.2 of the PCI Express Card Electromechanical
+	 * Specification (Revision 6.0), the deassertion of the PERST# signal
+	 * should be delayed by 100 ms (TPVPERL).
+	 */
+	msleep(100);
+
+	/* Deassert the reset signal */
+	gpiod_set_value(reset_gpio, 1);
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
 	if (!bridge)
 		return -ENODEV;
-- 
2.44.1


