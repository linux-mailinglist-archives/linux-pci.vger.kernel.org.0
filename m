Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D36381A5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKXXaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKXX3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:29:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A23C6C1;
        Thu, 24 Nov 2022 15:27:50 -0800 (PST)
Message-ID: <20221124232326.673658806@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TlIkyzTTSvqR6KrJj1PQdSVRNaBSTUiGHoaI0+IdJ9c=;
        b=EUoFqgAXkfl7YAb9sfhRXkRzdebVXqr9nvfDRvKe0xNeMGXnXUS/RjfUs0CWKgl9C/35U8
        stR9uXLyUVh8zZ3Wy/97dZn806sEYliKITeL1qlE2qk/c0aIXqVfzbf8fWwuatrebatmjl
        g57NpwGqhmq5+zoTYAfss2YKXnzwmDlYKhDBZzZdfo0OfeH0yw5yH7zvZ49veYVFbbuWEw
        q79fPtz3BEOSMIk/ynGb6TvgJFGZuT5iwOFAGhQyWJS10fZgk/FgotgeYX43lBWURsCvTg
        EU+Q4+/pbThL08M/8oG/ayOQiWvA4jFUELPBpcQA8kLNUnWzAaI2dM9GVodocQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TlIkyzTTSvqR6KrJj1PQdSVRNaBSTUiGHoaI0+IdJ9c=;
        b=vzdLTkxSP4LCa9Pxc3Pi1rv/Qg8a4qEGdY3fbmBj9MchY2As9EtRCN5fVVcBkVhl79ny3X
        sguIA9J1MueylECg==
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [patch V3 24/33] PCI/MSI: Provide prepare_desc() MSI domain op
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:23 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The setup of MSI descriptors for PCI/MSI-X interrupts depends partially on
the MSI index for which the descriptor is initialized.

Dynamic MSI-X vector allocation post MSI-X enablement allows to allocate
vectors at a given index or at any free index in the available table
range. The latter requires that the descriptor is initialized after the
MSI core has chosen an index.

Implement the prepare_desc() op in the PCI/MSI-X specific msi_domain_ops
which is invoked before the core interrupt descriptor and the associated
Linux interrupt number is allocated.

That callback is also provided for the upcoming PCI/IMS implementations so
the implementation specific interrupt domain can do their domain specific
initialization of the MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
V2: Reworded changelog (Bjorn)
---
 drivers/pci/msi/irqdomain.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -202,6 +202,14 @@ static void pci_irq_unmask_msix(struct i
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
 

