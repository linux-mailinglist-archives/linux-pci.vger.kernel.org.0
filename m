Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7445FBA9B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJKSmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJKSmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:42:16 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA87F13D;
        Tue, 11 Oct 2022 11:42:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o2so1883480qkk.10;
        Tue, 11 Oct 2022 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VS2GXG21DjRdeQjnmza5VEtpvDq1HC+087/4J2zXY70=;
        b=kIkrDBQ649U2RhFRoxOmCqKmWosJ2Ya9xlSmG2NtSdMT3UM92ZKefI1r2Cfqec69Fb
         i0H8dvUKeDZmxx+kB8/kXIPJ9U7da18cXsq2PnSsQNMTmetDy+gD+N+GjWYhz0dhWIMz
         ycBtLQVh4RfCPGWwwbWAbVAF+7QfwEtiejNgtuabQU6ColpwLbXSQAk/9zFN46aYY4+F
         8p/7fnoOSLEK47Muc8DjH5qam7YY44lBmsMNNEqWXQ5//TE+lwTK7gWFegK69LZJWv8v
         QNM4nTj7OtA4vZC9MHnElaE100dG/0R0ixMl479xEx9Yw+lQ4eyEAYPL4OpTHzZq3EQr
         1kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS2GXG21DjRdeQjnmza5VEtpvDq1HC+087/4J2zXY70=;
        b=UBstajXbKsTPxwPD42RlkHZvezQCqHUHFaGooJ9B6kRiUNSgZ2pSWsmWSXnyEIEcDO
         pZhKGDtWUaywtJHZn5ErVDSuHHfwHQliykkGUzwCtIIG25XrXcCUU2g7wLKZYgegDyuO
         pvpWFagShMkiwSJDo03JeRV2jqtzxWYlaeP7uDrIgcE8XWgR63y36ouw4raHpRQ+Gjo4
         h07kAIGbTTQvDVaB+W/R/jc9US28Q9lvXYnbG8O6ZJtW6MDO09tVAJXKELBUPMxx4syu
         qizkl9904EIDdi8dX5bqmcJ1U9U5Qk9c4/hp8ls9gv9EW2lykRVinRLFyw7CBHSBpFf3
         Y5vw==
X-Gm-Message-State: ACrzQf1uclqC/0WYEMjjatmw+/Irw2sqbxdWE7ZxhPEwaNg/YQiiXBIM
        XKqfAhbMwN+A/t7A6bfSS/1FYRHZHm4=
X-Google-Smtp-Source: AMsMyM53rDZRF8GSDj2tWNygq39EPCcGobdIWvrgxjFSBGYyZVwV0M5jHCi6Y28pLL6YgxnDaTLfEA==
X-Received: by 2002:a05:620a:25d0:b0:6bb:f597:1a3 with SMTP id y16-20020a05620a25d000b006bbf59701a3mr17401628qko.43.1665513735071;
        Tue, 11 Oct 2022 11:42:15 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05622a488800b003938a65479bsm10961732qtb.10.2022.10.11.11.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:42:14 -0700 (PDT)
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
Subject: [PATCH v2 1/5] PCI: brcmstb: Enable Multi-MSI
Date:   Tue, 11 Oct 2022 14:42:06 -0400
Message-Id: <20221011184211.18128-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011184211.18128-1-jim2101024@gmail.com>
References: <20221011184211.18128-1-jim2101024@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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

