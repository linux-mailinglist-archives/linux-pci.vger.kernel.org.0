Return-Path: <linux-pci+bounces-39949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D665C267B5
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3929F425CE9
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF626ED55;
	Fri, 31 Oct 2025 17:43:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9D2D2381;
	Fri, 31 Oct 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932606; cv=none; b=USreERZHUird66Pzdx7vdDz9IN1w2dDGtYci856HnIeQSYVe5dXbJKUq4tEB08tiZcOGiELWHBabbwDgqKUT9bjwTDsNU98AyCqqfUV/6TKTlj+ifc588JZjDHKpatKGlSlR1Ttfhh7j96zfUd0hHHQobi58sqgFeIIoIi/bTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932606; c=relaxed/simple;
	bh=hOzRlMRlpIFq50j9dDHMLuFdaWiwUzshHPxiwOpWbK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlZFd76eeuWxuWp0Y+EuajlyaQCsw4ZzVoAo+2pa51d1Qq2yQqQwfnmQx/YCmh8eHOgS6f/UsPog/ykCI49iOmraVhlWf5cxewWalxx9q+aRArhHRllgq+p/YZfdVJhMZTZMTJFUZELBzDD/fk8s9TANQkTF2hPLuBOlGHAWjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DC1C4CEF1;
	Fri, 31 Oct 2025 17:43:19 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 23:12:59 +0530
Subject: [PATCH 1/3] dt-bindings: PCI: amlogic: Fix the register name of
 the DBI region
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-pci-meson-fix-v1-1-ed29ee5b54f9@oss.qualcomm.com>
References: <20251031-pci-meson-fix-v1-0-ed29ee5b54f9@oss.qualcomm.com>
In-Reply-To: <20251031-pci-meson-fix-v1-0-ed29ee5b54f9@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=hOzRlMRlpIFq50j9dDHMLuFdaWiwUzshHPxiwOpWbK0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpBPUv+DpW+X31eYQDlq+xLMSoLGj8QHTWpr7cV
 bqBU5ZPb9WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQT1LwAKCRBVnxHm/pHO
 9eDJB/9csouOBq7gYpORCAxK+Pjw6U3fbv81XHaiJ5+j9AioSpKls7sMzhyOVMk5+M93jpZVw3j
 Z5AEMEDVIEz2G4/36rbdT8Hgz3iIgA4vxveurHRBPd0vFSOO0X84l0nl18oDH1Z4hf/LViT/gVw
 eU1+hHJl0sa2oi6cYVSFWqrKmngU89cDmjLRzYnZcY2+wxQUuxnEViNIJ5sIbKGYKsywMuJVZCu
 HJCvkiOIrjInrVDIA8hfnwb5gOvrkO/+Ami+zjM2ESLcaBI0qjGkHqTgb3a5EGySY8s9gGFOEFz
 MU+QmiA8Oe3ZnGWHZO9CXKzSAUKAx2vHD8wdNvZ/N/q0td+h
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
have region for DWC controllers as it has the Root Port and controller
specific registers, while ELBI has optional registers.

Hence, fix the binding. Though this is an ABI break, this change is needed
to accurately describe the PCI memory map.

Fixes: 7cd210391101 ("dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
index 79a21ba0f9fd62804ba95fe8a6cc3252cf652197..c8258ef4032834d87cf3160ffd1d93812801b62a 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -36,13 +36,13 @@ properties:
 
   reg:
     items:
-      - description: External local bus interface registers
+      - description: Data Bus Interface registers
       - description: Meson designed configuration registers
       - description: PCIe configuration space
 
   reg-names:
     items:
-      - const: elbi
+      - const: dbi
       - const: cfg
       - const: config
 
@@ -113,7 +113,7 @@ examples:
     pcie: pcie@f9800000 {
         compatible = "amlogic,axg-pcie", "snps,dw-pcie";
         reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
-        reg-names = "elbi", "cfg", "config";
+        reg-names = "dbi", "cfg", "config";
         interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
         clocks = <&pclk>, <&clk_port>, <&clk_phy>;
         clock-names = "pclk", "port", "general";

-- 
2.48.1


