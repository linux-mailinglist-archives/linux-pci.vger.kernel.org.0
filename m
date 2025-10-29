Return-Path: <linux-pci+bounces-39665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40762C1BF01
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC76E37F4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636634B42B;
	Wed, 29 Oct 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAF42/R9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA43491C7
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752476; cv=none; b=S9BfB8R+maN/rPmM4CvJeI8s5QsSGpZAxigu1ECh0u+AJ8ZEmjTzmqAw9Tp7xtL07zQ+O1iSIllnnozBKwP38xERUFGkLCpUM7hzsbg7emmk9Pl1e73kELJMM0HslBQjjtKs4CF/jcuNUwu4bQ5lB/ZxoKLIUpey7g6oDzZ0ZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752476; c=relaxed/simple;
	bh=E7zm8LMUS4vFyvqJmFvBbABlKzv6uaKHgJ+Ct/P6Zvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvvU7NXeJxhRxaJivp0LxNShrBPNV67E3HQAvgC9yPl8yMuU4TYKE5YLegMwg7NjkrZFeLvxgbJfZYwYSnT2JUlF6vUXuPvE7XraUqx0kUT6RJ8PH7vUbxrx50ql6WWQJ3chD2qyOhUdkQ47ekw757vHoWCb8mwnIQq9dmfP+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PAF42/R9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-472cbd003feso5739285e9.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752471; x=1762357271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQYPWoWkhW3jZedodS9/BAUyUvxIUEKkb3KJ3ANSZ4o=;
        b=PAF42/R9ufiKOeI95Zbn8T8wQALcQ85nEBGTd8GxeOv/YuiYAtW1/lESqCy9G7f91l
         QTWSA9ELgzTsR88wrES8wBwughqy8Twh53CebPNhkl9oSled2L+UQxEMLIXqCivjN475
         u7DvjuUhlT8+aoF5c4JN/+yleozA0q0j1DXB+LAacpMcmWSzI7DlGM+xu0+Jw4ibpDG7
         zZe4GJg/UCDGA5PMDELrd4+H/OZ/qJG4MNIHr59DfnzXuNRCHt5p/fMgQC+/d0ft1uj8
         ILs7dyXq4ns3wBgKEtNqpOUyAm0xAb/J2k6g8L27/NQrdM9u8RR5UtUenctw/satIfP6
         gpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752471; x=1762357271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQYPWoWkhW3jZedodS9/BAUyUvxIUEKkb3KJ3ANSZ4o=;
        b=ZhdOuv5c8d1tVBcZg+Psel0v3q+rko6tDO2143nImAO79WJYlKcXE3h1soWIXdKy9Q
         PLJD2i/Xs+cb0Mn/43sBxrA4tR8ufYL3bCBXc9Q+Y7oxAHxUBnk6KP/WQ0k+wTikMl9V
         3dHJxmIMilu9tQlPpIF6GV7oobh004+SclUJo6rw8TCHfqkjW1oXiYbwnM69ZKZSHLJD
         vpBNYQxoWWcor4dcHYkjn9SMbIQ8w2W71J61hXIkQHtUH4UJc+j5MZL8jQhGsIm9rzPZ
         XAkQHu8shH4JAbKznco4qB19HY7tDaDx2+JD3XN8EbqNciVxCYDRJs6WZb+Gh53v6Tt5
         JSOg==
X-Forwarded-Encrypted: i=1; AJvYcCWo1lYfYJoLk95tqZjlcEoyVdy/QqdHLUD2a8nyzAYL04whmfom0hKfEf8uZBPtbf1rzPVS1AV0Eik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJLqdJolREgzLFBYP08z0/TXNZRjP8CaDygcY0ljWjvODg6wE
	S+Lv1+upRDHDpiANSRvhLGAw4CLw+W/7XMTRUUNGHMbxZWKvDNyv7i6GI+nShMKSv/A=
X-Gm-Gg: ASbGnctplkEim2kNigrqCN9mcNuv7z6lN7uEN25ga27AttZ6TTz9M3Lk+GsbdqZDN2U
	ImuU7nCblKxcGx8wuatt6dAnf0213LGRXzHhLLJIfx3kxUUxIuIz8Wz0mpHN0wx4GdJJTz27iaN
	3ThAXj89K8FYEC7mX91cc+KbWU4SPd5Oe5DyZxmVxMykEV5lbaZr8u5Jd4w36vuUQOV09d0BmcE
	7pWkebvCW9KmgzyjvfAQh+TlhBVcUt7cUw40/Ggjh/LNsdWDJO9OeMTHedKfFcnuVGpGE8xhRFM
	4M4zQljRpqYhUMRiUs/WMZ579Uq1pDZNiHCuTyxdo+p+sMRW3kkGRdI02ECZUvbC+kUsn8CELkP
	TJcbDVwVQx+18+4UddE+/u/SjTIFellCUvorljOBhUQqZry07h+L9LPyu/rQodBJOf/CGZPmIEN
	WgHHf3dArEvLHgQVY3
X-Google-Smtp-Source: AGHT+IGxW3odD9bKs2JH0UPH/rsbekE2UxHroNcnfod1SMd4HhITjZ3xfahpFYg85ZGnnq00ntsjJg==
X-Received: by 2002:a05:600c:5251:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4771e1e3c66mr18069325e9.5.1761752470575;
        Wed, 29 Oct 2025 08:41:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:46 +0100
Subject: [PATCH 9/9] dt-bindings: PCI: qcom,pcie-x1e80100: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-9-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=E7zm8LMUS4vFyvqJmFvBbABlKzv6uaKHgJ+Ct/P6Zvw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWGxi8GSE6oS/W3aIZpLT+jPqgq6MLYpuwko
 bOSOWzIEpyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1hgAKCRDBN2bmhouD
 1xfED/4luD7q1dM8zsxzQlOn4BPacWjc9sRfxc1vkX8XrU1KLXlgOkbYi39rm8cRf1A0ksFa/jy
 Cu7YB5cbq1iRttjeW+osqs6tLSTm9Ut6IT86VQelkVbXzpHuZ0F1qEFIoTXG53W6MQQdBmehr5q
 qg3USdiGZlRfMRGnZGd3OJfCmCBvQxktzWnbm2Cn9qMfArW+MZjZaM+2FlVQdipnBJSYotgNJQv
 v0WfEaLhG140GruTHcj6+pSVdIN/ylBdbRKOvgOYuc9pU7BKloIOJE/vdqtQZfBOPt5ZR8zBm+1
 lTT5TKqhTMz4+7ODUq3XR4zU6qjvoKroDMFe66zTTZL45MdCYlFpoC2bGqP8qYh60QozMlVva4s
 Tq0porbp+9MOtqmaJES+NlviYPtTUwz2MBogc6Ec4/qlSrbUcHRdT25iSEZiKG60pR5xpaKKnSq
 rk3ZySauG+AIlGW1wqNj2alpCGJieKGEiPKdgc8TLnRy3uO16zen9O7PshAy4+LLCrvTWFXs7k1
 7sYJpgCcM9w7Wv9TpLDq7qj73yAcLRgd1AxHN+bcza4eD6JyihG31/vVplDMxCCudXMWioja9J0
 CfIM5nNMKu2X8O1BD8NrMu7S4iXibNTNdyxZqnT3hOh/nNb+JlxUZLEGDOlV2I+T+JbSNXM5L8d
 U2JCB2/Khir2LxQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Power domains should be required for PCI, so the proper SoC supplies are
turned on.

Cc: <stable@vger.kernel.org>
Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 61581ffbfb24..277337c51b49 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -73,6 +73,9 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


