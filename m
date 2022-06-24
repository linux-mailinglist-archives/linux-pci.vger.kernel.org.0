Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95339559C0A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiFXOgK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiFXOfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:35:34 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5BBA50E33;
        Fri, 24 Jun 2022 07:35:06 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A4F3C5BC8;
        Fri, 24 Jun 2022 17:36:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A4F3C5BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081366;
        bh=yyLGqAfosjNG2N3uj4bhe6vnwjhYx7OPkHB6etb2CBQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FJ662NofYwtq5kW3NR0UPtBh/X3irWG5jcVGWNYtKt2pxIR47Ns/grkBdwSX4qKrW
         Oix3tSLP18DlXiPRQHx763aQdpWWHYDuMRlvwHFom0E+akTjPfW+p0aU/Bgim+AOd1
         1KtC0dlhz07K+ikYIZh597mysYTL4sMlV5sGhmXA=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:46 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 17/18] PCI: dwc-plat: Discard unused regmap pointer
Date:   Fri, 24 Jun 2022 17:34:27 +0300
Message-ID: <20220624143428.8334-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

