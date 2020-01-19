Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B89141B2F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2020 03:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgASCew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jan 2020 21:34:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbgASCew (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jan 2020 21:34:52 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CEC81BD76778FA04D00C;
        Sun, 19 Jan 2020 10:34:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sun, 19 Jan 2020 10:34:42 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] PCI: brcmstb: Fix missing mutex_init()
Date:   Sun, 19 Jan 2020 02:30:03 +0000
Message-ID: <20200119023003.100987-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver allocates the mutex but not initialize it.
Use mutex_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Fixes: 72af6f6f0d13 ("PCI: brcmstb: Add MSI support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 43cba76c0e1e..065bada9cfad 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -528,6 +528,7 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	if (!msi)
 		return -ENOMEM;
 
+	mutex_init(&msi->lock);
 	msi->dev = dev;
 	msi->base = pcie->base;
 	msi->np = pcie->np;



