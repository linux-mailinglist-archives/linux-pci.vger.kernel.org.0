Return-Path: <linux-pci+bounces-9961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200492A89F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE628103E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60871465BD;
	Mon,  8 Jul 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVHsQXU9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A831D69E
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461948; cv=none; b=kEJzsVqnUK+JakQMlFAM7RxT8JYEXpoBPOpLqAdb8LZ+qNR4srIRhPiqWub1WQHu1JVrn0HndUoptN+rkABxWcaJoezvJr1UsUIRCUDB3kgj3OfKKGEl/oVgcxL1KzYHZZMHEOo5w+MqsSNmMNScWXr4MSP/qgGgTvp9APWIZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461948; c=relaxed/simple;
	bh=yLqftm4eDdgCnmitUT4t5kah4QCFH64IK/TUdDeuyNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrkvWzv2ZTle84qdaw++N7QjViVqhcauY2390d7xAcRi4NDMyF1ie1h3mGUK6f/pF3ygh2w+9/J27WVshvjfShQVcfPIfZdit+3zKYRhwcNmHG4TIWgiI2ESJTOGceV9hdpehGiicrsoy5r06jbUMEGZs6aqncDa6uZOvNwwsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVHsQXU9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7035b45d5c2so1908039a34.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720461946; x=1721066746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8GBy9t4kA52JVUKSemxpegpyHotiScJSh7xoSVGv88=;
        b=jVHsQXU9Mug/h9c0O0FY32G4mTl8z/1Lyf7xfobYxKOcO2gFZtRsQ+/H1iiKyohsMG
         kSr2G2UwiwKsZ/y6vVUOoHdyqAI/3PCP9ZcH7RUDOt8WwujRgSfku9G05mCy6+hfemL7
         Ffb34QhSBDoviYbnj4mOpR1Y65JUmlXAGYj/oYaMaqYBq/zLpuT5AyzW4t/Mnms07+2O
         non1GCRMBxCUkN/jclGz1UVu9w4pG/mJYkjT4mvXrtqECJcGq4yuJnE6GmxGyDgUfOXJ
         Sq3fKMObJDu6DZaAu45T6P7dtziV0dZ3XKSFjNqhyxBauS9ul7Y7OqmexJXSP7YOeBjT
         KCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461946; x=1721066746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8GBy9t4kA52JVUKSemxpegpyHotiScJSh7xoSVGv88=;
        b=c2Lzpv3zaphtNqpJ4CFs08Fi08sa/IPM0HZYyRFygfCfAZqKcfyRPUqQ2HAny7wn6L
         0SzBZva/jPZQkBqrZXKVpTpI3udZ+Loy8owPEh1FwHXVp6AFnfZ1AMSyMlN7eb5wq7c5
         IVBWJ+jqZNEg75s/sowmsiVdiZYYslSvNDLBGi4Djm8MPaNnqdVlrpkX3e4GpA6Exi0E
         ZTqlVreo138ym9iYZM8HQVpmG3duNJSEENd84SQJ/di572h3N7/Fb9AfOgRQA55VJGOU
         ZtaDQ1hqRZoIfN1ulyP9+iImo4hekd9UJySDT5o0BljrmuKn2xfOwh6QG7Kk95Ofmc4e
         QZVA==
X-Forwarded-Encrypted: i=1; AJvYcCVSey/NMKUXQzqkJ6P8G7Kgeiwb4HCloxKnMo1p/RzHy46XZ7OqohQ7i1BG2ZNmi+ZvpNmbbTGwaDeggDT+G6GuOy9D+VSI3pDr
X-Gm-Message-State: AOJu0YwQiiIbiWtFwun1vymTozRe6eMN9UIektOksfAbSdX7iERhsdx1
	r6mkZnxYFl0Ey0dtWggspj3Y8J9zXe4MTyumFxj49QnoNT+R+r/Iw40o/II/4uM=
X-Google-Smtp-Source: AGHT+IEu8XliCo52vyhpWrUqRkTeJslYmHDaL2dF8EVixnxKwbUnuulSL3pyI37N0oH7c5c426yr6g==
X-Received: by 2002:a05:6808:179e:b0:3d9:2986:5a3b with SMTP id 5614622812f47-3d93c085bb7mr114237b6e.37.1720461946251;
        Mon, 08 Jul 2024 11:05:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ada73fcsm73010b6e.52.2024.07.08.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:05:45 -0700 (PDT)
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
Subject: [PATCH 1/3] PCI: qcom: Fix missing error code in qcom_pcie_probe()
Date: Mon,  8 Jul 2024 13:05:36 -0500
Message-ID: <20240708180539.1447307-2-dan.carpenter@linaro.org>
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

Return a negative error code if dev_pm_opp_find_freq_floor() fails.
Don't return success.

Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 26405fcfa499..1d36311f9adb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1574,7 +1574,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!ret) {
 		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
 		if (IS_ERR(opp)) {
-			dev_err_probe(pci->dev, PTR_ERR(opp),
+			ret = PTR_ERR(opp);
+			dev_err_probe(pci->dev, ret,
 				      "Unable to find max freq OPP\n");
 			goto err_pm_runtime_put;
 		} else {
-- 
2.43.0


