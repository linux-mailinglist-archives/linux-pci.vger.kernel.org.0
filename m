Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6E442025
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhKASjz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 14:39:55 -0400
Received: from finn.gateworks.com ([108.161.129.64]:59064 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232191AbhKASjs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 14:39:48 -0400
X-Greylist: delayed 1791 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 14:39:48 EDT
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mhbdt-007rRg-E2; Mon, 01 Nov 2021 18:02:45 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] PCI: imx: do not remap invalid res
Date:   Mon,  1 Nov 2021 11:02:43 -0700
Message-Id: <20211101180243.23761-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On imx6 and perhaps others when pcie probes you get a:
imx6q-pcie 33800000.pcie: invalid resource

This occurs because the atu is not specified in the DT and as such it
should not be remapped.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a945f0c0e73d..3254f60d1713 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -671,10 +671,11 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 		if (!pci->atu_base) {
 			struct resource *res =
 				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
-			if (res)
+			if (res) {
 				pci->atu_size = resource_size(res);
-			pci->atu_base = devm_ioremap_resource(dev, res);
-			if (IS_ERR(pci->atu_base))
+				pci->atu_base = devm_ioremap_resource(dev, res);
+			}
+			if (!pci->atu_base || IS_ERR(pci->atu_base))
 				pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 		}
 
-- 
2.17.1

