Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492196326B2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKUOsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiKUOre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:47:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B3D2987;
        Mon, 21 Nov 2022 06:41:40 -0800 (PST)
Message-ID: <20221121140048.785620505@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lryKCdg7QeE0MhY5O2OfgLlItEx02Ny9/G/YzdpvlKM=;
        b=EvfA4ChliMdUWDqFwD48kq3Hg0yw0bqkMrO1I5BIckFvTPdega+p+b5VYOwVlM76jwFHLW
        adCBGVY5fe7qKOI6TX/hnojOb8TxywOTUDg2KFJhXFkRtxZTII+5r4mx5Ciip9wBI81VVG
        zy9EX16+9f55IyVJUjCOfcB+aK6H+7Nw/cM89SZ5K8p9r+kgk4PRC6HwFWq22aScexZWKh
        6xT3b8avmlv/OraRbE5S/3bFXs1w8qx2z7bK03svjMgz7699ieamCuRwOo0lPHIiRWhhag
        qejNDCdn9UdihbEkhouzH5Vhtc7XjquHuIV2zbaaFqSBCxsaLHtSrog9RJZqGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lryKCdg7QeE0MhY5O2OfgLlItEx02Ny9/G/YzdpvlKM=;
        b=eKAUQqZWCQ4VtNX8iVvvP7N4sbQ/Pq5wipjeK7yYD6tszP4D450UAP/9XSiZgzOVuUq9mE
        GiklmwXIgED4jwAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 08/40] genirq/irqdomain: Remove the param count restriction
 from select()
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:38 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the GIC-v3 callback can handle invocation with a fwspec parameter
count of 0 lift the restriction in the core code and invoke select()
unconditionally when the domain provides it.

Preparatory change for per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -417,7 +417,7 @@ struct irq_domain *irq_find_matching_fws
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->select && fwspec->param_count)
+		if (h->ops->select)
 			rc = h->ops->select(h, fwspec, bus_token);
 		else if (h->ops->match)
 			rc = h->ops->match(h, to_of_node(fwnode), bus_token);

