Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9512E5984D2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbiHRNwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbiHRNwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE761B28
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E6661615
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003EFC433B5;
        Thu, 18 Aug 2022 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830724;
        bh=tSjcRHzwdwDzj8PfrZEsmRIyZScrpL96WWWx0UfyT9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=csGn5pEa56RauNN1l07VvOwdgMijpg+cXax+BegtJH73GQ+fK/IX046x+/f4V3jyf
         14zwznu5vwWZ7TZFqnw0xbRfcpSsy7BxAiKvYOvlDb0/de1ErksgPZnEODLvcf47SK
         uGkTIk5gzxZgmKaISdYmRPo6LLyveR82/Z2IZLdLx54P35bt1o/HVLDayzFflK2ivG
         Fjc4ix7bSAFM41XyL8NUWHRmEeGgynj1f1A4QiT1ROGoiLga0QbfVvhkSy3+cuzT/c
         pnSmSEjPGqq3IK64ml653K6Un3Trh4DO3IGQ+324pSSs1ciDfr/Rg+BAkt5WseWzqu
         xecQbZYHZAqoA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 10/11] PCI: aardvark: Explicitly disable Marvell strict ordering
Date:   Thu, 18 Aug 2022 15:51:39 +0200
Message-Id: <20220818135140.5996-11-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

