Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1915530F5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349611AbiFULhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349366AbiFULhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 07:37:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698729CBA;
        Tue, 21 Jun 2022 04:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVnWUnO0Brr3uhgXo/xb4i3yPozDcTZT1PpfW3zRneAm5LV6xoZu9ycoSezM488fY1DNxxbInrf+atuEcqx/O9pKSqmZVBKG6qmVPFM3/LgwL9W1jxtZkQtjoT6c4YQoicGCK9lE0gVPXiOeaony0KpnaNn9BYCDyd+IlW+NqO3poeeCHEL/o3MpvCfKo+0FDKSrWSWhYHwh72BqUQE3mv2SVBlkB5whCs/QEqylgYjJDzMVdcT0lYb9JaN7VfpgG7bvg2s2m8hnbRp2tWpxAjTpCBusil8RkKz04U2eYKKdUv/FDFpFQqstoKPxvvnmK2ErI1ipeHbQRyT2hNnh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeK/B2KYa1ofLeS7LRUN1LCSV7pxDnm5hH6451AZNkk=;
 b=MYAy/++UTE3J8NB7cwYbcXl8BCEhbWxwmgGtigyRXpsWsUMYLA+T8BYaki9tRAEy+6OnvKRxywT2b0F+fjJuRBUCoYUn9IkV4dryKQnFQvMrCeJSPg2nbTKexjTwCwce1dsOfBEJ/vlOHJnG7elTSZhZHXcDYnQNmhCj9S3pD2CR/k2fHUeHmu3MwdQeyJkZM3sPcChuqTdz6YjSYrtOl551LQTU3y8QvW46UqjGHW17yhj3t3sjXitbMnSH7Tz6DXna62DAWq08/iRxWDkzBhtgNLQA0/4HAy7nbHoHTp+0nu/9cBY4MDxPLeqmGnryglAg2h9ifXZH29MhuTCBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeK/B2KYa1ofLeS7LRUN1LCSV7pxDnm5hH6451AZNkk=;
 b=K4Sb/ehiXWl0/x6M8rp7+EdAsknBKjAlEXd96BkQ/H4U06cHYTgYisXZzroIP7n6Iej1lojVeo5kjUssjedLJmmHSCjzGF5xQKR8YwarVVQTelEQmUmLQnNdEzpCjVRsUU3WZsfLB3WAivcy7qopgNQsiDYiEAIwXjXfh/Mlk2k=
Received: from SA9PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:21::21)
 by SN4PR0201MB3597.namprd02.prod.outlook.com (2603:10b6:803:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 11:37:04 +0000
Received: from SN1NAM02FT0015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:21:cafe::fe) by SA9PR13CA0016.outlook.office365.com
 (2603:10b6:806:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.12 via Frontend
 Transport; Tue, 21 Jun 2022 11:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0015.mail.protection.outlook.com (10.97.5.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 11:37:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 04:37:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 04:37:01 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.24] (port=39508 helo=xhdarjunv40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o3cBp-000Bco-9R; Tue, 21 Jun 2022 04:37:01 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Tue, 21 Jun 2022 17:06:52 +0530
Message-ID: <20220621113653.2354462-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
References: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21b9bc70-5647-4770-253a-08da537a5d8e
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3597:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35971AA184BE2345FC6D7664A5B39@SN4PR0201MB3597.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZjAfbIg8Z65pXrSALt2N4r0Qgvt6RuJr6DmBDb2squA4pLHNlc8XfwH3jfD/WrR+Tm5uNurme8GJyXFO/xteZ4LC2jxiSS+0V8HwPenmG1E1RjgBu87xCQJnvgS5FC2fmBqZeTxBp/pWzAoY8qavKwqpBdwiOdnhfoV4O2FRaA4TIxtkMyDClGALibjKXW+DtdV9fX1aDhhk4wCZsYRz0klE8e6qp9pXagawBFkCxjGY2+wZN2bugWsrTACxi8WCyXKzA0BsHJtDY7hlamkzglG10csBy+NrPaHo6PDiMnqybUVjF9wVWCBIO2puE9hHflS1osakjQ+7yfFF9jbfT9ngi31At/Mg1cYqEanbJNe2hyiOexNo5OYtmFXgGG297cQaFI++chA5+8/cmOTUDscpx600nNy6n4mnilqMcnB2uxuRl9XzMsNE9Y9mu6bP64oljk58xOGPruQLcTxxV0ouyLtwWaD81Qqew1oQQ1x633zMdNmcmWPD72YzDBJ3167t3PG6Huz1EVMaOPn48KbyFIDAW42w++WolGEBMwo7a2W4xyUt4apUbfebBxXXv+5Hqlmo8EjHFGlXj1XUop9xfrsyq5zmQa9K7iE+bJovpFWLu1M0d6dkEyzJx0rPZKuMqoOuj1Vb0mvb0zAWZjraI0pXPrIeEvOK6f+8QP1upiO5xPihTnrA1EkpfQBc+pGsBuqN9PXMvoQwYszdR1qj6rNgM84frdacbropNnY8UgUk5lvpVRN41MI0Zgs
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(40470700004)(36840700001)(82310400005)(103116003)(8936002)(36756003)(40480700001)(8676002)(4326008)(9786002)(5660300002)(478600001)(70586007)(70206006)(2906002)(54906003)(110136005)(316002)(40460700003)(7636003)(82740400003)(7696005)(26005)(47076005)(426003)(41300700001)(2616005)(36860700001)(83380400001)(1076003)(107886003)(6666004)(336012)(356005)(186003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 11:37:04.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b9bc70-5647-4770-253a-08da537a5d8e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3597
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root Port
functionality at Gen5 speed.

Add support for YAML schemas documentation for Versal CPM5 Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index cca395317a4c..24ddc2855b94 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,17 +14,23 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+    enum:
+      - xlnx,versal-cpm-host-1.00
+      - xlnx,versal-cpm5-host
 
   reg:
     items:
       - description: CPM system level control and status registers.
       - description: Configuration space region and bridge registers.
+      - description: CPM5 control and status registers.
+    minItems: 2
 
   reg-names:
     items:
       - const: cpm_slcr
       - const: cfg
+      - const: cpm_csr
+    minItems: 2
 
   interrupts:
     maxItems: 1
@@ -95,4 +101,34 @@ examples:
                                interrupt-controller;
                        };
                };
+
+               cpm5_pcie: pcie@fcdd0000 {
+                       compatible = "xlnx,versal-cpm5-host";
+                       device_type = "pci";
+                       #address-cells = <3>;
+                       #interrupt-cells = <1>;
+                       #size-cells = <2>;
+                       interrupts = <0 72 4>;
+                       interrupt-parent = <&gic>;
+                       interrupt-map-mask = <0 0 0 7>;
+                       interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
+                                       <0 0 0 2 &pcie_intc_1 1>,
+                                       <0 0 0 3 &pcie_intc_1 2>,
+                                       <0 0 0 4 &pcie_intc_1 3>;
+                       bus-range = <0x00 0xff>;
+                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
+                       msi-map = <0x0 &its_gic 0x0 0x10000>;
+                       reg = <0x00 0xfcdd0000 0x00 0x1000>,
+                             <0x06 0x00000000 0x00 0x1000000>,
+                             <0x00 0xfce20000 0x00 0x1000000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
+
+                       pcie_intc_1: interrupt-controller {
+                               #address-cells = <0>;
+                               #interrupt-cells = <1>;
+                               interrupt-controller;
+                       };
+               };
+
     };
-- 
2.25.1

