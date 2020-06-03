Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB61ECC04
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgFCIyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 04:54:55 -0400
Received: from mx.socionext.com ([202.248.49.38]:18844 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFCIyy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 04:54:54 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Jun 2020 17:54:52 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 717B360057;
        Wed,  3 Jun 2020 17:54:52 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 3 Jun 2020 17:54:52 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 108B81A12AD;
        Wed,  3 Jun 2020 17:54:52 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 4/6] PCI: uniphier: Add iATU register support
Date:   Wed,  3 Jun 2020 17:54:39 +0900
Message-Id: <1591174481-13975-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This gets iATU register area from reg property. In Synopsys DWC version
4.80 or later, since iATU register area is separated from core register
area, this area is necessary to get from DT independently.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index a8dda39..ad14e67 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -447,6 +447,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->pci.dbi_base))
 		return PTR_ERR(priv->pci.dbi_base);
 
+	priv->pci.atu_base =
+		devm_platform_ioremap_resource_byname(pdev, "atu");
+	if (IS_ERR(priv->pci.atu_base))
+		priv->pci.atu_base = NULL;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
 	priv->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->base))
-- 
2.7.4

