Return-Path: <linux-pci+bounces-24026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C3FA66FBD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE22E17299C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3E207A3B;
	Tue, 18 Mar 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gx/XCK5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770A6207A04;
	Tue, 18 Mar 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290034; cv=fail; b=bvajbIedBVPdPYpL+bl0k/R0F3JrZ6vfTEob2Dc2w13FRgdUpqNk3CWhxP36DUw5uX7/m6HnM13MHI1ksGljaNnYnGulEFMQJhMB1MslgHoMN4LBvVAJyZ5gqwXv+5AG06NN8IvZ5/pCYjJnGpmWTThhP4BD7mHOTKwQsfPTZs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290034; c=relaxed/simple;
	bh=+geJrcrX+GHj6yfjRFlIKFDWoYWp2JiMw17goYZN5Ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8kB1GdWUszBGyMp2Go2gQbJOmUl/d8llPsmvDawoQtVl4rnGCXlqRZybBwqwROTIRm08SC+mmI8UPO0E4yZyHUNfJoEOYsd671kx+BOQCyJoXovcxQZhUMquDGIs5dHBH86/gQAV9yEmzTEArr9fYl80Ya6g5CN+rEHUWemZus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gx/XCK5D; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VesNsyzFB01ACqU2lUZzUMVkh8P1NgrGnQKFOLYCT3QexE2G2/X60N1qW9LweMDU8+FeFTfYDEKCVTb8chQcj6TSvxPMuZIl1gfJW9fOUpYdZcR4560/iM91+T/spd1wNF6H+WsysbbOVlrZKc4rFIXFMVlaOxYPXskq8jVnxuc95jq/5+NToY3bN97tWU0Xgsizsg9JO+6Jik4Y9usjtGhVjqsR62rLECKkTr9NRoVFNdFEjai4bB/66GGpKEHT6duOTs3ST4g3Z0rPPHIyCeNTQ+mWhcfXG9he+uNL+k4W8cJgcHl97uAabySfQR/K2l1i8M1Le4oFXydw1fatEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROIDWbhr2azjduLaT7dy38fW9QWOW6HHijalGHOpjt8=;
 b=TUp/48tLga5Z4o4jwSvErlhtCihHODEmTWLNHrjC/9edhhsM4DVHssYhMmmxuna7bNKweYAoP5IC3HFEmGCX9T0/XQmJeUsMYCuUx7WNCkJV426wAD9fT+Zi0ivCkKJsvHe45o+bmbfyIaxffYTgfRssxIgg1gwqwEoo7PESmHDK5vO1cihPh120d3nRpmBpx8XrnrhcJpBIyKPr99qMry6Wuz/PnZvoLc7X8uUix3t6uwe0NTcxANaemmjjPE2jw9l1A4ou8O+9+cBsrH0xwWzogef6WoetgIqiXLvbre6sjApjQWqNhvqc1fTjuHSYCb6jls0g+ZpFY3IFE9rdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROIDWbhr2azjduLaT7dy38fW9QWOW6HHijalGHOpjt8=;
 b=gx/XCK5DMwMPJIHZDhnZ0u4w0fOnfN4HCXOtKLOL7U5TcM7V09bl0nYrjv6hWwN6eGueClX0p4t5zFLjnTSlMG2haKnxOcl6uZYdtCuL7DCHOMkqMnr/MrJmaqwBV6By8myhu/5VfMGB7r8yjvl4LKgNroHDKBm5GI0TKGtB438=
Received: from SJ0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:a03:331::13)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:27:07 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::3a) by SJ0PR03CA0068.outlook.office365.com
 (2603:10b6:a03:331::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 09:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 09:27:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 04:27:03 -0500
Received: from xhdlc210324.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 04:27:00 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
Date: Tue, 18 Mar 2025 14:56:47 +0530
Message-ID: <20250318092648.2298280-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cde8f9-c194-46e0-fc15-08dd65ff0d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaEn9j3WOMIRj/l/0SIh3qp/XYjcnwNLdFT4dMMfOtWDwj0bY36EEAtIT+Pf?=
 =?us-ascii?Q?c9N4ucgOWlm76ArfwTMhlPRXov4QmiaI9USMzy0tsAel6/8y68TIJSQwu5wn?=
 =?us-ascii?Q?D26YvgEju9zYxKeiLexh/AQKfLjKJnPG2NplRKv/JvTw7YoE1aNw7VD0eG07?=
 =?us-ascii?Q?wjiGvfoGfw5w7Q23HdofWu5JwvdX/hpee4VOZcqyIxmPNmyKRYuA2cdAMtwv?=
 =?us-ascii?Q?IJkl4h0kvdAJZojRh1ZeJjfox79kbivMG/+6j5XDogYiIGw8z0TYu7I7nUYu?=
 =?us-ascii?Q?fgbgS+uWmG8EqJnHvlIuRK4hKR/WKruBpX0nG0Sv3r9lT/5Ru57Uz/NLvMMI?=
 =?us-ascii?Q?NNz3opARXdfnKIgEaLjc9yEmL0geZm8ULYdcEQz0BJ43tYf+77LkYLD2aGr+?=
 =?us-ascii?Q?mZDJFMLsza8XLWAjMPkCtxxfXrbV/VgLe2Zww3pPuL9ujQ1zuibZlv46PENH?=
 =?us-ascii?Q?5CNsa5zJyMmgdzXC0739xwLUSDSVl5tjW17LfBPqxMMlLu6k9b61a0dAYPWL?=
 =?us-ascii?Q?lrMssEJQu9DkNq2EzsjEq/lASYvesan3eD1peeY35NiPyuz6z44FR/8LVGg9?=
 =?us-ascii?Q?eo31QJvVXsT/cmS+EtJHWgd05vg7flaIrJmSCDqeEaVfiDTPBQPBuXsB52qw?=
 =?us-ascii?Q?hv8+NK2YpU3wz6oUNLQuOpNJjn1VFwdU7PdGiZjxEe71rSlLIHQTpfkgj0yb?=
 =?us-ascii?Q?yvQDpNGitGD7hQm2LNVmTb84TTtK0edXPaInFeuUmdEZDJ9W6c63niPMt+mO?=
 =?us-ascii?Q?R4MVoGWh1It8F7OKUHRrql5dVSW95q3VJivBf1el11Z/Sa/EV1kWPsQxz4ca?=
 =?us-ascii?Q?QYydIFpZt3Qg9w6QXqhOHQl9zB71qRw42KdmRamtbu4JLvSEWLciJcnHxNdy?=
 =?us-ascii?Q?I6Cp6Qotst6LJpfceGmEYFPs0C1cFP3S/nUS6rM66xKFk+k4tHXhzo2Hwkwn?=
 =?us-ascii?Q?+2Yj2Ofdaxv5AURJEg/tDhFk1inFubijfli0r8bz64MTL74dJt3uj8y7uGuQ?=
 =?us-ascii?Q?WMsrZW3apFKwRc6XiP2/t5NRQRG4+7NBExAzeRmwsT2Amu49llAD7meD65lR?=
 =?us-ascii?Q?vyzADGIOrwhPhXqHTRNIvFipaUFgA3VTGTwcuYwrELESSMMeuQpvrl5a8m4U?=
 =?us-ascii?Q?HAt1HBr8OTsa8kOe/TWhUe2ammU8m99uYbTVW5GYo3WOrnyM3mqPvBpZVD1Q?=
 =?us-ascii?Q?Rwjo4GfLyu5yIFACpaSWPLQ7yMfdQiY9xNQfLAwXyd4AM4HwmY8JVN512/yG?=
 =?us-ascii?Q?Zmfz+23uZUpGCgaEobanS5pZU1TF07tGKTIajd861GRzXW3XDht9ljNO52D/?=
 =?us-ascii?Q?TcmruWmG761je9GcCIHDUATmhLX2MdeD/fFlFe4kNvNBP1SZxu3KX1wT7CgD?=
 =?us-ascii?Q?dy6iEpyXfU6MvpqMXEmalOFGfmz8OSt2FXhhB48/AyjUXLcASiFY3cq9UspC?=
 =?us-ascii?Q?p4W9/KERi+SaotQ8H23SldyTUIPaLhSCRp2T4i5GhvnGP3/Jx6NiWXUg2AN0?=
 =?us-ascii?Q?H0aa2gqWTGaxfCA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:27:06.7295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cde8f9-c194-46e0-fc15-08dd65ff0d30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

Introduce `reset-gpios` property to enable GPIO-based control of
the PCIe RP PERST# signal, generating assert and deassert signals.

Traditionally, the reset was managed in hardware and enabled during
initialization. With this patch set, the reset will be handled by the
driver. Consequently, the `reset-gpios` property must be explicitly
provided to ensure proper functionality.

Add CPM clock and reset control registers base to handle PCIe IP
reset along with PCIe RP PERST# to avoid Link Training errors.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v4:
- Add CPM clock and reset control registers base to handle PCIe IP
  reset.
- Update commit message.

Changes for v3:
- None

Changes for v2:
- Add define from include/dt-bindings/gpio/gpio.h for PERST# polarity
- Update commit message
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index d674a24c8ccc..904594138af2 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -24,15 +24,20 @@ properties:
     items:
       - description: CPM system level control and status registers.
       - description: Configuration space region and bridge registers.
+      - description: CPM clock and reset control registers.
       - description: CPM5 control and status registers.
-    minItems: 2
+    minItems: 3
 
   reg-names:
     items:
       - const: cpm_slcr
       - const: cfg
+      - const: cpm_crx
       - const: cpm_csr
-    minItems: 2
+    minItems: 3
+
+  reset-gpios:
+    description: GPIO used as PERST# signal
 
   interrupts:
     maxItems: 1
@@ -64,6 +69,7 @@ properties:
 required:
   - reg
   - reg-names
+  - reset-gpios
   - "#interrupt-cells"
   - interrupts
   - interrupt-map
@@ -76,6 +82,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
 
     versal {
                #address-cells = <2>;
@@ -98,8 +105,10 @@ examples:
                                 <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x0 0xfca10000 0x0 0x1000>,
-                             <0x6 0x00000000 0x0 0x10000000>;
-                       reg-names = "cpm_slcr", "cfg";
+                             <0x6 0x00000000 0x0 0x10000000>,
+                             <0x0 0xfca00000 0x0 10000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_crx";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
                        pcie_intc_0: interrupt-controller {
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
@@ -126,8 +135,10 @@ examples:
                        msi-map = <0x0 &its_gic 0x0 0x10000>;
                        reg = <0x00 0xfcdd0000 0x00 0x1000>,
                              <0x06 0x00000000 0x00 0x1000000>,
+                             <0x00 0xfcdc0000 0x00 0x10000>,
                              <0x00 0xfce20000 0x00 0x1000000>;
-                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
+                       reg-names = "cpm_slcr", "cfg", "cpm_crx", "cpm_csr";
+                       reset-gpios = <&gpio1 38 GPIO_ACTIVE_LOW>;
 
                        pcie_intc_1: interrupt-controller {
                                #address-cells = <0>;
-- 
2.44.1


