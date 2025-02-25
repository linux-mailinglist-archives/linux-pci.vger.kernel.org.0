Return-Path: <linux-pci+bounces-22313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A1A43B80
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FF87ABF89
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E887266582;
	Tue, 25 Feb 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="R3BMLr4V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21756157E99;
	Tue, 25 Feb 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479190; cv=none; b=uOHeGYkDwOTldc41fhfD8hqw7E2l+wTEV4A4uzFf4udHMriKZ5saDWCEEOC+O1uspWOqOJHmMsqKtY9Icae7U0bV7tud+WsRgB7fwA3SSQ4o50bP9Ww0DGLzCsskxUvkYX+urXoZSRNZNxS3gq8sKOSQ+ClaFtlXtaPGeuGuBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479190; c=relaxed/simple;
	bh=w+aiH2+ERaF147qiGvcUQoNta8JgrpXQVYoocIyjwaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSPJFNM1c5uBmA0jWkQjv2xhFitJfxmiTgWfg/CRRikcfWOZ0SpA1tbeXdfHWs8B3L4Q08VR56TSMCPuUhq3cMvLUy2QFFDfFzOq03ZKpD3Dc2FZbg/4Q45iTxPcMMPd7GFGEomUSnquXbbBco6tcII4wVyjIKNWgt6kUrRLWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=R3BMLr4V; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c22892ce;
	Tue, 25 Feb 2025 18:26:14 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Tue, 25 Feb 2025 18:26:10 +0800
Message-Id: <20250225102611.2096462-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkseQ1YfSB0aTEwYGUJJSBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a953ca4987e03afkunmc22892ce
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6HBw6GDIPFRYcSDkhMxQM
	ARcwCwpVSlVKTE9LT0xCSkxNSEhNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSEpCNwY+
DKIM-Signature:a=rsa-sha256;
	b=R3BMLr4VE9NCGf8G4KX+2yLPIsbV569yp/uPk999vqXfs7FFoJL7emRzj64MIQndiq3cBm9P2mt1N8kDy1TPipD1VcFQZzfMPXfVONnsMcpgaFBn9rM6nXgG/5lLBqQSanojrWWu6DtbmY4QSiDKSWW/wlwUgo3s3cTNL3PbEcc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=HxawArc165Ay2TKvOqn7tpKGAFxaS9bJbDWsvB3viO8=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
instead of using GIC ITS, so
- no ITS support is required and the 'msi-map' is not required,
- a new 'msi' interrupt is needed.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

Changes in v7:
- Move the rk3576 device specific schema out of common.yaml

Changes in v6:
- Fix make dt_binding_check and make CHECK_DTBS=y

Changes in v5:
- Add constraints per device for interrupt-names due to the interrupt is
different from rk3588.

Changes in v4:
- Fix wrong indentation in dt_binding_check report by Rob

Changes in v3:
- Fix dtb check broken on rk3588
- Update commit message

Changes in v2:
- remove required 'msi-map'
- add interrupt name 'msi'

 .../bindings/pci/rockchip-dw-pcie-common.yaml | 10 +++-
 .../bindings/pci/rockchip-dw-pcie.yaml        | 55 +++++++++++++++++--
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
index cc9adfc7611c..2150bd8b5fc2 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -65,7 +65,11 @@ properties:
           tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
           nf_err_rx, f_err_rx, radm_qoverflow
       - description:
-          eDMA write channel 0 interrupt
+          If the matching interrupt name is "msi", then this is the combinded
+          MSI line interrupt, which is to support MSI interrupts output to GIC
+          controller via GIC SPI interrupt instead of GIC its interrupt.
+          If the matching interrupt name is "dma0", then this is the eDMA write
+          channel 0 interrupt.
       - description:
           eDMA write channel 1 interrupt
       - description:
@@ -81,7 +85,9 @@ properties:
       - const: msg
       - const: legacy
       - const: err
-      - const: dma0
+      - enum:
+          - msi
+          - dma0
       - const: dma1
       - const: dma2
       - const: dma3
diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 550d8a684af3..4764a0173ae4 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -16,16 +16,13 @@ description: |+
   PCIe IP and thus inherits all the common properties defined in
   snps,dw-pcie.yaml.
 
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
-  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
-
 properties:
   compatible:
     oneOf:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
           - const: rockchip,rk3568-pcie
 
@@ -71,8 +68,54 @@ properties:
 
   vpcie3v3-supply: true
 
-required:
-  - msi-map
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: rockchip,rk3576-pcie
+    then:
+      required:
+        - msi-map
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-pcie
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+          maxItems: 6
+        interrupt-names:
+          items:
+            - const: sys
+            - const: pmc
+            - const: msg
+            - const: legacy
+            - const: err
+            - const: msi
+    else:
+      properties:
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          minItems: 5
+          items:
+            - const: sys
+            - const: pmc
+            - const: msg
+            - const: legacy
+            - const: err
+            - const: dma0
+            - const: dma1
+            - const: dma2
+            - const: dma3
+
 
 unevaluatedProperties: false
 
-- 
2.25.1


