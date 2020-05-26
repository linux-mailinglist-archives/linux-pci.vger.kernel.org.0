Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A241E250D
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 17:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEZPKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEZPKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 11:10:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73246C03E96D;
        Tue, 26 May 2020 08:10:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci23so1453104pjb.5;
        Tue, 26 May 2020 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PAeTgH6EFfvFnpLdTFbvRq34natBIZioqoaAH9SV2M=;
        b=HxB2pwcs6+tFYMRqTRFvA3B4DE7SDOWWHJUaPBdyIalvBVvvFiLWZJSIqcYWnuDseR
         sJXwr7rNgWLZcHsBzjpfSckHpLQKlwNMV7q7V9oiGy7LzXlaorNXCBuTTOAuJG9RLIvt
         GowoodB7JPF/OEWXGrel5fsDSvMBIuk9flZiIkkayRE+9VcCCJ4JvqTIOK5opqYi8OfX
         dQokAdXLqxTeEKZmBEKcLY08Z1XxZzrm3j5sY3R/ui8qmdr09Tqv76HE23P03qJfynrx
         Q0LKyxVAsugZZ5cWCiSOhKq1JdobwxVG7VS255FHV7eaQuPUETz7ciUqi096ne5aWPLq
         D61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PAeTgH6EFfvFnpLdTFbvRq34natBIZioqoaAH9SV2M=;
        b=Gf8GRJaLhlCIsr3sAVhqxLDtfP+xW8qy2olHXaxw4dDPb3rJjgD/SNVhj8wpClDtYf
         N13If/7VRVQ05LAAdTuSY2xfvvdZ2tXrQuzsA72fkz+bl1OBqbcslUFHRpFIsmiwlY5z
         wN/kgbIGdXRTqaNJ/Fo8gWkNzpowqF37un3aFMLtDuZKnaL3TJgzPvCbsiCKoEbVCDyk
         0pDNMMesd/zQBCJjRxfWMlbp092+Xj1I/N7uX0NYzZY7Pn0OkTBa237h+C6UYz1KfexJ
         ZFr9ee8VLro17ZTzfr2Vh9x+R8r0qmDXGOt/D47XpTRib2pGnuH+ZaR9Kabkgp6220Vl
         xlIg==
X-Gm-Message-State: AOAM532Iy5QfksSP/hFJzZiufWRZeoVysNSnu+M+hS5iGyKR7slwoUnt
        8Fuln0VHdiLk/aaymEXJ1pQ=
X-Google-Smtp-Source: ABdhPJztqf+j91YDUmH604FAJKzvq76tLyH27bxF6Wn8v7Ve+rWa8JAQfaFRXeMbI/9knlgwQHgfdA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr1532434pls.102.1590505801956;
        Tue, 26 May 2020 08:10:01 -0700 (PDT)
Received: from localhost ([144.34.194.82])
        by smtp.gmail.com with ESMTPSA id a2sm15530771pfl.28.2020.05.26.08.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 08:10:01 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, jonnyc@amazon.com,
        thomas.petazzoni@bootlin.com, pratyush.anand@gmail.com,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] PCI: controller: Remove duplicate error message
Date:   Tue, 26 May 2020 23:09:54 +0800
Message-Id: <20200526150954.4729-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It will print an error message by itself when
devm_pci_remap_cfg_resource() goes wrong. so remove the duplicate
error message.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c |  4 +---
 drivers/pci/controller/dwc/pcie-al.c               | 13 +++----------
 drivers/pci/controller/dwc/pcie-armada8k.c         |  1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c        |  1 -
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8c2543f28ba0..60bfb5bcbd37 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -234,10 +234,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
 	rc->cfg_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(rc->cfg_base)) {
-		dev_err(dev, "missing \"cfg\"\n");
+	if (IS_ERR(rc->cfg_base))
 		return PTR_ERR(rc->cfg_base);
-	}
 	rc->cfg_res = res;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 270868f3859a..d57d4ee15848 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -67,13 +67,8 @@ static int al_pcie_init(struct pci_config_window *cfg)
 	dev_dbg(dev, "Root port dbi res: %pR\n", res);
 
 	al_pcie->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(al_pcie->dbi_base)) {
-		long err = PTR_ERR(al_pcie->dbi_base);
-
-		dev_err(dev, "couldn't remap dbi base %pR (err:%ld)\n",
-			res, err);
-		return err;
-	}
+	if (IS_ERR(al_pcie->dbi_base))
+		return PTR_ERR(al_pcie->dbi_base);
 
 	cfg->priv = al_pcie;
 
@@ -408,10 +403,8 @@ static int al_pcie_probe(struct platform_device *pdev)
 
 	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
-	if (IS_ERR(pci->dbi_base)) {
-		dev_err(dev, "couldn't remap dbi base %pR\n", dbi_res);
+	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
-	}
 
 	ecam_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!ecam_res) {
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 49596547e8c2..896b95d6917c 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -317,7 +317,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, base);
 	if (IS_ERR(pci->dbi_base)) {
-		dev_err(dev, "couldn't remap regs base %p\n", base);
 		ret = PTR_ERR(pci->dbi_base);
 		goto fail_clkreg;
 	}
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 7d0cdfd8138b..cdfde1bd7d8e 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -273,7 +273,6 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base)) {
-		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
 		ret = PTR_ERR(pci->dbi_base);
 		goto fail_clk;
 	}
-- 
2.25.0

