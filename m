Return-Path: <linux-pci+bounces-39307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A9C08D81
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 09:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0FE3AC047
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FEB2E5B11;
	Sat, 25 Oct 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMq8hcIB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5A2E6105
	for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761378234; cv=none; b=BPRKTfUh7KVyI8tVkS+WdmhTUBcI9cub+PDLWartqTAGCUO9rR99O0Atc1vFnC7jdhibw4M38bS/dG9MWuNAnNBa83om8NT5f8FgJhch6u0C3bTf8wy77AQadICvnOMSKIivmKBmKXZs2eNbZZMuD7mWYM6M1NeI2IXapTybn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761378234; c=relaxed/simple;
	bh=yHFLxvbFUaA9/Kgq/p30crlG7aBSgJLzY1Tlh9Cmw9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev9QoHI3FiTIfkmNWva6KtJfMbxV1/Px2UD5yaPYEwHyA5xAdbBHHtoiQbqjr4h7ZU1k+U0FzrDyMxR2qnM7nzgeiE+pZ57g/KpwSl/clUxSoZ2kNQGDQZLmDkZbRTuQatY4nsk7fmSPlKiO1zeW8HgjrW+rsuKCNyNvuEpI7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMq8hcIB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso2323916b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761378232; x=1761983032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7VEd+Ttt8ujutNeib5W41dEQ7VwE5awjCGOWqT15+4=;
        b=FMq8hcIB54bEgPBEBm1oMHENw3l8uOhXvMoeWo0msMOvYEXJoMsZYV2VATy7eCBkzp
         71bc4CqgI4oTy1wUFWXnHsoAXXVrCgcXzEXb9qLQqfZRSx/eOaraWFQE48bv6S8SSBdt
         kVUDz/SzS0oWDXLw/J1affKdwoanOFNEwMkf5UvGzqH/4I+tkYetpgIOTNiP9CLcU3RB
         XOobQYUqrrZphrnh9fK7BF5MvczJlDwZTZ7DDJiCOlrTj43zrxVNTX6hYkdY6Y70yimM
         80pfyWfIM0EOwxapqG77uZ8YoKS0XOBB57j9O+WdXPp3CeRfYmsU06ouUUkBJDzoj75r
         1qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761378232; x=1761983032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7VEd+Ttt8ujutNeib5W41dEQ7VwE5awjCGOWqT15+4=;
        b=rb5dxK63s9tPTSrRpITG+qcqOGZKZ7J1tRUXi5impXkvCLrAJTVl7hkpjdm1ItOM+P
         xJ3bHPWt9ykQn0NSRcFZuSqAxpdCp2cLXn3fMhz6+4zyjEI6LYQvd2DNWYnIDeIpkDmw
         sH2sYS5/L4giV1EwzztLsT2Vmz7sRy3PMGmhusqxLJMUYgCtAAyjYBcWLCZTpH4z0BCi
         mtqsV2gLzgujiKDDsQYZiw2u5fPNRX8BMcy3c8XK/NWL1lCgdFpeIuM9eZalIzGoskNA
         IXkY3VIA+LyCjjlcSyKKBGVdJRhXLCIJefM/UJqN8y3wDqmT8zO2BLfVm697guC2KxYu
         LbDw==
X-Forwarded-Encrypted: i=1; AJvYcCU9wWBGOfjFGwpSC+ym3yijl+w6VMujfvAZH2MxY85wWG/gUttSOvHGeWaySgXlONlWwTzLfHlANlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7tQmAEDRDzI44CCncmFJC2tvWUjlBEbcqVZPAOFZ/GPea2Uv
	R+wVK8kQrw4/rchgqV48OsYWBQxowaLNYOtnVIwraq/mVYXRgFi6ioua
X-Gm-Gg: ASbGnctyDXSImz4mRqKh1lAzjMJgJQFxwInAngq6e1xul7o1tjmVe83fhYLVx1fdLId
	bBEBGX5QlSDheNVwnmr+6LZylF5bE9taH5pNo3/nIOhAnvRtig+fCHOmCFpIYaWBHmx26tuzbS1
	sV+ZPVugHxG5won1oOozPca7yZiBPU5rmZw+V+O3M0AphSwlN3fKm55q9DNg1+5NNCN+DUmM9uA
	GCwxFbhcnIGz74tXoQQ0X7OSQmmauTEFK4lm7tMGUZ87Fu6JXulj3stDm+0zZtG8lwJHs9V2wVY
	oKgwuJLGxwqR5ONNAfzuP5mPvaB4b0q1u02CjGdUiEzp7bYx87IYFNdtiNQi1ViB7oftyJ1qiXK
	i13gjE4E2C0iUMj/qRcFP7MeAKMXgROG4aJncFgobyKwAN56tZcpFIbgfgAzUj5U+MiynPQlswi
	EERrA+UZN3
X-Google-Smtp-Source: AGHT+IGB7E/KWo1lahJL8+e6wOJZtjYp6Eo98mRm//4pnQJwgE/Oh/eOMu0MhO/JU/RJV88qtg23AA==
X-Received: by 2002:aa7:88d1:0:b0:7a2:8111:780a with SMTP id d2e1a72fcca58-7a281117a18mr7274917b3a.2.1761378232258;
        Sat, 25 Oct 2025 00:43:52 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404d760sm1395083b3a.39.2025.10.25.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 00:43:51 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
Date: Sat, 25 Oct 2025 13:13:31 +0530
Message-ID: <20251025074336.26743-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251025074336.26743-1-linux.amoon@gmail.com>
References: <20251025074336.26743-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional_enabled() helper instead of calling
devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
the clk_prepare_enable() and clk_disable_unprepare() with proper error
handling and makes the code more compact.
The result of devm_clk_get_optional_enabled() is now assigned directly
to pcie->refclk. This removes a superfluous local clk variable,
improving code readability and compactness. The functionality
remains unchanged, but the code is now more streamlined.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: Rephase the commit message and use proper error pointer
    PTR_ERR(pcie->refclk) to return error.
v1: Drop explicit clk_disable_unprepare as it handled by
    devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
    internally manages clk_prepare_enable and clk_disable_unprepare
    as part of its lifecycle, the explicit call to clk_disable_unprepare
    is redundant and can be safely removed.
---
 drivers/pci/controller/cadence/pci-j721e.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..b678f7d48206 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep = NULL;
 	struct gpio_desc *gpiod;
 	void __iomem *base;
-	struct clk *clk;
 	u32 num_lanes;
 	u32 mode;
 	int ret;
@@ -603,19 +602,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		clk = devm_clk_get_optional(dev, "pcie_refclk");
-		if (IS_ERR(clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
+		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
+		if (IS_ERR(pcie->refclk)) {
+			ret = dev_err_probe(dev, PTR_ERR(pcie->refclk),
+					    "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
 
-		ret = clk_prepare_enable(clk);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-		pcie->refclk = clk;
-
 		/*
 		 * Section 2.2 of the PCI Express Card Electromechanical
 		 * Specification (Revision 5.1) mandates that the deassertion
@@ -629,10 +622,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		}
 
 		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
+		if (ret < 0)
 			goto err_pcie_setup;
-		}
 
 		break;
 	case PCI_MODE_EP:
@@ -679,7 +670,6 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 
-	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
 	j721e_pcie_disable_link_irq(pcie);
 	pm_runtime_put(dev);
@@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
 
 	if (pcie->mode == PCI_MODE_RC) {
 		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
-		clk_disable_unprepare(pcie->refclk);
 	}
 
 	cdns_pcie_disable_phy(pcie->cdns_pcie);
-- 
2.50.1


