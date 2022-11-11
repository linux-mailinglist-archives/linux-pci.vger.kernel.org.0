Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82474625C3F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiKKOC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiKKOBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:01:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83228845C7;
        Fri, 11 Nov 2022 05:57:10 -0800 (PST)
Message-ID: <20221111132707.005001510@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7CXvgfTszY3LslvHbPboJUjb59ZlVQ1XORNlFYSydbs=;
        b=Agv68rl7CQm4sjgpbWZA2zBJxntMTk8mKSY602PayvrRRyQNfmK6JasYanB3VY9nVbQfDj
        VlX/FV//rKxxyJc2J6IZvMB/vWG26i5zPuLzap/UX0+J0tw9DaIteiN4sIleRn3ZenaAv3
        9ai3s76aknsKpTN3l0Hgi3wSrImjy/D9K4IYYCA3R/qrsSEqz5QK3spbIVbb/L7SCNwK3t
        G+2MeXJnHh8eljbgb3LsHeb6rEBPGzLfJyLba+yd7Ba7Dk8SEqB6GRhfcJ6mfA3k2XD2XM
        TPs1i81pOJMIUjQjHlAiFOAzw0ooqh/fpEfnDymEhJVgRgfjeEMxg2j/N43gEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7CXvgfTszY3LslvHbPboJUjb59ZlVQ1XORNlFYSydbs=;
        b=LgqWWQEySgEZ5F9eCmSn1EOhVpouemmYgUmw/9/nAKuTrgu8/zuhKwoz5e6f1YFwbyYVyh
        G2q5r5gIL3SLohBw==
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
Subject: [patch 17/20] platform-msi: Switch to the domain id aware MSI interfaces
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:57:04 +0100 (CET)
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

