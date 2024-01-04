Return-Path: <linux-pci+bounces-1672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DF82425C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31CD280CD9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34866250EA;
	Thu,  4 Jan 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i1fH9UTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0824B24
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336f2c88361so429147f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 05:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373333; x=1704978133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjubhM9aoU69uzCwJp4rB5H4DPxtKhGSNuyfkMH8Lnk=;
        b=i1fH9UTdejynp/wbaJS2KLYILgwYmbsa7NRCM3iJpWuOMnZncABvbv3F8YBK46xZZT
         U3X2und5/Gwz4PCDRlDiihQ02XgLZIjwU788KEs+dPPXeZdoM5MqPjP7D84AE/WKUtO0
         c36CITX8IkPdkPrGMce7UzAg70milTpZEO6bLR4OMJjZojI81boIxrInBIPGMQ5jJKm1
         02wHC70LNiJBZ7ULF2hz6U2Gq7ygHp1XXA8nzYeBcv6sNb9TZ83tU5zkXoKf0MWp5vCY
         aur/7ZeC7uQQ9I04WYr0ALo0sfnP0SQRkunCQLzJLW6/aT1G+NaxjS5Nr5g6e+YXPL9x
         VBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373333; x=1704978133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjubhM9aoU69uzCwJp4rB5H4DPxtKhGSNuyfkMH8Lnk=;
        b=gjJ+oQGOHaBx9MbzTe8gGFzlz7ElZMynNSrK3Yjc5Elkra+hu0Df4ULHrcJBM9vlzM
         TkYc8+clM4K+xv1LX0H1q1evPO3YDoVxo1zCbRrY+BBZ0PZbaISIf5kLZS4zEJMzGFYK
         E9PTaIxQLmF8GpzIqqfsRVArj1scVcNMEqzC8m6mNJW2iInu8P3THYxS/luMdLUCdDfW
         gRS97rTOir+0MSMSDEt5rZl84UMmAHpGdooagGVHKBluW1iOOlGwlMbEwYR4x2zFOuaL
         y6TW1dxYhrNfgzndclNLp/MmbGspeg6QobryuTYhHc6NlkBF3DmbvCm76roGBph7/pF2
         6Eiw==
X-Gm-Message-State: AOJu0YyaNhVH5xLpKwnOEaZDSwwnA9LQTXk1RnI74Vh3asAisTVRUVM/
	x3a6EguLW4O4wl8dzAKdYwIsZ4MfgEq3PA==
X-Google-Smtp-Source: AGHT+IFaPrn2+5L/iSvaHGDXgCK1xkrpwFHBcvyt0keh9Su0XYw0Bar2ua6Y0uTWwzoul73MoCE/cw==
X-Received: by 2002:a5d:530b:0:b0:333:2e15:632c with SMTP id e11-20020a5d530b000000b003332e15632cmr447162wrv.10.1704373333369;
        Thu, 04 Jan 2024 05:02:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:13 -0800 (PST)
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
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 7/9] dt-bindings: wireless: ath11k: describe QCA6390
Date: Thu,  4 Jan 2024 14:01:21 +0100
Message-Id: <20240104130123.37115-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240104130123.37115-1-brgl@bgdev.pl>
References: <20240104130123.37115-1-brgl@bgdev.pl>
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
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 817f02a8b481..f584c25f4276 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -16,6 +16,7 @@ description: |
 properties:
   compatible:
     enum:
+      - pci17cb,1101  # QCA6390
       - pci17cb,1103  # WCN6855
 
   reg:
@@ -27,6 +28,19 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  enable-gpios:
+    description: GPIO line enabling the ATH11K module when asserted.
+    maxItems: 1
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
 required:
   - compatible
   - reg
-- 
2.40.1


