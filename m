Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D091374836D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGELrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGELrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 07:47:46 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E7D1731;
        Wed,  5 Jul 2023 04:47:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="170615185"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2023 20:46:14 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 49309400C45B;
        Wed,  5 Jul 2023 20:46:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v17 19/20] MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
Date:   Wed,  5 Jul 2023 20:42:05 +0900
Message-Id: <20230705114206.3585188-20-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update this entry for R-Car Gen4's source code.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad33f391c103..6d2830a9223e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16264,6 +16264,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/*rcar*
 F:	drivers/pci/controller/*rcar*
+F:	drivers/pci/controller/dwc/*rcar*
 
 PCI DRIVER FOR SAMSUNG EXYNOS
 M:	Jingoo Han <jingoohan1@gmail.com>
-- 
2.25.1

