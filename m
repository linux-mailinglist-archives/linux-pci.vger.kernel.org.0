Return-Path: <linux-pci+bounces-21954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753BA3EAFE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EBE19C5740
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0EE1DB958;
	Fri, 21 Feb 2025 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKOw8J6E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4A1D5CD4
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107174; cv=none; b=dRd6N8DlV3YRKU/+HzksSy+/rWaexA5BmdErl3Y+Gn6S3IJmcYhufbgT+CnRqIIGBsWdr1eUHr732XSMYn8gGsvc3GG9jVmYulfiIx2FLGng5HaR9SnTIInLXovyy6ob+n1pCImyXa98S6twWqmyZu8NnVNXJmAhUBDKKSj7inE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107174; c=relaxed/simple;
	bh=lb3UDfByEeVlM9MYXJhgnTQM/WREpWu1N/uL89//nZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tejV0GzH9cnVPD+yqeUPj53ErXnGZrKPrtANBrUCXvqW3fh/Mh2p/PiPtBt7bisZh2GXSEq4vmhFT74Yatuzc+p/bPfCpAbcovSYzYQD57q/EM1TS9m7n/sYI3jqfJqMMnMxUpLabE2K/m7JIQ1Xd1n4AwY105akRuc9qj1gxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qKOw8J6E; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54626a71b40so1593901e87.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107171; x=1740711971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3msjZwuUycg9OUgz/dbhO7sUgzQkrOl04qU9KgNt6w=;
        b=qKOw8J6Ef2qOkLFvlT5o0WJyRnbvxj6uSGyvDFoTGhftMDp3ArLk2qq2urCn/qqaf7
         ZIdD/JzyriiHYDEFGyBBkXjvduIFrAUDe6pfWsV74lRhxlX37Jv6uUQV8DSpXwB4X0Ek
         kBKfDKV7Z8fjCUmeoZ9DK+v7uA+EsWWOj2U/DUyCs+xG6GGHg6QFrqD1n4SYU7Gojtne
         NHb7Gyuwvx8Qa+Ty+AYp5IqRZhLcblPz/ujQAsq2HCA7WLsn/V7C7ZZQ+mzqiUygu49x
         I7h4P6hdv4Cn9f2U5coOZLK1G3sUVNH81aaNHlCZF2/SqxtO04G29f+cnCFKZFqmITpt
         iInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107171; x=1740711971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3msjZwuUycg9OUgz/dbhO7sUgzQkrOl04qU9KgNt6w=;
        b=ASblRK5GT/jzwi/IxKW0FBP/88ypNcaUAkz/3zfwhXHw5MMVnFNKiUmlQNI+troBaM
         seXFeZH3HUL8kkmSO+u1RbDDCNrOqZf/qgxK7DzUaS3H9FdTb6L/ue9xPqHIX+eyrTWB
         H7gZWSnmmuBWxhjruyxKwTPazdq2X0br/fWfrpIzSn+y9HtuhZ1RHuyruramXpXKshrn
         urj2Qgl736LExgahJgHgUzG7KlNetktsWb6mBLl5Q3y5F4x8+atY7ySanYmAJHqf6SZm
         EwnAvoeXcxoHbn3sZHKWj6N4Be0ILH7lzdP2AoIxDfxfNM82ojhA4BdUFVevMI3kX3Ge
         9NgA==
X-Forwarded-Encrypted: i=1; AJvYcCVHeM73SFIcauTTSY6PMRuBA/SxBYAIv5R2EJSOSoLXhw0tj7/Qf3D3CMTmYzDuNQQhDe4YL5M41Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7YL3Xm/osZn/mfWCMU4m1GgvBk4WIbZxhwtWAGItGs92WqB/
	tmnQ++cB9ulLD7zur78ckWa7VyzMxpTTWfdc/ra/06hFmeCxFki3FgTuxxJdq3c=
X-Gm-Gg: ASbGncuT4cPOgEM007F7vKXpa5dx/v3QjLIonQ+Je5efZYehsHMMJibWvIdNkNDaFOM
	Pq5pfHKW0P0Wzw62osgurkkNHBHjQyexJxwBsOm6WMbEzy8o8bEAFx5FMB+JiKz9yeXJtxbX82i
	jjJpWkVqo5slHjQ3hKip16O7SkmKMB3QkdWc4+VvfLb4W5k9b+i1NIw30SY/1RFmL1UvA2Tf4DN
	OsLbYsthq7kl50oPfF/eEnCKOnjpvGLOqhvz+vY1SBphHU48chY6MfnBj0yjFW7Acwe370ovqB0
	rfY1tcM9VT+vWU7nt0oLiIAxO7jmAxQG+Z/c04zQ54n/E6+X9dx4tEIzUVLW9gxbhAwIJQ==
X-Google-Smtp-Source: AGHT+IHsu1xWN16FKTtp+8rirxUPipy9nbEQPDxUaKLvacMMvlGE+kwkPlCEntfbZRY+SVtNMiKE2w==
X-Received: by 2002:a05:6512:3ba4:b0:540:206b:c355 with SMTP id 2adb3069b0e04-548391400dcmr440185e87.19.1740107170375;
        Thu, 20 Feb 2025 19:06:10 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 05:06:01 +0200
Subject: [PATCH v2 2/6] dt-bindings: PCI: qcom-ep: enable DMA for SM8450
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v2-2-cc87590ffbeb@linaro.org>
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lb3UDfByEeVlM9MYXJhgnTQM/WREpWu1N/uL89//nZ0=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2Zwhe9h8wd6aEzObnZ0j8f+L8uZ2eYDZcVo
 2fuM8LfTaSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmQAKCRAU23LtvoBl
 uJu+D/9UIjc3mwk+X9zmhQJ1LDmsX1Mdtf/JJLr41qllYHMnncZOrzGvfFq6y4D+G3uKWbdWIfO
 wNlt0N+wjpVlrPvfc1LoppJxsQpnHSC2AjAPOFQahohtI9OvUK96/sEFD9h2lhA8Rt5Zj/2qkkQ
 /mSYlqU+W/aYkA1msPS2zMqA7mSyFBBq60XBNMbdSrLPvABp2pztZJpWoNqMZI9bEi1yriptGa5
 mEKy2AJRMG/jqq1C9QicN49cm8JIV5pC3oexzvksZzDgnnquHTMlVlh/LbSXVxJgE+GCaU7gbjs
 85/Ei8ryyT4OjufhqyTvKsNsX9yYHY1tykkvGnlXzr5iZWBule463rprUS27qnqjUcP/N/v75vd
 A4lvkzRScYDSeHKaW2uIk14rptPV+UhOk5xftpwl+DxiuxxVkrFf6UTnqL0/Y6O9qVqnEnj/Umv
 StPYPLjlc8qDMNuRxoMb3PK7aHlQU7O6KMQh1U44aWPkpDW1kOqkXXIMxYs9uctJHWtk/StWbRv
 vEkz6FcHjzOPYKOzOM6xeOZpGb48zakskoItVTWEgZAb0MPb9ObvpwxtMpvSsqKVIyIFzYdJYtp
 hmxU79BWXMn3Qdon8nA0XQxOsKsRBYGjYOeHMFLLXfA3FCsp1s/r0FqNliesigAXnzTuxkwdh5I
 RzqbGPZ/rBOwCWA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Qualcomm SM8450 platform can (and should) be using DMA for the PCIe EP
transfers. Extend the MMIO regions and interrupts in order to acommodate
for the DMA resources. Upstream DT doesn't provide support for the EP
mode of the PCIe controller, so while this is an ABI break, it doesn't
break any of the supported platforms.

Fixes: 63e445b746aa ("dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 800accdf5947e7178ad80f0759cf53111be1a814..460191fc4ff1b64206bce89e15ce38e59c112ba6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -173,9 +173,9 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 6
+          maxItems: 7
         reg-names:
-          maxItems: 6
+          maxItems: 7
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -197,9 +197,9 @@ allOf:
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
         interrupts:
-          maxItems: 2
+          maxItems: 3
         interrupt-names:
-          maxItems: 2
+          maxItems: 3
 
   - if:
       properties:

-- 
2.39.5


