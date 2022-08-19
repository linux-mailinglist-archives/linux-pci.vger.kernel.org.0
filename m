Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E07F599DE0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349629AbiHSOuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349621AbiHSOue (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 10:50:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43973EEC7E
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g8so445739plq.11
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wz+KARvUZRNT6YKJjGhmT8Zsv9A5Qj7HDH8ifDRs8a4=;
        b=Xl298vBrOjKy25RecID8qShMPyWy6PpJrdWhgTv7NMsSsg4Ma7UDQzGHt+oK/ArPxA
         2eltgydhBQMFXrDmQKx23iAUYrjTm61BPA2i7MzoDm0TcqUGi8MI/Y/5eqM2yY5VcliI
         TRLVUrYBCuj0MUguApBkgsJPNby05M8o5pKmvTUGdrZPvmRhcHGcfrhyhitA6Bx9mLFR
         UCxOeZW7UjZJLO42WH9XEQJ3pNZq0N0QqjIPlDWwuv1lGBMJiUBb/rJDtp9WDJY02mTK
         C3Iy9ptuOumSXeozWccDd2UHgCv9fYqj3uNewRtovax5VP4H1tNs5yoM8l1ZizmF9sZG
         +AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wz+KARvUZRNT6YKJjGhmT8Zsv9A5Qj7HDH8ifDRs8a4=;
        b=a14Y6U4JlD4RwNPZhIIs90lhTZ3pYw6zRyLs3+sYiRr5oUI09vknuHlt7AK059/BLN
         /KrvfV2CS5Quhgs5uoqHI+qoAFfgzFuNAOtVoI9RIuIPrbDo+tpJ2W9repq97bDPYOv0
         K8W+lt4ExOIlyGNSmHF8u6vPPl+OZZGLMss8fosay7AhzhYXfAceXu2E1jtX27wGA5hm
         8yeLidu7cJJ+nEztXGDoHHo8t3tAWran9fFGxXz7J/a9aBFk9BLvi2qV4819nMmNjKBD
         L6P6twi5UHj8sjvs1XZ6pg0/snfBm6R3HDt8Vai9Tv4InSlBxyq8Q+Bj6M7CmcTYHltK
         wZMA==
X-Gm-Message-State: ACgBeo35zzpWkY2el1pSWs7gWOICdp61T4HSAJMI4T48Bvv8QE4dk0cp
        uzxqSsHlLHihuK9HlydkX8//
X-Google-Smtp-Source: AA6agR4GRFxgUYb5ZjTjGYv3p5ANaiHL4MV0LWXRwUoARVybfJICGuEr4RHaTaEdQwEWnmucZsbl2Q==
X-Received: by 2002:a17:90b:3852:b0:1fa:e83b:3d2c with SMTP id nl18-20020a17090b385200b001fae83b3d2cmr2835054pjb.125.1660920632672;
        Fri, 19 Aug 2022 07:50:32 -0700 (PDT)
Received: from localhost.localdomain ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a789800b001f312e7665asm3268380pjk.47.2022.08.19.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:50:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] misc: pci_endpoint_test: Remove unnecessary WARN_ON
Date:   Fri, 19 Aug 2022 20:20:14 +0530
Message-Id: <20220819145018.35732-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If unable to map test_reg_bar, then probe will fail with a dedicated
error message. So there is no real need of WARN_ON here.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/misc/pci_endpoint_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..db0458039d7d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -820,10 +820,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
-			if (!base) {
+			if (!base)
 				dev_err(dev, "Failed to read BAR%d\n", bar);
-				WARN_ON(bar == test_reg_bar);
-			}
 			test->bar[bar] = base;
 		}
 	}
-- 
2.25.1

