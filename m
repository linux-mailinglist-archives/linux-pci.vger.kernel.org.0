Return-Path: <linux-pci+bounces-3325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6A85058D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73689B224B7
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C25CDFF;
	Sat, 10 Feb 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+ao3uEv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7E5CDCA
	for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585017; cv=none; b=r5L01DZcS3rj1Jr+xn8/aKGcbhkTmFkXPazasVDk3cD9uDGqWPGz9wBJutd07UFfirLNB+V1R53mZl/9ngIBeBDyp7t/gJtFCXfX5E/Q0fTXPXA7cqwTUA5sxI5DiTOS7MtzjSuoNvFKdrbbFqQtv5HApvp1OJx26oVCHZVHUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585017; c=relaxed/simple;
	bh=Q/tkGNJIBJXpyEDTXFQsgKm/Jzq5e6UGCxuEuvZ0MQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2g+xA03Crr37wfQo2uuR0vJ7XQrEGx/OtPPDpln9oBB2DAT6oglL4jMdf6TWf77eCtvZuQuTsb5IdVi36P92KX0aCpKE/qZtanbjNDWSG0+tGbAuZKFjbC13O8h9gdEitXLlGCkSNWKO7M0yhBmqOV98H9C+KdwpfV5T6RLosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+ao3uEv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so354031066b.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Feb 2024 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585013; x=1708189813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4uw6U5ne+R+sJJghVlkDrwwqaS/V9vKBh8/gfD/1Fw=;
        b=G+ao3uEv5toX1HfCVp8O/c/67NMiiSd0y/3OVBnQ4IyTl/pexzRNHKdrlWRAP6zVk6
         mZ/MxPYKdb45AC6ZIbspp5cQoDrdZfB0IILIuUNNPdILBlCnX+dN3dVWTSVIidDuvhu/
         m+rladvPcEfjndTvTT/UpFLhAKJf1TVDITRcrusu+u7CetBT8fruy7XUOpUjecBaOo45
         kWIj5pIEHY7yxlHZ4shHFIv/VmyRNYByzyNVfGO+yEh21xohlDVd2ydAVJqZNl5n2DZ/
         VmgI3IUXcc8gmyNLJbhmZEbbDH9L8IlSk42ZgpW3E51628EX8QHjG8SZxbogEZhziTVB
         9svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585013; x=1708189813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4uw6U5ne+R+sJJghVlkDrwwqaS/V9vKBh8/gfD/1Fw=;
        b=T2RZSrMLGLAKfVZSV6BQU3gjBFt7Ok4b+JD7v4yrCx7q8j0Au6i/siAruQoJU/mIp5
         osErj8XRKc/o+Tn7HBA/7n7i095A9fdbLK2tv8TnVMOQrEUHt4f4vQ71XBkM54TdjMAz
         s1rjaWloIErdaRbf8v5cf1qOVdd2BfjM3xRab/qwSvFypO8yizTQFnoW9qKn/suYjn7h
         GiB9TS/Xkc2WLfLl5u9ShOxkX6npdyYdjLZyaa2psEWpSILcepgH+dpG+V1yCMA5s7xM
         PCXiYIjehvKOSrPAvdqY+5WK9gsvk8JxmNM3nWhTO01Hdbtdhxc95APawl+/HXkhLep7
         p9YA==
X-Forwarded-Encrypted: i=1; AJvYcCVgSHFQ5jaVrvm8NinLARk/hG91wQHvG+CxIfjib/juzIFZ+jyGKtx2zTT1F1nyV/z0Tjty/Mu/vlAxtJ/x3kFeGquRcFW/SiNP
X-Gm-Message-State: AOJu0YwnLvBIH6e7lCeJ2Nqa5J6jKNCFCblhOH5PCVFC1s/ts5Q4mol+
	onYsA/0+MkR5rP1cyUsGd5U+9VGGp/j9ow1WdciI/e4lclL0ClmhRaj56PwQbW8=
X-Google-Smtp-Source: AGHT+IEWBD/YrIDuofpyLF0Bn38wTBLG3x7OxG2MKQ+2xkzcE18D1qoRpWnshledBQN9Fxw/QD5YSQ==
X-Received: by 2002:a17:906:6a11:b0:a3c:458d:a1a8 with SMTP id qw17-20020a1709066a1100b00a3c458da1a8mr1320996ejc.12.1707585013633;
        Sat, 10 Feb 2024 09:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkSLJ1a5g8IPS4jmUAHg+1UemkoLGyCjbQ3H0wNJUaUK6ogLUfJh51CmnFxnjeTPRDqB6bLet39f6SWeZYztiCH/ZE/OTY36NI/3tliQmiKYSLnO3aJgyu3kxnZwYJR/SiMp83N/eNdivQvC+HART/Ul9ugkyi5GHa6IT/woPQW/t2aPSFVZAO3NuZhWsfiN0AnatAWNiZkcCCUMQIYMUH2O+arWfIYG5nTKTQhgdncWnSCtlE30pph23wyeyUe1IzSVs7OT2DeW+5Lpr3pBHgbKtQMKiCG2ACpcyznMs6qt/E8isx+6EnkRIcXTaXRDA9Sk7//FGqW5o8bjBhLRMl5yQIWEwBTrz4t06hX0XQXbFPZ6kmJUpWnNisWxul3Q==
Received: from [127.0.1.1] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id lg25-20020a170907181900b00a3c1e1ca800sm973242ejc.11.2024.02.10.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 09:10:13 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 10 Feb 2024 18:10:05 +0100
Subject: [PATCH v2 1/3] PCI: qcom: reshuffle reset logic in 2_7_0 .init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-8280_pcie-v2-1-1cef4b606883@linaro.org>
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

At least on SC8280XP, if the PCIe reset is asserted, the corresponding
AUX_CLK will be stuck at 'off'. This has not been an issue so far,
since the reset is both left de-asserted by the previous boot stages
and the driver only toggles it briefly in .init.

As part of the upcoming suspend prodecure however, the reset will be
held asserted.

Assert the reset (which may end up being a NOP in some cases) and
de-assert it back *before* turning on the clocks in preparation for
introducing RC powerdown and reinitialization.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3bd932b..cbde9effa352 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -900,27 +900,27 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 		return ret;
 	}
 
-	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
-	if (ret < 0)
-		goto err_disable_regulators;
-
+	/* Assert the reset to hold the RC in a known state */
 	ret = reset_control_assert(res->rst);
 	if (ret) {
 		dev_err(dev, "reset assert failed (%d)\n", ret);
-		goto err_disable_clocks;
+		goto err_disable_regulators;
 	}
-
 	usleep_range(1000, 1500);
 
+	/* GCC_PCIE_n_AUX_CLK won't come up if the reset is asserted */
 	ret = reset_control_deassert(res->rst);
 	if (ret) {
 		dev_err(dev, "reset deassert failed (%d)\n", ret);
-		goto err_disable_clocks;
+		goto err_disable_regulators;
 	}
-
 	/* Wait for reset to complete, required on SM8450 */
 	usleep_range(1000, 1500);
 
+	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
+	if (ret < 0)
+		goto err_disable_regulators;
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
@@ -951,8 +951,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
-err_disable_clocks:
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 

-- 
2.40.1


