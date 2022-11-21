Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CFA6326A3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiKUOqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiKUOqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:46:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2269D2347;
        Mon, 21 Nov 2022 06:40:44 -0800 (PST)
Message-ID: <20221121140048.659849460@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s+g/QPbklxPzM4FZ4SYWZR5FPe67LrDVUw7p5TgGo7M=;
        b=ztMtjC8CMfgn0ofL21t85GjPjHPmJj0DI3J8Wj1MfBlR/rPA9bWrNAj8tRTWNu+JZ4F+Rz
        Y6kYfSLLdpSwYVpuJp1Pnvt4t1kSSGDOheLoI98NvBg9myVGmqCGdHBLyq/fMYdeyfOfTM
        kEy3hloOeLgpVrxfdIRbR6F4oveg0ZdHqBfXPT5u96Bbr4eWrtGqJSP2tDKYN1oGAs+6TK
        3DGkJ4NCruCBMMprw16iBMfMjAZCKI4HSW400IL3L/FKElF72mUKNWSm+eI/FTQsT24ZmF
        AyQiTWfrn4XFXV+0+RUbb6HJ6PAgCYbHDfwif+JU6rYW7oaG7gT4cpvJ/xThAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s+g/QPbklxPzM4FZ4SYWZR5FPe67LrDVUw7p5TgGo7M=;
        b=B/8rXcQr4Eb6KRVesJ4zp0ATD6W2MViFL5MUAP3df6qU9aw5XXOTz46aiq58JCAE1M2DQ1
        I72PpkA6DPvOwmAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 06/40] PCI/MSI: Provide static key for parent mask/unmask
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:36 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most ARM(64) PCI/MSI domains mask and unmask in the parent domain after or
before the PCI mask/unmask operation takes place. So there are more than a
dozen of the same wrapper implementation all over the place.

Don't make the same mistake with the new per device PCI/MSI domains and
provide a static key which lets the domain implementation enable this
sequence in the PCI/MSI code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c |   30 ++++++++++++++++++++++++++++++
 include/linux/msi.h         |    2 ++
 2 files changed, 32 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,17 +148,45 @@ static void pci_device_domain_set_desc(m
 	arg->hwirq = desc->msi_index;
 }
 
+static DEFINE_STATIC_KEY_FALSE(pci_msi_mask_unmask_parent);
+
+/**
+ * pci_device_msi_mask_unmask_parent_enable - Enable propagation of mask/unmask
+ *					      to the parent interrupt chip
+ *
+ * For MSI parent interrupt domains which want to mask at the parent interrupt
+ * chip too.
+ */
+void pci_device_msi_mask_unmask_parent_enable(void)
+{
+	static_branch_enable(&pci_msi_mask_unmask_parent);
+}
+
+static __always_inline void cond_mask_parent(struct irq_data *data)
+{
+	if (static_branch_unlikely(&pci_msi_mask_unmask_parent))
+		irq_chip_mask_parent(data);
+}
+
+static __always_inline void cond_unmask_parent(struct irq_data *data)
+{
+	if (static_branch_unlikely(&pci_msi_mask_unmask_parent))
+		irq_chip_unmask_parent(data);
+}
+
 static void pci_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_mask_parent(data);
 }
 
 static void pci_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
 
@@ -195,10 +223,12 @@ static struct msi_domain_template pci_ms
 static void pci_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_mask_parent(data);
 }
 
 static void pci_unmask_msix(struct irq_data *data)
 {
+	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -653,12 +653,14 @@ struct irq_domain *pci_msi_create_irq_do
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+void pci_device_msi_mask_unmask_parent_enable(void);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	return NULL;
 }
 static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg) { }
+static inline void pci_device_msi_mask_unmask_parent_enable(void) { }
 #endif /* !CONFIG_PCI_MSI */
 
 #endif /* LINUX_MSI_H */

