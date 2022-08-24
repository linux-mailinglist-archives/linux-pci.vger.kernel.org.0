Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004DA59F9F8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiHXMaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiHXMa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 08:30:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3874A4A829
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 05:30:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 20so15530713plo.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MXeTFOPwaEYUnBKivNI6IIvkTRiGbL/Q2wJpJf6zbRo=;
        b=HQHBOY5lZpaZ+qTObtvVlZeS+Hz5VZapvG+JueRbRZDAdpGvaYCj8c8/syiQFxHkwS
         kVHkbTjUtEvgd+t5P7OHQKd39CRHrxnCDEE71shIBzXXimjpRJE3sOrdX3wjls23Bf3j
         dbaie1+5oEN2rUmiC3EN0HLElzS6rylQQq4pRPg8jhmzoIV88zduw4VhZe+0Vslu2f68
         qgu33LfbfuQ+A0S4YHSWwCWmKuweh8DdKNx0/kFCxhBItfCbISadP6td2FUU+zXAAKpe
         EJWh3vAGs7le17ILFjUc3Q/dVU2t4HsCWE6fANFYtVqxMiiKEFMYwbo12tGNZIDxkRPx
         47+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MXeTFOPwaEYUnBKivNI6IIvkTRiGbL/Q2wJpJf6zbRo=;
        b=OVaMBK6/X/MCUQi/N4J4/nIs4OBtuH6SR/I60H8sPFzq3m4Jvqn/HLzPnVZCZW8ilw
         G9fPAnKXz8uwp3sKauwZ1rttBU9iKuHPz2FsXykMSs3vSv+S4OLFz2Lixe5tN4hzN73U
         goFEpO8wp4Vk8VhZurPsl2rNn1WpSmJjd3M9RoqKOQzCpEvK6rG0wOiIqHfHDrajqIox
         jRczkolLy9yn8qUFIn159Kd3m0NSDtSR99bRZTlIPJlu1geb6FsUSGsr5a/3tFLJKubM
         e7hGJ2cdPhEh0mZlFCFDRl9om33GNzEDNzuJuccVhrOXHgGxpJkrgYEyyy8vWrj8GlNt
         Roiw==
X-Gm-Message-State: ACgBeo0BJqwqPBGI4PLa5s2GT1GPE1XcM7I1LthulJyV9Knc5IjfUjuY
        A+G219n1r+dQyloUILpPZiNt
X-Google-Smtp-Source: AA6agR6x9GSi2J9BABOsuQCyB8ynh29Q1qxfh7AhFPTdGC0DNCf+hHeDlhOUt8BK0F2Wu0IjKfJxSw==
X-Received: by 2002:a17:90b:1b10:b0:1fb:7baa:ce1c with SMTP id nu16-20020a17090b1b1000b001fb7baace1cmr4015390pjb.131.1661344227690;
        Wed, 24 Aug 2022 05:30:27 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b00173031308fdsm3539220plm.158.2022.08.24.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:30:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/5] tools: PCI: Fix parsing the return value of IOCTLs
Date:   Wed, 24 Aug 2022 18:00:07 +0530
Message-Id: <20220824123010.51763-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"pci_endpoint_test" driver now returns 0 for success and negative error
code for failure. So adapt to the change by reporting FAILURE if the
return value is < 0, and SUCCESS otherwise.

Cc: stable@vger.kernel.org #5.10
Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
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

