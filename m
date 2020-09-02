Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5621B25AD8E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgIBOor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 10:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgIBOo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 10:44:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1EA207D3;
        Wed,  2 Sep 2020 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599057849;
        bh=RQyeMBvVYEEripIxkiwgkQx2PRZzYyZmQJQeA0zGmCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFBlBkylysDA5Gjy5urP0SICWfH8AVxqvI6GX+AXUDd8IpE4KejLBKAn26gGLIQ1F
         NDmaCMReKZJM83VcSFXdS86Ww0BNsVQNvJ43si+T2k2UxS7umuaXERW+Sr+hIfKqMS
         KKSHClVO8CLCUchMTXOkXxKwspeB13acPmhCah5w=
Received: by pali.im (Postfix)
        id 16C4CF3C; Wed,  2 Sep 2020 16:44:07 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: aardvark: Fix initialization with old Marvell's Arm Trusted Firmware
Date:   Wed,  2 Sep 2020 16:43:44 +0200
Message-Id: <20200902144344.16684-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200902144344.16684-1-pali@kernel.org>
References: <20200902144344.16684-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Old ATF automatically power on pcie phy and does not provide SMC call for
phy power on functionality which leads to aardvark initialization failure:

[    0.330134] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
[    0.338846] phy phy-d0018300.phy.1: phy poweron failed --> -95
[    0.344753] advk-pcie d0070000.pcie: Failed to initialize PHY (-95)
[    0.351160] advk-pcie: probe of d0070000.pcie failed with error -95

This patch fixes above failure by ignoring 'not supported' error in
aardvark driver. In this case it is expected that phy is already power on.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 366697018c9a ("PCI: aardvark: Add PHY support")
---
 drivers/pci/controller/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c5d1bb3d52e4..e1a80c35c73d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1108,7 +1108,9 @@ static int advk_pcie_enable_phy(struct advk_pcie *pcie)
 	}
 
 	ret = phy_power_on(pcie->phy);
-	if (ret) {
+	if (ret == -EOPNOTSUPP) {
+		dev_warn(&pcie->pdev->dev, "PHY unsupported by firmware\n");
+	} else if (ret) {
 		phy_exit(pcie->phy);
 		return ret;
 	}
-- 
2.20.1

