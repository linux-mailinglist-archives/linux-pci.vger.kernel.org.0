Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40256599DDA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349663AbiHSOuy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349658AbiHSOuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 10:50:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CEEEF06
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso7759969pjb.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fm7QTBEvZYoh+uEnOcc/Xv3rhrfE/CRJJFQjFwf7qiE=;
        b=kTGHznXS4z9k9KSMxh2zmGsSAbQq549AyrNmdgNpiushumZ0U5Dxj6DmkhmutuPc5U
         VCqR9K4edCyQXiPQ+FigDGtWxQsuWB0OKEIv2oqxey/1NNe/0Vp1q98z+LiBjNwgezh1
         T85aAXYXQgK3FV3Z6zdmhJUyrau0IUdjB/8Y7hYR7GBtwBLW17T7q6TudNBQV1D8jmLa
         7zMTAV6cIITTjgGDqOUzUHTjgP/hvl6fRFRpiKXeQDniWQEV34AuK4y6Zgj7wXyx6SUs
         /uORDfVxdJZr8pG7YQ3tiC5wCYwpLmSOOxqZFU0t60j3sIjAUt4yIMB6upMwFpzeOaxj
         sThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fm7QTBEvZYoh+uEnOcc/Xv3rhrfE/CRJJFQjFwf7qiE=;
        b=iPXOjJP7XIo9lQZZkpYz6dogHfGIWrUOXL4lGcDVtgbM/y+0cVUupcew5FbgQFg6mc
         mHtNs+9sfyG+SECuo57s30QFKDNto1amaVCDkVT8QwdBKZdg95F/1cO0JeckN+GICYqZ
         D6MbysNt0/5TCeDrHnpXdDX6GDZRUGbzc09oLl3znhq+CSS6yGtMD3UQ+7OgnzvtwroV
         3TLAriASDCRGhtTomHso9V1pKOaDK02GjWUTIBi1Bb9sE78g6F9gP4NDbrjXLe7Yq9RH
         DjGwdL4RM+ssisEOBEqsi27fF1rAK4cgKzGGaF2H0F9YilzGxbrTL5pGH44FY/gAB7CY
         UlBw==
X-Gm-Message-State: ACgBeo1mpV+EsVJWtLjLmn7Jvf83/r/XW/YAa3ibNCmDktTFlRLgxjYd
        ccbGBBmxKq1NTnEiyZA2xajt
X-Google-Smtp-Source: AA6agR4WqLDdcp7eFf5epnHlvSLLcn/RdBV0PTQWnRxZD+k4r5blFdID/lUqi3LNfdQB0Rkh2y4Dhg==
X-Received: by 2002:a17:902:e5cc:b0:16f:1153:c519 with SMTP id u12-20020a170902e5cc00b0016f1153c519mr7883043plf.151.1660920649485;
        Fri, 19 Aug 2022 07:50:49 -0700 (PDT)
Received: from localhost.localdomain ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a789800b001f312e7665asm3268380pjk.47.2022.08.19.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:50:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] Documentation: PCI: endpoint: Use the correct return value of pcitest.sh
Date:   Fri, 19 Aug 2022 20:20:18 +0530
Message-Id: <20220819145018.35732-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcitest.sh now reports SUCCESS and FAILED instead of OKAY and NOT_OKAY.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/PCI/endpoint/pci-test-howto.rst | 152 +++++++++---------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index 909f770a07d6..3bc43b9f9856 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -144,92 +144,92 @@ pcitest.sh Output
 	# pcitest.sh
 	BAR tests
 
-	BAR0:           OKAY
-	BAR1:           OKAY
-	BAR2:           OKAY
-	BAR3:           OKAY
-	BAR4:           NOT OKAY
-	BAR5:           NOT OKAY
+	BAR0:           SUCCESS
+	BAR1:           SUCCESS
+	BAR2:           SUCCESS
+	BAR3:           SUCCESS
+	BAR4:           FAILED
+	BAR5:           FAILED
 
 	Interrupt tests
 
-	SET IRQ TYPE TO LEGACY:         OKAY
-	LEGACY IRQ:     NOT OKAY
-	SET IRQ TYPE TO MSI:            OKAY
-	MSI1:           OKAY
-	MSI2:           OKAY
-	MSI3:           OKAY
-	MSI4:           OKAY
-	MSI5:           OKAY
-	MSI6:           OKAY
-	MSI7:           OKAY
-	MSI8:           OKAY
-	MSI9:           OKAY
-	MSI10:          OKAY
-	MSI11:          OKAY
-	MSI12:          OKAY
-	MSI13:          OKAY
-	MSI14:          OKAY
-	MSI15:          OKAY
-	MSI16:          OKAY
-	MSI17:          NOT OKAY
-	MSI18:          NOT OKAY
-	MSI19:          NOT OKAY
-	MSI20:          NOT OKAY
-	MSI21:          NOT OKAY
-	MSI22:          NOT OKAY
-	MSI23:          NOT OKAY
-	MSI24:          NOT OKAY
-	MSI25:          NOT OKAY
-	MSI26:          NOT OKAY
-	MSI27:          NOT OKAY
-	MSI28:          NOT OKAY
-	MSI29:          NOT OKAY
-	MSI30:          NOT OKAY
-	MSI31:          NOT OKAY
-	MSI32:          NOT OKAY
-	SET IRQ TYPE TO MSI-X:          OKAY
-	MSI-X1:         OKAY
-	MSI-X2:         OKAY
-	MSI-X3:         OKAY
-	MSI-X4:         OKAY
-	MSI-X5:         OKAY
-	MSI-X6:         OKAY
-	MSI-X7:         OKAY
-	MSI-X8:         OKAY
-	MSI-X9:         NOT OKAY
-	MSI-X10:        NOT OKAY
-	MSI-X11:        NOT OKAY
-	MSI-X12:        NOT OKAY
-	MSI-X13:        NOT OKAY
-	MSI-X14:        NOT OKAY
-	MSI-X15:        NOT OKAY
-	MSI-X16:        NOT OKAY
+	SET IRQ TYPE TO LEGACY:         SUCCESS
+	LEGACY IRQ:     FAILED
+	SET IRQ TYPE TO MSI:            SUCCESS
+	MSI1:           SUCCESS
+	MSI2:           SUCCESS
+	MSI3:           SUCCESS
+	MSI4:           SUCCESS
+	MSI5:           SUCCESS
+	MSI6:           SUCCESS
+	MSI7:           SUCCESS
+	MSI8:           SUCCESS
+	MSI9:           SUCCESS
+	MSI10:          SUCCESS
+	MSI11:          SUCCESS
+	MSI12:          SUCCESS
+	MSI13:          SUCCESS
+	MSI14:          SUCCESS
+	MSI15:          SUCCESS
+	MSI16:          SUCCESS
+	MSI17:          FAILED
+	MSI18:          FAILED
+	MSI19:          FAILED
+	MSI20:          FAILED
+	MSI21:          FAILED
+	MSI22:          FAILED
+	MSI23:          FAILED
+	MSI24:          FAILED
+	MSI25:          FAILED
+	MSI26:          FAILED
+	MSI27:          FAILED
+	MSI28:          FAILED
+	MSI29:          FAILED
+	MSI30:          FAILED
+	MSI31:          FAILED
+	MSI32:          FAILED
+	SET IRQ TYPE TO MSI-X:          SUCCESS
+	MSI-X1:         SUCCESS
+	MSI-X2:         SUCCESS
+	MSI-X3:         SUCCESS
+	MSI-X4:         SUCCESS
+	MSI-X5:         SUCCESS
+	MSI-X6:         SUCCESS
+	MSI-X7:         SUCCESS
+	MSI-X8:         SUCCESS
+	MSI-X9:         FAILED
+	MSI-X10:        FAILED
+	MSI-X11:        FAILED
+	MSI-X12:        FAILED
+	MSI-X13:        FAILED
+	MSI-X14:        FAILED
+	MSI-X15:        FAILED
+	MSI-X16:        FAILED
 	[...]
-	MSI-X2047:      NOT OKAY
-	MSI-X2048:      NOT OKAY
+	MSI-X2047:      FAILED
+	MSI-X2048:      FAILED
 
 	Read Tests
 
-	SET IRQ TYPE TO MSI:            OKAY
-	READ (      1 bytes):           OKAY
-	READ (   1024 bytes):           OKAY
-	READ (   1025 bytes):           OKAY
-	READ (1024000 bytes):           OKAY
-	READ (1024001 bytes):           OKAY
+	SET IRQ TYPE TO MSI:            SUCCESS
+	READ (      1 bytes):           SUCCESS
+	READ (   1024 bytes):           SUCCESS
+	READ (   1025 bytes):           SUCCESS
+	READ (1024000 bytes):           SUCCESS
+	READ (1024001 bytes):           SUCCESS
 
 	Write Tests
 
-	WRITE (      1 bytes):          OKAY
-	WRITE (   1024 bytes):          OKAY
-	WRITE (   1025 bytes):          OKAY
-	WRITE (1024000 bytes):          OKAY
-	WRITE (1024001 bytes):          OKAY
+	WRITE (      1 bytes):          SUCCESS
+	WRITE (   1024 bytes):          SUCCESS
+	WRITE (   1025 bytes):          SUCCESS
+	WRITE (1024000 bytes):          SUCCESS
+	WRITE (1024001 bytes):          SUCCESS
 
 	Copy Tests
 
-	COPY (      1 bytes):           OKAY
-	COPY (   1024 bytes):           OKAY
-	COPY (   1025 bytes):           OKAY
-	COPY (1024000 bytes):           OKAY
-	COPY (1024001 bytes):           OKAY
+	COPY (      1 bytes):           SUCCESS
+	COPY (   1024 bytes):           SUCCESS
+	COPY (   1025 bytes):           SUCCESS
+	COPY (1024000 bytes):           SUCCESS
+	COPY (1024001 bytes):           SUCCESS
-- 
2.25.1

