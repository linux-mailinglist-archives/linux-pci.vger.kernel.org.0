Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21447A0E28
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbjINTXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjINTXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 15:23:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971426A4;
        Thu, 14 Sep 2023 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694719411; x=1726255411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bQ/m3C0Cjlp+qkmxV3qd9rgQFU2S555pRWmcCkVMVIg=;
  b=fPKDaBUqVs6t6gkxsdNzf6U1OQPwcK7x0o7EVvBzKpIPQkyCoSzcFrRf
   rrHLh14Bhq+j+MtsbpXMOlp2FaCQIUS3n27s/s+Tnjx/lPTJLAemUpHm8
   yXrGgtadzYmHlA0H+oDEB2t5vfHMeV0FoHClsMG2ty3Y+eCaDmIBVKO2A
   chVJSdnv5Mkz3hr2zaNYC1DLz67CijNqd7+qN0y4OZOGlPRFXzHwV27CF
   oOMdrfimiT7FM2nIxCJGAe+sHo3misaPXzo1c6CdP+Jgk3Av9zsr6iP13
   RVOdrdCknTgEj8cYtZMfoxFMbSxOXMbzdKL3ai77KjxsSvB3Ewzqco0jy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358467336"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="358467336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 12:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="738016982"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="738016982"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2023 12:23:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99460204; Thu, 14 Sep 2023 22:23:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] PCI: mediatek: Correct type for virt_to_phys()
Date:   Thu, 14 Sep 2023 22:23:24 +0300
Message-Id: <20230914192324.672997-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

virt_to_phys() takes a regular pointer, while driver supplies __iomem
annotated one. Force type to void to make sparse happy, otherwise

   pcie-mediatek.c:400:40: sparse:     expected void volatile *address
   pcie-mediatek.c:400:40: sparse:     got void [noderef] __iomem *

   pcie-mediatek.c:523:44: sparse:     expected void volatile *address
   pcie-mediatek.c:523:44: sparse:     got void [noderef] __iomem *

Reported-by: Huacai Chen <chenhuacai@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/pcie-mediatek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 66a8f73296fc..5e795afd1cee 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	phys_addr_t addr;
 
 	/* MT2712/MT7622 only support 32-bit MSI addresses */
-	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
+	addr = virt_to_phys((__force void *)port->base + PCIE_MSI_VECTOR);
 	msg->address_hi = 0;
 	msg->address_lo = lower_32_bits(addr);
 
@@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	u32 val;
 	phys_addr_t msg_addr;
 
-	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
+	msg_addr = virt_to_phys((__force void *)port->base + PCIE_MSI_VECTOR);
 	val = lower_32_bits(msg_addr);
 	writel(val, port->base + PCIE_IMSI_ADDR);
 
-- 
2.40.0.1.gaa8946217a0b

