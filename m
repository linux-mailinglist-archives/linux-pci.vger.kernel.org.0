Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0D632111
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKULqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiKULp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:45:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46EDFF3
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:45:57 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221121114555epoutp016eac92d7a46398fd0bc3632295350c7a~plv5PnNmk1836418364epoutp01G
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221121114555epoutp016eac92d7a46398fd0bc3632295350c7a~plv5PnNmk1836418364epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669031155;
        bh=x4NqUZy3eO/kKaGGQ+l1394E6XDEO1SQ1c3hYeoRUdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOdGlDYGnSf5gPMXd2eKtth3UZBw/l5s9ndcZtKpQG94wCVGwRMDQ2L0LxW4r5vwi
         il8v0rAjzFSJLWWjIlUBQ9j0P8xExQTN3f+3MxJcAEh0miLSr98oU7SaW9dMrRbY/M
         BYEO/biT8cvnh1V8DlCVr9M0W/+8chDp5s2GcSPU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221121114554epcas5p15551ae0f99ed701cf4aef8d29c850296~plv4WuiU81712917129epcas5p1f;
        Mon, 21 Nov 2022 11:45:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NG5Dx2Nz7z4x9Pr; Mon, 21 Nov
        2022 11:45:53 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.1E.39477.1F46B736; Mon, 21 Nov 2022 20:45:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221121104741epcas5p31e1320bc4c0912485c1fabe52ea19988~pk9C4GGg51558915589epcas5p3-;
        Mon, 21 Nov 2022 10:47:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121104741epsmtrp28f9fa1df6ba021ad610007d2d416a1b9~pk9C27YNs2142421424epsmtrp2Y;
        Mon, 21 Nov 2022 10:47:41 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-8f-637b64f1a3cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.45.18644.D475B736; Mon, 21 Nov 2022 19:47:41 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104737epsmtip15e885a17d36d7d307f0a9a4018d30058~pk8-ikYno1290712907epsmtip1h;
        Mon, 21 Nov 2022 10:47:37 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 5/6] arm64: dts: fsd: Add PCIe support for Tesla FSD SoC
Date:   Mon, 21 Nov 2022 16:22:09 +0530
Message-Id: <20221121105210.68596-6-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121105210.68596-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xbVRjAc3rb2wtauAJzZ1Wh6aazKKxllB1ecw4GN8NtGKYk0wSv5Uor
        pW362IaEDCcsGwPEuQkhUBGIhiqM0oGVrdLxNGYDlg5YpAuPQcKIAgMGbgyxpaD//c53ft93
        zvnOOQTmN4DzCYVKz2hVtFKIe7NbO0WvhzxKz5GJSwp8kX3uJhuNGVtxtHaph4s6LC1cNPRw
        gIvqzsqRo/0N9G1XHwd9UXsVRwNTRTgqmR7HUF7RKgc52ipxdNvYi6NS0zIb5T/LZyP7vAmg
        ycsTHNRtTkE1LUtcVDFg5aACWxcXGa1VABV35qKRPxs56Bfnb9gBPrX69BKgqpsNVLPpAk45
        h27g1OTdMhbVXvUTl7LUnaFKrpkA1XvvZxa12ByY7H0iM0bO0OmMVsCoZOp0hSojVpiUkhaX
        Jo0QS0IkkWifUKCis5hYYfw7ySEJCqXr4ELBSVppcIWSaZ1OuGd/jFZt0DMCuVqnjxUymnSl
        JlwTqqOzdAZVRqiK0UdJxOIwqUv8KFNe9vQcR7N4/PTK7a/xPJAXXwi8CEiGQ3OFmetmP/I6
        gM7RBA8vANhU9W4h8HbxIoDzXQVgK2Fisp/tmWgDcOVcA/AMCljweqtjw8LJYPj540LMzQHk
        AgZXvolySxhZDeD4vXqXRBD+JAVHnNFuh02+CkvKn7HczCOjoC2/AfesFgR/bLJv1PEio2Fj
        7QjurgPJJQJaSp0cjxQPZx4Ocz3sD2d6r20yHy7O2jYLZcB6SznmYSVcttSxPPwWtN+tZLv3
        g5EieLVtjyf8Crzye+OGgpE+sHh1clPnQatxi3fCpbUbbA/vgMYex+Z2KNhtqmJ72ljiauMf
        L5WCwIr/V6gGwAR2MBpdVgajk2rCVMyp/+5Mps5qBhtPO/iwFYyPzYd2ABYBOgAkMGEA78yH
        OTI/Xjqd/RmjVadpDUpG1wGkrv59hfG3ydSuv6HSp0nCI8XhERER4ZF7IyTC7bza8mCZH5lB
        65lMhtEw2q08FuHFz2Pl1mc/n7Qs/rW9CBcFJtS0fOl/es7R0/hEbbB5X/ANWvcxmNgBsXFD
        ywrdxIOwO68R6/dt08FGYm+Uj3Q4tf3W/TeXD/L4zvXEWfNaUj3zolyj+P654SfzkeWz/Sk5
        0YNTIk1/TOuYyFK4SybOPypQUL7Tgy+8X9NyLG4m1R545zu7wFxLn1xIW39cWXXxU9loqUC6
        6+M6yWG5wzoo1bf16c/2iHNkx6beY+0cUx7x2sdbKaXO5w7sPmEsnkvUd1oXHpza7ita/+CA
        /lZ2X9k24yfqoKibl3ObUkfLJ1/eL6+fViS2/9BwxCagj3f/Yz6fTIfsLjj091/jSsmjpLeP
        HhSydXJaEoxpdfS/ZeqSSGMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTtc3vDrZoOGstMWB9wdZLB7M28Zm
        8XfSMXaLQ5u3sltce3mB3WJJU4bF5f3aFvOPnGO1aF68ns3iwtMeNou+Fw+ZLRp6frNaXN41
        h83i7LzjbBYTVn1jsWj508JiceDDKkaLJ1MesVoc3RhssWjrF3aLWRd2sFq07j3CbjFvx1xG
        i97DtRa336xjtdh55wSzg5TH71+TGD0WbCr12LSqk83jzrU9bB5Prkxn8tg/dw27x+Yl9R59
        W1Yxehy/sZ3J4/MmuQCuKC6blNSczLLUIn27BK6M6b/aWAs+h1R8PzuZrYGxwaWLkZNDQsBE
        4tGT8yxdjFwcQgI7GCW6F85ghUhISny+uI4JwhaWWPnvOTtEUTOTxN2TbewgCTYBLYnGr13M
        IAkRgR4Widlb74BVMQssYZTYfHcPWxcjB4ewgIfE7TvWIA0sAqoSfTP+gE3lFbCS2Nuylg1i
        g7zE6g0HmEFsTgFriXWLb4PFhYBq1t34wz6BkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLS
        vHS95PzcTYzg6NLS2sG4Z9UHvUOMTByMhxglOJiVRHhFjlUmC/GmJFZWpRblxxeV5qQWH2KU
        5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBk/bMk+5TWjofd80JK3q07ekpzWsPflGWL
        OHb2K7cev/x037YLz69Vz5/xd6O3aogmd9CjmYVM69ZVmC68rex3QDfgjx//y5ksftvc3yy7
        nnU8c0X2WVnjH7cmtt3+EZvKWH7+1Pv2vlcPOM1mqu68cGSauPLzgnWhSxj9J7Hss2av/eSx
        4uqxW3vvNHyUudBeEq5cnLKsPfKEXKr07l+9ktd4T8UkRa9xnvHV/MtbydVT3HRvp80xqIw4
        qKfPc4cxS7vHQuloz37XNLHsbetyNH8xm7dXRE3VXl/q5n8o4q6hgPwUrkcR1xsCjnAxGMV8
        aEoJDz3woOKS8N/cO7sSu6VXLO2a4LYzIXbS/K9rlFiKMxINtZiLihMBVz4s0R0DAAA=
X-CMS-MailID: 20221121104741epcas5p31e1320bc4c0912485c1fabe52ea19988
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104741epcas5p31e1320bc4c0912485c1fabe52ea19988
References: <20221121105210.68596-1-shradha.t@samsung.com>
        <CGME20221121104741epcas5p31e1320bc4c0912485c1fabe52ea19988@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the support for PCIe controller driver and phy driver
for Tesla FSD. It includes support for both RC and EP.

Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  48 ++++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi |  65 ++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 171 +++++++++++++++++++++
 3 files changed, 284 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 1db6ddf03f01..cda72b0f76f8 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -41,3 +41,51 @@
 &ufs {
 	status = "okay";
 };
+
+&pcie_phy0 {
+	status = "disabled";
+};
+
+&pcie_phy1 {
+	status = "disabled";
+};
+
+&pcie4_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
+			<&pcie0_slot1>;
+	status = "disabled";
+};
+
+&pcie4_ep {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_clkreq>, <&pcie1_wake>, <&pcie1_preset>,
+			<&pcie0_slot1>;
+	status = "disabled";
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
+			 <&pcie0_slot0>;
+	status = "disabled";
+};
+
+&pcie0_ep {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake0>, <&pcie0_preset0>,
+			 <&pcie0_slot0>;
+	status = "disabled";
+};
+
+&pcie1_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
+	status = "disabled";
+};
+
+&pcie1_ep {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_clkreq>, <&pcie0_wake1>, <&pcie0_preset0>;
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index d0abb9aa0e9e..edae62dfa987 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -64,6 +64,27 @@
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
 	};
+
+	pcie1_clkreq: pcie1-clkreq {
+		samsung,pins = "gpf6-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie1_wake: pcie1-wake {
+		samsung,pins = "gpf6-1";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie1_preset: pcie1-preset {
+		samsung,pins = "gpf6-2";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_peric {
@@ -339,6 +360,50 @@
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
+
+	pcie0_clkreq: pcie0-clkreq {
+		samsung,pins = "gpc8-0";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_wake1: pcie0-wake1 {
+		samsung,pins = "gpc8-3";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_wake0: pcie0-wake0 {
+		samsung,pins = "gpc8-1";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_preset0: pcie0-preset0 {
+		samsung,pins = "gpc8-2";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	pcie0_slot0: pcie0-gpio22 {
+		samsung,pins = "gpg2-6";
+		samsung,pin-function = <FSD_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+		samsung,pin-val = <1>;
+	};
+
+	pcie0_slot1: pcie0-gpio23 {
+		samsung,pins = "gpg2-7";
+		samsung,pin-function = <FSD_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+		samsung,pin-val = <1>;
+	};
 };
 
 &pinctrl_pmu {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..2177f6964553 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -32,6 +32,14 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
+		pciephy0 = &pcie_phy0;
+		pciephy1 = &pcie_phy1;
+		pcierc0 = &pcie0_rc;
+		pcieep0 = &pcie0_ep;
+		pcierc1 = &pcie1_rc;
+		pcieep1 = &pcie1_ep;
+		pcierc2 = &pcie4_rc;
+		pcieep2 = &pcie4_ep;
 	};
 
 	cpus {
@@ -860,6 +868,169 @@
 			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
 			clock-names = "ref_clk";
 		};
+
+		pcie_phy0: pcie-phy@15080000 {
+			compatible = "tesla,fsd-pcie-phy";
+			#phy-cells = <0>;
+			reg = <0x0 0x15080000 0x0 0x2000>,
+			      <0x0 0x150A0000 0x0 0x1000>;
+			reg-names = "phy", "pcs";
+			samsung,pmureg-phandle = <&pmu_system_controller>;
+			tesla,pcie-sysreg = <&sysreg_fsys0>;
+			phy-mode = <0>;
+			status = "disabled";
+		};
+
+		pcie_phy1: pcie-phy@16880000 {
+			compatible = "tesla,fsd-pcie-phy";
+			#phy-cells = <0>;
+			reg = <0x0 0x16880000 0x0 0x2000>,
+			      <0x0 0x16860000 0x0 0x1000>;
+			reg-names = "phy", "pcs";
+			samsung,pmureg-phandle = <&pmu_system_controller>;
+			tesla,pcie-sysreg = <&sysreg_fsys1>;
+			phy-mode = <0>;
+			status = "disabled";
+		};
+
+		pcie4_rc: pcie@15400000 {
+			compatible = "tesla,fsd-pcie";
+			clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
+			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			dma-coherent;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "msi";
+			num-lanes = <4>;
+			reg = <0x0 0x15090000 0x0 0x1000>,
+			      <0x0 0x15400000 0x0 0x1000>,
+			      <0x0 0x15800000 0x0 0x1000>;
+			reg-names = "appl", "dbi", "config";
+			ranges =  <0x82000000 0 0x15801000 0 0x15801000 0 0xffefff>;
+			tesla,pcie-sysreg = <&sysreg_fsys0 0x434>;
+			phys = <&pcie_phy0>;
+			phy-names = "pcie_phy0";
+			iommu-map = <0x0 &smmu_fsys0 0x4 0x10000>;
+			iommu-map-mask = <0x0>;
+			status = "disabled";
+		};
+
+		pcie4_ep: pcie-ep@15400000 {
+			compatible = "tesla,fsd-pcie-ep";
+			clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
+				 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
+			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+			interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "sub_ctrl_intr";
+			reg = <0x0 0x15090000 0x0 0x1000>,
+			      <0x0 0x15400000 0x0 0x1000>,
+			      <0x0 0x15401000 0x0 0x80>,
+			      <0x0 0x15800000 0x0 0xFF0000>;
+			reg-names = "appl", "dbi", "dbi2", "addr_space";
+			num-lanes = <4>;
+			tesla,pcie-sysreg = <&sysreg_fsys0 0x434>;
+			phys = <&pcie_phy0>;
+			phy-names = "pcie_phy0";
+			status = "disabled";
+		};
+
+		pcie0_rc: pcie@16A00000 {
+			compatible = "tesla,fsd-pcie";
+			clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			dma-coherent;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "msi";
+			num-lanes = <4>;
+			reg = <0x0 0x168B0000 0x0 0x1000>,
+			      <0x0 0x16A00000 0x0 0x2000>,
+			      <0x0 0x17000000 0x0 0x1000>;
+			reg-names = "appl", "dbi", "config";
+			ranges =  <0x82000000 0 0x17001000 0 0x17001000 0 0xffefff>;
+			tesla,pcie-sysreg = <&sysreg_fsys1 0x50C>;
+			phys = <&pcie_phy1>;
+			phy-names = "pcie_phy1";
+			iommu-map = <0x0 &smmu_imem 0x0 0x10000>;
+			iommu-map-mask = <0x0>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@16A00000 {
+			compatible = "tesla,fsd-pcie-ep";
+			clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+			interrupts = <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "sub_ctrl_intr";
+			reg = <0x0 0x168B0000 0x0 0x1000>,
+			      <0x0 0x16A00000 0x0 0x1000>,
+			      <0x0 0x16A01000 0x0 0x80>,
+			      <0x0 0x17000000 0x0 0xFF0000>;
+			reg-names = "appl", "dbi", "dbi2", "addr_space";
+			num-lanes = <4>;
+			tesla,pcie-sysreg = <&sysreg_fsys1 0x50C>;
+			phys = <&pcie_phy1>;
+			phy-names = "pcie_phy1";
+			status = "disabled";
+		};
+
+		pcie1_rc: pcie-rc@16B00000 {
+			compatible = "tesla,fsd-pcie";
+			clocks = <&clock_fsys1 PCIE_LINK1_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			dma-coherent;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "msi";
+			num-lanes = <4>;
+			reg = <0x0 0x168C0000 0x0 0x1000>,
+			      <0x0 0x16B00000 0x0 0x1000>,
+			      <0x0 0x18000000 0x0 0x1000>;
+			reg-names = "appl", "dbi", "config";
+			ranges =  <0x82000000 0 0x18001000 0 0x18001000 0 0xffefff>;
+			tesla,pcie-sysreg = <&sysreg_fsys1 0x510>;
+			phys = <&pcie_phy1>;
+			phy-names = "pcie_phy1";
+			status = "disabled";
+		};
+
+		pcie1_ep: pcie-ep@16B00000 {
+			compatible = "tesla,fsd-pcie";
+			clocks = <&clock_fsys1 PCIE_LINK1_IPCLKPORT_AUX_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_DBI_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_MSTR_ACLK>,
+				 <&clock_fsys1 PCIE_LINK1_IPCLKPORT_SLV_ACLK>;
+			clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+			interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "intr";
+			reg = <0x0 0x168C0000 0x0 0x1000>,
+			      <0x0 0x16B00000 0x0 0x1000>,
+			      <0x0 0x16B01000 0x0 0x80>,
+			      <0x0 0x18000000 0x0 0xFF0000>;
+			reg-names = "appl", "dbi", "dbi2", "addr_space";
+			num-lanes = <4>;
+			tesla,pcie-sysreg = <&sysreg_fsys1 0x510>;
+			phys = <&pcie_phy1>;
+			phy-names = "pcie_phy1";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

