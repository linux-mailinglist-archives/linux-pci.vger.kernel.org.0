Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC06559C4F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiFXOj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiFXOj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:39:57 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1574D64783;
        Fri, 24 Jun 2022 07:39:57 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A2CA25BC5;
        Fri, 24 Jun 2022 17:41:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A2CA25BC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081673;
        bh=ORL4JApRjPpGjKJygzUfGiBMxpJLe/dPuqUMZiuGF94=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bSE8OQkBQhjxH0UAVq6ly5UMT+JUit/8eQ6ZhjxcSgHRz5NGeI+zOUl65b5aZr3l/
         zEWamh0GboEHyKsyN/LqBbePZWGA4kM7+Lx1TCOCrYZvxe9O9CQOU5cfIbmMcTD/m5
         B3fbYkvJ1px530z7rqd1WT8i1xRgJ36nhRGgnsQE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:39:54 +0300
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
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v4 02/15] PCI: dwc: Detect iATU settings after getting "addr_space" resource
Date:   Fri, 24 Jun 2022 17:39:34 +0300
Message-ID: <20220624143947.8991-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru>
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

The iATU detection procedure was introduced in the commit 281f1f99cf3a
("PCI: dwc: Detect number of iATU windows"). A bit later the procedure
execution was moved to Host/EP-specific methods in the framework of commit
8bcca2658558 ("PCI: dwc: Move iATU detection earlier"). The later
modification wasn't done in the most optimal way since the "addr_space"
CSR region resource doesn't depend on anything detected in the
dw_pcie_iatu_detect() method. Thus the detection can be postponed to be
executed after the resource request which can fail and make the detection
pointless. It will be also helpful for the dw_pcie_ep_init() method
readability since we are about to add the IP-core version and eDMA module
(a bit later) detection procedures.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v2:
- This is a new patch added on v2 iteration of the series.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 15b8059544e3..1e35542d6f72 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -704,8 +704,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		}
 	}
 
-	dw_pcie_iatu_detect(pci);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
 		return -EINVAL;
@@ -713,6 +711,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	dw_pcie_iatu_detect(pci);
+
 	ep->ib_window_map = devm_kcalloc(dev,
 					 BITS_TO_LONGS(pci->num_ib_windows),
 					 sizeof(long),
-- 
2.35.1

