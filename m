Return-Path: <linux-pci+bounces-6070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89F89FF8E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C1E282D40
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72811802DD;
	Wed, 10 Apr 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vY3A+gbP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F771802C1
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772936; cv=none; b=JGfEkuZBXCPH/vnHp9LVdj3j0K8ztfvkDrvcxPvPcf/MyRECvORoq/yJYSqoQJ4pQjyxzhyy63ThQYaImqeR3dU4sEqPLC1EICm/LHOQ/rK6DRbKKTcEFtoWhyEmv/1vXzSPUarmM59RBF/P3jLPGhXIFY8QgE/m1Qpw1BsyK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772936; c=relaxed/simple;
	bh=GUA2gQVyzUq4mqgqFOz7Ggun/F/2pZtr6iY/78kj6eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RejqIuYBU6ONnLrG/lcLiAu9BGQ5Kv+RXvctHW2ji1nozUD8uAeTH2D4sF7bfNTTX1zum/jIS3K118dWiCmGD64FMn+Qu6OaE6jMqsbc4Xy/YeNa+/WEoxFCBUXwP/EWbVyyzwNb6OC28erWTrPrfq22Ff4t4ermGVOKVFDx64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vY3A+gbP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-415515178ceso45967475e9.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712772933; x=1713377733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXX8VKX+rv9zqtz4L9Nra2C1jH70KvWHrUbepIAmkrw=;
        b=vY3A+gbPWJ3Q+qcXK7tv4rL4zkXRfzjxoLjPchy+nDwIYYWbmFiLYyyv85jeUJWbCP
         9ar9eZ3is3FXO0lal+8Gf7mdFB4ZsSXamzzFgIaN1YMKQfqU72LIJi/PX/l8pC0G5stN
         yuFvRQXjstbG91mYpMV0m72dMZu26xNY+faimRfBN2TXyfcRjiIsKk9/mKzwGnYA2XF4
         EsasEivyAjvK6/BCuLwFoWyTnQgC2r3zZeXUQj+U9yfsZ3HfqmmFCvzymgmCADWbXOcT
         lAjSJzEu4IAVgFNuJNLPp4RdCFpVMwt/fp613qVnyGW4e9IfeWQFRRTK80Wjlxoa1+NX
         Hy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772933; x=1713377733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXX8VKX+rv9zqtz4L9Nra2C1jH70KvWHrUbepIAmkrw=;
        b=GPhCtNfhFsM1pJTduR7arODToI2102ev914q2I3SLb1MuAbVsklMn35g45ptY0E4Ec
         tca0QhqCN3rbO48vyGJ8MePm2G9wfphoIU1bEOplao8t8ucB8Ztby+uiifyCMbqlTXh1
         RTgWelc6YVCTJdKYflfDQUYPtnGoUj7A3IhVqjZkSjyAijgoOOGAYQAmlOWQ3TdZEUkF
         YcJadKMEVDe4caFAWfcpuPatjUrvvL5kiYZlgtnJSySlBlO50B8Y2xWLf0kzsan2WC5q
         /q9QnLRUU07+Pl4PCSn+HUV++waf0v12N5FFPsi77DlKN67dgIcW6Jbpde+H8Ie9Wjd0
         LD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1vBYbrFMZUbFWdL5uShPowU6QpojAre0pkbnYzBKhi3YbxMGYIUskImeVB2RVsayfuPfJpRodAdtXJdNKnDJLq3vsuB0mMbT2
X-Gm-Message-State: AOJu0YyOPgggcBZTStSv3oeKO3VtOSo9yXO4IIzrzNnfXie4xVLuCbqw
	cazkV8/fSR9rprg23EqpcjxE36eDHO5yZqH8pjXRR3iNS1Q4BLDOPm/e49GZD+s=
X-Google-Smtp-Source: AGHT+IGazA6MZys4bTNDrbcrinuoI8bDaxyaA6yDxg8sZ5OMVeOpTl1JLqQsJ93ZXnFnHSgh7rOPfw==
X-Received: by 2002:a05:600c:4f0c:b0:416:a71e:f2c6 with SMTP id l12-20020a05600c4f0c00b00416a71ef2c6mr2275871wmq.4.1712772933184;
        Wed, 10 Apr 2024 11:15:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c3acd00b004161bffa48csm3026487wms.40.2024.04.10.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:15:32 -0700 (PDT)
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
Subject: [PATCH v2 2/4] dt-bindings: PCI: mediatek,mt7621: add missing child node reg
Date: Wed, 10 Apr 2024 20:15:19 +0200
Message-Id: <20240410181521.269431-2-krzysztof.kozlowski@linaro.org>
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

MT7621 PCI host bridge has children which apparently are also PCI host
bridges, at least that's what the binding suggest.  The children have
"reg" property, but do not explicitly define it.  Instead they rely on
pci-bus.yaml schema, but that one has "reg" without any constraints.

Define the "reg" for the children, so the binding will be more specific
and later will allow dropping reference to deprecated pci-bus.yaml
schema.

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add tags.
---
 .../devicetree/bindings/pci/mediatek,mt7621-pcie.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
index e63e6458cea8..61d027239910 100644
--- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
@@ -36,6 +36,9 @@ patternProperties:
     $ref: /schemas/pci/pci-bus.yaml#
 
     properties:
+      reg:
+        maxItems: 1
+
       resets:
         maxItems: 1
 
-- 
2.34.1


