Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0761E63263F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiKUOis (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKUOhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:37:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8F776E2;
        Mon, 21 Nov 2022 06:37:55 -0800 (PST)
Message-ID: <20221121091326.824201400@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xdXQN8DRlFx/ul31qn4JSIb+1+AWkLgJWGGnxBYyOqY=;
        b=RBGAMv2GkppARAoYghD/kjTwWaU4eeqxK2Ubd1SizNBhAVm2TXOrkaFFnaNXfr1KZeNxD+
        52VAh+N+AZDFLoazaVlHlG6JbwZ5YtCZ8aNwdxKgTNpHuOB/UtHaNGFqMOZeFICUjYv2KP
        vNEb+B0KlQwGsX51jstKGCTVczJ+jV6kqzAH0QxPWObSQZEfHQh5RJRmDFrR3hY2oTntED
        ymtALNUY8UxS9YYtigjuKBhO7h/tz+S0PMogZ+O32cuojrRsiZ/rsSh/HIzvvtOtkpV4SL
        0VSpgdE2WbQQ0FZGyHfDKDY2FGvCF9zZ1JDembFs3lwzluzpBAUwq0JWBHEUJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=xdXQN8DRlFx/ul31qn4JSIb+1+AWkLgJWGGnxBYyOqY=;
        b=wER6yTa5fecL2bNV9tiYHP4MwsBQhfok1JJm+pRrG71fCNhiW4druzH9vfv4qO9rONscXQ
        4wXzqJeZrLjAceBw==
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
Subject: [patch V2 06/33] genirq/irqdomain: Add irq_domain::dev for per device
 MSI domains
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:37:53 +0100 (CET)
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

