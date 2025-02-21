Return-Path: <linux-pci+bounces-21979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EEA3F397
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4DB7A6FCF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3C209F4B;
	Fri, 21 Feb 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jYrENAaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077F209F41;
	Fri, 21 Feb 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139198; cv=none; b=QdReJAqEk0PYE7CI5KkSGmVcKCR6FKV8/zhkVLqwFCGMJXcclbAWxgqS8/xiFE+4Z6glmTT0xYx6dUxBypKbRH766zEowRl1U6keG1aAUIzR4kMACFpxPzQtu573wapoDaccpSrmMgqDlqlFg+SsXkIpNG2lJcuJxtg6CWrK2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139198; c=relaxed/simple;
	bh=H66Br++P4bPNEqs39+jUcQdRgRuy2vL3PhuQWk8G2s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhTUNT6sGvY0R2Fdh4M4ZgypO9bJlPUeUb3eNT3+UAmRd6l8s9UrjBYcAM5pqP4a6XxaaEQcJ5UfWukfxdQV/lG5fiPswkzEu5Z5t3892bm8YuF2pssMJ11qdL4jYyHOA5gLhlcjXL3piuFc72ZEhEqLNQGfUgomARY29dKg7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jYrENAaX; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bca250ba;
	Fri, 21 Feb 2025 18:44:13 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
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
Subject: [RFC PATCH v6 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Fri, 21 Feb 2025 18:43:56 +0800
Message-Id: <20250221104357.1514128-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221104357.1514128-1-kever.yang@rock-chips.com>
References: <20250221104357.1514128-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNJGVZOGBpMT0kfTB0dTx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95281b9ed103afkunmbca250ba
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6GCo6DzIUThk4Nww5GEsv
	CzNPFFFVSlVKTE9LSkhPTU5OS05LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ09MNwY+
DKIM-Signature:a=rsa-sha256;
	b=jYrENAaXI/q/GIYW7Yvgf9InsIiCz3Ei7bvBTGdYQC5O1XfNu9hGFbX+muAKo75/tBxSNhttlMqTzQtWvEuqNGZpO25JxMr64u78X0cF7CZQ7iqT0P4tcqq2OGqCzTBSJMsSNiTZp9K1Y3/HO3Px5GnfYh+DCOr+A/BK5421A5k=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ukC/diYj/SOkXqmZAXU5Lp6DcD2S1bRVcWV6nw0f+Ro=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using dwc controller, with msi interrupt directly to gic instead
of to gic its, so
- no its support is required and the 'msi-map' is not need anymore,
- a new 'msi' interrupt is needed.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

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

 .../bindings/pci/rockchip-dw-pcie-common.yaml | 59 +++++++++++++++----
 .../bindings/pci/rockchip-dw-pcie.yaml        |  4 +-
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
index cc9adfc7611c..069eb267c0bb 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -64,6 +64,10 @@ properties:
           interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
           tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
           nf_err_rx, f_err_rx, radm_qoverflow
+      - description:
+          Combinded MSI line interrupt, which is to support MSI interrupts
+          output to GIC controller via GIC SPI interrupt instead of GIC its
+          interrupt.
       - description:
           eDMA write channel 0 interrupt
       - description:
@@ -75,16 +79,6 @@ properties:
 
   interrupt-names:
     minItems: 5
-    items:
-      - const: sys
-      - const: pmc
-      - const: msg
-      - const: legacy
-      - const: err
-      - const: dma0
-      - const: dma1
-      - const: dma2
-      - const: dma3
 
   num-lanes: true
 
@@ -123,4 +117,49 @@ required:
 
 additionalProperties: true
 
+anyOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3568-pcie
+              - rockchip,rk3588-pcie
+              - rockchip,rk3588-pcie-ep
+    then:
+      properties:
+        interrupt-names:
+          minItems: 5
+          type: array
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-pcie
+    then:
+      properties:
+        interrupt-names:
+          type: array
+          items:
+            - const: sys
+            - const: pmc
+            - const: msg
+            - const: legacy
+            - const: err
+            - const: msi
+          minItems: 6
+          maxItems: 6
+
 ...
diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 550d8a684af3..9a464731fa4a 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -26,6 +26,7 @@ properties:
       - const: rockchip,rk3568-pcie
       - items:
           - enum:
+              - rockchip,rk3576-pcie
               - rockchip,rk3588-pcie
           - const: rockchip,rk3568-pcie
 
@@ -71,9 +72,6 @@ properties:
 
   vpcie3v3-supply: true
 
-required:
-  - msi-map
-
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1


