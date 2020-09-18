Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C29E2703C9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIRSMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRSMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 14:12:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C164C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 11:12:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so3399052pll.6
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rE4BZJp0q9zDr8kKMiT4zLrTffXmD+rm19TjujnN1Vk=;
        b=Hm/XXSZmisiU6T6tNygou89zb4Ycs1lwy/6SoTmGc4hdMUZFBJNje4cBnYK/LR54S5
         JGyuoXInxA9zBYd8nDTr0Qu5P8uH+/vXWhdoT4Mmzgt1sim6TjopH6EKXrimtqXHoOHI
         rgWh7lGZz7y2Ae0mWVtAVQc91B1BzHSO4ZBYbJgCCc5XfiTQxGZA5988w/5j2ddwt+9h
         mAqiEV06sdg8dIodDRfkXuY3jjZv9B6M7r1Ra/nwrvSzt5S9JtNQm9zHr9D7xpBPFuCT
         SWex+b0QE5KrgqLz2uo9OfqZ6IdcAj5+pQZffqvsLf1HzIY4fKRt0qQKpRxi8F1nPnsx
         X0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rE4BZJp0q9zDr8kKMiT4zLrTffXmD+rm19TjujnN1Vk=;
        b=tkH3FVZ/0k6hgojn6DlgIzgEez4AZe4BDOPdmxu8hwmCmnLLEg5DfaQInE6L0pFgYF
         /zZqWJjC8KcRpIlZXyme9lGAEEQSUO4JRU753ZIEilPAgza6v2ZsjEHa5ioU21FjwO9L
         G+ShO67t9dhQIyyX8M9VGrlbKdKbiF3iMmnOtXM9oZ3wxeKwkmieqBxAw6iseD5HTXl7
         M4hulOpAix9GoAehxf49B7nxhuaesqZ078s83k7+kdi/c0RVdDAMIA1LdpyA+NiRWtgJ
         yLVY0hlKCNMH1boJ4toptRXXFLKcG7EMuL7yW5X7KWqLkjcogb17/2DReJ80xi4NQQBE
         JoAg==
X-Gm-Message-State: AOAM531SdIjWOxqibWge6K7HD5QyO7PvIGs7t4vU+VAwaMYdPcI6Ctx1
        Q5H7bB6UqyrkU3n7eRPNKOM7kLKR09LLNQ==
X-Google-Smtp-Source: ABdhPJwfrxGeVpYY+o0j8pr1eIsjuqfOXri4PFS+X0KVtN+hxvJwc1QM8JFwnSj5/PyhFV0mZRVNNg==
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr13566751pjb.187.1600452772658;
        Fri, 18 Sep 2020 11:12:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id l1sm3847426pgo.11.2020.09.18.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 11:12:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-pci@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>
Subject: [PATCH] pci: meson: build as module by default
Date:   Fri, 18 Sep 2020 11:12:51 -0700
Message-Id: <20200918181251.32423-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable pci-meson to build as a module whenever ARCH_MESON is enabled.

Cc: Yue Wang <yue.wang@amlogic.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Tested on Khadas VIM3 and Khadas VIM3 using NVMe SSD devices.

 drivers/pci/controller/dwc/Kconfig     | 3 ++-
 drivers/pci/controller/dwc/pci-meson.c | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a3761c44f..bc049865f8e0 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -237,8 +237,9 @@ config PCIE_HISI_STB
 	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
 
 config PCI_MESON
-	bool "MESON PCIe controller"
+	tristate "MESON PCIe controller"
 	depends on PCI_MSI_IRQ_DOMAIN
+	default m if ARCH_MESON
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Amlogic
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 4f183b96afbb..7a1fb55ee44a 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -17,6 +17,7 @@
 #include <linux/resource.h>
 #include <linux/types.h>
 #include <linux/phy/phy.h>
+#include <linux/module.h>
 
 #include "pcie-designware.h"
 
@@ -589,6 +590,7 @@ static const struct of_device_id meson_pcie_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, meson_pcie_of_match);
 
 static struct platform_driver meson_pcie_driver = {
 	.probe = meson_pcie_probe,
@@ -598,4 +600,8 @@ static struct platform_driver meson_pcie_driver = {
 	},
 };
 
-builtin_platform_driver(meson_pcie_driver);
+module_platform_driver(meson_pcie_driver);
+
+MODULE_AUTHOR("Yue Wang <yue.wang@amlogic.com>");
+MODULE_DESCRIPTION("Amlogic PCIe Controller driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.28.0

