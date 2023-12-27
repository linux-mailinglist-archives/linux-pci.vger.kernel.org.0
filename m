Return-Path: <linux-pci+bounces-1473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4281F257
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 23:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC5283EAB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2632482ED;
	Wed, 27 Dec 2023 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5335x0G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795B481D7
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2330a92ae6so624956166b.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715456; x=1704320256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gK+Z+cJ3q8PnVX9vvxAmwYo7P5nCQEAASDVIG/h3FtI=;
        b=A5335x0GpX/qFf1RFyxvzOR+PyrltkD6t2s15lZXqFnYmvTH4o1Ql8LvlFYynTpGbb
         WbXGkIhS+ooJApPZfKI6TB5MuMQtQ+CZnXgnVFkw8mZW2FU+P3kUS9DhiiGT4oVrVBXF
         B2lPd8+/CVyHMKAhsXoFtNRgH/M0iMHdB66fJzsyFrUyQ4ngzXwTFawCb+ADasL7EBZR
         c9m+pq0yJPBkNavajT/8I6JYzXK1dszS6CsN+S8vcylq6zBxmpookvwBfkvqjIeKwZPT
         TaxwSfQZjyo7tGCTU5rHK1SoezqnJCQs+MpA3/OxS/Uexz9tvjgVAGhCWyp7zP571vuC
         RkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715456; x=1704320256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK+Z+cJ3q8PnVX9vvxAmwYo7P5nCQEAASDVIG/h3FtI=;
        b=QUZDjjw46nB6RNdwJpTZZWgpmMu1dmv+a0Adnaittgwjqigu0Nsm63m8OIpbBYxPXA
         ydqRJiSfE7KNTMRtuqdviUkUgBoGgpdyBZGEBf7U4QgJuM9UzAEkCfg6ZLFEXHy8zWDo
         ve06Wn8g698EILCYkY88u/Wznmzuu1tC9wh0N32SQ5e+EVpJiCqqs/BW9KJB0vrujesP
         TOudFqo7ZL4vbHB3Al2A6Qe7d6Yw/19slp+54ZJz3sNs1BIFubOIAMc3uiIjsNrJHjNF
         KL7pwDeTiVyTv7rVL7qLf4J+6JSDkEDDhGub2OBWTOmsUqhJgXyjDrf2G9ZbjQ/9QWzj
         U9lg==
X-Gm-Message-State: AOJu0YzWPgYQRnDwIFkemHjdBvW+h/id+aPRA+aNB4N3LazPs0EMUe8E
	96aOwMZm3IMxExF/fTq4jSsd17GF5NjnQQ==
X-Google-Smtp-Source: AGHT+IEmGdAlzrAbtuChQoDwBsNDjEF9H0lhNM+GWDDSf4l/AEqFQDlgBOJqJA7RA0Rcl9c75JAhPw==
X-Received: by 2002:a17:907:710e:b0:a27:59fa:51de with SMTP id zr14-20020a170907710e00b00a2759fa51demr376464ejb.0.1703715456417;
        Wed, 27 Dec 2023 14:17:36 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ka12-20020a170907920c00b00a26ac57b951sm6245712ejb.23.2023.12.27.14.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:17:36 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:17:19 +0100
Subject: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
In-Reply-To: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715452; l=2311;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y85jS3ioUk1DQv8qH2gvXdl3T2x3NSOAYdPJTx3pyQM=;
 b=hoXqb4uT3vpTCXfQv6VngPZNtLPyrOIl3j8S1277XzoP0A9AZ2jiqAbd2P3bhkGsgoYh1p5+k
 5ue8mA0U803CdHHnSBa93k4XkY3BdR9CeA7LBCBucFfkLjuLg/uUtYK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

At least on SC8280XP, if the PCIe reset is asserted, the corresponding
AUX_CLK will be stuck at 'off'.

Assert the reset (which may end up being a NOP if it was previously
asserted) and de-assert it back *before* turning on the clocks to avoid
such cases.

In addition to that, in case the clock bulk enable fails, assert the
RC reset back, as the hardware is in an unknown state at best.

Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11c80555d975..1c5ab8c4ff39 100644
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
+		goto err_assert_reset;
+
 	/* configure PCIe to RC mode */
 	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
 
@@ -951,8 +951,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
-err_disable_clocks:
-	clk_bulk_disable_unprepare(res->num_clks, res->clks);
+
+err_assert_reset:
+	reset_control_assert(res->rst);
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 

-- 
2.43.0


