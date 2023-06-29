Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2DD742AEA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjF2RAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjF2RAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 13:00:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135263588
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 10:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89EC6615A0
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 17:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF10C433C0;
        Thu, 29 Jun 2023 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688058001;
        bh=+L4Ij4wrOLbQ96O/FTu1MsLp0W4gkxcKZWK0acwmpS0=;
        h=From:To:Cc:Subject:Date:From;
        b=MoXbH0bE6di+C5UwzqeyctmCs7co1wTv2/KtomUNC/fC9yUdGAPwseRlgW5d23hWE
         plF0wyxsCMm+621H7Q4FLFBJLVTuDGEexWwSPPLLAGzqYCBnM4cM2eq8r9iBUclwJH
         o0HkzQ6jEn8kfICJXfqaXfcnWWFlFuBJiCH/cxOsiCHaVpLooPfGLnERka3fbki7JK
         IQsY4jD4TIlWo97Cu1MVuX4wZnT49xoOHFddGroHI6vuihy3y5IGqYnrgZZLYZ6buN
         PyjzETzJxip3GlZmarkpZZR+zLSu9uRz9TQdQ6C33nzlnSHf68zJyASxgS52ZD0uCy
         fvRvmYU5sLo1w==
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
Subject: [PATCH 1/3] PCI: meson: Remove cast between incompatible function type
Date:   Thu, 29 Jun 2023 16:59:54 +0000
Message-ID: <20230629165956.237832-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.41.0
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

  drivers/pci/controller/dwc/pci-meson.c:191:6: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
                                   (void (*) (void *))clk_disable_unprepare,
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
No functional changes are intended.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index c1527693bed9..34990a6363d0 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -163,6 +163,13 @@ static int meson_pcie_reset(struct meson_pcie *mp)
 	return 0;
 }
 
+static inline void meson_pcie_disable_clock(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static inline struct clk *meson_pcie_probe_clock(struct device *dev,
 						 const char *id, u64 rate)
 {
@@ -187,9 +194,7 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
 		return ERR_PTR(ret);
 	}
 
-	devm_add_action_or_reset(dev,
-				 (void (*) (void *))clk_disable_unprepare,
-				 clk);
+	devm_add_action_or_reset(dev, meson_pcie_disable_clock, clk);
 
 	return clk;
 }
-- 
2.41.0

