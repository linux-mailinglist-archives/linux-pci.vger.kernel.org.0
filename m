Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8057CD43
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiGUOVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiGUOVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:21:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF12823A4;
        Thu, 21 Jul 2022 07:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc9jgwsAbeCYi2hoARh3rIaquIvad9Pe7R7+PAfOKV+fWsjUq4fbEgJIyBGoiVReOa11DdBpupdTxM9M+aVMdRscdbRKp4DswdVTKSGYOJeaArQvexx1wgYgYyPyX5Y8Uv6O9sLqUVeh5i2zUjZ1SQlbpIXtcuThbqaGAES2UOF7e5knIO1rS6JuYFGvyoBwq+47CQyfu8oCcRFZze7z/WW4rk2vOc3BuUu7m7xqypw25hJoe/GGArpfh3Kii9Dmpfh+emaSS+vxeRysTE4oQlEvQpF5whq9MwSfu3ncwqurJXsaPgyam0wawYakWSz+AN8LhTrYdXxBOxn82Lxtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWbe12Bo+1Q3LvLEBB2Ksic/mlYz3YzGMjpozrZHX3A=;
 b=cbufA3tpjAI71nNrdNs2a5PQ03LjsWhVyblgPvHJtAUKOwa1kJnRkMwhJ7CpOjtJPemVFAeu9hN04X4tuenQbKWhW5PaSRga4hG6dz7rMveYs6BSvSRNj67FFpT289Wy1kPZVmLMwds4Yz0xfHRfDL89hykkKWwFuYTNcPVnB1/QYzlkHrH9UoFNwgE4Uhz8HK5r+0xyhj1RqHLlnHjsknjZ5fYg0wYgz6xZmrAIcq0mAEJ5C4CtMK6pMJR9MlABQ9gt60/E6dOMCT789VFU+YtM0EZaP2JfisczBSSrlzwUDeavSMsMmsrvEsJUhSyhrixGIrqSO4N1p5nF91VFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWbe12Bo+1Q3LvLEBB2Ksic/mlYz3YzGMjpozrZHX3A=;
 b=g1SOeY2SCx9iR7SfKbRmPO5mU0+cmzHIsvMNN7VIz9iHLlEAy4yEbMv3BKQI5tAkbTJp5FbXrpurifIHrb2J5peDDgj15Qp7oaFqeL04ut/YF/vC8pEOp+aunb086MQvgS+wf8WSbSCuoykp2UriXHEV+sJ/8X8k8JfD3MT/s3HBCGXQ3jQ4VAPyq8FVZ5pHCESIk1PpCi6wq7lpQifnb1QIrguyVYAxq1AWW8Hypi62A5/glghAqDlXWXcf3euaize6SOvGXSAlMAc3hEW8aRsqle+HWREw5zKhDYDo/6nyr5Twwkwfijd5+u7g6EEgAClkbh/PIWCFd/w75BF42w==
Received: from BN0PR04CA0208.namprd04.prod.outlook.com (2603:10b6:408:e9::33)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:21:26 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::b8) by BN0PR04CA0208.outlook.office365.com
 (2603:10b6:408:e9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:25 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:21 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 02/16] dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
Date:   Thu, 21 Jul 2022 19:50:38 +0530
Message-ID: <20220721142052.25971-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67f7712-7f38-425f-758a-08da6b244c1b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQJmx3K/Kj/9U4LOR+Xm0Yexmv+STLAqMejKZH8fiMTGV0Y2dxxV4jhxqE+fScMo8WZVjjs+dT9//GimBOdgKurlmP+AvEEq+Drh+2ma3hornUr/VAXYjudrSiTSrcSeLnZQ7ifxjiU+0E8kyd6nx8J7WF8/BGugBTIvK0yrKTw03ODE8cVVtoHCpP3YULrfvETHpH3szKc+VSYFDO4EDHoSAZ1kazdK0yjjVbOGdX9USlVE2GX/fbJhNpdpWjbiXFwA6JfR2e/p5qCbVAp6xtSqtVYtRBiDqyqc6oqhz4pxeTjDoSaSbVUSGCGEvaEy1ukFzDhXurs1rev8GKNnHt9hqxSp7a5DP7ts5gNh4RU/LLgC9+mCuzRTbJtYSYVWDP9qBrKei3wVUiq/McfOXjvbTv5e1xnD7fbFELfgrHPcmSNhUiGVg92RDuzFV847kn2hVejvKlWbzhm9VlWi1cdp6Rs0GhFNsVwG2Tq4Mmxg019wh2OBXKWV5RvH2Bph/M0WDjdjuApd/fre8YT8hlKQz2m3WcDhRewvhOMsCoh+sSeP3nj86WK28wYclT+H++M8+a8KcHJqdTlBbuK0hKlr5Wdyqr7gd4A2+dfKGXvSGYRyMumOTjNzfAaqSyb8zolwQUENxPnCgKYmQHtZFt6JyM0Lsy2yVTUbJR6f1wmDC8XAa8JLpzWnKRDaCliEacDbGWomfh0MvULkVVk6/yj+yn52ktYAsRpbsa77m0b27sRXkSSREsynZ43zAd2gyLggnvAFyXtJVEyLufSy7S1RP+aQvvzEHAXDjbx+SVcpr10cBz9GoQbbQMZqczlUtvU7OsfpIdzFFGWtrhadIdgDmn/ur2cQ2svWIELs7LI=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(40470700004)(54906003)(82310400005)(47076005)(336012)(2616005)(426003)(110136005)(186003)(83380400001)(7696005)(1076003)(86362001)(6666004)(36860700001)(5660300002)(8676002)(70206006)(26005)(40460700003)(41300700001)(70586007)(4326008)(8936002)(82740400003)(478600001)(7416002)(36756003)(2906002)(40480700001)(316002)(81166007)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:26.4334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67f7712-7f38-425f-758a-08da6b244c1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that operate in the rootport mode
in tegra234 chipset.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V6:
* Added 'Reviewed-by: Rob Herring <robh@kernel.org>'

V5:
* Addressed review comments from Rob

V4:
* Rebased on top of previous patch

V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 102 +++++++++++++++++-
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index abbaafe98fd4..1e2274b2ba0b 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - nvidia,tegra194-pcie
+      - nvidia,tegra234-pcie
 
   reg:
     items:
@@ -92,7 +93,8 @@ properties:
       A phandle to the node that controls power to the respective PCIe
       controller and a specifier name for the PCIe controller.
 
-      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+      Tegra194 specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+      Tegra234 specifiers are defined in "include/dt-bindings/power/tegra234-powergate.h" file.
 
   interconnects:
     items:
@@ -112,17 +114,34 @@ properties:
       Must contain a pair of phandle to BPMP controller node followed by
       controller ID. Following are the controller IDs for each controller:
 
+      Tegra194
+
         0: C0
         1: C1
         2: C2
         3: C3
         4: C4
         5: C5
+
+      Tegra234
+
+        0 : C0
+        1 : C1
+        2 : C2
+        3 : C3
+        4 : C4
+        5 : C5
+        6 : C6
+        7 : C7
+        8 : C8
+        9 : C9
+        10: C10
+
     items:
       - items:
           - description: phandle to BPMP controller node
           - description: PCIe controller ID
-            maximum: 5
+            maximum: 10
 
   nvidia,update-fc-fixup:
     description: |
@@ -131,6 +150,8 @@ properties:
       of the following conditions thereby enabling root port to exchange
       optimum number of FC (Flow Control) credits with downstream devices:
 
+      NOTE:- This is applicable only for Tegra194.
+
         1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
         2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
           a) speed is Gen-2 and MPS is 256B
@@ -162,6 +183,22 @@ properties:
       if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
       in p2972-0000 platform).
 
+  nvidia,enable-srns:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to operate in SRNS (Separate Reference Clocks with No Spread-Spectrum Clocking).
+      NOTE:- This is applicable only for Tegra234.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nvidia,enable-ext-refclk:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to use the reference clocking coming in from an external clock source instead of
+      using the internal clock source.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
 
@@ -249,3 +286,64 @@ examples:
             phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
         };
     };
+
+  - |
+    #include <dt-bindings/clock/tegra234-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/tegra234-powergate.h>
+    #include <dt-bindings/reset/tegra234-reset.h>
+
+    bus@0 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0x0 0x0 0x0 0x8 0x0>;
+
+        pcie@14160000 {
+            compatible = "nvidia,tegra234-pcie";
+            power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4BB>;
+            reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
+                  <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
+                  <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+                  <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+            reg-names = "appl", "config", "atu_dma", "dbi";
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            num-lanes = <4>;
+            num-viewport = <8>;
+            linux,pci-domain = <4>;
+
+            clocks = <&bpmp TEGRA234_CLK_PEX0_C4_CORE>;
+            clock-names = "core";
+
+            resets = <&bpmp TEGRA234_RESET_PEX0_CORE_4_APB>,
+                     <&bpmp TEGRA234_RESET_PEX0_CORE_4>;
+            reset-names = "apb", "core";
+
+            interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+                         <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+            interrupt-names = "intr", "msi";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+
+            nvidia,bpmp = <&bpmp 4>;
+
+            nvidia,aspm-cmrt-us = <60>;
+            nvidia,aspm-pwr-on-t-us = <20>;
+            nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+            bus-range = <0x0 0xff>;
+            ranges = <0x43000000 0x21 0x40000000 0x21 0x40000000 0x2 0xe8000000>, /* prefetchable */
+                     <0x02000000 0x0  0x40000000 0x24 0x28000000 0x0 0x08000000>, /* non-prefetchable */
+                     <0x01000000 0x0  0x36100000 0x00 0x36100000 0x0 0x00100000>; /* downstream I/O */
+
+            vddio-pex-ctl-supply = <&p3701_vdd_AO_1v8>;
+
+            phys = <&p2u_hsio_4>, <&p2u_hsio_5>, <&p2u_hsio_6>,
+                   <&p2u_hsio_7>;
+            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+        };
+    };
-- 
2.17.1

