Return-Path: <linux-pci+bounces-32583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A9B0ADAD
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D6D1C2453D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 03:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A920458A;
	Sat, 19 Jul 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q4icfceW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF917BED0;
	Sat, 19 Jul 2025 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894611; cv=fail; b=DQrsIeOIrJsaThWLjB73yikvEZk5ZNx9IFCf/BMkT31dCBzrXxFWLxT1DOzGt+t5SxRAYIzAPMCjqmCyrbKthw2wyFqCVM2mYjoNe/chJLtLVYHpEPgK+6e070fTMxE3ZyipT8Z3xy1nkJhLkKeYn9vzjY/DaGsMtbVjz5oaW9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894611; c=relaxed/simple;
	bh=JaDve2zStaDAx3DqvqHB6+4OftksCrh79rg0CD0j7vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihclCQ1JEdiqWEQ+xmRRFdh5DpQ2asdL5Dpi9lBX03Dnyew04U2Os5YnmAoKlgZHmPIQL8dMFMdwAwuOGpjZ0y4Xqed3kAEmzeoYi9mYdD+GzlFLVNYWCI0IfrSq1EGL6N3M3/0ORmcpk9OhMwcNB3kMfhtRWrlZ2wFNYzf+QNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4icfceW; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBAJle7UKVBs77lcIAr7qFn4kXVltZzXYXyWCZsKQfMGmlM8GPQZ7TqxE08/uSSUbGFQmQDxKygXD67hZAmC9yfy2l/YCU31j3flmZmupIy5F+6gELfJiNxvWnK+2fmTp98jJJw/BEcQ/C1QZy6PS4I7dKfPyZCAF/CocOdMdx/vD5dlOJGyVLe5X7LcSekIMItRvI6ACU33FjOLP2Zl1/ODhUGc/hV4L+29h6lIn9DbBNU5FUWg2Zuj++oGCRSMi3tIypdLgNVe+NW2fWtieKBy64bU8sgoArHkUxUFVDhOn0dea217PILyUDAu2IqpJWv8eXscmO6orv6Ti7X2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrcQpcMg9KuCgTSC01Va1qawXY6SSEg4DQnDU8LXkQo=;
 b=oIRvqTnZ5/DuRYGx3OaM5Q42WRdVfUdH8PUrwOzvrWHW88kdsFWLJEdXLQBtJv2y2T0HueYV1rWdpEVBJKiV+xe9CkOo/3RnooyJjr7+IvrMbpi+G4OTw0XM2iNBfRSCazQah+/ke/2VKMj25ANYkzJitk8ixiw1HdwWneXqhP+kl/IjhjqqsRy96gXYP2H3yBFQS0/9vgPTa6jRT6IrzE4kA95ADxJVR2bJVxHg9aI0AMaq9xgKLMJgIM1+eWCrnwAQGizcWTG9iBWoQ5uCoy3JMOflhi7H+J4sDk5so5padzUlKHpGJOsoZ0U+jrJaroKCgg79bK+WO+kmDZ6Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrcQpcMg9KuCgTSC01Va1qawXY6SSEg4DQnDU8LXkQo=;
 b=q4icfceWLQbXnTacSXmOyzfjySeRzpG0LtHZ6hoGxGKVPUDHpUkrbotlvYra5g4lKs14l4+UnIFFgAR4REmvgb++Yl+DdaHQCFbw+NhwzcSrGOKzBae9o9OlHA0Fa5B2ELYn5XA1JEGF70H2wK7B/ZA4aeSA9SA1af4xsvI6jzI=
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sat, 19 Jul
 2025 03:10:06 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::7a) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Sat,
 19 Jul 2025 03:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Sat, 19 Jul 2025 03:10:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 22:10:02 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 22:09:58 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v6 1/2] dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe RP PERST#
Date: Sat, 19 Jul 2025 08:39:50 +0530
Message-ID: <20250719030951.3616385-2-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250719030951.3616385-1-sai.krishna.musham@amd.com>
References: <20250719030951.3616385-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcaea5e-9a6b-4075-8c36-08ddc671c311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aamQ0dy4madvd6DJ3YeVqaeBQfQxv7vWNpiLJuV1At0j9h35f8FzIQRru0xJ?=
 =?us-ascii?Q?taC9vDt82VewvfQ42k9LYGN1xB78naNwbu0uBnH4KFCY2J5DLR1RCXlJCPAE?=
 =?us-ascii?Q?LtGYDcB0tQ9M8QPwx0WCFiLU8AomZ72X6VgR2kFkvdCHS6cpGUZ1NiG10Uvc?=
 =?us-ascii?Q?kR+7IKbR47wn/Ro/m9e9PHNR/U38wpFdxn5MX/5/dqow9Jw3EJZP0okbfQMf?=
 =?us-ascii?Q?UicJLUQ4fN0mzeP+I0XvKojnmmCErE4TjF8F9WPsD4hswv6batURzkKE4iTi?=
 =?us-ascii?Q?9LTx9z6o3WNwvq4prAanlKqyIyvqUaVdkMSsrcLY2CJGVFpI0PGtM9acWc2m?=
 =?us-ascii?Q?LvY7oR5Z0oFnwB5E+ANE0Gc8+agznTDU7xMryjXogsfOVPX/+iicYoSuV188?=
 =?us-ascii?Q?bDHe3Vo06RWLEs2MYF3yQBvdkcenzgp1R8oLYeM8a/wwUzuEU7gHwQhd6f08?=
 =?us-ascii?Q?O9MR75IhlhF13jDw9AyC89aHWhJpykFSbKjG6zLF0I1DmrJVbXVMyQcis1c7?=
 =?us-ascii?Q?eEb+Q02rASE1mGs+H8OPtrzSrvFUy00HRkuHFVPKdMvTzMdj+HfJ59hqDt8T?=
 =?us-ascii?Q?2tHKJP44WHEriYeWaCaA7lUEunf+TEiy2ARzqY1lpYFKzfyPWQ7ZlfxMXaE+?=
 =?us-ascii?Q?RxXY1jnCG2aPi3pJTEt3qT7f2WUXKv3gQwxGMiCrqoh1hy/cTrIikeLbpwmn?=
 =?us-ascii?Q?XQGHiYdVclSo/M15TKbu85Eq6GPP/s8l5fXGFbVEurasMfoXNmZ8MhGE4uu5?=
 =?us-ascii?Q?uzOAs33vo6uLsnBBHiijmSueMBDGpRmPtI9ndiNI0DEblMrIJfeJ/mlqbrf6?=
 =?us-ascii?Q?tb6b4mUiwx2pS5mur4ERW47D0A9jGJs+lq34NHaLBpEqu/Kfy5U2V3imx1p9?=
 =?us-ascii?Q?ExmRA4FLY/kN/TnCF0Xxv7p851tOWoPrvTCYOIRLkN+EySJ/eg/+/Sr96WQv?=
 =?us-ascii?Q?ubEoWru2faQaF3BoHM/lc7vZ7Jm7pB2JDP7EeVQKrTsDx3X5Hc+EgrTvJffq?=
 =?us-ascii?Q?37DW6Pf1NMYc/nO78d7GMFG7AQ2ykekWn0ohuuVWv0aOFi1dybVIY1gjqXKl?=
 =?us-ascii?Q?msKC/ahkVl7I+Ddof37Adr5AhgpzxpySuwyuZoETJlwtyHlJFbbzwHaP+b46?=
 =?us-ascii?Q?bLsXIZBVl+Wr88A/CIdno3Rl7SHTDOnFUWDMmPwFJBiDolf7FX3jveSDcyqU?=
 =?us-ascii?Q?5YRcTgxkwxYKHhqu5Coy79v+CG8bOaAaZXICzAhVxOtlZTAZvS8A/Tq97S5/?=
 =?us-ascii?Q?uyouQEe+lGPFLJ0T00p7KiZ8FjuFwycygSDJDzlNfS5CGadlzBjDBH4IQr5N?=
 =?us-ascii?Q?7cCfBmwE+UlcOCFDhlQmtmR2EkhH0r+Jt1ec7tMbjDROdcrFe7FrbQDHrSL7?=
 =?us-ascii?Q?YP0qlixcQ7xHZjVTDfyKrdp9vniWqFaYHDKLKNuLYMienEJ/DmwcuD+4eIvV?=
 =?us-ascii?Q?vYUPxloTbdRDhoPoEi5k0OodkTCDQVaJJkI4pS6edIryfF0JztZEswqwdSxq?=
 =?us-ascii?Q?nPy7Elv9RjWRtfeG8EsixkBoT3ON5ZAg5/CKFtXEik86A0ltdW+sF1fyWg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 03:10:06.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcaea5e-9a6b-4075-8c36-08ddc671c311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

Update the device tree binding example to include usage of the
`reset-gpios` property in PCIe Root Port (RP) bridge node for PERST#
signal handling.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v6:
- None

Changes in v5:
- Add Reviewed-by tag.

Changes in v4:
- Remove reset-gpios define as it is already part of pci-bus-common.yaml.

Changes in v3:
- Move reset-gpios to PCI bridge node.

Changes in v2:
- Update commit message

v5 https://lore.kernel.org/all/20250711052357.3859719-1-sai.krishna.musham@amd.com/
v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
---
 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
index 43dc2585c237..421e1116ae7e 100644
--- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
+++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
@@ -71,6 +71,17 @@ properties:
       - "#address-cells"
       - "#interrupt-cells"
 
+patternProperties:
+  '^pcie@[0-2],0$':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+    unevaluatedProperties: false
+
 required:
   - reg
   - reg-names
@@ -87,6 +98,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
 
     soc {
         #address-cells = <2>;
@@ -112,6 +124,16 @@ examples:
             #size-cells = <2>;
             #interrupt-cells = <1>;
             device_type = "pci";
+
+            pcie@0,0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                reset-gpios = <&tca6416_u37 7 GPIO_ACTIVE_LOW>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
+
             pcie_intc_0: interrupt-controller {
                 #address-cells = <0>;
                 #interrupt-cells = <1>;
-- 
2.44.1


