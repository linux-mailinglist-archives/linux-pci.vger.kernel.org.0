Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2E86326B9
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiKUOsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiKUOqc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:46:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F368D236B;
        Mon, 21 Nov 2022 06:40:56 -0800 (PST)
Message-ID: <20221121140048.722992910@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0uPKQvIE6eHWFWTzh0P31YZRE+J5P6MvaWi2wIg9qig=;
        b=2xxh3n8fCQKY1tupSQrL9RMghm2CJAVDhvY/Tjdbm5UyTrZ3617loyNvTvtgNhd1HURZCG
        Ex96BmehgLludH3jYNj5aEgGOs3VtfcvigHKrZKPcj+QOILkhwD1zWcorhR2EQI6SmQQ5n
        KukieQVmKgYlUtVMunHXe/xRbloR1Epl9yYeoaU26IAVI2n/oqnJCsqZfEUyIs0/ujwyPo
        pZrNPN0L6CDAvMrk6b/buOWEbQOjlyfd5MmgRoRi1qpQ16QV8lOeNG/friBcWTlSuxbbJC
        Hopj84F9VxpGLUoQSU3abw9iD9Rfjr2mF19toJL/p/AnaCzwIr5dX5AihkVlXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0uPKQvIE6eHWFWTzh0P31YZRE+J5P6MvaWi2wIg9qig=;
        b=PCeo9bxFppNV9qQQ6klCeD7Y79K1FfbS6EFwmhDWSSkQCY8I3v39UhssGnoodq7GVDpqqE
        ZkeJvgcIGuShZNDQ==
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
Subject: [patch V2 07/40] irqchip/gic-v3: Make gic_irq_domain_select() robust
 for zero parameter count
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:37 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the irqdomain select callback is only invoked when the parameter
count of the fwspec arguments is not zero. That makes sense because then
the match is on the firmware node and eventually on the bus_token, which is
already handled in the core code.

The upcoming support for per device MSI domains requires to do real bus
token specific checks in the MSI parent domains with a zero parameter
count.

Make the gic-v3 select() callback handle that case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1613,9 +1613,13 @@ static int gic_irq_domain_select(struct
 	irq_hw_number_t hwirq;
 
 	/* Not for us */
-        if (fwspec->fwnode != d->fwnode)
+	if (fwspec->fwnode != d->fwnode)
 		return 0;
 
+	/* Handle pure domain searches */
+	if (!fwspec->param_count)
+		return d->bus_token == bus_token;
+
 	/* If this is not DT, then we have a single domain */
 	if (!is_of_node(fwspec->fwnode))
 		return 1;

