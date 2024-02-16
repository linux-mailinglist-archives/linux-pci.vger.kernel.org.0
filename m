Return-Path: <linux-pci+bounces-3632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18978586E7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77252285068
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE914901A;
	Fri, 16 Feb 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pw8lpZRn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C51487DD
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115601; cv=none; b=Lz3PmJuHqDrvaFkHZVoDci1t865zxphbdv9WEL6EBHy2Qi59aXw+bUGyEHa598VtqCNGxovfV4a6VQm/3iTAOCDRg299KifCqbpM4bRQJdTpyXaJhGwDy/4e+GKa/il5EE+7dR10DLZjlUnYukAc65nmRjyS6SrE6BLiH3Iwryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115601; c=relaxed/simple;
	bh=4LhLqDvGFT+IFCIuC4QIrfBunrKDwXswnSE7spSs1og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGXUbS1aaOMQtbtwHOhKaDLox7Qubw/cEWT9dZIuWrnno+rxBVZ1rPp4fvJRMCf43K7chJKqPJfTrMtijVmTErtvVKCB1Xdba2i0epcgR96xikMOlPC9BXacMvzoyFuyBNpHP6etbxsp7adcAkVugaPELJGKKVxwvAO8nIIwIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pw8lpZRn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d11d17dddeso16106301fa.3
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115597; x=1708720397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC1pu2stpbN83NTwAu2tyUDsfSSkKlZ+7hcnIJ0S5bk=;
        b=pw8lpZRn9/vsWZaABII0+DvViHbRjQuPwgLb4i/WqjXSHfa+GQL9WfkQm2XwOqrj0T
         GgdQaumG3DKydg4bv2YIWQ8DAmwCPQF0Id8uxPCSEMJedRMKpx3RxsIAMQ6tN1ae2qvI
         D2D0o7vb0bRHjGZSY6USu9vvbc8cKt05nC3L3FfK6STwd8GsqxUbPidtj7TA7VxbNmET
         EHfo18kb0Si1z/F0xUrdzARIVWWY7FZ9wjAnfB7ibIP7WJc1tZ6h9POam9qgL/6A7YsS
         TaXO73fSKrUMelRH2EDx7SbMwFinYm4Emmni39o3pSPCUmZsPjSPEPLEJA3dp5BxJU9R
         xGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115597; x=1708720397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC1pu2stpbN83NTwAu2tyUDsfSSkKlZ+7hcnIJ0S5bk=;
        b=VHQUUi4AJU3PYuDkiPg7n+iH3otmqrb47ONxuAl5Lorc1juTqz+iZvojBkGJEhwVMp
         GIUS2Ks6YH/SACkM4VVVNYdE1w7VSRB155PE+xPDTc1fOTrp6SkLSJmIYOf3cYRrbKjc
         y/yv7wkzjxN7O5UJE1SiWuwWbOspY6bjZ4AVT9W/SxFmichw5kD0vPi0Q4Rx5pNnkEXg
         4oS7b6lY4O2uXOmtVv7FmnW7nN18ZNuuVq5CRhKlF6XGCA4DwvR285VIAkON9HRyKDFU
         16R2HhsunHcKPD2Z5VGiGNZUbRKs8GfrGCiaV6gPCQDr7YfzKuRCOFLGnoLSLIhQtr1X
         zJjw==
X-Forwarded-Encrypted: i=1; AJvYcCWwOT5elzkB6EtgFR0L6JhWgQcO/3YJW9sSy8H90uF0BLQx2zvuUB1xI/2p7HncUhnr0I1eifKcLlR/1IoqZLUpDPFc0KSsGf2m
X-Gm-Message-State: AOJu0Yy4s6jy9joSTeKEPg7HpgO3awQ+C928z+axcFuimL+kYzYu0Xp8
	veZUtTh7SeQoLx43mloDcQksYTTf1VnINWvufCWGkh2TQaeRl2CJzqGZe6yO+r4=
X-Google-Smtp-Source: AGHT+IEodiKrpQa3Lrik26TTHjpOXpZBll1rH3wk3i2Jrykp7F0GsM6rUA/Fp5cYuEYiOGeqkA/RiQ==
X-Received: by 2002:a2e:9b8d:0:b0:2d0:85dc:bf9b with SMTP id z13-20020a2e9b8d000000b002d085dcbf9bmr4383652lji.14.1708115597122;
        Fri, 16 Feb 2024 12:33:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:16 -0800 (PST)
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
Subject: [PATCH v5 04/18] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
Date: Fri, 16 Feb 2024 21:32:01 +0100
Message-Id: <20240216203215.40870-5-brgl@bgdev.pl>
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

QCA6390 has a compatible listed in the bindings but is missing the
regulators description. Add the missing supply property and list the
required ones in the allOf section.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/bluetooth/qualcomm-bluetooth.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..702d04cdb247 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -62,6 +62,9 @@ properties:
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
+
   vddbtcxmx-supply:
     description: VDD_BT_CXMX supply regulator handle
 
@@ -180,6 +183,20 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p9-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qca6390-bt
+    then:
+      required:
+        - vddrfacmn-supply
+        - vddaon-supply
+        - vddbtcmx-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
 
 examples:
   - |
-- 
2.40.1


