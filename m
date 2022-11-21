Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A86326A4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiKUOqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiKUOqU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:46:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA5D2340;
        Mon, 21 Nov 2022 06:40:43 -0800 (PST)
Message-ID: <20221121140048.596303869@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XmeDaeqxxBY7nsoBMruO4Bn75n1RoKWKMjjDX37M0fs=;
        b=hAIlLxN1X/mz0jH28WYUdgrw5KmYM/Qygy+XwnwCbhplCeGyQry35K+26iEuC5UIofwwT9
        Ic/O32gLRHOJWxrGK5e1jHnuc4I29dv0EY2v7mpO57tn9yHo5YYM41rhOdIOUDmeQu0w2H
        hWI80mzh+K1w8NG7x+uY/Bh4OEffPOKhP8H6MTs1/zjsy+J9mrZ1Wf7wS2nbzyQRLcubG9
        2psc0mKXKvJ+2kdRw6HEYkNLCwpLVNsxVYOXR2pWtbwzdATo1dBoFpzXooo39rvRBRo0o0
        1ub1gQ87AFtIrFmPO1DIuTG/y+sk7T4sNtoXnRtM+ZzihCkZCJ6w+uCVUFnZXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XmeDaeqxxBY7nsoBMruO4Bn75n1RoKWKMjjDX37M0fs=;
        b=4TRSK3fTnqS9ah+MoAl2pZjh7JGD7zL3nf8/AlaZJEycpo5R4OnAVQ9KVGqzBJKDU/VQfh
        oWMLvyBEwF05AKAg==
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
Subject: [patch V2 05/40] irqchip/ti-sci-inta: Fix kernel doc
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:34 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W=1 build complains:

drivers/irqchip/irq-ti-sci-inta.c:177: warning: Function parameter or member 'vint_id' not described in 'ti_sci_inta_xlate_irq'
drivers/irqchip/irq-ti-sci-inta.c:177: warning: Excess function parameter 'irq' description in 'ti_sci_inta_xlate_irq'

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-ti-sci-inta.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -168,7 +168,7 @@ static void ti_sci_inta_irq_handler(stru
 /**
  * ti_sci_inta_xlate_irq() - Translate hwirq to parent's hwirq.
  * @inta:	IRQ domain corresponding to Interrupt Aggregator
- * @irq:	Hardware irq corresponding to the above irq domain
+ * @vint_id:	Hardware irq corresponding to the above irq domain
  *
  * Return parent irq number if translation is available else -ENOENT.
  */

