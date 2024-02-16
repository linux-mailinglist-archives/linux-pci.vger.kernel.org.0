Return-Path: <linux-pci+bounces-3631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFAD8586E1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5991C23AAB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CED1487FE;
	Fri, 16 Feb 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RopNAYmB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952D145B21
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115600; cv=none; b=Uo0c/U3pHcZ4WrkJ7QW7ErKSt15VTeE6ovrw809I4oD0a6jTlrehz5ybkBZgyfKfWr+ukSu9VdTuwyiBoIJGn5AhPiaYfKB1OYUEaXKgVcIoz2u178cjxkEwYpLiHwXAjeBS6Vea8k+SoW5xuNQkUFdR0QGkLCi4CUYEc5ORhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115600; c=relaxed/simple;
	bh=7siulsM+YIxL/zjVU9vKxvQTmEA2EKQzsqGyT9XfH/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVqEJiRNcRhm/aA6GcarEiNGq8CnBTynyG6GJfB+5mFv93q4wwTElBvbNvJ74SvnNiOF8PoiNgGIfHv7RjCo27vEkQWBtaIsPumD1ZTVESV+5xoZrxtr7F+uLE0S/a2EYodEJn12D44yT1S60TpDS879NZ79Zm2lLxNuWUwZEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RopNAYmB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411d715c401so19060125e9.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115595; x=1708720395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLo65DzlI0Pw6qQCEKnNFvuFSJmqXUdVDuf68OGs0ug=;
        b=RopNAYmBLzbU0E8FWuUlqcWP+GlVGJt0id3KbTdr5k9HaYH+UzwCoQfr0p1eAnfS2Y
         q9/ws62XvkUz89rZck2b2fw5t1uyn2WBFJ0Hf0MSsaobdw3m0k98z5FaG6tknDpRE1wY
         K10/03ea4vPXLOYm9561Jquaq6kOLSduihRk/P7VN3fTPQ2bRogDP18BW0prc0klPtpq
         pmfSKOsmTYGK5j5OcMDiHCLtyrqrGp0RWIq+4Z31VISMBcoQGOACQFLvBO9fQ0FkjX3o
         Av22SeTujKCnxSC2kmjHEWJqUp1JlrSdt0MPnMF/ljI3K+m/uUNTjTefCWM4yYs187Oi
         r8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115595; x=1708720395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLo65DzlI0Pw6qQCEKnNFvuFSJmqXUdVDuf68OGs0ug=;
        b=BE1l3Zli9ZI0R5AqaFOj9JNc8Nf2iYchwS8KY7mpjw2eULGByvi+99DxuJ2IW90Nvp
         s19VFaGtt6JTJspK+sDbEtbo2yvd8JXj77BDBrDMWGvlljS0Q5/qzjsz34CT2ddHNwiz
         XIGFcUtb1qYXgGsOZIJrYEYibXKTx80KkmTiHs+OhnZ2b1ku1JjkMhR/eQT8qfzXgzZx
         kg9SJ9jjpN4nXeqvNVLoHJNhSphUAUtD8pmvCt1qjNzuDpkYGsW0g2fRuIl1O0awjbay
         G5lvnSeXrxF76h0nWUGpMAsOwbfP7z2j7ukXpXxwd/iGeHnk414mhywr+EX6M6klXaC0
         ZEaw==
X-Forwarded-Encrypted: i=1; AJvYcCXoYl/eQdxPpQv7pgfgmS/sNd8t0G+pFoj8wiGkw7VBGrAJN8+utyn71lkoXxfq4v03Gx9425OIyoRAkhwI9McLUa57APBqwt1E
X-Gm-Message-State: AOJu0YwUQUHSgOgxhKYMjL+UCbTkiM1iF1cxBygVc+AhUfTzxlkJICqi
	PHiumhDHCdc1uCp85etPyncVXe58aoGDBxh4Jj61RqjUH+QfdX3DXVpsLwEKQko=
X-Google-Smtp-Source: AGHT+IFiDpD9jnNjXHaYBDe5iqmGRvtMJpVfZZ7zS3b3nDAA5bd5zEp/CAbSuDJNq9KUS4HizlvLyA==
X-Received: by 2002:a05:600c:b91:b0:411:e398:9f33 with SMTP id fl17-20020a05600c0b9100b00411e3989f33mr4538745wmb.15.1708115595442;
        Fri, 16 Feb 2024 12:33:15 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:15 -0800 (PST)
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
Subject: [PATCH v5 03/18] dt-bindings: regulator: describe the PMU module of the QCA6390 package
Date: Fri, 16 Feb 2024 21:32:00 +0100
Message-Id: <20240216203215.40870-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
are powered by the Power Management Unit (PMU) that takes inputs from the
host and provides LDO outputs. This document describes this module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml  | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
new file mode 100644
index 000000000000..b71fa782fc63
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,qca6390-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QCA6390 PMU Regulators
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description:
+  The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
+  are powered by the Power Management Unit (PMU) that takes inputs from the
+  host and provides LDO outputs. This document describes this module.
+
+properties:
+  compatible:
+    const: qcom,qca6390-pmu
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddpmu-supply:
+    description: VDD_PMU supply regulator handle
+
+  vddrfa0p95-supply:
+    description: VDD_RFA_0P95 supply regulator handle
+
+  vddrfa1p3-supply:
+    description: VDD_RFA_1P3 supply regulator handle
+
+  vddrfa1p9-supply:
+    description: VDD_RFA_1P9 supply regulator handle
+
+  vddpcie1p3-supply:
+    description: VDD_PCIE_1P3 supply regulator handle<S-Del>
+
+  vddpcie1p9-supply:
+    description: VDD_PCIE_1P9 supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  wlan-enable-gpios:
+    maxItems: 1
+    description:
+      GPIO line enabling the ATH11K WLAN module supplied by the PMU
+
+  bt-enable-gpios:
+    maxItems: 1
+    description:
+      GPIO line enabling the ATH11K Bluetooth module supplied by the PMU
+
+  regulators:
+    type: object
+    description:
+      LDO outputs of the PMU
+
+    patternProperties:
+      "^ldo[0-9]$":
+        $ref: regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - vddaon-supply
+  - vddpmu-supply
+  - vddrfa0p95-supply
+  - vddrfa1p3-supply
+  - vddrfa1p9-supply
+  - vddpcie1p3-supply
+  - vddpcie1p9-supply
+  - vddio-supply
+  - wlan-enable-gpios
+  - bt-enable-gpios
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    pmu {
+        compatible = "qcom,qca6390-pmu";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+        vddaon-supply = <&vreg_s6a_0p95>;
+        vddpmu-supply = <&vreg_s2f_0p95>;
+        vddrfa0p95-supply = <&vreg_s2f_0p95>;
+        vddrfa1p3-supply = <&vreg_s8c_1p3>;
+        vddrfa1p9-supply = <&vreg_s5a_1p9>;
+        vddpcie1p3-supply = <&vreg_s8c_1p3>;
+        vddpcie1p9-supply = <&vreg_s5a_1p9>;
+        vddio-supply = <&vreg_s4a_1p8>;
+
+        wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+        bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+        regulators {
+            vreg_pmu_rfa_cmn: ldo0 {
+                regulator-name = "vreg_pmu_rfa_cmn";
+                regulator-min-microvolt = <760000>;
+                regulator-max-microvolt = <840000>;
+            };
+
+            vreg_pmu_aon_0p59: ldo1 {
+                regulator-name = "vreg_pmu_aon_0p59";
+                regulator-min-microvolt = <540000>;
+                regulator-max-microvolt = <840000>;
+            };
+
+            vreg_pmu_wlcx_0p8: ldo2 {
+                regulator-name = "vreg_pmu_wlcx_0p8";
+                regulator-min-microvolt = <760000>;
+                regulator-max-microvolt = <840000>;
+            };
+
+            vreg_pmu_wlmx_0p85: ldo3 {
+                regulator-name = "vreg_pmu_wlmx_0p85";
+                regulator-min-microvolt = <810000>;
+                regulator-max-microvolt = <890000>;
+            };
+
+            vreg_pmu_btcmx_0p85: ldo4 {
+                regulator-name = "vreg_pmu_btcmx_0p85";
+                regulator-min-microvolt = <810000>;
+                regulator-max-microvolt = <890000>;
+            };
+
+            vreg_pmu_rfa_0p8: ldo5 {
+                regulator-name = "vreg_pmu_rfa_0p8";
+                regulator-min-microvolt = <760000>;
+                regulator-max-microvolt = <840000>;
+            };
+
+            vreg_pmu_rfa_1p2: ldo6 {
+                regulator-name = "vreg_pmu_rfa_1p2";
+                regulator-min-microvolt = <1187000>;
+                regulator-max-microvolt = <1313000>;
+            };
+
+            vreg_pmu_rfa_1p7: ldo7 {
+                regulator-name = "vreg_pmu_rfa_1p7";
+                regulator-min-microvolt = <1710000>;
+                regulator-max-microvolt = <1890000>;
+            };
+
+            vreg_pmu_pcie_0p9: ldo8 {
+                regulator-name = "vreg_pmu_pcie_0p9";
+                regulator-min-microvolt = <870000>;
+                regulator-max-microvolt = <970000>;
+            };
+
+            vreg_pmu_pcie_1p8: ldo9 {
+                regulator-name = "vreg_pmu_pcie_1p8";
+                regulator-min-microvolt = <1710000>;
+                regulator-max-microvolt = <1890000>;
+            };
+        };
+    };
-- 
2.40.1


