Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57D625C7F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiKKOH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiKKOHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39D99327;
        Fri, 11 Nov 2022 06:00:13 -0800 (PST)
Message-ID: <20221111135206.800062166@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7fmcFX1MJSQKPJVgurNTrf9/R1xe0is9IBLZWgzTjmw=;
        b=ikIR/AeSqt/XXTdAQyxTKZcUYLrhRTDWT2sptBXUbsU0SzCRHX1C80+o2BLWhFBYhOm6el
        ksLpaWyI+ic4nSWkQ3bzdPCEff5m6KfGLAwxizrjtcv+/L8uWlvDHMIIG6PMqTo9l2qTYb
        gcbbDZlgmgDxl+7PQfDsJOba6pGWPgEQZlQcjbuirbVK5hNYk7fAONSznugmW67WEJQs7B
        PHSlHia0l9TezyW6KhbjBEY2QR/YYdYhIn3O2XEDmg7qmqr47dAS+c54zpw0vNWm3isz2l
        lM5ZjjAy1H1znHrZkDRJ7oosVpKANVVmE511Di/dv5AYsuc9cOhuduXTAV/6Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7fmcFX1MJSQKPJVgurNTrf9/R1xe0is9IBLZWgzTjmw=;
        b=L5+0eNKf2C8h0mEfMzHIbkytQe8CGoXz6dnzRcdcGTEYL+V0gr2N8zFZZ5ghERyB1s8prE
        rdS4ZWKv9fvaR5BQ==
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
Subject: [patch 27/33] genirq/msi: Provide constants for PCI/IMS support
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:54 +0100 (CET)
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
@@ -525,6 +525,8 @@ enum {
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
 

