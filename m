Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEA72A326
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjFITdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjFITdq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 15:33:46 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8B2D44;
        Fri,  9 Jun 2023 12:33:46 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33b3cfb9495so9284855ab.2;
        Fri, 09 Jun 2023 12:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686339225; x=1688931225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMoUuVCoy8iPi5l41BbPCFeIaC3DlfQ2sHoobxu0rd4=;
        b=ZtkZ3qDX+p1flp8mOZ5JocGwjrh9j8wWAmeMehGXb5lKuO0UjHWEP/BucywwG2QNCH
         Ll6OWk1RyzoQwvEcvS9edGerud6DeXl5U+rBKiRWjHPtyer2pivXBamWXw7NYE9Im+2w
         j/jUy4ftWPgfF5OF4nAl18xvYEtw91fPEZZouNUdCEEBqEJs/ORdWSmieFQqzBlUPlbX
         t3lYVp2fdaCpJBhEB/R/+fvwb3uGy2IwfRXNVhd9ZCtUjatKAoS5AvFRNTGtegrJH8y3
         UkyzMikfQdoUelESVU8qpmVI9dGexSW7FT4NtD1f8psPrKbDkwxzXxfkgfMC1j0eWYBx
         cSpA==
X-Gm-Message-State: AC+VfDwIt4Jumy+qGMroxheORktZRE9Z5wdYik6sjYmZ4LVVOHPuy5XU
        54DmxXqxbvN1rF353lUCqQq/Qicfjg==
X-Google-Smtp-Source: ACHHUZ4pduV4nm+kOOf2LCKJZuG86VPl6p4jzzFbmjKFwp6EFkNLZ/0POAfMsLj1enQS0YlNO+g2ng==
X-Received: by 2002:a92:c149:0:b0:338:c685:83d1 with SMTP id b9-20020a92c149000000b00338c68583d1mr2607823ilh.10.1686339225462;
        Fri, 09 Jun 2023 12:33:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i8-20020a056e02054800b003248469e5easm1264744ils.43.2023.06.09.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 12:33:44 -0700 (PDT)
Received: (nullmailer pid 1963853 invoked by uid 1000);
        Fri, 09 Jun 2023 19:33:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: iproc: Use of_property_read_bool() for boolean properties
Date:   Fri,  9 Jun 2023 13:33:25 -0600
Message-Id: <20230609193326.1963542-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Commit msg: s/to to/to/
---
 drivers/pci/controller/pcie-iproc-msi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index fee036b07cd4..649fcb449f34 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -525,7 +525,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 	if (!of_device_is_compatible(node, "brcm,iproc-msi"))
 		return -ENODEV;
 
-	if (!of_find_property(node, "msi-controller", NULL))
+	if (!of_property_read_bool(node, "msi-controller"))
 		return -ENODEV;
 
 	if (pcie->msi)
@@ -585,8 +585,7 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 		return -EINVAL;
 	}
 
-	if (of_find_property(node, "brcm,pcie-msi-inten", NULL))
-		msi->has_inten_reg = true;
+	msi->has_inten_reg = of_property_read_bool(node, "brcm,pcie-msi-inten");
 
 	msi->nr_msi_vecs = msi->nr_irqs * EQ_LEN;
 	msi->bitmap = devm_bitmap_zalloc(pcie->dev, msi->nr_msi_vecs,
-- 
2.39.2

