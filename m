Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3397E625B9C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiKKNzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiKKNyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C167018C;
        Fri, 11 Nov 2022 05:54:28 -0800 (PST)
Message-ID: <20221111122014.063153448@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pIvr9Rr0WHVjkSJi7bxH/bI9Rim62Flb8AM+4v5YvL4=;
        b=whjvZ1hGnpGUhhkqm9I0JMcNO4qtQO27s2DQH8Oz9beyGWo7DUQsr+41f0+cZiGoF9CSwx
        vy50S9pzw9A2kbFhsoMOktYg78PizaWs9IR3KZshscuyc2m56wjLCpqJFSZBll2eH6V8nU
        MFd9D8/wAHhHSsTq9hOhTwRl6vK+7OlKxNjL0jjqxx5Jpk/xWBNusgl4nofXeNU4sGa2Jp
        4xxBlfu+GgVENgM2JLDzwXreETXKAUYT3oNe/e3Yp7Pby/icgOzh/0FpdMoIZobV0qz8X0
        +eNahDWVvyqLmTEvfdcUV0DxSloKi+SoF3/VjpwVitY04LcMpyXhGyF/Qz4d6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pIvr9Rr0WHVjkSJi7bxH/bI9Rim62Flb8AM+4v5YvL4=;
        b=wxPrtb03zedDnlK+TXh2gy6+0tXIlW3ThKc+ATDQcqkU5payjRpOO+xzL6leSmWxWqt9sy
        poWzdm2Y5IW7krDQ==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 08/39] genirq/msi: Provide msi_domain_ops::post_free()
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:27 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To prepare for removing the exposure of __msi_domain_free_irqs() provide a
post_free() callback in the MSI domain ops which can be used to solve
the problem of the only user of __msi_domain_free_irqs() in arch/powerpc.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |    4 ++++
 kernel/irq/msi.c    |    2 ++
 2 files changed, 6 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -315,6 +315,8 @@ struct msi_domain_info;
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
+ * @msi_post_free:	Optional function which is invoked after freeing
+ *			all interrupts.
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
@@ -359,6 +361,8 @@ struct msi_domain_ops {
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
 					    struct device *dev);
+	void		(*msi_post_free)(struct irq_domain *domain,
+					 struct device *dev);
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1026,6 +1026,8 @@ void msi_domain_free_irqs_descs_locked(s
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	ops->domain_free_irqs(domain, dev);
+	if (ops->msi_post_free)
+		ops->msi_post_free(domain, dev);
 	msi_domain_free_msi_descs(info, dev);
 }
 

