Return-Path: <linux-pci+bounces-24328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCCA6BA0E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F3D19C05AC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6322225788;
	Fri, 21 Mar 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ox9BCuiq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7C22541B;
	Fri, 21 Mar 2025 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557348; cv=fail; b=PsfY4zt47LOvijM+B1r9sdcwZeCaGcRB2KcZlerDn50Qp9e+tlx3ybfPelX+XvkH33FRN/QH59c7GVJVk9lvXIGzcflpJ1ujQINevzxfpnYoCfvLTz9P55HPddVDpTkQ+bhtLFFtLbsHzz5wPfid/MnHIPaIYVX2cGlibyeBgvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557348; c=relaxed/simple;
	bh=4pC2JhDWNl96+B+WQiqeFuiLfNaWqGbLdNUFk8xnDMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMHh64mVc+fZNKZY300mxQx5xm09l7c1zWUBgZk3CTN8LwjSWGzOqxom2kFBrIvwte1vIA0tgtbRF9LlQnNm31CAUF6S5C1tjFjDXfpMWWcHerqS3klcZwb990lm4WrdRstQwmRJ3OnEwVCUinEyn/EgQPGetIZNEJPkiAmKMnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ox9BCuiq; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rtnw2CkqjoRNnU9ClA+MWcdvEbyb85J4gwgUMsDZEU1ANBfLmnII1pxgZCV8tktLABaFMlL4G0+AGhpAzZSWMJKbBt1W+QV/zbD3Ymp7fgSkRKQXDnZyuk/1fsddANvt0KnZ33UrYE4ihJHEXQbIPa+d7qI5HdgqRtBe5djyy+M547vJ/22Ib9QEKXS7RwGvbhFj3ga6Z+OMlN9xrMelDCewRumbmGlYPFg5sQzjq112tbd9qXlENh8wtH/YK7n4VXlQiacxCVoUE9WgsfGus5oL5m/d+HfDnYkqILKz0uXAY9CPw8Z8v4/kncMJT8et+LXRhfP6dpMncbYol+SqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/q068apIxm75pdW7/naRuAqH+Pig8GLGKBGFR6+No0=;
 b=TMQZ3SdPkcwdyyZM4D/0RC8m2dL3yWsdXmxNzl63NV/RwmHV5TTRjGpjBX3j74jyisiUdA77/XLSbS1822AmGFGHm1lM+ilGf60TvFHzfo2+DKXun3eoMMoENBCFgJiapy1/egd4Pudok02Ik7cECu8ov457DFIYR4WUjE5jBR658X/aWhNN1JrWc+617jJdAgn8T1GO3ayeYdwHO73YMIMT08vR2eOk+UcBtUpjvf5gYwiMmv2lMt7HuRthW2h0rSJQgZfkThsPvds8/gayjCWP6OvichqLklc04DogsIErMr5TVoT6Htl92O8TbfSPqW3Ze0NdswjOR52jXAto3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/q068apIxm75pdW7/naRuAqH+Pig8GLGKBGFR6+No0=;
 b=Ox9BCuiqx0LjvNxEGrJam0G3vwmSgTmGoMsIQaI0on8Jj1P/zmbszh3b+Ppo1VSNwT4w4EqKhxujLeO5AXpu0jXkOCoNfp72mjv8zeGDR6/H4HHR9NjGaq8wbQi46DkxvrjtOGD7dyQr9LOV7iTcPFmT4fJ8szv9vuJFNfn6bMk=
Received: from BY5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:a03:1f4::45)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:42:23 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::d0) by BY5PR20CA0032.outlook.office365.com
 (2603:10b6:a03:1f4::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Fri,
 21 Mar 2025 11:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 11:42:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 06:42:21 -0500
Received: from xhdlc200235.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Mar 2025 06:42:18 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
Date: Fri, 21 Mar 2025 17:12:10 +0530
Message-ID: <20250321114211.2185782-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
References: <20250321114211.2185782-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6e77ff-56c5-46ca-e75b-08dd686d71e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHwlkLjFGY9HZ7zrPpQw4wm4FBfWbYUmWDajdcU1CydzZWabUlGh10App75f?=
 =?us-ascii?Q?G6ZqRCgFX0PGJrz+edwufRkTR5pY3GOD5GcnqcrgzOOoQFMeQ22+qCaWHMoV?=
 =?us-ascii?Q?3DCWmQkzXesGEeNEc/h3oktNu3UIwnDrbPGKB+15ijzS5ejywAkwvZuB8s3V?=
 =?us-ascii?Q?I6rrUF3orkVbM8FROhCjjYXPNZ8RVpwqGiWxn/3usNLzHGYGnRqaP4BOdBK0?=
 =?us-ascii?Q?H0Qo2a0jE+n2QotwY0T4C7hVPQWcaCCLxWzcIFoYc8VPcTblCGiQqQ0TLD20?=
 =?us-ascii?Q?3/b6B+eodiX4UemWRT/hHohqzpitlFijSP7upIEy66RznhShc55FTz9gzBig?=
 =?us-ascii?Q?hf20oAglbTlonSSU1oZF9ggaU4R7fNR8Cl652zz5/YgevdUZp/dJV2g6ohKM?=
 =?us-ascii?Q?T+0HA1BPoWfAH6RjEFSRV/y0wLcJ/8rcz2MJZ1aGL/oaRtJV0vYvGl6B6nWy?=
 =?us-ascii?Q?O/u4fxkHjyo1hv572EgsRmEwxzRd9vESl7b0eJktfR/8ygRpny/LYztYlh1B?=
 =?us-ascii?Q?YX1xxhEW/HYQOkuhOyBQ9ofcJcOpA/JCpXIR4Vo4wJbaYAgLTMOlx8dn+4kA?=
 =?us-ascii?Q?qmUUJBAYN/EAHVvn+VmgHCbv0mWmytBnZHo9+9GivcFRtJqMx082v66FERZh?=
 =?us-ascii?Q?Z5fyTPVabK/bMFOAWZksCiZH4PabAniiR8TwOz0lO5X0A88Fh2JFZ+rn3trF?=
 =?us-ascii?Q?T2J61X/QM5nrUTAmPUnH5BkEvp/jXvOHLcCIcDxT7/ft4deRJgpcfltdmOJr?=
 =?us-ascii?Q?nAho7cC9Gzc4t1OyU1KB8BneTIlIyhIJWD0fhdWvNVgWkKHu5OME41HVSZNJ?=
 =?us-ascii?Q?MnrqUTkhcJWAYF4Q/AynjIjoNY7iEjKkgfEDDSYx/byUShmMd3qYF4Mn5Cf9?=
 =?us-ascii?Q?fhy1c3ZxmCwfz9Xgex4Lx5YS9V3QSe1/7Iktyws0CIClXs5yVMefU544IIMd?=
 =?us-ascii?Q?m6GBVkKwC8cc4ReCnBrhJUksgkUX0O5mR0qXP7nql27A/JOt8MAQOiRqQqH5?=
 =?us-ascii?Q?eKvcgsFSaZYje4ueRPQ1w13oCRVFOZwJtXpVQNG7Yj3Q+Ssb+rgbWBcygVql?=
 =?us-ascii?Q?AJEr6gsa7VNmzOPnVCs5J96ODUr5teb5EaGGuxnrz7A6KC+U3DFcjzuhgc7b?=
 =?us-ascii?Q?AekGnsm4PSiCHLdiEcBQ3iECGFPOWUpFmJDb5ufXhp3+QUJZQx28Sam7QnEv?=
 =?us-ascii?Q?jUd5zSmT1joR0ao6+uR4q+Z98VgyXjo3Ndg8zT7Gh4D2DcsqQ4SULkzg9MP9?=
 =?us-ascii?Q?ZA/6V31w/agSTDH2z6ECjeQYxRmJFn3vhlXOum7m1B/6luTqrjIsSJnfgNS3?=
 =?us-ascii?Q?0oQDofhTAxQRIK9GwAS98L4l3cTJptOROQw+DYilZwUr6XeJpYwSjU49ILRn?=
 =?us-ascii?Q?bh/LjjYvxVYOHxr3/eF6PLYAbxrmxAHdLhE1BHObANqqbME8qzUfqwhWuOFy?=
 =?us-ascii?Q?EZrmqKouzILRytLyBYvOxFNDOYhBPdYdrUllYFY2HcJ7DzjIDSs5dZIb8xPb?=
 =?us-ascii?Q?qC4F1kp0UKVcP7I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:42:22.6975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6e77ff-56c5-46ca-e75b-08dd686d71e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

Introduce `reset-gpios` property to enable GPIO-based control of
the PCIe RP PERST# signal, generating assert and deassert signals.

Traditionally, the reset was managed in hardware and enabled during
initialization. With this patch set, the reset will be handled by the
driver. Consequently, the `reset-gpios` property must be explicitly
provided to ensure proper functionality.

Add CPM clock and reset control registers base (`cpm_crx`) to handle
PCIe IP reset along with PCIe RP PERST# to avoid Link Training errors.

Add `cpm_crx` property between `cfg` and `cpm_csr` as required. Absence
of this property results in an ABI break.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
Changes for v5:
- Remove `reset-gpios` property from required as it is already present
  in pci-bus-common.yaml
- Update commit message
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
 .../bindings/pci/xilinx-versal-cpm.yaml         | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index d674a24c8ccc..293df91d4e74 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -24,15 +24,17 @@ properties:
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
 
   interrupts:
     maxItems: 1
@@ -76,6 +78,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
 
     versal {
                #address-cells = <2>;
@@ -98,8 +101,10 @@ examples:
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
@@ -126,8 +131,10 @@ examples:
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


