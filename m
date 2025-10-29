Return-Path: <linux-pci+bounces-39656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF75C1C5B1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2835E642D7F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F9338F54;
	Wed, 29 Oct 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psXYPhMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD432E22BD
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752460; cv=none; b=BAANZXmSktOitKJoLqi03d764wGmN5Eo0DV9GbhrMUSctw8BRA2gPfEh6fVkpZOujqHkTcmJOjOt3kiGRgsvdvkPoytk+2h4qLG0ELHAunzsGc5j5kkOs40WfM4vI+eGJqhwnCdUuNDJ5aj8PH+Rt1y+CBNhU37+pbPEeiqaKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752460; c=relaxed/simple;
	bh=XZh7Co6zslMBQjbIXCr9v5B3gCRv9boi3KNiCtrOq7M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TMt9G329wrOi2MM2IOijzl7LSm9+vtW9MPxRdN0g/2RSlMLvmQGhIfqUxJmx/znmUSSynpiV2RtZ3u6X8hc+DHtnXfO+7kiNjrh1VkPYox8OByLEGmHxyCEGMek5Fl01+IhV7kl0+N2kfla/0FthZi90H0S7lMCyT5kRmx6uVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psXYPhMk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so888253f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752457; x=1762357257; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDt91SNIDyuEo7g1pxTkmePyL8nY5ebc1O1twS6LBZ4=;
        b=psXYPhMkUm5AETXhX3qqViCknno+TxnmOPaOsQKdBsoy0gXVW1G9PYXh8GesS1NqdB
         E8a4BzC9RwBdsng4jmXlewiadSTA+rmg9Bs0HrxXAHWOA2pGNO7z9JeQLRoXjsOZIcTO
         GHcWPdtNO2cijUIcJMdLv60SGhyF0OiiNyycf4zVtzP7/JERigZJSTrllfCSFQbN7spm
         AyghfSdJoGR+fV1pT+E4E669B8BdbQFhVtJGx4OB43RAdcCSy/Rygbgflw4JZQewuutU
         hlF6iFH31p+HonIxeWYQhFTn/SrV0qUfKodCw3oaeSz0d/KOloeX6jvclA2aWkGpLAjH
         CQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752457; x=1762357257;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDt91SNIDyuEo7g1pxTkmePyL8nY5ebc1O1twS6LBZ4=;
        b=MFmoCwcH3W3WaisqQL3lNm0dcL7HW9w/2hYHFwZwA4lgt95DPbJsm7CHq1WqcAZyaV
         P31c36I7yMnC9J9mz9GAs4zlwY8o/CcyRHJTTegJjuaPzOojP9q93zsAJ2c+7hox7pKF
         ODBqWHscnoCKKUO4B6Xs8Bg3x/lpDWf21CZ5DeSpRhYPmS6ypJ9Q9LfBgQraDmE355c1
         VB1a4s2fI+uQPJxjDkOLLe/3sySOARZvW+Hb8sb2QyVn7QJ11TCbMAJP8SNAjT5hof4b
         iwnCAFAHUnKU905+s3sTmDfyNE2yXF4a62bGyKCB9v9SHQ9K4RWeNUuUWHBfF0Zb+J+M
         jejA==
X-Forwarded-Encrypted: i=1; AJvYcCXGkK4r9ohlaxjma9L0hc/ZeJXEyoXbwHiKOrKxq/mricULfLP+3fmc0CnVEHEqYklvGsZ2bEY8crE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEnpoeGUz3u6c9JZXv19fYSQ/5Bwf3swbKBndzc12PYCbqG0z7
	Ml/42nPIz7Y0m78yC0LTmVMD5kzHC77++oHxmZtisl/5EDU2S61uDcYg3BD7WCW6Qko=
X-Gm-Gg: ASbGnct6IdBy1wTx5iczrSOTrrPbqW/udV2MX+USzaeTAvbu63wdLc2fFyqaWXR5u6u
	2T47ec2BMc5JQNbiFqfU1PzVKoMfqVGxUcOAf28HiYgA9HzYaw6DJTj/pkF8BFpoKJ2YcYmJ+oV
	slclVIfiHp3WsBzWcChN0NcOHWjfmMtvFW6fiLTkhk5B3nBlf2V+RYltYkYQV9QzWBHBr9vZOhm
	gG1QKVV+CO00MZbkpht/cC2lwD0m7jWfG2o0YrGXY/TSKoZfU1iCMNZI4AS498jHgT0D3fWLzUi
	CQ0cvO8jMedqGWfEsPoFUGxxxEXyjGSrxm/Bg3vNiHkhejNJGL+cQCb/E0ESkrTCPyPcDbtJVMW
	ezDcGmArH5I6m+ZcztF2BlkGreAiQCmyIpR9A+RwwLOYpHHrtiLpbQOb59vHHpZJ06C+/URWHkj
	WfmBju8SRL7ywHO7KC
X-Google-Smtp-Source: AGHT+IHfW4idvTSP2Ah3w6TfkGF/17Rr24+yasDsIjDvlkJDa3pwbq9RzRK1P0QDGji5PJoM5iNpwA==
X-Received: by 2002:a5d:64c7:0:b0:3f3:3c88:5071 with SMTP id ffacd0b85a97d-429aef802dbmr1640035f8f.4.1761752456995;
        Wed, 29 Oct 2025 08:40:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:40:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/9] dt-bindings: PCI: qcom: Add missing required
 power-domains
Date: Wed, 29 Oct 2025 16:40:37 +0100
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHU1AmkC/x3MQQqDQAxA0atI1g1oigP2KqWLcSZqFmbspLQF8
 e4Glw8+fwfjKmzwaHao/BWToo7u1kBaos6Mkt1ALfVdSwPmD46iWXQ23JLgO5UVJ/mzs/y4Yi5
 rFDW8hxjCMBJTT+C7rfKV+e35Oo4Td6w/QHoAAAA=
X-Change-ID: 20251029-dt-bindings-pci-qcom-fixes-power-domains-36a669b2e252
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XZh7Co6zslMBQjbIXCr9v5B3gCRv9boi3KNiCtrOq7M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjV8+rRwsh6mtOgt9cwnJyDBWBR90T9DNg1e/
 fAEZX9j8aCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1fAAKCRDBN2bmhouD
 1wxlD/0eFmxwUES2BznztM3ZTBcUo2UEJN5PYuTkJgH8y0sWSON51yeBBxwTK3SEA4IYe+HiQTQ
 i7Ms7eOUIjsmTT4/8qYW6bt/BCR7ZLULzMzNpfrtLfWJzqZCGzoj1fN8sPINtmo1XiO8V3ks4Fd
 jUB6qp1ldl0MXpWwLJzs3ck8JP6GueflzYZGH2Tq/IRLWLpTtIgkwL3Bi1qNcFZMeglCtBWBGkQ
 eoU18LISRmP+hWNrjaqKs3aA5Dw+YJtfouNyEdcvTmqtDviwV7rv/0H5oLQfARllF+2Gf0/Trnw
 PNjCqQSHtscaKZ9E5MJvCzjkcIZ+BoMq2A7GovFhWcLoMOdrfEBVA/+ROS+e3SJnAHYr/rwsqpu
 xNQfCzkurb2KyIYNwgsQKOrzJtEnbmN2ozK7k692z4hBWDv2c73DRNxPSmplr8i3AucNs38EZuB
 +WXhq7A/96rRaOFHAqCcegRt37R21Nn4YYmlVVbLgmyNhkYB8wHluSrZhqCLuV+jhuL9yapwWN6
 EQImQRMwkuyj28c+42uISguJX/Fr6tl9LBZ3dn4NAo37lKzfm0Tw519lZizr+e/jkL13elDA0+2
 I6VmNbLlSk88QQxlXXo1KF8r7FrRfrFKbh1WYryLK7xTHr3Zc+6iqI3BDcBl9KvI8S0yIUbUQ+k
 uToJGQdKF9rcLSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Recent binding changes forgot to make power-domains required.

I am not updating SC8180xp because it will be fixed other way in my next
patchset.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (9):
      dt-bindings: PCI: qcom,pcie-sa8775p: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains

 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 1 +
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 1 +
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 +++
 9 files changed, 23 insertions(+)
---
base-commit: 326bbf6e2b1ce8d1e6166cce2ca414aa241c382f
change-id: 20251029-dt-bindings-pci-qcom-fixes-power-domains-36a669b2e252

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


