Return-Path: <linux-pci+bounces-22147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F69A4155D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050B516A59E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C81DF98C;
	Mon, 24 Feb 2025 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Aa3biicW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB811DC9A2;
	Mon, 24 Feb 2025 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378670; cv=fail; b=p7g78Cf0dEEr8yOMhBueshBCD1JkWDQte1FylYLFPU481Jxvok5EKNNZkahK2eMbSAL8fdCtD84lNQyshzjhB1Yj67klyuU/Cs/27nzyt3mETspwR6f00mYKsFsN9+oQ3bKiH7WVWLzJaIUPPhgzaRc5Sk+jR8i4OwzZKABWS1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378670; c=relaxed/simple;
	bh=pWHCSrT2xzAEUgWWuFTaYkppz0t1hVUPaeevKAc6b7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2k8rNCtCEAdPH2wfSHEr4xP+K0kUs3ekcSbgfa0aEV/6xv32xUQEeP4+Qz5elbUxEnv1k3bQ6+RMgCNivBenYu9CT6bhLjZi14+aCpl61i4wWbHclDwC3ALJv0hoSVkRYXlgr8ETWScwwNMIlxC2+lm5UZ6SA58NIRZcVSl0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Aa3biicW; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8GPmhmNXZTKfsNBmVINwcLeWRD4EN1nX/sf+KBRXOhfBQTlIpGX/WecasQc47vMuqiDFMWFRRQY6SELnLrosKwrCx+S6nBefPKguXRBOiZhJMBfmhmm2Z1D46Bd4Qj0qPBIGUslWZdDBih/e9xacOwfSsMLw5USraVHR4AhOytKUILhymox1oNbzalyWSlPvQ3UX43ATtB14GSZD2PTAsT+yHJN5BVyNUjGVz0QJm7Nukvn3mDeayMdMB1D7sjiJFIgT9qPSsO7RV9Xgjl8PpPm2V6NS2BDsL5LE77SMdj16CwLOhCkrkVBPgfCulIsnHCSUKErFD5uvHI9JibZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXWQJQgtu1bd7MlMTuOh91civ06ZKatlE3xtFgpbL/I=;
 b=JraTNjRr+87aj+KA5EUgGkHrwuI5Iv6jbLeFmVe+dFbHNjFCQ11apE0bP5fnP+xEevKsmFG6WcPgXbVxkGc9QhuZ1kd32Cr96nz8joeBpfG2PBqVYslfWo1tLr9d+78Mb2TehjqF+7kqg9aC3Vo6fMYm8Q9qpQrgiSwX/hOjxgYz8ZVFapEujTjqigj8Sx9ym3Z5OxyLEoh8DoLQqnSDyhYh5kj9vjr3H18lSMIUQN+VIEYKO71f90lp2irmkhDxt95mCxgilTVm29s8uqj0/fhekgVatAnAKnkzIZ5qBzYeG+GwwKiwNOLVDqbt5LEHklEA/rmTWy3cD5TmYm4O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXWQJQgtu1bd7MlMTuOh91civ06ZKatlE3xtFgpbL/I=;
 b=Aa3biicWgkqbEkMKlrDQoUOsbcctTv+vrm3vz25RrF9L/VmUlDC6uhqYsr+ahTR2Czhc9QxkkKn91O5wKgmw22GqZSwXdOhjoWlHEjILVYvdvvv1wNBYxm/O8gxZWJF+FdDpaW8BS/utBKg6AJVFQI49bIwms74ILVGyUtzZEKk=
Received: from BN8PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:70::42)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 06:31:03 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:70:cafe::7d) by BN8PR04CA0029.outlook.office365.com
 (2603:10b6:408:70::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 06:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Mon, 24 Feb 2025 06:31:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 00:31:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 00:31:02 -0600
Received: from xhdlc240022.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 00:30:59 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
Date: Mon, 24 Feb 2025 12:00:45 +0530
Message-ID: <20250224063046.1438006-2-sai.krishna.musham@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 31240d0e-3e55-4034-a6b0-08dd549ccff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3ICJhFpqQT5n50f5DnCV4NC8fhz3LXUoiuRQPi1l2zhNyWDGzg7GuVllsVS?=
 =?us-ascii?Q?fZ1hyucjE8zZv1cYD+qEqFSeghUwwb/XgpS22kK+E81Lumei9ap/lO+YSpbq?=
 =?us-ascii?Q?RfClGKKSZChLjWVR0Br9JPW5uVM8I0aRfgtx3rmtFVd84k7HqpYEgAxwLLO6?=
 =?us-ascii?Q?cVc3ohBqAXnQfZUvmgkq4Fa37vx3SgmJq3eF1h0fQeIhgtmenP0P5VNBLDvw?=
 =?us-ascii?Q?LZgPCsyfsu7f1UUgpMa4YBA2WOT+Yn0z8fl8ssmGQMd9HHL46SdL8goGL6OU?=
 =?us-ascii?Q?YU21oAGqBwtvvNjzi6YFb3e398dkcFxrjyeY9ysuppVcRC9rPjoygQwZddxX?=
 =?us-ascii?Q?7GmXqrXhb4QN5JAe7gyDpHXXEcMvuCXS2HceXvfizdZDRZCXr3lUoYi9aVNK?=
 =?us-ascii?Q?qi5Q/zpqX4rKvC1lwejy+spC3BZCd9fSlNNj2p2hB9IMyGRI7xksdHNRikze?=
 =?us-ascii?Q?ocCfGOQo8cXDA148SuM+sfBrTbCgQtpjSrx54kC4gWVKGXMqzj3rDoDDHIat?=
 =?us-ascii?Q?f3Jr/YNlpKexUo+zbPKg7QJubcYNDXAmLxSWkXKzZgvExnUDKx39SqlP+enx?=
 =?us-ascii?Q?zqFx1ir6Ccdj54VpKnTENg3yDvLJSz5lP3L51ce7NPlEyzRYX3aRdVfJBOmR?=
 =?us-ascii?Q?PinEADMe2wS/+P+18IWzugEWWqJ6mWgeINMSNRoO7vr/36llRs50hFHBJ9MM?=
 =?us-ascii?Q?5fMx+TnQhYehSdDG4y3hgjzE/G0bTkP+AS+18HZPN/JDziVcscx6kzCRbPih?=
 =?us-ascii?Q?YEqHNrDqcb0DTL8LleMyBzfJtXQF6+cyHKRUB6W30NSrT5ulzsm5tH1yUnrz?=
 =?us-ascii?Q?ZpioX9FHoUGYVKh396uqY39RyBwGL6RWNOxH9mi/6ZHIyqUeZal52hVsXd8c?=
 =?us-ascii?Q?2fzr/JgL4h0QuEkLWZIx1G0iOKppNDDgJE5v2nO3KFJikGBfzJkX4Fy+g/C6?=
 =?us-ascii?Q?L4aLADm4BWZuUoKpEzugopqyfn8YQBHnrm41faSHWEjK2L+OpHx73Sh10C5n?=
 =?us-ascii?Q?BPt2OzLLXbL/P08+iIXGg2y0N+/odO6aTZFrY3qzULn/6sPDMd1fj8bm5gbT?=
 =?us-ascii?Q?dJ8vxztSBlHzH5Fo/AVnRT48Ok3j/JlTdaMWYfRgXJBx1qsXI+ehOukjCePn?=
 =?us-ascii?Q?Wrgp6tLMVhNd8zjT38z+nwNfs+PnoYV8hF4Yp/DJxxews7KjfsswPpfox7ML?=
 =?us-ascii?Q?TcJWPeh2dSfaAqYSm97At4SUGrgxXxL8qJj2PslY7+ZJws8zQ23FRWKa2KPL?=
 =?us-ascii?Q?zdGj6A4WsqJncIx+clLR3EB7u8hpYvvAB7pQwTzzpRwkbqBSBAHH3cbQDWT7?=
 =?us-ascii?Q?tre30r3gtx3PZSKyClnwCYQl4cdiC2T2HZnCpZKe4/t3aqQPlp/zzn4Eic66?=
 =?us-ascii?Q?MtpTc7Rqg5oy8Wy+OC6LFH+NgFw4EzFegeQwwnGTYV//geUmrZzVFksQlobk?=
 =?us-ascii?Q?+miT2+ZbsoI1a6XbyntPKaF1ZQHs6nlOe2vWcoa39WPrZoaFSTScQ1fNL35l?=
 =?us-ascii?Q?4wj/4Cxezn/Q1ow=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:31:03.6558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31240d0e-3e55-4034-a6b0-08dd549ccff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

Introduce `reset-gpios` property to enable GPIO-based control of
the PCIe RP PERST# signal, generating assert and deassert signals.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
This patch depends on the following patch series.
https://lore.kernel.org/all/20250217072713.635643-2-thippeswamy.havalige@amd.com/
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index b63a759ec2d7..293ed36d0cea 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -33,6 +33,9 @@ properties:
       - const: cpm_csr
     minItems: 2
 
+  reset-gpios:
+    description: GPIO used as PERST# signal. Please refer to pci.txt.
+
   interrupts:
     maxItems: 1
 
@@ -63,6 +66,7 @@ properties:
 required:
   - reg
   - reg-names
+  - reset-gpios
   - "#interrupt-cells"
   - interrupts
   - interrupt-map
@@ -99,6 +103,7 @@ examples:
                        reg = <0x0 0xfca10000 0x0 0x1000>,
                              <0x6 0x00000000 0x0 0x10000000>;
                        reg-names = "cpm_slcr", "cfg";
+                       reset-gpios = <&gpio1 38 0x01>;
                        pcie_intc_0: interrupt-controller {
                                #address-cells = <0>;
                                #interrupt-cells = <1>;
@@ -127,6 +132,7 @@ examples:
                              <0x06 0x00000000 0x00 0x1000000>,
                              <0x00 0xfce20000 0x00 0x1000000>;
                        reg-names = "cpm_slcr", "cfg", "cpm_csr";
+                       reset-gpios = <&gpio1 38 0x01>;
 
                        pcie_intc_1: interrupt-controller {
                                #address-cells = <0>;
-- 
2.44.1


