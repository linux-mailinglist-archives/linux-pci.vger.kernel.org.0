Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1250B66F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447171AbiDVLvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447162AbiDVLvl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:51:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FC956418
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y32so13841774lfa.6
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXnnqOlSzQ0HjodXPK9O2bvU/fuNTn2+NAB6Gr+Thbk=;
        b=Sl8HSBKi56M892wgAhtAl94HK6OnDgD4tHYYm7sE24uFpC5x28BHghYg9N2t+X2BAg
         TZI7CWWCKYH7neQG/OhEIf3ha1Zf/evzFCX2Rn2Om5K5MYfGKBmIcpTOWnQyKfKT+2tI
         4jBzv++d+BUxc3fJ1AfphWMJA0a0XzE9tTf4MLReGYnD55E4/+f8R1ozEz7HeoBNT1j8
         eKMPJjLbZG6VUzSMu9u5UfK0DmfNlELggQYwkq862IqgECqcIft4tKkcu44W0T7mXdi+
         ENw3mQ55FYUwj8HcFr/s0KnHdDPK5hNgqf2DHmS1ClhXrdLX6udd3NeljtJn8ylY9Skj
         JzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXnnqOlSzQ0HjodXPK9O2bvU/fuNTn2+NAB6Gr+Thbk=;
        b=fG1TWpV8VgWYEzMJt2PA9Cqf0UBm5EhVr/WLP2ZzgFtELlbi6SlKzaGCexlDcWdl3e
         9jQUM6RIoS3eCsdH2nLs2IA5x6LcxYVBNTsE4fqnwfeGr4mFCs7zDpqDmN89HMf3qaxA
         d+iIiK7YWQeQswH+0Oat0xMRqSM/9B33N08PPWKN13fhFzcz3e9/0g/laUD76GXMnyu1
         PQZL0RIyoPo4T/51F8xD50Nveh+NhuZRHNHzUgPAvWrxYDXtqDxQdvRDjwaA63V65L29
         ey7cruVmYkTuojPQFdNea2qRCwfQSKzIokp/FX0M8k71vJ5h7uTOWzjpZCtRzBL4B2/F
         HHAw==
X-Gm-Message-State: AOAM532X9VfklsvvBCEs0r9g5RazWXuPxSKdiM305PBWcKUBmHcC8Wzk
        9G87y3z1Id/xUCyXbQKxTLfMWA==
X-Google-Smtp-Source: ABdhPJxgnV41vPReEm+XfVo+e6lKauD1Vj1sosZpOGKq+jZim3XZJ24pC1P9ZWjuWCA76mebfN2snA==
X-Received: by 2002:a05:6512:3243:b0:445:79a1:b589 with SMTP id c3-20020a056512324300b0044579a1b589mr2797906lfr.191.1650628124776;
        Fri, 22 Apr 2022 04:48:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.65.189])
        by smtp.gmail.com with ESMTPSA id h7-20020a19ca47000000b0047014ca10f2sm200695lfj.8.2022.04.22.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:48:44 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: pci/qcom,pcie: convert to YAML
Date:   Fri, 22 Apr 2022 14:48:36 +0300
Message-Id: <20220422114841.1854138-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
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

Changes to examples:
 - Inline clock and reset numbers rather than including dt-bindings
   files because of conflicts between the headers
 - Split ranges properties to follow current practice

Changes to the schema:
 - Fixed the ordering of clock-names/reset-names according to
   the dtsi files.
 - Mark vdda-supply as required only for apq/ipq8064 (as it was marked
   as generally required in the txt file).

Note: while it was not clearly described in text schema, the majority of
Qualcomm platforms follow the snps,dw-pcie schema and use two
compatibility strings in the DT files: platform-specific one and a
fallback to the generic snps,dw-pcie one. This will be sorted out in the
next patches.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 397 ------------
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 607 ++++++++++++++++++
 2 files changed, 607 insertions(+), 397 deletions(-)
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
index 000000000000..89a1021df9bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -0,0 +1,607 @@
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
+    items:
+      - enum:
+          - qcom,pcie-ipq8064
+          - qcom,pcie-ipq8064-v2
+          - qcom,pcie-apq8064
+          - qcom,pcie-apq8084
+          - qcom,pcie-msm8996
+          - qcom,pcie-ipq4019
+          - qcom,pcie-ipq8074
+          - qcom,pcie-qcs404
+          - qcom,pcie-sc8180x
+          - qcom,pcie-sdm845
+          - qcom,pcie-sm8250
+          - qcom,pcie-sm8450-pcie0
+          - qcom,pcie-sm8450-pcie1
+          - qcom,pcie-ipq6018
+      - const: snps,dw-pcie
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
+  clocks: true
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
+  perst-gpio:
+    description: GPIO pin number of PERST# signal
+    maxItems: 1
+    deprecated: true
+
+  perst-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  wake-gpio:
+    description: GPIO pin number of WAKE# signal
+    maxItems: 1
+    deprecated: true
+
+  wake-gpios:
+    description: GPIO controlled connection to WAKE# signal
+    maxItems: 1
+
+  iommu-map: true
+  iommu-map-mask: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: core # Clocks the pcie hw block
+            - const: iface # Configuration AHB clock
+            - const: phy # Clocks the pcie PHY block
+        resets:
+          minItems: 5
+          maxItems: 5
+        reset-names:
+          items:
+            - const: axi # AXI reset
+            - const: ahb # AHB reset
+            - const: por # POR reset
+            - const: pci # PCI reset
+            - const: phy # PHY reset
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq8064
+              - qcom,pcie-ipq8064v2
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          items:
+            - const: core # Clocks the pcie hw block
+            - const: iface # Configuration AHB clock
+            - const: phy # Clocks the pcie PHY block
+            - const: aux # Clocks the pcie AUX block
+            - const: ref # Clocks the pcie ref block
+        resets:
+          minItems: 6
+          maxItems: 6
+        reset-names:
+          items:
+            - const: axi # AXI reset
+            - const: ahb # AHB reset
+            - const: por # POR reset
+            - const: pci # PCI reset
+            - const: phy # PHY reset
+            - const: ext # EXT reset
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+              - qcom,pcie-ipq8064
+              - qcom,pcie-ipq8064v2
+    then:
+      required:
+        - vdda-supply
+        - vdda_phy-supply
+        - vdda_refclk-supply
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
+      properties:
+        power-domains:
+          minItems: 1
+          maxItems: 1
+      required:
+        - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie@1b500000 {
+      compatible = "qcom,pcie-ipq8064", "snps,dw-pcie";
+      reg = <0x1b500000 0x1000
+             0x1b502000 0x80
+             0x1b600000 0x100
+             0x0ff00000 0x100000>;
+      reg-names = "dbi", "elbi", "parf", "config";
+      device_type = "pci";
+      linux,pci-domain = <0>;
+      bus-range = <0x00 0xff>;
+      num-lanes = <1>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000>, 
+               <0x82000000 0 0 0x08000000 0 0x07e00000>; 
+      interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
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
+      compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
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
+      interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;
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
+      perst-gpio = <&tlmm 70 GPIO_ACTIVE_LOW>;
+      pinctrl-0 = <&pcie0_pins_default>;
+      pinctrl-names = "default";
+    };
+...
-- 
2.35.1

