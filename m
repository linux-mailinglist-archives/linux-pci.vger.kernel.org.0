Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249F45A69F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhKWPl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhKWPl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDFC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l16so1725084wrp.11
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOyOFHSB6oYKtXPvxxZdcgKTN+X0OKDN76Q1B//9ysI=;
        b=QCUwPlbzSszi9ly4glgcfjLd7c48fGUounsbby+cYxDBYVNyFw0FNoDNYssSne2Ohe
         nDN5cmnJaBWFZGc2Hhkbxnv3FGdG7Pk/2OwGVa6Mg3B2/uLBmH0dsotlSkOOvdSc6pig
         a4GjKrBQCT4iQn1BhpOmyRWVfyoJzpboU0EaoLuKh46pdFN0eUEiyGBQ8ORnrA2hqSHX
         VyDz4KD54EXpsSjaBcSVKhVtQwBKH2AfSJrzLAEVrS1LP35dzRAFEUwaf2tuBoHG9+fP
         Y2RUDRXU2gEM1DB+51ClIpCEFBw0vSP+fAPWL8VtjYc8M6kmUDQRlUTCE+ElrvAjo+GN
         eM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOyOFHSB6oYKtXPvxxZdcgKTN+X0OKDN76Q1B//9ysI=;
        b=Gc2P54DEMUG7K3VGGfD4UfdYDWTyVxrtyzEfvdKYoZ3zbuGvr+BNck9ixLP4ZyYebm
         4KNmq8cqw7lRBNDfdu6x2nzr2juNvFAq7myUxCBo14J1arWLdkKGqsyeOkZBiQW/EJg+
         Yc6G/+aXy3aUZntUBI/6au/tpGUJAFFv3f9Ys4Tz/zAvwIox+jS7DD5ZHbDtnGoJAU/e
         AdT10titJuAWz3d2lh2iCfJaQZfQoQs8yX+5ZMRNi415RZuISvRLtJWTnZNdJlaGtSrY
         XP/c1JTt7dA0Q4C7hr6lYj163+2i2Nf3nEg3k8+Odwgx8BE+KO3oIDr2amC7ZueKCzKH
         3iZg==
X-Gm-Message-State: AOAM532VkHOWtDLkVRzL2CploAxy/Iz8OXLx2CuQ28Osca5DVQJeLEqj
        EUmObxU+/Orkf5UGHQjmQMc=
X-Google-Smtp-Source: ABdhPJz8rZJli9lsHIq5/ic2XRpKCSfGqQQjV9zclMz3HAyDwiw4wGAMjR4GFs0j6yNXM5O+vtTh+Q==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr6274088wrp.18.1637681897180;
        Tue, 23 Nov 2021 07:38:17 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id h15sm1959273wmq.32.2021.11.23.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:16 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 6/7] PCI: artpec6: Prefer of_device_get_match_data() over of_match_device()
Date:   Tue, 23 Nov 2021 16:38:01 +0100
Message-Id: <506cba227d09e1f94d9e34a81e7c2148fcaf5090.1637678104.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637678103.git.ffclaire1224@gmail.com>
References: <cover.1637678103.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The artpec6 PCI controller driver only needs "struct artpec_pcie_of_data *"
during probe(). Replace of_match_device(), which returns
"struct of_device_id *", with of_device_get_match_data(), to get
"struct artpec_pcie_of_data *" directly.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index c91fc1954432..2f15441770e1 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -380,17 +380,15 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct artpec6_pcie *artpec6_pcie;
 	int ret;
-	const struct of_device_id *match;
 	const struct artpec_pcie_of_data *data;
 	enum artpec_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 val;
 
-	match = of_match_device(artpec6_pcie_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct artpec_pcie_of_data *)match->data;
 	variant = (enum artpec_pcie_variants)data->variant;
 	mode = (enum dw_pcie_device_mode)data->mode;
 
-- 
2.25.1

