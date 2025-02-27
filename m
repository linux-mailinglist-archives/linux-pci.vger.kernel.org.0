Return-Path: <linux-pci+bounces-22548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C784A47F81
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 14:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7230C3B2FBE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD5233D65;
	Thu, 27 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzAuUVZ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823F23098D;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663654; cv=none; b=YzCGZxXTmDDG/wQCvoUC+EFyfDqzUxgmCJEPLunrnUXT8zP+vTX1icvYcus+uGARqqpnJvG18l2k2IP0H6MWY7BJORWv7MXi18zwUH1NCt8bBgyZQdeSf6NI48ALeCHLLmlZMONhDR2KCCPFy+0CmT8RIR87XXyVVL+2P2JHNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663654; c=relaxed/simple;
	bh=eMkFLu9eZI4oBc4UR/FOHb0UM1RchoKR20K3m6cbeLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTQ1LJs/GT2uTziSRCUU0HPVW6lnBhp5lsNJEoMdwYhWf9cNnoFDNtpHYuKjtcchjNDdx8a18/RZjAoYpMNVVsuCtxM55pLQYvrObYyWSpSdpOoY5cqHHvJbkYPGoHdlTZazhhk1xwJ94sLuTfCbVHMUsIErOylSL5izvx2dleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzAuUVZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62C9EC4CEF6;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663654;
	bh=eMkFLu9eZI4oBc4UR/FOHb0UM1RchoKR20K3m6cbeLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XzAuUVZ093g9gvxLn+R03KXEzapp4yHBK4IDP55azzGdDn9zQzdtDSOj5AYky2Oca
	 ALH91YKTs5SdeEbcQqt4bMGklZDQSkF3VaKbWwvJQWF5NjG51PjnPx2gsHDv8gNgBH
	 rdpoMHXUxH7ASC5Qd0Y0ZJfa6Y8aY63k8aLZK0RlnobFx6LTHbDZ4n1ENjkVvcoAoB
	 zZnfwg+xXS4lvIYYolxH4c9wl3AZoeNhUiVRgDiQ9V+4GIBfHJuAT1RvOWbtMqLDRI
	 z/nXb7R/UlitfM8XJG4WvXWDgh/rQeuW38e8NbM10bMFsZKoxtwiurFOTHZSr47cv5
	 kQ3LOqi/MUzJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511B9C19F32;
	Thu, 27 Feb 2025 13:40:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Thu, 27 Feb 2025 19:10:49 +0530
Subject: [PATCH 07/23] dt-bindings: PCI: qcom,pcie-sa8775p: Add 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-pcie-global-irq-v1-7-2b70a7819d1e@linaro.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=4B0RA4FNMrbUWOS2nSab+Rb0slrEsmCreVqNdxB2RFw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBnwGtek6zKKn+xtMxxKqrA5Go7wrjKJ4nFEUOgz
 1btVb55fweJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ8BrXgAKCRBVnxHm/pHO
 9dlUB/0WkVcodOGDAZRUbGOYKHC2tzc4FWjskU3dk670eIOy4a/o8DDAcajH4RFaMLfPvyEhuGQ
 /u9W0+EalHFlhmxpQHkBhpQzygzPnBhQfB0x4v1k7HrbkIWWEf4Z0DvNKUpZ/8rwVngnsku93dW
 eFGRMghC9kyfysf/E73vyhU3ctYQWdTXI6Dhn2Hqgqd7rTRjq01Y+H81ZHCqCgj58j8+KDl0OdN
 0ZAxzkRdcYi4clmZAtW0DFEffsC9dNkSs3q81HGK1F6RS7OqgHABN7VpRoxQFu58BYNxLdo+HtW
 gBtDybchutMpIx8kcvOKk+RzeDjh+Rci1HsPTFXEIlj4zP+6
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'global' interrupt is used to receive PCIe controller and link specific
events.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index efde49d1bef8..e3fa232da2ca 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -45,9 +45,10 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
+    minItems: 8
     items:
       - const: msi0
       - const: msi1
@@ -57,6 +58,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     maxItems: 1
@@ -129,7 +131,8 @@ examples:
                          <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0",
                               "msi1",
                               "msi2",
@@ -137,7 +140,8 @@ examples:
                               "msi4",
                               "msi5",
                               "msi6",
-                              "msi7";
+                              "msi7",
+                              "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.25.1



