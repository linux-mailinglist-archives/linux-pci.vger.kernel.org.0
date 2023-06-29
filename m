Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A0742AEB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2RAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjF2RAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 13:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECEE2D4C
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 10:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD4E615A8
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 17:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56124C433CB;
        Thu, 29 Jun 2023 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688058003;
        bh=HEnFcC/moYFnoPxBY2BVOmQpDQ1kN+hXUcu13kg/9xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMiUThPtt9QAVsqDXwBF4//tBZBsxF9cv8K24qAnQBF1YPPr2BkybozUVl+avaJRN
         udUNE/uWoNH0W9u0vh6Pe1s6DRUYBaZofTLVKRbwBm4aGhAuszASWydvu4jqs5TrX5
         Rg2/xKVIGWlyUJ+Pm9OWZ7vsWian4pSnl2/NdwzLcvDkUjr9MlSFv2e+O5pc9k1eqS
         BM4I7iEjRdL3AlpYI3d8zXaM3thEfoLDsELu6TNj1+wsae1ytO/H+FaWbqcr1+tegT
         6xOperToL6lTnjq2HCdi5ek/XcR6N93xhMn/IeTCw7/TpU7FMaf0C4uNlWacQBLFQ5
         nONfrPP1e+0Tw==
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
Subject: [PATCH 2/3] PCI: keembay: Remove cast between incompatible function type
Date:   Thu, 29 Jun 2023 16:59:55 +0000
Message-ID: <20230629165956.237832-2-kwilczynski@kernel.org>
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

  drivers/pci/controller/dwc/pcie-keembay.c:172:12: warning: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
                                         (void(*)(void *))clk_disable_unprepare,
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
No functional changes are intended.

Fixes: 0c87f90b4c13 ("PCI: keembay: Add support for Intel Keem Bay")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/controller/dwc/pcie-keembay.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index f90f36bac018..289bff99d762 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -148,6 +148,13 @@ static const struct dw_pcie_ops keembay_pcie_ops = {
 	.stop_link	= keembay_pcie_stop_link,
 };
 
+static inline void keembay_pcie_disable_clock(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static inline struct clk *keembay_pcie_probe_clock(struct device *dev,
 						   const char *id, u64 rate)
 {
@@ -168,9 +175,7 @@ static inline struct clk *keembay_pcie_probe_clock(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       clk);
+	ret = devm_add_action_or_reset(dev, keembay_pcie_disable_clock, clk);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.41.0

