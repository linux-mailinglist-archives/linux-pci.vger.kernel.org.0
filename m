Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC159869
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF1KaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 06:30:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1KaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 06:30:06 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N7zW7-1ic3kn1u4Z-0155ao; Fri, 28 Jun 2019 12:29:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: tegra: use correct gpio/consumer.h header
Date:   Fri, 28 Jun 2019 12:29:45 +0200
Message-Id: <20190628102953.2369879-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zzUOH1RM+MdToDOSOYUpqwuJhko3ET3hxBn0kGPsim+JIxZYxG1
 XL97K10O0FLtJdhcC8TvvrZ+HcsVaob78pOqwoRHayQtkPzyUnXYmeRdZiooYnSWvlgaDLJ
 UX1HF8WDmnop1ec+ErULmE0rOEZyKM9nbU1B5YxhZUgpe/PXfZSN184ruVBbzJmE9JY+IqL
 1bg1JEOXFUbYd0uZnb7tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uOgGL06hKEA=:hS06+fwf1oiScunEXCJ/Q9
 FPwbQ2nNg3RcBK2Z9OxHw/n6hxX2YWAfAAjYU7fMzaedv9Y426SIChlRpgYSQ+5t+eUhN8oSz
 aaw315oUK2DmZfIALtX85tDBJM+OoAGBWE50jGYGYdnmTvobIpZFJUqEl0uVJ5Qoq+WJ0F62O
 2hX5thowapEb41Jc2InElhRBOz8qRdnLXZ4bSldmCez5V+/wxUakjVTnRUQGDJHW74vufTVMT
 WsXmutUVJyujUC3x2gmo35hOjKY6wnekr8ldjGC/KVYXIBxMtdDPLYuDv3pfOgSF1TTHiH7an
 eIrvajVlLiZhCD6rNogHzfZarweSFnJMmqm569guG0m/111LCUqrYSj2X3Qs7m1Ots2MZQ+Vg
 klsnxXrX2LR8NWpc7GCIh4JnKdpyoWtRUssI8pa/zhtNwF51/rgpELL57qCf3kTOyXWwt6r6U
 jMev3IoHVG9fBcjSenEVIfDLoxLo/hIbHvAc/rIP6EvIJQ+w26caYlYXB/A2sBu48oexCAhNQ
 md1cRiV8C6nvA6qekQ142FAUBnJoxm46ZbIGa4VtDxzQ86TvT9FYY4UyriUWcT/j1+axePGRX
 mPclptMg0uriMqyRMZWrVOT/Lv1QwUlRgavwu3iPKYG40LqwsaxvBPWKSpmrmweCYz9uxETKg
 zl66Dzbhcab4Xoq2Azb7Hlkd4Nx71qBL/isG7n3a6Hc/VXc90NuYFE+CeKXGZ49ZHrfb7UTfP
 RmamvsxPm1j3TdFlCE1Ls3psNS/Anqx2Zf/P0w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

linux/gpio.h is not the correct header for modern interfaces and
causes a build failure without CONFIG_GPIOLIB:

drivers/pci/controller/pci-tegra.c: In function 'tegra_pcie_port_reset':
drivers/pci/controller/pci-tegra.c:551:3: error: implicit declaration of function 'gpiod_set_value'; did you mean 'gpio_set_value'? [-Werror=implicit-function-declaration]
   gpiod_set_value(port->reset_gpio, 1);
   ^~~~~~~~~~~~~~~

Use linux/gpio/consumer.h instead.

Fixes: 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9cc03a2549c0..1775b88c0aec 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -17,7 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
-- 
2.20.0

