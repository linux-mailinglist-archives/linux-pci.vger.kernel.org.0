Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2F638175
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKXX0B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKXXZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:25:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41CAB0CB;
        Thu, 24 Nov 2022 15:24:51 -0800 (PST)
Message-ID: <20221124230314.455168748@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LT/xfniXCBDF3W+A4foNyGvk9ZyzT/mpsXze/X+JW0Q=;
        b=qcOhB+B721EZTDMg7sUemBtDSq5G0ITFsKHACA2gN0eag+8RbO7qHyC/gj8+IRIT6TeWDT
        3xHYVYzFggERk9O9xshbu/FmVmhses6PrEP/BG1WRtY+7ARuUo61AQPMnSV9luzY1f2jcB
        /aCyUokCRDzCTrx6HYOLwldN7u3dK2D+RqgE2fN2zEpWBtHzs49eUqDRCTn4NRfmQssXoC
        6ktjncqcc6aRpuEBjv74pGEIGQLquw/ZOVUNhEFJp7BfQ4Mq7n9v6bLvzo9P/GVEZHc7cq
        Hu5NwMIBEhqF/hvbzpCuTctGHe+gxH+NHsPRRzfBS8azd5BMj11fXZbx/1bP1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LT/xfniXCBDF3W+A4foNyGvk9ZyzT/mpsXze/X+JW0Q=;
        b=9lRbnldfUMF5p9cb7nNI6GsFFsVTaBJm97LFYJQ0ABmA24Ogto1JixNzlycS1tvjrpmHsB
        o9CqOp9ZBEdoE1AQ==
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
Subject: [patch V3 18/22] PCI/MSI: Use msi_domain_alloc/free_irqs_all_locked()
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:36 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch to the new domain id aware interfaces to phase out the previous
ones. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -14,7 +14,7 @@ int pci_msi_setup_msi_irqs(struct pci_de
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
+		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nvec);
 
 	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
 }
@@ -25,7 +25,7 @@ void pci_msi_teardown_msi_irqs(struct pc
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain)) {
-		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
+		msi_domain_free_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN);
 	} else {
 		pci_msi_legacy_teardown_msi_irqs(dev);
 		msi_free_msi_descs(&dev->dev);

