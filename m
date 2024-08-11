Return-Path: <linux-pci+bounces-11580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201DE94DF9A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 04:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9B32819B7
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18ECE56A;
	Sun, 11 Aug 2024 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1TnvNGmp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F479F4;
	Sun, 11 Aug 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343049; cv=fail; b=Ucoq4L1A2G+gq07ny2euc4vJx3H8CGd/2ghB+Tz08mHeEZtIcevA8xQgYHUFcVNB2Fs2Psz69+XVZa6pN64GU/eYk/Zxz0nlKkGxxl2wNGIli/Xpcyr2nQI5Yhdzwx1FnB6yCGBSqy10BG8h/9X7fk6IySMV7VH6SS1lhvv48A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343049; c=relaxed/simple;
	bh=KIJJCML5y4MGXhZG5CnTcpRn80+GmFEf3I8cKdJgXgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeQE/qvbGSssLigUrMhxLC5nhej4VbZzujNGPN4JAcegeDRKX7k4Ist9cS6OiwyiLUgoPCaoSHjN7Y+pdiQXKwPpECuYk6NCp9XAjK/dzzg88w+wH1IWTZ/b6u0AvDgJPBTFC+uvem4EDClf3u1N4CyXzklum1wtmWXnLe2qpuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1TnvNGmp; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBTNzUHd+MCEl8jj0OFLktEgzZXTctqvt5/qZOs7f3A60hQr51ElT/ceIcrwK7odXPbFFhUkZuMLNaZFm4hxsIBrbmsQjn5h8DQcinPVxua3upqDDL0rlpSzJMp7sNcQ5CvF6824/uL4I6/f7scOgCA9IYxBZjsKXtZaJeklZoARfX03gG1EfvtkVxoytASyGi0EdeR4n6AkeZptFU9jSoRd70jJkAso22R7PcNmmye5tl0kO9xIFT20PqXY2YguI0TQLAgkvyDFAb3XO3rbEoC+wee8EBDc4Q8wnJT4511KyqbXPqouyqw8yzD/rInRBYS8vJ9zks0JUtGRYwT0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDn4YgdMskOZ62kHhogOexozy6HtcQbqMppXEvwAX5o=;
 b=r1hWbc2dmaUdVlmZ6gK01kpIgoPMVCjNqIvirRAUOdBZbxLcwfh3H4U6qdC4g4FPf96WeJuekcrTZ+/5vsOYlJxMcZv+E91R6KTtxZ5f0u0r/w1lgOsGRU3Pu/7CRDoRLnN7O2W/jXGoAWk1EsiBHk7ucYNzLyyu/tYbgz9rG9tuxde9aHQI7l2ITzCKp28kKNKNNI6A6UQNYa9kmh4jr+MwTEmvcLwJR8vLa+5YFP4mGUnZ1gaknybhChKSFiBHz/jDXHwzrZfTuVnWpf82LAEhjIFUspOno0bkDYzGrd0UqQlyjOIA7DA3Sy9lWdb2MS+2EOKXL/uLxMeo3Jm2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDn4YgdMskOZ62kHhogOexozy6HtcQbqMppXEvwAX5o=;
 b=1TnvNGmpL2quJrAUVS4089clvptAzZJ82QiayRSjaki8WKn7oBiGBOO87Z5CJ/fCzzuS5e1uFyGe24wvBX1IJtSIq3zW23elKQ927Fz8icneDD6k74UYHteUiRoC6tfaEXbAa/eJZMO0lvV+tZ4FqST+PdkpdUH5VA4idJSOwBg=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.17; Sun, 11 Aug 2024 02:24:03 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::c9) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Sun, 11 Aug 2024 02:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 02:24:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 10 Aug
 2024 21:24:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 10 Aug
 2024 21:24:02 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 10 Aug 2024 21:23:59 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	Thippeswamy Havalige <thippesw@amd.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root Port Bridge
Date: Sun, 11 Aug 2024 07:53:44 +0530
Message-ID: <20240811022345.1178203-2-thippesw@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811022345.1178203-1-thippesw@amd.com>
References: <20240811022345.1178203-1-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippesw@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eec6e90-c03b-4f67-538c-08dcb9acaaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Sjr9ImFpCwroRjD6U4PSWOoAv3YKu73okZ7+fbHqdUQPuRCs9eRluBeBM++?=
 =?us-ascii?Q?o6Oj57ky4VPC7tZoe2hMZzlKQXZB8Y8RbXqBXIw+uA1Y84+cWSB/F7HoitEk?=
 =?us-ascii?Q?g/8/j7WPI4FfhwJT94pk/ImMrzx3L7PNzizwi8aPuNF0iih62xw23+qsXsbO?=
 =?us-ascii?Q?x6hPARF1vmQLLj81IygBGq1kiDIrD7DK76S39shC+RbQhU9pmc3DslSynBzX?=
 =?us-ascii?Q?XJUuTIpTU1v3DvaI8G5WAM1ft47oIwle2j+LdaUHx90tK2HXN1TCI0ZbKJMM?=
 =?us-ascii?Q?++9OLDgIefudCMwvX20qi/To+oz/iZM0lGilj/bXtsWVNOnWoLM/70M6m4AC?=
 =?us-ascii?Q?2fWOBtPbXzsv2O0v1SxJbhFOU+vG+Rc74+AEoFMmBm+Dawillp6ElcHDjMk4?=
 =?us-ascii?Q?eAOx7/kcWVN2xInry73jHJxQk7KNZX2RpqGbs3ai76yN96KmtKPLTVx7MI4E?=
 =?us-ascii?Q?0GpGqyztnSHExLwdc0onkX2vamG/DQE8fjoRSzsYavsu7NEY/2zdZjUEOy+b?=
 =?us-ascii?Q?h+hkOUEUG7F3+fhNJTO47ZI4c2lI+I5GsZ/Mtiy84RMC7tTcvuwQqlf9R3Mf?=
 =?us-ascii?Q?c8zjFEwbLKMKuzhvl87lm9ravbvr+Zl96sZjzVYCDs9kMEJ3YeVo39wH2J05?=
 =?us-ascii?Q?N3PEe4hXxBP4FsP1l/8A8PCBgaaDMnvyEBs1xGekf75ZotHkwlB/5+7kg7Wo?=
 =?us-ascii?Q?K7Gc8eBTojGc8TtN3XRDJLSMO2esXL/skQkez3bgfHA3+M4+ayo7otFCI7Lo?=
 =?us-ascii?Q?YeK/e6g2kOh8sYW7q1y5IKMMr1zXoySekrLIpJogsMJmZv9jHsZf570hK8DM?=
 =?us-ascii?Q?ysDev2QnLY5EXw8DYzHSG1HXQxipCw5AqU3lKhGlHsUx9Vs5frmlm2pzny9X?=
 =?us-ascii?Q?17sQB3bek1dLELV6Jmm3snLLY4Jqj7KjW8RN9M7ObrDu6YiDgptvyUiBB+83?=
 =?us-ascii?Q?ZIJ904sikJyNOJmBqOTX+cgUiTK+JQWqb1LqOlJhQwoKONVytnpTwtVgANMO?=
 =?us-ascii?Q?7xzWilX2RcjVqpPEeoXFM78h/BBEknrILsyVeXTvaieqdB5kIR3a20DkGa8i?=
 =?us-ascii?Q?ZIAQj3jZZNk/Z/sXfEx4qn7XqUeF3XqRHghugUmKSOI3uLHT4achbEN//EEw?=
 =?us-ascii?Q?vtz4ThSZUnnK7qjwOMaDv0+Eq4fp46y6+B2TJrONQcyWFrkTkYcJP/Z1+lqo?=
 =?us-ascii?Q?i2bLl+9O3+KywtHQl/5hKC8NiPmCKMDeVClLUjFcMwmn5qtV2dQinz9hT/Tj?=
 =?us-ascii?Q?YE1I079j+4DtAr0CF5bGUuO5IrOpvY257dW42tAtTFdDbSPbQy5cpVlchykV?=
 =?us-ascii?Q?MHWQokuDNRkgtjdVjO1rvuk5VfTjCFnoUA4WjcOdoF6lIJ7yiIG0vfz5e1Wr?=
 =?us-ascii?Q?SSNv0en2NtTZj1RBRjxf3NYAhHMhPPG1RiprEZOc3Bi7Mlp57vcAN2zDgAkl?=
 =?us-ascii?Q?ekZicIY6jU3cSDfe5midKB2Q5rkSjP8o?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 02:24:03.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eec6e90-c03b-4f67-538c-08dcb9acaaf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

Add YAML devicetree schemas for Xilinx QDMA Soft IP PCIe Root Port
Bridge version 3.0.

Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/pci/xlnx,xdma-host.yaml          | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)
---
changes in v4
- update IP version 

changes in v3
- constrain the new entry to only the new compatible.
- Remove example.

changes in v2
- update dt node label with pcie.
---
diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
index 2f59b3a73dd2..f1efd919c351 100644
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
2.34.1


