Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0545A69E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhKWPlZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhKWPlZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510FC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay10-20020a05600c1e0a00b0033aa12cdd33so2178831wmb.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KlMAHaUOUgQ3F2U2z8IWCKXJhS3v/qnFhjYKYTFmaU=;
        b=F05DtYWgK4h13mFNGjyhs9gUOLIOUcxRxHlFFe1vRUw+hKRfkwXC1h44tR+RB5p2nZ
         YfcLaamdzUKD0vCmg3bPtNn8RktNkFncGoeFQ04QuhK0eanGg6cUW8kO/7cy3kNT+hGq
         sh+G4b9zd0CWYeaJo9eWtD0bh8Bd99V8CR+1h2xMpZICfDzE6k78hP0Q4P5VV9mWsQOM
         K8hyg+TDbOC1fkZpxG2YKde1dJg1WQqRt8fE4JZY0GWs0HwgLqE9IqBmZQZUY8J/V8Nk
         SZWDRVAOsAf06A5k4jHuEGKebIyJcxCgLllcWjN1eypnaLP5K1yFFSrtRXLHQ+gAQnBl
         y8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KlMAHaUOUgQ3F2U2z8IWCKXJhS3v/qnFhjYKYTFmaU=;
        b=kdbTicxKQuMypkUOzxsUSwyPFf49lVDyVsM/6obiy+4ueqgMOQXl1GnRe2IIfp8sEE
         8vP5ivKL7/0FgwpJIBD9SpAXH21t7QKDkzCRNspoqVvXaiSmSYNOWeLUX1f98FgpeosD
         ypX9wh6IKOL+DZr99Qs9oP+bj47EMOFYtnKp5+iNUu2CDQuvTanxQ2Huskrh47B3QQdw
         LIwOU5dJ70HN/AkTOwiGRKXbKNAeHUgCb9TH9Cx8g5N96ZV9EAkH1bkqpUCXlq2m+FX5
         6qe+PPXAzFu+dSOK8urxTEA1WU4fy0fmprTXpFp5Ni3Nr87qj3ubIBJthRZIjspMArrM
         pGsA==
X-Gm-Message-State: AOAM53394GURzdJHh1ESKhQJTOIwLTbatk6uXmThaS9/kQGWBrPMQywd
        4a+WpM3HIZF34sbf0QHxfqZGFSG1FgzEZA==
X-Google-Smtp-Source: ABdhPJxw5lBgkBurl2ZsHP6So+guw2VABKETKMqdLLgTlaLQxEnCr3UkYTtkW2n4b28i0ZFudGxzYw==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr4131480wmp.127.1637681895623;
        Tue, 23 Nov 2021 07:38:15 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:15 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 5/7] PCI: keystone: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:38:00 +0100
Message-Id: <696b879b141c9ff6b2de21b6453be7999008f2d4.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The keystone PCI controller driver only needs "struct ks_pcie_of_data *"
during probe(). Replace of_match_device(), which returns
"struct of_device_id *", with of_device_get_match_data(), to get
"struct ks_pcie_of_data *" directly.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 865258d8c53c..bf4755cb6c50 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1087,7 +1087,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct ks_pcie_of_data *data;
-	const struct of_device_id *match;
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
@@ -1104,8 +1103,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	match = of_match_device(of_match_ptr(ks_pcie_of_match), dev);
-	data = (struct ks_pcie_of_data *)match->data;
+	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
-- 
2.25.1

