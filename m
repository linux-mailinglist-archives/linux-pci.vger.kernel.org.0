Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCC103566
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfKTHnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 02:43:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:58426 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKTHno (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 02:43:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 23:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="381275147"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2019 23:43:40 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com
Cc:     linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v8 3/3] PCI: artpec6: Configure FTS with dwc helper function
Date:   Wed, 20 Nov 2019 15:43:02 +0800
Message-Id: <49581e0bc143da17fd20074b1dec2126306f745f.1574158309.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1574158309.git.eswara.kota@linux.intel.com>
References: <cover.1574158309.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1574158309.git.eswara.kota@linux.intel.com>
References: <cover.1574158309.git.eswara.kota@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use DesignWare helper functions to configure Fast Training
Sequence. Drop the respective code in the driver.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
Changes on v8:
	No change

Changes on v7:
	No change

Changes on v6:
	Typo fix:s/DesugnWare/DesignWare
	Update 'Utilize DesignWare' --> 'Use DesignWare'
	Add Reviewed-by: Andrew Murray <andrew.murray@arm.com>

 drivers/pci/controller/dwc/pcie-artpec6.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index d00252bd8fae..02d93b8c7942 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -51,9 +51,6 @@ static const struct of_device_id artpec6_pcie_of_match[];
 #define ACK_N_FTS_MASK			GENMASK(15, 8)
 #define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
 
-#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
-#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
-
 /* ARTPEC-6 specific registers */
 #define PCIECFG				0x18
 #define  PCIECFG_DBG_OEN		BIT(24)
@@ -313,10 +310,7 @@ static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
 	 * Set the Number of Fast Training Sequences that the core
 	 * advertises as its N_FTS during Gen2 or Gen3 link training.
 	 */
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~FAST_TRAINING_SEQ_MASK;
-	val |= FAST_TRAINING_SEQ(180);
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_link_set_n_fts(pci, 180);
 }
 
 static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
-- 
2.11.0

