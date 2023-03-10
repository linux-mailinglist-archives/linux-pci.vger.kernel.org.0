Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B482D6B47A8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjCJOxD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 09:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjCJOwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 09:52:31 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D410D320;
        Fri, 10 Mar 2023 06:48:58 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso3047081otr.5;
        Fri, 10 Mar 2023 06:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uh2zryUkVS9JH/QLtNCRYYvxt5QfZNmyGLsJzwETiPA=;
        b=ux0GFXVTzbCOdDorY+NWELTYrIDiZhtHMhnHp8Y/tSZzsNHY69AagMCTADpsETNzBb
         broerF+Ig2Ymh0C8DjwiL9lWtGJ0pUYeHjSVPPDtZ6EMveCTjg1QWaaZ40JYu+AvlcoY
         fZVp9OESxbLdJL2HTu9exDq+jyFxRXExwf6FWNNoDOtQxiz82B+700KE5g0PGFXQtsxp
         rekN35erXEoDxNvAiaCluohS+6fV/+WL6BIKWrVlrucBRrt6M8p1gONiSgcqlUy3nscU
         trevAPZwlrrAdT5GCNveu0U0Kxybsv9i5F4OEJEUc+T1+ANAqbZSh4T3dE82/sAZz4wr
         U9Dg==
X-Gm-Message-State: AO0yUKV/4WEzxGXG7HlcxMLr1/8Y+RhHr40wXhuF60L/DWSLpVdxw7Hg
        eCVOGI+dsnxuIomr0Fhk4SIaVr3Tpw==
X-Google-Smtp-Source: AK7set/AI2jpctLr/vDtjPcpG63rmnfkLhITd/XYQW/Dp2aBtAkDBQvwBtBBs175QmuTl8wItwS5lQ==
X-Received: by 2002:a05:6830:82a:b0:68b:dd5a:d99b with SMTP id t10-20020a056830082a00b0068bdd5ad99bmr13888196ots.31.1678459693800;
        Fri, 10 Mar 2023 06:48:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0845000000b00690f6d9a737sm135299oty.8.2023.03.10.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:13 -0800 (PST)
Received: (nullmailer pid 1544557 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: iproc: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:19 -0600
Message-Id: <20230310144720.1544531-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
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

