Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759C11FB14A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgFPM5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 08:57:15 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:33663
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728740AbgFPM5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 08:57:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8bootfkLra27lKiBgUZ38UYMCY8GhmNYp6o3TfJP5xgB9e5pyCY/SIPKVRWF7d6DWrEMDVBEEPrI7hyr/AwvTcRvnp57aG7gWHLzAx7zOQfW+b1ne/BlqeUA+yDBPtfOjdwQkVQOM3yGeDyN7G7NvZ2wkoKkVjuGxuDS76uy1FSP4bgbtNWc6o5jlR7AiWv7Aw0GiFehk8xFNagXN4eIlMBZSXajLay+BdAKJyqlzWq8FssY+KkfAmsDkHxUpCVnZRk1+UOpmf0+FpmhqQQgA/nEKSql8W+M2qarvwvpZMwgTlWhG8dys2PmcBHXhdZvJFM3RW3RnDKIsKvhUSdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOucvZcKqdiqPqJX4M8KJVI0664h++B2vdcDKV8QCoE=;
 b=du7zYv3VpGHxjbvGy9LTIyrjkt91K45QZzg3RfumCZ2skUzOR1lSUvOHXEM6pgZvqYsB83PzSV3+mH+MSr01dUJvb630A8kaSKGXSuDhpi3jeEg3Ml9vpEWMsCDm/UQmo1qAoF6Fwygny1bdOTNBPJ2LxNcI8iQXhXBH0EerjajdW+nfpFJU6eAwAihkvtS18rKy72k/L0Ni80ZStc7LJffoTh4QSis/P414469mAY/aB1V+5KtBNwgR4/BCNjvwX5P+Iwrzl8vSEAUirmZFni25vC7K1CdPU68MAk4HsD53kkdSEfll8HrRLjtp7mLqphvQYfcN3HO8NhmT/FFQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOucvZcKqdiqPqJX4M8KJVI0664h++B2vdcDKV8QCoE=;
 b=fNuSwkmGCVd6c6JOqouOTHJ1BDbHUA3KMymL64B+EiZnj+hRdB35Xw7Ct2tW88IJkiS8pNt4fBIke6T2HQdtOc+VYRaHTVTebzgm+HDfnyYs+GUdVL6zHMJ6HdDdPItouJyDbZUnEYB7yzC42SwAbe82W1zztlZHhvJFlxnPsW8=
Received: from SN6PR16CA0058.namprd16.prod.outlook.com (2603:10b6:805:ca::35)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 12:57:10 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::db) by SN6PR16CA0058.outlook.office365.com
 (2603:10b6:805:ca::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend
 Transport; Tue, 16 Jun 2020 12:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server id 15.20.3088.18 via Frontend Transport; Tue, 16 Jun 2020 12:57:09
 +0000
Received: from [149.199.38.66] (port=60986 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB8I-0000xT-E9; Tue, 16 Jun 2020 05:56:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB9J-0001rZ-G2; Tue, 16 Jun 2020 05:57:09 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05GCv4fR017267;
        Tue, 16 Jun 2020 05:57:04 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB9D-0001oA-KZ; Tue, 16 Jun 2020 05:57:04 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        maz@kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v9 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
Date:   Tue, 16 Jun 2020 18:26:53 +0530
Message-Id: <1592312214-9347-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(376002)(346002)(46966005)(70206006)(70586007)(6666004)(5660300002)(9786002)(336012)(8676002)(426003)(2616005)(7696005)(186003)(36756003)(2906002)(4326008)(107886003)(26005)(966005)(83380400001)(82740400003)(356005)(82310400002)(81166007)(316002)(47076004)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd9151d7-5903-4cf0-8001-08d811f4c801
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35107CF1B9F81A2EE7D26F59A59D0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoJNf1+4UFqvoO4zLxDqb7YxaGvHk8nzqjPxg+k7cgZZ9SHO2biTGrfDx+IIM0OY2BESylXfH6Yvbdd8zNWlb5PuFE8T1POS3eMpKUOkmLdAQxGW6ZVlDYL7BK9846dZfCkHyZa2w320sQA5MSHCgb0z1Mn8Djv/de2irOasHn/vCaJmXoGMnIrenGUivKB4HCcFrNSJaQM72Y/nholrUCECmer/Z8rCuwwDV4ltuY+afogrSi1sXWxHeUHKi4WROEjVo8PYLWomKj7PuJ5b5yMnNaqDhApANNbdP/hzH2rSgryUoGl7ljzOvwDiyTkkNT6QRo5YxInsPHs4X5142B+PKKUmn/3wf4YaUOGoyn4Tw5WnQGLAhfGwQyv50REn3QudFUsfzrps777tewljR2PP0rvEbfSOwrth2ijyYbjk9DaMZwASpDjNwsr8Aj/oXfnH7sIUFM5vRmhMEbURa0dySIddKKYRxqXw26XP4+s=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 12:57:09.8069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9151d7-5903-4cf0-8001-08d811f4c801
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add YAML schemas documentation for Versal CPM Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
new file mode 100644
index 0000000..a2bbc0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -0,0 +1,99 @@
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
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: xlnx,versal-cpm-host-1.00
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
+  interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+    properties:
+      "#address-cells":
+        const: 0
+      "#interrupt-cells":
+        const: 1
+      "interrupt-controller": true
+    additionalProperties: false
+
+required:
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-parent
+  - interrupt-map
+  - interrupt-map-mask
+  - bus-range
+  - msi-map
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    versal {
+               #address-cells = <2>;
+               #size-cells = <2>;
+               cpm_pcie: pcie@fca10000 {
+                       compatible = "xlnx,versal-cpm-host-1.00";
+                       device_type = "pci";
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
+                       pcie_intc_0: interrupt-controller {
+                               #address-cells = <0>;
+                               #interrupt-cells = <1>;
+                               interrupt-controller;
+                       };
+               };
+    };
-- 
2.7.4

