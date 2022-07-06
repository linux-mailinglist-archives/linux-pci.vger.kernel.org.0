Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDD5692EC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 21:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiGFT6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 15:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiGFT6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 15:58:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5A17A81;
        Wed,  6 Jul 2022 12:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60921B81EB7;
        Wed,  6 Jul 2022 19:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67D1C3411C;
        Wed,  6 Jul 2022 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657137521;
        bh=oFb69u//HpNXjs5TOfyJYyYjVRtzdr/CioBwb3NZ9Zc=;
        h=From:To:Cc:Subject:Date:From;
        b=BeJcw5YXsXvkbIs8t58CCQJBd7hoze5weHIpdTtnB+IURKWXqHynzbDZBHb3goTUL
         3HdAlp1H1eDzu8lc/p0cla3/srRywizZ+c/3LAQ3YH0zIjAZdU8jsqoitDYtwgKpXk
         jKE6EjsKIFpTg20JIgdwHcvXtKR3Mmd6rp5QspyiAPR3lwjJKIbWoax0nMXeqlz882
         h5ji3gUA4kk4YoMREZDycJED2S+bgRMcVYFJuqX8Sk+Z4aM3GmG/xxPZrjbOb9Fp17
         0y/fmB+BhlMYlCT8Fvp8z4bp0dny/ZkpVEvZJOJfnZnDckQ3K+96Pkv0GStXTZ77VV
         WajNqVAvktuyA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Toan Le <toan@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Drop of_match_ptr() to avoid unused variables
Date:   Wed,  6 Jul 2022 14:58:38 -0500
Message-Id: <20220706195838.217054-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We have stubs for most OF interfaces even when CONFIG_OF is not set, so we
allow building of most controller drivers in that case for compile testing.

When CONFIG_OF is not set, "of_match_ptr(<match_table>)" compiles to NULL,
which leaves <match_table> unused, resulting in errors like this:

  $ make W=1
  drivers/pci/controller/pci-xgene.c:636:34: error: ‘xgene_pcie_match_table’ defined but not used [-Werror=unused-const-variable=]

Drop of_match_ptr() to avoid the unused variable warning.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-keystone.c   | 2 +-
 drivers/pci/controller/dwc/pcie-armada8k.c  | 2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c | 2 +-
 drivers/pci/controller/pci-xgene.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d10e5fd0f83c..602909f712b9 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1324,7 +1324,7 @@ static struct platform_driver ks_pcie_driver __refdata = {
 	.remove = __exit_p(ks_pcie_remove),
 	.driver = {
 		.name	= "keystone-pcie",
-		.of_match_table = of_match_ptr(ks_pcie_of_match),
+		.of_match_table = ks_pcie_of_match,
 	},
 };
 builtin_platform_driver(ks_pcie_driver);
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 4e2552dcf982..8391417fad41 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -343,7 +343,7 @@ static struct platform_driver armada8k_pcie_driver = {
 	.probe		= armada8k_pcie_probe,
 	.driver = {
 		.name	= "armada8k-pcie",
-		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
+		.of_match_table = armada8k_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 1569e82b5568..48af5170a8e7 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -258,7 +258,7 @@ static struct platform_driver spear13xx_pcie_driver = {
 	.probe		= spear13xx_pcie_probe,
 	.driver = {
 		.name	= "spear-pcie",
-		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+		.of_match_table = spear13xx_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index eb6240958bb0..549d3bd6d1c2 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -641,7 +641,7 @@ static const struct of_device_id xgene_pcie_match_table[] = {
 static struct platform_driver xgene_pcie_driver = {
 	.driver = {
 		.name = "xgene-pcie",
-		.of_match_table = of_match_ptr(xgene_pcie_match_table),
+		.of_match_table = xgene_pcie_match_table,
 		.suppress_bind_attrs = true,
 	},
 	.probe = xgene_pcie_probe,
-- 
2.25.1

