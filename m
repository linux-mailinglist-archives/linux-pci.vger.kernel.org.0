Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2239599DCF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349643AbiHSOuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349638AbiHSOun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 10:50:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D107EEC77
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p18so4329447plr.8
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vikAzh9NWoFPTJPPXjTU2UjuhH8xGYu4rC/hhqXWXiE=;
        b=SJ++9QfiwF1/vLcdgXuesPGMMZzLwSuVFwhiYShXragKwRtGPCjpbMkpbcTwiMMpZz
         7oGb/hSMKV10ZUEEjIMQ/SE7AbWAYNXBrKGuYmPxW35kgfWtQxgSOoskSWvj1Xh8xwIh
         9QBSoafSIEwTgIrWcF+cq+C2xzY33+kvQjjccRzw/jY3sUPJUSpnWSWsobrIQMrMADlN
         27nVUYh2DKCsvVlmndPMR8+HkoNNIRN/+caUqBGueXqzUcT9bYRwCF7Ef/XC1ulAXMan
         wEGRcpc0DyEQA9v2slHGd9rzVK/SUjQd/2yW6qhE4lB2FmlCDtEEWJpJq3NmJksZzQfA
         +owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vikAzh9NWoFPTJPPXjTU2UjuhH8xGYu4rC/hhqXWXiE=;
        b=sekk93uZx85KQ0P9J15D67Mk+4YrpcJ5HTkzECfHPBqOz69lxYtjtRsm4ZHDZ1rGXL
         E4FH6bTkKrGBgPCm269iu4PJv+pcvwUuS06DGzkRt3KsET9gTX74tqwIYFZ+u6Ed+bxp
         VNjUq6PLqI0XOZKFiLrbHK2NLbB98jRbXRhKUKbg04mDu93gV9olsj+flSB2TIp3MrzV
         83sRhjqgXld4AtHl+81PEi/85GJxloKQODPGZIJD6HG76pCahIom9/m7KHtWDu5EEjmE
         S1P79Mv5d0fsBS7g+L8IcdalkiL0rViaXoJFMYMGEdPm/Epo5wUWN7380aJ5iZijCBsN
         CZRw==
X-Gm-Message-State: ACgBeo1TFH96n51I2q9c3m/FWnFpmI8XNJeMoWOM2oHao02jkaE610gw
        nqQoh3+6JSjB2XPV9hLVy4Y/
X-Google-Smtp-Source: AA6agR6NZlmh0EuKkvQIeFSe/N2REdZBOHn4R3Ur/UABybOUhs+9AMwZwzmtg+XZ8EwycD8yldEc8Q==
X-Received: by 2002:a17:90b:17ce:b0:1f4:d068:5722 with SMTP id me14-20020a17090b17ce00b001f4d0685722mr14055637pjb.28.1660920641497;
        Fri, 19 Aug 2022 07:50:41 -0700 (PDT)
Received: from localhost.localdomain ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a789800b001f312e7665asm3268380pjk.47.2022.08.19.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:50:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] tools: PCI: Fix parsing the return value of IOCTLs
Date:   Fri, 19 Aug 2022 20:20:16 +0530
Message-Id: <20220819145018.35732-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"pci_endpoint_test" driver now returns 0 for success and negative error
code for failure. So adapt to the change by reporting FAILURE if the
return value is < 0, and SUCCESS otherwise.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 tools/pci/pcitest.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 441b54234635..a4e5b17cc3b5 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -18,7 +18,6 @@
 
 #define BILLION 1E9
 
-static char *result[] = { "NOT OKAY", "OKAY" };
 static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 
 struct pci_test {
@@ -54,9 +53,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_BAR, test->barnum);
 		fprintf(stdout, "BAR%d:\t\t", test->barnum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->set_irqtype) {
@@ -65,16 +64,18 @@ static int run_test(struct pci_test *test)
 		if (ret < 0)
 			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->get_irqtype) {
 		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
 		fprintf(stdout, "GET IRQ TYPE:\t\t");
-		if (ret < 0)
+		if (ret < 0) {
 			fprintf(stdout, "FAILED\n");
-		else
+		} else {
 			fprintf(stdout, "%s\n", irq[ret]);
+			ret = 0;
+		}
 	}
 
 	if (test->clear_irq) {
@@ -83,34 +84,34 @@ static int run_test(struct pci_test *test)
 		if (ret < 0)
 			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->legacyirq) {
 		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
 		fprintf(stdout, "LEGACY IRQ:\t");
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->msinum > 0 && test->msinum <= 32) {
 		ret = ioctl(fd, PCITEST_MSI, test->msinum);
 		fprintf(stdout, "MSI%d:\t\t", test->msinum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->msixnum > 0 && test->msixnum <= 2048) {
 		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
 		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->write) {
@@ -120,9 +121,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_WRITE, &param);
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->read) {
@@ -132,9 +133,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_READ, &param);
 		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->copy) {
@@ -144,14 +145,14 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_COPY, &param);
 		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	fflush(stdout);
 	close(fd);
-	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
+	return ret;
 }
 
 int main(int argc, char **argv)
-- 
2.25.1

