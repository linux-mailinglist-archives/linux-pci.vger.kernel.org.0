Return-Path: <linux-pci+bounces-25844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF846A88602
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E1C16D9F7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0ED2586CD;
	Mon, 14 Apr 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cnrrXloX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE1C2FD;
	Mon, 14 Apr 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642287; cv=none; b=nLVWHvrZKnn3ldULVTF5UOFo4iMcfQ83+6dGc0w+x7k7J+HZ3OwF3lJw+fGi76QqMJuQQDHsNY0xUF/WmcGvjJkyYDHcbiPa2dI8Ic+N+ot/2NA7ZwZzsanF42HGrO20yMBHLrqB1DC61Bqj10U/eKf4pEF+qlHZ6tRgdmQ96zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642287; c=relaxed/simple;
	bh=oUTojJ8VHrzx54PxNLR2U2HXoy2rGAm9uo7GjD44W/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZbIbdYyC5sUZIkAv52kVCXvlnJ6g7Io0FsYRWqDVx59z3G0CuzMig2C+V0dkOWF+Kweyiif1Hj7LZtWCbpq/g3j5iJfnYBHQ5p3817GLHyv9C23wExhh1RmzgYukOZM2SXZuZSLwcnnJYVM9MkWJ9/bgoG9dZrEciTHOyaRIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cnrrXloX; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [124.72.37.3])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11d4dc643;
	Mon, 14 Apr 2025 22:51:13 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: andersson@kernel.org,
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
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Mon, 14 Apr 2025 22:51:09 +0800
Message-Id: <20250414145110.11275-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414145110.11275-1-kever.yang@rock-chips.com>
References: <20250414145110.11275-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx8YVkpPHx5KT0lCGUhIQ1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSExVSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a9634c872e303afkunm11d4dc643
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6GSo5FTJCDiI2SgtCEksh
	DikKCRlVSlVKTE9PTU9JSUxOSk9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKSU9VTElVSExVSFlXWQgBWUFOTE1INwY+
DKIM-Signature:a=rsa-sha256;
	b=cnrrXloX1YP095aIE5OUmRKuSR5Vu121W2IVIRy8DyimtaKTXjq5JVlnHcb7JuWzqOkIGccga8Ul/YnUFJNJfDLtA/JvixHtJ/L8vTUGB9MaQUCkQBITLm4WUhHIpZ+UNSB2ZtZwzD7S5lhyi0X0sB8ywaQJ2fkqC+rMnDIfyfQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=BTGfvvmx9uCOlQ7mdVX6yR0ITce+y5QIkRUUepIgMjo=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using DWC PCIe controller, with msi interrupt directly to GIC
instead of using GIC ITS, so
- no ITS support is required and the 'msi-map' is not required,
- a new 'msi' interrupt is needed.

Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v9:
- Collect review tag

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


