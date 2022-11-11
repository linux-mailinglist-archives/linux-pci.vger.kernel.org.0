Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A155625C26
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiKKOBL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiKKOAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC2F8D7ED;
        Fri, 11 Nov 2022 05:56:48 -0800 (PST)
Message-ID: <20221111132706.388892782@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+dAWZkN6cGNqJWgbyj9Oq+MbyBZuRhS/MrnxspMqy9E=;
        b=v1PtI44g/Am1qxyq/3b/TdkupIjQY/gl40s7ApESbrvv3cabUzkAHZp05hF9W8FAV9F5hi
        TV6cYF44shMIAfq2CjPKvZ9+Pjwp0Io/AXIalqCz+iXrqAbTNpzskxa2Q9O69cy3dSn+oe
        NWWwWqHUeSKNwojTyq8r0/fGYUtWJfNIjmIzMZ5lw+N4IA/iqTZ9h5RbMVpDc9D7wgjQV2
        mf43Xq8KvSl3iC+x89XCKH9pf5GoxjLEQ7KXwM0xoOEtTCyCIQNUG1Wp4Ctc4/5Z6KMCcx
        zQuLN3Mi72N5o/tU7l0Nh1H4ED+cNSw3WAnyexd6nDQDj+1hPM3rc13e12+2Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+dAWZkN6cGNqJWgbyj9Oq+MbyBZuRhS/MrnxspMqy9E=;
        b=Y/gXDXsYJF6Sa5UVN981gmV3cjImDqIc0W/tEeW5iVObyX3LNvGJBgS91vBPGFLMIwAEXH
        5JI1s/z7pzJ2nfDw==
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
Subject: [patch 06/20] genirq/msi: Check for invalid MSI parent domain usage
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:46 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the upcoming per device MSI domain concept the MSI parent domains are
not allowed to be used as regular MSI domains where the MSI allocation/free
operations are applicable.

Add appropriate checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -937,13 +937,21 @@ int msi_domain_alloc_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain))) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	/* Frees allocated descriptors in case of failure. */
 	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
 	if (ret)
 		return ret;
 
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
-	if (ret)
-		msi_domain_free_irqs_descs_locked(domain, dev);
+	if (!ret)
+		return 0;
+free:
+	msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
 
@@ -1013,6 +1021,9 @@ void msi_domain_free_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
+		return;
+
 	ops->domain_free_irqs(domain, dev);
 	if (ops->msi_post_free)
 		ops->msi_post_free(domain, dev);

