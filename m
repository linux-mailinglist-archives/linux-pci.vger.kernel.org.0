Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A94C25F161
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 03:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgIGBMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 21:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgIGBMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 21:12:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2AC061573;
        Sun,  6 Sep 2020 18:12:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so11553208qkf.0;
        Sun, 06 Sep 2020 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5maNrcLk88wuTov+ZELvNqVYmxoBjqjpNPpke/rV2w=;
        b=R3dlLRsV9XTYn0tt6vIfiGszKEc6HIIgQBe2xEW7nau0WLxPD5dZl7a8qHgHFkNEpx
         pVe+XGAD4zPCYhLTtrivAHLaGfX44yiw2/EzkRAeYSYxaSOyGctNhrf+EJoyMZNFOOVl
         2BOogiOSQzah651ovTJKKH+/Hf0Hgpr45FHkBf+PIok7e+r5DHETI7PTKzgocg5WE3nQ
         7Qv6zMFdBp2rQdQ1x6w7bZRVrKI0mDmeEUFRKITOXoNLYTejP/HpkXxt5tGtnTBNZi7/
         /QmPKKSLDI2GGs7Q2vKifJOEvpPeSnYsEsFZUTN5efOROJnW4mGe1g/XpAuIFjDwZEDE
         a+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Z5maNrcLk88wuTov+ZELvNqVYmxoBjqjpNPpke/rV2w=;
        b=d4CHS+0fUskvOvKAS+7mL9DPfdrefanI2TCFnWa+wnD0121P7Ichn9JsyzAXhumMqP
         9IjJWQPsnmMVepCBarG64XZMlLwdAdqn8y+Laf5YpQBMH0Onq958hUWAA5rlE1y7FzxX
         3r/CpINzcCeysWrGmkOKq7hSUJGQsJaFQHGpz1TzKSWTJLUG9ZwTqdnBwHf67rcBx9nl
         ZeYCc0AtBd906h5t/8ByMaUQ3t7iOP5QvzbIP+0ZV0iD/YJcn+F/comS1hHPM38165lz
         sa2grnjpbAocpYvZc98Wnaxcg9arFN5HYMg3FS6MSIvI+BAVjUnmUnW8wi93+OF7+XqR
         I10w==
X-Gm-Message-State: AOAM532e2HDwXM7AZJzyzznLeqv4L7mo3J5Nj8TIDPc03HYj3IJ60xiJ
        bXuQFiQAddu/diGs0u11UiY=
X-Google-Smtp-Source: ABdhPJz7q12uEimkzQTG1LqdYhUuf1xctUcqRbL51mks/laG8ZoWPBCepZqQqjhWl3lUiVCTRKz90g==
X-Received: by 2002:a05:620a:137c:: with SMTP id d28mr15696302qkl.160.1599441166090;
        Sun, 06 Sep 2020 18:12:46 -0700 (PDT)
Received: from athos.glmx.com ([70.19.70.200])
        by smtp.gmail.com with ESMTPSA id m10sm1269662qti.46.2020.09.06.18.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 18:12:45 -0700 (PDT)
From:   Ilia Mirkin <imirkin@alum.mit.edu>
To:     ansuelsmth@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Ilia Mirkin <imirkin@alum.mit.edu>
Subject: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
Date:   Sun,  6 Sep 2020 21:12:38 -0400
Message-Id: <20200907011238.3401-1-imirkin@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This makes PCIe links come up again on ifc6410 (apq8064).

Fixes: de3c4bf6489 ("PCI: qcom: Add support for tx term offset for rev 2.1.0")
Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3aac77a295ba..985b11cf6481 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -387,7 +387,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 
 	/* enable external reference clock */
 	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
-	val &= ~PHY_REFCLK_USE_PAD;
 	val |= PHY_REFCLK_SSP_EN;
 	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
 
-- 
2.26.2

