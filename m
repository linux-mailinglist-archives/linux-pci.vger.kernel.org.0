Return-Path: <linux-pci+bounces-5088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABA88A70C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F65A1F63491
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C713E407;
	Mon, 25 Mar 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="se0Wjkhd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0C13E3EC
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372624; cv=none; b=lkVr5C0v8g/s84VKop4nX0hleJt49j0lCEKX4odMbxwLoQoo/NBoxt7+GwGdukBulnZfawrlb6mdE+BKTHFF0UYTEU8eWaB814FOZCNHMyQGEUjn70YDgwgOvqBv3vAoALHup+/4e9QccnkqzfMJOM6vGIFIRlEgJ2H+ug+5Ysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372624; c=relaxed/simple;
	bh=6EJanTOb9lmBTF84w02dw6YmtQBZ//XxYHWVbdxtB38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2dMVfxQUTci5MXqxH6Svc/mvddeugpWMb5Ts3VWYCUTNJBvoS2VxvYj/1Nd3ROK/N5PZy/HOGWzf5ZtLUX8IATvRCZUf7b3dhQklzAoPBj2H53UynfWdSEyMwccUQr68qHGJ/P1QxLTjeeOiT1hBESA+IeFv4bGyWtfKHVEfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=se0Wjkhd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513dc9d6938so5419113e87.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372619; x=1711977419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V84zGWHhNqI3aEKBbqoMuQ965CIVij1HgYyzK0b1yI=;
        b=se0WjkhdEhv1Yp+rM5vu6A4BsWXSvoPH2l3gX+WCIyVRTKUMbr+t6vs9s2tdEp3yQZ
         wFPKxFGX7TXCbQmHN33HvwFMJje4FQOqC3UqIGtxSK6I6B1oEnxQtRHTFSwymqQm0gec
         A9RpvyjBTDSKhryCz+OxLJnX2NWeOcM3Lna8sGxkTTFcdUKjIfuNnjpof2rkH3ZQrG9S
         Ym/cA6l/LTKyIm2/LtqvNN5JXSNPZ/vax/wiYkikEaz2nGv0kfTk3nn/MXH9k9ThfIwo
         biFEtFMUtcRu/HyVejUh1etY5zVsoDhmpk/s4Apohl8l4j4u0cDSRPid+mkAEQ1K1v9U
         m0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372619; x=1711977419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V84zGWHhNqI3aEKBbqoMuQ965CIVij1HgYyzK0b1yI=;
        b=WAbitvKTx4k8yPCo/F23MeFLeEPD8GrGDjRV7tc8eUliIKOlAZipYAb2O9JjPNVqWq
         SYlSotlR6E0UB0y02oXcKBzS+cZMncG+1/rYDpLfcmmAUK+kLvFUwHDWiuZxUs3DauM9
         j4vSila/UznWVeH7jRYEnfitHBywXjGEn82iPVlaMeRU0Mz4YWen0Wtlc4wVj3MFwvGV
         ljslXRb0DCiKa8O45KDsRSUDER/eu4d//PWCF++eLRxUvEOzcYpsaNWV4WJUViw+/TME
         floZmd+fASsbDWKpZ5F6BAVb8usHJARpjtSJ7gAPZJ1kpz2MYnMRpbL7zbftue1W1SmJ
         +L3A==
X-Forwarded-Encrypted: i=1; AJvYcCUr24psoN5E2P8gGH1mLYY1mqqkh/dLho2X3hdJ7fR5/lDESJYK4IETD66objptCCxapYo01N9t6hwo6dhYYPnSGqRnF4QPhi6g
X-Gm-Message-State: AOJu0Yzh9W5Xftx+ehL5Nc4Ju/+mi1rH7yhYr/vl2yXOybWxICuiDiGR
	CTUZ4lAFk/qKvb5XmZoVV/39vQ88dJHXNkxnA6+1Id66s14IEjVW/c9Op/0522g=
X-Google-Smtp-Source: AGHT+IEJvXpyYOxHwIwWL88KBcpPwn0R7Fchkf1Dzvcc/UuyhrMuuTIaVTEp1xNfrw/QKp8Xtgt69g==
X-Received: by 2002:a19:6917:0:b0:513:a39e:ae45 with SMTP id e23-20020a196917000000b00513a39eae45mr4575257lfc.62.1711372619309;
        Mon, 25 Mar 2024 06:16:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:16:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 02/16] regulator: dt-bindings: describe the PMU module of the WCN7850 package
Date: Mon, 25 Mar 2024 14:16:10 +0100
Message-Id: <20240325131624.26023-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The WCN7850 package contains discreet modules for WLAN and Bluetooth. They
are powered by the Power Management Unit (PMU) that takes inputs from the
host and provides LDO outputs. Extend the bindings for QCA6390 to also
document this model.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml  | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 9d39ff9a75fd..2e543661a1e2 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -16,20 +16,37 @@ description:
 
 properties:
   compatible:
-    const: qcom,qca6390-pmu
+    enum:
+      - qcom,qca6390-pmu
+      - qcom,wcn7850-pmu
+
+  vdd-supply:
+    description: VDD supply regulator handle
 
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
+  vdddig-supply:
+    description: VDD_DIG supply regulator handle
+
   vddpmu-supply:
     description: VDD_PMU supply regulator handle
 
+  vddio1p2-supply:
+    description: VDD_IO_1P2 supply regulator handle
+
   vddrfa0p95-supply:
     description: VDD_RFA_0P95 supply regulator handle
 
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
   vddrfa1p3-supply:
     description: VDD_RFA_1P3 supply regulator handle
 
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
 
@@ -50,6 +67,10 @@ properties:
     maxItems: 1
     description: GPIO line enabling the ATH11K Bluetooth module supplied by the PMU
 
+  clocks:
+    maxItems: 1
+    description: Reference clock handle
+
   regulators:
     type: object
     description:
@@ -83,6 +104,19 @@ allOf:
         - vddpcie1p3-supply
         - vddpcie1p9-supply
         - vddio-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,wcn7850-pmu
+    then:
+      required:
+        - vdd-supply
+        - vddio-supply
+        - vddaon-supply
+        - vdddig-supply
+        - vddrfa1p2-supply
+        - vddrfa1p8-supply
 
 additionalProperties: false
 
-- 
2.40.1


