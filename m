Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26012F7F1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgACMEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:04:47 -0500
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:6248
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727527AbgACMEr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jan 2020 07:04:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbqTxYJqYKFD0BuHVJv7/aOYARu7Rx61ccFFOsFnM0ri2+KFudmTdGUvrHlumbd4Sb0twGRo4pH43FC3kzEd0GP/jQTy7XCy8Bzo0ulVRO+cL3EsMB/46z+7yWkuHxr+APRMEoaGjaxAEas9+EO7OdEkLhReBPrI/FaJbYhe493sLAQCMKuIiNdZvah2e1eicJePByM1wBDliwYsKr8XvEPY56AUt6dUQIasYl8fnyA8enH4S9J/5Ccf0ERsWdVvIqGpSUFSsfYn9SulZjaIga/3RRrig0cG80dFN3Ya087JrFQ6M35pCD0qPNDaanHmGgqBpuLwueGdiIfmjIGVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TixJ/2Rl+pk+8N9z7TgW5BMZN2JCC21Npy/ETR0vwg0=;
 b=bY4Nc3uHLrm++CXpMNa8Fxnhpm+rIvqsCXyhTUhFqkUjVPMDl0kZQNnhZKdPs/nnnDaAunZAUdzGCkztz+0rfZZp6zXZlgoup9sl7RtCnBxCWvkCF0QUGcs9uUUHS33FK1h1e3y73xqhEZss15K6k9WzeFL6BVE8B1WsDSOb1qq6Ae9xbY8MV+CO9X22SXasfsKGFth7Ko5lKALDUMMwQEaRGqHTDFpisaIwG135ieJbAgd44o4Gqv/iVs+FOPtY47FT2lG1/O9ik5fYSEmn+RshNZt7qf5XWB9vN1NebAdhNXV4Bk68Cr8iiQn1UTre5P/sH2eJvDt6BPMw8dHwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TixJ/2Rl+pk+8N9z7TgW5BMZN2JCC21Npy/ETR0vwg0=;
 b=EFrOkrslrOmceJalWXwoxdR68ynCpJeRS20vBWfgcIK248z15F6uALis5Aj7vdzTSaLiHpwaiHwVesa/fudaQyRC/LcJrcavruSWukq9sgPHZfHoxRckrVBm4c1T2kaIfSsdKjFTodxrNM/1COlSrxNWsuzToBibNehI/axScKI=
Received: from BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36)
 by CY4PR02MB2552.namprd02.prod.outlook.com (2603:10b6:903:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Fri, 3 Jan
 2020 12:04:43 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0095.outlook.office365.com
 (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Fri, 3 Jan 2020 12:04:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Fri, 3 Jan 2020 12:04:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLh4-0000Jk-Ly; Fri, 03 Jan 2020 04:04:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgz-0007pu-Ic; Fri, 03 Jan 2020 04:04:37 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgs-0007nw-AS; Fri, 03 Jan 2020 04:04:30 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 1/2] PCI: Versal CPM: Add device tree binding for Versal CPM host controller
Date:   Fri,  3 Jan 2020 17:34:21 +0530
Message-Id: <1578053062-391-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578053062-391-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1578053062-391-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(81156014)(6666004)(81166006)(70586007)(316002)(478600001)(8936002)(356004)(2906002)(8676002)(70206006)(36756003)(107886003)(186003)(336012)(26005)(2616005)(7696005)(9786002)(4326008)(426003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2552;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688853ca-0615-4fae-d5e6-08d790451e84
X-MS-TrafficTypeDiagnostic: CY4PR02MB2552:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2552EF52834ECF2667E0CCA8A5230@CY4PR02MB2552.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmPCqnxmPVBluLYI0HTznExi2Y82cNen2lrVpVyXSOxTn99/uiACLQt/rFsVveqNEcz1kmKPbTb03ypPy8l7ypq/996Wyhcoy2bPT89Sl2vvSDnHGbodp1XPWbfGk+aUeXNERVHr5PW7ESrfQPeIneQJ0ZNDNhBKbNrT5Pw8/T2369XxAA2GcshPDP+bIhS87TO/WNF40OUw6I9b4HkfkDtJSYGsSvHsr4w6PgfFSN4sP4c4rRw1Y2+NMLC3qfEJhR2hE2olLDFgeTrK+z4TT3bWXNuBzMqExrPENx1uqoVVPLd1Vz0/CO0svsW1jdWEUWHdoE+cA+8Rvo4kMKnH9HOGEJu5LE32rct3TMsHbA+Dmi0U1NavQbsVPpSsv2q86OLnctST8oztYDm+EdaT/00va8Bh6GeI4Ngivlcdovcis0ktKNpQ96fUa3mKl76B
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 12:04:43.2897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688853ca-0615-4fae-d5e6-08d790451e84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2552
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding device tree binding documentation for Versal CPM Root Port driver.

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

