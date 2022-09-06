Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C445AE51B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiIFKQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIFKQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 06:16:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C452CDF7
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 03:16:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 65so638947pfx.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hXiNAyvQQWIBJxUajZXg5TzJhz9BDXjhOqmjIrcqoMg=;
        b=U/WzBdX6suz8BGPmr7TORZNTIMN2KAe/OX9ejIWK4DHDWoUKD57SIvvoc5Q+rp+Iry
         VK4z4Ohy08BiYvvsKuxlgkIPZKvoxmEpZTV1mgUfMLmjjiZxch4F9IZcc9fCcqomXMEz
         +tRzS1/Kgn4fsuGpBM8IxXrmn4mfYgNMteMPs/pgonR+h2QKob+Oz0S8nh5PgzJvoOTa
         j9lfKECe5c2FQ1qimcKaHRzUU9N5C207+Sw/XntYgjclSYappwPuH39+olrz66fIvGDg
         QAH9M9tlXojbDsSUYBWbQB/wX6qq1+Li6LRG+9nb/KewYxm5/NvE15oH5W81FZs/GJ2Q
         +NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hXiNAyvQQWIBJxUajZXg5TzJhz9BDXjhOqmjIrcqoMg=;
        b=MkuIAHRpZHdtRSRCcesl6mFqAbP0T85IkYCk0y3Pay4UUcE9a3sKdW9TQdg7XD78qp
         UcTRbJOI1pC0KIG7O161dCMtZTeOHCu6sagUJwOqM8M6ffXIpeCPvCOgs/aLjgijjET8
         CuSmTNOQlFxCQyTgUW77s+avwjrQa8c0ZZZnfw7ardX+WZHc+Cx7e+lu6bzhxFn7zZgO
         ytAZT4RQ9HCu7PoKzMKvQ5x9U1orgH3p5jLKvt9LHS54vyuow4RiCqsJTX+H0jvywukI
         DJzbM2uaF98TZKIB/yxKS2XR+On90FujDJcxvRyKRz8pa0+vu3Wtl0GOHYIVJxafX+oS
         REQA==
X-Gm-Message-State: ACgBeo16FfC9TdokWcST99jamZDyKFOJvXhjSip+3KvOnEOy6Dlxx6xK
        qAtsgrRvjMG6uNqldlU8eC/uqMIknKhBlg==
X-Google-Smtp-Source: AA6agR4m4gRunsr3jfo/GCmmk67043I3g7JZJEcZcymFDtndOfjg56AhgkfRNBaWFwAl2vHUCnz0GA==
X-Received: by 2002:a05:6a00:1894:b0:537:2e86:c7df with SMTP id x20-20020a056a00189400b005372e86c7dfmr54511206pfh.18.1662459361496;
        Tue, 06 Sep 2022 03:16:01 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f62-20020a625141000000b0053b723a74f7sm7914151pfb.90.2022.09.06.03.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:16:00 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [RFC PATCH v2 1/2] misc: pci_endpoint_test: Aggregate params checking for xfer
Date:   Tue,  6 Sep 2022 19:15:54 +0900
Message-Id: <20220906101555.106033-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Each transfer test functions have same parameter checking code. This patch
unites those to an introduced function.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes in v2:
* New patch
---
---
 drivers/misc/pci_endpoint_test.c | 35 ++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..3bd9f135cdac 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -332,6 +332,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static int pci_endpoint_test_validate_xfer_params(struct device *dev,
+		struct pci_endpoint_test_xfer_param *param, size_t alignment)
+{
+	if (param->size > SIZE_MAX - alignment) {
+		dev_err(dev, "Maximum transfer data size exceeded\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
@@ -363,9 +374,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err) {
+		dev_err(dev, "Invalid parameter\n");
+		return false;
+	}
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -497,9 +512,13 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err) {
+		dev_err(dev, "Invalid parameter\n");
+		return false;
+	}
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -595,9 +614,13 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err) {
+		dev_err(dev, "Invalid parameter\n");
+		return false;
+	}
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
-- 
2.17.1

