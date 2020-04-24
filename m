Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDBC1B738E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDXMEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 08:04:25 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:8545
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbgDXMEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 08:04:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4+MmrvKbpOkdOXwTQ3CqAP/b7U46Corqc91MhEsr0sUSi7dxQdFOACjbxFZ/SYBevFJNUTZYj1WVPNKe3OKfN1yK+pgVvhezIQ3D4NTvSzBmocYMZT0SyaZ7dWhKpMaDdP2os13vVcdXSKIHHfrmMSw9d2mGTuF/h9WmN3GyMIaLOgQdYsP/whBP2OIL8UFycSzOfKfvdVD9GNngXPs2qbxKYNolVjXCkOhN3OHq4mFqcIPsEebSewTmkZiVQrjtyhmv2DH3GiX8EUqOZUGtVZtEeUn92OUTEcK5muEKcfA5dG2AOSiJJOdp77TOCJ9SO8U3iiASGpUrEmh3p2FdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrYN+ez5SyyxwZRRO5BRlZS/Qgy4EeC145iu/iSZE/Q=;
 b=KrEaup6W2+YTdXfeDXl91wtTlynVl0AaU4MEk+XX1kl4lV6Z/lIYmF2RCseG4MV9kVIp5xXtqvK+7bMPT0K/X2QUuTUAC0r8wC/LAHP5SSwx8O+495QovTUweOcm/4X8YJjg8SMsBu/EdirzfuSRZp98JGZE3/FVznlSnXG6FeFlgzIpjKXsDoETtVQ3TCkT64N5FrNJjr6BhL39b1wGOKrZnIeisIFLfNqHAwg7wWbloUM2n7KGF44ilLew/ZkMwg0uIYtfH22/I0s7XDilJei97KyBOUjXAWLbufy2WVHtddzCV6GDuarLT0SnWJLH4sqLYbnuvlFZg3p44juhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrYN+ez5SyyxwZRRO5BRlZS/Qgy4EeC145iu/iSZE/Q=;
 b=rrbJtjtB/YAaC137m+d5dnB5Jk9D5BjIdSNgYDIGiE+UGJSwE8zbjioLfLzSe/JmRSeYw+zsQzkvbiVftI3eNWH7uAmMr9j/KvBnTLWyfFJt6X75Ltkno2TG17yQ5X/UslQ0GGUFkgoc+Gf48Z75Oukvt/Sd6vsSM0v1m8ND4F4=
Received: from SN4PR0701CA0038.namprd07.prod.outlook.com
 (2603:10b6:803:2d::31) by BYAPR02MB5672.namprd02.prod.outlook.com
 (2603:10b6:a03:97::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 12:04:21 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::bf) by SN4PR0701CA0038.outlook.office365.com
 (2603:10b6:803:2d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 12:04:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 12:04:20
 +0000
Received: from [149.199.38.66] (port=50978 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jRx30-0004Sg-Bt; Fri, 24 Apr 2020 05:03:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jRx48-0000zU-7E; Fri, 24 Apr 2020 05:04:20 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OC4IfT027900;
        Fri, 24 Apr 2020 05:04:18 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jRx46-0000yh-3o; Fri, 24 Apr 2020 05:04:18 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v6 1/2] PCI: xilinx-cpm: Add device tree binding for Versal CPM Root Port
Date:   Fri, 24 Apr 2020 17:34:03 +0530
Message-Id: <1587729844-20798-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587729844-20798-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1587729844-20798-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(356005)(186003)(336012)(316002)(70206006)(426003)(4326008)(81166007)(47076004)(26005)(82740400003)(2616005)(6666004)(2906002)(5660300002)(8936002)(70586007)(478600001)(8676002)(82310400002)(36756003)(7696005)(9786002)(107886003)(81156014);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf922103-9bce-4967-506a-08d7e8479f1a
X-MS-TrafficTypeDiagnostic: BYAPR02MB5672:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB567212AE6E592449799BF14BA5D00@BYAPR02MB5672.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7z3Q3VNC70O+P0VEWgqa4+cPWKmWLu54bNn35V9E5YBHU9rhjNbyqIKhbxB30+X8qdmphoc6xZq0+/FsUEo2DodNv96ZTL/T+63WKFoVjkLd7N3Eo3KbOEb6F5izQ6/qhvqlG6wShmjCidQfZ3zq4wyxwAXrA6F78GCn41DKjNmuU1MtsevCQIiP4mV/mMAV+dJM1LM1bZ7xtbWvbuPrzvb7RyrBeoWqt+gwDc+7UV1xvx9CBZ0e5wWa2/kWv7Of+J/cq8iu8/SylCwAgTxK3H8zI34AzPuhwNCKr5AA+qEJSEqSpEJdF/R/hSHn8n3/R13XtMNYIiseIWAaS0w/dm+dV+d5bASNY0Z4+CPgIr5j8HGq6nfctc86NtrfZbuVjTU7f3jGQJ4soT6E1y8V3HUqmYuZKKrxo/kiaaIWounvvL5IQWzWrzbXTPWnf/oO2ppv2fwXFWONOJ85oDBOtvukkEoUMh2CzINu4Qyyqf4EIqu6zYQ0HYX1iEAnFjz2Dh8patSmlqzjmhMyIF8HKA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 12:04:20.5768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf922103-9bce-4967-506a-08d7e8479f1a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5672
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree binding documentation for Versal CPM Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
new file mode 100644
index 0000000..eac6144
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
@@ -0,0 +1,68 @@
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
+- bus-range: Range of bus numbers associated with this controller
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
+		interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
+				<0 0 0 2 &pcie_intc_0 1>,
+				<0 0 0 3 &pcie_intc_0 2>,
+				<0 0 0 4 &pcie_intc_0 3>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-parent = <&gic>;
+		interrupt-names = "misc";
+		interrupts = <0 72 4>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x02000000 0x00000000 0xE0000000 0x0 0xE0000000 0x00000000 0x10000000>,
+			 <0x43000000 0x00000080 0x00000000 0x00000080 0x00000000 0x00000000 0x80000000>;
+		msi-map = <0x0 &its_gic 0x0 0x10000>;
+		reg = <0x6 0x00000000 0x0 0x10000000>,
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

