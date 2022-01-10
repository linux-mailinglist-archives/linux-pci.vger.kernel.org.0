Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F7488E3F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiAJBui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiAJBui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:50:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F294C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1685C60F55
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C9EC36AE3;
        Mon, 10 Jan 2022 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641779436;
        bh=Z+oLM0WGsacWums++yEXDtS3g+XWRV+IpKoTRBf8qd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSXwhcLfdTHovN36ghDUHjdIteoL6gVEU7Bh9D1lz9tuogIQCeIUkJIHsT433q84m
         zdEIxYohQwRQG08E/hiMMDRI7N6S/mJWpYuopyRQ3UU5eaOeHJb+7uewU9E/Tm/yn4
         avma10OGOOdWRsIM86HlNn/eG0yrLBu3DUY9s93U+MpkBQQBy4gxPBTaEMpGVUHqCp
         05ZXB4Ce7Awk+egpYA3H216ggOaFoo7CR/Vz3GEvlAb6h9NnPh7P9Hmqd5FRv+Q33c
         ZQOpJg+yhtafsj8vXwamcf0sNjRnJZ8lRvmQzsecB0wShEENTkb8BSIXqXVZd8yKFg
         JLDk7XfIHHDnQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 06/23] PCI: aardvark: Make MSI irq_chip structures static driver structures
Date:   Mon, 10 Jan 2022 02:50:01 +0100
Message-Id: <20220110015018.26359-7-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110015018.26359-1-kabel@kernel.org>
References: <20220110015018.26359-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marc Zyngier says [1] that we should use struct irq_chip as a global
static struct in the driver. Even though the structure currently
contains a dynamic member (parent_device), Marc says [2] that he plans
to kill it and make the structure completely static.

Convert Aardvark's priv->msi_bottom_irq_chip and priv->msi_irq_chip to
static driver structure.

[1] https://lore.kernel.org/linux-pci/877dbcvngf.wl-maz@kernel.org/
[2] https://lore.kernel.org/linux-pci/874k6gvkhz.wl-maz@kernel.org/

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 252033a46e1e..441100bacb68 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -275,8 +275,6 @@ struct advk_pcie {
 	raw_spinlock_t irq_lock;
 	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
-	struct irq_chip msi_bottom_irq_chip;
-	struct irq_chip msi_irq_chip;
 	struct msi_domain_info msi_domain_info;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
@@ -1199,6 +1197,12 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
 	return -EINVAL;
 }
 
+static struct irq_chip advk_msi_bottom_irq_chip = {
+	.name			= "MSI",
+	.irq_compose_msi_msg	= advk_msi_irq_compose_msi_msg,
+	.irq_set_affinity	= advk_msi_set_affinity,
+};
+
 static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
 				     unsigned int virq,
 				     unsigned int nr_irqs, void *args)
@@ -1215,7 +1219,7 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
 
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, hwirq + i,
-				    &pcie->msi_bottom_irq_chip,
+				    &advk_msi_bottom_irq_chip,
 				    domain->host_data, handle_simple_irq,
 				    NULL, NULL);
 
@@ -1285,29 +1289,23 @@ static const struct irq_domain_ops advk_pcie_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+static struct irq_chip advk_msi_irq_chip = {
+	.name = "advk-MSI",
+};
+
 static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
 	struct device_node *node = dev->of_node;
-	struct irq_chip *bottom_ic, *msi_ic;
 	struct msi_domain_info *msi_di;
 	phys_addr_t msi_msg_phys;
 
 	mutex_init(&pcie->msi_used_lock);
 
-	bottom_ic = &pcie->msi_bottom_irq_chip;
-
-	bottom_ic->name = "MSI";
-	bottom_ic->irq_compose_msi_msg = advk_msi_irq_compose_msi_msg;
-	bottom_ic->irq_set_affinity = advk_msi_set_affinity;
-
-	msi_ic = &pcie->msi_irq_chip;
-	msi_ic->name = "advk-MSI";
-
 	msi_di = &pcie->msi_domain_info;
 	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		MSI_FLAG_MULTI_PCI_MSI;
-	msi_di->chip = msi_ic;
+	msi_di->chip = &advk_msi_irq_chip;
 
 	msi_msg_phys = virt_to_phys(&pcie->msi_msg);
 
-- 
2.34.1

