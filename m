Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B2638177
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKXX0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKXXZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:25:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8035687A7A;
        Thu, 24 Nov 2022 15:24:53 -0800 (PST)
Message-ID: <20221124230314.513924920@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7CXvgfTszY3LslvHbPboJUjb59ZlVQ1XORNlFYSydbs=;
        b=N8JY1BopCBWBKj7Vr8Dj29yJcik0JUGEEXlWibsw7QBp62HFKSvFAkLbxb3ubw1iSIlzKO
        Isc7U5NZaVolNkdr7V9qwH3GPmWfD0Zz/gAT7hMlH+qYgpWP6YTvOzTpynFQgTbjukK9KA
        3ET1XLezTGft+Bi5HSlcPJWpkM28UydEQCsUPGIVWw+/mQ/0x7Zwd0UsAhhTE/HrDZr8u9
        +mM2dBa+G7RzJKi/e0Ob6lLx5Liq6MYSr+hkF8bIZtvvklWxxfLxx30JlUu/swpbNHj+4m
        mGk33UMatSi8vSMH9Il1gJhFdOB2QYQlTfX0ut9ZQP/MRohP02/bz++/JPy2Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7CXvgfTszY3LslvHbPboJUjb59ZlVQ1XORNlFYSydbs=;
        b=eDPpZT95WzAUA5Bh/gAALDkn7f3DggzbAacEbgr1Nxd/CTSI4c0VOO20MUN+caGx803/EP
        YTigjd6OVcqZIJBA==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [patch V3 19/22] platform-msi: Switch to the domain id aware MSI interfaces
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:38 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

Switch to the new domain id aware interfaces to phase out the previous
ones. No functional change.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -213,7 +213,7 @@ int platform_msi_domain_alloc_irqs(struc
 	if (err)
 		return err;
 
-	err = msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
+	err = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
 	if (err)
 		platform_msi_free_priv_data(dev);
 
@@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(platform_msi_domain_al
  */
 void platform_msi_domain_free_irqs(struct device *dev)
 {
-	msi_domain_free_irqs(dev->msi.domain, dev);
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
 	platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);

