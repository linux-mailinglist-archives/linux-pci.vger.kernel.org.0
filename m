Return-Path: <linux-pci+bounces-28214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22059ABF64F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F9F1BA7997
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799A27C17F;
	Wed, 21 May 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY2MtFRu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869815098F;
	Wed, 21 May 2025 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834743; cv=none; b=ObzePntZ8XNd9xWd1oC78BdeITutIv9SzN+olGFoOd5vQMhQqx0Tgz6XFZhnn/XNveD4qSlO6+6m1WbsqsPYK0+ynssJ4csXy9/1q4y2adNe3P/6mHKRk9lXK6FgxlDbdNykS+9aY9g0E8xncQnP5qC18XCTp2Rc7xqyZwj6BoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834743; c=relaxed/simple;
	bh=hmw3/TYYvnguBR8TqyLON4vogTv3Z6PA39/cDuVfL8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plxY1+3h3WTxkPY47IjsUZzcM+0cwn2mS2PmEsYi0KBPl8R7UpcZgOFz7Z5XtlMwpgSXqCG5r0R8CmmpnlEteJbBVI13OxG8l9pMBPAZksNseLZsZyEBCDr2S+M8LSTdK7JouZKDtGDi/fwFUyMfEQajYj3q4YDmeLKTuf6OtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY2MtFRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0EDC4CEE7;
	Wed, 21 May 2025 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834742;
	bh=hmw3/TYYvnguBR8TqyLON4vogTv3Z6PA39/cDuVfL8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UY2MtFRuf29jjPSvmAzXOqwqgIzULtyOEfclYllVGbcz3fZXRqRBIqgN7iuhjknzw
	 qjwmSveiM1XykMblK+F4gO3RNnXAf5555WyKYHXYH8uxg6+3cz52788g8LeSlPI+0j
	 1QaN5yxdOPWwaj6FReeIaApJ3mlQitUSNAcqpPAW8tQQQs0afXANgDjaxIcIeVOYKX
	 9FTFCD00gGT2ZBXO0XEz0apytoSkeEYUaZqUhUAZ/oFZU6dQqHoCtXu7yv6kyDsixc
	 Eyi5Hr68nzSbXwLF3f9Uzgrvb1Sf1VjqD5oeG5iIof61jYd8XE2lTGsYDK1O0YjVs0
	 64mk4E899jc6A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 21 May 2025 15:38:10 +0200
Subject: [PATCH 1/4] dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated
 clocks from PCIe hosts
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-topic-8150_pcie_drop_clocks-v1-1-3d42e84f6453@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747834731; l=2010;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=HJbsRaZED0wy0A3F8QPlsAh5wTABzi2Z6ovJBrDz3qg=;
 b=6G8DmoAaPdMGYwy9JopFryWqvO8O2YBHxxPULwgFPvcZXhmatN/zSSHMIzu6ikGNhFa9pz/YD
 ITdfoN1G752C5yf1xiY1ZYKXdLpCQg8qt63OCbkSmTp+4H5wvoJBmev
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
The ref clock is already being driven upstream through some of the
branches.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml         | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
index 331fc25d7a17d657d4db3863f0c538d0e44dc840..34a4d7b2c8459aeb615736f54c1971014adb205f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
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
-      - const: ref # REFERENCE clock
-      - const: tbu # PCIe TBU clock
 
   interrupts:
     minItems: 8
@@ -117,17 +115,13 @@ examples:
                      <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
                      <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
                      <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_CLKREF_CLK>,
-                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
             clock-names = "pipe",
                           "aux",
                           "cfg",
                           "bus_master",
                           "bus_slave",
-                          "slave_q2a",
-                          "ref",
-                          "tbu";
+                          "slave_q2a";
 
             dma-coherent;
 

-- 
2.49.0


