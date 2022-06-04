Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7A53D851
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jun 2022 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiFDTcs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiFDTcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 15:32:10 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6054F9F4;
        Sat,  4 Jun 2022 12:31:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ew15so7962016qtb.2;
        Sat, 04 Jun 2022 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODz0xlzoLBs6dcrjiKhQxftor+2WPn3OJscfp/YQp7I=;
        b=Y1gh/CBM8MBqiAEP68Q5r9yD6zqL6tJYGIr5D9uF5dstEz3rT9cWB5jTPy2ceJ+/yE
         /Wse3w0exUsBYU/sErKIIiBTJngsnyLQ7Rby9npQ/75Y4tCO61GWPW/n9m6RPbsQ+FDe
         FJD81AC79cosf/Nes1YaBEJpuh1KNqVFmf09JCLGL2ij6/oTGGWQrjkrQUPT8iDz5jMq
         r9GsVNdxI3/L1+mwv/v4mzz1R0LWeHP6ucLYnhEgUkKWJLEfCiU57L04JLfiTT2e6RcM
         YLETwXcEmVAFroE9C8EDq6oPMPxMX3g6WLN8sKSB1KgtJEydz2uZQfcW0t7BHEgSOm/2
         aBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODz0xlzoLBs6dcrjiKhQxftor+2WPn3OJscfp/YQp7I=;
        b=6/nM3IvYZQoto7GFV84g+zkWxEbu+CCWWGN55PvIyA+OQ3V8tdGAwj+UwWZCtEDPpl
         Z4BfI/cPgTvnxYD2wzdl0m2pvO8gg8yuRuYOwr7izwyus+DHmE0VtjtgzthQGRXLY+Gu
         aC6PlVU9uQ2GyWvb9wWht8nxH78Dp/ArfnAEhKDSI4KEYVJsb9qJQeXtxeulYtMdxsyY
         NsZPHtIfqRUu6KE8y611mFCmLk0qM/Ocfw8ASKrSorgY8feBPh4S3PhBGD+tPYp1BCv7
         c589J+6o8VZS+ML8rQZ90U/TOr1CzHpNfyNc4f4K8iDryCXGhsivq6xIZIx2yBZHoiHI
         aI/A==
X-Gm-Message-State: AOAM533tdlQQaCclilnq4p7Lsmd1h4x9CPrZi0IMJaAe18s8aFISWBEG
        +acMyM8i6kpcPl1GCVbfWSDf2HesIUDS
X-Google-Smtp-Source: ABdhPJyFb0Cvw3XxP8j+iWRgmOmbVwwa/PfAwP6p+g+HAZV+hvBphkJ+ocbbc+Khip88ap0Tf5af4g==
X-Received: by 2002:ac8:570a:0:b0:304:e615:275f with SMTP id 10-20020ac8570a000000b00304e615275fmr3099117qtw.139.1654371094268;
        Sat, 04 Jun 2022 12:31:34 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:33 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 29/33] PCI/P2PDMA: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:38 -0400
Message-Id: <20220604193042.1674951-30-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
 drivers/pci/p2pdma.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d..c40d91912a 100644
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
 
-- 
2.36.0

