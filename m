Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DA7CDA91
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjJRLfH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjJRLfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:35:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD612F;
        Wed, 18 Oct 2023 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628895; x=1729164895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRJlQShSFWurHaKOv7QhLLMxfjt9JndN5eDKi4TZy98=;
  b=aGbYegRUtj56RBdWDPRzO9F0UnjGtoWATtUqMrSJdZjhGYMQ2A6ivG4d
   6pVdPGZDrHNJw3PzKnMNjDxsDxINogltPm/9AIegeJsjnG2nhApe4a3FP
   Kbkd/js6XQVoJwiqrb+NGYeu3Se3MhMV73t52u4PH8gLgZPtY01u8TS6p
   oHSFuxXJwF7XFJwp7YkFMS3hFHW167AeXArQkgnWhIvOdznIfeBSo503b
   /8hS6qXYv4iFhgM0hZwCv1NFG45oiZFRX8q0WLUB1b45O8JQvpTnEZiST
   oSbpvY0P3CxKt/rzUfUHYaW4OLTHrpITf658DpasvOLG1+E/FcvfspS9d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376365782"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="376365782"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="733145191"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="733145191"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/7] PCI/MSI: Use FIELD_GET/PREP()
Date:   Wed, 18 Oct 2023 14:32:54 +0300
Message-Id: <20231018113254.17616-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of custom masking and shifting, use FIELD_GET/PREP() with
register fields.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/msi/msi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index ef1d8857a51b..682fa877478f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -6,6 +6,7 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  * Copyright (C) 2016 Christoph Hellwig.
  */
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/irq.h>
@@ -188,7 +189,7 @@ static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
 
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
-	msgctl |= desc->pci.msi_attrib.multiple << 4;
+	msgctl |= FIELD_PREP(PCI_MSI_FLAGS_QSIZE, desc->pci.msi_attrib.multiple);
 	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, msgctl);
 
 	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, msg->address_lo);
@@ -299,7 +300,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	desc.pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
 	desc.pci.msi_attrib.can_mask	= !!(control & PCI_MSI_FLAGS_MASKBIT);
 	desc.pci.msi_attrib.default_irq	= dev->irq;
-	desc.pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
+	desc.pci.msi_attrib.multi_cap	= FIELD_GET(PCI_MSI_FLAGS_QMASK, control);
 	desc.pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 	desc.affinity			= masks;
 
@@ -478,7 +479,7 @@ int pci_msi_vec_count(struct pci_dev *dev)
 		return -EINVAL;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
-	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
+	ret = 1 << FIELD_GET(PCI_MSI_FLAGS_QMASK, msgctl);
 
 	return ret;
 }
@@ -511,7 +512,8 @@ void __pci_restore_msi_state(struct pci_dev *dev)
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 	pci_msi_update_mask(entry, 0, 0);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
-	control |= (entry->pci.msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
+	control |= PCI_MSI_FLAGS_ENABLE |
+		   FIELD_PREP(PCI_MSI_FLAGS_QSIZE, entry->pci.msi_attrib.multiple);
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
-- 
2.30.2

