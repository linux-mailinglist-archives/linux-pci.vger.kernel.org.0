Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF30BD479
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 23:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfIXVqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 17:46:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40501 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfIXVqf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 17:46:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so3056368oib.7
        for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2019 14:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//h/OxzQrbFvZbG2t2Yg6Jg8Wa0hSEoVjKepOuIzhVo=;
        b=QdcNRWOmikEB0WXQrUJJW3rqj+5d6D5iePotMbL1tGj1d62H5MIx72H3hvHpz5Qn9r
         HnTbG7zZqz4/rBvoNr7giMgG15ljX1kSFABRRHc5FjQoc9aBaDH3Cr2L2tTjRngPC30p
         oA5VTFgQyF1FQOAQGic5WvfzvhMpCMBMWDBrqOgbnKdEC8LXIqXxygCFFsbPvTbeiiKK
         MlyP7vj6sHsDiHQcbsNQXLUXhwSS6KeNCO6S4IP0w4XnTvdGoOqXwiWRo45P5lpwQsbw
         nfgCJdNMeRBgdP1NZEGj2x7CWueeVvbmFBme2Vf2s1qHrdlEX1RX0uDdlUvgL0lBekv/
         mxzQ==
X-Gm-Message-State: APjAAAVrUagDAB28zUYPEY3LvtKjcf4abO6npHUDOOtmggDqZsfnFP9N
        2EWD+3begwiiQ4CBEklNbDUiuTs=
X-Google-Smtp-Source: APXvYqxl9MzHk9KICSl5mCZBeGMuFnuTeQOIA/uFntXG9yZg7dp6GjNzV/dG2YNqwJRwgtOUA/zTQQ==
X-Received: by 2002:a54:4105:: with SMTP id l5mr2014401oic.2.1569361594676;
        Tue, 24 Sep 2019 14:46:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s66sm976787otb.65.2019.09.24.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 14:46:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org
Subject: [PATCH 02/11] PCI: altera: Use pci_parse_request_of_pci_ranges()
Date:   Tue, 24 Sep 2019 16:46:21 -0500
Message-Id: <20190924214630.12817-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924214630.12817-1-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert altera host bridge to use the common
pci_parse_request_of_pci_ranges().

Cc: Ley Foon Tan <lftan@altera.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: rfi@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-altera.c | 38 ++--------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index d2497ca43828..2ed00babff5a 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -670,39 +670,6 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
-{
-	int err, res_valid = 0;
-	struct device *dev = &pcie->pdev->dev;
-	struct resource_entry *win;
-
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, NULL);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, &pcie->resources);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry(win, &pcie->resources) {
-		struct resource *res = win->res;
-
-		if (resource_type(res) == IORESOURCE_MEM)
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-	}
-
-	if (res_valid)
-		return 0;
-
-	dev_err(dev, "non-prefetchable memory resource required\n");
-	err = -EINVAL;
-
-out_release_res:
-	pci_free_resource_list(&pcie->resources);
-	return err;
-}
-
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -833,9 +800,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	INIT_LIST_HEAD(&pcie->resources);
-
-	ret = altera_pcie_parse_request_of_pci_ranges(pcie);
+	ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
+					      NULL);
 	if (ret) {
 		dev_err(dev, "Failed add resources\n");
 		return ret;
-- 
2.20.1

