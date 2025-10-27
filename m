Return-Path: <linux-pci+bounces-39366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CFC0C908
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A23219A1A79
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75B2EF667;
	Mon, 27 Oct 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0t1wjFz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F42F5A22
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555808; cv=none; b=nr0G6FPNG4OLZDT9566/0xmnkRAgWv7Bn87MHk9rCS+Pslq6x21UPWxrxs8Gb2LDn3N3A+IdFRr+XCUTIX+eNKJzwAcOhgvv8cjHsDSxJQHk7X5ZurzcvXDWPBh47B66p9cf7JT2GozH4G62k+9yICeUExvBGMPoKmoy6fL97lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555808; c=relaxed/simple;
	bh=eogBR5sxD05fZ6c/zTfkTbZBgKCFI/Gyw8bMtmzrf/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndJkIsgD8vGDoYJTJoZ3TZP76Q2viURM99kJGACDSeqJkNU1JND2gcrGu8tIfNnGqskpwyY9aFXyyKM3DIJSbmZRfa5QU39FApvx0md1yavxoN6tczrDG3elafn9e9wdk53U9eQOKupfRTM46AWllwAtnRFs95keHe9BJBkm0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0t1wjFz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso5510260a91.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555806; x=1762160606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDCevJO/jn4uxha5g3iGQ0Gi4sz+BoDakhPsr84awrg=;
        b=P0t1wjFzzv8xKGXVHp5WRpuE+lUaI+Z7UVZ47m56PohjaWjv2M3CYbUvshRfsrF7tw
         BTyHijKitPi2zRGmHL9SADRQr3CBGAlbgNuT58FAtDVD2F3ywc844KtX7MsyFaamynL5
         XGQyPIS/nfjhiTcMdtO5r0NehjmnebDUOYnZbL1fBkW639zW8ihbP6HbcRKOUtTF2SqW
         pkMmsQkCDABRqrQ0lPSzJNlmshzaqSMqohmpUB3u291GjR71qsMqP9cGicDN55MYVdgM
         eHHr4JGG/m8rb7Mtz2uiA4wIWxlqvTsJz9Zf57sQ3eqUN05UQe12B/fLed1DvGb8CetI
         +wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555806; x=1762160606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDCevJO/jn4uxha5g3iGQ0Gi4sz+BoDakhPsr84awrg=;
        b=Rtn+KCDlALnviteTaptEsqNbdtopGiz5CdeweH9cBUiOz2Ufn6qNUc5W7wDRZ9DwX/
         CaJWuxegkar/BYGf0P8eIHU+rQhN80b7BTwVUuW44VuEaSvx4OboI42g2wWwxK60t2Ux
         UoxAMZZAfLGXKbrUQRKSC5e+ZzIucIsu6dBTng5WmVbXwIGf8ZRgOkLWxGD2Ne5/cwap
         Kxnw5+eOMyOsXX5OJaJVpkjc9gNiQQKzNV68xZWaKJPwiDxq690fRCCxXv2sbWW+16Q5
         9Nr3hBlarqIK/VZfosySwpOq2BUOtKDa3g4LmPIfiSqvLqjZong19WBtgBPt1O8lua3z
         5kbA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Tv6MGGczdFOvQ6ns3oZIxPUssSOsJoGbv3jA3SpyrtjNvYOM2S+Vzn5huiKo42gcGoMMqubXrV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMUdS2B6ZnZXTH3ENZ74vil90TUS/m+gS9GmsemTNOL0ksnlJ
	WQRmdLMs0Z9/BnLL7Ry2jTANmZZch1eSHaUMKL8R8vS1Fx6wprJGdM++
X-Gm-Gg: ASbGnct2+uWfRaX3QHfv8ohz2kirFtIJo2tUse6H9/6VTaexfdlzoA1UECe8Dl4n9xZ
	B7ztkQQnegQQFmu4ZnIVs//r7S2RurB/PMY4sLkp7Dcxyqc7PmV71Wr/EITIE2m/+q0wB0Q1gXk
	xGmSS00fx/MpZ5WDo6Prh+Tmjw2OGDTkuApKFQUZM7yiivTFW2E1fUmbW/KYEcxSjQnrgyD8Dh+
	Nitv/HShdS5IpSlqFEOzSy1ohKl3QhxpMeeEDjkAqCl4lr2WVCfkU7SszLrnpyL/I8svkBl8O/h
	WKMUzZZiQNYlNRyVwZDGRj1//tcRnRuSYmiEKe7iM2Ajo+/UwdoVYCslVmaJFuYJHOKFnhLftyo
	0X4RhE/M0jocTmu3kff5MyKRloLcf9+QJjPi+2e6cmeb0jfPh/QbTKxvqVKFreFlDrERbyIg57U
	c9dbrzxL9/3tVyr30xzrU=
X-Google-Smtp-Source: AGHT+IHmIUD2h1GuwjjhJJdGb/O47J3PxX86EGpWbLGZgnTd2IndPXIXzCHY76GqEBfYMKQNDQz7ww==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id d9443c01a7336-290caf8582emr559508755ad.36.1761555806053;
        Mon, 27 Oct 2025 02:03:26 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm73881335ad.21.2025.10.27.02.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:03:25 -0700 (PDT)
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
Subject: [PATCH v3 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
Date: Mon, 27 Oct 2025 14:33:05 +0530
Message-ID: <20251027090310.38999-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027090310.38999-1-linux.amoon@gmail.com>
References: <20251027090310.38999-1-linux.amoon@gmail.com>
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
v3: Clock needs to be disabled on Suspend and enabled on Resume.
v2: Rephase the commit message and use proper error pointer
    PTR_ERR(pcie->refclk) to return error.
v1: Drop explicit clk_disable_unprepare as it handled by
    devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
    internally manages clk_prepare_enable and clk_disable_unprepare
    as part of its lifecycle, the explicit call to clk_disable_unprepare
    is redundant and can be safely removed.
---
 drivers/pci/controller/cadence/pci-j721e.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..a88b2e52fd78 100644
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
-- 
2.50.1


