Return-Path: <linux-pci+bounces-9962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8AD92A8A2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CB51F21E2A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3D14A0A5;
	Mon,  8 Jul 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HimCvSTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AB148FED
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461950; cv=none; b=ua8Z/k7TTVngyaDOJxl8sWSsydHZXWhkiHatE+9OPfmhLHFPLveZcn3otaNfOrGsg6GXK4l4B1xQonkEF4mGPh/MgO3cUFkfQX1+H74B1YzljnmSu6VhyrdkRwuKxMzhSYSsFMUi2oxT4XlgG1cEFvGZuQA7NaX7LW81K7J7JBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461950; c=relaxed/simple;
	bh=8RLjAkvbd9deEwBz/GOWHSJSSqFw/q5XUI9esz1VxSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJnlvOSynutAIuzRTustRuxHBqeiwaXluFD6UiSOcRaDuKWZMfDqdf1oosLoAHIXiqxTSzdW/RIY3kvARIjN8uGRqZ02dQ5DHEF0PbrSG8+wbR97wTAhpDODI7M6PW7Bi6ll1gcxGfYWVpLM0rd1VE4bkD6pfn48wWivhvgB/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HimCvSTo; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d92aa6b62bso1204955b6e.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720461948; x=1721066748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxcirFeeuu0bt0rjz0tmui1G8RYDC+/JunVt8zPPRlg=;
        b=HimCvSToBRd0wyTWybX3iK/ljx9N7x5Kf6z/EztaEn00F9+Rc/ww6NWSERNxX9I4Dq
         u+UtQxi3iXxQNkDgvdHx1UcsqntPliN62vvsQ/GpcQJ4E0ypmkDJXAOVxHxd6mlNy6dc
         MOICnrtX6KhNXfaca8UTv6HI554B4n+jJx1IDSv4xX9gJeaJZsWWfunwwb1hcmouE2YD
         iqs1oXW97dkfpIPtsOx6NQSWjGMcvUbOxSUqfi+dLduw0+Nc6ghLHJvkcSnMMnX55gsI
         aQsIJitQOMgWfJpL9DFN3ZhRmfzZGNEIPU3akNE9B06+1casa95QtMuz3eJfAtGvIH6X
         Y7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461948; x=1721066748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxcirFeeuu0bt0rjz0tmui1G8RYDC+/JunVt8zPPRlg=;
        b=l7WI9uaZa+QLo+CzYiCa3d9+0ZuElJAZx+Bfb6ryV12J2GhirQmk3LRxYzn4oAK4V3
         M2kqS1FgiXnB9gbZ8oGPyF0y5VEA/yLaSoghdJd5hDHYqSqU+MR01aTfUrXIhor1NM8D
         VSH86e9u7vqHu9xATj9DYkRo3LCuYH2jPBvMaime18YTejbQ2iVm5cUNgDPuVJl4sE+9
         uoOryKdEdIGNQ8+pXD6D9g5aO195RtqUmdNWeOxUoXvoX32myfsNyn95B0Zp3ogP3oUp
         /9lUEwW4QZTPI6c80BVV6uZmxUhqERAmsA8csATfd4UsMR70MPnGoX5VT6oP8kXraI2i
         BcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwkqYAK6ZlIVETdJ8PeCCcKNQFBLOYM+DRSFLgaiM1ECxyPZiHVwhel4bQLtJujradn601FDr1Yh33VRIJ/DMVc9/kp/BwodUj
X-Gm-Message-State: AOJu0Yw0g/+XY0QmrqvDqvSMkSUNkQPGz7shCPr8I6hlps2DXRSSKuYj
	JJju+PbkZdvblnfurOQKTGxsBItXiq3T1ZYHPjf7V4mM24nwBLob1iA9AmvpEg8=
X-Google-Smtp-Source: AGHT+IG8otGIAka26ozpbixMx1Ghd9XSCzhxkO203rOwzFDNLcLqz5bFlnD1pgUMtGdNE1fgcqq6yA==
X-Received: by 2002:a05:6808:10d5:b0:3d9:3802:3855 with SMTP id 5614622812f47-3d93c02038bmr176901b6e.23.1720461947976;
        Mon, 08 Jul 2024 11:05:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff184sm76287b6e.10.2024.07.08.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:05:47 -0700 (PDT)
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: qcom: Prevent potential error pointer dereference
Date: Mon,  8 Jul 2024 13:05:37 -0500
Message-ID: <20240708180539.1447307-3-dan.carpenter@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708180539.1447307-1-dan.carpenter@linaro.org>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only call dev_pm_opp_put() if dev_pm_opp_find_freq_exact() succeeds.
Otherwise it leads to an error pointer dereference.

Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1d36311f9adb..e06c4ad3a72a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1443,8 +1443,8 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			if (ret)
 				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
 					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
 		}
-		dev_pm_opp_put(opp);
 	}
 }
 
-- 
2.43.0


