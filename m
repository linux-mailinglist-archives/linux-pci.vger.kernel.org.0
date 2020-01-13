Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52662138E7D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 11:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgAMKEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 05:04:16 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:6244
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbgAMKEQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 05:04:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp1v3i1UCi9nxVb+w6/smkY7l0I9mtg4qCXkTwAmdSdQmzul6XfWZITeVjzJUM3mOpmhx71qTR8IH5yB5AHzy60XdWtDpsJPBVjDOHdFd7SxRPuQ0k6BJSJRVCGHSXyA/ACYmLkacNNcaJjy48OhHsN130KTgb9tC3Ki5AUzdX8W//QJZmExiN6fgJ5hoYFiLzJ73Vde7GoV+Rc3txn6IJybZH/fNRm4KPhcinQxVG/5FBSfwFh87l7oG+8teGesLinMYUbecdka9upAwzFsPn01ZgWlo3gV8GZnD005jKM4p8Y41pSDVh3hmG6bk2A33Fdh++yPEPE/hY99kalifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TixJ/2Rl+pk+8N9z7TgW5BMZN2JCC21Npy/ETR0vwg0=;
 b=aIa8bOdFq5IpMSSY9xeoVYltaKDShMsJmUUTeeGcZ8w2J2Td/lyxuALiOs2JuahXRuN2G3WyKqtLv6BSuQQ3jPjEI4wI6UF/pZYU0gcwnf6gLWnTSK0a1XkPfWOCfLVyolbC6AMts+MGj9OsBjThTW3uIPPuKgnvXhdt0TfY4hSCvXCMJ6VngfZCKxpofRxJeaZO4Q0vm0ROKg3yOTZdF7tEiXIf9Bfigzss1kGKWkL3gV4y0QswkzhdMde5rbJcXTB4LWwa5BlqdUWHgBXpQQi6zJH4eTvwkZoae898xQI6cmD08iux7QUoJ+cH2yFMJh/hEFPMCqkssEABfMUwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TixJ/2Rl+pk+8N9z7TgW5BMZN2JCC21Npy/ETR0vwg0=;
 b=dRg1OPqntUnAfGypd/+SK3ydfKy9aDWej7NsWk4P1B2c5P981ZfU/ngJO8gThgij9+HQ/xewwdNJVm8KwHmdQ1gxZxSOGG9nXTNETWy+u8fuZgLcpyD+R2UG+MUx1TeFj3WDnLhBUSDKN2wmAdPEQTdJISHvbUT040pfr/2l+vg=
Received: from CH2PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:4e::32)
 by BL0PR02MB4596.namprd02.prod.outlook.com (2603:10b6:208:4d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Mon, 13 Jan
 2020 10:04:13 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CH2PR02CA0022.outlook.office365.com
 (2603:10b6:610:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Mon, 13 Jan 2020 10:04:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 10:04:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iqwZw-0000S1-CT; Mon, 13 Jan 2020 02:04:12 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iqwZr-0007Zs-4D; Mon, 13 Jan 2020 02:04:07 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iqwZh-0007VY-B9; Mon, 13 Jan 2020 02:03:57 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 1/2] PCI: Versal CPM: Add device tree binding for Versal CPM host controller
Date:   Mon, 13 Jan 2020 15:33:40 +0530
Message-Id: <1578909821-10604-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578909821-10604-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1578909821-10604-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(8676002)(36756003)(426003)(81166006)(6666004)(356004)(2616005)(316002)(70206006)(81156014)(2906002)(478600001)(8936002)(70586007)(26005)(9786002)(186003)(107886003)(5660300002)(7696005)(336012)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4596;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21f9a591-2f8c-4ed6-5627-08d7980ff0e5
X-MS-TrafficTypeDiagnostic: BL0PR02MB4596:
X-Microsoft-Antispam-PRVS: <BL0PR02MB45960842DC5509D8C5E74D06A5350@BL0PR02MB4596.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNDAdyV2aTbA1iobQ4nHnQgVh2TUkjGULjcgRzeJnRIHWrKhyqezu0RE9SiUREdmhl2enqtCLURvOMAgNEe6ryNqSc/b0xaWOGI180/OY2DUGSyfRjqQmY1x/GtSp6cPlkOwwhfQbKRVOowgNDPYT3NZCRfBoVhlFpUo/0kc/lLUxUQp8QI0VGUqlrGyHSjbwCxCnzH8e/f57VF5wg0yjnHA80qPGprJUMLVelW6uB/OIrfHgIcYYOVCPGSH8KmCOpyT+rz097mw5fyPI/CMgGvtq6O/JbcSj26GXlL6JlIA2u/BYyU4NiCmg/OLgBnMBI4FcWSPzu3zMjny41bH32Z50+ZRY3nrpIUWvZpUcy1DxBhS/lz4OsNwpWgYrMh1/BkA26xd5w8KYyxftDCrIlso5LwIEBqEGv8nSn+3qADcToLyGeW2gcQQ4pv8X8uu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:04:12.8216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f9a591-2f8c-4ed6-5627-08d7980ff0e5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4596
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

