Return-Path: <linux-pci+bounces-10869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05C93DE0A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 11:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08301C217F3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F2855897;
	Sat, 27 Jul 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4sOGJdA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F647F4D
	for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071173; cv=none; b=eu2zcURwFvtdi0Ti+9x+zgw+c9okCrWp3Tssfkmw5pgPxPxoKKokUDKJLmtNq5g6FOfNmOZV9IuFSJ5ufa6oW4LasEQA7oWotRqYX8YFe8uhUM8nKOCuDfZjrwiMnvdItMUgm1de6Aez9qyub9yF+VdYsqBf7ksJnD9MhzP0TSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071173; c=relaxed/simple;
	bh=w5cZrFI9Yutg/sZ9EKgpKy/wPnaZGOsNX8b3Qo9cEek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQv3NvJWwy64mlAplHkinHrd+iqP29udx/WhfF5SA+r1JugnonQP1WwzADVf8hrTqjgBTB0Xjg1KUFyMo/z2VTR20MBYPOGq0yqxBeXV4Kewsi6JyOZ06DqzurjvDNrOsvEry4WRJDy3vZFvRHGz9enUZnLiq+rjSvL+VVs7WnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4sOGJdA; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39aebcdee9aso2459065ab.3
        for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2024 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722071171; x=1722675971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDq5ocjaHKIoj4uSnGH3wUSyzEmvqPLoYIJb1YiFvGk=;
        b=Y4sOGJdApzCgCs+inC+JqZyBH92OF08GSUFV2cYld5jRZWtzj3A3McjDxlOdFyUUN5
         9mZye6G4s/RGo3XLUku79xbubZmkciWmXyEtekdc7DdlGcM9i883IFlLnQ0zNsMgx6V9
         jWXNGfx1y1cMZJnZipZTfWuYFiZ19DZ0JJm/3KL1P3saWyyPBCrSJkatiUVQghBHdpJb
         vLbqiwADBzyAc6o/C4YeM40Bph8rquiuFD/6AVMzKv7e5nSXzn7ZqOWt6j+8fs4U0tpq
         07D+IWm62QFIWlTUn6UlaNjNYDVclGPlrE7HXSRXgXvYLV1CO1c6tTB4CmAtVYlWvOjL
         Dbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722071171; x=1722675971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDq5ocjaHKIoj4uSnGH3wUSyzEmvqPLoYIJb1YiFvGk=;
        b=Db0a5ymBrZs0JlgHC+5V+aUbORimmwr+CgVVvXpWYuXBqeGLFaHNJY2HU30Zy/uq4S
         gNwYo3LN1u//Ulcd5s/akxxYXGQ6L8EhvdC6J1ppEBpGohdMOpvoWme2FWbf3T4m0Rbp
         cGCSAr3MAwTBW4TqOXDkp5VopUzgc5h7yr0lcRnamoEUU23CqDoKTaAahbMmFBEVBs4l
         rjf1wnkMe7LgAzPbvvg/oLwUycVHFiw21Z72kNEMJA4YeoGtk8zjxR5O7mwoYaMZ1yPu
         5LGIVkYfrAGkmy9uIpNB9bxkv7XxuYGjRR4XycdHfHbox7pDZBy/RWJSlCW1NZZu7sGp
         5UNw==
X-Forwarded-Encrypted: i=1; AJvYcCXyQ+Z0dGbEfOtZ1fFjPCZDBLQoMVhWgOqUWaEDueo3HfLMehCCxnpssSqSC2vd3ZKGDKxFV9mPp0oeGjhyPDpu3mfv75ljZHAO
X-Gm-Message-State: AOJu0Ywx3K0Uovz1GTPpliw+P2lRQvCQcPBrPCsTGoeplbH70Q/Xxy8L
	IE71pS7J3CB7LaWmwJVxE5ZDlbSPfjwkJASYr7eeJe0OXHGRKWbs+vbWojaA/A==
X-Google-Smtp-Source: AGHT+IEjSd7a4n6+cb1jZ2TKPL1G+oJtxyUtQYDKIQ0gsJo9nJmeipEN0kjj6m73mgR0wHkSdD4Eog==
X-Received: by 2002:a05:6e02:1a6d:b0:39a:ea20:bf7f with SMTP id e9e14a558f8ab-39aec419d4cmr24055785ab.25.1722071170827;
        Sat, 27 Jul 2024 02:06:10 -0700 (PDT)
Received: from localhost.localdomain ([120.56.198.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9fbd4b0sm3449717a12.72.2024.07.27.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 02:06:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Date: Sat, 27 Jul 2024 14:36:04 +0530
Message-Id: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
for drivers requiring refclk from host"), all the hardware register access
(like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
from host.

So there is no need to enable the endpoint resources (like clk, regulators,
PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
helper from probe(). This was added earlier because dw_pcie_ep_init() was
doing DBI access, which is not done now.

While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
EP controller in the case of failure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..2319ff2ae9f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -846,21 +846,15 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qcom_pcie_enable_resources(pcie_ep);
-	if (ret) {
-		dev_err(dev, "Failed to enable resources: %d\n", ret);
-		return ret;
-	}
-
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
-		goto err_disable_resources;
+		return ret;
 	}
 
 	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
 	if (ret)
-		goto err_disable_resources;
+		goto err_ep_deinit;
 
 	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
 	if (!name) {
@@ -877,8 +871,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	disable_irq(pcie_ep->global_irq);
 	disable_irq(pcie_ep->perst_irq);
 
-err_disable_resources:
-	qcom_pcie_disable_resources(pcie_ep);
+err_ep_deinit:
+	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
 
 	return ret;
 }
-- 
2.25.1


