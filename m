Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36127742AEC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjF2RAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjF2RAI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 13:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEDC2D4C
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 10:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E086F615A8
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 17:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094FAC433C0;
        Thu, 29 Jun 2023 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688058006;
        bh=ekZJhfEVqtyX3t+uLKmzRW38MPCUXcmlO89VvVdAQak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5AbPL2HVz3TeQmXq1zjjfnu71OYU8djIbs5/c9qxDEwhZz5jhwcajuZCLWcAf1YG
         6UjtkyusIMkEn35B9ID+o4wyUfD8Syj+nTCcdyoT9PQH/x1xQozB7BY/9ggREkIa5m
         +vNMH+Blw10Ll3L+bBoLHUYfDeYOU98PCKzQpa6bfVEzt/EjOBjHHgC8AhqBbezmw2
         vAywnOuyOp1lKkttmawODM3OHQ5RDeMx89L7jc2xW12syxhI21c7HiqbxdSsS5t0nc
         cFRf2sMLMCraOSx/SFj5Kv2mSMq66XzgB4jZUanmp4mfQ2KMcF9CpX4PvfGzmz9voT
         Vgm+m5Gfg9BLg==
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To:     "Bjorn Helgaas" <bhelgaas@google.com>
Cc:     "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Rob Herring" <robh@kernel.org>, "Yue Wang" <yue.wang@Amlogic.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        "Srikanth Thokala" <srikanth.thokala@intel.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        "Conor Dooley" <conor.dooley@microchip.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] PCI: microchip: Remove cast between incompatible function type
Date:   Thu, 29 Jun 2023 16:59:56 +0000
Message-ID: <20230629165956.237832-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629165956.237832-1-kwilczynski@kernel.org>
References: <20230629165956.237832-1-kwilczynski@kernel.org>
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

Rather than casting void(*)(struct clk *) to void (*)(void *), that
forces conversion to an incompatible function type, replace the cast
with a small local stub function with a signature that matches what
the devm_add_action_or_reset() function expects.

The sub function takes a void *, then passes it directly to
clk_disable_unprepare(), which handles the more specific type.

Reported by clang when building with warnings enabled:

  drivers/pci/controller/pcie-microchip-host.c:866:32: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
          devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
No functional changes are intended.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Co-developed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Co-developed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/controller/pcie-microchip-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 5e710e485464..d30286f815e7 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -848,6 +848,13 @@ static const struct irq_domain_ops event_domain_ops = {
 	.map = mc_pcie_event_map,
 };
 
+static inline void mc_pcie_deinit_clk(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
 {
 	struct clk *clk;
@@ -863,8 +870,7 @@ static inline struct clk *mc_pcie_init_clk(struct device *dev, const char *id)
 	if (ret)
 		return ERR_PTR(ret);
 
-	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare,
-				 clk);
+	devm_add_action_or_reset(dev, mc_pcie_deinit_clk, clk);
 
 	return clk;
 }
-- 
2.41.0

