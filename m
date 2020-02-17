Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388011610E6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBQLRV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 06:17:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbgBQLRV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Feb 2020 06:17:21 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D9DB24020B379EB5A77B;
        Mon, 17 Feb 2020 19:17:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Feb 2020 19:17:05 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v4 05/10] PCI: brcmstb: Use pcie_link_speed[] to decode link speed
Date:   Mon, 17 Feb 2020 19:12:59 +0800
Message-ID: <1581937984-40353-6-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1581937984-40353-1-git-send-email-yangyicong@hisilicon.com>
References: <1581937984-40353-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_link_speed[] is used to decode link speed from link
capability register. Use it in brcm_pcie_setup() to display
the link speed rather than using the offset.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d20aabc..a390a29 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -824,7 +824,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
 	nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 	dev_info(dev, "link up, %s x%u %s\n",
-		 PCIE_SPEED2STR(cls + PCI_SPEED_133MHz_PCIX_533),
+		 PCIE_SPEED2STR(pcie_link_speed[cls]),
 		 nlw, ssc_good ? "(SSC)" : "(!SSC)");
 
 	/* PCIe->SCB endian mode for BAR */
-- 
2.8.1

