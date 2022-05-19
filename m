Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973EB52DB2C
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiESR0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiESRZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 13:25:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB6F332;
        Thu, 19 May 2022 10:25:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so9369262pjb.2;
        Thu, 19 May 2022 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brt3Yeauzwa5CMMxNRUyLq/zIk6506yKuvqwwF5DMC8=;
        b=JSJdcqdSDHPjGSo+xJVkbFOfu6AOq9y9IhGph92HdwJ9MI/md7HGxr+0wkTaI+xCTl
         4t96zC4F+ojZ6FCrrCQrG1mWOmOzNaR8Ktxz6/dolYM9VvRhqhqMRkvlPffCpt9VwykO
         s2msXPGgxgbtioNQwfUaqOs9xfTQjgR+MUSf+TavLIkvPQ3C4E86pKabt8uM0tPzqP9W
         FfOlJYzShD+Dg/Of9SseQ9vyGLfvezn4cnwWRhEow0rOASJZz0I6E0SKaWcrR8KjqaKr
         e3OgDZUH8v1FkJ3np7ID3xTI+Du8pLJycLmew+44eYLIPrDcarYPLfLyFrFL2hYo7+QG
         HoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brt3Yeauzwa5CMMxNRUyLq/zIk6506yKuvqwwF5DMC8=;
        b=gpepObByyqoC1Ev+gMSONyJ33nyq0bmA4PWTTs3ijB+tEYZYJIvjic/HbZYhvzrwrZ
         C8QJOpsJ81B/fAZyuHgCiUQrVkH1es9gC9mvTidGcHp/pYOwtNpkvpx70vtVA6Raa3oB
         VXDZqBe3C7T0mHUXS3qMnNgo+1KjVJ7kASzaRQdLSRB1GTW5U2Lvs+71+9iZpUIRPd3/
         yBtHK+2MmFIebzHFB+JCYP9b8wkG0+kFBR1cueT5vERVMg1j9hjvn+DLbwG8TIMKhIan
         q0nGAnzODt3o/Qt5nOSf3EEtSAF0VUht9Ak0x98sR3AKyRlsWi0DgxyHqA9eb8Y8Yl61
         xInw==
X-Gm-Message-State: AOAM530EjPZj59lXcrBDWNN8ClRLMLeAMtqLaAXryNpggQUBzZZ5GgWW
        kyGgC25qXHM1WV1UkaR1fAC2Y/lTaUqR
X-Google-Smtp-Source: ABdhPJyRNZ55YmuAKFNKOY/V8a+Mw2JojTXrQcsM6jyTPrXRQTybLjqXiyjSo1Fyqw9hTeU1Y0M+/w==
X-Received: by 2002:a17:90b:3903:b0:1df:d0b4:3b54 with SMTP id ob3-20020a17090b390300b001dfd0b43b54mr5463906pjb.40.1652981141801;
        Thu, 19 May 2022 10:25:41 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:41 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 28/28] PCI/P2PDMA: Convert to printbuf
Date:   Thu, 19 May 2022 13:24:21 -0400
Message-Id: <20220519172421.162394-29-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
index 1015274bd2..0d5c993386 100644
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
+static void pr_bus_devfn(struct printbuf *buf, struct pci_dev *pdev)
 {
-	if (!buf)
-		return;
-
-	seq_buf_printf(buf, "%s;", pci_name(pdev));
+	pr_buf(buf, "%s;", pci_name(pdev));
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
+			pr_bus_devfn(&acs_list, a);
 			acs_cnt++;
 		}
 
@@ -500,7 +495,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			break;
 
 		if (pci_bridge_has_acs_redir(bb)) {
-			seq_buf_print_bus_devfn(&acs_list, bb);
+			pr_bus_devfn(&acs_list, bb);
 			acs_cnt++;
 		}
 
-- 
2.36.0

