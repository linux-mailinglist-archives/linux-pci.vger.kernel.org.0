Return-Path: <linux-pci+bounces-24330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812DA6BA64
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 13:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68C2188C545
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16822579E;
	Fri, 21 Mar 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo7LJsD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB91EA7D3;
	Fri, 21 Mar 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559286; cv=none; b=bYwhQOI8F7JZ4+wz0lNtACFCBvAGpB+3Avwp8RiCiIIgkNSuvD5wCkcMRXPxrv0aygF2TZZ64SEAWW1oGo7lqHsrWfK40hHMbnwuVemsmAHhlO0/dkWILLZ07siKf9cYezyfolszQPM6cyC5o+/HQLj4pCFu+toefqPI5VNvVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559286; c=relaxed/simple;
	bh=m1VPIuo5vZSZGVGPIyjDJGkECuuIKNQjt+mSRkRxpoQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uhH38QP0uUZsJY4NGI0zsmwfATShH4R9hFcmT3OUEsIExgUp/p711JIk0CWuwTLTK2BjhCfVG0WgI5xRJporVuS8CtuQWJHLLF4ljA7gYJb4fTb772n+tlz+703u/TG0TXKki2jjGZ3IXEditSnnzB1VOfrxbdArv1w7VpariIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo7LJsD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4653C4CEE3;
	Fri, 21 Mar 2025 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742559285;
	bh=m1VPIuo5vZSZGVGPIyjDJGkECuuIKNQjt+mSRkRxpoQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Fo7LJsD65aFXCdaMWiR9wJYJcNAQqRSEOTuFc5M7mDsESsGaj8KzuOIWrPLWZmrEd
	 8qqO1NMzwYxIh/ilmv78vLmFL6KHZtMTblNq2XvaGicKcnq7pB7U8i3q5i3iB2JunR
	 jMjq2QiKx4sboOlL2HZSCtFkthXCVoBBVjG0AM5HdFMInZHz+0bNk7F/+bT3SzJUFL
	 tYoUqlTtsmzKYpqZ+IYHlqjASn5kznabs6RVUoQBb5+UVCN3z8ND8tkOmnr5qlhQ9c
	 y2L6X25Rj9SxcVJBadXlS/v1SeilCqmN+ivienXZ6U4fafCi8ByUnRT5n7Blb0lKQu
	 6yRL2coZCMZ6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5CBC35FFF;
	Fri, 21 Mar 2025 12:14:45 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v6 0/6] Enable IPQ5018 PCI support
Date: Fri, 21 Mar 2025 16:14:38 +0400
Message-Id: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5Y3WcC/22OwQ6CMBBEf8X0bEl3oVI8AaI3E6NH46FCkUalt
 SjREP5d4Gbi8U123mxHGuW0ashy1hGnWt1oUw+wmM9IXsn6oqguBibIkDMfgWr74AwEtblWFIo
 gkOeSKSw5GSrWqVK/J93xNHClm6dxn8newpiS7BDu9hBtUyGEv0HuiyQJMxaEa/BXwDCNsgwx/
 jnzanm3roDIs84Unnk9b8ZcvdzcybjS8sn8/8WWU0alVJhLCWUAIv6p933/BTWaCY4EAQAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742559282; l=4765;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=m1VPIuo5vZSZGVGPIyjDJGkECuuIKNQjt+mSRkRxpoQ=;
 b=tFK4Yh9hIxkOVHYsz+sbGqZw75VR3chKQwuSFrMLNjiMt+SM8beXcxTOxA7Gi5lkZliFIIvJ6
 POKuhvr00yTAwodqbTjgnrtpDAnCpsnvwyPO66X67JzNXalJUjWsu/a
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

This patch series adds the relevant phy and controller
DT configurations for enabling PCI gen2 support
on IPQ5018. IPQ5018 has two phys and two controllers, 
one dual-lane and one single-lane.

Last patch series (v3) submitted dates back to August 30, 2024.
As I've worked to add IPQ5018 platform support in OpenWrt, I'm
continuing the efforts to add Linux kernel support.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Changes in v6:
- Fixed issues reported by 'make dt_bindings_check' as per Rob's bot
- Removed Krzysztof's Ack-tag on  
- Link to v5: https://lore.kernel.org/r/20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com

Changes in v5:
- Re-ordered reg and reg-names in dt-bindings and dts to align with
  other IPQ SoCs
- Corrected nr of interrupts in dt-bindings: phy: qcom: Add IPQ5018 SoC
- Corrected ranges property of pcie controller nodes
- Removed newlines between cells properties in pcie phy nodes
- Modified dt bindings to add descriptions and separate conditions for
  ipq5018 and ipq5332 as they have different nr of clocks and resets
  As such, also removed Krzysztof's RB tag for validation
- Ran dtbs_check and fixed:
  interrupt-map property in pcie nodes:
  /soc@0/pcie@80000000:interrupt-map: Cell 13 is not a phandle(0)
  /soc@0/pcie@a0000000:interrupt-map: Cell 13 is not a phandle(0)
- Added missing gpio header file to ipq5018-rdp432-c2.dts
- Added MHI register requirement to bindings and to PCIe nodes as per:
  Depends-on: <20250317100029.881286-2-quic_varada@quicinc.com>
- Link to v4: https://lore.kernel.org/all/DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v4:
- removed dependency as the following have been applied:
	dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
	phy: qcom: Introduce PCIe UNIPHY 28LP driver
	dt-bindings: PCI: qcom: Document the IPQ5332 PCIe controller
  Link: https://lore.kernel.org/all/20250313080600.1719505-1-quic_varada@quicinc.com/
- added Mani's RB tag to: PCI: qcom: Add support for IPQ5018
- Removed power-domains property requirement in dt-bindings for IPQ5018
  and removed Krzysztof's RB tag from:
  dt-bindings: PCI: qcom: Add IPQ5018 SoC
- fixed author chain and retained Sricharan Ramabadhran in SoB tags and
  kept Nitheesh Sekar as the original author
- Removed comments as per Konrad's comment in:
  arm64: dts: qcom: ipq5018: Add PCIe related nodes
- Link to v3 submitted by Sricharan Ramabadhran:
  Link: https://lore.kernel.org/all/20240830081132.4016860-1-quic_srichara@quicinc.com/
- Link to v3, incorrectly versioned:
  Link: https://lore.kernel.org/all/DS7PR19MB8883BC190797BECAA78EC50F9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com/

Changes in v3 (incorrectly versioned):
- Depends on
  Link: https://patchwork.kernel.org/project/linux-arm-msm/cover/20250220094251.230936-1-quic_varada@quicinc.com/
- Added 8 MSI SPI and 1 global interrupts (Thanks Mani for confirming)
- Added hw revision (internal/synopsys) and nr of lanes in patch 4
  commit msg
- Sorted reg addresses and moved PCIe nodes accordingly
- Moved to GIC based interrupts
- Added rootport node in controller nodes
- Tested on Linksys devices (MX5500/SPNMX56)
- Link to v2: https://lore.kernel.org/all/20240827045757.1101194-1-quic_srichara com/

Changes in v3:
 - Added Reviewed-by tag for patch#1.
 - Fixed dev_err_probe usage in patch#3.
 - Added pinctrl/wak pins for pcie1 in patch#6.

Changes in v2:
 - Fixed all review comments from Krzysztof, Robert Marko,
   Dmitry Baryshkov, Manivannan Sadhasivam, Konrad Dybcio.
 - Updated the respective patches for their changes.
 - Link to v1: https://lore.kernel.org/lkml/32389b66-48f3-8ee8-e2f1-1613feed3cc7@gmail.com/T/

---
Nitheesh Sekar (6):
      dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018 compatible
      phy: qualcomm: qcom-uniphy-pcie 28LP add support for IPQ5018
      dt-bindings: PCI: qcom: Add IPQ5018 SoC
      PCI: qcom: Add support for IPQ5018
      arm64: dts: qcom: ipq5018: Add PCIe related nodes
      arm64: dts: qcom: ipq5018: Enable PCIe

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  50 +++++
 .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml |  49 ++++-
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts     |  40 ++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 234 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c   |  45 ++++
 6 files changed, 409 insertions(+), 10 deletions(-)
---
base-commit: 5744a64fddfc33629f3bcc9a06a646f7443077a7
change-id: 20250321-ipq5018-pcie-1d44abf0e2f5

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



