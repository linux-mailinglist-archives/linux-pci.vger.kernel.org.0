Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE42734AD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 23:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUVQB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 17:16:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47007 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgIUVQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 17:16:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kKTAB-0003av-N2; Mon, 21 Sep 2020 21:15:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] PCI: brcmstb: fix a missing if statement on a return error check
Date:   Mon, 21 Sep 2020 22:15:55 +0100
Message-Id: <20200921211555.383458-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error return ret is not being check with an if statement and
currently the code always returns leaving the following code as
dead code. Fix this by adding in the missing if statement and
clean up with the clk_disable_unprepare call.

Kudos to Florian Fainelli for noting that the clock needed disabling.

Addresses-Coverity: ("Structurally dead code")
Fixes: ad3d29c77e1e ("PCI: brcmstb: Add control of rescal reset")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: disable clock as noted by Florian Fainelli and suggested by
    Jim Quinlan.
---
 drivers/pci/controller/pcie-brcmstb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7a3ff4632e7c..25f46f87b36f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1154,7 +1154,10 @@ static int brcm_pcie_resume(struct device *dev)
 	clk_prepare_enable(pcie->clk);
 
 	ret = brcm_phy_start(pcie);
+	if (ret) {
+		clk_disable_unprepare(pcie->clk);
 		return ret;
+	}
 
 	/* Take bridge out of reset so we can access the SERDES reg */
 	pcie->bridge_sw_init_set(pcie, 0);
-- 
2.27.0

