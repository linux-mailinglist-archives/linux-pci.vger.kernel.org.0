Return-Path: <linux-pci+bounces-39776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF1CC1F1D3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20D214E9AC3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C133F383;
	Thu, 30 Oct 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8MAx9Sg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FF339B58
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814272; cv=none; b=TwcUwGVy/RAFa11VQvolbDkP+AOyVj1L131Yk+AkJltAfBXbeqLtEhcy8LFfO/Uh7XVjAT8H6hHEO0lU0tKfzxCC5PcHfRchA653F5WZNhAC33JiP2C9g9qLKaPlFKoB0WV2YtU4tgOFGS3eUPdzp5KWvjBW3IF/D/1aqbmuIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814272; c=relaxed/simple;
	bh=UnjXcV99SvWkoomQOs3r0Y0I0AunpUUaV5PFC6B7+o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifuoE11Vciblz+sO2RASq9EM8Osr2VgS/jvUhoXC3S45ooOZTff8NG6tJUWkadi8ruyCQYXpb78ktYHU4DpLfxpxEiTH/nSspJ4gHpH8c6J7uEzkgZSuGHtQPvLZGFMFrtrqRG2wkSJLEZo2AitID1eodFpCf/OC6MvN3h7VhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8MAx9Sg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6dc4667305so14628766b.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814268; x=1762419068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/swht44pfZHk2nX88R5C4csGgGV80gpv8aGt6ox/pU=;
        b=h8MAx9SgtWI90FcqVZj6WiFivagLNTbeIcW4BN/6C/scYBLnXIGAXiEXryUTIfRrrJ
         eMOF6bGvv3tdFPhVzu3IS3ZDAB/GCmdiAu+z1khevGWPKjphnvaDpsNZWksyBXT9c/La
         txvokatlaphrOYZDEJx2cLFadQj41Qv3WVL73FFntZl9KrJPh/YaTjQ1sUSfKvOxImtv
         39zkjC0Vkp/Q/GX/ZeLFBbJIXKbadCKPQECh6Qw0cgRXIEkonkrLJGo78YDcfg3NEVKC
         jS6kZqB5E5BNpKruLpdPGBizV1jUXWkXAmSzlq/FqULtj6DS+ZswdEMGQSbBKUHSrZNP
         jWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814268; x=1762419068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/swht44pfZHk2nX88R5C4csGgGV80gpv8aGt6ox/pU=;
        b=t9L30hpYN9ZBM4FnKS/YRNQqQAW8t753H8oC3HLkyJDjmYs++pB2OrrH2k1OLk0Y7b
         UtJy4LiyrwSwOczBpGNhfm69RZybNOOaO4W+ZBwMHJcOO2C6tAzMZQAd2Y+YwHKy1sZ+
         e0Ib8ulSN4KjTLAZ3+1Ie4lsNPsfjOs3ppBPW2bC6N8Skmb8HiiXaNRgvNyq6KegsXf1
         Ew/x6UTPp04BMqMUNyBtXBY8wrGMUgPDAhgxfXbmJdaIb4lHF6L/g//LcFnRP6aF5pVz
         F9gPOQWJ6JWw+u4UHrwXHUL+RfeWe+PCeYCBJmdpuge/hP2NTYPgd7vQbQQjxIoQswAG
         ARrw==
X-Forwarded-Encrypted: i=1; AJvYcCU+n+2bQdbL+kVZfketQ3RhkrZVOA1vRu9w2L6Mryjvln4rv1TnhM3lzHPVY0jAqR8qGGBFexJUm9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pITHpFWZZhXVhHy1hiED3wUyXTfWo2KhIV9ZWxkZtZvT3+9p
	W1M5oYSl08CwtfrLGWCzAO5V26WivSQ5/2BWNN9RVbs/fEjhG6/r6gvOYqCnQegG7r8=
X-Gm-Gg: ASbGncs0Go08BGB+KtGQhstnq8z+0wNGPLpWmp3dmAx979xZFAZfV2puIbBpnU4AfeR
	EvaPKkIyPB9bgUljvqflCV6R4DFceevEXDP4Q8sHduJv+ZWrETklzQPQLV3nYBuNCHGK0FlGPCo
	nmIl97nSkUOJE4RwGAiYoSbFPqvYllXTq4LTxG7S9xCCBDe++h2TRtNL0UVinVqXbdsasEnR150
	fITDWdDzWPb5Hs6QxBoFZ/Oy7IzsXEoY8cH2f6aJjRvLSKpHEnN4cQtOsaO5ZY/1uVp7wWp1CGX
	KxmGGRl8IfvBs+YMIh9LEQHjNaB4XUxB7IloW5ZOUZUY71MK6q0zVKduet12y92azpx+wMgN8RS
	X6bRusD7O6vHyM4nP2sDNswZv691J+FuiWOn/HM74fqJJ/yPHkmYVnroXqSquKhSCEdl4aTAqO9
	3gISJUNjcXrsjVrOQ60MahdDelI3s=
X-Google-Smtp-Source: AGHT+IH4Xpg+Im3DojMugmh1k4WQg6GSGitSimjc0UjEvJ67YG1OYfvfJB1hyyAWNNTXg3FuP1igOw==
X-Received: by 2002:a17:907:1c1a:b0:b29:8743:81ef with SMTP id a640c23a62f3a-b703d062d24mr328347066b.0.1761814267999;
        Thu, 30 Oct 2025 01:51:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:46 +0100
Subject: [PATCH v2 3/9] dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-3-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UnjXcV99SvWkoomQOs3r0Y0I0AunpUUaV5PFC6B7+o0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybwOMIy5w7bVl5laC1F4cjGoJzeCUfsuy9MV
 e27p5XJXNqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8AAKCRDBN2bmhouD
 14njEACEAza30Q1dP29Vs6Eqa9pYTbA+URJVy6miVBTSavZAWXhlnPMMd9kpAP8wWwFsAnOShld
 on3rTD4/3IsP9vcg8vTYTS4TPbhNOLAOhdiBNx9Cw9Xu/keTxYG0wD3SIFr59ge40KF3bCmy9Kq
 iHQ9Parl8OKVn75at+yzA81l3tj3KQmE/jwi9W86vvdh5LuSuPBFVcAuOQQxAzq57vPCV6xAgbD
 8mCQ2ev9GdlvoqHpW9fN0IPYZAGYnqN9ODdkBvHvTgJ+OQKMDhEj3lRK6R45lTMT2XUKRheS0Y1
 0ylazyYeY2z3U+bu20ecS1zRB8cu6VpGnsGFAKn2TCcr5GVYEgorUItdfVeGh6umBpTEsLszu7g
 FAtBsYXk0u/Wc751GoXJMQFXsleMwDVoO4Sieodja+ktfIw38a6sxP5Ri8j4rdykDu2ca3OojEZ
 6mK68gvYsI6nhAa9siz25yReo7wAc5kCPPPeGxy8qGmHV2qfzHfEYsNJFndnoarD/B5+t4YWzbV
 beiULSkopGYdfofLXTdtZa7h+l5g3n+cO/P6EunojWpqKP1rTsWPstWXJslxIinRZM2msroFKS+
 jhojr/TNW/F29S0G0j7MAIEhIrOcGo9mvZlMw/dFgomgf7DVNLyzdEjRp3bE/BE6rw9PYeNRtiC
 RkP5/pc6FWZLBYA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move
SC8280XP to dedicated schema") move the device schema to separate file,
but it missed a "if:not:...then:" clause in the original binding which
was requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
index 15ba2385eb73..b6fb0e37cec5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -61,6 +61,9 @@ properties:
 required:
   - interconnects
   - interconnect-names
+  - power-domains
+  - resets
+  - reset-names
 
 allOf:
   - $ref: qcom,pcie-common.yaml#

-- 
2.48.1


