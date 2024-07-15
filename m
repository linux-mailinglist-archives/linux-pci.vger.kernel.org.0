Return-Path: <linux-pci+bounces-10291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8493199B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A121F23758
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF213A877;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu82C2Ll"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F9770EB;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064830; cv=none; b=pNg2DGmgQR10RlUc7VEQvrEZWe3WBqFVAi2yNusDFGPZ7aCe9fzvtSGSBjaKUfj3bTkhtuRkfuV5iLpbBTYQu42/6HyxMDuT8Ybj4XENgbeCE3ENoccWFzX9Nt66qkd2r6SaHkUGON9Y5BRDkdC3VI2dgif5GU3xzZbW1FCA2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064830; c=relaxed/simple;
	bh=xVSjQT1rCMYJ7JMW46sFrx5R4uNe8KS69JtmKEfBafc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP0wHuEI54bPFJeSfJOggtInHBBXTphCJzCbwE8kff1j+sOFKcNErfvv7msIMDyPvuRcNmB9TTVak7nc2yhhsDwZUPOKr1FGCzgB34UJKNy/R6xOeBHmmNWzoe2hA0ZtCCFO5hSWptJCI1sEyJ6Sk7QHCtYBmjYyDJpecadLFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu82C2Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 302C1C4DE03;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064830;
	bh=xVSjQT1rCMYJ7JMW46sFrx5R4uNe8KS69JtmKEfBafc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nu82C2Ll4x+3lGoxTT8d/ieQYacqV3i7WgzyCLF/jqFqRs06bMb+QAdiHiPdAt8TQ
	 TJ3//nMr/oylVL5GhOC6H32iblKRfVk0+fldHePorK4E3N4h0Ah/+A6owKoIhCtR09
	 GcLtpbx4NsjV61M9lg+FU3NMe9aJWylzzgWntPF7xT1++2PKxtWyAfLw2yl/huP3wg
	 Ve3SKyK6wBx1wVvhovI7os8RVknFDzL0WuSPZzmMKZDOxtkzJK+dr9XxX9W1Gf7u/c
	 pnCxFDZriZgI1bl4n95/IB0umuf8DhFYKxub4gveOKqMn/HxsJg3VmwK2q30QwfFBC
	 EaQ2UD05in6ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06EC3DA4B;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:54 +0530
Subject: [PATCH 12/14] dt-bindings: PCI: qcom,pcie-sm8450: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-12-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=WTYqEiAQrNsXkDUR6nKibzqYEnKaNCwK2nnJZ4g+zho=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV16ZB3NnaJtATae6mwMyrKVJ5xmd5atLfNLa
 xNlnVYMLfiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdegAKCRBVnxHm/pHO
 9XSNB/sESbYziAXHCBhk6c0y4dDnKo4/6fjFGjaoiyuL3YY+yC6HGf4SU6vfy5rgOSfWQ99qy6+
 y691vXTGGQQx+ZsWpidtNxMp1HrknnTgg4BjRYwAC8UJzvxX1ABF96iHbWDQP0a3AlhsOt0u8sw
 qQoFSu/eleHhcdSoPcIsD0BUoHnT488bVpYbwRPBIUQEGtNDPf2BadLKJiiIT/y3LjrMsMQU4Cb
 RUX+VeDDj0CHEGfgc5zuTDidsls19BPtYjo1NsmEeiNXFfmxYOQJwBJO1NueUznfO8kJO1ctX2S
 jEvWemfxy0WBlS8FybekwrE7jS9uNMo/+WiVQNGGCpvoO5Pc
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPU. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, document it in the binding along with the existing MSI interrupts.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index d8c0afaa4b19..0d68ce073383 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -55,11 +55,12 @@ properties:
       - const: aggre1 # Aggre NoC PCIe1 AXI clock
 
   interrupts:
-    minItems: 8
-    maxItems: 8
+    minItems: 9
+    maxItems: 9
 
   interrupt-names:
     items:
+      - const: global
       - const: msi0
       - const: msi1
       - const: msi2
@@ -142,7 +143,8 @@ examples:
                           "aggre0",
                           "aggre1";
 
-            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+            interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
@@ -150,7 +152,7 @@ examples:
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+            interrupt-names = "global", "msi0", "msi1", "msi2", "msi3",
                               "msi4", "msi5", "msi6", "msi7";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;

-- 
2.25.1



