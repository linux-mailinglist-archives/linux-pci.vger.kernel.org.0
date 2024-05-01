Return-Path: <linux-pci+bounces-6922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D498B84BB
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A51F26783
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416651C2B;
	Wed,  1 May 2024 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTVF8lzV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E550A6A;
	Wed,  1 May 2024 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536508; cv=none; b=UM70P7Uxy9gnkF1+TDd6IAzLUYpyMOYKrKegP/YVPPGdwGwaASVCxtnBzIl8qsFHyDRxy8OXQaIShKw03lQVtgWCuMLTDHoLf+oh5Uec5c/eCAMrEpQz4X4JHYiA8irAaz1mm6+knBH/xkOqoP1NePvHTptFmJCky4bStidaepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536508; c=relaxed/simple;
	bh=2cKONyUhvqsDbdbaoKbjY2AvnOp4SE0Z8KCFA6jaKJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktwtTNqhX+PJsz5rStRs5GV2K35kWOqUKi4pbTMgw/yWS7mRN9EI9iF8ovRUFBZcd6S13S+bBYDEQpBtY4QRTglvt600L5UXtIN1T97Xd2+BH67tI7uKAspZkjJRfHPqze381sIYKHZTYMubIhLMz7Jm/OjBOYtnlSzKtGWjVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTVF8lzV; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c86f0661d0so207980b6e.1;
        Tue, 30 Apr 2024 21:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536506; x=1715141306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI71NoupknAET1jl5DuELYiP8ivpPOCBg6fYut4RUIg=;
        b=BTVF8lzVDLE7EimODO6nutRikMcnlscR2KAgdxCltJBUvC40ab6WuJeet0GRlRijuQ
         /Y0/Q+JcXDGaMuMWUkR26aToy7KZgCboVgFWPP9XpNed13XM6i4h1NQiI+A3CIz/QHgl
         KgSy01/ny0TYASZAfLc8d/5dP4kJwSy0dReeGBJSRxoeuwskucenX4FPAfh6vV7Q0BaY
         X1ZY5AtB9VUZ2POpU3BKSbcwYYEm0QsgcfZ3S9FESLMLfOtAgJT3CIKfme2Hu3SJr20z
         2+Enya/GlLwsAo0kLmBS4hTKrXd8C5Ud6qkhuL3XrWEaBYPVio7EJDJcWpAwgbMNmEZm
         +wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536506; x=1715141306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI71NoupknAET1jl5DuELYiP8ivpPOCBg6fYut4RUIg=;
        b=LQlzB0fCvl6UM1iObsLUGjdkqs9ksrTDpEQaKqzFeonQZvNF7GrO6pqfrQwLem5lgo
         bLjhgq/WN0KChxFu+yfCsGWKQBm9TkWe2mP9ldnpUdPLgKXzJR/K7xVkwX3Hz7SUaOC5
         G7q9C2YEY/CfT4YHBiyrNv8cteHlLI6V+Xj6E/hZWo2GozmG71tbXln5n4AjCekr6Wxn
         sWzNFN1mCGC7UaWzuXDNGtcAb3nNbMRmjVfdYdEDY0P9tJT0r+S5qybo7HuUPmPbWfWu
         7O+1tMWNXx7jCcKAAx88LCDIsM8CZCkEOnqK1KAyQazFhoESaSCMOC4l8lVRmGXMexV7
         WBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWryS6M7iN4T3FRbq6Ge8mlZ5cTofqGQ3K2DsNmNAXo1Y7lHnupY3nzsK4fPTPAhnljq+lcQL+EpOjsL6HwCDAXrkjWLDcoqzBAYCuc5kT9Z/HHBy96Kd675vQWTcLh9st/fsmzS8zTRQ==
X-Gm-Message-State: AOJu0Yw7cpiwSXL/5dgCTgpl+Nuzt4wyCgdM0chbUW316M7mtYfuCbqe
	IXHNWmTj67Vxl3GC59T6DbD092SVFs1Pd62+ZcC4/Uhf8HHB0WaJ
X-Google-Smtp-Source: AGHT+IEOEA0Nz3fFxE/btpAm2rObYRw3PP0PAwdDEnbLI/kZDSRXDvCSKfVwM43CkCB2K/uZ8BEgbA==
X-Received: by 2002:a05:6808:1589:b0:3c8:2fc4:c387 with SMTP id t9-20020a056808158900b003c82fc4c387mr2170081oiw.14.1714536506017;
        Tue, 30 Apr 2024 21:08:26 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:25 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 5/8] PCI: qcom: Add support for IPQ9574
Date: Tue, 30 Apr 2024 23:07:56 -0500
Message-Id: <20240501040800.1542805-15-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPQ9574 has four PCIe controllers: two single-lane Gen3, and two
dual-lane Gen3. The controllers are identical from a software
perspective, with the differences appearing in the PHYs.

Add a compatible for the PCIe on IPQ9574.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ea81ff68d433..e61888e6c63d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1551,6 +1551,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
 	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
+	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
-- 
2.40.1


