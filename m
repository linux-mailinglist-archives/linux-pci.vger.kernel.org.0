Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1491A127A22
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLTLli (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 06:41:38 -0500
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:6042
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727184AbfLTLlh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 06:41:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzTjJJ4A+jzCdqYdWm337muHB1+nuGndGztxjuX9qPVVNV4bbo4eIZqKYj/Wb6y2MHIncBhc7vSTWrmoYrUMixyidEISHVmA9+ILgdXelbHPwhhs2FA8s12uTDKEXAMOEaWrKw64aI4D8jNRVt+EVIr1k6HBDF0JZ33jIvELZ2PD7uGKeC0MOoxaKcfoVCz8BaJH75ICWQ3ygrUrWeIb63DvXLrxn3jP8mYBYEuEq8bNF6v5IEblSfMOXiQXlA/w56OHZABAu6BKbhaTgGAf1FXbl09+G1/ztkTpt6QzhbHCak8tX7JH+CObAKiZlo2zUpn7GqQ3nJa07A/N8kRB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RqJ8YCPzP1LaanrG6FCqG4zt0MHlWjzuB5qrwYKXQA=;
 b=l8xHDCk/8mLIzgdFTvsmidnh6Ja9C44SudHniTvTJz6FZZX4FQRcXYR21RROn3PCxabA368Mo5UQ9NpLFyoXjA4Alze8uHu4yjn4XB9GIXsj9EHECI18Mpc9yo3xBoBpUzjZgLhSo3e0cV4R7TImlyKRJEb5bI1DALjSM1Fp6s9cNCzn5Iu68tWkPIvqEE0/QCN3RShX5PQIMhhWkJF2eQfWP7xfbAElsi05xn2duadgezdS82NjFEOA6on6YZGVHBj4TO6/CQc4peTx0jY/zFsdg3vtQNjVxBvTh5CqAttCWDv7f9ZZ3s0/U/JEg5GO5MPyTXixWGLJA1wgMWD3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RqJ8YCPzP1LaanrG6FCqG4zt0MHlWjzuB5qrwYKXQA=;
 b=gO/lxsSIn3yYn8e7+ZfdkHfPEyFuLq1nduIS7POBQMKgOjKdr9O6r80JUMlJtPWzTBK0Z7i9uNMH20q8jxAy22BY2Nuvx9SMQPICw4IlAri0MwmYWeVxVUrk4RYBg0iQA0d0fLXrPtPRN+vjrzCbi4Q0Nn3tzyCWwUk4R7a/kTs=
Received: from SN4PR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:803:2b::12) by BL0PR02MB4833.namprd02.prod.outlook.com
 (2603:10b6:208:53::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Fri, 20 Dec
 2019 11:41:32 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by SN4PR0201CA0002.outlook.office365.com
 (2603:10b6:803:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Fri, 20 Dec 2019 11:41:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Fri, 20 Dec 2019 11:41:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGex-0001Hh-Uw; Fri, 20 Dec 2019 03:41:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGes-0006Ne-Rn; Fri, 20 Dec 2019 03:41:26 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBKBfKjn011899;
        Fri, 20 Dec 2019 03:41:20 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGem-0006LD-3n; Fri, 20 Dec 2019 03:41:20 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/2] PCI: Versal CPM: Add device tree binding forversal CPM host controller
Date:   Fri, 20 Dec 2019 17:11:11 +0530
Message-Id: <1576842072-32027-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(316002)(2906002)(36756003)(107886003)(7696005)(8936002)(5660300002)(26005)(8676002)(426003)(81166006)(81156014)(2616005)(9786002)(4326008)(478600001)(70206006)(70586007)(356004)(336012)(6666004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4833;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15eb2605-4664-42af-3512-08d785418f96
X-MS-TrafficTypeDiagnostic: BL0PR02MB4833:
X-Microsoft-Antispam-PRVS: <BL0PR02MB483334368F2CDDE87FA83CB5A52D0@BL0PR02MB4833.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 025796F161
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQfw01YNKy9FHNjNSD69KTUwqhsIxteUv4Vb6JW3VIFrlG4r9kW9q1alJIE60Fr4Z0bp5NY6srNtrAW1LSVbfyRKLBnZbKvhaZDThAGnv70FnPHZ+g0tIOYqnZy3aYXwJCW2+so99adIQTmQeP3PHAutITtkGTiakOfLYOpSS3pYLo8oyVmAYiL0AJj6toIgOBFpofrazogelLR2f30JzsYB7k1CNPY2NW62RVo5DyidnR+54QEJFYBPavLY2K8dBrsJhu5pTTMLA6bIpC23yQ4jAfJ5ki4N8M1S80MsDecjBfRk2cnq8VvFPliDH0LZeH64vXp65khoPms9+kWEfvn103zAGsLaGXZaXjtspuacb5AYPUpjvaH+cG5ScjLskvWMhU2qflOAams6QuFfiV9pKbLRIYQyVZ7CLQlXOBSRs8iouWBKs53p47Rcplmn
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 11:41:32.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eb2605-4664-42af-3512-08d785418f96
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4833
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding device tree binding documentation for versal CPM Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
new file mode 100644
index 0000000..35f8556
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
@@ -0,0 +1,66 @@
+* Xilinx Versal CPM DMA Root Port Bridge DT description
+
+Required properties:
+- #address-cells: Address representation for root ports, set to <3>
+- #size-cells: Size representation for root ports, set to <2>
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+- compatible: Should contain "xlnx,versal-cpm-host-1.00"
+- reg: Should contain configuration space (includes bridge registers) and
+	CPM system level control and status registers, and length
+- reg-names: Must include the following entries:
+	"cfg": configuration space region and bridge registers
+	"cpm_slcr": CPM system level control and status registers
+- interrupts: Should contain AXI PCIe interrupt
+- interrupt-map-mask,
+  interrupt-map: standard PCI properties to define the mapping of the
+	PCI interface to interrupt numbers.
+- ranges: ranges for the PCI memory regions (I/O space region is not
+	supported by hardware)
+	Please refer to the standard PCI bus binding document for a more
+	detailed explanation
+- msi-map: Maps a Requester ID to an MSI controller and associated MSI
+	sideband data
+- interrupt-names: Must include the following entries:
+	"misc": interrupt asserted when legacy or error interrupt is received
+
+Interrupt controller child node
++++++++++++++++++++++++++++++++
+Required properties:
+- interrupt-controller: identifies the node as an interrupt controller
+- #address-cells: specifies the number of cells needed to encode an
+	address. The value must be 0.
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+
+
+Refer to the following binding document for more detailed description on
+the use of 'msi-map':
+	 Documentation/devicetree/bindings/pci/pci-msi.txt
+
+Example:
+	pci@fca10000 {
+		#address-cells = <3>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		compatible = "xlnx,versal-cpm-host-1.00";
+		interrupt-map = <0 0 0 1 &pcie_intc_0 1>,
+				<0 0 0 2 &pcie_intc_0 2>,
+				<0 0 0 3 &pcie_intc_0 3>,
+				<0 0 0 4 &pcie_intc_0 4>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-parent = <&gic>;
+		interrupt-names = "misc";
+		interrupts = <0 72 4>;
+		ranges = <0x02000000 0x00000000 0xE0000000 0x0 0xE0000000 0x00000000 0x10000000>,
+			 <0x43000000 0x00000080 0x00000000 0x00000080 0x00000000 0x00000000 0x80000000>;
+		msi-map = <0x0 &its_gic 0x0 0x10000>;
+		reg = <0x6 0x00000000 0x0 0x1000000>,
+		      <0x0 0xFCA10000 0x0 0x1000>;
+		reg-names = "cfg", "cpm_slcr";
+		pcie_intc_0: pci-interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller ;
+		};
+	};
-- 
2.7.4

