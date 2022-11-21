Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A552632681
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiKUOlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiKUOjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:39:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F270EC846A;
        Mon, 21 Nov 2022 06:38:26 -0800 (PST)
Message-ID: <20221121091328.184455059@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SuhbIxDBU+pgQkYaRbDZDx3XYR1ZMR159u+r/p3oNuI=;
        b=1psr2+6PEXY3YBQmmhtpss+e/EXa3fcuidPDiz2U/W/zlXsB2qLo8iCUiCbS/WujW3vE+h
        OXmLxsn8RCKMB14O6J4EekalasMdPu5542sb/8pz9abolCY9H2piNBDYa6c0a7lp+hRzoz
        fDbLxngNyek74VO0HsgdxY8ojuKCW0YldMTPdi+egcKZDdPxJDvehtF4066jgo1+3juDb8
        q2LDrF4ftSwgbcXMmFNKh1gZuUo4Qj8lh64UQF8VFe1V5J6cYYY91uAYV6zLY5eXU/8kZ3
        V8wBr9qz0yqwUrtTI6VQ7A7IbugtHPhbhK8pcaAFQlE31nxaTvGPchh741n2TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SuhbIxDBU+pgQkYaRbDZDx3XYR1ZMR159u+r/p3oNuI=;
        b=Rn8pzIZk+L7xOktcHzTRG9gckCOFAhYH4n4XxaFboCMQqeHg4TQPOweQ7JbeSWvSySHefJ
        N4ipPb0kY1QPg9Aw==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:24 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI/IMS works like PCI/MSI-X in the remapping. Just add the feature flag.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/iommu/intel/irq_remapping.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1429,7 +1429,9 @@ static const struct irq_domain_ops intel
 };
 
 static const struct msi_parent_ops dmar_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };

