Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25037625C86
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiKKOIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiKKOHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F677237;
        Fri, 11 Nov 2022 05:59:54 -0800 (PST)
Message-ID: <20221111135206.632756918@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JjWom/9kwklaxMWDn9npHnU2VscMDs0fiXQjZmDEcT0=;
        b=ahkaO7sqkimzmk6FJeJUgu/hLpTvx0v/QYQSZDVSusTaHvT0AS0egLjhY0gDh9d3l7aC5d
        JOCmTrDecGH6fwBAzw81LaIpP0SIg7GG8lJDwKV+qyF7Sq8ywytE/fn26YUPKNgjIwzeaM
        8zoBtB6JFML0TVmSjs8+oBmDJc+QXr8idQ6jUzLfVO98s9998QWH9LCb68ozS3+8KJefaZ
        ZgZ9pWA+j+qSJZPCpS3plvrNZFxh6t8USlKyvenpxR6i8WaxZ9lL8CG4mQvgbbrr4Qs4Jj
        pG0pgHTaDcJYDRXxMEWwsavIilJDioMvqc5HhYkc2sORGFDaLpF4ad63CTuMXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JjWom/9kwklaxMWDn9npHnU2VscMDs0fiXQjZmDEcT0=;
        b=+b/g6JiogzgLkTDTxXLbWJyXPVwUYqVIHPR/EvFzo1OTXU0ubv9AkPFRSAfcBNkcO3NUnG
        yiwORE0zYF02WvAQ==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 24/33] PCI/MSI: Provide prepare_desc() MSI domain op
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:49 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dynamic MSI-X vector allocation post MSI-X allows to allocate vectors at a
given index or at any free index in the available table range. The latter
requires that the core code selects the index at descriptor allocation time.

This requires that the PCI/MSI-X specific setup of the MSI-X descriptor,
which is partially depending on the chosen index happens after allocation.

Implement the prepare_desc() op in the PCI/MSI-X specific msi_domain_ops
which is invoked before the core interrupt descriptor and the associated
Linux interrupt number is allocated. That callback is also provided for the
upcoming PCI/IMS implementations so the implementation specific interrupt
domain can do their domain specific initialization of the MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -202,6 +202,14 @@ static void pci_unmask_msix(struct irq_d
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
+static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+				  struct msi_desc *desc)
+{
+	/* Don't fiddle with preallocated MSI descriptors */
+	if (!desc->pci.mask_base)
+		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
+}
+
 static struct msi_domain_template pci_msix_template = {
 	.chip = {
 		.name			= "PCI-MSIX",
@@ -212,6 +220,7 @@ static struct msi_domain_template pci_ms
 	},
 
 	.ops = {
+		.prepare_desc		= pci_msix_prepare_desc,
 		.set_desc		= pci_device_domain_set_desc,
 	},
 

