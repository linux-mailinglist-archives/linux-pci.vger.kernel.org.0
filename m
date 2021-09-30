Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114541DA41
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbhI3Mwv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 08:52:51 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:20081 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351051AbhI3Mwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 08:52:51 -0400
X-IronPort-AV: E=Sophos;i="5.85,336,1624312800"; 
   d="scan'208";a="19801620"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 Sep 2021 14:51:07 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 30 Sep 2021 14:51:07 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 30 Sep 2021 14:51:07 +0200
X-IronPort-AV: E=Sophos;i="5.85,336,1624312800"; 
   d="scan'208";a="19801619"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Sep 2021 14:51:07 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6C30B280065;
        Thu, 30 Sep 2021 14:51:07 +0200 (CEST)
From:   Alexander Stein <Alexander.Stein@tq-systems.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/1] PCI: imx6: Fix device probe without link
Date:   Thu, 30 Sep 2021 14:51:01 +0200
Message-Id: <20210930125101.1307751-1-Alexander.Stein@tq-systems.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

If there is no link up during probe -TIMEDOUT will be propagated up and
probing finally fails with -110.
This is contradicts to what commit 886a9c134755 ("PCI: dwc: Move link
handling into common code") says.

Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
These are the kernel messages from an imx8mx based board. Linux is
v5.15-rc3.

imx6q-pcie 33c00000.pcie: host bridge /soc@0/pcie@33c00000 ranges:
imx6q-pcie 33c00000.pcie:   No bus range found for /soc@0/pcie@33c00000, using [bus 00-ff]
imx6q-pcie 33c00000.pcie:       IO 0x0027f80000..0x0027f8ffff -> 0x0000000000
imx6q-pcie 33c00000.pcie:      MEM 0x0020000000..0x0027efffff -> 0x0020000000
imx6q-pcie 33c00000.pcie: invalid resource
imx6q-pcie 33c00000.pcie: iATU unroll: enabled
imx6q-pcie 33c00000.pcie: Detected iATU regions: 4 outbound, 4 inbound
imx6q-pcie 33c00000.pcie: Phy link never came up
imx6q-pcie: probe of 33c00000.pcie failed with error -110

The old code before 886a9c134755 ignored the return code of
imx6_pcie_establish_link() (now imx6_pcie_start_link()) during host_init. Since
that commit the return value of start_link() causes dw_pcie_host_init() to
fail.
This is an RFC as I'm unsure what is the correct behavior and with this
change the dev_info() in imx6_pcie_resume_noirq() is dead code.

 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..b45affeb23f5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -780,8 +780,10 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	imx6_pcie_ltssm_enable(dev);
 
 	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
+	if (ret) {
+		ret = 0;
 		goto err_reset_phy;
+	}
 
 	if (pci->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-- 
2.25.1

