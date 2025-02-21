Return-Path: <linux-pci+bounces-21990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0392A3F993
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0584205D8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1051F1902;
	Fri, 21 Feb 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDcsZoZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F851E7C2D
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153130; cv=none; b=OZePmpb1jyeNb5Gqrr5U3D6XLg57bmcPLZRxX9KGzg0VlgqqRbleqhw6NzcPSp9kWNuXyagUKirS4svTM1W3iTRzkOA64Z5OtjHA0B7YI16+ydhtLpYhO5v2YjR03XrKiGZWUPrifPfYJQuc+xcLtu+uMmV7Qh9Up1md3MEmPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153130; c=relaxed/simple;
	bh=PqoH6wcUbVCg+bqzkwcAIFED7tpYhlfF1LvH1T0LlxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaBRkeMQ8HUJGxScSijNqdxtHYvwIqb+Sfr8L4jOg+hgJCIB9xU/S8u8nfFgZuzHqsFdXT0tmLfMMK3FCRLJ9XhG44BsOaMdcN+oARmXOvu8slrhaArQPL4CaW7MDRMVOJYYMSXgzYLrhBXm1+uZ0RnFk808LLkJnXuOGbJrMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yDcsZoZh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a28bf1baaso19545231fa.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153127; x=1740757927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oaD81AileLAazDqpE265bLHpNvWu1Ruwv82L/foeI4=;
        b=yDcsZoZh5dFezQwp4WJdmGjEOQrzNY0xkW58GYpYTzf0t7cNH/yr1RKXICGdD2/3vk
         P3PnsVJq/zU2HomkJCOx21i0XVae7UtNLGsn5AJLMm8H6kCHHznx45AtWPf7A2yim0xy
         an0QbaI+1SCZ1LvqBNu33tDnnQHZGsCIOm5r7MlZe/O3YgaMrJatNZxGHW/JclErbpK1
         V8t0PjQqtdALzqO04RX+m1EAYLDZJ5NWBqDwAaGUv+LiKaZ8CGRs9D7Hljx5KrDr1CGJ
         ozY6+X335Kbmh2h9hAsFb1y+AQXWop106HZe1L7QnuAC28mw0KzMdsD6+42ZZeyt6uFS
         upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153127; x=1740757927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oaD81AileLAazDqpE265bLHpNvWu1Ruwv82L/foeI4=;
        b=anOLcIAk9H1S9gbfc4czX08IRjSsLHhtupShAI4RF8jIweVnQJEmRCNeDGlkcqnHAL
         +la3QYDVEaULoZO+ZCFSlkXKXz7kS2HFs2a3HXq9mPB1GjDvp1VkT16/5HkEKJ0h3sWB
         TBWAiLAhStL64ypMCr9YebOX+RNed3T1Vnrvv6W/5IvwqedRWLrnLjq/kePBpeHer5gx
         FRQbOyeN5sDqcJkbd/uINTu/Hb/eq5cMGFvixVOThktN0FGdWaU2NWSh4PqwBdxkf5zN
         eQogE6LJTaArqPw2SnPz9WPlVOPa/ZQ6rrS5UZZPwUfgGm0lsiGZT6oLjn+HFTAFGkD5
         TnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi34Hhw+FPZdzA2133cUWBIxzSQs+5GSTo/nK6n03/33h3N87ocvCuI0Yh0xfYHWwkku147bekpeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjA9wF1Cw/N8ajlGA1Zy3R3ORqXf/seWRsfdSNf77QOkkdvMoS
	tWT9NRoAKEzFw8MfKyVbLqqB3cmNqomEJOcd1lxeXodtxZkHS1zQ6RRlCAzzVf0=
X-Gm-Gg: ASbGncsVojxU5Ud/fqQyvdSRJiIzwA/UbJrcN5fBNQ4e6yGnIwNur8VUvnGMsFDLH70
	F0t5X80jrh3eZJjQmHm3VrWGYHZ/4PV6DnV9f8aPrwfNVzj8Rs1HK5EXczxf+MDG4GbP1ltHiGi
	ZbX+Vik6iHmMquF/LaIfMvN1C0UgBCmL/CCMYRs8x8U6sHSfmyypWAR2YDo7e8phJkHRGf5tGqu
	Sjfa7tjOeWL1ysuH/kdnvItjweLNzTnz88bONTkwJGslaE497rly6o89s3yF6pDDCRhNl0wYirE
	MxtWM9oChTcIxkyrrLBdwkE4bymdzEDrkjFc6G1Az4SlLW2N3l0JoovXm2QopjYNRugung==
X-Google-Smtp-Source: AGHT+IHxm3N45IVfBfGIzLC6Faod278XegLTfJfcTvzqKtK1atXf77g6WvKoYe7ZdGWd/kD/iP4keA==
X-Received: by 2002:a05:6512:3d8e:b0:545:2f9f:5f6a with SMTP id 2adb3069b0e04-5483913f9a7mr1381513e87.14.1740153126698;
        Fri, 21 Feb 2025 07:52:06 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:01 +0200
Subject: [PATCH v3 3/8] dt-bindings: PCI: qcom-ep: enable DMA for SM8450
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-3-61a0fdfb75b4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=PqoH6wcUbVCg+bqzkwcAIFED7tpYhlfF1LvH1T0LlxE=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEhZTF1AOa+8fcBJRBvG2FOggKSKq/3RmrUC
 ZLIaKWYzQOJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIQAKCRAU23LtvoBl
 uMKxD/9VrC4yim5nVDujzoNMhKiYeP1R8iLZvoq5ZbIQS0oqpAVFb2hoTdU8vkEXYATnahH1Xge
 0UvkbmaXVQmFeQwACbnLB5UnlaBFRC5rBhYjbNepja1lo2/FmO4KtQIdDaqL1uOFTOo95mxhp5+
 VwO9rocB59AVUnaj3RNyg8qS4jJjX1ryASHxLm57OkQYVjUwC3cPnxAf2EGKo5HevAGBC71SZjm
 2ur7zuSvT9OQ8igt+FPRSX9ynsQaRoHKgZmE1iCzuk664PIjx28qwEbBojwqd6SZ0eChmODylPI
 d5OP/Fiz2VBCh7r8Yehm3X8MK/p8pxx+iSSN4a+n4whq1fAmCxjsEeqneaNooDEYibsAT3HZw+a
 cu5WE+T1Fm8zANkGaRgW6k5VjC3eyedJdKWV+exATCyEg6wBlzC4XoZQcyuFo4d719uSkUsTd+z
 hJX82WzEQF0jrC1IrKYRjaYle+iUvSKSOW/jjwQfCJpUFyEVRM31aKLnRazWdEd0dbT3foXJLZp
 VKkcJ9AhYx3vuYZuQgsbb0Fn947GJWn3g0fU7eTrJ9xirK1rncgUFOc6qnGomT4G3EFoenjw8z1
 nk5GcI5Dit0MxJLaxQGg1G67jaKt0BXLqHx3SFUqLoVzfnUJRRme3Q65S9rfF2myobVtVg9o6SJ
 kAzf3o1sFrizXVw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Qualcomm SM8450 platform can (and should) be using DMA for the PCIe EP
transfers. Extend the MMIO regions and interrupts in order to acommodate
for the DMA resources, mark iommus property as required for the
platform.

Upstream DT doesn't provide support for the EP mode of the PCIe
controller, so while this is an ABI break, it doesn't break any of the
supported platforms.

Fixes: 63e445b746aa ("dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 6075361348352bb8d607acecc76189e28b03dc5b..d22022ff2760c5aa84d31e3c719dd4b63adbb4cf 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -176,9 +176,11 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 6
+          minItems: 7
+          maxItems: 7
         reg-names:
-          maxItems: 6
+          minItems: 7
+          maxItems: 7
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -200,9 +202,13 @@ allOf:
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
         interrupts:
-          maxItems: 2
+          minItems: 3
+          maxItems: 3
         interrupt-names:
-          maxItems: 2
+          minItems: 3
+          maxItems: 3
+      required:
+        - iommus
 
   - if:
       properties:

-- 
2.39.5


