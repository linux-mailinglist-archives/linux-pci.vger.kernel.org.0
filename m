Return-Path: <linux-pci+bounces-28215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7430ABF652
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AC71BA7AE8
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD027E7F4;
	Wed, 21 May 2025 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck8hXaxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E827D763;
	Wed, 21 May 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834748; cv=none; b=HtSm2XBP9H22xU2+WoHFxkNesZQpTOU0uSaBxei77cQd0Pxr6vr5xASmo2UOG//Pm2pj6p8MjQ1OLupJKeK56fCOXMWFxYbamDKU5kvD/GVNDK+xHNnST39EZbkAvK8lX78r6UzsGR7e9gLfW1J9kSwH2UvDMXM3vp0uGE0MmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834748; c=relaxed/simple;
	bh=higOUmwE/JWWFF1zmcM7ckjtomNy5EXZlVjC90Xww/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4YhqmxzDTFcES537bhnpCL4F6Q3WQpaPUokOEgBRKiQb4/7CknI/egrjvPtRzIYeI1Uk5tUiJ/+nxbAFZnBaZZ+ljRxE/ixIi8l+0eNKZZs46zXdqkd4C4qKfW6nIw5WRm7/SGtgMC2U4czncWmKPp5g2DSdwcYmw6YTVGLy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck8hXaxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D02DC4CEE4;
	Wed, 21 May 2025 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834747;
	bh=higOUmwE/JWWFF1zmcM7ckjtomNy5EXZlVjC90Xww/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ck8hXaxZ8G/WXT6hcLlbAoMnmttfJzWy29Xpi7wEkQw4T/2SubYJyaLTJsBW1gg6b
	 ppKn+hjJfDTsk5mlSoq14+kKzJT48k3sp/SfrnsnzrWrD94gP4Uj4LyFXWAeKkHief
	 2wgP2MiQQhJP0nk0THXvQH7arKFAu2nx/VLHK0K9rES7425HtO7Qu6Y2TqB6shtyfy
	 9Z62I5RxbFXGXQpQBSxF0WHgsKxstzplRJq80J8v4+6Upc9YSwVBU+j9rm5hG3SBME
	 PSwNKJFOd+chcJ7N7Xq2/bM7+fKGv2keU3iXsPoeB8k0u9S/Uvz3dQTzpeUlee50CE
	 jfZLGx1pja8Sw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 21 May 2025 15:38:11 +0200
Subject: [PATCH 2/4] dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated
 clocks from PCIe hosts
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-topic-8150_pcie_drop_clocks-v1-2-3d42e84f6453@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747834731; l=2093;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=sQCw7E34cAPyLXmDB3OvJZnN+ubAWssAmMHAauecdyk=;
 b=9OQWHcrk9X3HLOJbNqQj8gTtxkBVN0/QoYhamzyVIhXCpJw+FiqgqfwtvnI+RVx7rthnkBgAf
 22LvHyNGAhTAhSA41k+pMrDa78H2fx7Kt5OCxUsDVQDzhhIw06GwTzr
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
The ref clock is already being driven upstream through some of the
branches.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml          | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index a604f2a79de3b28863a0b8933e6679df4953402c..434448cd816ad4241ade402bbc621efc49646bdd 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -33,8 +33,8 @@ properties:
       - const: mhi # MHI registers
 
   clocks:
-    minItems: 8
-    maxItems: 8
+    minItems: 6
+    maxItems: 6
 
   clock-names:
     items:
@@ -44,8 +44,6 @@ properties:
       - const: bus_master # Master AXI clock
       - const: bus_slave # Slave AXI clock
       - const: slave_q2a # Slave Q2A clock
-      - const: tbu # PCIe TBU clock
-      - const: ref # REFERENCE clock
 
   interrupts:
     minItems: 8
@@ -111,17 +109,13 @@ examples:
                      <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
                      <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
                      <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
-                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
-                     <&rpmhcc RPMH_CXO_CLK>;
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
             clock-names = "pipe",
                           "aux",
                           "cfg",
                           "bus_master",
                           "bus_slave",
-                          "slave_q2a",
-                          "tbu",
-                          "ref";
+                          "slave_q2a";
 
             interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.49.0


