Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1B4CE2B3
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiCEFMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiCEFMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:12:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D76350B;
        Fri,  4 Mar 2022 21:11:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJJwJQqSJugMajseBB43SBTFoo9u59Blvl2o/Cs0wq1MGK6qy8+wrmCzvcIBu7vRvsA5oq1b9TgbnDYMyV1DhxvzUTA6pPYo4pp7344hVeTfgQauixLJ8XVaTsTixo99z3bkq2ROM/s6UrOKOY70gdVh0FvZ+OtD8BA9ZZOOFdyDoYqvc48vnW3nz+yNSLxLv4fWErxUDloErleeHJLnxw8tBalTwCWI4Y8mDDs5tX7vUmgDwKq4ulY3nq8lz5LdQlL9cHITH2GM/ooaQLue+OZy7C+jt7pzvZvylNNpKqxbrFoxtookeFBHTDk9xHnKWlkL6gRHbm5INh9ILLM7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+LJXBmaDbKZVsVzVqhgP5YWio/nOvHhdeAjOWMBEy0=;
 b=ldgpfcEIXSUHgdEjDDUy9DwyDT8VNRwn8u5KoJBhimcGll40mm4q6+b/8l1ksGc6QteNYF38KhubafRyAicKlTrzLmEBMgqbCwuZ+RB5viBuXaeGMAVkPAcmRyYUXUAfyU0UOu6YsZ3HnD3GrCgac+ixKQgNNy0eBdRd+iP3BaP9HDWd2G079Xn52n8ext2UgUlh4jI/EK+/qvbtrfu0dY48FGuOE8Opg5rrIBK6JuAsYYyadW8/P6oFNQ4VgzVIua5kPXBooH20uEgryvnZUvzu44t8eYpOZE01bvzkPRDuF5Pd+H3ravZl67dfZbrv/iuKLrTLLT9o5OqWOLWO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+LJXBmaDbKZVsVzVqhgP5YWio/nOvHhdeAjOWMBEy0=;
 b=SkNiEf5A+oRM9BTgOw3OucWy7gargAftEXAJAL8ChEPXgXYwEwodYsGZ+FNuGw3HlseF1V83qSMHrwJfSKgxO+bVPYirUPU+61A4B/JPwGHr+u1+Eaws5vJiRGsE0EH0R6e2CaXNWcBp/RsvXBGVqilIOABqFYqIdv9rPBaNVqU=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by SJ0PR02MB8846.namprd02.prod.outlook.com (2603:10b6:a03:3d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 05:11:21 +0000
Received: from DM3NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::a2) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Sat, 5 Mar 2022 05:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT036.mail.protection.outlook.com (10.13.5.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:11:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:11:20 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:11:20 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44412 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMhM-000GqD-Iy; Fri, 04 Mar 2022 21:11:20 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 29688600131; Fri,  4 Mar 2022 21:11:08 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 2/4] Documentation: devicetree: bindings: add binding for PCIe endpoint bus
Date:   Fri, 4 Mar 2022 21:11:03 -0800
Message-ID: <20220305051105.725838-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305051105.725838-1-lizhi.hou@xilinx.com>
References: <20220305051105.725838-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c53d7c5-7556-4260-caaa-08d9fe669665
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8846:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8846DD3CF4DF85DE0708FF83A1069@SJ0PR02MB8846.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK2+Ec4jddLdumpi5/U/1Vh+gIB/uhF/9M8K5kxlNsiR6dClMF6M1gARnr97WVI+R6ul12QBn5kh+vyyaEe5QyMb/7Ic9doyTSpA2kShgS7kDJLHU0+SzZ1pArSNAYY4YrH+otAvaJzZvK/j0cx5AldfF9Ow90Sa2dDH2qXmyl1nPCq40oMl5VxdzKNH9UETlL6JHNJyp7Wac8K3bsoCANagzBC+o3BF9j4f62PKpsc6EnIP+JCPZYznGGTGnsXK9pavVuODhrT/C4P7DA8pWW6XwnDNkja6rwaHsXhQTh/DkqkY1kCJoq6AJtKOge7TaikpE13CTUDUEsEvWTUrbwyL5+W5vpy33BnKQfj9NusBLvE/5NLaxIVz63C0Ni3NCIQZKowU2e7+4frt04HRRzzExNU1UDWXBBCVXZKEay11d7KrpDRrdH9vnGihrzglF9piQn2q1wdeFOkTRXH9k848n7b4N1zkeImpSTEEDte8kvHhWn0H9VBpi9gdWcei96ADocOVUy0hBNxNt7TIwAXMgOA/FjXVr8cQoRgvwkzYq5WCLY2sOMUR+nXytfsRF77XVFzFu6hLP8/6lfzegf/xMr7CN0EjgEM7JmVVdx5wzD7DA7Agke53eNjlyURlsISzjdPCIStKqfG9m6olbqX+qCkOxmyNiv1xhA2TniuAvwYEqZprLjgJsUa0Q2r+82LFIWThNBtGXz6mg0bw/prOt0iuzmZ1Lwfitec91PCtl/UXDpzkPKNUtfz5fX19aI9yJefikkTV26bzI/um4Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(316002)(110136005)(42186006)(36756003)(54906003)(8936002)(966005)(44832011)(6266002)(1076003)(2616005)(508600001)(5660300002)(6666004)(4326008)(26005)(186003)(336012)(426003)(8676002)(70206006)(107886003)(70586007)(7636003)(356005)(36860700001)(47076005)(2906002)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:11:21.2227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c53d7c5-7556-4260-caaa-08d9fe669665
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8846
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

