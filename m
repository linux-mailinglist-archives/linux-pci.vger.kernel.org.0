Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69960CF8F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiJYOvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiJYOvU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:51:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98B19DDBE
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:51:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p3so10214631pld.10
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hyDFi6BwQQxvnWgZlqZn5l8SdU7JiBSKsGQ5Uy8Nc4=;
        b=B+Ho+V5zB8khfJJf/JNSmJRTSBXzjK3/x2iH3IUW+3k8ukGumO3PIT4Oqu0Ueygspo
         Vax2mYHRn2gpHjoLFcFFmWflLnvWKnMY9lYch7r2RvnYa9NaxwNLlKdOHv6NxwoPqHKb
         E2Ft8mkq25TGJCuJ2K7Wn0a77Rua6pyNJ0UHG6tAGUFmEiVT3pnuTayxVJVMJslVe3ZO
         41Ddwg65oinyJTz77lx+aN0zPcydn/SJnS45njc2YRDeuIIJ7sx6rn1iFvMKCb6g3gd7
         2c3NrnvBmGQhyfYPpMlquqS4Q8pfJhArF6UC494/fU/JNumwwESFGCrhQlCl0ZQ403vg
         gO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hyDFi6BwQQxvnWgZlqZn5l8SdU7JiBSKsGQ5Uy8Nc4=;
        b=6vqFsj2d3YtrUge+6Z9+9kRxRV4QHfe/8vUT49bXWbagkz/8aRatZNxDBM+H1sSn0o
         biWMZX2d8OKKrbJeoH1y3Nkj6WSiojfyEiOYtlhq00OHGNXwSN7dTE//pP8eWwCCY3q2
         i/VZ+jicHsD2/oa0HIXPl6XexEyq4/UPRtmoG29NigAauWwzkCT6hOX0ayYmW1T/sHBF
         dQM5gBNg0Rf5onCW6umxmcUD0d284FwzaRh0mgMHoank/1jo1vPvO0hwUQCUpNa1g5ys
         EP4Kt6UfN8vtcP96UiqHY9AN2jEt7gdBFG+rqW946UOdjXP09rGOrR89nuetFxad7Ze3
         2P8Q==
X-Gm-Message-State: ACrzQf3o0j4yKc/737Cpfge85loBcJEaFk4mJZnSDMCSYou9Wcz5Viqg
        Ex1h7zLXCQkDyJ9HNqwKjcoP
X-Google-Smtp-Source: AMsMyM49ruqiJZ5OsTzYWG9l6cKL5waGEDKrpmrFogpMdnF7XKH2HzUWjTzi2Q0OO10fAhuTs6TxsQ==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr46560042pjb.143.1666709478981;
        Tue, 25 Oct 2022 07:51:18 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id n14-20020a170903110e00b00180cf894b67sm1318765plh.130.2022.10.25.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:51:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 1/5] PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
Date:   Tue, 25 Oct 2022 20:20:57 +0530
Message-Id: <20221025145101.116393-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "dra7xx-pcie-main" hard IRQ handler is just printing the IRQ status
and calling the dw_pcie_ep_linkup() API if LINK_UP status is set. But the
execution of dw_pcie_ep_linkup() depends on the EPF driver and may take
more time depending on the EPF implementation.

In general, hard IRQ handlers are supposed to return quickly and not block
for so long. Moreover, there is no real need of the current IRQ handler to
be a hard IRQ handler. So switch to the threaded IRQ handler for the
"dra7xx-pcie-main" IRQ.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 38462ed11d07..4ae807e7cf79 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -840,7 +840,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	}
 	dra7xx->mode = mode;
 
-	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL, dra7xx_pcie_irq_handler,
 			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-- 
2.25.1

