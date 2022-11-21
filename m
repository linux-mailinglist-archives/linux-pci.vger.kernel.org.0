Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8EC632613
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiKUOhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKUOgp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A86C6BFE;
        Mon, 21 Nov 2022 06:36:41 -0800 (PST)
Message-ID: <20221121083326.451412447@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g4QPlbf/kZK7IE6hnczsu6AmVOXaYfuEpjg2N6VHa1U=;
        b=JhNtr/myl7sTYsZkFaNXoZvsyFXwR7OsO5tGwrf0hUhsIoeB2vfgzbvdci+jZxbbxYU4Yn
        GrjMKBmOUYe4nZ8i1eFehzLYDcKYq8LzTeTZIwcnnquXm1pOgxbvJUhtbuQ2Fptk1+I4qF
        UGBT2sakYMRQVqr6f9jaunHUaCESHQ8o/LvCu3m5Yh9Nd7Jtv38FrUfIon3dVuZL3JWjKc
        wEX5aW6srGp9g4I0Q/svAouCR3HqFXrg3YS4Cld57SSDV0JCZ2BhbCdsfkAhVLE8TkIr2A
        qY0x+Kv8PHFpj2XcTfRXWTxJGE8/hXNlqVSS2U9vr6vi/1KSjJCoCHliy+oJWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g4QPlbf/kZK7IE6hnczsu6AmVOXaYfuEpjg2N6VHa1U=;
        b=R4JlIJg7yrPBj1VvEB0zM08yCyUsfvtNcRcEXwT0rxRbiBaMx9pM6gugtWAraRu71rFZH/
        zi5XsKplaUbLuGAg==
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
Subject: [patch V2 17/21] PCI/MSI: Use msi_domain_alloc/free_irqs_all_locked()
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:39 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch to the new domain id aware interfaces to phase out the previous
ones.

This uses the _all() variants of the MSI allocation/free interfaces
because due to potentially sparse indices of the preallocated MSI
descriptors describing the range precisely is not possible.

No functional change.

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

