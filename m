Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF741A787D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438424AbgDNKex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 06:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438410AbgDNKe2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AE520857;
        Tue, 14 Apr 2020 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586859931;
        bh=7AnjB2puNCQx4Q9gGmOLxxCHf1XfRWpqRH6zopFpoVk=;
        h=From:To:Cc:Subject:Date:From;
        b=GQGO0/OM3WUST01CJFl44QRvJ8uVmMSy5LgxUUHU49aXdr0ZONt8V8eS1n7bwy29k
         YZNczl5EOFPVjMTk6gLCG9OAvgT+966N5eSCvCi1cEjrbOZFIpV1i6i2Mop7F983go
         TJlE8TxWUNFXI4TvyvlNA91Mdnf6q/nIXHKzeE28=
Received: by pali.im (Postfix)
        id A4E1E770; Tue, 14 Apr 2020 12:25:29 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: Fix reporting GPIO error value
Date:   Tue, 14 Apr 2020 12:25:12 +0200
Message-Id: <20200414102512.27506-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Error code is stored in rp->reset_gpio and not in err variable.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 0e03cef72840..378d5a8773c7 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2314,8 +2314,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
 				rp->reset_gpio = NULL;
 			} else {
-				dev_err(dev, "failed to get reset GPIO: %d\n",
-					err);
+				dev_err(dev, "failed to get reset GPIO: %ld\n",
+					PTR_ERR(rp->reset_gpio));
 				return PTR_ERR(rp->reset_gpio);
 			}
 		}
-- 
2.20.1

