Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA714B468
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgA1MpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 07:45:12 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:28916
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbgA1MpJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 07:45:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez3VK/suEq0ZeOrXEUf29ud0RSzQ7WTdRcEeQXt5fQoqApxzRObfgJXlFkmmF5CalZlWBveg5/CPsD3QAssiPD+svwZr+2Acs2MWlaKg+csI4CnM23kYsTtsdn8EbRjP2ov41KKY7EvKSNxhYZ5+938bGUF0z0n7iM+3XOqcu+i8s62NirepDxtdTOSPYcz4FHgLGfDnEjAexUYzNVbbJlnSpmmyT8lbNhcVhpvvvA85RfA7cS21BvFcDIe786dNJg7FNWoSOa7esRPTAN6RgxeGN1YksFRt3Goti7P+rMWjFBqDF8E2JwoqBV2Gm7wT27FR3zW160eAWHRLttB85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7ne/ZO5UD51mqS/R2k1lor3pqdsaqfLX+Upx5pYIo=;
 b=fZ4qT88SGsizidVC+7MisLKXkjm2YyRjvelueZQDu8zP2Oeyx1HeSQPmk57t4L0XEXcJ+dpnlRezTjYniNDAAZfe5+MnV+6SGVioTkxJ+OJYG2gpMW6y1ZCp5M1qMwFmZI6+z14aJDWcRtud/vooCAQZkKh5gWQMueARNgnzAAjaP3kOH533MO4gIhMzLMFUXpgUuV+xUlGXKusmDjq4UKk9MTrjTV+1R+jROU2K1FNi+7JhquTy2mLSVC16N+vV+KA0xXNm62DRr54oNfa7mECI0b5b00jMgbPSPi2P8P57KmACCF6Lm0nlNRE8vN59rOpEeUfNA1eQiFXb3vKMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7ne/ZO5UD51mqS/R2k1lor3pqdsaqfLX+Upx5pYIo=;
 b=GxT8E+CoFiPATzvlnsrdMXyWPKM7/z3HWQEn1cA81Po2Idp3wYehVXeNd+uArzHvPos8p3ZYx7nu2vSMOcPkEdH6nddqk1S/oERd4XlUZTc2WiWIrgNEFBaaEmgACsor2CVYBul/cw7eySMFCIqth5i8em+Vhnv82LDqu/Sgozs=
Received: from SN4PR0201CA0042.namprd02.prod.outlook.com
 (2603:10b6:803:2e::28) by BL0PR02MB5394.namprd02.prod.outlook.com
 (2603:10b6:208:37::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23; Tue, 28 Jan
 2020 12:45:05 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0042.outlook.office365.com
 (2603:10b6:803:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Tue, 28 Jan 2020 12:45:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2665.18
 via Frontend Transport; Tue, 28 Jan 2020 12:45:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEq-0007b9-PX; Tue, 28 Jan 2020 04:45:04 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEl-0006rI-Lx; Tue, 28 Jan 2020 04:44:59 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00SCiubw016809;
        Tue, 28 Jan 2020 04:44:56 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEh-0006pq-Mk; Tue, 28 Jan 2020 04:44:56 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4 1/2] PCI: xilinx-cpm: Add device tree binding for Versal CPM host bridge.
Date:   Tue, 28 Jan 2020 18:14:42 +0530
Message-Id: <1580215483-8835-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580215483-8835-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1580215483-8835-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(316002)(5660300002)(7696005)(70206006)(36756003)(70586007)(4326008)(107886003)(2906002)(26005)(356004)(6666004)(186003)(478600001)(426003)(2616005)(8936002)(9786002)(81166006)(81156014)(336012)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5394;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cc6083f-bf2a-4629-dcf7-08d7a3efe65d
X-MS-TrafficTypeDiagnostic: BL0PR02MB5394:
X-Microsoft-Antispam-PRVS: <BL0PR02MB53949E8FB6854CC4E8846823A50A0@BL0PR02MB5394.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acwPlSjng19pLcdXUG/Hg7v5nYCd8XgMQW4qOMzzIbdEWA7lnpM8t/diGGyP0IdbA0w+zAF2CwDWUZuG/zFYz8F1Q8vAwTJn0/BokE+1SqqpJ40feBIjiht4QbDvXp51Lc2o7bR3lxLa6xD8C58S03wZFHKPEnOXR0DJqdFce4xb5rI1Ojw5oJpHXxxlQkun+EdYejNlgSj48s/DzCotyTPmu2veN8duthsHG1CAoFwsiy3FLsw4em2lzvAYame/qfeFPfn7qZIFWsYirPcyDIyZ2x6Ay1tyWo56wG9qgAuhwmCi4RJP7YVqBth4rVR+eVBvwSTcZwCkzP+O4IglctLodRIZhDyox3/6qD6w+eJsl8Xdbz5DWwtinpSGrU+v51oWj9qODjR1pVXkcAIBMtl6PuXpckA1zj1XfZ5MRG0D9VmbQw4cLqC0/PpNeewh
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 12:45:05.2165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc6083f-bf2a-4629-dcf7-08d7a3efe65d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5394
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree binding documentation for Versal CPM Root Port driver.

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

