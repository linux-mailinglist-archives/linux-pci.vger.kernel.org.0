Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753E443C689
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbhJ0JhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 05:37:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:45304 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241199AbhJ0JhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 05:37:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230394517"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230394517"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="465671139"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 02:34:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76177BB; Wed, 27 Oct 2021 12:34:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] PCI: brcmstb: Use GENMASK() as __GENMASK() is for internal use only
Date:   Wed, 27 Oct 2021 12:34:33 +0300
Message-Id: <20211027093433.4832-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use GENMASK() as __GENMASK() is for internal use only.

Fixes: 3baec684a531 ("PCI: brcmstb: Accommodate MSI for older chips")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..51522510c08c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -619,7 +619,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-	u32 val = __GENMASK(31, msi->legacy_shift);
+	u32 val = GENMASK(31, msi->legacy_shift);
 
 	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
 	writel(val, msi->intr_base + MSI_INT_CLR);
-- 
2.33.0

