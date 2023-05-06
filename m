Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F686F8FCE
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEFHS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEFHS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 03:18:57 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 May 2023 00:18:55 PDT
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0ACF11567
        for <linux-pci@vger.kernel.org>; Sat,  6 May 2023 00:18:55 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vC4bpnvtnGGqgvC4bpbPWL; Sat, 06 May 2023 09:11:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683357083;
        bh=LCwtFRx+YxY+EmtN+x8N93lmLUJnBu1GrjughYec7hk=;
        h=From:To:Cc:Subject:Date;
        b=dPDRr9NJWUcumThQ3K8vmGoeFthoe40EmUuljc44kB6Db1/nur+r3j+irmyyDY6fJ
         FmKTLTebxollA+5WkjbG2hHYBh5hFwz3qxCz8BDkV87L2Wuu23WF7DKfRW1Ial90IE
         nbOfhNAHOwV+1ohcE2SbHWbX2vvLqqkeXTFS9yu0Rty0IZZgHs4RQpkMXHpBuPSZlQ
         EYiSdWajeq+wLrAAIe8ZbciQvBNHEWi02kTHh2743MgdarwyrNThgKMAXI8MQ5WFbx
         bpdXtTSUSISBEm98bDhfFG5cIyjrNgJIaKWxKHfQIhn1LYLohibYm2U8NrvfMspNZN
         gChnjeggQqtTw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 09:11:23 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/2] x86/PCI: Fix a sanity check in pirq_convert_irt_table()
Date:   Sat,  6 May 2023 09:11:09 +0200
Message-Id: <bc8422a8bf3ff99809413eb62dd12aacc85a9950.1683356951.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
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

We compare the size in bytes of a struct (and its ending flexible array)
with the number of elements in a flexible array.

This is wrong and "ir->size < ir->used" is likely to be always false.

Compute the number of possible entries instead, as already done in other
places, and compare it to the number of used entries.

Fixes: b584db0c84db ("x86/PCI: Add $IRT PIRQ routing table support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---

/!\  This patch is speculative. Review with care  /!\


I'm not sure that this sanity check is needed at all.

If 'used' was the size of the flexible array, I think it would simplify
the code in other places. It will also help scripts when __counted_by macro
will be added.
See [1].

[1]: https://lore.kernel.org/all/6453f739.170a0220.62695.7785@mx.google.com/
---
 arch/x86/pci/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index a498b847d740..e29b487cc069 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -128,12 +128,16 @@ static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr,
 {
 	struct irt_routing_table *ir;
 	struct irq_routing_table *rt;
+	int entries;
 	u16 size;
 	u8 sum;
 	int i;
 
 	ir = (struct irt_routing_table *)addr;
-	if (ir->signature != IRT_SIGNATURE || !ir->used || ir->size < ir->used)
+	entries = (ir->size - sizeof(struct irq_routing_table)) /
+		sizeof(struct irq_info);
+
+	if (ir->signature != IRT_SIGNATURE || !ir->used || entries < ir->used)
 		return NULL;
 
 	size = sizeof(*ir) + ir->used * sizeof(ir->slots[0]);
-- 
2.34.1

