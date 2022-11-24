Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872D66381AE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKXXaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKXX3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:29:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E394EC04;
        Thu, 24 Nov 2022 15:27:57 -0800 (PST)
Message-ID: <20221124232326.846169830@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dO4Zi35OCCA7gHzDk5+sx7+ILHZnBqLXkJXZcofiSSc=;
        b=vJ1ivInEGxFXD/cLi/XsGMd7gWG3RnRzT+bSNGmuipyBQatFEozxsYSg5LRSwEK/Eq2OGc
        OcPZYezbgEk1I2kXpuhyaEuj0tB7dluO75I6L1kZj6tUTve7qwKfhpEeKFOT+s8jrEFKJ6
        QgJbaoCRSf0CKbYhEwISJNcGkuS8tucvIV6BPn16Z0Xj8/uFke4AZmOdBBeBUvcTUKencz
        SMhwViegYUJhy6BdiD1OzlcV7Z/OStEKHq+JW/nnJS1Skp45uU0TPFRZVOLBpZWC4bKpVa
        99SQHyP2TDlfCyrY6ySUAiPLwhJZdBnCzeO2GnIPzYluWwmdxWAo8nNJWL94og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dO4Zi35OCCA7gHzDk5+sx7+ILHZnBqLXkJXZcofiSSc=;
        b=bodUHha1Sn8a5HfJeWq5ctT/b+kcYXaQkmaIOJsbXjkGurYIaUgFYmHM5Y9v+EeKW61q2K
        teWGRf0CdndccABw==
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
Subject: [patch V3 27/33] genirq/msi: Provide constants for PCI/IMS support
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:28 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide the necessary constants for PCI/IMS support:

  - A new bus token for MSI irqdomain identification
  - A MSI feature flag for the MSI irqdomains to signal support
  - A secondary domain id

The latter expands the device internal domain pointer storage array from 1
to 2 entries. That extra pointer is mostly unused today, but the
alternative solutions would not be free either and would introduce more
complexity all over the place. Trade the 8bytes for simplicity.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain_defs.h |    1 +
 include/linux/msi.h            |    2 ++
 include/linux/msi_api.h        |    1 +
 3 files changed, 4 insertions(+)

--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -25,6 +25,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
 	DOMAIN_BUS_DMAR,
 	DOMAIN_BUS_AMDVI,
+	DOMAIN_BUS_PCI_DEVICE_IMS,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -559,6 +559,8 @@ enum {
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 19),
 	/* PCI/MSI-X vectors can be dynamically allocated/freed post MSI-X enable */
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
+	/* Support for PCI/IMS */
+	MSI_FLAG_PCI_IMS		= (1 << 21),
 };
 
 /**
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -15,6 +15,7 @@ struct device;
  */
 enum msi_domain_ids {
 	MSI_DEFAULT_DOMAIN,
+	MSI_SECONDARY_DOMAIN,
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 

