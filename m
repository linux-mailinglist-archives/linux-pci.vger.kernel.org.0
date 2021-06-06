Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D7939CF0A
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 14:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhFFMe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 08:34:28 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45718 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhFFMe1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Jun 2021 08:34:27 -0400
Received: by mail-wr1-f54.google.com with SMTP id z8so14176776wrp.12;
        Sun, 06 Jun 2021 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYwRQbli1I4hRkELxP1eiNXBdqKWRZGGQHjz4e56pPA=;
        b=HxfDQx8n4eFxXVY5t1YWxq4nYBT+yLIpZ821I/YZFbkADzUxOTIkwYVGSQI5knuaVc
         rNnTzxvSo0yL2eJCNKLHNYFkdtd2DC0H20X5tLu1BYsgmHNeDD8jHt8xbjk+/kWNH/uV
         ounfRlhyqCjkLf1CXcza8Hif36Q8Lcu/6DfTgDAjrVG4LHmlhoH8eWlxwwc7YzvkOkrP
         yCVhwJJyiQ46Ifq+51uQnwRP1bAI6v3b8er7U0B+44SZmmhttZAG2F0fbV3GPpSPzGxR
         NeSwbBnmvCLmwqK8fFTZDM/iYT0mXn0GFE7No59K9+PNWxcqJx64XmOPmL7rCO0U+koC
         LTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYwRQbli1I4hRkELxP1eiNXBdqKWRZGGQHjz4e56pPA=;
        b=SL69PhtcTBU9uF89ANmnXC4eHIHHRiPYq8MMb92iBoOE0y3tU4JCRAyKblS6tVojab
         qzfSbHMu2K13NEiMPKYWRGgLMVxBbKNoPZcneGRx/D2xdqZLUAolJbOPYwWw7i174L7D
         uFzVTegeMLRYIqS9O4tsyNu2rY6gjmgOZBiS6LS7H4rGoZmOEX4FUbxaAxjo6FtWIqIO
         jYbPNSVzZpEivDrOgjApuVMuwsb0Zv5XDc0xU29XP47qtSaVXhkyj5E0KUcZf8uZElnx
         kt0k6BUJkBbk9Zti0w06+YZyV4AwuVm/GRaxG4W1gb0EK+0PuthNA8Gl1PaLdq2UryQ/
         mCcw==
X-Gm-Message-State: AOAM531d9oREhJE0hnYR8w9KNoBFiNyBCuUcdiLSZyErfjksJvju0k4R
        B0zrDrbN18vhW5zf6Y6YULo=
X-Google-Smtp-Source: ABdhPJzQh10L6Nw6bzQ+bW4SV/yydOU0a0bTrlgXmmGQbGj5xwgMbTUwDqKzhDgn5JL89gNYgRwY2Q==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr12652140wrr.408.1622982682947;
        Sun, 06 Jun 2021 05:31:22 -0700 (PDT)
Received: from snuff.lan (178-164-181-11.pool.digikabel.hu. [178.164.181.11])
        by smtp.gmail.com with ESMTPSA id p5sm12922023wrd.25.2021.06.06.05.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:31:22 -0700 (PDT)
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/2] PCI: iproc: Support multi-MSI only on uniprocessor kernel
Date:   Sun,  6 Jun 2021 14:30:44 +0200
Message-Id: <20210606123044.31250-2-sbodomerle@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210606123044.31250-1-sbodomerle@gmail.com>
References: <20210606123044.31250-1-sbodomerle@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The interrupt affinity scheme used by this driver is incompatible with
multi-MSI as it implies moving the doorbell address to that of another MSI
group.  This isn't possible for multi-MSI, as all the MSIs must have the
same doorbell address. As such it is restricted to systems with a single
CPU.

Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
---
 drivers/pci/controller/pcie-iproc-msi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 557d93dcb3bc..81b4effeb130 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
 
 static struct msi_domain_info iproc_msi_domain_info = {
 	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+		MSI_FLAG_PCI_MSIX,
 	.chip = &iproc_msi_irq_chip,
 };
 
@@ -250,6 +250,9 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 	struct iproc_msi *msi = domain->host_data;
 	int hwirq, i;
 
+	if (msi->nr_cpus > 1 && nr_irqs > 1)
+		return -EINVAL;
+
 	mutex_lock(&msi->bitmap_lock);
 
 	/*
@@ -540,6 +543,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 	mutex_init(&msi->bitmap_lock);
 	msi->nr_cpus = num_possible_cpus();
 
+	if (msi->nr_cpus == 1)
+		iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
+
 	msi->nr_irqs = of_irq_count(node);
 	if (!msi->nr_irqs) {
 		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
-- 
2.31.0

