Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE7613A4A
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 16:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiJaPkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiJaPkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 11:40:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB662659C;
        Mon, 31 Oct 2022 08:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69F25B818F0;
        Mon, 31 Oct 2022 15:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD48C433D6;
        Mon, 31 Oct 2022 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230804;
        bh=Ry1yPEx/VrNVXc5mpZkvv9i5ZTht3Zoh5muiCVNjxzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oy/IOnLMkbQ7kxnquoU/2edARkafOXHPiIJq2OqrpQkGiZgvJexhCdpjG37prwLLg
         NDs1zg8tIRJwDr4H2monx6M6P8WUjH2T7eQqaJdK09Xcd2VfnZuWzcImqEgbPl1epE
         wtcqpp0KKL8gbtORGYeoBMBfhHw3ZZyLXzvEEPVY8v8P1GgOvMBS+UX3sP9ySSwaLm
         NsOrv2PW/Mhv9f+24QK03QLBoS7u+WNhKL9A5ps0SHLGjArc22j4hUnA4LCWzgwVhf
         yKkEneeNNyULguuHRvrB6p0UvlVwEimpyZJT6DK5dETWRXrdNtSTaeacaQ/l6qRItH
         2vzfLen3Rxu9g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/5] PCI: microchip: Include <linux/irqdomain.h> explicitly
Date:   Mon, 31 Oct 2022 10:39:51 -0500
Message-Id: <20221031153954.1163623-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031153954.1163623-1-helgaas@kernel.org>
References: <20221031153954.1163623-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie-microchip-host.c uses irq_domain_add_linear() and related interfaces,
so it needs <linux/irqdomain.h> but doesn't include it directly; it relies
on the fact that <linux/of_irq.h> includes it.

But pcie-microchip-host.c *doesn't* need <linux/of_irq.h> itself.  Include
<linux/irqdomain.h> directly to remove this implicit dependency so a future
patch can drop <linux/of_irq.h>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 7263d175b5ad..57b2a62f52c8 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
-- 
2.25.1

