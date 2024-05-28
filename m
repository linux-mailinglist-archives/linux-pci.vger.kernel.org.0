Return-Path: <linux-pci+bounces-7911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5632F8D23CF
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 21:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19BE1F24D97
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D4E178CF1;
	Tue, 28 May 2024 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zQy1R4s0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42E173343
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923034; cv=none; b=NbMPQjO5tJEXeVT8XQ+0RcFbVN4DNQ9Nz70SdHghTIvtDnpBAhso1FRc/wpq9epXXSEODoEUOQ8v0AngnafxoX2P7ft8XML+WYNrenwpz7N658FcSNUNp4cOcoj3fkpOuAiQEsdUaYFB5CFO6RFwPbGODFHpZcbuHXIyl8dwqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923034; c=relaxed/simple;
	bh=jRRVWnUcsllv5xg42qCNsEqBnQxxCaBinC9xgoK7ExY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6BJ4g3/RwdQwQ80+/LMBJRwkyn6n8cXYJZuKPEglEci+Gt3Wuz+nTFGoTEFy2TfLDFO7U+uuy3iiFugsPhuciu4NCzXlDZdrridV1dGm/veOBx5pisQPlReyuLI+J4lomp/KzCBPkqjdpMkWy9zfdZdWA7rnz+1mJtNoLE2o8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zQy1R4s0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so10140375e9.2
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923029; x=1717527829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/rfODploHDKXzqF5uZDj5HypMDi8GHx8C3gU75cfUM=;
        b=zQy1R4s0Fw3Hb3fuCjUOVxn+UVgKo3/10nbUP4dD1urK75sfNVqKC0vSQYScQ3pn8R
         NIqR5BYhZun1B5CjqnNfqBT8fYujxsEqGV1sbUoeZ0v+4M0AVZjUHkycD1Letngn6r3n
         2Wex69J1vP3bVSuI2Va4EXxBtAfwEDRPCT5SM/r9QRDi4Cn/utikY5DENAtGAASqo/W6
         jgtEhrKX/8XcgaFnPZxgMkeFFzKqs5k5QvYv/sVFRZEFcrHcGBbPq4TJr6koG7xXD9m9
         sPeDFQcf0hCV3RhMa6ZpB7PgrNAWTerLZivO9RdBir+rESuyz4+uNFV396Cjq1gwYWq3
         k+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923029; x=1717527829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/rfODploHDKXzqF5uZDj5HypMDi8GHx8C3gU75cfUM=;
        b=w8ujJI/RLVdKhR+5RGMbC+DLbAoaBXyow1L/03110ULnHl8ISBPT0N3Tj7eOdUN7pr
         3jd8G8uwuZgKahnCRBOeMZTOiDNBs22mL+1X07ZUzIjUMexjR5YHWZPn7Y6Ns5sGgXCJ
         liOc3CE9zR6iBSh0GvtKNVAD2d+xGWu6iD3xASRw9z+jOjHyiBzAN/2hxAaK86df1lm3
         JD7klgVjH4o0re3jI7AcOEYuvM2FpqHCVSrqWHRv6Qc+iK0fmZHI7PGbOHoOOTnolwcK
         /r4Pb2/UeNgULaSHr1TQU1PgAa+y1NWEHy1JQmWJqmzscsxJVFyOdhba0JT9oJnsDdbS
         j14A==
X-Forwarded-Encrypted: i=1; AJvYcCV7sgvkYnb0KVJXv1YuQh54ugMm5jVLNl4IHn+c+LUbB248CpGBShWSQnoNBtNmIukq2hvSz+TdDoUBbkljxz7KRjZi58f/++ww
X-Gm-Message-State: AOJu0YxlaUpzOSlGm91F4iM1zteVAbjvKidxiuwR/DEai7W/pvQRgXqw
	3x0WEJLOi9HgNOtpQMuqmRgDzByKnawZPAViT+kD4mZjABQqZVpEU4OVKt2RGQw=
X-Google-Smtp-Source: AGHT+IEZz3DaP8vDUiO7UYMRhD5/zIn2+KNYNHhCT2WPx1urmnhscLCNQt/r21FNScSTSxiCZ5ikxw==
X-Received: by 2002:a05:600c:224e:b0:420:fb99:ed02 with SMTP id 5b1f17b1804b1-421089b2283mr120556495e9.6.1716923028845;
        Tue, 28 May 2024 12:03:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:03:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:09 +0200
Subject: [PATCH v8 01/17] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-1-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5018;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Qkeb9YORIDfkvwkp+GlKEgMos9lOvfcfa7/lVVyOAJo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqMCQ/7vIZDzBIYID6EF7Nm5cHxYRr8KSj2h
 LnquCFgGt+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqjAAKCRARpy6gFHHX
 cihkD/0SSyWXBlx16ygZBVfA5mClNZjjlHCSb0a0oKurV28LhpE8Ywi7P/dafyU5VNjvLPsTGzW
 VzdDWjnAljTr21lVO2sU7RjDsL20cya9kwiFh9bWd8SKR3n9Wf9ZAkQQ2B3mEYrQB4HF8Jta66D
 orpfmCzzOusEyyX+NGHq+Bxwm0md4ba7VNzouizzBCZ1D9JIjQsXURxxKh99R/Mivhusckdlx9j
 sdsWzoHFCbb3rCRp2Jl9n9p5U0g5lN/cnoGZ0rVA8Jdz4/CY1Est956oKIYiIAV8Rp6Vv6a+UmT
 uw+oBs1iLjxTog/r4er2YKzTknHe/xlWf4/FCdAVac1Yno7ApdLLXtxP0YoCR89XeHC2VzErg2X
 ICz7ZGhPdo+47loMVwrA2XhI2GEmJkUjBmgCgXYHIc9KfrIl7bq5jGxD7f+q2eq14wQ52TLdaND
 +gf9RlbC7Y5f70cnBNG8JpWPPAVLIjgBCHRzAvenDd/TC8irL457L0WS1hGSo2tuY8u8XpbqO0n
 /QAJvHhTDNEDHUVs5vRIt1nugKXfzoay9uQ7jG4BpZODjQX46RbAfXtKpNYhw6XhojPhgfzVNeB
 3cG9Is1qrCw00o788jXSrT/CU8jTcynrBXEUa5fwLPOx3rd68LzGtTLTVGVs9GNN5HTYxkGaolj
 cjFiCfxfmEZHUQw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
are powered by the Power Management Unit (PMU) that takes inputs from the
host and provides LDO outputs. This document describes this module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml       | 151 +++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
new file mode 100644
index 000000000000..9d39ff9a75fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -0,0 +1,151 @@
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
+    description: GPIO line enabling the ATH11K WLAN module supplied by the PMU
+
+  bt-enable-gpios:
+    maxItems: 1
+    description: GPIO line enabling the ATH11K Bluetooth module supplied by the PMU
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
+  - regulators
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,qca6390-pmu
+    then:
+      required:
+        - vddaon-supply
+        - vddpmu-supply
+        - vddrfa0p95-supply
+        - vddrfa1p3-supply
+        - vddrfa1p9-supply
+        - vddpcie1p3-supply
+        - vddpcie1p9-supply
+        - vddio-supply
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
+            };
+
+            vreg_pmu_aon_0p59: ldo1 {
+                regulator-name = "vreg_pmu_aon_0p59";
+            };
+
+            vreg_pmu_wlcx_0p8: ldo2 {
+                regulator-name = "vreg_pmu_wlcx_0p8";
+            };
+
+            vreg_pmu_wlmx_0p85: ldo3 {
+                regulator-name = "vreg_pmu_wlmx_0p85";
+            };
+
+            vreg_pmu_btcmx_0p85: ldo4 {
+                regulator-name = "vreg_pmu_btcmx_0p85";
+            };
+
+            vreg_pmu_rfa_0p8: ldo5 {
+                regulator-name = "vreg_pmu_rfa_0p8";
+            };
+
+            vreg_pmu_rfa_1p2: ldo6 {
+                regulator-name = "vreg_pmu_rfa_1p2";
+            };
+
+            vreg_pmu_rfa_1p7: ldo7 {
+                regulator-name = "vreg_pmu_rfa_1p7";
+            };
+
+            vreg_pmu_pcie_0p9: ldo8 {
+                regulator-name = "vreg_pmu_pcie_0p9";
+            };
+
+            vreg_pmu_pcie_1p8: ldo9 {
+                regulator-name = "vreg_pmu_pcie_1p8";
+            };
+        };
+    };

-- 
2.43.0


