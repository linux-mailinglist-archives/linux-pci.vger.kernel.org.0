Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDF54D50E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357201AbiFOXRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355677AbiFOXQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F8393F4;
        Wed, 15 Jun 2022 16:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85D61B81C66;
        Wed, 15 Jun 2022 23:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6C6C3411A;
        Wed, 15 Jun 2022 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334990;
        bh=qmixXl4n20cUaihLKiCP4FjnpbNs9/9/CtTDaEdLVsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGQkDnwdDQtDH1N6PcBLB4fpHzPR2/On8gbcPj2NhcvTGk+ef/F9pu/sUp/FmBaIN
         6JOYX0TnW14heXNYxsnxUbmMbSB07x2LMIcPUtQACz3zQG+vnL72am625fsmkI1nJK
         k3xG0FOPPnm6DoqRceTUK83ALsh8hw82dq83rULL7apz5nYhH+pmUmWT1gNrDfXytC
         eH8Cuxo3ktaZHAVGD8kdoBwJYZH7UHDeTPVwzJN4O0zGXvka53eaB2VfoxJ/pABe3+
         N0TVMmVW+wdGn53tM4TDOr/b35DvTho8V4z144qEy6Fu5+t4dgAC8fX6EXn3Usnfb/
         /sE7hD+f3iEsA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 13/13] PCI: imx6: Disable clocks in reverse order of enable
Date:   Wed, 15 Jun 2022 18:15:51 -0500
Message-Id: <20220615231551.1054753-14-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615231551.1054753-1-helgaas@kernel.org>
References: <20220615231551.1054753-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

imx6_pcie_clk_enable() enables clocks in the order:

  pcie_phy
  pcie_bus
  pcie
  imx6_pcie_enable_ref_clk

Change imx6_pcie_clk_disable() to disable them in the reverse order.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bd736aff94a3..738b5a732cef 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -655,10 +655,10 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
 	imx6_pcie_disable_ref_clk(imx6_pcie);
+	clk_disable_unprepare(imx6_pcie->pcie);
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
-- 
2.25.1

