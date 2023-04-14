Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A66E1C7F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 08:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDNGQt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDNGQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 02:16:40 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD6EA6A42;
        Thu, 13 Apr 2023 23:16:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,195,1677510000"; 
   d="scan'208";a="155958255"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Apr 2023 15:16:33 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CBC094195D7C;
        Fri, 14 Apr 2023 15:16:33 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v12 18/19] MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
Date:   Fri, 14 Apr 2023 15:16:21 +0900
Message-Id: <20230414061622.2930995-19-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update this entry for R-Car Gen4's source code.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b971f520e93..e8263a451182 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16157,6 +16157,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/*rcar*
 F:	drivers/pci/controller/*rcar*
+F:	drivers/pci/controller/dwc/*rcar*
 
 PCI DRIVER FOR SAMSUNG EXYNOS
 M:	Jingoo Han <jingoohan1@gmail.com>
-- 
2.25.1

