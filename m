Return-Path: <linux-pci+bounces-39662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF85C1BD12
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABCB95C0E05
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F080347BC0;
	Wed, 29 Oct 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zk+YGaOD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02F3451C9
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752470; cv=none; b=lKI0EYsfDjThkkMl6hrfRTCtgmPNet74OtgyR7y7qTFSbWUhqT2mt7/V7gys6tWrH1NbjTRo8VGANEEA7Sqd9zIFF/WUKyJNryzsZXiD1iq2bPzKmYjHtNJTX4I4Y2DxJxLQgKHsQbRpS/Co2lPAZ4M9Ax0sktEaSs2Ug29c/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752470; c=relaxed/simple;
	bh=gcObtR8O5ZMp1fMjuAEDOYmMY8vzvFQgHaemqAfEjN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0Ag0oBzR0IhDsq47kaeKcod35VOkTC9uofOCHaosDnuD9AS6/jWIF4e950mdXnm745wpIEYGQjFltU2aSX3Jk2AeEqtWcTevgZAQP1kc4/YTDPevWzkPQhnYDs3SbyPAtcsZt+sqAU3lcD0/a4vC+0ftxyLnxmtvo5cQ3Y/Zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zk+YGaOD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4270900c887so834853f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752465; x=1762357265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNRZvMLh19JYUSBdaaySWh/yUqTck826cyg9+QX0TII=;
        b=Zk+YGaODo5WErRkupFok9ypdEBU0iPKOCExjZtQImwCFQyxlY2aAagkLjHFFl0257b
         LcQnmPXMTNzsAr2oL5ci8qWySBFtpCxMGD+j0Vp8MQI+1fqjbY1TmNErPPhf/Xqm7kB/
         2C5QRCKL4XSRfrulBKVsA5QeSX6M+YnSUYX/VpHzbHihMuYEHl9kcByxPdcT0hHYWC72
         j05g3352+O32gdKYHKMOMBHTactjmMys6vJDi7XZLMJW4XU9JDp8GAIfDcV4kLtMAevb
         INlxXu+BRdZq3f2qiGzmsZ1UnDOgoU8B3ynqLsQ6790YOc1hxYi+tvMEOLSDgCVvSvLL
         CBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752465; x=1762357265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNRZvMLh19JYUSBdaaySWh/yUqTck826cyg9+QX0TII=;
        b=CvOXgg/T56SMT14cmBy7eEg+iBzL4ZNA4Mqy9b0Jd7hZQMjkRBKggt3rJwvGMCPza6
         /adlOlwqczSPH/AFGwnpiHva8sdMV3S5pYPBji6YzNi/peGln5OW5fVFKZJDOecQanFQ
         ib8L4nuSQLyU5joWVz0Hw6QF2QwuIZEanBgKaX1jvmxcvlQBUj+bh2m8u7U0fsdoKy4H
         sNCw7On2gDqK9rWlp2eWjLrSbc+qwzsVuDMmuYYi6K6k+aHqkAASQE6163TOoX0HOyay
         FT9O4ZJmn00cSQcp5shklgmL8s0ng5xSGnQqr8Xz2QNzvgNPVbH+pwne6xZyPyIsiKQo
         P6aw==
X-Forwarded-Encrypted: i=1; AJvYcCWysZ03DRDQRUaxLPLACptbp24QsXnXFgt4ESaaffVMHU5WpTnKw+Ygh4eRO0C8rzjAy2FDK6nQfH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylaM1KPAQhBOYHOPdydx3dSDSd4YgyIaIkp7gdV230hVJr+IlA
	AXmWMf20t9xfgMz/rYRNYWLVwPsWRJeS/1duUKUG6ywaUR+q63PK2mFSK4805TsOAv0=
X-Gm-Gg: ASbGncshZHYMGoFhwA78FqEDeep/92fUsDDnyaZoSkQvySunLER0IGpyCKzDpW5yNW9
	9f65D5JwNp8F5m7CRfnYj5trEjz4dvEaa+ZgPE1zWAfYTz8PHC6S4OKBnjT/twqnQxdHvEAQOJs
	q+mIRzQsV4/q3mN538froBRLbIC5duX+Mpa1TLmuw4/linqzOqw7AsLXwCSger02xcIeU0DBOK1
	XGpEZu77RQRoRqgC8SRY4H4xIQ4Cw4GLs1SL2Ct27b5HfQLYnCBX7EnUaitBf/xJLSK9AOuTz7D
	hiZKRLZCMck2KpzVESHVcszda9+U+uH6eADYm3p5ZeLBcORE8YpEOLGO9OvQuUU3zoiL/u1NDl1
	PI/fXWE9VjR3/85UvaDMFE0MVMPDUGfD6n5QOAPy4aZ0QcN4WGxS9aGtEpet0bnWHfCL7t6GhVd
	PW4uBJSJXAgzxbF54u
X-Google-Smtp-Source: AGHT+IEHcEqR1OdvqLT7eFSnCpgoJm/oJzx813KuGyGeIP7ewwn6rKls9lXlsuPVl0vgZ/Ia/84viw==
X-Received: by 2002:a05:6000:402b:b0:3f7:f02b:d7a with SMTP id ffacd0b85a97d-429aefc0267mr1328492f8f.5.1761752465432;
        Wed, 29 Oct 2025 08:41:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:43 +0100
Subject: [PATCH 6/9] dt-bindings: PCI: qcom,pcie-sm8350: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-6-da7ac2c477f4@linaro.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gcObtR8O5ZMp1fMjuAEDOYmMY8vzvFQgHaemqAfEjN0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWDrYP9a0vChuYXfR8Ab+MtJdkra9hCmwFbM
 hzimW88JWiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gwAKCRDBN2bmhouD
 1+uiD/9tc10crzvcSVVVTGJrGwZDo3ymggZeqB4dpQkQO9qW8TCegY4ChY4YPON2MO9QNcu/JnD
 U+QbXdTAEVo/TpjL92VL+0fsP5JpRNzvmv0FZwDekHwEp/9W3ux0TO0F3d+tOsufXVozh41LfTp
 1AhW8FuNoR9vpmDPd9dwGF3Y3HG8HAVAc1LzHkRDiEJ27YTRCoYQU6UlvlWIbYzuUo/uS9jm3dd
 duyOvzEoQ2nrpU2GnSVov78qUt6BGm677yXo0ewX4xvdp2lPRVZmnP36tdo411qH6BxjKp3OElL
 AsluU39AGhioV6p0GHUazID4dQRkYiqi+e/bQ1KAOioP0lbENtdaIuqs8CvHgPiZ5A9Az4IlksJ
 1vqOEddg71wF4yR0N5OMGwhi2whCJ7VBhdL1jcHBKrePUlj15T54U4mJ7NM0d6QQQ6FcDV9O5t1
 VUTlB+tWJDXxWAe5ULAxacFC20hWnCPVI2cJk1PKG1HOp96J1HISP+sBX/4qcTGAtpvlnZZVieQ
 g802C1XbIapQ3zMYCToGJMqdpHxm0u5I7Zwnbe2K3TOqSKXGWQYpVarZN2izM6s4kw/1JC7LIyq
 btx5E8eh/MUfCUF33cleNN/A5uAKloctJeXae/VKXehVKoLcl+qvslGBp5S3+twTaXnaNC2MUYX
 4VB8Ql1gQkJqL0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index dde3079adbb3..7106ff08da6c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -73,6 +73,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


