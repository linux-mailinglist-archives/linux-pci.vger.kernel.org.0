Return-Path: <linux-pci+bounces-22418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C6A45B44
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095BA1896C15
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAFF24E00C;
	Wed, 26 Feb 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DftBZyq1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49222.qiye.163.com (mail-m49222.qiye.163.com [45.254.49.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2E23816F;
	Wed, 26 Feb 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564581; cv=none; b=cbg0f6eaIwrTNctuUNfT/+PpGi6ZUIcEc9ZNw0SJymoe66r/wK//9LDF+fn95o3HOoyBJOfb+aZRDvh6SxLtuf8WlPHfwBhrJH2SjlagXmpcf/CDSrN1J6yBGQ0KFg/ZikSxnrCpUcJp9do5Tnw2OBUYmGKPSBWr4txyxqOQdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564581; c=relaxed/simple;
	bh=mXll4kOrJS2RYX/fu5Ga6AY++aXx3ovIghYituZIu3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VyYZpN7HYojmXehYiK38gJ6sMCYSP/VnWCAw2spriDYSu2NsB/FaGOZtZ5ssc3+/rE6FTHPyQIoFRE7n6N2yxPjbkfPn3n0N3FsVt9yypZN8Npvz4SF04GgeG5UQVdNrWRksM3FU66TkoiZ4Sv9Zvc6AgWVGrNwbYQHZc9RhrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DftBZyq1; arc=none smtp.client-ip=45.254.49.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c43156e5;
	Wed, 26 Feb 2025 17:54:15 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v8 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Wed, 26 Feb 2025 17:54:13 +0800
Message-Id: <20250226095414.2173410-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0eGlZPSBkdQkxJSU5MGBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9541adad4403afkunmc43156e5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6FRw4KTIcMwoTGEkcFQsv
	CixPCg5VSlVKTE9LTk1ITU5MTk9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTktDNwY+
DKIM-Signature:a=rsa-sha256;
	b=DftBZyq1kVe+u2e2A+F4tUJTnrHIcEcB8ciyc3OnouZLacAuk9PMU2mLx8KSfwcEcAWO15gGL02go8EOL2cPpmwpsLLaeu1lZ7e2BdKJvd8GFFsPhHoKSr/rn6xJHnkIQzYeZwyKEU8f4wGiVyPHzJDiF0fP/86RFLgRbPtNpF4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=vjXYFkddkt9PDyEj3qPNIpcqvdoLV3GTDFsK6D1hKxk=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
instead of using GIC ITS, so
- no ITS support is required and the 'msi-map' is not required,
- a new 'msi' interrupt is needed.

Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

Changes in v8:
- Collect review tag and add Co-developed-by tag.

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


