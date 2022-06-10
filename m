Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A2545F0C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347604AbiFJI3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbiFJI1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:50 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 928A1B1CA;
        Fri, 10 Jun 2022 01:26:15 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id F26CF16A5;
        Fri, 10 Jun 2022 11:26:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com F26CF16A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849603;
        bh=a+O6XktN6lzFP6/aqF4Pl/mH17U2GaI3O4WvtLp9nSU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=X/sWxL0ahzZiCHw4dNTodpgOgQsMNENjR6Jn4DjkRqHZMKi7livyqqoyH9xI3y6k7
         OOY/kItshhCehL+0zF3FpuJ60uFLkZs48oFUseliEHfjcNOlrVhpZGZp8tBaQd02aL
         XrFY36nWchTAhAHdtHz/ecS/cgwrNMWr2WBDhxQM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:51 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 17/18] PCI: dwc-plat: Discard unused regmap pointer
Date:   Fri, 10 Jun 2022 11:25:33 +0300
Message-ID: <20220610082535.12802-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The regmap pointer was added into the dw_plat_pcie structure in
commit 1d906b22076e ("PCI: dwc: Add support for EP mode"), but it hasn't
been utilized neither in the code submitted in the denoted so far nor in
the platform driver evolving afterwards. Drop it then for good.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index c6871bebf3fe..59bd85d4190b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -17,13 +17,11 @@
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/types.h>
-#include <linux/regmap.h>
 
 #include "pcie-designware.h"
 
 struct dw_plat_pcie {
 	struct dw_pcie			*pci;
-	struct regmap			*regmap;
 	enum dw_pcie_device_mode	mode;
 };
 
-- 
2.35.1

