Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3999760D462
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiJYTNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYTNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 15:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E7BBE3F;
        Tue, 25 Oct 2022 12:13:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF96761AFD;
        Tue, 25 Oct 2022 19:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25457C433C1;
        Tue, 25 Oct 2022 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666725227;
        bh=AdyKWW3kGsGFXnVfnmHp1ENXlUnPRsBFMxwcFLjmBrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hk/xayVVcKCpHaAzHXbaviYa6so4a/D3kV4UKD/14yg2QgkhwqQf3ZSwDlv7OWxsF
         pEQD2XT0EKxPtHgbfbjgznJNg5Zs/VwXrHjQnTC+Ntg+6aquFUqES3q0/xu136WYW+
         GS0vljuz32rwaBQMR8l0AtbVomECjXfTx9q0DTYzf9sEZPU03P3xuzmkyKo1RLwuhv
         yoIHjwl8th4X0rnz3v4HlP9SXtu2Avyo3xoLciZl/3D+ZGy1LPzCHJK4XV/SwGIpYC
         sP1RusB8B8hLxUOqD0d8HCG8FM+GtbKw7SZU69lG/WXtsDy1KcOGKbcLCGjBTAmEa1
         XZdx9Q4pyPyCQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: Drop of_match_ptr() to avoid unused variables
Date:   Tue, 25 Oct 2022 14:13:38 -0500
Message-Id: <20221025191339.667614-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025191339.667614-1-helgaas@kernel.org>
References: <20221025191339.667614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

See also 1dff012f636d ("PCI: Drop of_match_ptr() to avoid unused
variables").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pci-ftpci100.c | 2 +-
 drivers/pci/controller/pci-v3-semi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 0cfd9d5a497c..ecd3009df586 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -553,7 +553,7 @@ static const struct of_device_id faraday_pci_of_match[] = {
 static struct platform_driver faraday_pci_driver = {
 	.driver = {
 		.name = "ftpci100",
-		.of_match_table = of_match_ptr(faraday_pci_of_match),
+		.of_match_table = faraday_pci_of_match,
 		.suppress_bind_attrs = true,
 	},
 	.probe  = faraday_pci_probe,
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 154a5398633c..d1f9ee4a1ede 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -902,7 +902,7 @@ static const struct of_device_id v3_pci_of_match[] = {
 static struct platform_driver v3_pci_driver = {
 	.driver = {
 		.name = "pci-v3-semi",
-		.of_match_table = of_match_ptr(v3_pci_of_match),
+		.of_match_table = v3_pci_of_match,
 		.suppress_bind_attrs = true,
 	},
 	.probe  = v3_pci_probe,
-- 
2.25.1

