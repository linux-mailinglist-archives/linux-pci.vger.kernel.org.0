Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087E8638190
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKXX2p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiKXX2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:28:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEAD39D7;
        Thu, 24 Nov 2022 15:26:49 -0800 (PST)
Message-ID: <20221124232325.857982142@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=osB1ROcuLYeqTjSSCjR+4n5EoRccoICYxGf0yGM+gI4=;
        b=ABaIW7MV8O3R2mRIwO7XbR954a66E6czAFyHzAy1nqq+3Go8dnsOQrvE9HTCyZ5TUSR8GJ
        SkEDDe1FnLWq8QYG9vIDYGLGuyfQjYB8sTAZXRHfwSwt9Atwg7i9WikjEgxECyGJRagXsG
        munrndXOg5nsbq3O9UZxoMRauswae1SnyuIo+djGBCG8R2ctFvcE0w3RW/kg3KLxid+oXd
        x1Zpe/t0GEwwuh6LN5BQtsIxtqVfE/Om6ubID8cuKr1U8UZ1bJD+oZClqJN/i1Yc3+O1MJ
        IrnynicLqy4ZxrS+JEU3JmVDJo4tpo76cTuxTUvg0DErzz508yCTDkpTysd0eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=osB1ROcuLYeqTjSSCjR+4n5EoRccoICYxGf0yGM+gI4=;
        b=9C5N+ZHv6PSbAktC6PZccDrlqHU363uVBq/cMK/CZrvzFFxFLzZOb1195PdSrGa0TK5YFB
        YAt7DEbWz78jWgCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [patch V3 10/33] PCI/MSI: Split __pci_write_msi_msg()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:00 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The upcoming per device MSI domains will create different domains for MSI
and MSI-X. Split the write message function into MSI and MSI-X helpers so
they can be used by those new domain functions seperately.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/msi.c |  104 +++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 50 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -180,6 +180,58 @@ void __pci_read_msi_msg(struct msi_desc
 	}
 }
 
+static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
+				     struct msi_msg *msg)
+{
+	int pos = dev->msi_cap;
+	u16 msgctl;
+
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
+	msgctl |= desc->pci.msi_attrib.multiple << 4;
+	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
+
+	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
+	if (desc->pci.msi_attrib.is_64) {
+		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,  msg->address_hi);
+		pci_write_config_word(dev, pos + PCI_MSI_DATA_64, msg->data);
+	} else {
+		pci_write_config_word(dev, pos + PCI_MSI_DATA_32, msg->data);
+	}
+	/* Ensure that the writes are visible in the device */
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+}
+
+static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg *msg)
+{
+	void __iomem *base = pci_msix_desc_addr(desc);
+	u32 ctrl = desc->pci.msix_ctrl;
+	bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+	if (desc->pci.msi_attrib.is_virtual)
+		return;
+	/*
+	 * The specification mandates that the entry is masked
+	 * when the message is modified:
+	 *
+	 * "If software changes the Address or Data value of an
+	 * entry while the entry is unmasked, the result is
+	 * undefined."
+	 */
+	if (unmasked)
+		pci_msix_write_vector_ctrl(desc, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
+	writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
+	writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
+	writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+
+	if (unmasked)
+		pci_msix_write_vector_ctrl(desc, ctrl);
+
+	/* Ensure that the writes are visible in the device */
+	readl(base + PCI_MSIX_ENTRY_DATA);
+}
+
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
@@ -187,63 +239,15 @@ void __pci_write_msi_msg(struct msi_desc
 	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->pci.msi_attrib.is_msix) {
-		void __iomem *base = pci_msix_desc_addr(entry);
-		u32 ctrl = entry->pci.msix_ctrl;
-		bool unmasked = !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
-		if (entry->pci.msi_attrib.is_virtual)
-			goto skip;
-
-		/*
-		 * The specification mandates that the entry is masked
-		 * when the message is modified:
-		 *
-		 * "If software changes the Address or Data value of an
-		 * entry while the entry is unmasked, the result is
-		 * undefined."
-		 */
-		if (unmasked)
-			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
-		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
-		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
-		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
-
-		if (unmasked)
-			pci_msix_write_vector_ctrl(entry, ctrl);
-
-		/* Ensure that the writes are visible in the device */
-		readl(base + PCI_MSIX_ENTRY_DATA);
+		pci_write_msg_msix(entry, msg);
 	} else {
-		int pos = dev->msi_cap;
-		u16 msgctl;
-
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
-		msgctl &= ~PCI_MSI_FLAGS_QSIZE;
-		msgctl |= entry->pci.msi_attrib.multiple << 4;
-		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
-
-		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO,
-				       msg->address_lo);
-		if (entry->pci.msi_attrib.is_64) {
-			pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI,
-					       msg->address_hi);
-			pci_write_config_word(dev, pos + PCI_MSI_DATA_64,
-					      msg->data);
-		} else {
-			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
-					      msg->data);
-		}
-		/* Ensure that the writes are visible in the device */
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+		pci_write_msg_msi(dev, entry, msg);
 	}
 
-skip:
 	entry->msg = *msg;
 
 	if (entry->write_msi_msg)
 		entry->write_msi_msg(entry, entry->write_msi_msg_data);
-
 }
 
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)

