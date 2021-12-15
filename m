Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4C475C86
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbhLOP7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 10:59:52 -0500
Received: from mout.perfora.net ([74.208.4.196]:44183 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhLOP7v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Dec 2021 10:59:51 -0500
X-Greylist: delayed 783 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 10:59:51 EST
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MLePl-1mxF7p3NJb-000tVI;
 Wed, 15 Dec 2021 16:30:51 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-phy@lists.infradead.org
Cc:     linux-imx@nxp.com, linux-next@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] phy: freescale: pcie: fix building for x86_64 as a module
Date:   Wed, 15 Dec 2021 16:30:36 +0100
Message-Id: <20211215153037.688885-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/cHhHSs4N+2DNJ5wTLoubYD0rUh2l5oYb3aX9HXa0UVqu9pMzMH
 x28Ezyml0wRYEPJv55bAaYjT+GdEyE0EyrLF5WXgnYvHdA46RWoxI5rFwvao8GE/Z0Ko8Wn
 zHYpeRMGj4Oez1fAUsPK6WdyDVU06FLWr/izt4+nhuLOghlYZmREkXYt9P3HEp+IMegRn+/
 7cpvofDSXIf8K/oJxQ23Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:j9pVH4IC4Ko=:L/0+fEZ1sh5vEjL38EdZNa
 ZdUk5+nc3/JZMH9e65FYO4YxeSpeV8Q9/wFTvh+KJ26lcOzDG2P736wCK8BXCOIrkrcS/Lk00
 UwlXBpZvpsu0qxxleOV7c4NRNGbVu/OG3/x6QSh85ZizqUqRXnQ34qv9lOxScCA78UkhcC09N
 SlKWoj67Ade6nkH81iD2m5M0WkQyC69VFDlMVPCphfhlyN9XMvsp1wRGZUGP2Ob/8MNlTny9p
 Z0soAHNOZQi8NJg33mqTjVuluF8BNf7gkrD+b+w/mRO5whvIhOLx7ACap6gpMn4yKNrLcUxag
 6qHkoAei7cAd4AAsBneQp4kqny5u++sBSXAXUNsNbu7vXspVVx7I8tajJDUmFJqIdlFL73AWi
 SvVrRWYsplHIXM3wXkrFd3fH0b+ungUzj8NBRegOsECr/ZH8CCdLT8nW/5fvPoIFJc78U5O9/
 Qiaena3e6vwsK3kWZD9NpXgt4f8ppecDciHoWWVIeWSmCL14z7L7UPDZuXTcGGXYOOTzWZCyy
 ixQoIazO2B5Pq1iML6BxUtFKLRwZdLO/n184pUWrBqnnWg9Mkg36wEDP3P9YTXuG/YYD+oAdo
 cAioKSkOYXG5T5Nd4EjSCDh1rx7Zvj84wU5iUExWycoEj5tgC5pKft0RCNFNUTr3J4TKpk5CU
 UEL5q03GWPRgkv/N5MJQkO6lFrnc/8IJHAy32E/6a3N5kRoWi0cwbBHVQbZXkoJ5eB1A=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

x86_64 allmodconfig build failed like this:

/tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c: In function
 'imx8_pcie_phy_init':
/tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:37:
 error: implicit declaration of function 'FIELD_PREP'
 [-Werror=implicit-function-declaration]
   41 | #define IMX8MM_GPR_PCIE_REF_CLK_EXT FIELD_PREP(IMX8MM_GPR_PCIE_
REF_CLK_SEL, 0x2)
      |                                     ^~~~~~~~~~
/tmp/next/build/drivers/phy/freescale/phy-fsl-imx8m-pcie.c:85:7: note:
 in expansion of macro 'IMX8MM_GPR_PCIE_REF_CLK_EXT'
   85 |       IMX8MM_GPR_PCIE_REF_CLK_EXT :
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Fix this by explicitly including linux/bitfield.h.

While at it sort includes alphabethically and add a new line before the
dt-bindings one as usually done.

Fixes: 1aa97b002258a190d77
("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index f6502463d49a..f1eb03ba25d6 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -3,10 +3,11 @@
  * Copyright 2021 NXP
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
 #include <linux/module.h>
@@ -14,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 
 #define IMX8MM_PCIE_PHY_CMN_REG061	0x184
-- 
2.33.1

