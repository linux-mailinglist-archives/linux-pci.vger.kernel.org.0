Return-Path: <linux-pci+bounces-28216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F001ABF655
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4146750009C
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F74B283143;
	Wed, 21 May 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPcPjC76"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30627F4D6;
	Wed, 21 May 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834753; cv=none; b=sO7gy3Wzj9/7n5DM4MPeqVSR3ecZY8JAM9yeP8aENeW8AHXgRf1TEa1i8R00x4zmWViOxYRtQL+e6rmIvWwSVWGBLpVGnrQ+VxYd9koFG08QY8ibw624G3O4Vd1Liu0x2YWWR9ETLb2AjwwLZQdMw5lmrqihZuOdD50DFAmJF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834753; c=relaxed/simple;
	bh=QZ/N+a39LlXrtVzFcSeG+ClgaQogMsn7b0CzKFTeir8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/2Mh10dpblXdN4G3J8N0C2TZPeQee7gus9slqnCukp8TmWFWG9XgggTkwD0yTPnaxlqtiPxZRxrnw3a6AjD5ZemPdfCGXYQ4GcnYxo+/ahKANk/6uLaSMGLyuBzM8kiabbRZxP/vvxk+YE5cI1geY74Y6R8bJgRrwcj8h3UhvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPcPjC76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237BCC4CEE7;
	Wed, 21 May 2025 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834752;
	bh=QZ/N+a39LlXrtVzFcSeG+ClgaQogMsn7b0CzKFTeir8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iPcPjC76RCEOUDmGGWiII5dIVRhPBaVNQ9zTe4xOpzlQ/ui8MBGsPh63cglnOcnK+
	 KodF6o5kCtyna+ERglYo+ABXdliNi40+o5YxLvrzzZ2Q+HneEK/qcUBXxUwmu/VCNh
	 KE+wR0R2SXJ72EjF24zWiFmfgYyDifJXlaAa2Cd/adU6t5CGvrPVu5Lf0ZOAjKCynk
	 J+wddV+7tcMmbfkQ5PjMie0zgMvOl1u/3mBDIFVFGyVhqvpYojnDZk7TEBLk/iF4vN
	 9i+YIvdHrqw01VDX6MgETkEJMY9RYROEETVlVa/wSFdG9y52oIPwbG/1XbLBVV3KSm
	 7pwRT2rNxAGsA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 21 May 2025 15:38:12 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sc8180x: Drop unrelated clocks from
 PCIe hosts
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-topic-8150_pcie_drop_clocks-v1-3-3d42e84f6453@oss.qualcomm.com>
References: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
In-Reply-To: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, 
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747834731; l=3135;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=zxHMcimv+kU1WGBSo+lpDyaARP5YfF9wHCQPFVFx1OQ=;
 b=PJh1oDwjEBHc3YOxlXQw67vlhY97+jXIMDs0wve2/oGa65q3WoonslJya507FmX6FklnT1nbD
 WnHIVSty5laCR7TqaNeBSbrL0axTGiAfblhrwi4x60gvGHfgRu1dZRe
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
The ref clock is already being driven upstream through some of the
branches.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index b84e47a461a014871ef11e08d18af70bec8e2d63..fa8bd1ddfb39c3d46095f94a6c97fedb71db00ba 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -1747,17 +1747,13 @@ pcie0: pcie@1c00000 {
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
-				      "slave_q2a",
-				      "ref",
-				      "tbu";
+				      "slave_q2a";
 
 			assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
@@ -1868,17 +1864,13 @@ pcie3: pcie@1c08000 {
 				 <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_3_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_3_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_3_CLKREF_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_PCIE_3_SLV_Q2A_AXI_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
-				      "slave_q2a",
-				      "ref",
-				      "tbu";
+				      "slave_q2a";
 
 			assigned-clocks = <&gcc GCC_PCIE_3_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
@@ -1990,17 +1982,13 @@ pcie1: pcie@1c10000 {
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_1_CLKREF_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
-				      "slave_q2a",
-				      "ref",
-				      "tbu";
+				      "slave_q2a";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
@@ -2112,17 +2100,13 @@ pcie2: pcie@1c18000 {
 				 <&gcc GCC_PCIE_2_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_2_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_2_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_2_CLKREF_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+				 <&gcc GCC_PCIE_2_SLV_Q2A_AXI_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
-				      "slave_q2a",
-				      "ref",
-				      "tbu";
+				      "slave_q2a";
 
 			assigned-clocks = <&gcc GCC_PCIE_2_AUX_CLK>;
 			assigned-clock-rates = <19200000>;

-- 
2.49.0


