Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD97CDA8C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjJRLee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJRLec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:34:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79680114;
        Wed, 18 Oct 2023 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628870; x=1729164870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eqc17uG/Wp2D66WXcFZdwU3+R9wxUscpDbfeTvikXZs=;
  b=hXDENuY7dRREPQA7nPotsPyhE0JAPBdkS7GfYJ5kFTB0IEo9+wuzB3jn
   VqSR7dQZHfKiVctWPYS5vTdTDvq0bXLZmmQ0nmvkKznJzGxCkYafGroTG
   AUrjv2oX4uajsrfcTDeR0gTtccAGUoBJJGkkPs8puqNX4ONH+YkBAnAPN
   rWvYlhKIDoNy64tmRsGPzo00X9XGQLR0/+Aw3Xy72I7eJOhHabxp1k12B
   FMB1uzQ1im5bRkYB1Xnhcx8PXLIRf9/8pykYUnNkLprF1W1ZyP9qVdmGw
   31iRItZfYWsCuguLWoC9jW5xZijJOHLUCDCpOyNfpng91Pw0Ts31bkgkP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383215922"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383215922"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826855323"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="826855323"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:25 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/7] PCI/DPC: Use defined fields with DPC_CTL register
Date:   Wed, 18 Oct 2023 14:32:52 +0300
Message-Id: <20231018113254.17616-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using a literal to clear bits, add PCI_EXP_DPC_CTL_EN_MASK
and use the usual pattern to modify a bitfield.

While at it, rearrange RMW code more logically together.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a5c259ada9ea..0048a11bd119 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -18,6 +18,9 @@
 #include "portdrv.h"
 #include "../pci.h"
 
+#define PCI_EXP_DPC_CTL_EN_MASK	(PCI_EXP_DPC_CTL_EN_FATAL | \
+				 PCI_EXP_DPC_CTL_EN_NONFATAL)
+
 static const char * const rp_pio_error_string[] = {
 	"Configuration Request received UR Completion",	 /* Bit Position 0  */
 	"Configuration Request received CA Completion",	 /* Bit Position 1  */
@@ -369,12 +372,13 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
+	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
-	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 
+	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
 		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
 		 FLAG(cap, PCI_EXP_DPC_CAP_POISONED_TLP),
-- 
2.30.2

