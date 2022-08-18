Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175975984D3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbiHRNwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiHRNwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:52:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F06170F
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1508B82179
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207B4C433C1;
        Thu, 18 Aug 2022 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830722;
        bh=HbKz24Nfhn6/cZiuUPLYNM9zdj4uhadCwjvhLdFM3nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIj9yTawYe15eFIn/SasT5q9CtieZbV3xFGVfraiKRr3ohpvteKHYHl2RCpla0N3Q
         evprTZZW/rOqaFTkz1/BUl4ydzNeMZcECjvQJWOtd6TTEshExtzpPOim2/rltHX4bj
         E0+kxqlyFEkj2j1ut/1wFvvsd/AIXNtC1sNC0PXbdDco/K7mNdmutgZ+4YjnxSty2q
         +ZtrLRZDXajllxWjGbHqVyKbLdFyxyAR/35bxxP1JGmNIxmT6pSeQT7IREIXunvo/O
         EPXBuKeugFWXxnqJKaRZX5NVDKIk0tcgfbDiFlXk56x4p59x/vX2sNxEW9tgAsKXXO
         zV2xV9b7/fiAg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 09/11] PCI: aardvark: Don't write read-only bits explicitly in PCI_ERR_CAP register
Date:   Thu, 18 Aug 2022 15:51:38 +0200
Message-Id: <20220818135140.5996-10-kabel@kernel.org>
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

The bits PCI_ERR_CAP_ECRC_GENC and PCI_ERR_CAP_ECRC_CHKC are read only,
reporting the capability of ECRC. Don't write them explicitly, instead
read the register (where they are set), and add the bits that enable
these features.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 4855ac733484..e816ab726f66 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -584,9 +584,9 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
 	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
 
-	/* Set Advanced Error Capabilities and Control PF0 register */
-	reg = PCI_ERR_CAP_ECRC_GENC | PCI_ERR_CAP_ECRC_GENE |
-	      PCI_ERR_CAP_ECRC_CHKC | PCI_ERR_CAP_ECRC_CHKE;
+	/* Enable generation and checking of ECRC on Root Bridge */
+	reg = advk_readl(pcie, PCIE_CORE_PCIERR_CAP + PCI_ERR_CAP);
+	reg |= PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE;
 	advk_writel(pcie, reg, PCIE_CORE_PCIERR_CAP + PCI_ERR_CAP);
 
 	/* Set PCIe Device Control register */
-- 
2.35.1

