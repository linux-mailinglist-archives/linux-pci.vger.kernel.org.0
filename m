Return-Path: <linux-pci+bounces-24740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A30A71221
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D8518989DE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2071A0BFD;
	Wed, 26 Mar 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+ChHUPM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9781A072C;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976664; cv=none; b=Wy95whGkgCsXP5kaZqxkAn4eOZ61gevWQ34CY881HMtSJwgLM807UVW7Ap7qDrClMvXCzqRPiMwgGkSTr9vAzMz6AY/zrtaiXriXRbPzeqfUQS0SPR7Nri7ESd8No0wACpR1zWnQN3mJikaw9itUVjgWQmQmuqg33cswrCrY3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976664; c=relaxed/simple;
	bh=Na7jEYdslPCYkUpJBoxusypjZQ5gijCuIbwMSR8fY50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YPZwb0FvDhXocIkFF7NMawCqIRotdaCFmBV5puxBja7kIhxpUOkOVzgj/KWsmCVRxRH7XOsbETnjTOnk5oRxO4X9TuH3wunn8f7MgQbVB/dM34t0ob8gP4UhwL4KcebDaIV9xav2TzIYtK54zm3chfB3epRVO4hJnIMB06VsTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+ChHUPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DC34C4CEE2;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976663;
	bh=Na7jEYdslPCYkUpJBoxusypjZQ5gijCuIbwMSR8fY50=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=e+ChHUPMS2pu2mACzAfjC6f/Uv1stEsb4AfVx3S/JUOs8met5PDPZeXQwJnLNCFXJ
	 Y7kIfPv6tuHDlHQoZ7rXKLs2odGKQ/D5BCGbk24JuvxDSg4tsu+R6NhP16e/f29Tjw
	 gcqv8G8nUtw6A1KJM8MXkWh6zWwiEqEflBwVLcvJfR4RRlEyOKkg/o+GoyTdNHajRY
	 Y3RfFSHROXZ6fC8lSmSzzX7suWIqHWZ8X9M051xlkUr38acDEACAFh/VXGDycLFajp
	 yrgKmGO2hiIj1WV/NYtur1l9GxmUCsXTF+AyVck9t7vPESL5HAEVjU47K0Sut0qcRc
	 4ShVzh9m5s+JQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB0C36008;
	Wed, 26 Mar 2025 08:11:03 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v7 0/6] Enable IPQ5018 PCI support
Date: Wed, 26 Mar 2025 12:10:54 +0400
Message-Id: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI6242cC/32Ry07DMBREf6XyGkd+xLFdIZSWwA4JwRIhdOMHt
 SCPOmkEqvrvOOmqArHzXPmM74yPaHAxuAGtV0cU3RSG0LVJyKsVMjto3x0ONmnECBOEM4pDvxe
 EKtyb4DC1eQ61J455gRLSR+fD12L38pr0LgxjF78X94nOU1Q9y8cnqh+2Sil+zwRXm42sSC7vK
 L+lhG11VTFWXlzLWmj6aKnO+tjZrDuMn133kZmuQfMrk1ic/15xEphgAMcMAPU5VeUvvPgPLxJ
 eS1sIDbJgRFzip3Po6PaHVN14To4aNwywVLdeXZ99qaSEEKYzpShTBaY4EeZtgggWyvkcWjN73
 sw91jA4nEQTxvQXVjoJwnMBhhPpc1EbXWvP05ClTMQW2hfGpG1OPzrYooPQAQAA
X-Change-ID: 20250321-ipq5018-pcie-1d44abf0e2f5
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
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, George Moussalem <george.moussalem@outlook.com>, 
 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742976660; l=5673;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Na7jEYdslPCYkUpJBoxusypjZQ5gijCuIbwMSR8fY50=;
 b=WzD26guUijM8mavL4SByuKdXHFbWjYgiLgxCy+41pdRnRQ5a+UewE/GEOaaqMAjPK+pc00K6R
 ILSJKaYYB0BDC4qvCIZ3x+OKiI/2z1y6u7wWiNni+mArE6BdGyCvoLD
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
Changes in v7:
- Updated commit log and added comment in dtsi to explain why 
  max-link-speed is set: IPQ5018 PCIe controllers supports gen3, yet the
  PHYs support gen2 only.
- Carried over Ack and RB-tags
- Added dependency with b4 prep on below series which adds the MHI
  register space (patch 1) which fixes issues reported by Rob's bot:
  Depends-on: <20250317100029.881286-1-quic_varada@quicinc.com>
- Link to v6: https://lore.kernel.org/r/20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com

Changes in v6:
- Fixed issues reported by 'make dt_bindings_check' as per Rob's bot
- Removed Krzysztof's Ack-tag on:
  dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018 compatible
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
 .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml |  49 +++-
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts     |  40 ++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 246 ++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c   |  45 ++++
 6 files changed, 421 insertions(+), 10 deletions(-)
---
base-commit: 7d7e7a5f35ac307f45bc9b9f37a52a1f0d69f6cc
change-id: 20250321-ipq5018-pcie-1d44abf0e2f5
prerequisite-message-id: <20250317100029.881286-1-quic_varada@quicinc.com>
prerequisite-patch-id: 210bd857b2a3ce208c6c66389d2845616dafae60
prerequisite-patch-id: 27a1070861e75cf1dcb03f1e440618bd77b32043
prerequisite-patch-id: 4dfad74bedd5e7b3b628ead0b23baed7de8b88f7
prerequisite-patch-id: 79ded164c537cfe947447c920602570626eddb3d

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



