Return-Path: <linux-pci+bounces-28217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC81ABF65C
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7245F9E389C
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865E283CBA;
	Wed, 21 May 2025 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfvN81VD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9427F4D6;
	Wed, 21 May 2025 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834757; cv=none; b=QhN1FXa8Q/2ACBQt+ot42xl/Ed/HIF1Slnk6YIXFam/DzZ/54XH2kKzmTZ/RDVZRwkm9MGetSjAFw3rHQZeOVk6mh4ULD/KBg/amVTz3W9ZlUgoBv7NAdGXieLS3lKdtsdNgYR4VHJmxYJSUXfSqeLVNAsVTBSTi9q7FKCHjU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834757; c=relaxed/simple;
	bh=yw0++ZvqdhGvKxhN4dC4GrdXLS0x0UD4xzEIG7d+J6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMx252QavWSThwXkhzRREh3xOqamDoHbDiKPqWsAEAZPJ8a5dieRlv79DOmnOU+XKVV2DwYjuC1WS26kUeO28o2cs2U3mlZYGHNZBP1J0jNMIiA2W2j99KbKi9/KcBTpA6+FRAhiilf57frOMFnUYLmajl+4gQiYbLgI013bzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfvN81VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40144C4CEE4;
	Wed, 21 May 2025 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834757;
	bh=yw0++ZvqdhGvKxhN4dC4GrdXLS0x0UD4xzEIG7d+J6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tfvN81VDSr4qLDZCN52LBm3KSr4BmH3Mbx09kAM6U7xfx3al4ZLdCzDUePO4nFAn7
	 KWFPLejpeiJYc7rwGgD0Vdn3PYID6hZdaIfvdTRapieeAnqIeDKqT8BFx+VALSjUiU
	 QOUFO0rr8zDRub1V/L/1+69bxGay9gUB/rQp4Ryq6wO0MeWGcCO4fr0/deIH7EVS8k
	 /v+g+LSsJ4Dunee6meBe9ARSzAVpd9U0ESHPPi9L/L5wdPVkITNG0Fqv9Voxrsl5wz
	 xVH51EmahziCPJHrQqq+HvhWGq5ZzwncN3lEdACudCIJ8yJUUPdwOQ8NiOBtIjRdDS
	 BgNasw1Fqxsdw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 21 May 2025 15:38:13 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm8150: Drop unrelated clocks from
 PCIe hosts
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-topic-8150_pcie_drop_clocks-v1-4-3d42e84f6453@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747834731; l=1857;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=1YJXdyRsJC8YT6jcvtA/RpIY0NdcNSr2pcVtcnwaH/0=;
 b=35UOKkkgXeK86ySsxCfVwM/dKCMJO3XovYRumUxLdAA8Ybf30dwneG0LSLzjQxyzzEekaBsB8
 Vu2glshRo+LB5ANcTHBL3j93PC93UezWR0mjL+o5zaOEoabrenxtDMh
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
The ref clock is already being driven upstream through some of the
branches.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cdb47359c4c88af5c73956ba0ba1710ca312a9af..da3d86a17a4f61dc0d1318efeaaf43ac213835ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1874,17 +1874,13 @@ pcie0: pcie@1c00000 {
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
+				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
-				      "slave_q2a",
-				      "tbu",
-				      "ref";
+				      "slave_q2a";
 
 			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
 				    <0x100 &apps_smmu 0x1d81 0x1>;
@@ -1991,17 +1987,13 @@ pcie1: pcie@1c08000 {
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
 				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>;
 			clock-names = "pipe",
 				      "aux",
 				      "cfg",
 				      "bus_master",
 				      "bus_slave",
-				      "slave_q2a",
-				      "tbu",
-				      "ref";
+				      "slave_q2a";
 
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;

-- 
2.49.0


