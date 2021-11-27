Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B945F91E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbhK0B0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbhK0BYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:24:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14311C0613F8;
        Fri, 26 Nov 2021 17:19:32 -0800 (PST)
Message-ID: <20211126223824.441771859@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EjQK06gGut8wpWxb3xXf7TaaLrkIbQLhpXZXlXqI+1E=;
        b=3IN7G2Z+0trEJeykGv7kUnMltcrJgw6/YiiYZT8QXhspQzKvcIJW3i6gR+n0r+g0hsjZAO
        6Y9KrK5zYseTHHVb7+c8IptjiFQeVXBeJDPflWUfULp3GtFjmbp9XFuGtmX1U+/q2euX+7
        jbyTLqyRLHFcvAPwlksKJBmoQq5tScd89MT6QeCRCoLuq+1hECPKCcrJEwZqd6tTMvJfgo
        omFGhCP0pUYeNAhfPERNfI16sLmeF3+3CoWsyDCxxVlEIkwnejxyxNkkc5/OsucKZ6M2Wz
        9b3BXGVs3dTsq0Elas1wdnxn4Qa5k8MRI/8VEocHf7LWeYN/GB276k0tmU8dkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EjQK06gGut8wpWxb3xXf7TaaLrkIbQLhpXZXlXqI+1E=;
        b=tNxaZsUisx8qmcOuXzPTbk9OTikfV8u0CcSvhiEBov4PNCxknl15jCdw3kB2y8lH62s1JS
        bmCvi3+Z0sDU1eBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch 06/22] PCI/MSI: Make pci_msi_domain_write_msg() static
References: <20211126222700.862407977@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:19:30 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no point to have this function public as it is set by the PCI core
anyway when a PCI/MSI irqdomain is created.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v2m.c            |    1 -
 drivers/irqchip/irq-gic-v3-its-pci-msi.c |    1 -
 drivers/irqchip/irq-gic-v3-mbi.c         |    1 -
 drivers/pci/msi.c                        |    2 +-
 include/linux/msi.h                      |    1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -88,7 +88,6 @@ static struct irq_chip gicv2m_msi_irq_ch
 	.irq_mask		= gicv2m_mask_msi_irq,
 	.irq_unmask		= gicv2m_unmask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
 static struct msi_domain_info gicv2m_msi_domain_info = {
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -28,7 +28,6 @@ static struct irq_chip its_msi_irq_chip
 	.irq_unmask		= its_unmask_msi_irq,
 	.irq_mask		= its_mask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
 static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -171,7 +171,6 @@ static struct irq_chip mbi_msi_irq_chip
 	.irq_unmask		= mbi_unmask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_compose_msi_msg	= mbi_compose_msi_msg,
-	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
 static struct msi_domain_info mbi_msi_domain_info = {
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1267,7 +1267,7 @@ EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdat
  * @irq_data:	Pointer to interrupt data of the MSI interrupt
  * @msg:	Pointer to the message
  */
-void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
+static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(irq_data);
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -454,7 +454,6 @@ void *platform_msi_get_host_data(struct
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);

