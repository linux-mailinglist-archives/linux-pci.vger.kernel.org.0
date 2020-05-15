Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEEB1D44F0
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 06:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgEOEsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 00:48:43 -0400
Received: from mx.socionext.com ([202.248.49.38]:25919 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgEOEsk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 00:48:40 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 May 2020 13:48:38 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 0F34B180B60;
        Fri, 15 May 2020 13:48:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 May 2020 13:48:39 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 679341A0E67;
        Fri, 15 May 2020 13:48:38 +0900 (JST)
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
Subject: [PATCH 5/5] PCI: uniphier: Add error message when failed to get phy
Date:   Fri, 15 May 2020 13:48:25 +0900
Message-Id: <1589518105-18368-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589518105-18368-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1589518105-18368-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Even if phy driver doesn't probe, the error message can't be
distinguished from other errors. This displays error message
caused by the phy driver explicitly.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 6180d50..2bcf394 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -480,8 +480,10 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->rst);
 
 	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
-	if (IS_ERR(priv->phy))
+	if (IS_ERR(priv->phy)) {
+		dev_err(dev, "Failed to get phy (%d)\n", PTR_ERR(priv->phy));
 		return PTR_ERR(priv->phy);
+	}
 
 	platform_set_drvdata(pdev, priv);
 
-- 
2.7.4

