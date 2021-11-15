Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98287450353
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKOLZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 06:25:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:37308 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhKOLXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 06:23:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233667709"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233667709"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 03:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="503787458"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2021 03:20:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 019B122B; Mon, 15 Nov 2021 13:20:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for internal use only
Date:   Mon, 15 Nov 2021 13:20:00 +0200
Message-Id: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use BIT() as __GENMASK() is for internal use only. The rationale
of switching to BIT() is to provide better generated code. The
GENMASK() against non-constant numbers may produce an ugly assembler
code. On contrary the BIT() is simply converted to corresponding shift
operation.

Note, it's the only user of __GENMASK() in the kernel outside of its own realm.

Fixes: 3baec684a531 ("PCI: brcmstb: Accommodate MSI for older chips")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: switched to BIT() and elaborated why, hence not included tag
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..0c49fc65792c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -619,7 +619,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
 
 static void brcm_msi_set_regs(struct brcm_msi *msi)
 {
-	u32 val = __GENMASK(31, msi->legacy_shift);
+	u32 val = ~(BIT(msi->legacy_shift) - 1);
 
 	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
 	writel(val, msi->intr_base + MSI_INT_CLR);
-- 
2.33.0

