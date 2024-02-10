Return-Path: <linux-pci+bounces-3326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B225E850591
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681FF1F2515C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DC5D725;
	Sat, 10 Feb 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK+XV/IL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD35CDF9
	for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585019; cv=none; b=oJqHsUdfn92PhfNT0iB9YZAlrP2lJFH1SZDWuUXwjvqWFcapQ5qvyjdg+ptszE1G4Nu3aT3BhGzn95kzHNuHWrAmgQ1o1DNx1haq+Hs5kvzIGNFlTlYKEf60AvhGtYiP2i07eAChBNEnDxSX3fWrso3qS+Vw3D5QUDts83qtu3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585019; c=relaxed/simple;
	bh=4Or5VI5ZnZ1ID78niRW0J52lNzSsB1zjEV1fVdr25BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snzXDwOyeaM8LuuWKoevcg8cR9wpMNrIXF+NGQVNwe0bkSZMgu8e4CY6+l6ERURcq8As+frra4eP7ilI1Cr10ZxaXCbCjDOMaSIzgzs15WVSvCiv4ZjvUfPIpXNKzGzJJ75gMFWN6mCdpBYyWGRR9UsRzL0WtPTtm5v9XV5Ddsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HK+XV/IL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a38392b9917so250828266b.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 09:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585015; x=1708189815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5eEDZ2SBOr178JyoKUFrLLup1vdc34CTGoZZtEa27Q=;
        b=HK+XV/IL4rUBseoi2+eMZaQJEAO2rroKPxgKoCqhtIF10BVggwLPT6iTcYvfyYW6K5
         Jy0gTjmJHhaLfEcC1GgLaD/ni4iNlGlBpHZ9wmTI2dGq3E4rA0WqXypo+AkQ30UXRegR
         auJ8T7U/BrO+SYEXOFUEXeGGbEX/RgZd3tvbAz21gkx9hiNR7g7jbPSQIf/hRdeZZl8a
         G1tj8qqPF4oa0DzS5NgJLj3yxDEL2F/+8odft+5FezoKGMyzzFSl4peRJfbG5cWt/rmQ
         +qXTcEtDOQ2Gl3swek04sfYe47e4O7VHkIC3kn/8KmcxHU48JauDMb2CluoYfHUZjpgZ
         Hzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585015; x=1708189815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5eEDZ2SBOr178JyoKUFrLLup1vdc34CTGoZZtEa27Q=;
        b=eRCOjanZmdrIlpe8iJEV7A61k2DGbTCwbnYIW/xOa6duiDHDMvvGZX2pgun9jN5pPc
         O0CI9LYkc2slyOvAaRWFbtPpdGLGuDbvinijiKLJReUEogixt0pk88YDWTzI3a1GTQVk
         9c1NAIyPDeO6zBmFAYtbqTHJq/yOlqgEO1tAvS6Ovx4LHNlOKfaYpWf0AHfB7z9Bh/Dq
         rqdMr5jfzublxDGJVNO8KwPeaL06s/5UDmJpx6aPSORreXQR8YwML0djjqYWKmvbJfky
         Q3xBVd5bebVsoPpsCsMekXooLuMVQn7iQCdRHzaeapLyDexwx31Eqx1J91ud5SA4Zvmq
         gMRg==
X-Gm-Message-State: AOJu0YyZ7wx9m10mij8ppUH3fSO0UcVs0nhJDZEjzrR4TNIk/LGxMRXg
	TyXdqzqIvrNGO5AfNcDqE3G1hWkGwh1qxWnCT8Zs6AczEtHfcA6i/z1DE5qIiyU=
X-Google-Smtp-Source: AGHT+IGmyojuJZDgZJxKnYU0KbK8pKpOpVR06QrZo9a8qqVps7HLs7Dxic3PZJESurg3B6iHW103MQ==
X-Received: by 2002:a17:906:af42:b0:a3b:d9bd:be7e with SMTP id ly2-20020a170906af4200b00a3bd9bdbe7emr1514696ejb.76.1707585015036;
        Sat, 10 Feb 2024 09:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnMvj5sl6aewT1D7//JM+3l1Jkpvwv0WkYZKzK5xSsmO3amS7nMfzjqGRrebRoT7aiUuPuijxYQre3qmY1JhLOWU1O9Gp6H9YMkVoczEMZUZnG+8MBVU+FTiQUtK3t8djI0vb6FKPEeXkplXXRikKAZFutdREmxGrBjqjIscBkzaFoWs9f0MqyCHaNyI1zYXDn41JzQqW0i9V3M3nZaMTgdkVVKDwZl4gsZJulSM87Sc/cXrjFrG1SuhXuWmfw4pOE5Um0ZO+1Q9W8RTZmdenBxDP2oGX1YAggDVDtVtZKC0cwpK2Sxw2YTBhoOA5iEnC1MNy/bHLfpFdUkuk9qirJ7GxUm9VzGb1lzWALQYN5na6TUw6N+kuuiOd3TVyeCA==
Received: from [127.0.1.1] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3c1e1ca800sm973242ejc.11.2024.02.10.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:10:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 10 Feb 2024 18:10:06 +0100
Subject: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-8280_pcie-v2-2-1cef4b606883@linaro.org>
References: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
In-Reply-To: <20240210-topic-8280_pcie-v2-0-1cef4b606883@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

To ensure write completion, read the PARF_LTSSM register after setting
the LTSSM enable bit before polling for "link up".

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index cbde9effa352..6a469ed213ce 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -539,6 +539,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 	val = readl(pcie->parf + PARF_LTSSM);
 	val |= LTSSM_EN;
 	writel(val, pcie->parf + PARF_LTSSM);
+	readl(pcie->parf + PARF_LTSSM);
 }
 
 static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)

-- 
2.40.1


