Return-Path: <linux-pci+bounces-20027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D5A148F0
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 05:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EB0188C8AD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 04:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44A1F63FD;
	Fri, 17 Jan 2025 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SSQIn1G6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143041F63C6;
	Fri, 17 Jan 2025 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737089017; cv=none; b=JVYk/CnJ36ui0+jFkKKDGuFInngXaBV1hbaz+zfOTsYtkpftKQbgThTGRyHdqaMT07thk1QCKYcCpShJBOHjbOQpa0QAxwS7/6CNQMtmkInTJL5XfnsXIeUT9XdFm3Jtzocf95O7jgc98G3TAZaOVJcbqo3iS/1x0vm9/29hr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737089017; c=relaxed/simple;
	bh=y8RuriOS2ja4SiOfa72cFSdYPjP1BtVBWSYrhVdMUP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkcrAVM28cbMMojidzZEi7059sykwEOf0aFlY+PMOs7ice6fafmXYvqi/dijmazJHk1O74M9a23tmiLjFxWg5LEU7eDFQlr4AsrnSO1INrITFvRgfpbaTPxYMKYUdELowXN/xFn9MB6TFo+Kdi/sLEnatuJHYSGBcvqundnETtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SSQIn1G6; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id 8f2239f3;
	Fri, 17 Jan 2025 11:27:45 +0800 (GMT+08:00)
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
Subject: [PATCH v5 1/2] dt-bindings: PCI: dw: rockchip: Add rk3576 support
Date: Fri, 17 Jan 2025 11:27:41 +0800
Message-Id: <20250117032742.2990779-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0hIVkxITEpIHkoYTE5OTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a94724d735c03afkunm8f2239f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6KQw5TTIcOD8jES8sCR9C
	Fy0wCk9VSlVKTEhMS0NPT01DS01IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhDSko3Bg++
DKIM-Signature:a=rsa-sha256;
	b=SSQIn1G6Ajd3TooJmtM6vPtgaM8iirnAcYMHDd6c5OBEL/va29VvQohMa7+Gf5Ah2nGLqaRbWLLheucTYzF9IznOpv6HYfZ+XLTB79X9ydhtb1ea6kWa+g9zy+2trw0Mgr7RO9LxDcO8X/d6NY1m802k9rH1YjN/dv14kdw0b3E=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=nWUOXgGr1bJtNx1vYM6geNONWF/tpXFfL8Oby3eDDFE=;
	h=date:mime-version:subject:message-id:from;

rk3576 is using dwc controller, with msi interrupt directly to gic instead
of to gic its, so
- no its support is required and the 'msi-map' is not need anymore,
- a new 'msi' interrupt is needed.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

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

 .../bindings/pci/rockchip-dw-pcie-common.yaml | 53 +++++++++++++++----
 .../bindings/pci/rockchip-dw-pcie.yaml        |  4 +-
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
index cc9adfc7611c..eef108037184 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
@@ -40,6 +40,7 @@ properties:
 
   interrupts:
     minItems: 5
+    maxItems: 9
     items:
       - description:
           Combined system interrupt, which is used to signal the following
@@ -64,6 +65,10 @@ properties:
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
@@ -75,16 +80,7 @@ properties:
 
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
+    maxItems: 9
 
   num-lanes: true
 
@@ -123,4 +119,41 @@ required:
 
 additionalProperties: true
 
+allOf:
+  - if:
+      compatible:
+        contains:
+          enum:
+            - rockchip,rk3568-pcie
+            - rockchip,rk3588-pcie
+    then:
+      properties:
+        interrupts:
+          min-items: 5
+          max-Items: 9
+        interrupt-names:
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
+    else:
+      properties:
+        interrupts:
+          min-items: 6
+          max-Items: 6
+        interrupt-names:
+          items:
+            - const: sys
+            - const: pmc
+            - const: msg
+            - const: legacy
+            - const: err
+            - const: msi
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


