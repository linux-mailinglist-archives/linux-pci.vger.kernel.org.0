Return-Path: <linux-pci+bounces-6071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA1E89FF94
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883741C23325
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045518130C;
	Wed, 10 Apr 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oB2gqypm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7D180A72
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772940; cv=none; b=ku2YrNuOjiNrgVXiEP82xRwjdva+9p9xuYhoZWkg1M+e6M7jNDEs0L595etOEmFqNLiArbgHehbe0Sh888PrreborR3L3M3w5tJl8Dts75YMuILUhnTIjBtE8occKYTxBqIULRvdR2wIPcBUR2851w9ySG6iwTj8AOQapP4MbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772940; c=relaxed/simple;
	bh=QLl5hlfep+ISuO1k8ea3e/nibjZ23isHug4k5JuNqOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glQSiHfBhsUULoQUoghRcyVcKV6govzWJGaV9rfiaE+4kQQ4gBw+hSQ2Gw06yfUNijuuykc346Nc1VVJM9yVyuqXk5yMW5byOCA6zrf7Hycxn+HAfCJDFo1YOFpPANmKDOQ7VTRduCwUPIgjc+I69HE9sRViWk+vANLMFC8fZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oB2gqypm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-417d092f2ffso241585e9.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712772937; x=1713377737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ7Fsv2L3D/V/tmG+uHYif1jQEu7neZ2/hm95sKkBlc=;
        b=oB2gqypmrJfxdNd2ddSVZBAt7Tomg0tZhw1gHU3clLo7aVekeS7lVOf5hl2QbrXqs4
         irArIVfaDHloCCwL6YJoVhnyptxDlxylxOJ8ad0Z+pQiwVjxbc0mavlEDnrfxR6BW2ta
         MKMhKggm5heBgNCv8JfGpdgT4A1FeTAKwKwSDQJb/nvuOSqkGtLNoFWph/Du6jCgBo28
         rSoaC9drZeCE8ukQAgI5M8gjkXU+fHsb/rEsgCjR3iQatFNjlLdIHBESypcNsK5VcEn1
         Bkkg7ThMqXUPfS+tlRl0nuaSSjZp1k/r/6TbxAu+JSVgTgR+43ICWjX3ZV9FGsfBcsqI
         C2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772937; x=1713377737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ7Fsv2L3D/V/tmG+uHYif1jQEu7neZ2/hm95sKkBlc=;
        b=omTdho76IdrlgIWQBioi5KnQ1p00Yf+BM0Y4/HmLrEbxyL/XoDRrSHhRo0timAMyP+
         YrFDQm3cL43GUgBhzCu/n9SGVwQDwzwI+Tg3EYk6x3FPQSEg9dqv2OEwLZjWtEjkpCtI
         Fp4TZemFBMMZJpodU58WAMNJPlDf7t8kVrbokMUx9V6fe/5aI8dbuoDGXsdpaPmVjVZc
         wy6zJ84jGwYFQx+ThWEdi8hqIxsUN/nov1YFfRw29D0dDDcBIT/mzmrUM7F7m+U1Y3cj
         9ZHPIYygHHq/vQzUxXT5gw+SsFO0EHCXHD5YM0CmrNKTpvECPQYngSRXnRZjZYl9V+lf
         bq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiHgcgT4e4eKqxmW7E4b/2YjtbukWIkmvMxPP/3OYsRlxntGxujsnH2k0P+/QptxYnVsICoW3v67rgkCEIL1jtVI7/cKa8sRhX
X-Gm-Message-State: AOJu0YzfegunA30Jh5kwe1kr2oCMP5yQc94znuFT5XUuEmECjl6fnG3v
	1ZH6xE7i4X5r82TFB8LTt0Q3cHARImhevgrbZ2gLD3Pn18npU7OLEhF4sBLRLpk=
X-Google-Smtp-Source: AGHT+IFWUtYZ81T+KZpUvyozhtH/oHDd2vVecgT7DaEB3ZmuIzfWZThdpq5JSOyKEpahu3eOvktS3Q==
X-Received: by 2002:a05:600c:3592:b0:415:511c:f801 with SMTP id p18-20020a05600c359200b00415511cf801mr2454776wmq.34.1712772936626;
        Wed, 10 Apr 2024 11:15:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c3acd00b004161bffa48csm3026487wms.40.2024.04.10.11.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:15:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] dt-bindings: PCI: host-bridges: switch from deprecated pci-bus.yaml
Date: Wed, 10 Apr 2024 20:15:20 +0200
Message-Id: <20240410181521.269431-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410181521.269431-1-krzysztof.kozlowski@linaro.org>
References: <20240410181521.269431-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema package with core schemas deprecated pci-bus.yaml schema in
favor of pci-host-bridge.yaml.  Update all bindings to use the latter
one.

The difference between pci-bus.yaml and pci-host-bridge.yaml is only in
lack of "reg" property defined by the latter, which should not have any
effect here, because all these bindings define the "reg".

The change is therefore quite trivial, however it requires dtschema
package v2024.02 or newer.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # Renesas
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add tags.
2. Split mediatek,mt7621-pcie to separate patch as it uses
   pci-pci-bridge schema.
---
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml     | 2 +-
 Documentation/devicetree/bindings/pci/apple,pcie.yaml           | 2 +-
 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml      | 2 +-
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml        | 2 +-
 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml       | 2 +-
 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml     | 2 +-
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml     | 2 +-
 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml     | 2 +-
 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/loongson.yaml             | 2 +-
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml  | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml     | 2 +-
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml            | 2 +-
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml        | 2 +-
 .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml          | 2 +-
 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml | 2 +-
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml         | 2 +-
 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml     | 2 +-
 Documentation/devicetree/bindings/pci/versatile.yaml            | 2 +-
 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml    | 2 +-
 Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml   | 2 +-
 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml        | 2 +-
 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml       | 2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
index a5bd90bc0712..79a21ba0f9fd 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -13,7 +13,7 @@ description:
   Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
 
 # We need a select here so we don't match all nodes with 'snps,dw-pcie'
diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index 215ff9a9c835..c8775f9cb071 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -85,7 +85,7 @@ required:
 unevaluatedProperties: false
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
index 0e07ab61a48d..5434c144d2ec 100644
--- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Scott Branden <scott.branden@broadcom.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 22491f7f8852..11f8ea33240c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -108,7 +108,7 @@ required:
   - msi-controller
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index a6b494401ebb..f4eb82e684bd 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: cdns-pcie.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
index 92efbf0f1297..378dd1c8e2ee 100644
--- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
+++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
@@ -51,7 +51,7 @@ description: |
         <0x6000 0 0 4 &pci_intc 2>;
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index d25423aa7167..3484e0b4b412 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -116,7 +116,7 @@ required:
   - ranges
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
index debfb54a8042..3cae2e0f7f5e 100644
--- a/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
@@ -12,7 +12,7 @@ maintainers:
 description: PCI host controller found in the Intel IXP4xx SoC series.
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
index 505acc4f3efc..1fd557504b10 100644
--- a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Srikanth Thokala <srikanth.thokala@intel.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
index a8324a9bd002..1988465e73a1 100644
--- a/Documentation/devicetree/bindings/pci/loongson.yaml
+++ b/Documentation/devicetree/bindings/pci/loongson.yaml
@@ -13,7 +13,7 @@ description: |+
   PCI host controller found on Loongson PCHs and SoCs.
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 7e8c7a2a5f9b..76d742051f73 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -140,7 +140,7 @@ required:
   - interrupt-controller
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index f7a3c2636355..a3c4ddc094aa 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Daire McNamara <daire.mcnamara@microchip.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
index 0d1b23523f62..0a39bbfcb28b 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -95,6 +95,6 @@ anyOf:
       - msi-map
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index cf9a6910b542..f867746b1ae5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -130,7 +130,7 @@ anyOf:
       - msi-map
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index b6a7cb32f61e..210c3f2bf94c 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -12,7 +12,7 @@ maintainers:
   - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 
 allOf:
-  - $ref: pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index 5a0d64d3ae6b..b288cdb1ec70 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -110,7 +110,7 @@ required:
   - "#interrupt-cells"
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
index 002b728cbc71..720a5f945a4e 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Shawn Lin <shawn.lin@rock-chips.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: rockchip,rk3399-pcie-common.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 022055edbf9e..548f59d76ef2 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -23,7 +23,7 @@ select:
     - compatible
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
   - if:
       not:
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index a20dccbafd94..695e491b7b3b 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Kishon Vijay Abraham I <kishon@ti.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/versatile.yaml b/Documentation/devicetree/bindings/pci/versatile.yaml
index 09748ef6b94f..294c7cd84b37 100644
--- a/Documentation/devicetree/bindings/pci/versatile.yaml
+++ b/Documentation/devicetree/bindings/pci/versatile.yaml
@@ -13,7 +13,7 @@ description: |+
   PCI host controller found on the ARM Versatile PB board's FPGA.
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 4734be456bde..b75ceefa6f93 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
index 69b7decabd45..fb87b960a250 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
index 426f90a47f35..b0d07c71c1c0 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
   - $ref: /schemas/interrupt-controller/msi-controller.yaml#
 
 properties:
diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
index 0aa00b8e49b3..2f59b3a73dd2 100644
--- a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
+++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
 
 properties:
   compatible:
-- 
2.34.1


