Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21192904B4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407168AbgJPMEn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 08:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406845AbgJPMEl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 08:04:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B49BC061755;
        Fri, 16 Oct 2020 05:04:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h24so2736519ejg.9;
        Fri, 16 Oct 2020 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=99xt5tOxYL+SsaIFtCFHk6b78TJvFfz6VlYtP/wHSYo=;
        b=AbuFMvGpPxRfTL0Vkv6wAp+YVoZ+whZsEj43YJm114aAlLx625EC1u/srVJNFN1TCC
         G+K86rE8ptlqoY4+Ytn1Rrq5kKmuvHcYNmKxZOtkBh0806jurIDiL8iSwp99+kf8KKE/
         YAVmXkE8a801FFX/0zTyt8b0RIFCa695HTQBmzwCIpAcn7rPDe15pCDNvgBqgJ+kz65J
         f4gTRCj5ViPxdG5IBArXJTrFGCaYofVs/b4CnHXgPky197QMpfNw+iExW3S8s8WJckMq
         +ClQ5QS6J9fq70XpZ2i5r+1uopRCp751MF0Jvlo1uUIefTq6vuurS0crkIwbh9ngHYF0
         hegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=99xt5tOxYL+SsaIFtCFHk6b78TJvFfz6VlYtP/wHSYo=;
        b=ryOQKUuwuBIpsvDKjo3SqY8z+kTnWzpvNCTG1/OqCn1R572V0E7IFB0NXLxgnScW75
         k1LXK1IGsgLN6PZ4KjbPzhwLARnxT+F22AW7/eJt/pgvKm1wnrWmzAzRF65fVNT0uiS5
         Sipu84SLDmztavoFAAiNBfVV9jcjtgfej4SjjTM/rvxRhAF0TioqyXTBFq0e+35/G8aA
         wKYVAUzoX22Z/UtJuYCzMiuJeZ+dJ9HJWjEpm27WLaqUglh5Rkjc0PVamz8HFjT1TdfB
         ecgIsjMNr60xvlX3qJal1UszFSyJN4KjzeWdYks4cd0b+U8b4gr0s3FXQhmdD+EIcoL/
         t0MQ==
X-Gm-Message-State: AOAM532Fjb3rvc5uWYvY1uQdgxNML6CU+8NWGZQDhrk/HHtp8K2XzqSI
        d1C57QV+RZQWnCc924Tqh2cZRS+xCqm24Q==
X-Google-Smtp-Source: ABdhPJx96sTZPYVmd1ghvhar6UA0CdNGRd8QNjox83Ax1W1Vq/YQtzqh/rrU7JIMwtMpdOSQqPb1dw==
X-Received: by 2002:a17:906:1f08:: with SMTP id w8mr3260880ejj.181.1602849879120;
        Fri, 16 Oct 2020 05:04:39 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id g18sm1450298eje.12.2020.10.16.05.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 05:04:38 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar: Always allocate MSI addresses in 32bit space
Date:   Fri, 16 Oct 2020 14:04:31 +0200
Message-Id: <20201016120431.7062-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

This fixes MSI operation on legacy PCI cards, which cannot issue 64bit MSIs.
The R-Car controller only has one MSI trigger address instead of two, one
for 64bit and one for 32bit MSI, set the address to 32bit PCIe space so that
legacy PCI cards can also trigger MSIs.

Fixes: 290c1fb35860 ("PCI: rcar: Add MSI support for PCIe")
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/pcie-rcar-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 1194d5f3341b..ac5c7d7573a6 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -753,7 +753,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	}
 
 	/* setup MSI data target */
-	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA32, 0);
 	rcar_pcie_hw_enable_msi(host);
 
 	return 0;
-- 
2.28.0

