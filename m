Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14E50C38C
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiDVWTo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiDVWSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:18:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B224D355
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so16355654lfa.10
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHifQauKWsdjvPhwluuWcv37TSnwROO+30XpFG2Vym8=;
        b=quCy66FESme97bHixtZ5RNM1Fa9myc2DYys7DgjyfsVzWgKHeDcTp6r4wCLZrWWP5I
         +gG1HyFWCjfMPeqDXGKFfM7+ORyIdZlYo9fxa5U0ADSjfMAffuGCn4P6ux9dNUESVENV
         MfOgsL5HZ3THWrRAyVd3sS2DeIt3DAZhkEPOLLXmVuHzZ5aEmKS/gOperb3JBrmVGJ/9
         gRTr5hp87Fc0B+zuk80389OPV5op16nhGpg20jVRYheLtwGUvHr1MXHcVzfl3cbYXjgi
         H/aHc1IA+Q7wvx4JkiBG2DugNfm1nvHegZsDybdll9TEzRvQZMH0jsD0xbjM3UELivbk
         3HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHifQauKWsdjvPhwluuWcv37TSnwROO+30XpFG2Vym8=;
        b=sXjc6Mq1owqLuS1SNd8ZB3fhDfvA6Ju5YNzTpi+7Kv+Ss+FzIkfj+zGnm9rOwicN39
         uOZ+iSSwrAIQ9Tt3Q2BuAFIjBraxVYUXfLG2EjemJpPQpHXnHoY0uBZ2Yh+QfmHR1cNL
         pW5867eqZU5+NW8WjRGzKKPG5UCcrUTXA55xxhQfDl6kPaW46NPqlgJtwRoFqVgPVOmK
         iN4E53omP2bA+cldLIr3G+G9VfWD8yZ7ehDpnkWJMRfXS4WVugA8Yg6tU/s3zilAjUc8
         08DdrG7rdNwfzhY0fP7sGTDPwHWB7k4kwHhZJgWltB+jToefo3F6zXnR+cYlaZ7GYtDB
         ESlA==
X-Gm-Message-State: AOAM530npfu9vCYVgoUAgGylNusWZ19ZLhZVeasc5szC2fTkApM22D1g
        H530guCFv9aRUHI/4ifPEOuFh1n7eOKL8w==
X-Google-Smtp-Source: ABdhPJycV6mZ8LTG+fTceooIxMEQd0w2t/o7lwS56rxqWrldNPo2/nyD6eF1CkE4MJUwM0uODHkUhQ==
X-Received: by 2002:a05:6512:33cc:b0:471:a439:8397 with SMTP id d12-20020a05651233cc00b00471a4398397mr4171635lfg.551.1650661805470;
        Fri, 22 Apr 2022 14:10:05 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24d46000000b0046bb728b873sm351240lfp.252.2022.04.22.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:05 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: pci/qcom,pcie: convert to YAML
Date:   Sat, 23 Apr 2022 00:09:56 +0300
Message-Id: <20220422211002.2012070-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes to the schema:
 - Fixed the ordering of clock-names/reset-names according to
   the dtsi files.
 - Mark vdda-supply as required only for apq/ipq8064 (as it was marked
   as generally required in the txt file).

Changes to examples:
 - Inline clock and reset numbers rather than including dt-bindings
   files because of conflicts between the headers
 - Split ranges and reg properties to follow current practice
 - Change -gpio to -gpios
 - Update IRQ flags to LEVEL_HIGH rater than NONE
 - Removed extra "snps,dw-pcie" compatibility.

Note: while it was not clearly described in text schema, the majority of
Qualcomm platforms follow the snps,dw-pcie schema and use two
compatibility strings in the DT files: platform-specific one and a
fallback to the generic snps,dw-pcie one. However the platform itself is
not compatible with the snps,dw-pcie interface, so we are going to
remove it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 397 ------------
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 593 ++++++++++++++++++
 2 files changed, 593 insertions(+), 397 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
deleted file mode 100644
index 0adb56d5645e..000000000000
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ /dev/null
@@ -1,397 +0,0 @@
-* Qualcomm PCI express root complex
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Value should contain
-			- "qcom,pcie-ipq8064" for ipq8064
-			- "qcom,pcie-ipq8064-v2" for ipq8064 rev 2 or ipq8065
-			- "qcom,pcie-apq8064" for apq8064
-			- "qcom,pcie-apq8084" for apq8084
-			- "qcom,pcie-msm8996" for msm8996 or apq8096
-			- "qcom,pcie-ipq4019" for ipq4019
-			- "qcom,pcie-ipq8074" for ipq8074
-			- "qcom,pcie-qcs404" for qcs404
-			- "qcom,pcie-sc8180x" for sc8180x
-			- "qcom,pcie-sdm845" for sdm845
-			- "qcom,pcie-sm8250" for sm8250
-			- "qcom,pcie-sm8450-pcie0" for PCIe0 on sm8450
-			- "qcom,pcie-sm8450-pcie1" for PCIe1 on sm8450
-			- "qcom,pcie-ipq6018" for ipq6018
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: Register ranges as listed in the reg-names property
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Must include the following entries
-			- "parf"   Qualcomm specific registers
-			- "dbi"	   DesignWare PCIe registers
-			- "elbi"   External local bus interface registers
-			- "config" PCIe configuration space
-			- "atu"    ATU address space (optional)
-
-- device_type:
-	Usage: required
-	Value type: <string>
-	Definition: Should be "pci". As specified in snps,dw-pcie.yaml
-
-- #address-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 3. As specified in snps,dw-pcie.yaml
-
-- #size-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 2. As specified in snps,dw-pcie.yaml
-
-- ranges:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: As specified in snps,dw-pcie.yaml
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: MSI interrupt
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Should contain "msi"
-
-- #interrupt-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: Should be 1. As specified in snps,dw-pcie.yaml
-
-- interrupt-map-mask:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: As specified in snps,dw-pcie.yaml
-
-- interrupt-map:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: As specified in snps,dw-pcie.yaml
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: List of phandle and clock specifier pairs as listed
-		    in clock-names property
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	Configuration AHB clock
-
-- clock-names:
-	Usage: required for ipq/apq8064
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "core"	Clocks the pcie hw block
-			- "phy"		Clocks the pcie PHY block
-			- "aux" 	Clocks the pcie AUX block
-			- "ref" 	Clocks the pcie ref block
-- clock-names:
-	Usage: required for apq8084/ipq4019
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "aux"		Auxiliary (AUX) clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-
-- clock-names:
-	Usage: required for msm8996/apq8096
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pipe"	Pipe Clock driving internal logic
-			- "aux"		Auxiliary (AUX) clock
-			- "cfg"		Configuration clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-
-- clock-names:
-	Usage: required for ipq8074
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	PCIe to SysNOC BIU clock
-			- "axi_m"	AXI Master clock
-			- "axi_s"	AXI Slave clock
-			- "ahb"		AHB clock
-			- "aux"		Auxiliary clock
-
-- clock-names:
-	Usage: required for ipq6018
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	PCIe to SysNOC BIU clock
-			- "axi_m"	AXI Master clock
-			- "axi_s"	AXI Slave clock
-			- "axi_bridge"	AXI bridge clock
-			- "rchng"
-
-- clock-names:
-	Usage: required for qcs404
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "iface"	AHB clock
-			- "aux"		Auxiliary clock
-			- "master_bus"	AXI Master clock
-			- "slave_bus"	AXI Slave clock
-
-- clock-names:
-	Usage: required for sdm845
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "aux"		Auxiliary clock
-			- "cfg"		Configuration clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-			- "slave_q2a"	Slave Q2A clock
-			- "tbu"		PCIe TBU clock
-			- "pipe"	PIPE clock
-
-- clock-names:
-	Usage: required for sc8180x and sm8250
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "aux"		Auxiliary clock
-			- "cfg"		Configuration clock
-			- "bus_master"	Master AXI clock
-			- "bus_slave"	Slave AXI clock
-			- "slave_q2a"	Slave Q2A clock
-			- "tbu"		PCIe TBU clock
-			- "ddrss_sf_tbu" PCIe SF TBU clock
-			- "pipe"	PIPE clock
-
-- clock-names:
-	Usage: required for sm8450-pcie0 and sm8450-pcie1
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "aux"         Auxiliary clock
-			- "cfg"         Configuration clock
-			- "bus_master"  Master AXI clock
-			- "bus_slave"   Slave AXI clock
-			- "slave_q2a"   Slave Q2A clock
-			- "tbu"         PCIe TBU clock
-			- "ddrss_sf_tbu" PCIe SF TBU clock
-			- "pipe"        PIPE clock
-			- "pipe_mux"    PIPE MUX
-			- "phy_pipe"    PIPE output clock
-			- "ref"         REFERENCE clock
-			- "aggre0"	Aggre NoC PCIe0 AXI clock, only for sm8450-pcie0
-			- "aggre1"	Aggre NoC PCIe1 AXI clock
-
-- resets:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: List of phandle and reset specifier pairs as listed
-		    in reset-names property
-
-- reset-names:
-	Usage: required for ipq/apq8064
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "axi"  AXI reset
-			- "ahb"  AHB reset
-			- "por"  POR reset
-			- "pci"  PCI reset
-			- "phy"  PHY reset
-
-- reset-names:
-	Usage: required for apq8084
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "core" Core reset
-
-- reset-names:
-	Usage: required for ipq/apq8064
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "axi_m"		AXI master reset
-			- "axi_s"		AXI slave reset
-			- "pipe"		PIPE reset
-			- "axi_m_vmid"		VMID reset
-			- "axi_s_xpu"		XPU reset
-			- "parf"		PARF reset
-			- "phy"			PHY reset
-			- "axi_m_sticky"	AXI sticky reset
-			- "pipe_sticky"		PIPE sticky reset
-			- "pwr"			PWR reset
-			- "ahb"			AHB reset
-			- "phy_ahb"		PHY AHB reset
-			- "ext"			EXT reset
-
-- reset-names:
-	Usage: required for ipq8074
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pipe"		PIPE reset
-			- "sleep"		Sleep reset
-			- "sticky"		Core Sticky reset
-			- "axi_m"		AXI Master reset
-			- "axi_s"		AXI Slave reset
-			- "ahb"			AHB Reset
-			- "axi_m_sticky"	AXI Master Sticky reset
-
-- reset-names:
-	Usage: required for ipq6018
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pipe"		PIPE reset
-			- "sleep"		Sleep reset
-			- "sticky"		Core Sticky reset
-			- "axi_m"		AXI Master reset
-			- "axi_s"		AXI Slave reset
-			- "ahb"			AHB Reset
-			- "axi_m_sticky"	AXI Master Sticky reset
-			- "axi_s_sticky"	AXI Slave Sticky reset
-
-- reset-names:
-	Usage: required for qcs404
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "axi_m"		AXI Master reset
-			- "axi_s"		AXI Slave reset
-			- "axi_m_sticky"	AXI Master Sticky reset
-			- "pipe_sticky"		PIPE sticky reset
-			- "pwr"			PWR reset
-			- "ahb"			AHB reset
-
-- reset-names:
-	Usage: required for sc8180x, sdm845, sm8250 and sm8450
-	Value type: <stringlist>
-	Definition: Should contain the following entries
-			- "pci"			PCIe core reset
-
-- power-domains:
-	Usage: required for apq8084 and msm8996/apq8096
-	Value type: <prop-encoded-array>
-	Definition: A phandle and power domain specifier pair to the
-		    power domain which is responsible for collapsing
-		    and restoring power to the peripheral
-
-- vdda-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: A phandle to the core analog power supply
-
-- vdda_phy-supply:
-	Usage: required for ipq/apq8064
-	Value type: <phandle>
-	Definition: A phandle to the analog power supply for PHY
-
-- vdda_refclk-supply:
-	Usage: required for ipq/apq8064
-	Value type: <phandle>
-	Definition: A phandle to the analog power supply for IC which generates
-		    reference clock
-- vddpe-3v3-supply:
-	Usage: optional
-	Value type: <phandle>
-	Definition: A phandle to the PCIe endpoint power supply
-
-- phys:
-	Usage: required for apq8084 and qcs404
-	Value type: <phandle>
-	Definition: List of phandle(s) as listed in phy-names property
-
-- phy-names:
-	Usage: required for apq8084 and qcs404
-	Value type: <stringlist>
-	Definition: Should contain "pciephy"
-
-- <name>-gpios:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: List of phandle and GPIO specifier pairs. Should contain
-			- "perst-gpios"	PCIe endpoint reset signal line
-			- "wake-gpios"	PCIe endpoint wake signal line
-
-* Example for ipq/apq8064
-	pcie@1b500000 {
-		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
-		reg = <0x1b500000 0x1000
-		       0x1b502000 0x80
-		       0x1b600000 0x100
-		       0x0ff00000 0x100000>;
-		reg-names = "dbi", "elbi", "parf", "config";
-		device_type = "pci";
-		linux,pci-domain = <0>;
-		bus-range = <0x00 0xff>;
-		num-lanes = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
-			  0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
-		interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-				<0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-				<0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-		clocks = <&gcc PCIE_A_CLK>,
-			 <&gcc PCIE_H_CLK>,
-			 <&gcc PCIE_PHY_CLK>,
-			 <&gcc PCIE_AUX_CLK>,
-			 <&gcc PCIE_ALT_REF_CLK>;
-		clock-names = "core", "iface", "phy", "aux", "ref";
-		resets = <&gcc PCIE_ACLK_RESET>,
-			 <&gcc PCIE_HCLK_RESET>,
-			 <&gcc PCIE_POR_RESET>,
-			 <&gcc PCIE_PCI_RESET>,
-			 <&gcc PCIE_PHY_RESET>,
-			 <&gcc PCIE_EXT_RESET>;
-		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
-		pinctrl-0 = <&pcie_pins_default>;
-		pinctrl-names = "default";
-	};
-
-* Example for apq8084
-	pcie0@fc520000 {
-		compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
-		reg = <0xfc520000 0x2000>,
-		      <0xff000000 0x1000>,
-		      <0xff001000 0x1000>,
-		      <0xff002000 0x2000>;
-		reg-names = "parf", "dbi", "elbi", "config";
-		device_type = "pci";
-		linux,pci-domain = <0>;
-		bus-range = <0x00 0xff>;
-		num-lanes = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		ranges = <0x81000000 0 0          0xff200000 0 0x00100000   /* I/O */
-			  0x82000000 0 0x00300000 0xff300000 0 0x00d00000>; /* memory */
-		interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0x7>;
-		interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-				<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-				<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-				<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-		clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
-			 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
-			 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-			 <&gcc GCC_PCIE_0_AUX_CLK>;
-		clock-names = "iface", "master_bus", "slave_bus", "aux";
-		resets = <&gcc GCC_PCIE_0_BCR>;
-		reset-names = "core";
-		power-domains = <&gcc PCIE0_GDSC>;
-		vdda-supply = <&pma8084_l3>;
-		phys = <&pciephy0>;
-		phy-names = "pciephy";
-		perst-gpio = <&tlmm 70 GPIO_ACTIVE_LOW>;
-		pinctrl-0 = <&pcie0_pins_default>;
-		pinctrl-names = "default";
-	};
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
new file mode 100644
index 000000000000..071d7ef0e939
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -0,0 +1,593 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PCI express root complex
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Stanimir Varbanov <svarbanov@mm-sol.com>
+
+description: |
+  Qualcomm PCIe root complex controller is bansed on the Synopsys DesignWare
+  PCIe IP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq8064
+      - qcom,pcie-ipq8064-v2
+      - qcom,pcie-apq8064
+      - qcom,pcie-apq8084
+      - qcom,pcie-msm8996
+      - qcom,pcie-ipq4019
+      - qcom,pcie-ipq8074
+      - qcom,pcie-qcs404
+      - qcom,pcie-sc8180x
+      - qcom,pcie-sdm845
+      - qcom,pcie-sm8250
+      - qcom,pcie-sm8450-pcie0
+      - qcom,pcie-sm8450-pcie1
+      - qcom,pcie-ipq6018
+
+  reg:
+    minItems: 4
+    maxItems: 5
+
+  reg-names:
+    minItems: 4
+    maxItems: 5
+    items:
+      enum:
+        - parf # Qualcomm specific registers
+        - dbi # DesignWare PCIe registers
+        - elbi # External local bus interface registers
+        - config # PCIe configuration space
+        - atu # ATU address space (optional)
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: "msi"
+
+  # Common definitions for clocks, clock-names and reset.
+  # Platform constraints are described later.
+  clocks:
+    minItems: 3
+    maxItems: 12
+
+  clock-names:
+    minItems: 3
+    maxItems: 12
+
+  resets:
+    minItems: 1
+    maxItems: 12
+
+  resets-names:
+    minItems: 1
+    maxItems: 12
+
+  vdda-supply:
+    description: A phandle to the core analog power supply
+
+  vdda_phy-supply:
+    description: A phandle to the core analog power supply for PHY
+
+  vdda_refclk-supply:
+    description: A phandle to the core analog power supply for IC which generates reference clock
+
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: "pciephy"
+
+  power-domains:
+    maxItems: 1
+
+  perst-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO controlled connection to WAKE# signal
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+              - qcom,pcie-ipq8064
+              - qcom,pcie-ipq8064v2
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 5
+        clock-names:
+          minItems: 3
+          items:
+            - const: core # Clocks the pcie hw block
+            - const: iface # Configuration AHB clock
+            - const: phy # Clocks the pcie PHY block
+            - const: aux # Clocks the pcie AUX block, not on apq8064
+            - const: ref # Clocks the pcie ref block, not on apq8064
+        resets:
+          minItems: 5
+          maxItems: 6
+        reset-names:
+          minItems: 5
+          items:
+            - const: axi # AXI reset
+            - const: ahb # AHB reset
+            - const: por # POR reset
+            - const: pci # PCI reset
+            - const: phy # PHY reset
+            - const: ext # EXT reset, not on apq8064
+      required:
+        - vdda-supply
+        - vdda_phy-supply
+        - vdda_refclk-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8084
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: iface # Configuration AHB clock
+            - const: master_bus # Master AXI clock
+            - const: slave_bus # Slave AXI clock
+            - const: aux # Auxiliary (AUX) clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: core # Core reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq4019
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: aux # Auxiliary (AUX) clock
+            - const: master_bus # Master AXI clock
+            - const: slave_bus # Slave AXI clock
+        resets:
+          minItems: 12
+          maxItems: 12
+        reset-names:
+          items:
+            - const: axi_m # AXI master reset
+            - const: axi_s # AXI slave reset
+            - const: pipe # PIPE reset
+            - const: axi_m_vmid # VMID reset
+            - const: axi_s_xpu # XPU reset
+            - const: parf # PARF reset
+            - const: phy # PHY reset
+            - const: axi_m_sticky # AXI sticky reset
+            - const: pipe_sticky # PIPE sticky reset
+            - const: pwr # PWR reset
+            - const: ahb # AHB reset
+            - const: phy_ahb # PHY AHB reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-msm8996
+    then:
+      oneOf:
+        - properties:
+            clock-names:
+              items:
+                - const: pipe # Pipe Clock driving internal logic
+                - const: aux # Auxiliary (AUX) clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+        - properties:
+            clock-names:
+              items:
+                - const: pipe # Pipe Clock driving internal logic
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: cfg # Configuration clock
+                - const: aux # Auxiliary (AUX) clock
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        resets: false
+        reset-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq8074
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          items:
+            - const: iface # PCIe to SysNOC BIU clock
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: ahb # AHB clock
+            - const: aux # Auxiliary clock
+        resets:
+          minItems: 7
+          maxItems: 7
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sleep # Sleep reset
+            - const: sticky # Core Sticky reset
+            - const: axi_m # AXI Master reset
+            - const: axi_s # AXI Slave reset
+            - const: ahb # AHB Reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq6018
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          items:
+            - const: iface # PCIe to SysNOC BIU clock
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: axi_bridge # AXI bridge clock
+            - const: rchng
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sleep # Sleep reset
+            - const: sticky # Core Sticky reset
+            - const: axi_m # AXI Master reset
+            - const: axi_s # AXI Slave reset
+            - const: ahb # AHB Reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+            - const: axi_s_sticky # AXI Slave Sticky reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-qcs404
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: iface # AHB clock
+            - const: aux # Auxiliary clock
+            - const: master_bus # AXI Master clock
+            - const: slave_bus # AXI Slave clock
+        resets:
+          minItems: 6
+          maxItems: 6
+        reset-names:
+          items:
+            - const: axi_m # AXI Master reset
+            - const: axi_s # AXI Slave reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+            - const: pipe_sticky # PIPE sticky reset
+            - const: pwr # PWR reset
+            - const: ahb # AHB reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sdm845
+    then:
+      oneOf:
+          # Unfortunately the "optional" ref clock is used in the middle of the list
+        - properties:
+            clocks:
+              minItems: 8
+              maxItems: 8
+            clock-names:
+              items:
+                - const: pipe # PIPE clock
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: ref # REFERENCE clock
+                - const: tbu # PCIe TBU clock
+        - properties:
+            clocks:
+              minItems: 7
+              maxItems: 7
+            clock-names:
+              items:
+                - const: pipe # PIPE clock
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: tbu # PCIe TBU clock
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+              - qcom,pcie-sm8250
+    then:
+      oneOf:
+          # Unfortunately the "optional" ref clock is used in the middle of the list
+        - properties:
+            clocks:
+              minItems: 9
+              maxItems: 9
+            clock-names:
+              items:
+                - const: pipe # PIPE clock
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: ref # REFERENCE clock
+                - const: tbu # PCIe TBU clock
+                - const: ddrss_sf_tbu # PCIe SF TBU clock
+        - properties:
+            clocks:
+              minItems: 8
+              maxItems: 8
+            clock-names:
+              items:
+                - const: pipe # PIPE clock
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: tbu # PCIe TBU clock
+                - const: ddrss_sf_tbu # PCIe SF TBU clock
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8450-pcie0
+    then:
+      properties:
+        clocks:
+          minItems: 12
+          maxItems: 12
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre0 # Aggre NoC PCIe0 AXI clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8450-pcie1
+    then:
+      properties:
+        clocks:
+          minItems: 11
+          maxItems: 11
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,pcie-apq8064
+                - qcom,pcie-ipq4019
+                - qcom,pcie-ipq8064
+                - qcom,pcie-ipq8064v2
+                - qcom,pcie-ipq8074
+                - qcom,pcie-qcs404
+    then:
+      required:
+        - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie@1b500000 {
+      compatible = "qcom,pcie-ipq8064";
+      reg = <0x1b500000 0x1000>,
+            <0x1b502000 0x80>,
+            <0x1b600000 0x100>,
+            <0x0ff00000 0x100000>;
+      reg-names = "dbi", "elbi", "parf", "config";
+      device_type = "pci";
+      linux,pci-domain = <0>;
+      bus-range = <0x00 0xff>;
+      num-lanes = <1>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000>,
+               <0x82000000 0 0 0x08000000 0 0x07e00000>;
+      interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "msi";
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0x7>;
+      interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&gcc 41>,
+               <&gcc 43>,
+               <&gcc 44>,
+               <&gcc 42>,
+               <&gcc 248>;
+      clock-names = "core", "iface", "phy", "aux", "ref";
+      resets = <&gcc 27>,
+               <&gcc 26>,
+               <&gcc 25>,
+               <&gcc 24>,
+               <&gcc 23>,
+               <&gcc 22>;
+      reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
+      pinctrl-0 = <&pcie_pins_default>;
+      pinctrl-names = "default";
+      vdda-supply = <&pm8921_s3>;
+      vdda_phy-supply = <&pm8921_lvs6>;
+      vdda_refclk-supply = <&ext_3p3v>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pcie@fc520000 {
+      compatible = "qcom,pcie-apq8084";
+      reg = <0xfc520000 0x2000>,
+            <0xff000000 0x1000>,
+            <0xff001000 0x1000>,
+            <0xff002000 0x2000>;
+      reg-names = "parf", "dbi", "elbi", "config";
+      device_type = "pci";
+      linux,pci-domain = <0>;
+      bus-range = <0x00 0xff>;
+      num-lanes = <1>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>,
+               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>;
+      interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "msi";
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0x7>;
+      interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&gcc 324>,
+               <&gcc 325>,
+               <&gcc 327>,
+               <&gcc 323>;
+      clock-names = "iface", "master_bus", "slave_bus", "aux";
+      resets = <&gcc 81>;
+      reset-names = "core";
+      power-domains = <&gcc 1>;
+      vdda-supply = <&pma8084_l3>;
+      phys = <&pciephy0>;
+      phy-names = "pciephy";
+      perst-gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
+      pinctrl-0 = <&pcie0_pins_default>;
+      pinctrl-names = "default";
+    };
+...
-- 
2.35.1

