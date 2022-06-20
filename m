Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9274A550E0D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 02:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiFTAou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jun 2022 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiFTAnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2022 20:43:50 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C94DB847;
        Sun, 19 Jun 2022 17:43:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p63so6869820qkd.10;
        Sun, 19 Jun 2022 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Xg1dB8Y2o2fTfyU6/JMm3V6r0Q6Byu7YKRWwJ+H+P4=;
        b=YMEMmazsTJymTBZg5B+MMIRicoAxtJ7ZVBPY72BhCaDEL02Th5qRPhx4J9aamZdt2R
         AX6lCzjBTjorsmk12pbSZSnV0blpooWefBhQa6O2wBOTFFgCptAUNs6vG+zx+1sNT2Mw
         LsDQZlzhxIvqKfjVGHbfpXG9X53Bhl1mbztGVaEhDrq+vD3TvA+a3nopvnrSOryggHkf
         UClv9V+ds1nzIuGbf+Yfl6o/j7LxV6WRfVzHcH3rr6l+9uBQi3CPFh2zdLvJhef/dXM3
         4QAWd9MFzvQ0BmraqaKTlWNuOtkOTVXJWKV3g7AsUDD1EU1RBhJcxlTykX8tjZ3KXK0p
         br0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Xg1dB8Y2o2fTfyU6/JMm3V6r0Q6Byu7YKRWwJ+H+P4=;
        b=D5cCQjNK4ZV5k8u0E55GXNtDpdw5liqm3aZr0vlPyip/vRuHmojWMOnDwC6GCrdjNo
         P/om2v4/FDiuBwfmoLk62BfM2OYxKBkf65HEVx6NI0bD9kDhtcJ3ws7udogYnJ4zNzoV
         hL86EAYod9ZLg51vZvYfQRHZpKcpWj/Cg7pjwEubkmE2bjkh/gTyrjL3VPTnoSRtu158
         ChPTL5F/3JA+f6yxIARZKh30ymqsuHrBoGENeVeIAnRlnVC0wG2EAuyiwQPTmgCvd4xs
         AUTW3y9Wds1fhy/wyT2nPUCeN7II93pC5PCXTWhi8DBpG6S64eGzVna+QixYWRixrNIa
         byXg==
X-Gm-Message-State: AJIora/cv7gH4lAYu5q1i2OTnrQ30P1VDcj4O9/E4aS9rlEZ+yOFEQoc
        l7JApDkRx2td1O9l4qECjQzwr0UK0pyRNDQ=
X-Google-Smtp-Source: AGRyM1uCfrheAlhgCp9i1EFrQVHXoukF22l+FI6Up40z4nZppqvuTPxoWyFhEbHIP29gGwI1wSisVA==
X-Received: by 2002:a37:5e46:0:b0:6ab:90dc:d9d6 with SMTP id s67-20020a375e46000000b006ab90dcd9d6mr9561307qkb.131.1655685821224;
        Sun, 19 Jun 2022 17:43:41 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id ci6-20020a05622a260600b003051ce7812asm9739089qtb.5.2022.06.19.17.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:40 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 29/34] PCI/P2PDMA: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:28 -0400
Message-Id: <20220620004233.3805-30-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode, so it's a direct conversion, aside from some trivial
refactoring in cpu_show_meltdown() to make the code more consistent.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/p2pdma.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d..3b7a6ca446 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -17,7 +17,7 @@
 #include <linux/memremap.h>
 #include <linux/percpu-refcount.h>
 #include <linux/random.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/xarray.h>
 
 enum pci_p2pdma_map_type {
@@ -281,12 +281,9 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
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
@@ -455,13 +452,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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
@@ -472,7 +467,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		dist_b = 0;
 
 		if (pci_bridge_has_acs_redir(a)) {
-			seq_buf_print_bus_devfn(&acs_list, a);
+			prt_bus_devfn(&acs_list, a);
 			acs_cnt++;
 		}
 
@@ -501,7 +496,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			break;
 
 		if (pci_bridge_has_acs_redir(bb)) {
-			seq_buf_print_bus_devfn(&acs_list, bb);
+			prt_bus_devfn(&acs_list, bb);
 			acs_cnt++;
 		}
 
@@ -516,11 +511,11 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
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

