Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19CC3FA499
	for <lists+linux-pci@lfdr.de>; Sat, 28 Aug 2021 11:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhH1I7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Aug 2021 04:59:40 -0400
Received: from mx21.baidu.com ([220.181.3.85]:54334 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233584AbhH1I7i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Aug 2021 04:59:38 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id EA40F55558F5C2C6E396;
        Sat, 28 Aug 2021 16:58:44 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 28 Aug 2021 16:58:44 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.20) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 28 Aug 2021 16:58:44 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <bhelgaas@google.com>, <kbusch@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] PCI/portdrv: Make use of the helper macro SET_SYSTEM_SLEEP_PM_OPS()/ SET_RUNTIME_PM_OPS()
Date:   Sat, 28 Aug 2021 16:58:30 +0800
Message-ID: <20210828085830.351-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.20]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the helper macro SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS()
instead of the verbose operators ".runtime_suspend/_resume/_idle"
and ".suspend/.resume/.freeze/.thaw/.poweroff/.restore", because the
helper macro SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS() could be
brought in to make code a little clearer, a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/pci/pcie/portdrv_pci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c7ff1eea225a..29d1c7de6410 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -70,17 +70,11 @@ static int pcie_port_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
-	.suspend	= pcie_port_device_suspend,
+	SET_SYSTEM_SLEEP_PM_OPS(pcie_port_device_suspend, pcie_port_device_resume)
+	SET_RUNTIME_PM_OPS(pcie_port_runtime_suspend,
+			   pcie_port_device_runtime_resume, pcie_port_runtime_idle)
 	.resume_noirq	= pcie_port_device_resume_noirq,
-	.resume		= pcie_port_device_resume,
-	.freeze		= pcie_port_device_suspend,
-	.thaw		= pcie_port_device_resume,
-	.poweroff	= pcie_port_device_suspend,
 	.restore_noirq	= pcie_port_device_resume_noirq,
-	.restore	= pcie_port_device_resume,
-	.runtime_suspend = pcie_port_runtime_suspend,
-	.runtime_resume	= pcie_port_device_runtime_resume,
-	.runtime_idle	= pcie_port_runtime_idle,
 };
 
 #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
-- 
2.25.1

