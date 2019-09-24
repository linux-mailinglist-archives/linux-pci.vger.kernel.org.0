Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F08ABD47C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394047AbfIXVqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34149 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388524AbfIXVqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so3067903oii.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFGVP1gTb36lMoxSPHjuhPE/KeYNGUEeUXlv9JWR1dI=;
        b=t+9Il7XrKSmtyqMrEl4UTFcIGVYtzCkqN7mSNqWxPfF9lM38jqud2mYI5P2UquTXg1
         FOlKs5w1IVhd/orTepaz7hKY+iI5UBDNV/D5rHciu05SgZNs3BOJsimBRONtirdyp4Ya
         A6DZ2FP3f4bFT73bEWfORSmRMU/yuvgQvJPkeDxw0kEIRKpiASVSpmR05T4+VmbcraOq
         +iZWUnue5czVXp3gTwoxMQDoeiKMmKb5u0IoOxjjKYCqiDbpOtrj/N/2uEj26sQVFZuW
         VbDYKfOd2Kw98NK9yHn1gEEIZhJ5vCuiL35YNCUexypGGlxfaUFGzv6jkY4So1Ev+PXY
         CikQ==
X-Gm-Message-State: APjAAAWeqkT91uEd/ShyJ7aygo2zUNfMKg9FeTIUV6Z5Ola8xtzGK54c
        kw/ZwDzf5sckeY8ob5P2Fo5SzOE=
X-Google-Smtp-Source: APXvYqxzmL05Q/VVNyaKHOpBcnC2Byr6GGa7fArDJxSh7BTq5kENGbIQ1jSGPDjT/+961bZtkS/6nQ==
X-Received: by 2002:aca:5254:: with SMTP id g81mr2094149oib.67.1569361597595;
        Tue, 24 Sep 2019 14:46:37 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/11] PCI: versatile: Use pci_parse_request_of_pci_ranges()
Date:   Tue, 24 Sep 2019 16:46:24 -0500
Message-Id: <20190924214630.12817-6-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert ARM Versatile host bridge to use the common
pci_parse_request_of_pci_ranges().

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-versatile.c | 62 +++++---------------------
 1 file changed, 11 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index f59ad2728c0b..237b1abb26f2 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -62,60 +62,12 @@ static struct pci_ops pci_versatile_ops = {
 	.write	= pci_generic_config_write,
 };
 
-static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
-						     struct list_head *res)
-{
-	int err, mem = 1, res_valid = 0;
-	resource_size_t iobase;
-	struct resource_entry *win, *tmp;
-
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, res);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry_safe(win, tmp, res) {
-		struct resource *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			err = devm_pci_remap_iospace(dev, res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-
-			writel(res->start >> 28, PCI_IMAP(mem));
-			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
-			mem++;
-
-			break;
-		}
-	}
-
-	if (res_valid)
-		return 0;
-
-	dev_err(dev, "non-prefetchable memory resource required\n");
-	err = -EINVAL;
-
-out_release_res:
-	pci_free_resource_list(res);
-	return err;
-}
-
 static int versatile_pci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	int ret, i, myslot = -1;
+	struct resource_entry *entry;
+	int ret, i, myslot = -1, mem = 0;
 	u32 val;
 	void __iomem *local_pci_cfg_base;
 	struct pci_bus *bus, *child;
@@ -141,10 +93,18 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	if (IS_ERR(versatile_cfg_base[1]))
 		return PTR_ERR(versatile_cfg_base[1]);
 
-	ret = versatile_pci_parse_request_of_pci_ranges(dev, &pci_res);
+	ret = pci_parse_request_of_pci_ranges(dev, &pci_res, NULL);
 	if (ret)
 		return ret;
 
+	resource_list_for_each_entry(entry, &pci_res) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			writel(entry->res->start >> 28, PCI_IMAP(mem));
+			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
+			mem++;
+		}
+	}
+
 	/*
 	 * We need to discover the PCI core first to configure itself
 	 * before the main PCI probing is performed
-- 
2.20.1

