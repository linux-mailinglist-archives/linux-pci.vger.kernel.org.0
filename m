Return-Path: <linux-pci+bounces-1474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794381F25C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 23:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B93E1C2269C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E31481BB;
	Wed, 27 Dec 2023 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzFB0SoH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F444879D
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so67803635e9.3
        for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 14:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715458; x=1704320258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL9QepTktwRzfZ1qfRmphE2ZEXra95fLycdHekby0tw=;
        b=SzFB0SoHfO6lnGAoYKGzsl3LyvoA6zou9C9a1N9/RGZHVPq/qEZzGvy9BaHFI+rDG2
         Qn4Q9xR+8UfeZhsxpyfvNHKwWV7ZjIE4BKOZd23Rnp43CaGGCZM1JyfPbdCNlF2Slpav
         pC9gNcJ8JOY2QsZZBj0uQZYOFOdj/jFw3EE3cIMMVH37A6HZYrtij9pwfHO/VsXK1tl7
         2xUiS4fwpGr4Hb67G5iZfbV8Eq7Bpa7rMcCKcyTQipG0WsY03LzU/lCc2D9tWC/Q5j8f
         2LxFmOuJIBBVtiDYhNNAdX6gIkq+/MgYYvywbYjwDUKXU2WWxHch8ao/M9+P+iHz8GAl
         9wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715458; x=1704320258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL9QepTktwRzfZ1qfRmphE2ZEXra95fLycdHekby0tw=;
        b=bZvgw8xGEI+cj/rkUwClp1a/IIBYjhamODX21GnuY9zAD2WQc5VvgPPegs6D6Nlw6b
         eF/LJQWypd89HQ3CbHWXyRKMTNl96wugI+iFqbQbI2bbR3QUDFUeKyqDDXvWYcf00nrC
         XZmTy9Pu26MY1UdnnLyZ1YdtuPvrEu0pTohC5RFT0rFzqa1OT4grd0amBBn8Pue1/ae8
         hY8VnsEdSK6Mb0fYKbxedmSOWIXZ2weHxw5X65/Of6E+Jru9OSmd3P9zW0bzmevPB3hM
         jbqMJPpYjef05/to7qlsTAflHsPc5jCjCMWKUFoIqmIYIQ6HCOL5kI1qfcSYTrY8yIFj
         c+6Q==
X-Gm-Message-State: AOJu0Yyh+nXXJCb9AoqtnSPmG6jPuiAHjSDTJcZyxBslCgfLHvCvQe9C
	YCtIu8PRpnDl5q70dqeDxdggNHLvsa217w==
X-Google-Smtp-Source: AGHT+IFKSca7nTTTQLFFlnwqXjCbtcDKKbUOZbqtSZT1icxeWa+sWDrNIIqnQWtn+IzsLjf8TSfnyA==
X-Received: by 2002:a05:600c:3d0f:b0:40d:43cf:275d with SMTP id bh15-20020a05600c3d0f00b0040d43cf275dmr5306262wmb.95.1703715458571;
        Wed, 27 Dec 2023 14:17:38 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ka12-20020a170907920c00b00a26ac57b951sm6245712ejb.23.2023.12.27.14.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:17:38 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:17:20 +0100
Subject: [PATCH 2/4] PCI: qcom: Cache last icc bandwidth
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-8280_pcie-v1-2-095491baf9e4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715452; l=1504;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qF9x2W0s+UbihjgEpXNx/tQIgEfBt4CokexyeClTC+s=;
 b=Ut2csbDk7i4ucgHp6UiLrRct7RJZYvkH0BNoyJ8o1AoM6NSg7odFU8uAlhMsvQEgQQw386KHm
 heme3d3SgUKDZ8ZSDcx8Df6lN0kgFUqgL2+0+7MI/sZqxjzPzB0J705
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In preparation for shutting down the RC, cache the last interconnect
bandwidth vote to allow for icc tag setting.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1c5ab8c4ff39..a02dc197c495 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -240,6 +240,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
+	u32 last_bw;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
@@ -1387,6 +1388,8 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 		return ret;
 	}
 
+	pcie->last_bw = QCOM_PCIE_LINK_SPEED_TO_BW(1);
+
 	return 0;
 }
 
@@ -1415,6 +1418,8 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
 			ret);
 	}
+
+	pcie->last_bw = width * QCOM_PCIE_LINK_SPEED_TO_BW(speed);
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
@@ -1578,6 +1583,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		return ret;
 	}
 
+	pcie->last_bw = kBps_to_icc(1);
+
 	/*
 	 * Turn OFF the resources only for controllers without active PCIe
 	 * devices. For controllers with active devices, the resources are kept

-- 
2.43.0


