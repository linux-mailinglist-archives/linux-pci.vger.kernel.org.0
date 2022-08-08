Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7258C1AF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 04:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbiHHCln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Aug 2022 22:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiHHClj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF121BF;
        Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BvTU+A/nzuWUa8MQa4k7Sb4glYSL+iQXtzbWCaKztNY=; b=GLqkpcfBCrPO49rGo+VKNZFVZU
        iFKYf5NbjDOjL4T7Ju6Az370rqSdPV+96FyYRNmhl3+vbhVxDgIqTUDNIHpSR0FIKJqXava9rSkkU
        pYZE51oQzMU37HijszMPXEys7ubsnPoFDlFr0ye4g4iiyr5hg68zVpKt2/DItFlQoSTeSRUFcCfn7
        g/d7u693Gyd85tSt6SxgEZlBJQT4Uz5NyD1OOtZzX+yNRjygMRX4DeZ75dfKkjj89tCiYU+Tvyce/
        PQsKCLIC0R55T5USWY/OT4FdnaAKeF+ufewhzxYP142nkG/bFzidi4z+wsj209PGZ9DD7wjLzjgXr
        HeAlwkHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVSh-QD; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH v5 27/32] PCI/P2PDMA: Convert to printbuf
Date:   Mon,  8 Aug 2022 03:41:23 +0100
Message-Id: <20220808024128.3219082-28-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode, so it's a direct conversion, aside from some trivial
refactoring in cpu_show_meltdown() to make the code more consistent.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/p2pdma.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4496a7c5c478..8e29e7cabad3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -18,7 +18,7 @@
 #include <linux/memremap.h>
 #include <linux/percpu-refcount.h>
 #include <linux/random.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/xarray.h>
 
 struct pci_p2pdma {
@@ -275,12 +275,9 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 	return 0;
 }
 
-static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
+static void prt_bus_devfn(struct printbuf *buf, struct pci_dev *pdev)
 {
-	if (!buf)
-		return;
-
-	seq_buf_printf(buf, "%s;", pci_name(pdev));
+	prt_printf(buf, "%s;", pci_name(pdev));
 }
 
 static bool cpu_supports_p2pdma(void)
@@ -454,13 +451,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	struct pci_dev *a = provider, *b = client, *bb;
 	bool acs_redirects = false;
 	struct pci_p2pdma *p2pdma;
-	struct seq_buf acs_list;
 	int acs_cnt = 0;
 	int dist_a = 0;
 	int dist_b = 0;
 	char buf[128];
-
-	seq_buf_init(&acs_list, buf, sizeof(buf));
+	struct printbuf acs_list = PRINTBUF_EXTERN(buf, sizeof(buf));
 
 	/*
 	 * Note, we don't need to take references to devices returned by
@@ -471,7 +466,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		dist_b = 0;
 
 		if (pci_bridge_has_acs_redir(a)) {
-			seq_buf_print_bus_devfn(&acs_list, a);
+			prt_bus_devfn(&acs_list, a);
 			acs_cnt++;
 		}
 
@@ -500,7 +495,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			break;
 
 		if (pci_bridge_has_acs_redir(bb)) {
-			seq_buf_print_bus_devfn(&acs_list, bb);
+			prt_bus_devfn(&acs_list, bb);
 			acs_cnt++;
 		}
 
@@ -515,11 +510,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	}
 
 	if (verbose) {
-		acs_list.buffer[acs_list.len-1] = 0; /* drop final semicolon */
+		acs_list.buf[acs_list.pos-1] = 0; /* drop final semicolon */
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
-			 acs_list.buffer);
+			 acs_list.buf);
 	}
 	acs_redirects = true;
 
-- 
2.35.1

