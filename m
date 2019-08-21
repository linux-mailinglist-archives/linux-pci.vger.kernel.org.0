Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C694C978BE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHUMB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 08:01:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51807 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHUMB2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 08:01:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i0PIq-0006W5-Lf; Wed, 21 Aug 2019 12:01:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: tegra: tegra194: fix phy_count less than zero check
Date:   Wed, 21 Aug 2019 13:01:23 +0100
Message-Id: <20190821120123.14223-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for pcie->phy_count < 0 is always false because phy_count
is an unsigned int and can never be less than zero. Fix this by
assigning ret to the return from of_property_count_strings and
checking if this is less than zero instead.

Addresses-Coverity: ("Dead code")
Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc0dbeb31d78..b47ea3e68303 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -969,12 +969,13 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return ret;
 	}
 
-	pcie->phy_count = of_property_count_strings(np, "phy-names");
-	if (pcie->phy_count < 0) {
+	ret = of_property_count_strings(np, "phy-names");
+	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to find PHY entries: %d\n",
-			pcie->phy_count);
-		return pcie->phy_count;
+			ret);
+		return ret;
 	}
+	pcie->phy_count = ret;
 
 	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
 		pcie->update_fc_fixup = true;
-- 
2.20.1

