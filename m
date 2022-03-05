Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5AD4CE2CC
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiCEFYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiCEFYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:24:16 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82104162000;
        Fri,  4 Mar 2022 21:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWjBcEQg3CaG6xasRYSpAak9G2SlMC+8pdEFGj+Vy7YvRiouW/tOVPrE4/C+PCA3y0xm7I+w/nmhtXf3MQTdR5mNRTQuAt8Tt4LyzsJCmsYkka+B293tf13+D5KJyJCzf48WI1ZMbl/LSJ9iD1BHL9T6U2MOwSnEktPv6ZbUtTnc2mmzClQ5j5IhzOUrSz91f6G/CvLDhh847bDHgpEC3M8rm2IfJXGu3Yan3M9VjU7MRGoP7EFovsVTS2NYAONFdG6l+qovBgBUt5y8dICUJ0svZLt/lYuoEA6SIG4Gh3Oz6hyCARkaSJVqjsNdcxK1xRvbVliD0lFufXDIFAUIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+LJXBmaDbKZVsVzVqhgP5YWio/nOvHhdeAjOWMBEy0=;
 b=KofJA+cecRHBROGLCfuIq5JeohANZeTHJnxpOlXCw/eERyIX7xNrBiHJAH6uXXpNZFC4Wf3VxmiUXlq067dDT/WkE+usV/dBAdxyD25nH6qMI9V2fVlOaEYbuK8rkHVVZKdjBNkZrrNnBKEK3Gg8SJ2qbx3/PB5ySJvlfkEwj8PXpXi3ig3/jgRz/WHkzhZPa+dyvgDL/uB4bqH40g0C9qxGug32P5ib/1DG2GFa4VBZkPi9fo7N2HBq+/ynrp4i/8iqjHilDk3d84SYgU+NXUmh088V4orV4GVgIydQz8ugrMwETlJI6o5SFCRapgCslBaI1RZSeVJS6yBSjV2mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+LJXBmaDbKZVsVzVqhgP5YWio/nOvHhdeAjOWMBEy0=;
 b=jfSvIQ0qKWz/FK/QSh444wAp/eS/4XGFP/+ihjDL5j7dPec/Js5hq0BXY5Nd55RiNwYFrzWRNkX+0XpDRDzdK89MF2UI+SzQjc8ElUS0Yauoeb3GSR0/+PfiDSLbsAYyQo6ePEDmBU/oP64wOHbL3zNOm8JYrHtdJlto+TT1YqU=
Received: from SA0PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:d3::19)
 by BN8PR02MB5906.namprd02.prod.outlook.com (2603:10b6:408:ba::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 05:23:23 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::4f) by SA0PR11CA0014.outlook.office365.com
 (2603:10b6:806:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Sat, 5 Mar 2022 05:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:23:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:23:22 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:23:22 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44428 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMt0-000BYJ-DR; Fri, 04 Mar 2022 21:23:22 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 08BB0600131; Fri,  4 Mar 2022 21:23:09 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 RESEND 2/4] Documentation: devicetree: bindings: add binding for PCIe endpoint bus
Date:   Fri, 4 Mar 2022 21:23:02 -0800
Message-ID: <20220305052304.726050-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305052304.726050-1-lizhi.hou@xilinx.com>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a47673-2634-41f9-466c-08d9fe6844b3
X-MS-TrafficTypeDiagnostic: BN8PR02MB5906:EE_
X-Microsoft-Antispam-PRVS: <BN8PR02MB5906907D55971A33108842C7A1069@BN8PR02MB5906.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj8c0R4+gafCeAD4nIcAAfohLbpMAjVVG3aiau3z+yv1VzfL+vCQRkSefkiPDdSuaBdpkb3y2FW0/y1XDgZhD2d9qZqm8BvDWVz2SSTtG/6b1GUnmfeROCxg5myICXR96HWIhuGo2+X0NcHXbCwMCxcTkwudVwnuRAkNK5QF9Bbxyz45l8W+KVmvm/lolitBLdAswa0/zIWCQi2mAF3jEcfx/itqio1aRA4uxYy6iX+bgs0DIwGHqhWx0SuYeMx78AS/ENJ4Hd5UES6PL6BxUZ0MMJJtrYbH03X1g+wsrdE3AAouKuDTy2DQn6X6W7cCUlcoPiTPjkwwrkN4MRGXrlIx9MMM3ODaNJwMbEL5E+Qo5kxc8wgSxuR0Ns9Z2cfGDIywjROKG4FoI8f5f+eb899So18B+GH6P2FtwdSv/oNHNU67wrLDZVw6h2RiB42EhQ8zXR8fFlKfUf4kQBDeWlVJVf/enK8HftlcRvVegd/hOzMsw8FiE/Kt+bjo9nuMC8NS049TnJJ/gDRKkNDmmqhshjtdvaCmVK8G3rZJNxrUyl9GWaWgZY6LB0YXiep5ghl5mleU5SH0C55hmDsbvYebfUO+oLuNzk7T2NnGlNkvc4psubaB3a+CDfjMmItei7zPst0n2ue3ko33PAh6fdt76esCn9azBf1iRr0cmFn+QuzyIRlqng3HW5eGCfNgeczx0Q6BL64Td123ZR7qHWzolN9dY+137/RyJGgqJXtZKyax41eS9G/jqkGiO1VAmjEHH59foyST2+qbKwOAdg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(82310400004)(2906002)(36860700001)(70586007)(966005)(47076005)(508600001)(4326008)(8676002)(26005)(186003)(6266002)(8936002)(356005)(107886003)(42186006)(36756003)(7636003)(70206006)(110136005)(44832011)(54906003)(2616005)(1076003)(426003)(5660300002)(6666004)(336012)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:23:23.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a47673-2634-41f9-466c-08d9fe6844b3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5906
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create device tree binding document for PCIe endpoint bus.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 .../devicetree/bindings/bus/pci-ep-bus.yaml   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/pci-ep-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
new file mode 100644
index 000000000000..0ca96298db6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/pci-ep-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe Endpoint Bus binding
+
+description: |
+  PCIe device may use flattened device tree to describe apertures in its
+  PCIe BARs. The Bus PCIe endpoint node is created and attached under the
+  device tree root node for this kind of device. Then the flatten device
+  tree overlay for this device is attached under the endpoint node.
+
+  The aperture address which is under the endpoint node consists of BAR
+  index and offset. It uses the following encoding:
+
+    0xIooooooo 0xoooooooo
+
+  Where:
+
+    I = BAR index
+    oooooo oooooooo = BAR offset
+
+  The endpoint is compatible with 'simple-bus' and contains 'ranges'
+  property for translating aperture address to CPU address.
+
+allOf:
+  - $ref: /schemas/simple-bus.yaml#
+
+maintainers:
+  - Lizhi Hou <lizhi.hou@xilinx.com>
+
+properties:
+  compatible:
+    contains:
+      const: pci-ep-bus
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    description: hardware apertures belong to this device.
+    type: object
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pci-ep-bus@e0000000 {
+            compatible = "pci-ep-bus", "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xe0000000 0x0 0x2000000
+                      0x20000000 0x0 0x0 0xe4200000 0x0 0x40000>;
+        };
+    };
-- 
2.27.0

