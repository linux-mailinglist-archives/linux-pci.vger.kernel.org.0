Return-Path: <linux-pci+bounces-21988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7E7A3F98D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E71F17E312
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07711E8850;
	Fri, 21 Feb 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoP0w3yG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934C1DED47
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153128; cv=none; b=INadwNUcwhEOMPiG/lbUlens96hb14n+6SSEs1QqDl9R0C/m3uhIu97Tb83rycTP6PY2UVbTCiBKlEAlyh9t1J606qN+EiD8RJSpkxOVV5binUcTBru9N02RK0mRvSGFo5EF5Hb4vXQSAK20JsxYwhzqkM60Y4Rq3GLBtnpORIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153128; c=relaxed/simple;
	bh=LSOha9ZV5t2cPvEWY5zoP+XX5KPDQlxYOyHJF+qbokY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAbECFvrnNtPzjk89HEHB3QU18a42TbOjIET5Ag1oH/vZ76zSM0zGS4T2oPRUhcV4FMCWz/8gg9K8lbyCLj0Gl/lyrNKODr0ApyP3qy1bXbwO2mhqJn1ZwJvTr0WPjX8LTmPsNcOhwt6nKU1SjjbHNrJhCFo7tRqgbnQwh0CBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LoP0w3yG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54622829175so2046412e87.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 07:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153125; x=1740757925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ct0FcLLZ1SMiYaNJd1QrfYKujHVobHJNoSYSOTYQf5U=;
        b=LoP0w3yGJLIdeMO3vnjo6wAaHgxFe6zxfSXoad5dTJ5tIEbGDxfkc7YuIPdKzJL/EW
         6DWur2RLBOUv3haGyK1kvYspfCue4VfNsqVjfSGX42n4ogdJOUPTVqWEIPF5TB0W86ZL
         yjsFmExVG9W++ABqCW9SwFdokPIUrnmw2qRSa+kLrLR7WHka8vz9qcGz9dstWUPd0mpq
         p4kVkExXRJudXeRP0TPLzCy1/6EmCr6eU9KeRNYi4uExEe9ooAz6kejdP+dCbYgv9pEW
         j0ljDL5JfNvsIoRr+aP2cL0GR2OS/nejhvxEkNpv8c8MhdPye7RqJUNf5F2oMQcTXBNj
         r25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153125; x=1740757925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct0FcLLZ1SMiYaNJd1QrfYKujHVobHJNoSYSOTYQf5U=;
        b=ZYDnCJ0ZDRXjsbBflrleSchsh6bWkR1L9AIlsQHNc0/dC3frqRHb7sptALyy5aQ2dK
         NSni94Nfk9LQJI9ZpIf6CYqX+RiP9xcnJFIHSXb3qNVGU/uiRpVYEEf9WncwPljRGfV4
         lRDHjvA7zVI3Mzy1vCjE/V9UpGmime+o2Yinvo+p8fKNpWggP1e4RfoVv2nUR0aSrG0u
         mCF7+vtBqVhH/SWwF1nVvzuYfPRuMGYtzApZxjCKmA8PlvSaYV4P/qmzkVjqKts5/SpO
         xY+cwA7VctJ9Ov2jBFMKEqhDyaROqOgcw0aMHis6edYaWkpkrzG7xiLIWPbPSVHUae1/
         26eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLLRiTusjf8Ho5H2qaRXDSE3a8NVeKtG5c9WzR5wZvx/zjKmqpUzPZlYI1VsCWw4gtNfFlfjz+9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRPHh5f2vHJAG7vG4RPRMRbEjEDD2JqZzmjvt0LfBc45qu2iy
	dGJGxxSTFYZfXcSfMI37aQGUb2GahEVIoNH8+U6Y6fWskZH90p6HKlrRTLQl7KQ=
X-Gm-Gg: ASbGncuIlCD7XFrpzmMT33QiScHujGWi6jnw8k7BJ1ic+zocexIVagK2EaJkuf9TwfD
	ZYV2NsoVtDDhjeCCun9tqcQFB3m4DuzHj9y8fQ8pu7Tf6yhGBR2CUpdhniTripVwWK4waCwC9mL
	4XMn5Tal67jbWWSKZjTKTxbLO3I1U7YcUzqgk80exf3bSmV8WguLf8LWzWWpLry6NvjdnlgYM+9
	s3D6ooWnBZuy3qRgHKP0IyuQvsmLYy4z0iObZ54Sj/uf3aUREEiakl62BD4cqemdnBbvCdAKs3w
	GsWUwjjKmu8AvqohqBR8xTdCVczp5hQgNcMX9moDavU+o/JQBATf8ON6P9kjNo/QbZBVXg==
X-Google-Smtp-Source: AGHT+IEBXDAkrh9n7HUy4NVKLpY8bn4ytIZDi66BSMlzCV03umj1H2D7ZK1HxM5gblkQ8xBNgvVD6w==
X-Received: by 2002:a05:6512:1189:b0:545:10cf:3468 with SMTP id 2adb3069b0e04-548392685a7mr1437238e87.37.1740153125026;
        Fri, 21 Feb 2025 07:52:05 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:51:59 +0200
Subject: [PATCH v3 1/8] dt-bindings: PCI: qcom-ep: describe optional
 dma-coherent property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-1-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LSOha9ZV5t2cPvEWY5zoP+XX5KPDQlxYOyHJF+qbokY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEgKeB0T1pyKUNWhuwuUKapjBjzqhB3Vp1WZ
 rsWxcuGuIqJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIAAKCRAU23LtvoBl
 uOUID/sGQ5IGEMG4DmSC3qz4rlAZ5tvxBI74ZW9hbPLvYSXJJ2lQFw9OuMOHXYVgKSIvdzQe8Aq
 0iesSjOKwaC/EsmedBjjgsamuN7lQ2sRMTGEQnQGbPd/Jb2sdIj5nt8WHxI+6XWS1iQss3h01hg
 oFLtkK3t/tAxdPAP2Jiyi1rNqdHpBNEhntcoQDLxad5yKA5tiCuUDaN2AgpmvUvgpp9c+tISyvk
 Dgk/T3Ju0a4asRfCgx0djLqXbPE73Tj4xEv3f5yQMMcn8g0QcAYCprgn1VrygX8Xe3iWxZNlMuD
 oHzKVBtSesNqG5arLbme5XAzy26ZYHsxrllGtPOj37E49EsJ0WFd4UYcdb+kg7vlN1lr3xZsjFf
 0q+MNoLiIn1fl45BH7KBmgLg/pkiRqgmi/NWvPWcolsCcUT4RhM8g1O4ycDQ+c2GeTu4H0Mz5uO
 g/orN4E6n/uMnNfDYy04MYHOVLM1YIe81tRB/h4jt0+n8nFKDhViAjUArQiGN7by9aMp0jcBUhc
 tKA2dQcDRkUcAhJcMdvzTegeGw/9WPU2Axng1iLlRrDhjr5Kai51+UVB9S0y7bGp3yXz6DyDVov
 PuQAuxEpMhQyySzVj8hgx7OIdV3jxwi2l077D7TEUDB1cPVYW/0W9TIeS5ngzOERlsolYzzsNWz
 WGq0SOW44n9aC1g==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Qualcomm SA8775P supports cache coherency on the PCIe EP controller.
Allow 'dma-coherent' property to be used for this device. This fixes
a part of the following error (the second part is fixed in the next
commit):

pcie-ep@1c10000: Unevaluated properties are not allowed ('dma-coherent', 'iommus' were unexpected)

Fixes: 4b220c6fa9f3 ("arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 1226ee5d08d1ae909b07b0d78014618c4c74e9a8..0c2ca4cfa3b190b3fb204f0d7142370734fb3534 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -91,6 +91,8 @@ properties:
       - const: pcie-mem
       - const: cpu-pcie
 
+  dma-coherent: true
+
   resets:
     maxItems: 1
 

-- 
2.39.5


