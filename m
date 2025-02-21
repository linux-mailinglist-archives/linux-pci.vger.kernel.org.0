Return-Path: <linux-pci+bounces-21952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68DA3EAF9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B963BD724
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667651D61A2;
	Fri, 21 Feb 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOLmF3OK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5945009
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107171; cv=none; b=BxQwps5EC0vMVQFgYoumZaBx/xD3ctlWMHwP78fEsRxBJlUOL4hGCYmOiKTEUZe0AjUA5gm1W46yi3jo4VNMhOTx4rn3lrWZSTG4tg143FZUdoEYMtY1iV56YlzdiJIBfu5V7nWrlWs2NEoQmYDLNcK8fpfIwBj9H/0S0qQ8oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107171; c=relaxed/simple;
	bh=9UsApYEDGH2IHjWwMiu0TWBdNEwNiQK7ZA2hUV9JAvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PnhnSMNHqRTjx7a4mbi75+7OWw2bSXng5SqFWHblHi9CAaa+ClWR+PyGnpbU5nYzeOJ3XwbVx9edmwz+IXF0WudLl9mCIzAkxEc6eq0un+shHdFd5kZrOid3vn9xC4pTlp2MS0YkV2avW+3UbjZOxR0+/g7jqAjPB2gSRxZL/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOLmF3OK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3092643f4aaso14661981fa.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 19:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107166; x=1740711966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmCF1to7hYwEmQjLMqw9j0vtEKkBlDvJBhrQCO6ksdk=;
        b=xOLmF3OKQp3CQrxbCWVw7Lv05oPPMYMk7yz4RHiE7XWsYxVSN8s498bl151GJ4PQnD
         KXEQap1IyWfLapnC65yGIR42KU9ea7hrGAgzVVXzEadCr/KJgL/ycnMlHuYqM+AVfrTb
         Hb/5UdnWqHMLVjPKPoYV62kBeRHLAYFBEeDkzLJxfhdQir3xbyXykBHmfwv+A5rdHAj2
         gi2kfni3tCYC60ibworFoTh3aR/5CA131ZBL1w4AdMUFEVzkXvvZhYhzbjQMjP0waf2R
         Vrem8U0cNNJVznUtCPpTWRXNZSRu6zqb+TP/3Td2vI88JBKoT4GO6C6oddjh0y/3Bjnp
         SJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107166; x=1740711966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmCF1to7hYwEmQjLMqw9j0vtEKkBlDvJBhrQCO6ksdk=;
        b=Zq5lAeQFZWarL7nXWIyuVAFxguP0JXQTGgOQROXDRabwSDZzWw1I6u2m4udPZxaDjx
         Tk3ysMvMTquoc/IJ7o1H3MQGrcXdcGTs1q4/qiipCJovYqiSAlGaeA9eTCqx/TAR522f
         T28FxdqklPe1qJBQLJp8Fz/LQ6/1GVEmNkoN6PNhfWa0caz/YCX9HlGPzo9O9Br3OZfX
         qWHueqyjMQdXARNxzrGWV6VSqWaHfbWjPCzoIF05A7OmvdfpQhh6AD3ukBdZOC3NEmUp
         2wjNVJxCarWLm+yMQQtf5HAOU8e34GgfAg0BQDakJYHjDJLucumbxOOnpZ5AhbvHSCoB
         Dp0w==
X-Forwarded-Encrypted: i=1; AJvYcCUMJ4H/9Z+6nRdNMIaA704KdRUpQ8NP1Gyz2Rtw5gpqJccZFcgUW0g/Hmfzr7m6l84WDLInP17qJOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCagixKaVmuYmb4ckY+nLCpnNBufdFG99GqLDMIMovpT60n4N
	AT2Bnh2VU98Yf7D+XiyXqfCtv70UlXC2qOhz6bISlXpI3aaCioIKemlYxQa3eRE=
X-Gm-Gg: ASbGncvWMG4wpyjF/Koc1iYhMnP+ldzoUew891fmrTrKmoprg5j5Cvtrxle63T/YKch
	KtqNZ2DgZ3X7Roz5NBelFRUQDq6yHPhDd7W5w36G9xEsrGxzBPbit1ZQf/MqgqXjQJOhcN2Reqh
	8yR0PTf75upbnvmlbD4i1eB10lRgVdUbYD2LhD00wNTRfZIQAf+WrmyphIsKHD5bWyoZWnrM/AN
	Vnk6TAAdSjDGRqWpGZMMNohWZzZi5GGNYZ/KPxijZNj+miICO/yhhZzB1B5IePIgRMjwpdK7GUy
	HQmrc3BqjqVBHCAUvN01q+oWHi458t2H3IXZJ4Tdpsx28dwf/MoiUvwRJ9lo4wrY+7kLJw==
X-Google-Smtp-Source: AGHT+IFHXdcth1w6OSj7/CMbouJhrEFHe2wNKQ7rU3x9ZDg6f1eOa3maRdFlyqQ/E+5fOMtWOHAHRQ==
X-Received: by 2002:a2e:904a:0:b0:302:3356:35d7 with SMTP id 38308e7fff4ca-30a599af5admr4079381fa.18.1740107166420;
        Thu, 20 Feb 2025 19:06:06 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/6] PCI: qcom-ep: add support for using the EP on
 SAR2130P and SM8450
Date: Fri, 21 Feb 2025 05:05:59 +0200
Message-Id: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJftt2cC/13MQQ6CMBCF4auQWVszLWCRlfcwLGoZYRLTkqlpN
 IS7W1i6/F/yvhUSCVOCvlpBKHPiGEqYUwV+dmEixWNpMGgajdqq5MToGhe1eFYdjo7q1l0sdVA
 ui9CTPwd3H0rPnN5Rvoee9b7uUIvmH8paobo2D4PkLTrd3F4cnMRzlAmGbdt+s7VQcakAAAA=
X-Change-ID: 20241017-sar2130p-pci-80dae35a67e8
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9UsApYEDGH2IHjWwMiu0TWBdNEwNiQK7ZA2hUV9JAvw=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2ZDJv/U4UT/2kI4DlpFLm9NwHsC2dpNgv+l
 oFN2nz1Xf6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmQAKCRAU23LtvoBl
 uC3ZEAC+Z7R4UVrh4IYMMo2C4ZHT53ykjxHNkmsSr30b1Jzx/2U7M5+GoMveEo3ji6gJ0CcmcAB
 wYkgbUk7VQVstQY4cIypyLSl6O0XLbPFHr3GavLAqOtrb/Fa0FjF9+ZgYLJFLeP0CFzquJvB7Kf
 8cn4nzAeO5jczYKbUAf2R1qI6S9jRxWxTH3WcEq8VJh/cyGiw/pHJeVVTI9FwPgjbkcAHbIO3Ei
 IrBd7fA45s/Hui1T6RGd0ohm/gGBaxE2OsfqEtElMoCwXWNljyOsB4TbD0r19yG4Xet1mPJXZIU
 +rKMvHFXizfAVwhLZjKT/7w7kCfOO1iLyWEfWefTi61KfzAIa80aLUNarczHFACybLJUAL5WFvf
 lp7yjNl9A/NnaShFinraIYOOqd4wOcSWsO9GL/pnPpQNAEOmb+q9gsbrxQVZ/OJordzj6A/oNVT
 D0lIiVj1G4SCNSbJydpD+3pHnvBQ+DZhpK+qWrTKuhm5P3/20StCqdrKjch1zHh8eF+dw0Tvy0A
 VHw2QTnj5eietIUWfIwhXWyCxSPQxywaCeUGa1ANiyUrtB5JJrPZC3GlRsDWQasEmLOBViFrxYb
 h2hkH+f1b2+KTOa3FeDyTDzbn/8o212OoTXXgrhiLeHrM4tw/OxgM4/ohIeEnmzkcr+YogBHJxr
 g3FoRgoJDlpjWyg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Update the incomplete SM8450 support and bring in SAR2130P support for
the PCIe1 controller to be used in EP mode.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Rephrase IOMMU commit message to stop mentioning eDMA (Mani)
- Explain why it is impossible to use fallback compatibles (Mani)
- Reformat names to vertical lists (Konrad)
- Use ACTIVE_ONLY for cpu-pcie interconnect (Konrad)
- Use tags for sm8450 interconnects (Konrad)
- Link to v1: https://lore.kernel.org/r/20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org

---
Dmitry Baryshkov (6):
      dt-bindings: PCI: qcom-ep: describe optional IOMMU
      dt-bindings: PCI: qcom-ep: enable DMA for SM8450
      dt-bindings: PCI: qcom-ep: add SAR2130P compatible
      PCI: dwc: pcie-qcom-ep: enable EP support for SAR2130P
      arm64: dts: qcom: sar2130p: add PCIe EP device nodes
      arm64: dts: qcom: sm8450: add PCIe EP device nodes

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 69 ++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 61 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 62 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
 4 files changed, 187 insertions(+), 6 deletions(-)
---
base-commit: 34598f5b38950c59f15caa5194cfccbf6ec03c99
change-id: 20241017-sar2130p-pci-80dae35a67e8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


