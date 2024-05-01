Return-Path: <linux-pci+bounces-6919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB188B84A0
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B4B1F24C4C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CA481D7;
	Wed,  1 May 2024 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqnpAGDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F547A62;
	Wed,  1 May 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536493; cv=none; b=LQqplOL0AM6azzb6EyffmQGNO7upaDDZQ5TQH4OQnWgNO1buNnbEuw6euamCUso1xvu06mM/+fJey6I8ALCF6W+uHMnT35AHNXuZ8lPRg9cYnjonFiqCzTpmsCNedWSOZNFO7WxUp5/vpVLTzL64HMhJIl/95nv7nyqrAwjSqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536493; c=relaxed/simple;
	bh=2cKONyUhvqsDbdbaoKbjY2AvnOp4SE0Z8KCFA6jaKJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qw3RJCyoEtUNt6RaQc5SbTj9mF5imFiRWj17p3O/T25i05k9VXUaAw7vAmlfdjrkYQZOYfEKZ8BBOK41xdrTXNMrbJmZT8nigLLrFms99Z6RWm6Rkz+3rKXKtwL0JMdJJbfYVm5uXipcC41EMQ2I4DLxeSRaWA3svTe1rwVFHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqnpAGDR; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c7513a991cso4345180b6e.1;
        Tue, 30 Apr 2024 21:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536491; x=1715141291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI71NoupknAET1jl5DuELYiP8ivpPOCBg6fYut4RUIg=;
        b=XqnpAGDRNHbXKbPJJSilIy+sOtTlD8kQtWYsSlzUgjFOnrh28qSQah6cThcb2FheXI
         9eyBJo8QtRdg/kQ4Sv5Uvz8gTd2297GG1FSQz9Lny5SmrCRNN74G/S7MgVAG9k0StXfr
         bhA8BNjBfE3bRwdA4X905JY4554UhaVzDfAs45QJRVbwnEyoGML6K3BTPghmxcl3JXTx
         Evc+XJR3KXosZedpZOtu6+nw2pN0FKtjf4h34kwCq2oP8XbvKI4aSrV34rMH350kOPg5
         tUrocuKpVSXATO348ZTe+N39F4qoObJ+U36DltZA7jTrNWgfn6Nt/tbhif5HntUok5Sp
         O9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536491; x=1715141291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI71NoupknAET1jl5DuELYiP8ivpPOCBg6fYut4RUIg=;
        b=mX8QHka32BhMQJa+ViHbqpKQZq8BH+aG8E78q19jG+14bC5mekGtP9VVkLTlsOD1O4
         QwGNr8w3f81kjNtxRQOV008hNjsz63bitZieDoReSmWO+5AFhjJ9Uqw9pkHj6+1Guy5l
         Ckgia4xFfSpu2brhmZKcDJ4Nh2aSD2UjASqw6XMhBdbR1MaGlYW4Ys79C2atkm1dUSwS
         a8en5FI21zxxe60cXnVqNzMsiMGmsmWyhG8WygNSvidzjJclKLUdu8nK3vr0kkMrNXnt
         DMm2FI1AClj79OAbgdtBaLZQ2H7to6KIsbtEIg0E1faiBsslqSpgsUF0LHsgWCBr4iIg
         747A==
X-Forwarded-Encrypted: i=1; AJvYcCXzhOYLpHFPnGbcMIRaJ2EaJItYjPARiaOj4R3ygusvQTgGv8nIRcrljhVNbl8hIshaDKNDTJiJtj5VkUpfl3JL4ciquxqLyTZeQQXoDmmjBfZoYnLrDbo2uTePczvRIylGbs3jBZsFMQ==
X-Gm-Message-State: AOJu0YwQ49WXPQmHBt/49nsB1B2uirDu1fmQ1/PuuOSR5Wo2UolgKwRf
	g4SvjfiY9cLvR+l5zsvy4wxIhTlCcLFKUUkpvd+WxYFhCoj5LtPp
X-Google-Smtp-Source: AGHT+IGWkFSZCO+ZZ/YO1r4ABUoLVDbfdhiB69s9e2f41K99hiJkGkFuG2kvrL0k3rjMtPTuJWCe5w==
X-Received: by 2002:a05:6808:1919:b0:3c8:4228:e6d4 with SMTP id bf25-20020a056808191900b003c84228e6d4mr1973871oib.9.1714536490966;
        Tue, 30 Apr 2024 21:08:10 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:10 -0700 (PDT)
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
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/8] PCI: qcom: Add support for IPQ9574
Date: Tue, 30 Apr 2024 23:07:47 -0500
Message-Id: <20240501040800.1542805-6-mr.nuke.me@gmail.com>
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


