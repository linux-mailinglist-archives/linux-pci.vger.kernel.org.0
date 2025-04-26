Return-Path: <linux-pci+bounces-26800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD39A9D971
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3541192034C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDF2367A1;
	Sat, 26 Apr 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcVTfC4m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4161ABEA5;
	Sat, 26 Apr 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745657271; cv=none; b=WxRKYo0UdEN3llI0drepQzXgOQIb/T41fZf0obORo7CRwMSPuvCzrJtD6xItsQjm0E0beQ9UKn8HUlfQ5+xHU0rG5bJDjsRh/Na/K291r5PysvdGhPSQ2GgnCAo2/EnQB4s2UjYL7r0kUkAJFKRwuGjNbg39ZcFeGn1WDy9Mm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745657271; c=relaxed/simple;
	bh=W3kdljkEATM/b+BdHb7MSH+5/TdP6vHCRrAkWB2n8bg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k9ez20vSzBZz8JDczhjHuRi5wMjWdETDglKE5iuOrN97IQFrWeuoYQNyFH8iM3OGZU5lHP+w/Glu3nDeB4aRZLPu19t59UZCmymFH4uUUzzofKvo+OvTZu/vt1/pvlGFUS7FLIyucA7qI97QeK3JG//PWjh2D0L+F8LD62x2Z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcVTfC4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0E26C4CEE2;
	Sat, 26 Apr 2025 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745657271;
	bh=W3kdljkEATM/b+BdHb7MSH+5/TdP6vHCRrAkWB2n8bg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YcVTfC4miFbq/2YK/efe1BEQGuX8oK/ZnrHam6NxMrOUgOUi4NbAkjaLp0lGX1YOo
	 HBR4KFvkRL6HHKYTrSg7NqFNoTgv/ZCDvDbbDVaEn8qLGBYO7PboFQtJTn7Cc7//bn
	 WnIgQVG5HPHkuSFK/z/jubNDbQFNAPiEOWxiVjpbrVaOI0VfCvMDKGiKfD7edVaqBn
	 2FMIh7yM6/hL4V/Lpv5ql/XQO+4wh9GnRVeIJ2ADYj3WI7yneGgFRftM7TtLqTlKkc
	 W8YwIYIm7taI81QwJQVXPeaEcHtXgd56bsvJAdkQnYDuZCHshnC6hnGohAjbgjzhrb
	 HPjdKWz2YE2mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F3C369CB;
	Sat, 26 Apr 2025 08:47:50 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v9 0/2] Enable IPQ5018 PCI support
Date: Sat, 26 Apr 2025 12:47:19 +0400
Message-Id: <20250426-ipq5018-pcie-v9-0-1f0dca6c205b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJedDGgC/33RW0vDMBQH8K9S8mxKLs1tiGyz+iaIPopImosL2
 svSrijD727aPeg28S3/kN/J4Zw96F0MrgeLbA+iG0Mf2iYFdZEBs9HNq4PBpgwIIgxRgmHotgx
 hCTsTHMS2KHTlkSOegUS66Hz4mMs9Pae8Cf3Qxs+5+oinW1A+ivsHrO7WUkp6SxiVq5UoUSFuM
 L3GiKxVWRKyPHqWN7ruosUq72Jr83Y3vLftW27aGky/jGyu/HeLI4MIau2I0Rr7AsvlGef/cZ5
 4JSxnSgtOEDvn4jfnJ1wk7rAk0juPuFHnXP7wgrATLhNH1DnBjBDcmmP+dRh5dNtdWtxwmDuoX
 d/reXGL7PLQFhYYIURULiUmkkMMkzAvo47a6uV0Do2Zal5NW6x072AKdRgWmbDCCc08ZdpQJHz
 BKqMq5Wm6JGmiyHLluTGpm69vvChix04CAAA=
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
 Sricharan R <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745657268; l=5859;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=W3kdljkEATM/b+BdHb7MSH+5/TdP6vHCRrAkWB2n8bg=;
 b=YLj6RgPHWXLLdtMHlVgsjMe7uXb7X2lwA19bwDyZc4DUP0YkRy1K8IH5gTaIlObwohSttLVHf
 yC0eN+7bibEBVtVYXoqrIsiKxB72ttqllUDZbj/ApXSHYShYmEi2+JB
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

Last patch series (v3) submitted by qcom dates back to August 30, 2024.
As I've worked to add IPQ5018 platform support in OpenWrt, I'm
continuing the efforts to add Linux kernel support.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Changes in v9:
- Added whitespace between pcie phy nodes and curly brackets
- Shortened comment in dtsi to fit on 1 line as per Konrad's suggestion
- Link to v8: https://lore.kernel.org/r/20250425-ipq5018-pcie-v8-0-03ee75c776dc@outlook.com

Changes in v8:
- Updated comment in dtsi to remove superfluous reference to ipq5018 as
  pointed out by Mani
- Corrected the size of the 2-lane phy's memory-mapped region as it
  should be 0x1000 (0x800 per lane).
- Matched PCI domain to pcie controller instance (pcie0 -> PCI domain 0
  and pcie1 to PCI domain 1)
- Link to v7: https://lore.kernel.org/r/20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com

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
- Link to v4: https://lore.kernel.org/r/DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com

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
Nitheesh Sekar (2):
      arm64: dts: qcom: ipq5018: Add PCIe related nodes
      arm64: dts: qcom: ipq5018: Enable PCIe

 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  40 +++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi          | 238 ++++++++++++++++++++++++-
 2 files changed, 276 insertions(+), 2 deletions(-)
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



