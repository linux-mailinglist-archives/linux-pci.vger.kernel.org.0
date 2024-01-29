Return-Path: <linux-pci+bounces-2668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7E83FB96
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF6EB20C80
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1038F70;
	Mon, 29 Jan 2024 01:02:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2063.outbound.protection.partner.outlook.cn [139.219.17.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB05F515;
	Mon, 29 Jan 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490131; cv=fail; b=ex6QUsvx5DZmR0ZwwJEE9FOOX+oM7r0dxwnvGgU+mmbyqF5Qp2kD54mApgSutjFdnHcvcLJ8iDoRriQbcKRl05nDvOh5A8so5WAyKzeDbmAs+0VBFS7hALbfMUkM0ZBzZ8Va3hcckAOPpYkiyJk4CWyGpBwG9OM5m9CyH5BJVfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490131; c=relaxed/simple;
	bh=S2lDL0gD7pPak+dReXlI6JFdBr+tBRJUw89XXRjBFG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovnQVjn8fuW+Dze6qsOmpUFy3pqFeY6b03yOZ+NYtmm2TmGyI/h/gr5QFICxz3QaCd8MXKoyllkQTfEgcs53elOwTVIxlIMqDgZGeG58ZG6y745XxUliXL9VgqGpkLTONpMeQNQA+es60bYOKdXL33U42nlouFE3r0pcDad7ZsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcisV9TWTTWpRcb63z0QsLALaQRNlrFTYsrmbVa1h9P+t76y7/YqJOyhL3IFeB4boTp3B2xJ0uL6pPXuc1x01XJ1kDWfhrvJR4Gvlquvk9coXQPL01gpHdJqV3QyYEAwV5YDnqlnpS6D2Uv35Kwt3J37vfiSAfGTzsGl+nJo0cdol8Z+GsoNRmB44q07KMuAOVHDOZVSc+hayKL0RYvoyojGW7XaxxNEKSNJugd/92BbIFKYGU/3CDwtJKGpDR+PiE5NaxSk1kCDf2bapH/dXseZf0ZvFFdWqCFeXQj6jRAqkMjdQfKeLPBvpcBAyUd3AUaIf4sWjLOEl5xYB2cIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIXi8JBQnxVNAlvrZCPiLc7iuf6UII3Un7BOHkCInrQ=;
 b=D2FR9lBFHVzrWAZjiGqeE5REc0AOQqhmlEZH6PMg33YUT7YgE9XwvJ3o3JOsuw+1hDlg/2TbXZdXU/1ByFh6Uor/0ueqKQdpjMN5UJq/IFD0/pZOwxwdfha69n3G8EIdIDWn0q+MGehen0H7VPZiYj01rqrZ11kxop+VEI8GH+nko+nnjeLTFJiqlcR0BfxuNn5c/0UgMlZPNShAHBsSIeK3TkuFhZNlrPR8BAT1eD/ms1VztwhoTxUFlzHMDppvCGf+PoFnrjG23bJX295kcm6YQ97IyQTbdudcp4obcfvOwfUtiMgjaQqdv71IBMOVwo0CH12wJehItvx65mqOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:02:00 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:02:00 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v14,RESEND 22/22] riscv: dts: starfive: add PCIe dts configuration for JH7110
Date: Mon, 29 Jan 2024 09:01:42 +0800
Message-Id: <20240129010142.3732-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129010142.3732-1-minda.chen@starfivetech.com>
References: <20240129010142.3732-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d90048d-25de-4956-adeb-08dc2065e5c0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XChOFFnG9VdyXuQFXksUq9g1AAebnNe2piVREg3ZUiJ3LXkVZTVow53Qqi/AfFAJfjHzrPIiFTuYBJXUdYjoLpJeMPXHK5hGxIG+k203NBdpdNQwDmYgyhtTHR2rzSjsJu9iTLnqT27lIfhVhm4EljsFPRtjk6PBE2aYv1HJjd81M6H5f1mJm4fg4MhuWsIKoiblXR5UVQWoi3GULkTMhPda2+VY9CakdqzoOQClCHt0yfhxc9bk7MgpkeqgZkQg7aZ3C+CoFSE3N3shTsiqY7QrcVQQF2CEXoMczYV/QhQ3ZmpxIMeTPK9k+Zgwc2/v5+DzoqCa33c8I1STtzuXVakFDQ3D2C5IW4bGl9XqAxtDZwiyd91/6Ak8jpPQiDBFRmOqrttaql4dbOY1jwSDzpudYYMsSfxR61fsmqgM7C4ktWpkCDD/li7/647Z0tKOBvYpNdDkN+DTZ68yNDhe7YO/J+ewgyZ/vAByvuI/Wq7QTiamc/ROFqa7CEW4HPJjT6DAFtlQeE1dx+3t6qoxbd5mtmDbbbXUdf31DwFGKJmLgp/v407NT4DUf7BZvnBY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suqYYL6Z0Elz+9dTUfe35YjsAt1H45+EFUtbQDgoNuWAkE3baJU3eZ2Bn+N0?=
 =?us-ascii?Q?wWfNloboxBTInLduckNtbFOUqPfNgoz0YUEiJY0o/w48KtuykZLw5yWsKpX2?=
 =?us-ascii?Q?+2JAQahF6Q8GrUMIV8sWua/AmNnHuH8sbY5AqeUZAvDBuzJAU6JxMqp9J7aA?=
 =?us-ascii?Q?ay38D6du+DVtxuCICuIC2dwl91Ajc32tmQxvcD6iOZOPS6jsCLgCUqMjkPUk?=
 =?us-ascii?Q?HhvJZFew4kMDAqiuwNhXM2ZIIyX4Ff4VURGgCTw5wjgsmVBocELAci3WcCHY?=
 =?us-ascii?Q?hUU1o2PyhszB1ODsUX9lRsNWFhpK9Vq5FsqFTaYQCegZeTInZZkQnuKPamAN?=
 =?us-ascii?Q?Dq5K+luKPDmOF3CL0Mdhv9T4wyilgvMuNudhzatsH+Z3/sS0vsEZ6IZ2nRXB?=
 =?us-ascii?Q?qDo87UHZM65T05wRIu+Xb3BtIJtQNoNLW1PP9OaQJBdZ9eosRbc82Md4U+cY?=
 =?us-ascii?Q?8zLITwN6SFXJbDhOrlvC8yRIGMlnwih0GEWOddNQA3SP10lugTt3C2lTsusU?=
 =?us-ascii?Q?Ogw0Zz/SOV4jK6YrHkH+//r5UpXg5MSt/v6Dl6qIZzJTgAtsf6VUp4KK9JG2?=
 =?us-ascii?Q?Z5SzomDgnsviGAk5MaL9USlTLF3yQEQxHfVOS3rgPTQBgduBOHnorGM+4IpO?=
 =?us-ascii?Q?0OTmqt9UgPrMh2qyl+HraY15EGxQqiipm69MBToQkwpHxLWHE7/KckzdaRaS?=
 =?us-ascii?Q?mkh5DIeY7L494iTx4sgwlaL4bl0Q9W18GsC4VvRlePSce6G4I9QOw06ngg/R?=
 =?us-ascii?Q?RQyIoM7INaO+On2kK1bpeeb4pkerac+t0fhij9Ktfw++iXfVvVnO/l1TvWy0?=
 =?us-ascii?Q?0BSjvAtfNPqa+vwzXFMSJ2k3IGVEvlqfPG9AFhBAC8cY7GfoA/2EpS0Stu33?=
 =?us-ascii?Q?skunBpZQ7/eEWuGHQqF0kbX4uCMyUGHIjT2csJqgVYvAfpk/9J3aEEMlj49l?=
 =?us-ascii?Q?4VOJhbJeiKAmTlMmDIAVux/yrSM4hJDzNwKWV3olAcrcDEjxnN9KzG9sFZ62?=
 =?us-ascii?Q?OHbIL0H2WMgimyAh9kM0Hqh3u5BDm3iysnPAUaujqAcfXP56lr9V1Qf8BC7w?=
 =?us-ascii?Q?Fltq/5xDCEhttv27frKt0UPRXqLnwulukR34Xtace84/PduyvElM7rogUs3A?=
 =?us-ascii?Q?K/CPNrbLXfmsCe1bRUc40KgnJb0yFHQdG2cZQAME6zJDfcpdIGAH8RTraNdd?=
 =?us-ascii?Q?C9tWAf67JMuVr6qFtCt0RQ27ZElp369DkjgScDYOzXIZ0CsNwRR/pnb7vTtm?=
 =?us-ascii?Q?0GOEirFuAt1IQH9r4nmufQOr16JS8K0VGmXtYxa1Fq22E1QgwICEKWZbC4VZ?=
 =?us-ascii?Q?WZct52C7vobJlF9DF9FpVCk61nt3fqVcztF1wPShNpm4d0MwAjnHQidqZbz5?=
 =?us-ascii?Q?nE1tifHfGGMjN98N2VI2YMURsTRIz/2VZehYCHKsSio70kdEAIQUsVvhLtgD?=
 =?us-ascii?Q?DnxJxJyAagHrWan713UjWj+LBme6KBSBWborE1uKkxgYqWT6uY7ouDaoSmV+?=
 =?us-ascii?Q?KVDYdO8ugj3ARdjDEbMo0eZcLohPv6Ro7n7+tmoxFH3zuGf7A7arztu/wM1D?=
 =?us-ascii?Q?65fo63+nN50E7r429gdU4DEGDALP19NVYTdh3lC7SsKhfI69OXhxS9BxFxF4?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d90048d-25de-4956-adeb-08dc2065e5c0
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:59.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9BAYzmTeGYnWOATaiTflZkXeKGzcHvwTchJ0849LZF750nI99rgDJ9kYH6ONCYWE5pke3lqAjt+XGtWaZrVr34UW3SxDnOpMdLUzXj83CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

Add PCIe dts configuraion for JH7110 SoC platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 64 ++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..2f8056d6f817 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -287,6 +287,22 @@
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins>;
+	status = "okay";
+};
+
 &qspi {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -513,6 +529,54 @@
 		};
 	};
 
+	pcie0_pins: pcie0-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(27, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(32, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pcie1_pins: pcie1-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(29, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(21, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..dfa2f94ed5b2 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1138,5 +1138,91 @@
 			#reset-cells = <1>;
 			power-domains = <&pwrc JH7110_PD_VOUT>;
 		};
+
+		pcie0: pcie@940000000 {
+			compatible = "starfive,jh7110-pcie";
+			reg = <0x9 0x40000000 0x0 0x1000000>,
+			      <0x0 0x2b000000 0x0 0x100000>;
+			reg-names = "cfg", "apb";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
+				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
+			interrupts = <56>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
+			msi-controller;
+			device_type = "pci";
+			starfive,stg-syscon = <&stg_syscon>;
+			bus-range = <0x0 0xff>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
+			clock-names = "noc", "tl", "axi_mst0", "apb";
+			resets = <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
+				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
+				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
+				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
+			reset-names = "mst0", "slv0", "slv", "brg",
+				      "core", "apb";
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie1: pcie@9c0000000 {
+			compatible = "starfive,jh7110-pcie";
+			reg = <0x9 0xc0000000 0x0 0x1000000>,
+			      <0x0 0x2c000000 0x0 0x100000>;
+			reg-names = "cfg", "apb";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000>,
+				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
+			interrupts = <57>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc1 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_intc1 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_intc1 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_intc1 0x4>;
+			msi-controller;
+			device_type = "pci";
+			starfive,stg-syscon = <&stg_syscon>;
+			bus-range = <0x0 0xff>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
+			clock-names = "noc", "tl", "axi_mst0", "apb";
+			resets = <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
+				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
+				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
+				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
+			reset-names = "mst0", "slv0", "slv", "brg",
+				      "core", "apb";
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
 	};
 };
-- 
2.17.1


