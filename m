Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E662820F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 15:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiKNOKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 09:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiKNOJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 09:09:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB425E8E;
        Mon, 14 Nov 2022 06:09:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5j3QJUZBiorf5VAXPJTntywBnGClV29rF2Lg2+6pmFsQB6BOQC8oQ7rbXTp2updXupZaDfKtFS5w5ilkE0iHBFPO+xXhPRRvpz9BV7zwNEuSi0ENtnf5JDQ4ExlcBIOAO3vpOYb6omVlZCPc54mKQKfQDJZaWnh12NH215jue1pfJB8n/dTVrcGY3IbIB6ARHPyvNJM5yYBiN0teUK/vP1H96xd4J6V6nETyyid79FI8dpQEr5q4+B+q4QX7EFd0ntxit23FEd3gMPjXs058BQiXppr/px0U7sMfo2in32CtVK3FAV61eszpIX5Q+2zwMl8KiiH+xSBB//QEaEU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfZ/Qr/NiCgRcjScDRjj4Rb1YVyqTCbHQgDP9Bp3jG0=;
 b=XdZNm9Ak7O9fb6V9Xc7pHl7esaRE4nPGqgAgpxQ76PAlXsldeHpvwq/K+eBOPd6EPVCKBMzcF4OGInxUzwoqektNtRMUkDooLh3SZcvWt5i+Kz46ngX8uUBhkbPSOEnWsPmBVjNb9hB4em9fssrzQuncMCagQlif1fUfsbOau596e0kMfmmNw+YDsCijnYeaIo27tr5TIgw6xSbPzrfVoTF2COauYz9j0iexdJ4AN4WZDZcVHmLcCXAxDPdwCBdUXHuTINhTGz6UsmNXmPTTvE1SwAvbdskslS+FnM10wNC39kJ4VtBTaWienQMh1IGKQU4vPSBU5t3GuL/m/d8WTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfZ/Qr/NiCgRcjScDRjj4Rb1YVyqTCbHQgDP9Bp3jG0=;
 b=mu6UpThayx+1EXBAPfTX/LOgUDATKBVljOxlj39ylfuDJy8Y7Xr6m2laEhyzN2c0rYEfPsaX1eUZjahJafxicsBkBELBzdFxQ1GoulKMnFoONP/Xavx26vozChxMsyLNaBxfKzSao2LnXyWXxYP5Otlig1NrlFeFh4TI9+5sz9fgu8BqVrUyVuCG+nzVVMDmxXrXfyiMIiO9aq0gYy1GA+RfZoKF3B3Y3ol73NzGIMNY7aYJ80JGiDcXuBAmFPykwYLJYX/M5SKwot8LnkY/ez3U6ffYvex9GCh1uQyyFsUOltByEOnPazL/dqnN+5NyTMoiO4SWTV0APDYsSV7aTA==
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 14:09:57 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::be) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 14:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 14:09:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 06:09:54 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 06:09:54 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 06:09:52 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Date:   Mon, 14 Nov 2022 14:09:15 +0000
Message-ID: <20221114140916.200395-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114140916.200395-1-jonathanh@nvidia.com>
References: <20221114140916.200395-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd86d6f-f111-49a3-7c89-08dac649e895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFcpLUwdYOr5whHJC2EDgZcYikNgIu69VSnVqnrMh5st5IU7aGGtw7jvDQnbYgW6RDkPkhArURpqAJqtfyE40k2IZW0sExohqg4UuMgtsYuQlzcbGRGTjtaBsKHCtEEj3MMhKXN2mJpzjlAVFzuy52Npee1uVG4+ALqfginC39c4y5m/iDf8efsajXkdBWltH3IMx7hsqfR7JaCFgnA2ejfkEOQ4VYz/MrXh8uW7hWGl5GKQDlDuKBCjpupo759WZr+0io/SB7LajjMw54qvQfMz4HYRgph675YEzztmsjSM7QBjHDby0xI3IcX6Mo1KzZQP/BZ24MyB5Q6CYp5DqKkh4AG42oxYOKRQRcvnfZr5bn1fyalKmkfxJQZ+HSeGmtvtPWZqliWjs9Hb5ZMOaeSHmHo0EBcrTAYSgfc9ixjGERY4azdKpRLcVOOimegFP/qQIOBEVblIvqqVCDjVZXh1d5QsuxseiYTVzpCew4mtZRn2Bj8JvA7mUaUHbkoMwTROEBNibBZIza2RYGzvWRa5+KNB0XU8ZPdEThJZGR7VLIbhCUHnWO1iVHYCDHn55HOnKvPEQkXiARpJsuR9TOINY2Wj5lxBihPnpdTlR29TuxMZMjsU9nfhoOexXwVnyi+GUosAy4GEgq9OPZvLSbS953NUR/pZkmu/TARtcC1L6AL1c9Up45d/Z74fJxYwj8A1Y5zXLrDoas9mK1h6QEZH4YTO+Dh87ioovW+nukpZ6ZAWYyR19We0NoFcrQ/3SFzBIrp2P8Ms6qeDFFnXXg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(107886003)(6666004)(54906003)(7696005)(110136005)(478600001)(8936002)(36756003)(70206006)(4326008)(8676002)(70586007)(2616005)(41300700001)(26005)(1076003)(336012)(5660300002)(186003)(82310400005)(83380400001)(40460700003)(7636003)(356005)(47076005)(426003)(36860700001)(2906002)(316002)(40480700001)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:09:56.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd86d6f-f111-49a3-7c89-08dac649e895
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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

Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Restricted the ECAM aperture to only Tegra234 devices that support it.

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 76 +++++++++++++++----
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 2 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index 75da3e8eecb9..7ae0f37f5364 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -27,21 +27,12 @@ properties:
       - nvidia,tegra234-pcie
 
   reg:
-    items:
-      - description: controller's application logic registers
-      - description: configuration registers
-      - description: iATU and DMA registers. This is where the iATU (internal
-          Address Translation Unit) registers of the PCIe core are made
-          available for software access.
-      - description: aperture where the Root Port's own configuration
-          registers are available.
+    minItems: 4
+    maxItems: 5
 
   reg-names:
-    items:
-      - const: appl
-      - const: config
-      - const: atu_dma
-      - const: dbi
+    minItems: 4
+    maxItems: 5
 
   interrupts:
     items:
@@ -202,6 +193,60 @@ properties:
 
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
+          minItems: 4
+          maxItems: 4
+          items:
+            - description: controller's application logic registers
+            - description: configuration registers
+            - description: iATU and DMA registers. This is where the iATU (internal
+                Address Translation Unit) registers of the PCIe core are made
+                available for software access.
+            - description: aperture where the Root Port's own configuration
+                registers are available.
+        reg-names:
+          items:
+            - const: appl
+            - const: config
+            - const: atu_dma
+            - const: dbi
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
+          maxItems: 5
+          items:
+            - description: controller's application logic registers
+            - description: configuration registers
+            - description: iATU and DMA registers. This is where the iATU (internal
+                Address Translation Unit) registers of the PCIe core are made
+                available for software access.
+            - description: aperture where the Root Port's own configuration
+                registers are available.
+            - description: aperture to access the configuration space through ECAM.
+        reg-names:
+          items:
+            - const: appl
+            - const: config
+            - const: atu_dma
+            - const: dbi
+            - const: ecam
+
 
 unevaluatedProperties: false
 
@@ -305,8 +350,9 @@ examples:
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

