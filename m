Return-Path: <linux-pci+bounces-2289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65A6830A9A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 17:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A03B25A0E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29F250ED;
	Wed, 17 Jan 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AGM2kIWV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D424A1D
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507721; cv=none; b=MDBHFQyzM1q26hPuLC4bt08EJTsg3lryjheeY6vZSCsp4IEwryZUwIdqzuo4aDbk6ukRHbpqW+pMxWArRiPCzfL5oQB5KMKpJAv0T8C4qoK2QwzlyiLtDb4HL8VQq4oFGKpOy4EB9SIUb8eZ4e1X/70jJdudBiWK+TAkaPsiG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507721; c=relaxed/simple;
	bh=RmzggMuqX9S2sYKlWB5CTnSQ2ymEjp/UGoryY82oivE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=fe0/Xtd4+FhIR5ZV0YyJNdnn335Bbhw6vgFtxYfuKGY1H84VcfQoc6/LLrChalpU5IuuyYkxS8oz+W6nScMdn4edJr/BL04fMtlKxqk6j5/dpaYYgIDPNuw7JEvNieUqZ9Z6bmhPWm01BEp1pysqeSsVvBsqu7eY3zCW6DOf0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AGM2kIWV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33694bf8835so8504347f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705507718; x=1706112518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFu9yLDki9n8hZLDYiMoEZqERou6Z5NMTUbYakLpe9U=;
        b=AGM2kIWV9zkOgZm5YdSDtl353IyCrexsWyLpNaXizZKE1vpFt97Qfc4DrQRl9hU1Wd
         mgAKFdFP+XNpCd3yO/9zCnMhGtFd1W6LpYv74cpZt69+8gkYyytY4opyZwKakh1StNJI
         BzC54uf2s/M5c4GpDss8XRaJWGVHf9sWRUzo+bGB77SXHsSmarFarYVs0mRIbo3eXcO2
         Hd7SFbeoWvCTrqocktxS3WJnwXnH+URCh/zDs2U+Y496tg9Xwn8UDMZhryoCx34WUG7h
         gSPjFe/yzFdihgETy1lqiRFeajWvRATHNZ3hFLklSG/n0iG16kPaRhO4ffS5N3noL4YN
         rI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507718; x=1706112518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFu9yLDki9n8hZLDYiMoEZqERou6Z5NMTUbYakLpe9U=;
        b=YHmY0YHQgZzy+lh+jFAnygw6afR3Afyt870mQeb/15sLXE8AtxjrAqEtDsQE63ZAPt
         ygTUGCRHEIQC0j86FNPYPIp3BPvMJdiMZTBY9ABpsKwOp+tqH/ztlhBxBTG9dnK9UItW
         VCkK9gLiEX1lEtVSlcLudyBobSRmhuwS1JBFYrJfW63Q9OX1007QEWGcAdMho+NsotYe
         5Z8jOY3UdkkEZuP6YKxlZizKQPT5a2zpz5h3Nwecr2c1VbQo3U8vjgUxUo9Z9q8Gzkzg
         meyWmplNP7TNqJUhGcD0BraZFHmqhmDoDC3h/UF0DmwSSxv2Jdm2EKZwoNNf81ynx6+I
         pG/w==
X-Gm-Message-State: AOJu0Yx62zsZfvJ8mKU6s1hml4xlwf4a0bq2dtFD/AzYTC+ienq6CyZg
	mp4/m0e4FLBHU6nUd3+I9Vfr+OZR/Fjntw==
X-Google-Smtp-Source: AGHT+IEmgi0LRLiPs2g64YkCGg5BMB/9EVVczXYVKQC5N4pf2ch45rIJoaEV0jPaB90LK0yrggei2g==
X-Received: by 2002:a05:6000:1445:b0:337:c4d5:ce70 with SMTP id v5-20020a056000144500b00337c4d5ce70mr662501wrx.137.1705507717858;
        Wed, 17 Jan 2024 08:08:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0b5:43ec:48:baad])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1972092wrw.57.2024.01.17.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:08:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 7/9] dt-bindings: wireless: ath11k: describe QCA6390
Date: Wed, 17 Jan 2024 17:07:46 +0100
Message-Id: <20240117160748.37682-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
References: <20240117160748.37682-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the ath11k variant present on the QCA6390 module.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/wireless/qcom,ath11k-pci.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 817f02a8b481..c8ec9d313d93 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
 
   reg:
@@ -27,10 +28,57 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  enable-gpios:
+    description: GPIO line enabling the ATH11K module when asserted.
+    maxItems: 1
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddpmu-supply:
+    description: VDD_PMU supply regulator handle
+
+  vddpcie1-supply:
+    description: VDD_PCIE1 supply regulator handle
+
+  vddpcie2-supply:
+    description: VDD_PCIE2 supply regulator handle
+
+  vddrfa1-supply:
+    description: VDD_RFA1 supply regulator handle
+
+  vddrfa2-supply:
+    description: VDD_RFA2 supply regulator handle
+
+  vddrfa3-supply:
+    description: VDD_RFA3 supply regulator handle
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci17cb,1103
+    then:
+      properties:
+        enable-gpios: false
+        vddio-supply: false
+        vddaon-supply: false
+        vddpmu-supply: false
+        vddrfa1-supply: false
+        vddrfa2-supply: false
+        vddrfa3-supply: false
+        vddpcie1-supply: false
+        vddpcie2-supply: false
+
 additionalProperties: false
 
 examples:
-- 
2.40.1


