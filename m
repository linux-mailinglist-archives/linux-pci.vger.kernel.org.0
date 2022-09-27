Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306985EC5DC
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiI0OUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiI0OUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:20:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C41181CDB
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 168FFB81C01
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF85C433C1;
        Tue, 27 Sep 2022 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288389;
        bh=tSjcRHzwdwDzj8PfrZEsmRIyZScrpL96WWWx0UfyT9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fl9zj7S0WWn6d/YtEQT5wLM3hQQ5O3t5EFBLp8lVq24DBE+1A+5JeSMgFIuppGjha
         X0zTVWOlzPkS9AZuQzFPK26+bVSmzZMGtyWNWjWRV0rboP+rS1lQcyMWHbP7y0+euR
         zYD7rhXpDS63fEdrX7guKPCVINNsCSEq7GxS6Wcex+s/nMobyVoliWBuenFQ0ECJWH
         lnzkTtzwpV+pB2d37cNOpSGERdB1Q8zBlgVq29pyYwqVyGrojNRZJAGLX7n1KP0ge3
         7wpAgJWaIj1Vu3Xs4sCDsYCBGXQG8muL/wAN4zKVksw+MdEfuVWLySbQ5cOvIZopx3
         fwvWYGcv/BWTA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 09/10] PCI: aardvark: Explicitly disable Marvell strict ordering
Date:   Tue, 27 Sep 2022 16:19:25 +0200
Message-Id: <20220927141926.8895-10-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927141926.8895-1-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of implicitly disabling BIT(5) (STRICT_ORDER_ENABLE bit) of the
CORE_CTRL2 by writing PCIE_CORE_CTRL2_RESERVED |
PCIE_CORE_CTRL2_TD_ENABLE to it, disable it explicitly, with
read-modify-write.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e816ab726f66..73a604f70f06 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -600,8 +600,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
 
 	/* Program PCIe Control 2 to disable strict ordering */
-	reg = PCIE_CORE_CTRL2_RESERVED |
-		PCIE_CORE_CTRL2_TD_ENABLE;
+	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
+	reg &= ~PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
 	/* Set lane X1 */
-- 
2.35.1

