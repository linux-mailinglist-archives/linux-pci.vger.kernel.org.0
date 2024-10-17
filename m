Return-Path: <linux-pci+bounces-14822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDFB9A2B9F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 20:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CB21F240C8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563141DFE23;
	Thu, 17 Oct 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTlbmQ/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2201DD548
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188298; cv=none; b=CP9DO5AkeTwc0VLSkyarEslULfdWroLZn9GBSNbRLJq6rZcNjUkoItv+Kr+kI37jSGzLTXFFD03aAWU6fC2gRNpNbU8UwMbGe1UWF4w3hxUE6RzK8emyiQ78w2unYSScaBA+mvwf4QbkfvMYCVTuJSyyq9RqiokNWsDa0VNQpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188298; c=relaxed/simple;
	bh=O15mCh3VtZU97Mpx6hgeP/jWXAjP95Snr2eA5fDon0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=odcmceAWjtpGM1tm1V+QuyTIXOU38fKu3rE8XSGK0D6BvRd524I/fgmezoBPG7La/2JI5riiWFjiEclWl/5CivtD5eaO2iLi7Pcu2a/oj7NyiF7Ze/yvkhrlmL7KxdE/3SHLMN+ddSj/O2JqbLGM9Wp5rIWOKkbmbd/FNO+KcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pTlbmQ/d; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1856617e87.0
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729188291; x=1729793091; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaymF0ZiBA6V8Fk87JggRvX+rVkin1b9pjhriuc27Y0=;
        b=pTlbmQ/d+gL46Dwelxm0zknNBSNnSbZF/+KyiowAFCFexcvkIWcaETHN+CblHQc9UI
         EjGxPao+pKLiK+4/q79m5ZDroquXFPHMPgdnc6+YZBKKJ/+sGZtFE9KGsDzcY0ydw5t0
         gV3kwhHIuUt9oqn+bmqcfXDYebQUQYzm7dd4/THk1jT/mOkcd9Lkpf6ohi2l67zUhycm
         Ui8qVIbERCeddqFiIq4w3gt7mr420t8YET8tIlnybfFmkyP+ryKO4RmOkFe1cEBz/6G+
         9Gb84ZtVCl2a8uOUPlV/sEUNRIWCLpUbtoHunUSOUBR1kr9Vcv+mEYvgFib9RP4YcJYg
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188291; x=1729793091;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaymF0ZiBA6V8Fk87JggRvX+rVkin1b9pjhriuc27Y0=;
        b=PMa+5yErFPG6fP6rFRlIl7vwlL0q030TtaxOxMV+BRgpC2vSyex8v7WTCj8Q55CxPt
         Z6ZIIfr5cX2zIyOROAe1yMucfW6lpP/XAPm4D+6dXi4Lg9oTyKQa7a26makB6dwF/roS
         LZOsBtKDnXnCmEZ0mHEhW8npB1DcoQuE/SBiDfSwAbVW2UN4AKJdA2C344uvAxTXKY+t
         4cnr0X8fTWiRBWp2jGYWi1YkPCcdnybXc4xKZ0Nx8oBel3tyf3ClYlG++NPdrJKJVcsa
         kDw64S27Dgx6SKt2r9saeakzBjJp5j6d089hhB3Muc75R4NMOE7LC32k6z4WCq/WRKwP
         dRNg==
X-Forwarded-Encrypted: i=1; AJvYcCVpa7x4fxqgp4vfiZI+jMtg4MvA9U7sDZCysv7jB2VjKUPNgVaVuszx8fYFJkPjiVlDi9WcAeFyODs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vQRACn99wcZ+Ep4nop0OwTv2JyTPfvV2y4sG2Vmtfct/D+1o
	zCrpvoS/IgTcyx6Diy9QuJRPi7Vr3tpqP4lhHyXmcQEurb0S7vVBzrC0mwPby4Q=
X-Google-Smtp-Source: AGHT+IEtaSRfi/zuQd0/3BxDiMd84LqpMen+1AmFAWxym0m/1Njhxs+M7M01GS96rbcHuSvVwJ/8mg==
X-Received: by 2002:a05:6512:2244:b0:539:ad93:f887 with SMTP id 2adb3069b0e04-539e5522d3cmr15495948e87.36.1729188291239;
        Thu, 17 Oct 2024 11:04:51 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff3ddfsm826195e87.149.2024.10.17.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:04:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 21:04:47 +0300
Subject: [PATCH] dt-bindings: PCI: qcom,pcie-sm8550: add SAR2130P
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL5REWcC/x3MQQqAIBBA0avIrBN0CoyuEi1snGo2JgoRiHdPW
 r7F/xUKZ+ECi6qQ+ZEid+ywgwK6fDxZS+gGNDhZY50uPqMdTdKJRAcyhLiznx1DT1LmQ95/t26
 tfUdn/YZeAAAA
X-Change-ID: 20241017-sar2130p-pci-dc0c22bea87e
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=O15mCh3VtZU97Mpx6hgeP/jWXAjP95Snr2eA5fDon0o=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEVG/8G68/lf7OSluZpPo++4hB+Ws2ABn0W8AS
 w2HBjUHOKSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFRvwAKCRAU23LtvoBl
 uDRFEACjiiUvc4JlyT2BHMwSCQBB6n2qjwJjB4kkuTTtHGHF+okKp8yzFPhmFz9ciLyRfK9PxG0
 kmHEh18U6z4glv7vUbjSaT4wR8gphPEyKAHN/gpXEikXSzlsFKCrwUoghPyDrqEl4+i7yf9Aepf
 PxIp4xfOBzW4QdR2ClFzmPQky3yO2kNXHMO1jH4JyNA0TZk1K0TNRAXlfzND+gh50INLD4eJfMp
 5AqY4nlKURTtrTIwhF0Zwp1t3rXAE94Bz2wjfBbXvwnWUxS+PXQ4K60bNcLjJ+2piuKDlcHlScH
 +eYTeE5Axqm0GXEmyxyOfcX/KuXwMoWl0+NNlSnt1iWhDZPkyLVcQxWI2uAwjy8stLVU8LGItR0
 mABUBlaZ0ATnbP9u88hF/9WiBvXpbhzQvT6U5tzjcv8T9z35xOxzA0l71yovAg4dBX0SdSxS72Z
 MqCVCEdMZSYDh8TScFbynwLi9t+JR+5Af1jls04vW1p0agbKT4dMtyHp/jhFz2ypUERoh4tWJYj
 1n/bLUUV3pJPrqm3HO0Rv0HaGGBiRWJryPcXZWBMUsjDCWg0Xe0dVq+Ky6+b/WX2tXnGol7qbUP
 MnAsIKNnKR3QLNiO7muZFaciN316JZlLBfvEByXZEJtg0a4XfyIpar8qlRlyFS10YWX9RgK49gq
 SIqdnb06KAadgfg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm SAR2130P platform the PCIe host is compatible with the
DWC controller present on the SM8550 platorm, just using one additional
clock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 24cb38673581d7391f877d3af5fadd6096c8d5be..2b5498a35dcc1707e6ba7356389c33b3fcce9d0f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -20,6 +20,7 @@ properties:
       - const: qcom,pcie-sm8550
       - items:
           - enum:
+              - qcom,sar2130p-pcie
               - qcom,pcie-sm8650
           - const: qcom,pcie-sm8550
 
@@ -39,7 +40,7 @@ properties:
 
   clocks:
     minItems: 7
-    maxItems: 8
+    maxItems: 9
 
   clock-names:
     minItems: 7
@@ -52,6 +53,7 @@ properties:
       - const: ddrss_sf_tbu # PCIe SF TBU clock
       - const: noc_aggr # Aggre NoC PCIe AXI clock
       - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+      - const: qmip_pcie_ahb # QMIP PCIe AHB clock
 
   interrupts:
     minItems: 8

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-pci-dc0c22bea87e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


