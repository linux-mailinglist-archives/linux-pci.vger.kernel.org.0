Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7151903B
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiECV1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbiECV1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:27:23 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 364E34163F;
        Tue,  3 May 2022 14:23:37 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 46BD416D6;
        Wed,  4 May 2022 00:24:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 46BD416D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651613051;
        bh=DWfIhQOlThJ6h1HtDk1Jv4zywOs8e0bFpuSN9WfYfs4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ST3CBNxFw9aKNHigL70CVKAAZkG4CdoQaJMJc6T0DJSLXLNOrBVwOP8dHwr+cLyAC
         heGM1J622OyyK8/NYUFKfCiS8pel1ff1ayjRB3ng8+PhE9cQOA79OsuW/jheA/GeBv
         bEiaIv+ASl2q4UhGMoZDvu1aaoTaDC5JdfqdbGLs=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:23:37 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/13] PCI: dwc-plat: Discard unused regmap pointer
Date:   Wed, 4 May 2022 00:22:59 +0300
Message-ID: <20220503212300.30105-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
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
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index fea785096261..99cf2ac5b0ba 100644
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

