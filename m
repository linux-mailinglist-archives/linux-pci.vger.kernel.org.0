Return-Path: <linux-pci+bounces-9963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9292A8A7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22654280F10
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 18:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DFC14BFBF;
	Mon,  8 Jul 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeaLQbf2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1A14A60C
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461953; cv=none; b=mfjNwLN0iQriylUMDls5PH6otIsBfmUzr7g/CebHLKRd7EHt/Njzsc74jcS1B6iUN+mHQq3556zlt9s2ghlvSyqC/dNDNGwIj0Iqa9bKDeLiWV0n0lC4gJcwKr4+Sex4ejtx3TPf3LpylSfRJCJOKjBOP422XYncrboRye7PpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461953; c=relaxed/simple;
	bh=sQurFjBE9L3fAEjeupv9dzjJcGbx0I4IJJjL3X9WlHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX0gjDhzdY6M/UQe7QZFtc4U1IfqHg9ihzhMd7/8kxSt0qpkempZxeIS5gpR6uwDAaBM9D7VWx+HRdqTvwhU5DKSteu0pIWd7AgLQn21irs93v/3D1acU8sasj+ccQ0xF5YQt+rDT4EtaYe/tUbbsKu4wlez/iS13J5AUJ7cu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KeaLQbf2; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70365f905b6so1058790a34.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720461950; x=1721066750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYngg2/AvD5ABD/9akPCHM96QJ+CMJBmjqIZiNK6u3U=;
        b=KeaLQbf268m2mnCh//+CQ1tbqfpeXynd5ZCLBgYHjLnUM5GzEJonArueM+iKZH184s
         Q1AmcFw9bP/eZZv5vKZ6mC8NuUUniwA/VT/WHFxAKWmBXjRq2fYKbtVYdWQQz2c+giMw
         Y0vPCnNW1PFopbFP6fhwEmvFIGMQL0YU9WUXAvSpwkRhIqyY0AMBQHGj/gI1HktKtYLU
         SqFSwrCLCG2FP6uJV78fNnsKvq8RgE5nT8vB92GgBiaYRgwfqn4qTOATCSommvZ/XtAH
         LX4lHySvrtArDPdmzcBPo5QDBIkBBLUWHnC9Ufb8ftEw0qWKLIrRcLr7kOd2H2oHrAWK
         v/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461950; x=1721066750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYngg2/AvD5ABD/9akPCHM96QJ+CMJBmjqIZiNK6u3U=;
        b=bQr+BB01ItCNeRP0VlGONUSiD3xKo3nY8zeatO/FKGH2WFBdNMcp4IL0qZywfkszpj
         MQc87t9gDJscl5Ee0Q9J6GgWIXbJ8OgJ10ZvlT8hbELOCanwwp3WKv/hVtVLe85tMmpT
         MVYmrRPDYUdICOqX1y+DL8GkvmqoZhqjujyYtRB3LTUsr34YDoBGJ+1Ck+rJMtiLy587
         UhdgyP5DKM2pTNxZk+HTU1EpgcDhAKLRF5w28S7X2SwMjlQAawDYO/1N8jXBWl+M6Jbl
         Q1SOYlt8opa8JmJ4617Np59DYAo2vMgHzSTyaGaoQ3DZl9zmjdeqFoXm8H0oJ3LX+xsX
         vtLg==
X-Forwarded-Encrypted: i=1; AJvYcCXGNbWX64VnHUSv6O74pIFl6/wCkDusulIgKKuu/yr02hOPCfZOMcOHNFLYddZMOmN5FJc+/8KuMjIDy0b3u5i3/QE3ulsYqPzM
X-Gm-Message-State: AOJu0YxKz1oP13DLCKsebk4y+cFD+6Z+SLrRcVojexO0v6fKiZgGvNFl
	5Uny4TEeshAm7EHRYvqnDxmcNkK0BFNXNaBnBsi/TVg5NkoHiKIu9kbomQ2fA2w=
X-Google-Smtp-Source: AGHT+IFotg/OqzVapLsDoyFgjgyedblYoClmUMzMboNvrP7Hf0zFKYNPw6ZcbTQzYlbt4UCndKAUOw==
X-Received: by 2002:a05:6830:91d:b0:703:5fba:5e1a with SMTP id 46e09a7af769-70375a0512dmr309192a34.9.1720461949870;
        Mon, 08 Jul 2024 11:05:49 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:cdd0:d497:b7b2:fe])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f7a2d3sm86559a34.32.2024.07.08.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:05:49 -0700 (PDT)
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: qcom: Potential uninitialized variable in qcom_pcie_suspend_noirq()
Date: Mon,  8 Jul 2024 13:05:38 -0500
Message-ID: <20240708180539.1447307-4-dan.carpenter@linaro.org>
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

Smatch complains that "ret" could be uninitialized if "pcie->icc_mem"
is NULL and "pm_suspend_target_state == PM_SUSPEND_MEM".  Silence this
warning by initializing ret to zero.

Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e06c4ad3a72a..74e2acf4ae11 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1633,7 +1633,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static int qcom_pcie_suspend_noirq(struct device *dev)
 {
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Set minimum bandwidth required to keep data path functional during
-- 
2.43.0


