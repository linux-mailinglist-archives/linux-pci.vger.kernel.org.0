Return-Path: <linux-pci+bounces-39780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C26C1F21B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AB94250B4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC33343D63;
	Thu, 30 Oct 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwqvokk6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311A339B47
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814278; cv=none; b=NjwDBfOodMo4+gVs+4RMkif277KQ3zfzZpb0aWhhpj2PFgS17XnUyNp1PtyknHt1VrSLuEw+CKBMIiHe+nltcy6sgLXaM3Oy8ZhrqNvy87wkyJHAtRynGF5ncn7Tm40Pw+p6fpXywPp9UqrxDMT+EtU62ApyUoxMWe4scgoVB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814278; c=relaxed/simple;
	bh=CNLlhBwuYpBvzzRU0Iy0xfaJ7C6izC/UNkN1Iz1WyaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOd6pA4OJpQEhQ160DSTEKoOeV+8X1dmfqjplyoIhqg7yXKPzRF7yPVTYNT6AA2doOzUEb8vdGmzP48UyA1nnqbpQ6g8L8nhdU5/Qg1nbP0rd7NxrTLufmN43wEMe5gfQkSnPSdW3mMPskxaRDoNLqNltFnOQktx0v+4OxS5Gek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwqvokk6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d6027158eso16096866b.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814272; x=1762419072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D28EfOOxWYrdaefT1gXIR0iUkSzZ7BDb5koGblp5Wl4=;
        b=pwqvokk6pQOd1rSYrof2E7/+qAq+t9W8CMH2+oxx3yL2FSgpejn6d4qDt060vx4f6w
         3lyZks/8P41I4hvJC8mv2C32ZLlJqNJK63SDB30Sbz0r+xsKZoFvD2nNJssvdASA8V4n
         m2oQg7tQFwJ8xxBlqmHO3nTKEKPEHV/OY/KA9CGQYPRlS2t0LrFBMJED4067c6i8lbAM
         Cy+tS+78kpnz8tkfMJFiCc/neeYTr/MVl/U0eO+/Z0SNVEsHtftMypgGOnoWI6HhY6bL
         cFhq0GOFdRdXFmxtZjzPj7fXPDcLi+NV+LiXalYr8+BBZYGv4K0ewXgbdSoTsHCS/vw9
         y0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814272; x=1762419072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D28EfOOxWYrdaefT1gXIR0iUkSzZ7BDb5koGblp5Wl4=;
        b=pML4cxT7f8rIaisiR8ky1EsVJdK2MVCJVVyWkioi6AsDYcll7ChcJHGk8cirgDHPtg
         KtaZsoF3XOiLvFAYQh7J1E9x1zaXH/4z25QUWxqB4jodr+aaCvqYE4hd0H38Vqvf6zpq
         WjkL4zQfKkj2ab55nAzmDXvPl4OROLKrZDSpemhPEJSApzyWLT0JKhPtXI/KT1P9OLUq
         X0N78WeiczqrD9UGzEf8jUKOSDkRMb/BzayEaZ+ifOeYk95MN+6aJlhkjzakrF6cDP+5
         ZOAYxyc2fwxh1u6iKV9Duxk901qBRJtvrljs+7ScTt3BWEaCjpt18qoV8rxbijBNXyc4
         hNhA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+QEp/CGZpXRUeSj0bQ3elErQRhQEHg46cXcljjLzbpDdorBz+LTZ5DNBBVTqeafww+W0xXnHg14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7K8djW+1WkeE+oRiniijVIH6uCJWut4Gc+xSXOiXS88l5Mrc
	okx4nZEvuuXVJVDMUzjElL5UcNo+JRp3/F4WYsHNwqWSmoz2Y8YYv0hwtdZHnlFdR/0=
X-Gm-Gg: ASbGncu0lxoRRE7fbVSKp8OMJBNM3o8hZ0k2TZnDjoYWWQLnnRAr/dXMw78QcmkWqu3
	lKOs73sgYFT8z8p0QFj58Z6UD+hSFarnLCO0hkxjt19tVdoxhJj4yNTxFVWkKc4wIqVtTEHONh7
	pMCEE7Vqovpdh/zQtAhGB/IOLcArKrmScxGt8zu9y5QwxbNY54MhB9Eyb466CxKNzSP/sVKnj8E
	ekB/uh4phJWXxmV/r2qnqR5WHO2AO3DyqTqPp+e4vBLhoopGovw6Vv1WgHViJ73ZD3/QMkDGHzs
	108SG9yToJEDpt7ARU+lpMMFncfW9GAngwY6OlgwsWC0cR1zLxUVXZykgxY7PztwJu//1IW8DkK
	ikGpTNs0kPz69Vwp8nts1M2nYa9BvDRufx6A6tfU/Bi4cJP+f/4byQ6sO/7SE41Gk4azyDp8M8m
	8bLINbZR+KxCv11fi4
X-Google-Smtp-Source: AGHT+IFx4TelI+GrNXm/w2tTDA32IzJmyD7uC/kjRQlzUbLtCTfWDCgAcAVXbD7GZ4re56J7E8ocOw==
X-Received: by 2002:a17:907:3f87:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b703d2b2ce8mr290352266b.1.1761814272428;
        Thu, 30 Oct 2025 01:51:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:49 +0100
Subject: [PATCH v2 6/9] dt-bindings: PCI: qcom,pcie-sm8350: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-6-28c1f11599fe@linaro.org>
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
 bh=CNLlhBwuYpBvzzRU0Iy0xfaJ7C6izC/UNkN1Iz1WyaI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAyby8/J5iVMIuTmuZt6le060uzimF01oYn8Wv
 LGUVH2MNZyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8gAKCRDBN2bmhouD
 1+/DD/48Kef+j6tupHzMNU34kgv6dutDHj8uLyepSBKdQgQcOPmwAr7eZDv388C9Oc3L4Nh50TI
 sErtby7muwDfjDnNWmYunVt6adxYTIpM0TmfVchHjz61k7ZTzeJRzw0X/4tmICke3G+zKx9FUhG
 ciQbffG8afv+t8rSDlm6asoWxuR9n2aL69tFVNsnrcXaufEQLvq+PUmUIfxYxIeuVE7X7tBEdi9
 NLumO3kPl3/Z2VvOKCTLKhLLBjuAdmsVYwbqhXuR4BsJRNxTSuqGO5pcDyV8YpDHB56zE3YB688
 RvPMnx5bwWu6ZOnkPviI/rBIrO7vNPZ/f6FRQqGOhR2dft7doy/DDFwL5/hOnvOevql7RQaXr98
 2/nanaG3loYui7huQJhD8EXYmjqRTlIicAVVfnFyCUSTP1u4kDwRpm2pRhoEa8FpWwhsaUds05k
 T/qjLVs8MhL5EwQR5/woPhfjkryaCO2IU6L8UoMpSYbpkrqyW2XqLtTzkiTMbHlALEAmwDcHGi2
 43VghVruiEVzticWXJpM6QEsMrISdhAGzzxQEog6pZt1PuedCvuxxh8ZnyTTFK23NHK8yaW3tCh
 XVGDF9swwdXAsuqr9CUlYLZae5aa+02k08DpgmSptaw4jayiiEOCklDl9NUOmxFqR3wL3K81Bj5
 IIzetD/Iv8wb2Sw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index dde3079adbb3..299473af51d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -73,6 +73,11 @@ properties:
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


