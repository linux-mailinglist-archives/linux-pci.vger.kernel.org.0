Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6B4709E6B
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjESRmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjESRmi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 13:42:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43910D
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 10:42:34 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 047Zqh2d1ln91047ZqYTB1; Fri, 19 May 2023 19:42:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684518152;
        bh=mAaO/WBbYiwwJShzEiCb+5IddAiptsLyN04MdP2OqLA=;
        h=From:To:Cc:Subject:Date;
        b=H3CtDD3+Pj6GAN5+IziYhhQ43auTun8QEHu+PODCpbpFNWxka/yOMP5BimHMJhh5s
         lBHmslKC7aU9q4GFO/15SKg9uZWve9BNm75A8VSTMUEOpeNlVcD9fwJAHmExobhQK6
         q16gz/LLg4Bhl2UFCVn2BlgX7GiPrxMxFiDwLRduECWS1vfsEC6bah6Aq7KR1X8jr5
         TUmXEXfVw51CEGaR39ZYxTzVDnC/3mN02yhJEV98H8zQbRCfa3j+HxSvd0GBYcCLCT
         APQPim1923PLfgxiJ13Pn6+RHh9m7EwnG7k4mGlV5oM/Fmg9GVnPksi788Y4/yHFdv
         wsfmwtALvcfmA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 19 May 2023 19:42:32 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH] x86/PCI: Use struct_size()
Date:   Fri, 19 May 2023 19:42:28 +0200
Message-Id: <00a5cc2cd322e7dea26579916ac6dda9c637aa57.1684518118.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use struct_size() instead of hand-writing it. It is less verbose, more
robust and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/x86/pci/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index a498b847d740..0de436316a1d 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -136,14 +136,14 @@ static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr,
 	if (ir->signature != IRT_SIGNATURE || !ir->used || ir->size < ir->used)
 		return NULL;
 
-	size = sizeof(*ir) + ir->used * sizeof(ir->slots[0]);
+	size = struct_size(ir, slots, ir->used);
 	if (size > limit - addr)
 		return NULL;
 
 	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
 	    __pa(ir));
 
-	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
+	size = struct_size(rt, slots, ir->used);
 	rt = kzalloc(size, GFP_KERNEL);
 	if (!rt)
 		return NULL;
-- 
2.34.1

