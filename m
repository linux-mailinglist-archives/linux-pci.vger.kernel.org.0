Return-Path: <linux-pci+bounces-3634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233858586FC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC41B23E23
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3D14AD3B;
	Fri, 16 Feb 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2kjTrD8s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA414A0BE
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115605; cv=none; b=nQueZO26Yx3QebiMNBwDuWNqHdvMXed12Qmya9nAPr8Dcz0bc5fJnOIa7YoNa2+9SZnPZCNDdE/V/HuntYFxoRr720VhmJ7b2jD759gOcY/2PZC3vgK6emXVMzuB7xuvlhNKNze/bgYj/BPDl/VwmZt23w03OzAn1t5qgles938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115605; c=relaxed/simple;
	bh=QomsFZdvlO3Um/w6n0gLWUpVxNmjbstnoc/fUGr+uLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSGVOV8+MaxIcv9P8V6us0SiCirp0mH2GlAf/2RZOHDQ5xgT8N+nwEigFjMyqYUjufbzsAMqB/eR7/0ynhkMHvRGxCopJw0nz+4rep71dOIBAbmct972y/EmxqBmz3mYZIwpGFxBqVdzVQaqtCjzHOFTe8H5Og4jKvdy8zGN9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2kjTrD8s; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso30234461fa.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115600; x=1708720400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlPormlXa3l6k1Z+tnXCNjE2JFWbtT+cHvZXGY4tddg=;
        b=2kjTrD8sjG2dDsxTsb3CWRBw95iVtIqVD1oc12pXtMOO5LaZrocehbGPiH0vSi/jnh
         T5FpeFfgrhbYI4U5mJEArAoAc/0PBWDGKkyaJEq69Nf9thhkqyODPuk8fyxQGD9ujkQr
         c92570KgKYO8gnoECMRioEUHsnI6B+odhAM+MVxsMIXa4bcvNtPvtWFp87nYuhgmux9Y
         tQdfMynZNwtKl9LlbVcVQflgvIIx2YLGzKQMr/mbHQ93XfCMxUhFIG2o1FHdNoT87Agz
         +tIX27TpPmzAC67Vhkg04NtjAR0w5ZuPNVesO1KeD+iz4gT+aP+FtGGz7zm86pHgKYk5
         H4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115600; x=1708720400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlPormlXa3l6k1Z+tnXCNjE2JFWbtT+cHvZXGY4tddg=;
        b=KOqVqFMXror7SQfZB2PWzPzS9mjkB0QKvx4joG/slascbF84nvwTtVHHXzZyTpmo1N
         CbePLK1XniABzMafHta2PyZl+1R/99k4ck2dDGDgdAaJlaGfHxVoouNvJaGD2ZO0Z5s7
         XvkXHxkosgUEa/mNSh1wshXCkpD3BSR531OzP9N/Zxx1vUuty4NdS4dc67abpG6w835B
         43Ju5Bjm5iq52bKCKB+VAkYkLBirAyhTNX2GN6joyooBK0saP1JdNdQuL0kDlRifZHiP
         JMK794AOjpSAy6y/yEbdDtpI1ffy1nOOhNzRRPAKRyfgskFF+foKmDC8HcmhMx/e/iU2
         WUsw==
X-Forwarded-Encrypted: i=1; AJvYcCVhLMMRwwnG/4a2bEtioxJjK4RWRsWMOTMvglgrxyMV+45Czb3LhSKGIgkAFMg8q5+r1wI5kyrlWfUuSt/acPy/SHFJISz5q/lz
X-Gm-Message-State: AOJu0YxJrPRWFYMYtD8ueBfJEjz6oawM1Df3x5rNqVPvEjzs+2d2hyKK
	Rp/GVu7caxRCXBCz5JzTKJ8SAHcnU7ifMygdY5dqfw95wznDqQ0sBFyIMShyBFk=
X-Google-Smtp-Source: AGHT+IEkFURpgepPlDG+ueLwKqqzySZpTpb0gzgEBbEk7oxfGbiVn1m6Ly2ffglkki0hcfkMVZUFhg==
X-Received: by 2002:a2e:80da:0:b0:2d0:9fb2:2c79 with SMTP id r26-20020a2e80da000000b002d09fb22c79mr4506727ljg.3.1708115600369;
        Fri, 16 Feb 2024 12:33:20 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:19 -0800 (PST)
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
Subject: [PATCH v5 06/18] dt-bindings: new: wireless: describe the ath12k PCI module
Date: Fri, 16 Feb 2024 21:32:03 +0100
Message-Id: <20240216203215.40870-7-brgl@bgdev.pl>
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

Add device-tree bindings for the ATH12K module found in the WCN7850
package.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath12k-pci.yaml         | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
new file mode 100644
index 000000000000..063c576b99a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 Linaro Limited
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath12k wireless devices (PCIe)
+
+maintainers:
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description: |
+  Qualcomm Technologies IEEE 802.11ax PCIe devices
+
+properties:
+  compatible:
+    enum:
+      - pci17cb,1107  # WCN7850
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO line enabling the WLAN module
+
+  vdd-supply:
+    description: VDD supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddio1p2-supply:
+    description: VDD_IO_1P2 supply regulator handle
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vdddig-supply:
+    description: VDD_DIG supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p8-supply:
+    description: VDD_PCIE_1P8 supply regulator handle
+
+  clocks:
+    maxItems: 1
+    description:
+      Reference clock phandle
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - vddaon-supply
+  - vdddig-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            bus-range = <0x01 0xff>;
+
+            wifi@0 {
+                compatible = "pci17cb,1107";
+                reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&wlan_en>;
+
+                enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+
+                vdd-supply = <&vreg_s4i_0p85>;
+                vddio-supply = <&vreg_l15b_1p8>;
+                vddio1p2-supply = <&vreg_l3c_1p2>;
+                vddaon-supply = <&vreg_s2c_0p8>;
+                vdddig-supply = <&vreg_s3c_0p9>;
+                vddrfa1p2-supply = <&vreg_s1c_1p2>;
+                vddrfa1p8-supply = <&vreg_s6c_1p8>;
+
+                clocks = <&rpmhcc RPMH_RF_CLK1>;
+            };
+        };
+    };
-- 
2.40.1


