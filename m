Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AD495FB3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 14:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380607AbiAUNU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 08:20:58 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:43936 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiAUNU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 08:20:56 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (1024 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 58DE61C0BAB
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 14:20:55 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id DDBAB1A1639; Fri, 21 Jan 2022 14:20:54 +0100 (CET)
Date:   Fri, 21 Jan 2022 14:20:54 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] lspci: Don't report PCIe link downgrades for downstream
 ports
Message-ID: <mj+md-20220121.131934.39347.albireo@ucw.cz>
References: <20210318170244.151240-1-helgaas@kernel.org>
 <20210318173325.GR3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318173325.GR3420@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 58DE61C0BAB
X-Spam-Status: No, score=-1.49
X-Spamd-Bar: -
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
X-Spamd-Result: default: False [-1.49 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         DMARC_NA(0.00)[ucw.cz];
         SENDER_REP_HAM(-0.69)[asn: 51744(-0.18), country: CZ(-0.01), ip: 91.219.245.20(-0.51)];
         RCPT_COUNT_FIVE(0.00)[6];
         AUTH_NA(1.00)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-1.000];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         TAGGED_FROM(0.00)[f-210122,linux-pci=vger.kernel.org];
         MID_RHS_MATCH_FROM(0.00)[]
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

This fell through the cracks in my mailbox, but I finally assembled
pieces and here is what I applied.

				Martin


commit 9f7681202fcfaefd02e202eb64c01eb9e962729d
Author: Martin Mares <mj@ucw.cz>
Date:   Fri Jan 21 14:16:37 2022 +0100

    lspci: Improvements to PCIe link speed downgrade reporting
    
    Do not report PCIe link downgrades for downstream ports.
    
    Changed wording so that "overdriven" is reported instead of
    "strange" for speeds greater than the maximum supported one.
    
    Also report nothing instead of "ok".
    
    Inspired by patches by Bjorn Helgaas and Matthew Wilcox.

diff --git a/ls-caps.c b/ls-caps.c
index 91acb59..79b61cd 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -771,13 +771,16 @@ static char *link_speed(int speed)
     }
 }
 
-static char *link_compare(int sta, int cap)
+static char *link_compare(int type, int sta, int cap)
 {
-  if (sta < cap)
-    return "downgraded";
   if (sta > cap)
-    return "strange";
-  return "ok";
+    return " (overdriven)";
+  if (sta == cap)
+    return "";
+  if ((type == PCI_EXP_TYPE_ROOT_PORT) || (type == PCI_EXP_TYPE_DOWNSTREAM) ||
+      (type == PCI_EXP_TYPE_PCIE_BRIDGE))
+    return "";
+  return " (downgraded)";
 }
 
 static char *aspm_support(int code)
@@ -850,11 +853,11 @@ static void cap_express_link(struct device *d, int where, int type)
   w = get_conf_word(d, where + PCI_EXP_LNKSTA);
   sta_speed = w & PCI_EXP_LNKSTA_SPEED;
   sta_width = (w & PCI_EXP_LNKSTA_WIDTH) >> 4;
-  printf("\t\tLnkSta:\tSpeed %s (%s), Width x%d (%s)\n",
+  printf("\t\tLnkSta:\tSpeed %s%s, Width x%d%s\n",
 	link_speed(sta_speed),
-	link_compare(sta_speed, cap_speed),
+	link_compare(type, sta_speed, cap_speed),
 	sta_width,
-	link_compare(sta_width, cap_width));
+	link_compare(type, sta_width, cap_width));
   printf("\t\t\tTrErr%c Train%c SlotClk%c DLActive%c BWMgmt%c ABWMgmt%c\n",
 	FLAG(w, PCI_EXP_LNKSTA_TR_ERR),
 	FLAG(w, PCI_EXP_LNKSTA_TRAIN),
