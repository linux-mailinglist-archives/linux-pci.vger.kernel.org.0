Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E145A69D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhKWPlY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhKWPlY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA42C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so39733260wrb.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASSotiF2cSkOj3gpIahmP5n1YFsWO59L2r5BleZzS48=;
        b=m+dHVEqHiNpekRlEhfyDp4MU1D8mx8CoY52yMiUjeLZfdMJ2GWiIDqaqdLd5qp/68O
         4fFbapNZ8wV819LdMOATSCym8ynRLNMGt3GqAT3reJPmcnrNeCpARJO3iZSM9pGg1xoY
         /nsn6zZoeLktqiqk0MjZo0TZHegfitUSH4Bf2ynUcaE7dS5EtDtF0aO/xQn+cAZvgw8R
         cMEhDonN1qq8tae0Wp9N1TarM3waZC7ktRzHEHHKhJ5tTRc85gDePt3pJZQEsEhN+xvi
         2nsgGrZYZUKgRwAmoSNnJdxG/jvfsEqSrQayb/rfFvBhCNukWkes3Rq2MU9BRUl4M/vK
         Aiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASSotiF2cSkOj3gpIahmP5n1YFsWO59L2r5BleZzS48=;
        b=B1GAX2tY+LaTeRlHoMJdI6Mkndl/g1V6Q+twLukyK9Dyc2qS6JeyK/uHBje/C8V+dp
         QgFgnG90O7iXEgJistwZVdi5+bfTx2FhYF81UlrAanqchAe2FVWV7bWEGiSHaCLw3zOR
         yBQIlwKcvliuG65EaIGFydN7fS6vh/NxBJmGWlJzrD/jfuR/SmNJHfa2WZ/kgjW51b33
         pAzK4+BqYNAQkIkwaloaGPpBYsZGAFF3d8SGduZZX6qRrKzjurMN/kEuDQgz5LtCXKzz
         verMhJQLVxZWz8eWTBrWK7vK/NDJhxFI18pwNc2Bjwm9JsqPWokXtnDYF4eIDZd5W+Xa
         8TIQ==
X-Gm-Message-State: AOAM530jZ0ME32D8Gx8N5aMNQkocp8VxK3cSIrmX0yv3HajVJZ+Q6C0P
        RHyXvWqOy6xNF/C2AXKYqmivQDMtu7E0RQ==
X-Google-Smtp-Source: ABdhPJyF+iq/I2z84C8f9HHsBQSJ2nVFChurV+kxciIEQQkcPMpYGFY0t1C/1JyAKHF3r0MZIOGGQQ==
X-Received: by 2002:a5d:584e:: with SMTP id i14mr8690966wrf.386.1637681894202;
        Tue, 23 Nov 2021 07:38:14 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:13 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 4/7] PCI: dra7xx: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:37:59 +0100
Message-Id: <e5ee4df18f3ec1e4fff4f32c498e76fa612c3097.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dra7xx PCI controller driver only needs "struct dra7xx_pcie_of_data *"
during probe(). Replace of_match_device(), which returns
"struct of_device_id *", with of_device_get_match_data(), to get
"struct dra7xx_pcie_of_data *" directly.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a4221f6f3629..12d19183e746 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -697,16 +697,14 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	char name[10];
 	struct gpio_desc *reset;
-	const struct of_device_id *match;
 	const struct dra7xx_pcie_of_data *data;
 	enum dw_pcie_device_mode mode;
 	u32 b1co_mode_sel_mask;
 
-	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct dra7xx_pcie_of_data *)match->data;
 	mode = (enum dw_pcie_device_mode)data->mode;
 	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
 
-- 
2.25.1

