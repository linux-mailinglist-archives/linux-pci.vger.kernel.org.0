Return-Path: <linux-pci+bounces-39775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44DC1F1C5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAF34261A7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2345D33A027;
	Thu, 30 Oct 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPN2B2RW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC80335BAF
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814271; cv=none; b=a+uJ7PM+xoy2rfU4P6i9bYsC4eVP+RuBJ8MJVkjUiElQZgV9qIdetBWyd7zcP7nvgXvioO8Hb14uQ7en9kv3TJnWAgc89yFkiGlYxaDJr9B3AKx1flRvT8h8PRBE+UvF7C/p/oHjV9YwSU1/fo11yY6rRsdYCQ8oXwAgvUAeB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814271; c=relaxed/simple;
	bh=rpjdsC8YDAR4ce9DkX3G6WOQjqex1hTpcjV1pmb+6FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSVyrUMIRmwidiHdlbUba9ycSJqJwBSAGs5JrQDIBw9rGj77bsUcHBTVmiBidCAjtVoYncCW+zUm+VVmzFaNLkk2cWIvlIaPgUzHexI8CcpahSLldzB83TH+e2CEu02xpu1wzVAtI1D20AT+YdbvAbNE6lyZ8jvNnqkjto9sJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IPN2B2RW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b404a8be3f1so14273166b.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814267; x=1762419067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeZHkr4YD9H0TDPFAU8SBi/+IlGQLxtOdn7QyZP9pFg=;
        b=IPN2B2RWR1Du4Ggu02p+DhAOnm6HVqJo9XvTxmsFlRsCNJ0HrZMDsajeQ64I6KbkLC
         I9hFjp6sJ0axUhP/DYYt3xwQB0njuQ561eKeYVvKAK0S0hKgy/4Pejbneu7ZzZGw8s4s
         ahlJfJu4hWe3iHODptBoWNJN4XF9Sar2g7rosjLdZQg6LB+RBF/FpWlRYFHgtqr6b94e
         KKHgXQ6frtKmOtk19toapMyF7i7kMMccqc8FYn4HSVzV/HNJXRMQRcvXbIMTmZT3J2Lk
         0zc2W4DEBeP7yB5PHZXiWAvt3Gd+DaDsJQVQUtfvrKFAfDX7+rNo9nU1k/QNV/8S59MC
         rp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814267; x=1762419067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZHkr4YD9H0TDPFAU8SBi/+IlGQLxtOdn7QyZP9pFg=;
        b=Np6SnAEUh5KxS1GwGBOfTEj8UPwtKQlXgRCuOol3nRzTI864VofYSvahclH/UXABvv
         rkJi2eAh5JwHGavY4VoDg5lkuC80nxYfanDDZ97+zop1AO+ldY+Go+wr60cKjHOE+HmX
         jOl5BpcLCIrEJWWfSPQICq5Zr/PqnySMCA0PrXPiC6SRlXBXie5S1Kjf5pXmYglfgANW
         8wLK09qS66ljnIG0jo2Vwuo3cafLG8vH6H32J/jH9dsKBd0htaeNFwQOpABGW2+QsLPv
         LxMSAoIlRboiFxAeg0CZ5bJiC0vcvDYQuJXQSyxeFABclI1YTllOFzxPEmRBQvReZOfH
         05aw==
X-Forwarded-Encrypted: i=1; AJvYcCVYezayprTttY2Gcpxw9N8cvmJX7Od2vjAhVq8JB9fjjVO/3Czrs/jJa+5/BkOa2V6VBd/FOv33Jgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQ9jrmGu9+jO5pYdcuDiPqEQ4zBeECoj2acu6tPkPY2ginSlH
	6/Wx5cUBcPKP6HR8wFL/ZlS76RjmTc/nq738e0k8KR5IF/e03BnqSQ5fJJecYCL3vPk=
X-Gm-Gg: ASbGncsVoKWZnpRyKEt5ei0i5WToNB5j7T4TQ4fXff0VxXW8MG+GehfU4ra4SKptKXr
	EuxH/4+CJqsCqVI+YiGusOQPj7CdX1x9yFe2jYwtnAf9q+/PeqcitdyAhNc/UJk20PgBtbhT9EC
	si1tkSxkW4p3GcN4kVLveKxbzw7OEpTUKQNa2sK0RT0i+WNqOcd4Ii6iW5IDxHxi5QYbpCwGDXt
	NIgSnj7sDaI0grcn3JFbzmLi/eGCqKH6OZzMJDZT7GC3OuffEietqhUPzYBcX6b99ixcdxJBaNh
	XU0bTwiljuCZxMm+jg3I6pLM8x0du19RYv/0g9tg5K/QjAIl6Mi7qyZ6usGVsZlyXLmCvIiz7Kh
	Cb0n8eqp99kxW6IgSf4e2eqB+V4Ibn5iCN1CswvwO2VEUTYL6thJvjhlVG5vTkHb0tNf2+Mknry
	oBGM9lwAFzXL4luDL8
X-Google-Smtp-Source: AGHT+IGa2ZrCMJ941md/YaGSeVQ3cz4WZFg2TaBoGEFTfFX7GrykK6ynC7BBGxsj4Kqgr42s5r1Irg==
X-Received: by 2002:a17:907:7255:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b703d568818mr370592666b.9.1761814266546;
        Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:45 +0100
Subject: [PATCH v2 2/9] dt-bindings: PCI: qcom,pcie-sc7280: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-2-28c1f11599fe@linaro.org>
References: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
In-Reply-To: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rpjdsC8YDAR4ce9DkX3G6WOQjqex1hTpcjV1pmb+6FQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybvXntta9FsaICcpfmprRUQ8u2uaIde10GCc
 2STDIF0KwmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm7wAKCRDBN2bmhouD
 1xNYD/46QXqnYkaIGSMZZXc3CCIa5r8QA8x6uVCG8deex5AnM0Cv6cpu8/OLgT6PqgPjYdUpLIx
 j8LQodj1MeEEMOjmqZrIfAVq9/onEuPEfSGZMni7Ltf8uw82Wt4rqF11IHXiBg7hScSAop2VXIp
 8Tp8+8vacfoDLLdJ1iXu2dgZo/tjQW1IECcIBUSMd0lNsuH9TEnqrazOk/ZikVV5tOtnbVMdIwJ
 AM4rxtHheqEnH4Z1cXc8f5aivkuMOQ8JKwHvAMTOkh/QBoTiAV89LbkHyhZcPOvpwgAc08tA6L3
 MZxYoI2SEfhrJcX9ZfrElJxXpGeAavzw64nZji8uKYJAZm+4gZ7SpFjC1FsNhR+Hm2l1zausrYd
 MZmkPsRYjm7DfDGKa0/7rHhgcf9yemb5G0aQNd6ILASUDyeKWye/Te1/dGdVpJS0qx3gNuog5Er
 rtpsjVLum+hMgKJEL/rJTDsYLQWXjSwEtNlDbvVTSK/OOAkK5BP933vqZ34xFOz+xgcD5MNy+88
 wcnRGFsM1cT8lcFeDAbUPBG9FLGqKeg8nSo0vMMlD5jD+XTdiSISPeDcLUpCv8mVA6jhYyFuQOT
 9s38CAF9I04uf0KUzEUttomHR/5dJmu0X5GZN4iSZVTPfOYIjakMCgzsjJzsF395tQ50w9IMUmD
 u0VKS/Tz9oi7ViA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 4d0a91556603..f760807b5feb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -76,6 +76,11 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+  - resets
+  - reset-names
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


