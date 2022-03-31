Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078524ED484
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiCaHNk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiCaHNJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:13:09 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E9CA0BF6;
        Thu, 31 Mar 2022 00:11:15 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D0E099200B3; Thu, 31 Mar 2022 09:11:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CBA1D92009E;
        Thu, 31 Mar 2022 08:11:14 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:11:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, Nikolai Zhubr <zhubr.2@gmail.com>,
        Michal Necasek <mnecasek@yahoo.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] x86/PCI: Fix coding style in PIRQ table
 verification
In-Reply-To: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203310017260.44113@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove an extraneous space with a cast in `pirq_check_routing_table'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Changes from v3:

- Remove parts obsoleted by 1/5.

New change in v3.
---
 arch/x86/pci/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -77,7 +77,7 @@ static inline struct irq_routing_table *
 	int i;
 	u8 sum;
 
-	rt = (struct irq_routing_table *) addr;
+	rt = (struct irq_routing_table *)addr;
 	if (rt->signature != PIRQ_SIGNATURE ||
 	    rt->version != PIRQ_VERSION ||
 	    rt->size % 16 ||
