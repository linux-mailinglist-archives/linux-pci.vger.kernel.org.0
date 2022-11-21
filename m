Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4C632697
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKUOpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiKUOoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:44:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B109CFEB1;
        Mon, 21 Nov 2022 06:39:52 -0800 (PST)
Message-ID: <20221121140048.344525618@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VMdi78Ph2ZKt//IeQ4f995Y7xixQx0PVMNetg0nGRuE=;
        b=s1lueuqmL8rn1uMzqRQQRUHs8j8k/PkQkr2FJayzUfJfBRzHMwnhKu/4YzxQRoJorfRzoU
        8rw39T93j+gaLV9OPwyttucgaKM38hHBhQJgqU3caAg8N5/683w2esfJcfBgzRKouh0wqq
        a+G20BwLFXT7fvCEYMziNoTp/uL+/VDnwrWStO4yh0G5zMRoGqKi/+pHIPtHx/RanKrwjP
        8NkqmtSrNGxN2RYeso48vaUquk7W2L35QPy68rsQ3zB9H/0cN4oGgvyinCf0YQyKt7EZ3U
        OcHFgGyNHeUEHAwZJJsyciQhX8cXeoblH6XN/iaO6a5x4BW6mnqLQKydoyl2Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VMdi78Ph2ZKt//IeQ4f995Y7xixQx0PVMNetg0nGRuE=;
        b=MBeTqTJkLdnku5CLyv6f0wHkET+DFJKaoKtmUAmidr2fZ2eYNfvQPhyph1fu65IpXbLV59
        jqtVa9JpyObax5AA==
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
Subject: [patch V2 01/40] irqchip/irq-mvebu-icu: Fix works by chance pointer
 assignment
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:29 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Assigning a void pointer which points to a struct to two different data
types only works by chance if the second type is the first member of the
struct.

Replace this works by chance code by using the primary struct pointer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/irqchip/irq-mvebu-icu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -151,9 +151,9 @@ static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
-	struct mvebu_icu *icu = platform_msi_get_host_data(d);
 	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
+	struct mvebu_icu *icu = msi_data->icu;
 
 	/* Check the count of the parameters in dt */
 	if (WARN_ON(fwspec->param_count != param_count)) {

