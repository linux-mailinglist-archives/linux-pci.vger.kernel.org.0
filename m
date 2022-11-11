Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F68625C9F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiKKOJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiKKOIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:08:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D99B57C;
        Fri, 11 Nov 2022 06:00:28 -0800 (PST)
Message-ID: <20221111135207.085366489@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vuCfp3+0SFn3kyyf+6t5pZzLC+oocOyU3+0CroYzbSc=;
        b=EYt8PyTcQH+0MR0fODXHcb9JxXkjqE+wWj55+6Buo8kyYPFBpuyYGpWoP/c0AchwDGaC8j
        o91RKwkReUyNkRx3W3F5PBDkfzojM6ZCOPRm4jGASScw4wdKklqInJv0XApQvELQpbCRh0
        lOWkkPFpzyIXuZXZM/OKsbqK5heGYU3VnaVp1B4gVfFFj9clEsSo4EktQY2Ie/J7a0Ktqv
        9nJcrHODFi/Q259MrdTDCEEf1xCF2ceLuO2JOMac0SCf/dVGoEWX/bHcGi7kzTb+w9YaJ+
        ShVEYIH2ko1CCWHDHs534bMonKRyLQAy8R7syQl1gXUC8DkSzDlS6fommPb9/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vuCfp3+0SFn3kyyf+6t5pZzLC+oocOyU3+0CroYzbSc=;
        b=B5oBtBjhJP+iFlPL0l7RB/iDoWeRkbXaXOdEK20wwXfv2p22rBVYcPtCWmiBOvXBznw/P9
        Yp4L3vJ6MB/ucuBA==
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
Subject: [patch 32/33] iommu/amd: Enable PCI/IMS
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:59:02 +0100 (CET)
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
 drivers/iommu/amd/iommu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3649,7 +3649,9 @@ static struct irq_chip amd_ir_chip = {
 };
 
 static const struct msi_parent_ops amdvi_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };

