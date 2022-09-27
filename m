Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5535EC5DB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiI0OU0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiI0OUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD127EA5B9
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDFB4B81C16
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2009DC43148;
        Tue, 27 Sep 2022 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288387;
        bh=HbKz24Nfhn6/cZiuUPLYNM9zdj4uhadCwjvhLdFM3nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxEzqxdtFCb6omMCyPw8bzBExgzYn0H+DQjIqminL2P4SAwpZVSdVJw81CMA+6eiz
         roq9zq+Euv4aF/ZkRbPLb7reGIloFli0Hk70SZj7P2rRatHNeTgmOenWNb4EAbPXGo
         ly/zfo3U6Y2yp5J0qFMFp4k3/zd0HYV160h0yy+x/6G1xeWIonZj7bovr/ISFG8Nmn
         VQ97B0vwXZEr7h8ANvSMD+Qb+OrcEdIBCRYZSrKPKO2Gg6bcrTdqSkR333OcurUixq
         fxn9PhwTCLEXVuKAwoF6B27RgarGj77s6L42NHom55bsPVdK6Q8gH3zubyxV76ZK7T
         SBxCbASKA925g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 08/10] PCI: aardvark: Don't write read-only bits explicitly in PCI_ERR_CAP register
Date:   Tue, 27 Sep 2022 16:19:24 +0200
Message-Id: <20220927141926.8895-9-kabel@kernel.org>
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

