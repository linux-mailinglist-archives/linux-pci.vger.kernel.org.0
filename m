Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86FE62846B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiKNPyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiKNPyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:54:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B52DAB5;
        Mon, 14 Nov 2022 07:54:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfEyb7rKXKo52ICgujlro6QxKi3L9MGSF3vTkXPNbskd5kxzCf/uRRdOWVuqaK5yRUoq/yQHBjeYd92GoVo45wdjuY6GBQ1fmnZeS1o3Kp3078kHkP1HIE1n3HlQ6qD5Va2ZgoSCa/0Xm1zu09rtoy9bbKLB2I/GUnafKTrfED66aqhr4mES9rJ7W8LU5mgsoKLCEgITVg+75CxSxzxq4o+J7kMhbR1wnYw4E0jIZbUksLoWkyFEZr5WV39pF4KsCNEDeg5JSuEl1XTVmNhKhTccemoiKj0emXkS8ylYIoZiMH7NDb6B82+9Qso4OTeWwBCYDucnYd929Ipty2+EWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhsmSgAR7koWgTw29s0ixTi17EfH0IbLcNqcPDCa0Rk=;
 b=kjmvMRR2MKUEZXE+9zux4Rt+lO1/XlNvs3R5+tPpfkZg6/h5hPtqFCSn2a9qgAVtteN6prvB9AR3p2+cmM8/iK5fSRMkBpVG6LiNiOrdpHUkyMVcybVnBDBmGDB1WacICmjWh87o4NG4ES1MdNlPXZzpDYg5wXedLa6fETjG5IdPdo8OoBF4m0uROYae233/VKU4bNMPEeM4l0ltoI/yCxvvdRlkir8lFo1+avHe95X+bIohKqjKVgJaDrKOM880HIpQkOXUWycXP6k4MSo/UiwQvRSeM+MOGF+cDM03LMmdKvvdB0Dtut5Gkr3xpuCn58QP4fVHpCkDNrUyRagelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhsmSgAR7koWgTw29s0ixTi17EfH0IbLcNqcPDCa0Rk=;
 b=sBez4S5wPA7BqszTXuHFAqDiUWSGHdgGBGHVMVnaQgc5uLPZypBsN6j0AZvme2D3dJUe3ZIOc7Y8Qv/3UTg63cDOt8uVHmW2llYu7TbEb0DpZvjKvqIXYRgz7QlDDR7Sgrs7nTx7FFLAymdHEDpZtOdU0oVC3BUVRjN5+K2tw3M3HoRe1/s4Z5X4HXRg3NkU0KbtSJjwwPBgrWgTGJJWVoROcV+NygRc6EeGg5odU7oLJEZcNnp61wmpUzZ2mCJ0MEFm0udxZ/8bV8+Sd230obSPtiA9yx6dDhUc+enQlXTdzq6gDF1Hf2fhEbZ+ii6ORpv1x9ISCtVe8PNeJfFT7g==
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:54:02 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::d) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 15:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 15:54:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 07:53:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 07:53:49 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 07:53:47 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Date:   Mon, 14 Nov 2022 15:53:32 +0000
Message-ID: <20221114155333.234496-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114155333.234496-1-jonathanh@nvidia.com>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 373f5910-6889-4fdf-195c-08dac658733a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9UeuwgvtG3tORLo8KxN7JllW4ZTc5pTR6A3v1FzGuIa4EhUVjsWx8D71gRgGe5BDP8gyj40cv2CvCHfDmll6PI1alALO4FU8+sQ4iiLhRw9TvNa4w+sD5EyzydfqNQhrJxD8p/5yI4hKCoyj7mGDStIDOqgcjMbsFs88PwSc1sBjqlKZR6P8m4Kz8rWIwJbe7EkDfjFtr96hN8u+LXdZcsTnl4XCr3VJ7kQQ8GJYiB3CWnoREhMmxQPQnimAGNb4fYCs6ygEuHxL/Z6E1TVqLpyfsS89WJUwgZmqh5dG4VE6snS6g5Q/sYzByhd/OqXhAlv178IBe1CM1jmakHevoGgy8ZeWzrtSQFk2DdVobI2yKLHYLFI4Iw1I8uyNl3/h2bjNcv6jwrKIAGEQthtNfOv1tYlKz9XdXmjRor63FlzQNx9pcuC0d3zGCwB0CVNJJ4Kz8bYs9jfOa7EQzcDJJGGcu+kpenjgAzIdmPKsoLkXW6tt12d9fRsf2yyX/H2Mt75WibV3fLlMCOIZMt5SPCnj+JTniGidqRRgZbKcIcLoNClk/g3Es9I/Bovl4fhpa/sAlyL0hhDpdwyLkN36zdkfZf+q7hkHsBVwYlGev2D08ewMdJY+rJt+dVy+fkBBo1c7eO3HBla8PrvFozXUzl88t/ldfxZY2JCEJyPShHRXSLfjXo1/L7xyUixPeHCRVM4PfjwaDqrutd7nU+4sb53BLoLy4ny3roOtkEyydw4VfJr2LAFC8xlGfJaaG2zr0LDyp/sdfr9XgN3PZOG6w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(107886003)(6666004)(82740400003)(356005)(7636003)(7696005)(41300700001)(47076005)(8936002)(426003)(83380400001)(5660300002)(478600001)(110136005)(54906003)(336012)(26005)(82310400005)(36860700001)(40460700003)(86362001)(316002)(2616005)(40480700001)(36756003)(70586007)(186003)(8676002)(4326008)(2906002)(1076003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:54:01.7549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 373f5910-6889-4fdf-195c-08dac658733a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vidya Sagar <vidyas@nvidia.com>

Add support for ECAM aperture that is only supported for Tegra234
devices.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V2:
- Avoid duplication of reg items and reg-names
Changes since V1:
- Restricted the ECAM aperture to only Tegra234 devices that support it.

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index 75da3e8eecb9..fe81d52c7277 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -27,6 +27,7 @@ properties:
       - nvidia,tegra234-pcie
 
   reg:
+    minItems: 4
     items:
       - description: controller's application logic registers
       - description: configuration registers
@@ -35,13 +36,16 @@ properties:
           available for software access.
       - description: aperture where the Root Port's own configuration
           registers are available.
+      - description: aperture to access the configuration space through ECAM.
 
   reg-names:
+    minItems: 4
     items:
       - const: appl
       - const: config
       - const: atu_dma
       - const: dbi
+      - const: ecam
 
   interrupts:
     items:
@@ -202,6 +206,31 @@ properties:
 
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra194-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 4
+        reg-names:
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra234-pcie
+    then:
+      properties:
+        reg:
+          minItems: 5
+        reg-names:
+          minItems: 5
 
 unevaluatedProperties: false
 
@@ -305,8 +334,9 @@ examples:
             reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
                   <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
                   <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-                  <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-            reg-names = "appl", "config", "atu_dma", "dbi";
+                  <0x00 0x36080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+                  <0x24 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+            reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
             #address-cells = <3>;
             #size-cells = <2>;
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 7287d395e1b6..7e0b015f1414 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 5
     items:
       enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
-              parf, cfg, link, ulreg, smu, mpu, apb, phy ]
+              parf, cfg, link, ulreg, smu, mpu, apb, phy, ecam ]
 
   num-lanes:
     description: |
-- 
2.25.1

