Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48A2B4BCC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgKPQ4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgKPQ4L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 11:56:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D5C0613CF;
        Mon, 16 Nov 2020 08:56:10 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so2258630wrg.7;
        Mon, 16 Nov 2020 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rgqx75mWHRgXFv0CwsRMCHA+Jcb7vaejQXT/lvk4loI=;
        b=R4iHLOz/BtXQffuiBz0GFIa0q6Lg5X2oAtQfBOGQDXzIe7Mk9aRwyl4IuT2aiNOTER
         uCgxNsY75kHGqbARXkCeKliXExFRpdBRzqZa4znrXAPHSI8Q08RQibOiZMCFaBx4+WZZ
         vCqpygSaD+QLP0HOcqTAQWgXVV/tyPRdk4VJtt0GNJhh6g3/SfLMdGpl7XggqqWYWA6N
         ZGtawuIpnNbLiWV0LJguJir7mP5dYJxNB3gVDbMzYJII9YfOWHD0SfsMcu6OMwY02wES
         U7dx4hXvHUEa9XDUjv0lwv/DQXHrMlE5mc7YPavRRfP9PHiN5yjotVvZ9VQah3U357aQ
         hDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rgqx75mWHRgXFv0CwsRMCHA+Jcb7vaejQXT/lvk4loI=;
        b=PRPP8OctNcP1Sv5F9oHUZZwND5F38cejGLB7auF5EGS1ZeGd2wxV9WixVQeScn9Jd3
         uUGmBxHfTicbHtelqEPSzlTHxD69oUyi0XsCyEjfFiGCFR+XOurOeAcfPyxG2qG+fXkm
         lyCKJ4NKLg6MhEEDIFRR0fSiJyDHX+WkcOQl1Dt2WSfMXsnuQ35iLaE2BpoUb2H1O8R4
         ik1yxQ2ta4ENfrjuwji9X8df5hMVK45Yjk30tlWwQrtwGf8zH4DThXcdSe3uT5DCqjDD
         zALwzYczqjjGOBTkEs1VBF4vYneXklYic6UiS/+7XfpUzB4bl7Od7O+Zp97X81gVYjzs
         gzDA==
X-Gm-Message-State: AOAM530pa+sHvVkujolv5LpiFtZ82KIVQV4Brnskt+87tktdF/+UnM6J
        rvvGSUw5xoAAZ0RHKxCj0PK0HWcgtoIjow==
X-Google-Smtp-Source: ABdhPJxU6kxyRt4iLAsiDSGX2pIkswZYteymqDmfvEZ7u7/u0Yo6zB0NJQktTFsMB/UVTXHFnHIElQ==
X-Received: by 2002:adf:ea91:: with SMTP id s17mr20593129wrm.349.1605545769524;
        Mon, 16 Nov 2020 08:56:09 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id d2sm19314593wra.73.2020.11.16.08.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 08:56:09 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
Date:   Mon, 16 Nov 2020 16:54:07 +0000
Message-Id: <20201116165407.8050-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
doing 'return 0'.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/pci/controller/pci-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8fcabed7c6a6..4c52b2d58645 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1308,10 +1308,8 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
 		return PTR_ERR(pcie->afi_rst);
 
 	pcie->pcie_xrst = devm_reset_control_get_exclusive(dev, "pcie_x");
-	if (IS_ERR(pcie->pcie_xrst))
-		return PTR_ERR(pcie->pcie_xrst);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
 }
 
 static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
-- 
2.11.0

