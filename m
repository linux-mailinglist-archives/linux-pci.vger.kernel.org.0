Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648661ECAE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 09:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKGINo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 03:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiKGINn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 03:13:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A7FAE53
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 00:13:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h193so9766154pgc.10
        for <linux-pci@vger.kernel.org>; Mon, 07 Nov 2022 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y71pLMvooIRecOUj8AXrDoMOrUDoDubP/fQuwH79cVQ=;
        b=W7E7bB/v9cZQW93GKuGYJEJvY7ThtLs55R2ykpJdCI1aALO6M5vSiJd0lvjmxfNMMg
         wZiIJhDNqe6+tHHHtPW4Ue3sQK55dTfTuAdMeWJ+XEuZnGQMVC80Gly9j5tk+RbDSZdl
         f1LCtU+1QqqFUsLdQcxRpAOircqMCAGCIjTjPxWAN6LbvM5bP9pJswTbyDACmLYqslaA
         teX0SHTXTMOzq71cnehss6sz08a8Mtlw8zi9w9zfvE1E2xUvB59DVnNmvOOqsDq3oGFY
         PVdvNe5EPnKbO1QBUQXEKNX5Rm4kCfp3AUF8jLznBJvhtDrzKN2Hvx8v6iKI2Ih4FEce
         K0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y71pLMvooIRecOUj8AXrDoMOrUDoDubP/fQuwH79cVQ=;
        b=1ot30I//AqZeE+rFwoznZ8wpNC+4S6+phMSbCpiSF5EsbXzJyxEs8Z4/iS5B18GhEd
         i9U7PXxRrrPNnmXktBvTfJU+ouHVxxErr8+Il/cyxuYs8EDkAT9j1zQRb59f9e1/1nPY
         y8EU9rdhwXqxoeSO16h1O8/khY98ySw+4H0v4/Eg0NNtjzncksnhCKGY0RWYDQgL+lFh
         AdEi8M4QhUYEZLsSfqTHn6zBntoQym3+J2B0ATeUnZDSL/dFY1kurJ8MY7WTcAawGbYf
         NVziK23SIm9FZRIXmaO6g5+wJe5YKCq6/aFQGCPCIQ94ajziTAs77nma+KtDaPkA6dv5
         CfGg==
X-Gm-Message-State: ACrzQf3Hc3fewmW8Ld+D+SEjtXlZQVqLLwOujoW6lEprQGuumBMFJKQO
        KDQaoclKnb6pRMEC1tONDNGb3Q==
X-Google-Smtp-Source: AMsMyM4Sl/kXw/jB7JyTksaM0VO42+EshFVOhqAXTLRxKZ77IelcNlGxrwh8AxGDugduoJGX4PAyMA==
X-Received: by 2002:a63:dd4f:0:b0:46f:fae3:373d with SMTP id g15-20020a63dd4f000000b0046ffae3373dmr26459600pgj.31.1667808822337;
        Mon, 07 Nov 2022 00:13:42 -0800 (PST)
Received: from [127.0.1.1] (117-20-68-146.751444.bne.nbn.aussiebb.net. [117.20.68.146])
        by smtp.gmail.com with UTF8SMTPSA id pc3-20020a17090b3b8300b00212cf2fe8c3sm17579487pjb.1.2022.11.07.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 00:13:41 -0800 (PST)
Date:   Mon, 07 Nov 2022 08:13:27 +0000
Message-Id: <20221107081327.336239-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] PCI: mvebu: Set Target Link Speed for 2.5GT downstream devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

There is a known issue with the mvebu PCIe controller when triggering
retraining of the link (via Link Control) where the link is dropped
completely causing significant delay in the renegotiation of the link.
This occurs only when the downstream device is 2.5GT and the upstream
port is configured to support both 2.5GT and 5GT.

It is possible to prevent this link dropping by setting the associated
link speed in Target Link Speed of the Link Control 2 register. This
only needs to be done when the downstream is specifically 2.5GT.

This change applies the required Target Link Speed value during
mvebu_pcie_setup_hw conditionally depending on the current link speed
from the Link Status register, only applying the change when the link
is configured to 2.5GT already.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/pci/controller/pci-mvebu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1ced73726a..6a869a33ba 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -248,7 +248,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
+	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl, lnksta, lnkctl2;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -339,6 +339,22 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
 		  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
 	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+
+	/*
+	 * Set Target Link Speed within the Link Control 2 register when the
+	 * linked downstream device is connected at 2.5GT. This is configured
+	 * in order to avoid issues with the controller when the upstream port
+	 * is configured to support 2.5GT and 5GT and the downstream device is
+	 * linked at 2.5GT, retraining the link in this case causes the link to
+	 * drop taking significant time to retrain.
+	 */
+	lnksta = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL) >> 16;
+	if ((lnksta & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
+		lnkctl2 = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
+		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
+		lnkctl2 |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+		mvebu_writel(port, lnkctl2, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL2);
+	}
 }
 
 static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
---
2.37.2
