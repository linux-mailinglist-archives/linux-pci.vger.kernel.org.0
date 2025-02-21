Return-Path: <linux-pci+bounces-21993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A1A3F9A0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1ED1655A9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C211F3FC1;
	Fri, 21 Feb 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNu0+A0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73121129A
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153138; cv=none; b=DbCY3mx806UY3NtT2inOpcvf8GRRcM3N2tmaN7XqE8R+hD01TTC3qlmz1Zzm+zh0MsFYOfxPi18TMx0oADOCFRENRiNyy3H7DPBpggWYRw7oFlF918n3O6ASqqy/dkc4MLDDky2BuueU05AamZ+P6nB1iF3EFbV31GiPTTbKlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153138; c=relaxed/simple;
	bh=r63bMyziS5VAUoRIbBTBNVf6CyjstQjiNuFZTwV1jAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDwyeOprp77KF0i89HPA7KOoc+WEpGaT21XT5VcW91lOhtIgLJN77k5TwgnAs55jsSSyIAEtbEV5PYLh4M4mB1nPhBGLAZ0kyMi1OKfh5wa166xvUJ4c770HPtM9Rs9PsGBP8fF5afSy7xMh33ILuUWgle2lSckgxU79IrFnI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNu0+A0a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-546237cd3cbso2273404e87.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153133; x=1740757933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md2U+XG4zVBPU+kJo14bBfe09ZT4A11xAQxscpC41RA=;
        b=XNu0+A0aSSTO2CUQQxhsdW5svifJc8etTCYKOVqyFo2LTPgqaEbVLrqrHsCBeiQTkF
         QiGn/tSvACRh/NTJh+L2Vb1Ra+E+FsjcQcpCS9CikJym712DgjilxwuzwusYrVHzXC3s
         6KenJEJVdKccxU61qhWvU/Ue7I1NVNZE3LVVSkw5/qU0NiYi7Ma8ouTItWLBl8ngXwox
         gneoB6o5xJFuHthlncA9dMLHAxZndEPXpCQiFmtBZTDBRP3xf5bCgGdffcas/acGU4U+
         qQ+1Q3oOQs2eQGLOg/whR3/pfLWO/dRmXwDOL2Pk1dzoRUs9/E0lZ3xYKyhQ2TMbkCYv
         b3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153133; x=1740757933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md2U+XG4zVBPU+kJo14bBfe09ZT4A11xAQxscpC41RA=;
        b=SKcH6wl18l4bWGUa41OJzoMMcXTfB8fcpFRlAT3w7ZoQMm37GIwJPD1EysJ8OfhWs0
         8bhwuYOVr74HE9UdPgiBNfWZz8GnA3YTY1+fZgargvudLAK8OIDC2XTHEqz4c4m7gbkq
         yJd+eJ4LpaS/VEylfbc4MGCqSApTrWZD4LRIKHo0NvtHa17YsVMIl9WkGDdOC8EbBxuw
         amau0xA9AFWTxjleR46gRInc+zJ0ZfC8VQBg5nW7KFKPrnvkScpaYrltOYywTnTg31oz
         TSWjZDcqlZS1khullBExAvMFJ4+slOZc/7+9vOOfwN7aM4mfuJE8/w1Mk+6/IMv4NHaB
         Eujw==
X-Forwarded-Encrypted: i=1; AJvYcCV6K7V67ieEuIjnBnQazbpGXU3d82TsXkVO+z12FevHKhiod/PAF0F7ozSvKbKRSj++qyK3K/z90V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRACHkj42K6DfQQoHVRquctnAuu1tGN8Khqs6lmOuBGIDjzdN
	XsPpoonFFB1FkSpxS+fpftKTKf4iawq+WiHVUtKxe5SIgKyvBNI5rlZprLu4RLI=
X-Gm-Gg: ASbGncu3fOrmH8pM/ef60NcT9nEs9MYq/350Mb6U6zF+DhZOPja/E3hNOJW2/WygDWV
	1MyaSi4uzbphruWjWmxzbp9CR9kWMoiCtMjtqSwcsnNZrn+5jsKu7PGDRNI4WEqZ5HaIFEss/A+
	9AgGLD/WKOVVgOxo3ivySJd6xqtOirEj6LKwLsWeoqeODQc4kCupMOV9olqkdqNKlcsdUKpdeQT
	lRbB1Tt0rUe4DX8xUnEYjEXDWlP60VxYoMq7kgO8XN+v0sO2JWvTUeSNgZO43OrUp3FgY81C/hG
	YLlfZkomCOvmspT+kqKxu6QOJR7lf3+9ly2wcUCn72INyeTpu3VivorT8d96SvDvzmdpfA==
X-Google-Smtp-Source: AGHT+IGbMcerfbwYgeYw6YLssCNVTGm0A7e8f1N/RMimd9WBVnYYr2qhKyh+qBmIMoNFdbv0docIBg==
X-Received: by 2002:a05:6512:ba5:b0:543:9a61:a2e5 with SMTP id 2adb3069b0e04-54838ef78cemr1638320e87.23.1740153131920;
        Fri, 21 Feb 2025 07:52:11 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:04 +0200
Subject: [PATCH v3 6/8] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-6-61a0fdfb75b4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=r63bMyziS5VAUoRIbBTBNVf6CyjstQjiNuFZTwV1jAY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEiMghTZnHdd+xhyWX15/p0yt7X2L/g3fJVA
 V474rUbS7qJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIgAKCRAU23LtvoBl
 uIedEACmYKkrGylvmir9udVstpPuKUV6LsfVVylxsAMVdyVj2j4C75HKY5dilcPrULL2IuHR/TO
 hvBxPXwExZ2hAvCSw9IaHCsOGScC4PqHdSYyhRIJn3/qkoRw6HI4qm6TyrLOFLYj7iVAxPUL9c+
 jSqTvqDMHskwYt0fhvzMi7aRPFaT0UJWw9fBEZq9oUczMq0lv7sx92Ut6MukjNqmxjHhOiRBzu4
 uVWMW9TI457V8tqTxz64/PTMpZnECv8oz734AEcAnrfpuSf5yqhEfwWclz6z2IhV0p7yCmoawEm
 h+aBT/ouSAx3FXgOcUaWkCHuVjKI/Bk5auAPcjvCqfKyzRlBsqrnkifoqkLNGDf4mMNcLjEeYO0
 Iwj72vp6yWKBz84VzmmvoWYkmcfjW3lxy3JNSgGpqs28bhL7JcNkeSrrdbLYryyAM2CUhq75FtV
 6PPPqVcv0pwz/XiC5mAX3BP3LXgB8tt1Dhwqf8ico9vtIacs+teN0SCJyoPvMMd6lRhM91V7XD4
 3FvqVdgJxhmrQAQGdwnJlVlaaxDxmPwgGiqM7++XoYaWS/1Bo9jZM/BiRrusMLeFEqgvOWmPsEv
 HHGIysIJTlwbnTBYJ9xQXrjtfGQ/COARIc8Eogn/cem2UVYSEgEAkWALxzcnVPbLQM+PdbTp/i0
 y2F1AHp83SBR4BA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable PCIe endpoint support for the Qualcomm SAR2130P platform. It is
impossible to use fallback compatible to any other platform since
SAR2130P uses slightly different set of clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c08f64d7a825fa5da22976c8020f96ee5faa5462..dec5675c7c9d52b77f084ae139845b488fa02d2c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -933,6 +933,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
+	{ .compatible = "qcom,sar2130p-pcie-ep", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_ep_match);

-- 
2.39.5


