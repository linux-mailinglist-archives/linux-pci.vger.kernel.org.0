Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76DB5933FC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiHOR0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 13:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiHOR0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 13:26:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A847E0DE;
        Mon, 15 Aug 2022 10:26:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKGAoYzKocT6tPlfHYXOslYqo3Kewd4KFjNpWIp1c9A=;
        b=j4OUDaXkkAn4u47WZY/pom7BeBDQvQsBTh6U/GoeZMrvY81CLYmZyyXCbYeR8baovY+NCt
        WOKR6db7S2VvRhigxOpJsFQ5ocGvMWFnPl5tQSkmLbqs8Ljnl1ngGyHxW5Zwt09hlUfxUY
        KWo6qjxnlBeKDoesI4Fc76yvdpSfvv0=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 06/11] PCI/P2PDMA: Convert to printbuf
Date:   Mon, 15 Aug 2022 13:26:08 -0400
Message-Id: <20220815172613.621627-7-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode so this is a direct conversion.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/p2pdma.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4496a7c5c4..8e29e7caba 100644
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
2.36.1

