Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F097366704
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhDUIb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 04:31:58 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:38696 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhDUIbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 04:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/r8S+nB2TYev7ufcDA
        J/F5aeYifKpJJ3QrkBIbJKMhg=; b=En4Eg9e0U9eL2pC4D8li2sw3lGmzTqI85Q
        c8uxGodmndVZEzN08YsNPRTcGHf+aKuOvsp8hNJJF9l58kW40L2UxDY8NoCcPO1Q
        fePYgdx+v80V7qiQBYyQEO0FlGjJ1ElJTo8SPktmflfftawJlObG2wdtsd7go+Rd
        U/Fr0tULc=
Received: from ubuntu.localdomain (unknown [139.214.254.27])
        by smtp1 (Coremail) with SMTP id GdxpCgBnP1_V4n9gfWDiCQ--.716S2;
        Wed, 21 Apr 2021 16:31:17 +0800 (CST)
From:   Siyu Jin <jinsiyu940203@163.com>
To:     linux-pci@vger.kernel.org
Cc:     Siyu Jin <jinsiyu940203@163.com>
Subject: [PATCH] PCI: rockchip: Fix timeout in rockchip_pcie_host_init_port()
Date:   Wed, 21 Apr 2021 16:31:15 +0800
Message-Id: <20210421083115.30213-1-jinsiyu940203@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgBnP1_V4n9gfWDiCQ--.716S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1fWrW5Aw1xZrWUZw48tFb_yoW8ZrW5pa
        90ywsrGr1kK3yjvan7ZFn3Cw4rt3Zavay7Jrs7Ka4IgFnxJa4UKr1Yk3sxtF17Cr47AF13
        CFW7ta48XwsxZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwiSLUUUUU=
X-Originating-IP: [139.214.254.27]
X-CM-SenderInfo: 5mlq2xd1xzkiqsqtqiywtou0bp/1tbiMBZ711WBw778WQAAsG
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In function rockchip_pcie_host_init_port(), it defines a timeout
value of 500ms to wait for pcie training. However, it is not enough
for samsung PM953 SSD drive and realtek RTL8111F network adapter,
which leads to the following errors:

	[    0.879663] rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
	[    0.880284] rockchip-pcie f8000000.pcie: deferred probe failed
	[    0.880932] rockchip-pcie: probe of f8000000.pcie failed with error -110

The pcie spec only defines the min time of training, not the max
one. So set a proper timeout value is important. Change the value
to 1000ms will fix this bug.

Signed-off-by: Siyu Jin <jinsiyu940203@163.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index f1d08a1b1591..aa42e28b49a8 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -329,10 +329,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
-	/* 500ms timeout value should be enough for Gen1/2 training */
+	/* 1000ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
 				 status, PCIE_LINK_UP(status), 20,
-				 500 * USEC_PER_MSEC);
+				 1000 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(dev, "PCIe link training gen1 timeout!\n");
 		goto err_power_off_phy;
@@ -349,7 +349,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
-					 500 * USEC_PER_MSEC);
+					 1000 * USEC_PER_MSEC);
 		if (err)
 			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
 	}
-- 
2.17.1

