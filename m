Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5A6E2EA8
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDOCgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjDOCgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0A5FFC
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6D0D64079
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C0C433D2;
        Sat, 15 Apr 2023 02:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526168;
        bh=G0LOHzcvtEdKXfEDzwz1WeiaCCW1mDE2gp5mIDAgnXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5Dob+elXzI2mED2gQFbw7x07kAoYixg2y75RE5bs6kwVqIkchxpbMqbt9qcvxtSh
         m/EizFVMwi4qg9oAL72ghMw/lNjiMe8zLFr5+6ZsAr+UijM95njjMWMrhqBoPXJk8O
         N1P0BsBfZrHpGeD5qELuyoNNqqI9r17eYZxZEW/dLMankiA4yR4tJUrRbIXSXlqoRk
         50FnWdQd0BbAdl5AdOZZz07sFugOd2dKj7uwkwmqQIcWNhvZP7bNF0QiHW8sZz0jcT
         Gb2dxrXwRAs/+mVNV0RiF41SYW1FzrEqHxcrJ13nqilz6l0SkzgZmez5Zyz9JJfcTc
         u3nNautNpY/Yw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 13/17] PCI: epf-test: Simplify transfers result print
Date:   Sat, 15 Apr 2023 11:35:38 +0900
Message-Id: <20230415023542.77601-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pci_epf_test_print_rate(), instead of open coding a reduction loop to
allow for a division by a 32-bits ns value, simply use div64_u64() to
calculate the transfer rate. To match the printed unit of KB/s, this
calculation divides the rate by 1000 instead of 1024 (that would be
KiB/s unit).

Change the format of the results printed by pci_epf_test_print_rate()
to be more compact without the double new line. Also use dev_info()
instead of pr_info().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 39 +++++++------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 909e3e8ac01c..0bb14fb21edd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -295,34 +295,23 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	return;
 }
 
-static void pci_epf_test_print_rate(const char *ops, u64 size,
+static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
+				    const char *op, u64 size,
 				    struct timespec64 *start,
 				    struct timespec64 *end, bool dma)
 {
-	struct timespec64 ts;
-	u64 rate, ns;
-
-	ts = timespec64_sub(*end, *start);
-
-	/* convert both size (stored in 'rate') and time in terms of 'ns' */
-	ns = timespec64_to_ns(&ts);
-	rate = size * NSEC_PER_SEC;
-
-	/* Divide both size (stored in 'rate') and ns by a common factor */
-	while (ns > UINT_MAX) {
-		rate >>= 1;
-		ns >>= 1;
-	}
-
-	if (!ns)
-		return;
+	struct timespec64 ts = timespec64_sub(*end, *start);
+	u64 rate = 0, ns;
 
 	/* calculate the rate */
-	do_div(rate, (uint32_t)ns);
+	ns = timespec64_to_ns(&ts);
+	if (ns)
+		rate = div64_u64(size * NSEC_PER_SEC, ns * 1000);
 
-	pr_info("\n%s => Size: %llu bytes\t DMA: %s\t Time: %llu.%09u seconds\t"
-		"Rate: %llu KB/s\n", ops, size, dma ? "YES" : "NO",
-		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
+	dev_info(&epf_test->epf->dev,
+		 "%s => Size: %llu B, DMA: %s, Time: %llu.%09u s, Rate: %llu KB/s\n",
+		 op, size, dma ? "YES" : "NO",
+		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
 }
 
 static void pci_epf_test_copy(struct pci_epf_test *epf_test,
@@ -397,7 +386,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 		kfree(buf);
 	}
 	ktime_get_ts64(&end);
-	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
 
 err_map_addr:
@@ -481,7 +470,7 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
 		ktime_get_ts64(&end);
 	}
 
-	pci_epf_test_print_rate("READ", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
 
 	crc32 = crc32_le(~0, buf, reg->size);
@@ -570,7 +559,7 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
 		ktime_get_ts64(&end);
 	}
 
-	pci_epf_test_print_rate("WRITE", reg->size, &start, &end,
+	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
 				reg->flags & FLAG_USE_DMA);
 
 	/*
-- 
2.39.2

