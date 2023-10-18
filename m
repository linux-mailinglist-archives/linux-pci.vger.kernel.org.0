Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD67CDA82
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJRLdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjJRLdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:33:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D35115;
        Wed, 18 Oct 2023 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628823; x=1729164823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+IUgN6qDc3zy/7h4GNa/9YgQiOVwyIUTeR+n02SRwIM=;
  b=lSWAU71aIUaHqUWrMunRcy8XDUWNZfk9zGNWodVyf5ut3K/O4u+Zm9Zr
   fPQ3yfYnvExezMnkOeHDWAjb9BrWuPkOVclLh1oulpu4Xy1yNNJsDNisw
   cavOtF4jVJeI6AU5mosxapsU7uaLwjcRYjvOtjZt1VqqirxZNpTC2CbTw
   VmHgYDmtd8BGTo0vj8SxBlqoEbPSPyrKnFbgxpel9Xj7kDsgW6jLAq9Ya
   r2I9LDAYs4D0oLthtKRZzCgAZr+gLzqZKPh4ikta8hpNR+hWa9Wc1tAY+
   ftPGWRsKQnKdCVXvS2hIMGV526o/7BKHa9XBvq/f6mXg3Xs+37QdrKEIK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="371056710"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="371056710"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930150801"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="930150801"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:33:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/7] PCI: cadence: Use FIELD_GET()
Date:   Wed, 18 Oct 2023 14:32:48 +0300
Message-Id: <20231018113254.17616-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert open-coded variants of PCI field access into FIELD_GET() to
make the code easier to understand.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b8b655d4047e..3142feb8ac19 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -3,6 +3,7 @@
 // Cadence PCIe endpoint controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -262,7 +263,7 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 	 * Get the Multiple Message Enable bitfield from the Message Control
 	 * register.
 	 */
-	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
+	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
 
 	return mme;
 }
@@ -394,7 +395,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 		return -EINVAL;
 
 	/* Get the number of enabled MSIs */
-	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
+	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
 	msi_count = 1 << mme;
 	if (!interrupt_num || interrupt_num > msi_count)
 		return -EINVAL;
@@ -449,7 +450,7 @@ static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 		return -EINVAL;
 
 	/* Get the number of enabled MSIs */
-	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
+	mme = FIELD_GET(PCI_MSI_FLAGS_QSIZE, flags);
 	msi_count = 1 << mme;
 	if (!interrupt_num || interrupt_num > msi_count)
 		return -EINVAL;
@@ -506,7 +507,7 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
 
 	reg = cap + PCI_MSIX_TABLE;
 	tbl_offset = cdns_pcie_ep_fn_readl(pcie, fn, reg);
-	bir = tbl_offset & PCI_MSIX_TABLE_BIR;
+	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
 	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
 
 	msix_tbl = epf->epf_bar[bir]->addr + tbl_offset;
-- 
2.30.2

