Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A45AF99E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 04:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIGCBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 22:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIGCBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 22:01:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1C886719
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 19:01:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so13021546plq.12
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wMmXTxb9LbCsYqga95mJwmvC4k81ZDpljIpjJFQZtFw=;
        b=hn6hqpEUxGoGhX68VXgTXpMCVKDJ5Pa6HLR3DTCS+p/PxteYYkJWtclUSQ+cFe8KTe
         jBdDF3N2kAMZp3qwCb8e0woljUxUquQSNV9Pq/AzMSLTHKXe69BXp+9OD1A2pWrD6sOL
         nWr92uWfuhzsfhJ4nN8KxkkF0zXIxxVezZkiWpzt+4LW8RKcR23HXmFvLGaKJMZXGWHJ
         JiEULAe6syHdCofXjyEvOs1ZVjq/pQrbYhRwPpX7bncI/u5VH5VkY4Jz5Mqj7AZEuA9D
         T4nap+kOtJo67m5mcrZwLQ7nMqT6vBLDeoe15kfsBhzkKTXO79GjcqeeX8jDIKyO1Mug
         jl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wMmXTxb9LbCsYqga95mJwmvC4k81ZDpljIpjJFQZtFw=;
        b=o/71+q1snYSNpPDIlxeOyidn0NEqmVdWjU++fcJTkASEq1SxdcvEr8XbiI29JP2T7G
         J3XhDPkeX9tT2l4JaOhka6iOmg8vKQQNFp1YMC1FU9ysds0vHMEYZAqWokSTFZ23Ts8v
         eFIlxzn2P6tZ81ZerIMSrZozDo2r1eB1Cifkd9JdRcgnayUnTMwvpTelrbcP9UhQ7bOe
         oelV15SKBhH25S9nx+YlrWkDmBg4M28Cx/Neal0QGCWu0BkFweBMGfwnbU/mrmfPkA6+
         WPPUXJi7AEBnrfYimeqTmIeHNISTGDvlYAka1a+bybsQ6poP8dwYZ2EfdRqbA4W8oZN8
         xopg==
X-Gm-Message-State: ACgBeo0ATvN+Gm9QXvuFKEG70BIpyWaQTNcZKVrwgMuAF8g9Ql/gGLeY
        FRy1x0k3PkM1EoaIv9klLDJ3huhbQXhTOg==
X-Google-Smtp-Source: AA6agR6xr1M9nClZ35+wWuEvB7RQBR2FuZReE6jv3+pgOUfltbLPBGu7oaxudF/b7HTVtH7DOaL/Aw==
X-Received: by 2002:a17:902:ce8e:b0:16d:cebc:e92e with SMTP id f14-20020a170902ce8e00b0016dcebce92emr1241966plg.85.1662516069638;
        Tue, 06 Sep 2022 19:01:09 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id s59-20020a17090a2f4100b002005c3d4d4fsm5182369pjd.19.2022.09.06.19.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 19:01:09 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH v3 1/2] misc: pci_endpoint_test: Aggregate params checking for xfer
Date:   Wed,  7 Sep 2022 11:00:59 +0900
Message-Id: <20220907020100.122588-1-mie@igel.co.jp>
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
Changes in v3:
* Remove duplicated logging and change to use dev_dbg().

Changes in v2:
* New patch
---
---
 drivers/misc/pci_endpoint_test.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..39d477bb0989 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -332,6 +332,17 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	return false;
 }
 
+static int pci_endpoint_test_validate_xfer_params(struct device *dev,
+		struct pci_endpoint_test_xfer_param *param, size_t alignment)
+{
+	if (param->size > SIZE_MAX - alignment) {
+		dev_dbg(dev, "Maximum transfer data size exceeded\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
@@ -363,9 +374,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err)
+		return false;
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -497,9 +510,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err)
+		return false;
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
@@ -595,9 +610,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 		return false;
 	}
 
+	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (err)
+		return false;
+
 	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
 	if (use_dma)
-- 
2.17.1

