Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0416F8FCF
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEFHS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEFHS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 03:18:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87BF74C1E
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 00:18:58 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vC4bpnvtnGGqgvC4kpbPX0; Sat, 06 May 2023 09:11:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683357087;
        bh=hARn2U5Ck8gsaGekp7/R1Pqh66Ft8Q75GW6ULFlZglk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jCzkfsS+JENGKpeRh4/VY6mz+f9xHy5jKatmWS04zuwGUv9WRlBqrvl/zlOZJYp7M
         zNnKHEUPsQopJd4vvX/Tn9tSHcr4HqzeDvGHRbRL8PpMx/HlhZNryCERxcM3pzfCtb
         mZxm19jDJyvK9C26UCXEW8nVgKEk+ve1wU4nx6Wgr7ezd6QzZ5NreCKmzrU/adE8qk
         Q3ylq+2ffYcHYFLTM7N8HGkQEqfFVU5dZJgdXym7MKnf7wgr5dWBj/+Bfh1wYC5ua+
         2d0MmoIyRMD4Z0GleiADFS++dIWnjc3g41YjJvVdv/yCKrrucTLC4ScWjbj4DEqPsR
         xZrPrPGglryxQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 09:11:27 +0200
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
Subject: [PATCH 2/2] x86/PCI: Slightly simplify pirq_convert_irt_table()
Date:   Sat,  6 May 2023 09:11:10 +0200
Message-Id: <84bf047b01452a72642dbe355b02ef016c985a91.1683356951.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
References: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'size' if computed twice. *ir and *it being the same, the result is the
same as well.

While at it, also use struct_size() which is less verbose, more robust and
more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/x86/pci/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index e29b487cc069..6bc51f80eec2 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -140,14 +140,13 @@ static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr,
 	if (ir->signature != IRT_SIGNATURE || !ir->used || entries < ir->used)
 		return NULL;
 
-	size = sizeof(*ir) + ir->used * sizeof(ir->slots[0]);
+	size = struct_size(ir, slots, ir->used);
 	if (size > limit - addr)
 		return NULL;
 
 	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
 	    __pa(ir));
 
-	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
 	rt = kzalloc(size, GFP_KERNEL);
 	if (!rt)
 		return NULL;
-- 
2.34.1

