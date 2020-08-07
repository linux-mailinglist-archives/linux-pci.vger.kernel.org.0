Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8823EB7F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHGKZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 06:25:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:31578 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgHGKZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 06:25:35 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Aug 2020 19:25:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id A9134180BB5;
        Fri,  7 Aug 2020 19:25:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 7 Aug 2020 19:25:34 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 11D2C1A0507;
        Fri,  7 Aug 2020 19:25:34 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v6 5/6] PCI: uniphier: Add iATU register support
Date:   Fri,  7 Aug 2020 19:25:21 +0900
Message-Id: <1596795922-705-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
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
index 55a7166..93ef608 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -471,6 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->pci.dbi_base))
 		return PTR_ERR(priv->pci.dbi_base);
 
+	priv->pci.atu_base =
+		devm_platform_ioremap_resource_byname(pdev, "atu");
+	if (IS_ERR(priv->pci.atu_base))
+		priv->pci.atu_base = NULL;
+
 	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
-- 
2.7.4

