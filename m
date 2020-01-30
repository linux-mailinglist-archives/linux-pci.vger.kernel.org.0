Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42F814DEA1
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgA3QNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 11:13:19 -0500
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:28484
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbgA3QNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 11:13:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0cl9OPnBHOz2F0sSV1F5du099Lqd15SObPrRul/q72E1Go2HErRS/blNHq8BspK63XlbhnzlVNf14i4FsidecNwaPZWdiTj7yWxmOLpcNEvjWigyz4wAVeJRZkuYfq0ZULzwdZCLkvkC80sBWrCgkG/JH75Oy9ZLNTKDadk/VwA5uXTspzXcZhDdco9vN+vaUnALckgz/MmgSy7z/hQK14EdrLxPLmeslBnXrrNzEJcM94oDnjg1TAoAPJsJnRcaB8mfAV3DKAwjG+kTE1Ck3x8WLm5aXY6ADf26WqW6TaFB9NsPK74boZajVBFgjsa4k9wm+p3GGQrrvZUNBkAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7ne/ZO5UD51mqS/R2k1lor3pqdsaqfLX+Upx5pYIo=;
 b=O9FsAIwkTCR8sIAM9Hlj5GVjYPl92sc9nYeVPqNF3kIipUiEogIeMYv7z6LmPgsg10Zud5jXN3hUG1zOJGQk+AaSiJ4UBtayrPFZWNldPzpFMs5iITCuY52dOhxSMpAYyu+jcn1jIFKYSfpmQDEGH6NcdX/mmaSmaAePMgJzvpsEcg/cFkNBnNBKLZQq4fJYoPMO4bjtnlD17vxk0q03N4s/dEjKm05b8T97U10hLUhGuWA6FvO/EqNwstpndHHuNRKYmdyufccmIjJZv+XduXqumhGXlCRFUQfjmwJxRu84X0oI32nBK96B17r3CNFSbu4AqzoZTr1CxM6pFKaIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7ne/ZO5UD51mqS/R2k1lor3pqdsaqfLX+Upx5pYIo=;
 b=P7/F5J6lLY4h+Z7+pP41ImyfgeClplwdU2vxAJDON+6iPvlVd7fVSeEWmpLJwxyu1dNwLL8RQ/Zup62kDfNWTcl0RxoG3sQ/UuYh7OYtFdw8PwUi4cmwh8YBikpfnlwKTh3ZdvtDFfebF87YxM/8FWGJok5WC3aBEBbZ1XYQ96w=
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by BN6PR02MB3137.namprd02.prod.outlook.com (2603:10b6:405:62::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Thu, 30 Jan
 2020 16:13:16 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 16:13:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Thu, 30 Jan 2020 16:13:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1ixCRP-00028F-KM; Thu, 30 Jan 2020 08:13:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1ixCRK-0005oM-Hq; Thu, 30 Jan 2020 08:13:10 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1ixCRE-0005mP-Ct; Thu, 30 Jan 2020 08:13:04 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 1/2] PCI: xilinx-cpm: Add device tree binding for Versal CPM host bridge
Date:   Thu, 30 Jan 2020 21:42:50 +0530
Message-Id: <1580400771-12382-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(336012)(186003)(2906002)(81166006)(8936002)(5660300002)(81156014)(316002)(2616005)(36756003)(26005)(107886003)(70586007)(6666004)(356004)(4326008)(9786002)(478600001)(426003)(7696005)(8676002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB3137;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c458f26-114b-47f6-63df-08d7a59f5062
X-MS-TrafficTypeDiagnostic: BN6PR02MB3137:
X-Microsoft-Antispam-PRVS: <BN6PR02MB313756867F38DA61BB4FBCA5A5040@BN6PR02MB3137.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02981BE340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPzObklTg4muXcx9TLXfr5TLZ7VLWjLKK4uB/xqZBdVAgU36/BNuscSvF5x63EqqZ1g6xb9DADo4rQeM9qhf1AwItYtpMUkyQ2AXH8VUITn95jV1Tt+2WfO3D9j58/qScIG8mzrEHhqqP4XunXNMEOf/CbaMHmQVEqMGym0+pEU91o/Y2FOpxOMT6iLnJv3VqNQdONDzcU0jmQjJFNGIX8pRbfqFUDXIZyRlK/2P1NqkjuYlmbu0cTTdLzyt3n+WIWxm+/mHW16kcbWLc2kn4KWMhr6W2MLUOaEtFPNyu4ycii9i0Q1igua7lDkiYPBFUJcrVCz2rtvT5vFxbXTbg4O6XwTs1IgX+O1eQxHHF/fQo3/Buy2CT/hjs7qsJkmdPjBv+yowGWsI2baFsw7lsG6JZq8HIPE33VPFmcQ0ZXICml8vkSVw+GZeVtOPEZ9p
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 16:13:16.1491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c458f26-114b-47f6-63df-08d7a59f5062
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3137
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

