Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31C062CB71
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiKPUvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiKPUvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:51:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C963B87;
        Wed, 16 Nov 2022 12:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A92AB81EC1;
        Wed, 16 Nov 2022 20:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95817C433D6;
        Wed, 16 Nov 2022 20:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668631868;
        bh=m6/u2vgmMBuIIdm3mXwZ8M7e/kuC3+TOJ2k7xEqGPF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzKeuOjOZxzuqYLQfd4CmqiACVuym10CfQHY3frTCsUUDGehntk6guziLR4zMHr3j
         +LDx7TVtM+lmr3YKsHOHTycfkFFnBi7QL6dUJV9hopZvLOzG7tY6Aes7geVnsMrT4A
         4vS90YYFQsnTpgQe/50+yTHGrWdHY+M5Zoa6LUAK3IoGaIkc6u5zpiWktMH/a1yhUV
         n2lQlz1L2zlMgyhAAQn8wTL+mvySXUZ6Yw/HHj2b6SUub8uaSq8DHdQ+AHODumUSaf
         xyeOpWLRDA+6t7IU2dD+c7YnF14HUPIxeSdWMPuZ0W80sbfoY1+J12curKlUxVdG5L
         LiNvyu4/wWfiw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] PCI: Drop of_match_ptr() to avoid unused variables
Date:   Wed, 16 Nov 2022 14:50:59 -0600
Message-Id: <20221116205100.1136224-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116205100.1136224-1-helgaas@kernel.org>
References: <20221116205100.1136224-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Link: https://lore.kernel.org/r/20221025191339.667614-2-helgaas@kernel.org
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
index 784fcf35599c..ca44b0c83d1b 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -901,7 +901,7 @@ static const struct of_device_id v3_pci_of_match[] = {
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

