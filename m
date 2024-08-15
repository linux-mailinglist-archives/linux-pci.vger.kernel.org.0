Return-Path: <linux-pci+bounces-11723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ED1953DAF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61462896AC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12C15A85B;
	Thu, 15 Aug 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZgarUnw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A615958D
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762677; cv=none; b=YG3Y7Nakvs6UJ3yDdkJYE0g2qA1v+DvNRQVb5C3zfRt+ypXbmlVURQR+rLPzDgWbItTPK4kaPg6xsjPXHTp953mMpZSjiDo1cX2e4OUwGJQOl25gM0x87018Y8IDqdWhLX7Q+9ImITWE7gWAlErWCmBrPXh1vWyup8yiszm/S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762677; c=relaxed/simple;
	bh=qTDi0kOxY/kD5rVfIUljkrlSg/xVzJq9D9pnUqYRYDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IXfQTRvlfYbgdtbl7UpWaJtCT95Znpq5RW5L9DLXLw8knH/m/nxz/IUzBVBZKaqF4+Xuv4AacIkB+3bRBhYC+cZBiqW/kJAmz9rASr5pNoUanyfyYdE6ntPwFfW10JJOuqEWtnExqFO3vog+NTbTEGbOpEubdVbM/G3NexuscUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZgarUnw0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d1ecfe88d7so1095063a91.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762675; x=1724367475; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFI8arKdNkGnCtRjmqMHmug8W/dZT+YtS9MCra9oudk=;
        b=ZgarUnw0pHfK/Ml9sOTsQqPNr9I+4sIuwx5o9+dZarl2nriwnmBnP/hiF75Rd3cG83
         kWNPXL0SAsBoYLvxbsN+SHoiVccXHdQH/+ZmTTI7EU6eBkttA053748VOvTn2yqQIU7H
         SWW9gcAeLrbQAPNnYIakSWxpm9KDLlKjCj92g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762675; x=1724367475;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFI8arKdNkGnCtRjmqMHmug8W/dZT+YtS9MCra9oudk=;
        b=WOEedkjHyHez8Z3C8kbHDvOEesn8o23AkvO3iFb63RGYWX9Uj/e4LEAt+MYM2LpR0b
         1LRxX6tKPaJAVLXZNZ4xCxqtvgKPNRXDT1OWZ4KxKsv0ZHSdFFkkXvQXN1gTcVQGW9wc
         5q8wCwdcHFMCjVYSAuc9ew0pP651Cy8Kkn3DrF4WshN0AJ6Ydus25hZ2epeUxA08CWRC
         vEZqjU4Hh6AO2lFtJxiiVsJFm98VFh5uYWxUaeqGTP16WfLyLVOY1RvIIIRAWkBWLVov
         X7I7kkGjHNZQEn3wU5vZlK95JRWiFJ7B4wTN9Lbox9fQZDedPI2drut/Zcx0YAn8apDR
         8QsA==
X-Gm-Message-State: AOJu0YywNtSSCOBwOUhDbj72I//6R+H1ueGU6OPI7gy+AgCbTeHvQrLy
	BYC3zXgclqrvKsd/mmTwpg8rGvv7wSFklUwSDWhKo+9CJCTTuF3eGn7HlGcm4W1ecRtpZfe1duY
	YtP6qHeyunBszEbhx1lbRu1ks3iBi31rlKrZQx2eBqr9vbKaoBw0JbCqfzEz6s7fFMg9rXeYDbq
	z/MYU2m63ZlCPsAToJ8kaTdelE1StbpJx6zmfYJcxBYC0JyA==
X-Google-Smtp-Source: AGHT+IEUS/2XIAaK/sG/bTFILt7iLNTiWV/caijt7nP5Wuvf8TQyR8eT31jxKpyY6JZ2oBbAi6rwug==
X-Received: by 2002:a17:90a:bc81:b0:2c8:3f5:37d2 with SMTP id 98e67ed59e1d1-2d3dfc75e41mr1338644a91.20.1723762675007;
        Thu, 15 Aug 2024 15:57:55 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:54 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 04/13] PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
Date: Thu, 15 Aug 2024 18:57:17 -0400
Message-Id: <20240815225731.40276-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Refactor the error handling in the bottom half of the probe
function for readability.  The invocation of clk_prepare_enable()
is moved lower in the function and this simplifies a couple
of return paths.  dev_err_probe() is also used when it is apt.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c08683febdd4..790a149f6581 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1613,25 +1613,23 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
 
-	ret = clk_prepare_enable(pcie->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "could not enable clock\n");
-		return ret;
-	}
 	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
-	if (IS_ERR(pcie->rescal)) {
-		clk_disable_unprepare(pcie->clk);
+	if (IS_ERR(pcie->rescal))
 		return PTR_ERR(pcie->rescal);
-	}
+
 	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
-	if (IS_ERR(pcie->perst_reset)) {
-		clk_disable_unprepare(pcie->clk);
+	if (IS_ERR(pcie->perst_reset))
 		return PTR_ERR(pcie->perst_reset);
-	}
 
-	ret = reset_control_reset(pcie->rescal);
+	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
-		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
+		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
+
+	ret = reset_control_reset(pcie->rescal);
+	if (ret) {
+		clk_disable_unprepare(pcie->clk);
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n");
+	}
 
 	ret = brcm_phy_start(pcie);
 	if (ret) {
@@ -1678,6 +1676,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 fail:
 	__brcm_pcie_remove(pcie);
+
 	return ret;
 }
 
-- 
2.17.1


