Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464CF1F19C9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgFHNTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 09:19:21 -0400
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:6140
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729290AbgFHNTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 09:19:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TddLn2eCFls+/FV68AAlVxKCl4yStX8VYpyZWq0FP0XPLt+SQJAz6QO0avzgLfvxPG7N79tQMoyniAljD5enRD4SVd2BWkZK1jaQUUtvKeXTd6ko+NSP0Qgz7o2neBX9IZ3C5FVSEvHd8RXp6RpL/AeZTvVp9OCDnNEFy1sgHr8QnWR5+d+CV7MVoPg2+44bMkaIAPQmtazoegiEhCDFiXFhPOsutVrS7T1XagxTNnwmJYK7+MIOI9v+1uzJ2Af1/uwdhLYTaZO02r8hQo4DwJLLm3gS8wgQBNQo04Yo6tjHMD5VndNsDVkqKMVinY7rY/wicx6ORw09BonIQ5Xcwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOucvZcKqdiqPqJX4M8KJVI0664h++B2vdcDKV8QCoE=;
 b=BMkpHdplVaX+DW+yzs8CpTlk0QSNZHD9i5xV53jweDWRlp8g0ls6IIuxQGKo+6NqRFBtmST22O3jHoEzeDoOEHewuHDlUZWgR9qVQ3HXj3UaqbDUhsGFepm+NPaRoXKlW/SuNGXpcuI6GovqSs/ScIHeT8pmsMJhnYcaOjsrdvzRp77R8G0SznTlx09EPb95Fl2f5soznzh0Jph5hMwoyy+h99P92IorMFop12jSR+mLdaeywA7VAoP3oXa45rXfWLOAuudqxcFqygsu4yOuhDqwz+LylTPNcJF8zoNfvjwAPgCUq6XooEhqhyUJc8/BKg/+hZwn/sdTNhmqWJt9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOucvZcKqdiqPqJX4M8KJVI0664h++B2vdcDKV8QCoE=;
 b=ZMY9Uk4k0U1jHTkJSvJwm1BlYx6dj4OeixNWMfm3gdHXLqERprgm9Vf9yiGCSSNxnbvPiJt1/dLCqtPceAbzJheoqAxLi5RzMQ/OuUuYICM/SqKdt242pR2Y2g6Z0up9GjwF9H6hhVk7mFpxiadMdsbgz/INzYW1x+n6deb45Is=
Received: from BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25)
 by SN6PR02MB5454.namprd02.prod.outlook.com (2603:10b6:805:e6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 13:19:15 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:91:cafe::1d) by BL0PR05CA0015.outlook.office365.com
 (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.10 via Frontend
 Transport; Mon, 8 Jun 2020 13:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 13:19:14
 +0000
Received: from [149.199.38.66] (port=47809 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jiHfR-00061F-DN; Mon, 08 Jun 2020 06:18:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jiHgH-0006Gi-Q4; Mon, 08 Jun 2020 06:19:13 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 058DJ7Q4026121;
        Mon, 8 Jun 2020 06:19:07 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jiHgA-0006En-RZ; Mon, 08 Jun 2020 06:19:07 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v8 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
Date:   Mon,  8 Jun 2020 18:48:57 +0530
Message-Id: <1591622338-22652-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(136003)(376002)(396003)(46966005)(4326008)(81166007)(8676002)(5660300002)(356005)(426003)(336012)(82310400002)(83380400001)(6666004)(2906002)(316002)(2616005)(63350400001)(186003)(8936002)(47076004)(70206006)(70586007)(9786002)(107886003)(36756003)(478600001)(7696005)(82740400003)(966005)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf1ac15a-e9bb-4dca-3a93-08d80bae8a15
X-MS-TrafficTypeDiagnostic: SN6PR02MB5454:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB545457449D50605D9B86B5B9A5850@SN6PR02MB5454.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ww6zjHnITrLRkOWZQpiKo194u2KaksEWb08kQcipMMDZCRfkoEN7TylhqdemHw6+JLYqtzcqUjnQtT8spMJqQmB3XiBH+laXo3TjtZjGdXYReWd0SIlBah6LSX1Cfs+3Q3VLwQD8N+Kghlgm6LaLA4cH6IBvYBA+hiL2ZmK/jKdaArviuUeEmc5s9IFySwgp8YWzQTflDC6IehzTaikLYYRKWZZf8uuyAdUC3Syqbl7aTjk+Ry4dVtb5j3p2vjJSZBEavtQRSRSjoigE4CAXTSa/+1wIwpOZOmzPsE87cHjJtFezWdsEn5lVv0ZtZW216nRgvNAdZDNTfwNwQ1Ff09mOfFuWB6WiLiYLRRVDKzpE4IjD18dPzaf/kBwAVBvVizdOBSJ3em3ySUf6jQ7ua7xiBuZ3OfLE9SCCe/DrlA7/RC6m4NoCh5arPq3hIHq584k37lfShR46CM8rsIr1mIqPGxiEiOqGup+BWA3O68=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 13:19:14.1697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1ac15a-e9bb-4dca-3a93-08d80bae8a15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5454
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

