Return-Path: <linux-pci+bounces-39778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2111C1F1E2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E4114EA064
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BE340A5A;
	Thu, 30 Oct 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qxg9LkTi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C933F392
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814275; cv=none; b=BZN7cRhOti5n+G+3OEJRI5tEWEw6r34OrNF0kC/jUToLXvxW8e/3BmGHSs6Gt4nZhmL3L4aGsZ92+3TaoXEdbd489TBq16O+lsUmrEBtrSANXPm75P9PywprpbC69wlE3RljKsZnsR+Wn8BlIJtQ2RSc6snhFOGi0ceZdOLpgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814275; c=relaxed/simple;
	bh=4pGm/GG46vHLJGZFoG9Oyw8WYggRSTiaiD5DNxchMzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJ8AxyOrU5L6yWGD95bYbx2f7WEpchMg3dcgPFWw1H4AVLxthtvaW6/H1U2ZGrWZSq1Ry/dgbMkPb3YJAxMi1XS+x/LIGUspCnWh6DqOYmMhEGighyVUtP6+roPdgOrqmkr4NXkKgcyEU5o+DdowVNK5MRcx7sxaqVIEgi5moVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qxg9LkTi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d3aaa150eso9825066b.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814271; x=1762419071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB8wr4Z46fipvIRWrp5R+KCN9mXNpfUi8ky4i/rQTXg=;
        b=Qxg9LkTiCjhi1VHNvuQyF+82u4KKXS+u/Nb60uhA9uiCGSg0u5vd5h+rhmhB8ixDdt
         8Jtguz4lmRIZzUFsXDKfDiUgh1bEkElQv5cNFFftVdJLKuhsZL2B6LPEQtjyjK46q+/Z
         I0H1cmdnkLeqAD3j6fP9lOF7Oyys3Na5gKZS5L6C0AvmFEd9V4Pzw16UeP0niPIuhuAV
         oCOPUlftPK0VK3PMbbOZOj0zdLDdTW/nNXd/OVL87JZ1gMYauaKEJ8rsBGT4wY6le6yI
         cAQ6mMDVKNpSCuVboMAqrK2Z9IsepL8w0LGZDS9x44iKScJe6kqZ83cUtMVuGCNQr9xS
         wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814271; x=1762419071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB8wr4Z46fipvIRWrp5R+KCN9mXNpfUi8ky4i/rQTXg=;
        b=clCeYeX3Fm1aND4vjCRJBk4dwNh9JPNPgR47RRJPRiKv2k0jLwV/ESFa9IfEALFoWL
         S1RgKytUTnqSjiJnZDPSlauv2+e99xJzbsbz9F3OGxkr+ur4HLuIQ6cxH6rtVlPMj59H
         08EPAzBOGfEPUtoyz6epYvbYghGgo5Lnc1LFBjKllIRM/BEOaHdKmyeZ6Y32ucpv8nl3
         hHnhSP21XKwjG4aO1q+8QqqmHCyowdfcTl9mHVbluxB5ByfleusQOpYILRQ5e1fHb2p9
         5nW6QNNc+bHrDjggYtgsZlEsBhKWIbkqd3JlMv87qEuD21hwTfK8ern+T9EU365BZKOj
         eY2g==
X-Forwarded-Encrypted: i=1; AJvYcCX4c4dfXBvG3TKOq3th4Xaipw6IO8M2e74ypgJMKrqMPAyg0S0IrdvHwPtFAb2X1be/SFVhbxeL+sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZaBm7wRt4JY+v0MuouUwy8/lm+PuIlYKsv42ojdS2NF+rhwB
	E/hZcccnmTvY285iGz3Yik//ZqEJUBh4oFRnG57TyNiKg2d0YXNH2l3PJON8+qMx/6SeMpZoOU0
	WJSdr
X-Gm-Gg: ASbGncv3KX4TYXZnl63Q70TASe++lvltK/W+rZ2zrxXUEgLczNiVoHHhKPzleaWHg2D
	ttdmR04sN1w4SlW66lAB0uhNFU0lNZs7pYkSq5SHqax8vbAnBcAuJv1TCE4epuG/VmjsCwZqNfJ
	b7YKdxIBYV1A9pAm1ePggYmh0G+cJW1UvwuYqPkshFIKLTiBxGwBLpkGBXUj5MfgQLJJ2m1Cx8A
	Ooe2Wh0lGri9fXBMc8uif1CnRzZwgG0p0GMC/Ey7V96En1EONyYHbMEBrAgaFXhVuCJFvGxR8hL
	/w28OnExlWOWEdPRv9yPpporGyNqJ/detn8x4R4a4QIJh0qipmH+BjaCcagUIPQrdmk0I7XAxuD
	j4/3Ji7Nj7H6GZtj4ouqieFlmjNxNyt1QqBG9/040P8Xp8KQihmZ5QHdTZ9OgGZLk9bZQdaBX/P
	FP1Go3I5yGJ9LlAyD8
X-Google-Smtp-Source: AGHT+IEWvPX4pKMIN2tcv6fUOmne0vn4eS23qQK+t86LVfx9e8vdXXysoyxx7cpwZCeitbzhAe2Qeg==
X-Received: by 2002:a17:907:3f87:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b703d2b2ce8mr290349266b.1.1761814271032;
        Thu, 30 Oct 2025 01:51:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:48 +0100
Subject: [PATCH v2 5/9] dt-bindings: PCI: qcom,pcie-sm8250: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-5-28c1f11599fe@linaro.org>
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
 bh=4pGm/GG46vHLJGZFoG9Oyw8WYggRSTiaiD5DNxchMzw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybxfIhbtaeqrQNtMrV2jCyqpx0Ii2cFSN2gS
 I/ZVtkk18KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8QAKCRDBN2bmhouD
 1yOaD/9qnpCE+oz4X9bDF2ucBepgDoKTO1BwXb99YJ1t2BZinsDqbM2fEGqzknWzoo9Pk4/x84C
 W8LyPjiDIc0jG2++/XJUIG9B1x94LgrZUDbDLNSNvw1uwA3l9bgPubCYuU2YtNso+8Ev21DNikR
 r1InFFmcNhzVoZTGy83nTa0a2pKCpBovygaGvDqY5jQtbIKbR77VT8TBHsAxzxyC1IMvwnY4J9L
 O0cdE1MSQbVlsgYGEDOq2hLWOkx4uXncN+xwRsDpqMc0Xtm3sn7jShAKhT0fXVEFJWZFHpicB48
 Ghy2OBudY6lB8TKsJiQI5OW0qx2wGq/vlV+xfhicMb9ozZXTAha3ugEPFfSLwZpy8G4ZDo+dCEs
 guU/R4GirzcGX/Y6OYoWtUrP65xvmH/vnIQb+KfvpG15sb2WleB0vgByTDiwINuX8XyVqipAd7n
 /nF89GWwRdh/Pqx80tMCCLzaZlpEBNEWSXx0+KEGR33kveZJ75vzCr82ImCxSrPAAdfXXVAKLSv
 eMv1kgJOiEa5OQujwlV+7A0+u0KTS+IsTZMRsIcSkWbGkyaxn8MOFUXW0LMl/eL/b8SF3p4Gesg
 U4X8ECt8Do9O+T7b3QQFkJCgmtjCMDIDyK1sBLnGj6Xkd+4+3t/bLjUaNm7O4QFzUZymBz3d8EK
 0i2rL9dNc81+U1Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index af4dae68d508..591f1a1eddde 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -83,6 +83,11 @@ properties:
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


