Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25182727EC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgIUOkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 10:40:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35485 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUOkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 10:40:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kKMzJ-0002tN-Ps; Mon, 21 Sep 2020 14:40:17 +0000
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
Subject: [PATCH][next] PCI: brcmstb: fix a missing if statement on a return error check
Date:   Mon, 21 Sep 2020 15:40:17 +0100
Message-Id: <20200921144017.334602-1-colin.king@canonical.com>
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
dead code. Fix this by adding in the missing if statement.

Addresses-Coverity: ("Structurally dead code")
Fixes: ad3d29c77e1e ("PCI: brcmstb: Add control of rescal reset")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7a3ff4632e7c..cb0c11b7308e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1154,6 +1154,7 @@ static int brcm_pcie_resume(struct device *dev)
 	clk_prepare_enable(pcie->clk);
 
 	ret = brcm_phy_start(pcie);
+	if (ret)
 		return ret;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-- 
2.27.0

