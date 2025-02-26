Return-Path: <linux-pci+bounces-22436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243EA45FA0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A9116F76A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F821B9FB;
	Wed, 26 Feb 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gP+6sz1Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C421B9CC;
	Wed, 26 Feb 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573859; cv=fail; b=NY6LCMCJr5anSpE+WCnAoYAYGW+nRCbQRlg58o3T/VHpwa+wVbQPZ0aly416yvaawiVbKh4n8EwLBg9h1mDB2pDtVeSIALFoOiiN2auehw+w4ZSesI1u8Aa+Hj214iHUHg5wUMTdN0K2rOIGYXDWv1qmX7iuzCuaSPd1xFEN20k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573859; c=relaxed/simple;
	bh=zxd2tmR4Z2hh3M3jZPTieSrsTNVAppxo9hlBpNYCMgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGHWBgpYLBwHcB9UwbJK0LIpcOZ1OviWdZoT3LpAiRknEq6Hz7pCxkAP0dQ/1Lrlzefog1qeWmZlvy7bSWAm32z4bgeUOqc6flhYzjXYBKBvE2vO9vw1gYUdOM/npj5cK08ZEIgWtTs+tqxmSd+XRR1vOxELR3MLuFch4z7VN/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gP+6sz1Z; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2M/57PlqV3Bxn9/l7zf+/+NHLYu/CsSaTwAAE2N//KMvUqvifjPzkBAL9uo5Yg6q/7xlDDE/bV9sP74MJU+KZoxW+9PNRnKabSXdeExpcBvn1IuJPzuqQHWLBjnmdYRypFjtabzpqHAla6+C2OEs3DdkRASiWfEKu2gKFn1oni4OgeT/uF3gFqeLKDr3xPACR0jeJ0s3RWzQ+SaMlpdZi4mo/t1FHbrB/c4h7Tdl/NJb16N6WAasC1s0rW9Q+TVTBASCC4D0EehcPkrBaQP4h1prZJ2imBKXmBUjjVBsKkvFuz6HKkTqiRsV+XzugcdjwkxCT0Kg9QMyjqs5x6x8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh329/WUe5SCTCu8WHhZfwhjlgH4CJO/VN5hLDlBK8I=;
 b=AW6Hl1TRT1APZndsTjx47d5jfOPHXkBrjIMBVPyJNX+eZAtb8VCXwQclPXxSDZtXdopLqM/PGs7aAzYlyDrBv6TtBkthA9Jh/Qrr3PRQVdkn19/pT6flSMuQYI0iBGnhOyvyT/k6RqfwUVCJKbhHT5tWQ9tz3gnITBoasjw8i87JbbgPJPSMEPePe69ccmvJOQ3Iu/7X/tJtJKD/0Gfw58/Nxy78KQdO8CKihvCkE0tCU/qH2eYaUN5MzA6mksobLuG/OPhBzsjAon1FZGmq5Y23WhgfCzeKMeruyzvAG7y8Nq2oq0mn/WsMZit47vJKWjx/8m+Mb9srmxNO7Ex+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh329/WUe5SCTCu8WHhZfwhjlgH4CJO/VN5hLDlBK8I=;
 b=gP+6sz1ZLYrMtLj7JCD7LRBvex8tkt1CGktZk+USdxseFSokDXnqbPqVZWX0Nyg0JI7UfAWJyx5zH7Ik6R6XSy7q4ITZ1qqWlFV3WHXq/XCPF+6jqaON/ww50lNz4VuJng+gIoqUMhytO2u6n2dMbaVmIqxpYKC/EBNp7ZaP17w=
Received: from PH7PR17CA0006.namprd17.prod.outlook.com (2603:10b6:510:324::28)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 12:44:15 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::14) by PH7PR17CA0006.outlook.office365.com
 (2603:10b6:510:324::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 12:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:44:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 06:44:13 -0600
Received: from xhdlc210316.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Feb 2025 06:44:09 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
Date: Wed, 26 Feb 2025 18:13:58 +0530
Message-ID: <20250226124358.88227-3-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250226124358.88227-1-sai.krishna.musham@amd.com>
References: <20250226124358.88227-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb03b16-39a8-4391-edd7-08dd56634687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PO53UsfqyAb3CQnnLo+vuIaVkZe7MmVl6RkUENAXgDKL+t6tUpwNhX0ayCDh?=
 =?us-ascii?Q?YKalmHYfbR8Q6U9HkVXzMpNMA8sgk+QjJBwv+PVrg0ISmgIzHQ7v+gXtNGHI?=
 =?us-ascii?Q?yhAGXfUDbjScQW7IgXK5E7htR4Rw64WglFBUYa/p5SprtDz77XZcwuBXnSwl?=
 =?us-ascii?Q?hdkvNL3qitfinxQc4/fkuH02DPWcBR//CB2D5b8nZHXy2Kfxdm9vJgm5g/XP?=
 =?us-ascii?Q?mM0MuMvmh5qTF/8/jjaI2IzU/vlRJ/Eb0/Lp37lLH0pEmMzpizEJs88LcCVO?=
 =?us-ascii?Q?bGUZDXN64u+OAf0Zc0Argu9+l9pJNhGp+jmn720XQ4p/BIvphUNmnVYGqylF?=
 =?us-ascii?Q?5RaBjvLM2J63HDXHOXnCebk19GKCs86NBtvgYNQx0UxPfCjdoqzZaEgzOf8K?=
 =?us-ascii?Q?NcBB19+siHUwX3ZUqpJqu7uy+Vm3QoKULgQ9hWjmtijjrtc+2t516090TMSH?=
 =?us-ascii?Q?tY7OIQUaHjs4KwqHNy77F0ETD9sUyykudtFFYdTjSct/Xk74czWMaOai1jGO?=
 =?us-ascii?Q?Tzv+fF+EUy+XspWS1woB56O++yptEbQeMmsyyNKfl+JYaw5F2eZefp4gPgzo?=
 =?us-ascii?Q?deaL8js1x98r7cvqpiaxb3F5Nau4fcQ+Ka+/tPfgTZ+EJ8vwa1Us1b0w0lM+?=
 =?us-ascii?Q?NkucCCRxNDXp5qddQIKlRuf3hqY3Jd1sm65SrkJSYk4AugdALAhSwMYjZTLD?=
 =?us-ascii?Q?QvaRdMzVDs8e/lcChMDAvF6/EiVNd1dOgajho3Qx5hnhgH1F8BzbfvE26jN1?=
 =?us-ascii?Q?2t22JmchkqNva4tHBe8f66l7Hlb0snhTDqYy62jqxe+9u5t0SgfUo150/PTC?=
 =?us-ascii?Q?q+v6acNtIKN4LDfDI61AcgDjbLY5q3u1Wsx6p/Sx/L5G3VvGgm8T9Obm5USw?=
 =?us-ascii?Q?Z59bdljFqWBetLlHd5NZlFfX9ab59p3X2bW4+IW/XEDFXnWZ7Ihys5YSjogx?=
 =?us-ascii?Q?6Xt3jA3C9E8iaJ/JyERHhZeHJlhLbVIjS0bNN1pr2RBk1ySvRlRj7PuFhsRq?=
 =?us-ascii?Q?81xTk0nN9u8j32Qmvv2UYo0YA78l6YtBEU61Su1khe7axvqlaphIsT1WKMOD?=
 =?us-ascii?Q?aSjkazAq9pa06/ZIHOcL/uCC98LTVIDl8U3l2kAahln5NXj16piJ35nFs0mD?=
 =?us-ascii?Q?K4AML/ZI0E4q5bGb1s9i9OsB2BvTONNdOrqwI6ZwqKt7HT/G+KJyWsRkjnyt?=
 =?us-ascii?Q?TiWo8a9ozTn4V1c6WoPtqmKRrf6itqM54Op8aoijZGFB0guIZCoyDG4zvac0?=
 =?us-ascii?Q?DlghbqYlGRA10Zow0MJRvkDiobcgLOnJbTa7hdUZNHGtx81ORvXHhY9Qx518?=
 =?us-ascii?Q?k6eCpBkwYpxrzjtR+gQ1cW74yYv25n4p/6pXVePXuKcTicwf29zbqoH2uQiW?=
 =?us-ascii?Q?mv7QwHiK7W3ZjQACB7qHDopE83x2S9QoD+yTmKriKT9O4bJHTrxEvJKgE1N3?=
 =?us-ascii?Q?gZlAKK0vljcnJQBkPF8Jxvg2Xg+f9XCcGUvZcOjE3JKHZPmGIcRGXwmEoqyL?=
 =?us-ascii?Q?e4t7rn2x5h0Utl0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:44:13.9823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb03b16-39a8-4391-edd7-08dd56634687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840

Add GPIO-based control for the PCIe Root Port PERST# signal.

According to section 2.2 of the PCIe Electromechanical Specification
(Revision 6.0), PERST# signal has to be deasserted after a delay of
100 ms (TPVPERL) to ensure proper reset sequencing during PCIe
initialization.

Adapt to use the GPIO framework and make reset optional to keep DTB
backward compatibility.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
This patch depends on the following patch series.
https://lore.kernel.org/all/20250217072713.635643-3-thippeswamy.havalige@amd.com/

Changes for v2:
- Make the request GPIO optional.
- Correct the reset sequence as per PERST#
- Update commit message
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d0..aa0c61d30049 100644
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
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio)) {
+		dev_err(dev, "Failed to request reset GPIO\n");
+		return PTR_ERR(reset_gpio);
+	}
+
+	/* Assert the reset signal */
+	gpiod_set_value(reset_gpio, 1);
+
+	/*
+	 * As per section 2.2 of the PCI Express Card Electromechanical
+	 * Specification (Revision 6.0), the deassertion of the PERST# signal
+	 * should be delayed by 100 ms (TPVPERL).
+	 */
+	msleep(100);
+
+	/* Deassert the reset signal */
+	gpiod_set_value(reset_gpio, 0);
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
 	if (!bridge)
 		return -ENODEV;
-- 
2.44.1


