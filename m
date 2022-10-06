Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB985F70E1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiJFWDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiJFWDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:03:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D311144C1;
        Thu,  6 Oct 2022 15:03:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m15so4656855edb.13;
        Thu, 06 Oct 2022 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LvjVJjiaNiXSnHQ1r2rSRUSpphAvqfDohp9kovF79Fw=;
        b=a6ENQW/fBFHrcuTkmewx1Ezqz7WdsS8lHYb3wM4ybF+4tVltkXPGBh9RMEa1f+9ZPE
         Cufh1iIddOcvRVvVoDjB8B8tJmcOTi/yZcYKcHaqPJksUXjbk2cSadcpBollm7L7ZUrL
         fOZWjV/N1lzLku1HwKyPOxlWfXbQnwoEnF5LoAOqCCg5PW7J895CKOglppVEpRT8NmRD
         587qGPl+18YVo1ZnaLoMc6O3138Pu8+h8geFWNPN7bOB41cOXgIM4MJK0fVi/ffMF0k6
         TQq9TFlzGZHE2iVhQmshUn02czDFIG/TcxYRey4Hl+pCTOlOtSs/4vAfpVQ7KYemoqF1
         lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvjVJjiaNiXSnHQ1r2rSRUSpphAvqfDohp9kovF79Fw=;
        b=QIU/48GTeSs+99oGWqng29uxtPZvQduS6aDOu2hAveqyOCmvOC7J1OyioMq0hF/ZE6
         prua9+DFWVG25aSXtB6uVo00erefBVkXxhCt4J3j+Pd2PDodwXdxJLgn6DUEVW2zWadE
         wUtAKSk//dvE8Xwgyn/L8vnb+YbkjvN084qTJPNPcDX0WLjmQ/jo5c9zgdxLbB35WEtD
         rgOh9eosJmCMmDLLqzrhVoXqlm5SnIO0xX2PTTffYCGkyCG3xH+GhwMH2DI1shJHDF4b
         /2h0PBPnK2mUBtCbM/tJ2kQqFapA6VkbVXDqb4D+sq6oLz5gBAAa4+JMaMArBJyqSpv4
         c3VQ==
X-Gm-Message-State: ACrzQf102+clib1iaor+TTeYp8X/OG3GDQo/f1Ykv456646GiIeUUf5A
        39jZfL/Jn75LskZyTYQNZlAoxC1yWyg=
X-Google-Smtp-Source: AMsMyM5lpw9c0Xsha7zB9F1tvzVa0a06GrkmekFIVkKbSmB4K3Yw55PgrVrY9J3MOB30bkMwUrJBtg==
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id b7-20020a056402084700b00453943b0bf4mr1785028edz.301.1665093811706;
        Thu, 06 Oct 2022 15:03:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090631ce00b0078246b1360fsm241484ejf.131.2022.10.06.15.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:03:30 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/5] PCI: brcmstb: Enable Multi-MSI
Date:   Thu,  6 Oct 2022 18:03:17 -0400
Message-Id: <20221006220322.33000-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006220322.33000-1-jim2101024@gmail.com>
References: <20221006220322.33000-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We always wanted to enable Multi-MSI but didn't have a test device until
recently.  In addition, there are some devices out there that will ask for
multiple MSI but refuse to work if they are only granted one.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 521acd632f1a..a45ce7d61847 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -445,7 +445,8 @@ static struct irq_chip brcm_msi_irq_chip = {
 
 static struct msi_domain_info brcm_msi_domain_info = {
 	/* Multi MSI is supported by the controller, but not by this driver */
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_MULTI_PCI_MSI),
 	.chip	= &brcm_msi_irq_chip,
 };
 
@@ -505,21 +506,23 @@ static struct irq_chip brcm_msi_bottom_irq_chip = {
 	.irq_ack                = brcm_msi_ack_irq,
 };
 
-static int brcm_msi_alloc(struct brcm_msi *msi)
+static int brcm_msi_alloc(struct brcm_msi *msi, unsigned int nr_irqs)
 {
 	int hwirq;
 
 	mutex_lock(&msi->lock);
-	hwirq = bitmap_find_free_region(msi->used, msi->nr, 0);
+	hwirq = bitmap_find_free_region(msi->used, msi->nr,
+					order_base_2(nr_irqs));
 	mutex_unlock(&msi->lock);
 
 	return hwirq;
 }
 
-static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
+static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq,
+			  unsigned int nr_irqs)
 {
 	mutex_lock(&msi->lock);
-	bitmap_release_region(msi->used, hwirq, 0);
+	bitmap_release_region(msi->used, hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&msi->lock);
 }
 
@@ -527,16 +530,17 @@ static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *args)
 {
 	struct brcm_msi *msi = domain->host_data;
-	int hwirq;
+	int hwirq, i;
 
-	hwirq = brcm_msi_alloc(msi);
+	hwirq = brcm_msi_alloc(msi, nr_irqs);
 
 	if (hwirq < 0)
 		return hwirq;
 
-	irq_domain_set_info(domain, virq, (irq_hw_number_t)hwirq,
-			    &brcm_msi_bottom_irq_chip, domain->host_data,
-			    handle_edge_irq, NULL, NULL);
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &brcm_msi_bottom_irq_chip, domain->host_data,
+				    handle_edge_irq, NULL, NULL);
 	return 0;
 }
 
@@ -546,7 +550,7 @@ static void brcm_irq_domain_free(struct irq_domain *domain,
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct brcm_msi *msi = irq_data_get_irq_chip_data(d);
 
-	brcm_msi_free(msi, d->hwirq);
+	brcm_msi_free(msi, d->hwirq, nr_irqs);
 }
 
 static const struct irq_domain_ops msi_domain_ops = {
-- 
2.17.1

