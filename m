Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081913FA496
	for <lists+linux-pci@lfdr.de>; Sat, 28 Aug 2021 11:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhH1I5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Aug 2021 04:57:49 -0400
Received: from mx21.baidu.com ([220.181.3.85]:52584 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233446AbhH1I5s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Aug 2021 04:57:48 -0400
Received: from BC-Mail-Ex07.internal.baidu.com (unknown [172.31.51.47])
        by Forcepoint Email with ESMTPS id 6B1FFA6BB270BB89359D;
        Sat, 28 Aug 2021 16:56:56 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX07.internal.baidu.com (172.31.51.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 28 Aug 2021 16:56:56 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.18) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 28 Aug 2021 16:56:55 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] PCI: Make use of the helper macro SET_RUNTIME_PM_OPS()
Date:   Sat, 28 Aug 2021 16:56:42 +0800
Message-ID: <20210828085642.559-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.18]
X-ClientProxiedBy: BC-Mail-Ex18.internal.baidu.com (172.31.51.12) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
operators ".runtime_suspend/.runtime_resume/.runtime_idle", because
the SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
in to make code a little clearer, a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/pci/pci-driver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a0615395500a..deddd0e28e6c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1330,6 +1330,7 @@ static int pci_pm_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops pci_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(pci_pm_runtime_suspend, pci_pm_runtime_resume, pci_pm_runtime_idle)
 	.prepare = pci_pm_prepare,
 	.complete = pci_pm_complete,
 	.suspend = pci_pm_suspend,
@@ -1347,9 +1348,6 @@ static const struct dev_pm_ops pci_dev_pm_ops = {
 	.thaw_noirq = pci_pm_thaw_noirq,
 	.poweroff_noirq = pci_pm_poweroff_noirq,
 	.restore_noirq = pci_pm_restore_noirq,
-	.runtime_suspend = pci_pm_runtime_suspend,
-	.runtime_resume = pci_pm_runtime_resume,
-	.runtime_idle = pci_pm_runtime_idle,
 };
 
 #define PCI_PM_OPS_PTR	(&pci_dev_pm_ops)
-- 
2.25.1

