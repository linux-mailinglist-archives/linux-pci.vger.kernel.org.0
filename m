Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2417F1C8916
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGL7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 07:59:46 -0400
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:16637
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbgEGL7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 07:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggs9W32tFh9+oNRd0YgToy++JAmOrfQKeaoljipTWkMe4Rb5HxznyRb/yBbULz+gC1xHA7GnfJf59RuoGXc5YxDPUhLebJCe4uK+6/IX8I4BydB2eM6TxuRPA2742X+E4jVeKLbm4syPnwTJlRoU81M07KBwNic8s+ICmIZGw3JF43+XE9Etruyl9rbl27lRqINSUtKmC65veUrGm3FUZAckvgpZ1IYD4Lz5QEVXk+VyMLpo/i5YpUAXfCDpY0153Llm1tZUBj3SKRHZPn9KfD8VwtpZDdon0p6++/wU3jCdKG/PNYPqB9CSkng42zwPVD5t+1/S/UB2mdqT6VHJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyL45BzxJsYhLeuhWufCYm5oFsHMkcT31dfOK8IEPc8=;
 b=ikS5zTdoZzepHlt5FmUMlu9RyCfvMvWcwOXPg1qUf7RUN24th2ob7hlmm4Ip7sPsrhMYcbAQplQQTWr40ML30f4gqLha0s2UBj1DcXzq5AZC3uyfRKad5M+cHhzGkaPHzkgCjctw+kGGgWvAmq/srtR7TXA9dq7P8yRRaqFCWLu+Af1qfsawv4RWnQFMuNuHvjwybfEowlxKlX+nXaqeZlvfCE92ySEP38xmk5bUVx+wFuouuHBW9wxIvvWzWIwiWxIMRkAVJfZudsrJ1BNVTzl8wJCq8eVVpjpmImXvaxkH1+rN+VWiPP2fp2bMI7CpVgH43H0cK+xSF+x1Ka5/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyL45BzxJsYhLeuhWufCYm5oFsHMkcT31dfOK8IEPc8=;
 b=R+YnksA5wd8QRTMzh7+fRdB/TgDtIko41TIiQndYrUFhI2AcNUynMaKSs8p/tptxZ+/Iak+cAPTnO+qoUYADxbS/inrVkGpFNp0zRnTY1nsXCohDo9AyucR1lA5oRfc3l33I1AoV/+RuNAPeFpiPEtpsj/rhszpeDxYf009jzYY=
Received: from SN4PR0801CA0017.namprd08.prod.outlook.com
 (2603:10b6:803:29::27) by BL0PR02MB5683.namprd02.prod.outlook.com
 (2603:10b6:208:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 11:59:40 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::7e) by SN4PR0801CA0017.outlook.office365.com
 (2603:10b6:803:29::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Thu, 7 May 2020 11:59:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 11:59:39
 +0000
Received: from [149.199.38.66] (port=60019 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBZ-0004yL-Ub; Thu, 07 May 2020 04:59:29 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBj-00082j-FE; Thu, 07 May 2020 04:59:39 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 047Bxb4C012821;
        Thu, 7 May 2020 04:59:38 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBh-00081d-Ff; Thu, 07 May 2020 04:59:37 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v7 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
Date:   Thu,  7 May 2020 17:28:35 +0530
Message-Id: <1588852716-23132-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39860400002)(396003)(46966005)(33430700001)(70586007)(26005)(478600001)(2616005)(966005)(336012)(316002)(70206006)(47076004)(426003)(8936002)(33440700001)(4326008)(7696005)(82740400003)(8676002)(36756003)(186003)(82310400002)(81166007)(2906002)(107886003)(9786002)(5660300002)(356005);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e707b81-0451-4a17-be04-08d7f27e1f17
X-MS-TrafficTypeDiagnostic: BL0PR02MB5683:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR02MB5683CF159AEC790A221C6D83A5A50@BL0PR02MB5683.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G59qBYG4/55WUp9qzKqL/qNXJNVzpF5PoNfpDiuqHPU2P9VYDHBpLgwqC10Kxo1cFiEBwMXIaLIeeS5gsto+JErOwDT+N/Zs8igX4M+euRTjF6/h92H0+XYfa7HfB6xqosr0/8wBrxy2SVoCXRPztwS+0HBSey9O8ZZGGjWtp/31ZvU3jN0HRvE6IZX+4hxowtVu7ya80ZYFsxwW1w10UGJ+atLS6aCGfTWiz6jXd/NlZy+k2qI8ScE8gVXrwUR+LRyaMefdNMlsGRV26Agnju4Hpo6JLDoOYlErUH6qwyIVZHHIvN8ddlRCj8A+JJ/6C7ku5Ep42hON8RTfHRADsdDuAl/SOdtF1NfpNW93gQUhoPh+l6RjZZsojDgRXcJwweuL3A6xETK5c6qR9PzNZxCvmx4hzoJG6HcaQeA30TcbBPb6WD4+6QsGGfGs22TWZXvu9unzPLQzFDOz+mat8RmsUftp9EBqrGSwNfo97OGZO0wLzR7r/uz/6H7N7rjiHLjp3heEVBWyNa02w7MMtjr/fTOPJRJ/+2c/5zmvGe7XJFLf4viRLv2A4IHB0xSH/V/JwWNS9PYhXiioEh8CkrYTOE/9LQwBqu7YfNMWbirKuIvtRD4ou3Sd0u9YqRadlQ3UR8gDLjDCv+Qe8Bei1w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 11:59:39.7585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e707b81-0451-4a17-be04-08d7f27e1f17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5683
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML schemas documentation for Versal CPM Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
new file mode 100644
index 0000000..5fc5c3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/xilinx-versal-cpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CPM Host Controller device tree for Xilinx Versal SoCs
+
+maintainers:
+  - Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
+
+properties:
+  compatible:
+    const: xlnx,versal-cpm-host-1.00
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  reg:
+    items:
+      - description: Configuration space region and bridge registers.
+      - description: CPM system level control and status registers.
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: cpm_slcr
+
+  interrupts:
+    maxItems: 1
+
+  msi-map:
+    description:
+      Maps a Requester ID to an MSI controller and associated MSI sideband data.
+
+  ranges:
+    maxItems: 2
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-map-mask:
+    description: Standard PCI IRQ mapping properties.
+
+  interrupt-map:
+    description: Standard PCI IRQ mapping properties.
+
+  interrupt_controller:
+    description: Interrupt controller child node.
+
+  bus-range:
+    description: Range of bus numbers associated with this controller.
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-parent
+  - interrupt-map
+  - interrupt-map-mask
+  - ranges
+  - bus-range
+  - msi-map
+
+additionalProperties: false
+
+examples:
+  - |
+
+    versal {
+               #address-cells = <2>;
+               #size-cells = <2>;
+               cpm_pcie: pci@fca10000 {
+                       compatible = "xlnx,versal-cpm-host-1.00";
+                       #address-cells = <3>;
+                       #interrupt-cells = <1>;
+                       #size-cells = <2>;
+                       interrupts = <0 72 4>;
+                       interrupt-parent = <&gic>;
+                       interrupt-map-mask = <0 0 0 7>;
+                       interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
+                                       <0 0 0 2 &pcie_intc_0 1>,
+                                       <0 0 0 3 &pcie_intc_0 2>,
+                                       <0 0 0 4 &pcie_intc_0 3>;
+                       bus-range = <0x00 0xff>;
+                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
+                       msi-map = <0x0 &its_gic 0x0 0x10000>;
+                       reg = <0x6 0x00000000 0x0 0x10000000>,
+                             <0x0 0xfca10000 0x0 0x1000>;
+                       reg-names = "cfg", "cpm_slcr";
+                       pcie_intc_0: interrupt_controller {
+                               #address-cells = <0>;
+                               #interrupt-cells = <1>;
+                               interrupt-controller ;
+                       };
+                };
+    };
-- 
2.7.4

