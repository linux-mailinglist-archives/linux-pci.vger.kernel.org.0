Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86600308A40
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 17:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhA2Qcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 11:32:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhA2Qbo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 11:31:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0720064DFD;
        Fri, 29 Jan 2021 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611937864;
        bh=+AbPZ5Xsf8cGzLmX/c37ZvPUD+eQokRI5BEG0yFXASY=;
        h=Date:From:To:Cc:Subject:From;
        b=F5cDj5bXQeuvxAFU300wYllglP/fz6K3HKMGjnMKjjf+5tyobigvAK4SMOkHKO7Vy
         WrMBletmjKv0C/wT9lCtpKOUuq9R4nMIGlArN3Ban4dUHDKqqjNUaqczg5RPbjUVAi
         boMDGpN9Te6wKfyxgq3+btNmAAETNc3JyKyr668Bp3qa3Dtc15D4z1Oo1JqXdMG4Br
         lJv37QpLjoin7cF5PVcqYQ5tjrsiZBseb8J10ZXQdOupMLoJbQ0cV5UlhsglcPbjvV
         LyFU8+4JM74K4cpEwUzZ12853V5ylzl1EhwU1azjByO7kj6PAJDrkbF/5WvagcpQ1h
         ZNuA2JHfkq6Vg==
Date:   Fri, 29 Jan 2021 17:30:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Enabling PCIe support on Hikey 970
Message-ID: <20210129173057.30288c9d@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn/Rob,

I've been trying to make a Hikey 970 board to work properly upstream.

This specific hardware is similar to a previous model (Hikey 960),
and it uses the same PCIe driver, with a few additions
(drivers/pci/controller/dwc/pcie-kirin.c).

The major difference between those two models is that, on Hikey 960,
the PCIe is mapped as [1]:

	+---------+      +--------+
	|Kirin 960|----> |PCIe M.2|
	|  SoC    |	 |        |
	+---------+      +--------+

While, on Hikey 970, the connection is more complex[2]:

	+---------+	 +--------+
	|         |	 |        |     +--------+
	|         |	 |        |---->|PCIe M.2|-->M.2 slot
	|         |	 |        |     +--------+
	|         |	 |        |
	|         |	 |        |     +--------+
	|Kirin 970|----> |Switch  |---->|Mini 1x |-->mini PCIe slot
	|         |	 |PEX 8606|     +--------+
	|  SoC    |	 |        |
	|         |	 |        |     +-------+
	|         |	 |        |---->|RTL8169|---> Ethernet
	|         |	 |        |     +-------+
	+---------+	 +--------+



[1] see https://www.96boards.org/documentation/consumer/hikey/hikey960/hardware-docs/hardware-user-manual.md.html
[2] see https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf

When the driver is properly loaded, this is what can be seen there:

	$ lspci
	00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
	01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
	02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
	02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
	02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
	02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
	02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
	06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)

(without anything connected to M.2 or mini 1x slots)

All devices after the SoC require a regulator line to be
enabled (LDO33). Starting the PCIe bus before turning them on
causes PCIe probe to fail.

There are also separate PERST lines for the switch (Broadcom PEX 8606), 
PCIe M.2, Mini 1x and for the Ethernet hardware (RTL 8169).

To make it a little more fun, the M.2, the Mini 1x and the
RTL 8169 also requires a clockreq in order to work.

Both the 4 PERST reset lines and the 3 CLOCKREQ lines are initialized
during the PCIe power on logic, at probing time.

I'm currently thinking about the best way to report this via
device tree.

It sounds to me that the best would be to add those 4 data at the DTS file:

	reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
		      <&gpio3 1 0 >, <&gpio27 4 0 >;
	reset-names = "pcie_switch_reset", "pcie_eth_reset",
		      "pcie_m_2_reset",    "pcie_mini1_reset";
	clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
		       <&gpio17 0 0 >;
	clkreq-names = "pcie_eth_clkreq", "pcie_m_2_clkreq",
		       "pcie_mini1_clkreq";

E. g. the complete representation for the PCIe controller will
be:

	soc {
		compatible = "simple-bus";
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;
...
		pcie@f4000000 {
			compatible = "hisilicon,kirin970-pcie";
			reg = <0x0 0xf4000000 0x0 0x1000000>,
			      <0x0 0xfc180000 0x0 0x1000>,
			      <0x0 0xfc000000 0x0 0x80000>,
			      <0x0 0xf5000000 0x0 0x2000>;
			pci-supply = <&ldo33>;
			reg-names = "dbi", "apb", "phy", "config";
			bus-range = <0x0  0x1>;
			msi-parent = <&its_pcie>;
			#address-cells = <3>;
			#size-cells = <2>;
			device_type = "pci";
			ranges = <0x02000000 0x0 0x00000000
				  0x0 0xf6000000
				  0x0 0x02000000>;
			num-lanes = <1>;
			#interrupt-cells = <1>;
			interrupts = <0 283 4>;
			interrupt-names = "msi";
			interrupt-map-mask = <0 0 0 7>;
			interrupt-map = <0x0 0 0 1
					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
					<0x0 0 0 2
					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
					<0x0 0 0 3
					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
					<0x0 0 0 4
					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
				 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
				 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
				 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;

			clock-names = "pcie_phy_ref", "pcie_aux",
				      "pcie_apb_phy", "pcie_apb_sys",
				      "pcie_aclk";
			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
				      <&gpio3 1 0 >, <&gpio27 4 0 >;

			reset-names = "pcie_switch_reset", "pcie_eth_reset",
				      "pcie_m_2_reset",    "pcie_mini1_reset";

			clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
				       <&gpio17 0 0 >;

			clkreq-names = "pcie_eth_clkreq", "pcie_m_2_clkreq",
				       "pcie_mini1_clkreq";

			/* vboost iboost pre post main */
			eye_param = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;

			pinctrl-names = "default";
			pinctrl-0 = <&pcie_clkreq_pmx_func &pcie_clkreq_cfg_func>;
		};
	};

Would this be ok?

---

FYI, the current driver is on this branch:

	https://github.com/mchehab/linux/tree/staging/hikey970-pcie-v2

The DTS file is at:

	https://github.com/mchehab/linux/blob/staging/hikey970-pcie-v2/arch/arm64/boot/dts/hisilicon/hi3670.dtsi

The DT bindings at:
	https://github.com/mchehab/linux/blob/staging/hikey970-pcie-v2/Documentation/devicetree/bindings/pci/hisilicon%2Ckirin-pcie.yaml

And the driver, modified to support Hikey 970, at:
	https://github.com/mchehab/linux/blob/staging/hikey970-pcie-v2/drivers/pci/controller/dwc/pcie-kirin.c

Thanks,
Mauro
