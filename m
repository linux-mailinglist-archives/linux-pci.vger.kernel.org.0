Return-Path: <linux-pci+bounces-11523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F270E94CA2A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734221F27819
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973216D33F;
	Fri,  9 Aug 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cM8XEmyQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81116D333;
	Fri,  9 Aug 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183828; cv=fail; b=OG0Y8n9G1NwEbwK05LF/6NJn9MPoKPlS3VcOSLmdW8f1Y8x8ckUE1Fvis3VzsKFbb3J9CRYswAvUZAnBw8/ngNvjd6ceLUfRtTlFRnjDXFNPhUegYizWQMdYKVagDpsd+dpriQ2qkO2VSr7bNHNYoO+NhVdUKvkh27wzsw4Fuz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183828; c=relaxed/simple;
	bh=Lhd5vd+hAR1jUFo0cwuDRadBkVN5dT56cHZuax9ejK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0L+X/J/k25lvMDV4FErJ/f0xww5j8uh/KZndJ5pRKU4wcIGZGjrE65lIqH2nuppXqOEuBh3qTrtljDK7Np+pKTp02keYGr9mEHJn0z8YH9HynLTVOYcbQXlaoXZwtWobCxM91nF1GM+I8/00h7798PDMQECHbNkZOwC6d/kd0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cM8XEmyQ; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TAATKIRWExbH5cSaxdkEHtRyOY547YajfZL7PvGAe7OnrMb21eINGUOiGM+kucFKPlIgVGJnDj0+sL+Lamphdox7LMNge+XHA0iXDJmx+VjGbNRfN51NKDavnz4Xt6HBlAitbouqv2Ah75SU1TqbnQqplDIsNa/nrluR2CK5/kY5ffveEBa6UECM8pYccfVlq9zmsHRxXfPjow8oqYeA+XeQ7fAnE/uFg+Nbh8FlmabMmLQCIfL6FR0KuXOaN02s/M5EdL5N+6CTSlkyqn+HcTFUf6jXOpNPZNP3+7c72Hs7A4TmMLc+YyeHfBKL3A3YKt5SD1i/XRS7w4xUVTC/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fgbu+vmMtWkXTudPY9JxMV+R2mA07ox3D1YVBDgvZU=;
 b=NuKhtSh+Jo+hekZ+J1MSIiGO7w1cD945K8HR3NX00L8IL0V/PLmIxi2R844h84Qip+MsefmZ9F+8EsSaVCknjB4YG86NAo4MQfT06XUpNIOqEqdsRvc043LhGjxa+J2wFT0DQHdz8E7xZiDFCarBsgJo50lrSd6d+ztSUySpeDfvp2NDyVJrOSGFajCKnRCTMvuuEW0dS7lR0BJ7Rg0H12Ml9fDoFEewDAgJA/DGr4hmYc0dhAUe9ACz1VnCUHlCsxkfSPRPX5ExA5AgVqzeLCGFLbpzcG4jkE7Kb3bjl8+zPG650phGrU51gnDjJl5Vwq8fV+Zhn3yc+3OpilsqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fgbu+vmMtWkXTudPY9JxMV+R2mA07ox3D1YVBDgvZU=;
 b=cM8XEmyQYj7qJzris0KVQ4FxkeQq158lH0qzsGlawkXFGNaVgFdfbIlPU/PhXDOnrasxHRHCpXa9Af6hJrpunsqSf7UlTiq5hACcMDHWwOo57/Yr/lWiuDX49X9VbY97HsEvkV5riZtLxIgWgXxhkgEoA0QnJT8SuoFmnvoNES4=
Received: from BL0PR02CA0079.namprd02.prod.outlook.com (2603:10b6:208:51::20)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 06:10:22 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::71) by BL0PR02CA0079.outlook.office365.com
 (2603:10b6:208:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Fri, 9 Aug 2024 06:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7875.2 via Frontend Transport; Fri, 9 Aug 2024 06:10:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:10:20 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 01:10:16 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <thippeswamy.havalige@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
Date: Fri, 9 Aug 2024 11:39:54 +0530
Message-ID: <20240809060955.1982335-2-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809060955.1982335-1-thippesw@amd.com>
References: <20240809060955.1982335-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfb3b19-edfb-431f-e833-08dcb839f310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6RolUSKNW/dlVQIwYq6JBF2xuKJoappCuKyn/ldOi9v0x/4Fjri+xJVcR7Ah?=
 =?us-ascii?Q?maNszPv1mJMcFJbB5bmEKEAPE2VsVKvLpeU5+cs6/4CN4Cj6rMI82LoqpoST?=
 =?us-ascii?Q?R5AYDm95bO6hX4rfEjQlzMd/pRMbs14HYwPAJjvrPhE72Q8/h49BUkzOL1aX?=
 =?us-ascii?Q?+y1Xngi2tJlxeyu1auByjwyfUlYW06bjvhVSwegLhlAYhut4QtOSvOjTBYvD?=
 =?us-ascii?Q?I8n7/Ww6lC0D1EzV4roYyzLu0bOGdjlkRK2LsENYjx3LCiRAsbgIMDqUB0Qk?=
 =?us-ascii?Q?9AOpWqPLh6iiP8w3A27pZVwgvZMwGLmGakgnTULJmyCjCrEs2VsJIxZrXKsO?=
 =?us-ascii?Q?46ih0DV7kQ5j0dkAwRV49bdSCjehSvcMCUGa1It1laAkbkB5WGCEa/xqqt3j?=
 =?us-ascii?Q?wcYpK7x2IRL011aahRMCN7bhdvB/+j501K2X85ZdtdR707iEpcX/tQHutJoY?=
 =?us-ascii?Q?4Ow3sJCb8UEOhh9pwtrMRq94lNro2DywuA09aatgbEQy3VvpZ51WOnvqKFsi?=
 =?us-ascii?Q?9TLcA+6Wcig4TozlgJwAUkcjGxZ+X1xpKOgWjBhQDPvYyeQskrYzB8UlLqwi?=
 =?us-ascii?Q?iprHmNpFeqJSXUTuFZ+tsCKW08LTc+6KCA1m0sh+0EJSabVNXw5Kq3dncR5y?=
 =?us-ascii?Q?ymYYOne++HiMKhHl4tQckyKcndODk2ywsO+a1aJ7MQp+FbUA+PQD5tZJSUoc?=
 =?us-ascii?Q?MgYy/buE/xY1BhtkWhpvzhqNQTpk/TklPYYoo5RdA7oEMIBZknDfiRo1KF5J?=
 =?us-ascii?Q?76PH/JkzuC1Bz6kvWKB/qAWVm73cHUh7Moaw+essob6rxElEmO/rgXk7Nd/D?=
 =?us-ascii?Q?UhMjdol7SSeLUnERVO8QR1ZhUiCWX5feqJhhLMbF0VsszRbiGkA37hH9KF8+?=
 =?us-ascii?Q?+VTcTExQOPUbgwhqEDWn6OTq35lijXTE1MH68qMXtC7crAg9s+nRXgK3rrSt?=
 =?us-ascii?Q?yBQLGzo/OLB276K+R4fPjI9Bj1kz81O/sCTXG0B2qHYNjcJcZYJrwAl+nXaH?=
 =?us-ascii?Q?Jx91Rx4Ic0u/SRXspRMUjK4MuKc3f/a52mUgHadkAyRfHe8zG+Zv/LWsmu2C?=
 =?us-ascii?Q?845fwyJVAO2bLSW5tkvhUr3WFav7JHDyejUwEpTeHii4lkwoS8ap7k+e6AUa?=
 =?us-ascii?Q?9qRFshmghlpDsXjfNtYGxQ7lJZTrYhsG3s4eR4+zMlNoyEUL0r87aH7UGOpA?=
 =?us-ascii?Q?nUC/Xnk52Z30cuIYpJ33nZ74eF8ZxMvLPY4kbdI2d+v5W1MHrzUxy2IWH0wv?=
 =?us-ascii?Q?xvP2qfMTc7q0kKopya7X3GYywRDPlNhvKia0fHTYMYr5bTezqxNGH05aCsHW?=
 =?us-ascii?Q?t7KBtgp8nTjQ8xWUvri7CRA+Aadj8rsYlETKpTtxiu0oKXk5hDxp0w+aNi5y?=
 =?us-ascii?Q?9ktNGFMolGfHg32bENv314QJelON4xK9GXxCB8Ylva5w+X73IkOqApkwf+UT?=
 =?us-ascii?Q?tB+6EOW+VmyuSKKdnmAjauxXlpyBOeq1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:10:20.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfb3b19-edfb-431f-e833-08dcb839f310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
Bridge.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
---
 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 36 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)
---
changes in v3
- constrain the new entry to only the new compatible.
- Remove example.

changes in v2
- update dt node label with pcie.
---
diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
index 2f59b3a..f1efd919 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
@@ -14,10 +14,21 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,xdma-host-3.00
+    enum:
+      - xlnx,xdma-host-3.00
+      - xlnx,qdma-host-3.00
 
   reg:
-    maxItems: 1
+    items:
+      - description: configuration region and XDMA bridge register.
+      - description: QDMA bridge register.
+    minItems: 1
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: breg
+    minItems: 1
 
   ranges:
     maxItems: 2
@@ -76,6 +87,27 @@ required:
   - "#interrupt-cells"
   - interrupt-controller
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - xlnx,qdma-host-3.00
+then:
+  properties:
+    reg:
+      minItems: 2
+    reg-names:
+      minItems: 2
+  required:
+    - reg-names
+else:
+  properties:
+    reg:
+      maxItems: 1
+    reg-names:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
1.8.3.1


