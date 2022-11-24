Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF76638196
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKXX2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKXX2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:28:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7965A314C;
        Thu, 24 Nov 2022 15:26:52 -0800 (PST)
Message-ID: <20221124232326.093093200@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yBkAsYnt2I7B5+/On6wDlCIdm7qhkb9RizMNRpsl694=;
        b=HrvsEqLsToIp55l3cj4SBWy8qS2MjQlZnu+8IatPQjHQbT5uVUsqrUHw9nH6PpX/P/PkWz
        TnGpDhRs1+2PE4R3ZHDZ1dRucY0efo1AYOp1P7WF0EEvbuXHGnnh6Yu41N5zq1dqKiTFGp
        vFFxvKBl6IKDjA5e9loUG+K23k4c4D2zEDkm9cenDZiLLkyYxQwEpkbVld2RId3hYK2eTF
        b2xKPBf4BemHdE9mVtPyjoYZEraUmFmNltveXAtSkoHCEldWQrYyf+ts7Ghify5lufLdsm
        ux+UqPSxSlKE87V+xdu/TBe9bXdUlCVlgqrMLBhYIqlieOz6rGJUOW/LU+t6AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yBkAsYnt2I7B5+/On6wDlCIdm7qhkb9RizMNRpsl694=;
        b=llw9Gy4LLy7Jis6eY6x6b5HwgSNES0ZONTNs/hP8H+ArWsmIZZ/Q3JtM3eohnehUT/kcMN
        idqiyWXU1AMeo9Dw==
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
Subject: [patch V3 14/33] PCI/MSI: Remove unused pci_dev_has_special_msi_domain()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The check for special MSI domains like VMD which prevents the interrupt
remapping code to overwrite device::msi::domain is not longer required and
has been replaced by an x86 specific version which is aware of MSI parent
domains.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c |   21 ---------------------
 include/linux/msi.h         |    1 -
 2 files changed, 22 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -414,24 +414,3 @@ struct irq_domain *pci_msi_get_device_do
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
-
-/**
- * pci_dev_has_special_msi_domain - Check whether the device is handled by
- *				    a non-standard PCI-MSI domain
- * @pdev:	The PCI device to check.
- *
- * Returns: True if the device irqdomain or the bus irqdomain is
- * non-standard PCI/MSI.
- */
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
-{
-	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
-
-	if (!dom)
-		dom = dev_get_msi_domain(&pdev->bus->dev);
-
-	if (!dom)
-		return true;
-
-	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
-}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -609,7 +609,6 @@ struct irq_domain *pci_msi_create_irq_do
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {

