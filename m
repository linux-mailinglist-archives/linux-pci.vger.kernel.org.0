Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8BB937E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfITOz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 10:55:28 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfITOz1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2019 10:55:27 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N2E9Y-1i3w1B3Rhm-013dNt; Fri, 20 Sep 2019 16:55:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thierry Reding <treding@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: include linux/pinctrl/consumer.h
Date:   Fri, 20 Sep 2019 16:55:05 +0200
Message-Id: <20190920145518.1721180-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IwQMbPlR2hr9aTYQU1WDWQp/cnWIHD0os/rsPvkzxg5L9g8x8mA
 2DNVyhrFFzxmek/irSF0HHBeAWbaT4U+mGNlPQqTPhHiwMii3+RpJUelI6QH1xX9lVZ72Wm
 BlfpVF+DfIkabdQBKTXXIadYPXtuwQ6W8+IGUBNBdOupGXJIKp6qUX+oTejZy1l78epJsEQ
 p1hyoFhaumLrR85fK81ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4DDgX0lpUTI=:mBJblij8EOpSFP48bSRQh8
 gK3v16QkRIC56OVlWdDqEYBT7IifzDycka2ZxrNmOq+xVyP1bb8eZHLm05DHNeqI8XsIo6pUB
 H/sEnOHNc8H9CJp81BapaglceHikDfXTuNVTJPt9I+zu5A3fcN8IisPtu0lFHvTZMYO6/Z9Qp
 qX2EBITg9eimJC4DMBEad4T/7jhocR/Lyvx0psF1u3ghhbLuU0bvozUoZO0q6Huo0xDeZC1ZA
 BdFpThncSZ9g/ZHXdZBQ3vFhEt5Tnzhz2BF3Mmi4jiHc24lcqFSiRmjOY5cYaZpFanZQuqlMY
 u+JXl2QOWK9rhjCt9H4BNujUEo9qv20t8OR9P1KcT7SJWzK78abDvRwcFIH9LKUgmrEs6LA9p
 NCl8KN+hSndWm0Qa9jPOa2b8wX940nQAsTZ9+gHV+uSjSMUX79AYcQuvSW2lVcKu6G55w2g/H
 sLYk7odwFBz4zocfPOJ7HspP7DzgZDwXOTnK4fR+4FeXWJm++it0eljp0BHJf+ocNJo3UhpkS
 5wqC/K5AGAHoZBp/3B3i0E0vlylpG0P9aEp4H+4RzRRYen4oM10OvIT2frGcHFxmFr6puAo8s
 zJ4sBKKL7zSsCJV/rvEGGfheXuxYTuXG7PjcmhPGcZLZngIiu3UVDqh/NlkSXT1YT8escPrCN
 Nu6xSd9tLIe059q4dsYh8XQQcicmI1dJhzi79KMNweENpcQLxvNvUlfYnbdhnaFqhcBzDNB/2
 fZUXfu2yMiPmGVMQS/5fFEjndyjY5yGbAmsOSLoqmheXNtTdnabt5Iz7QjOr+bGsLGCXxRRzH
 16KAVy4NtulsA9Q7abon4Rq4L/frN3amAZyXHahcasreSXFzn+giCY7BrfaRkBiGNnP+Ab7ha
 wFEmZKoU0RudbuBIgOjg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Without this, we can run into a build failure:

drivers/pci/controller/dwc/pcie-tegra194.c:1394:8: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror,-Wimplicit-function-declaration]

Fixes: ab2a50e7602b ("PCI: tegra: Add support to configure sideband pins")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09ed8e473cff..f89f5acee72d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -22,6 +22,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
-- 
2.20.0

