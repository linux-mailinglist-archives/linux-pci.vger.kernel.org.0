Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A837625C5D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiKKOFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiKKOFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:05:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783938B47C;
        Fri, 11 Nov 2022 05:59:17 -0800 (PST)
Message-ID: <20221111135205.601563808@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xdXQN8DRlFx/ul31qn4JSIb+1+AWkLgJWGGnxBYyOqY=;
        b=WtVC2QIqbLK6P3xlT6wSY/JDFKu3lLwNilN3JNp6QWP3khbi+wL1jnS3qudRT0exHV45Th
        AiZuYZQFD2qoXVI6pwnM45xMVYxj8JDFuqsQ0IEdsrmjyBBzNzP+Ws5gnSXnwJKGJEXSAu
        1t2hYbGBDr9Srww34ao6RhbukK+QDbiG4urD4dmz88hvUuukH7c8H6uaMEmsyis1izFGtO
        p0+uQPdOV22UvUt12EuUwkzqJmmi4FC0uNLhkb2i2bHg9IbGA7eDJ6u5wtqZf3DmPTvm9B
        3RBDoSYtugSy3lM7gLKl2tK1AeDBhOQu1hhuBVzVLJjQzuEnUo/WcapNeprYLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xdXQN8DRlFx/ul31qn4JSIb+1+AWkLgJWGGnxBYyOqY=;
        b=UYTcQJebJYMtepSbazMw2A4Q5zsWOluoAV6RD556tCbHR6nMrpe/rZqwIzBPiMJmYyliDG
        f4QET080a9aGrwAA==
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
Subject: [patch 06/33] genirq/irqdomain: Add irq_domain::dev for per device
 MSI domains
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:20 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per device domains require the device pointer of the device which
instantiated the domain for some purposes. Add the pointer to struct
irq_domain. It will be used in the next step which provides the
infrastructure to create per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -132,6 +132,9 @@ struct irq_domain_chip_generic;
  * @gc:		Pointer to a list of generic chips. There is a helper function for
  *		setting up one or more generic chips for interrupt controllers
  *		drivers using the generic chip library which uses this pointer.
+ * @dev:	Pointer to the device which instantiated the irqdomain
+ *		With per device irq domains this is not necessarily the same
+ *		as @pm_dev.
  * @pm_dev:	Pointer to a device that can be utilized for power management
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
@@ -155,6 +158,7 @@ struct irq_domain {
 	struct fwnode_handle		*fwnode;
 	enum irq_domain_bus_token	bus_token;
 	struct irq_domain_chip_generic	*gc;
+	struct device			*dev;
 	struct device			*pm_dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain		*parent;

