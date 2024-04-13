Return-Path: <linux-pci+bounces-6212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C98A3D33
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83A6B21600
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5CF45C16;
	Sat, 13 Apr 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SO+4uYcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7747A7A
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713021403; cv=none; b=G5FS3YylFFQUTpjFaTx2duvug7eskS4OvBUNw3EI6TKD4V+O7rigqxmC7zji0dNN1Rcs7Bx7UoRcGv7DmGQgTOvJBXB/xh6YwU6+wTPO5AffvJif+DzLXn75kimSUIIwK3LyvvzhmzKOucdI91ZDIKztqI5Nj0vVvVpErH+dcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713021403; c=relaxed/simple;
	bh=hH/i56/VVMXc5h7IY9kB8GOOP4BZo9JkA0T8zeB0y1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m2ohPibcrRpfOJXnJsEbVA0KZoH24+IqI5bDQR1BfbzfBuMZo7ze0yAYKl008QZ76yixyZUn3mjOiZqeBAQLsr7m91xuti6Ntf7FLsViWCLyA4fqxCyq2kh7nlvt13SG/6Cb5vzINkLfpTOWzvZDeo18BsAcnBYbInwM0UkVG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SO+4uYcw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2da01cb187cso32209341fa.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713021400; x=1713626200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KLUzTPW+KpN4IRI1ic6uWm66ErzBdD1Xi0Bbn1RRvE=;
        b=SO+4uYcwgRmR13xE9xpgbjeLoTcy2dS9rLlXQ4iT0DCVUisbhVTPemX8ehvEMZ3foT
         lOlCCZU299HCe6mm/AmTFLZFKa41W16TbBLBK49PCbJMbLb8ydiuCywSA30abNmKv0sy
         D98+s49v4V43n+KWWpMvP3ip9Kp1xR9eXol1hY6/eivWTb1wIiirh/9DWsaLIAXYuIZr
         ko1mDWsz8s8Xa5lgCwtQlWZVg+ZYKD7aMxwP+WoVsYDIdCCeSKiD/ROaPlZ/E+rrfhPu
         rwIaRSn1iJ9h9cc4sNtFrs77Y24roJQQTsnGC5J+lxzjDf/zbSYu63aK+MNwRS+LY5Xb
         UmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713021400; x=1713626200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KLUzTPW+KpN4IRI1ic6uWm66ErzBdD1Xi0Bbn1RRvE=;
        b=he2rzV+z2SHhFuW4bMgs4h2R84novuzkRK1LIukKBYy8Y7kNrTsGJMS2bU3f/aPvIK
         SXr8VQcotRnLN7N7M2NQUTn1ROsZICmYWtnmBBSdyl0oCyABPQBO67gY7SjMNEHFEvZi
         yDtlbNVbW4expN1ovug6yB15J2sp/PIHcIP8q2fdWx9mIBPp/EwGwtv2L9m6pG2bEHOC
         ByORXAqp6UVyIT91GQ8a00kK1bBCpi076siQVfHcOaC5rdiuCO9kDRO8wlYK81bnWHwK
         smw4bysArdzuz8iAbV5F+SH4uV+J/t45m7xGaXYQbnnN48KXEImqrDJKKSKUrLhN/Eqw
         Vdsg==
X-Forwarded-Encrypted: i=1; AJvYcCUVj4JrmS+zVQZa3kdRtQZstP2Ugw4fXxgI5CCo/VO34FirXjq0Gv2JWDIa/x85scXKi3nVaR61b4sywR/70Vn93eWejbeM4N5j
X-Gm-Message-State: AOJu0YyTH/TCv4q53NHo0NykXjieMiOletmuWF/0War7HUAKSwAPHWCv
	ncB8ajDcTqcfywXCi26IBbR3zSOHutPTeuPseMWA9Jpt55IF3CpUObQs8YIY1AQ=
X-Google-Smtp-Source: AGHT+IG1tNnKVrVnl2J/+j+UL2Wl4h4NMws2XRL9Lu8vXwFs1VUku2GIOwL+IkYjq0NdIfadi6221Q==
X-Received: by 2002:a2e:9ed4:0:b0:2d9:fd90:af57 with SMTP id h20-20020a2e9ed4000000b002d9fd90af57mr3723839ljk.51.1713021399920;
        Sat, 13 Apr 2024 08:16:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3104956ejc.76.2024.04.13.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:16:39 -0700 (PDT)
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
Subject: [PATCH v3 1/4] dt-bindings: PCI: cdns,cdns-pcie-host: drop redundant msi-parent and pci-bus.yaml
Date: Sat, 13 Apr 2024 17:16:14 +0200
Message-Id: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binding reference common cdns-pcie-host.yaml, which already defines
msi-parent and has a reference to pci-bus.yaml schema.  Drop redundant
pieces here to make it a bit smaller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. None

Changes in v2:
1. Add tags.
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index bc3c48f60fff..a8190d9b100f 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -10,7 +10,6 @@ maintainers:
   - Tom Joseph <tjoseph@cadence.com>
 
 allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: cdns-pcie-host.yaml#
 
 properties:
@@ -25,8 +24,6 @@ properties:
       - const: reg
       - const: cfg
 
-  msi-parent: true
-
 required:
   - reg
   - reg-names
-- 
2.34.1


