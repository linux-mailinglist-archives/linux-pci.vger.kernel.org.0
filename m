Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2C6E0B43
	for <lists+linux-pci@lfdr.de>; Thu, 13 Apr 2023 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDMKRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Apr 2023 06:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDMKQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Apr 2023 06:16:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEB1113
        for <linux-pci@vger.kernel.org>; Thu, 13 Apr 2023 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681381003; x=1712917003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CRYHLrtB7tkYmx12gfnRFmla/xImqWAQNobWhWHoNgk=;
  b=WM/VAFldKxVZyQUFr7M4oow9WLqvidLMTNWINRP6iMf5zb0UKIAyKRfl
   2oGuiJ3a4P3aT1kgcnJdqLKaatHXVqJKnKOBRccQUXWpBOzI1fJ/qCqHJ
   t7ZIooOyztg4Exmc4OXK0Ja823nBM2Hr4EE2gTAA/PITnkAt0SxeJOAKv
   dyb7Mks6TQQQJGSeLUtIi43/Tx3gegRsWe5qjmhjABO2Vi1ukbgQ1TZWf
   shXzmoY/Kb6sCxKCCf3fbKBzmR60qfkAAHqH84zxwIoWNp/1RkFu70lJx
   4r8v02IRDJ1PTHvQGBfwYcnfbmx29Fu6sZGOqbyfetGGIx7GThhxHsQfB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346828787"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="346828787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="721997664"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="721997664"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 13 Apr 2023 03:16:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E60C326A; Thu, 13 Apr 2023 13:16:42 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI/PM: Bail out early in pci_bridge_wait_for_secondary_bus() if link is not trained
Date:   Thu, 13 Apr 2023 13:16:42 +0300
Message-Id: <20230413101642.8724-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the Root/Downstream Port supports active link reporting we can check
if the link is trained before waiting for the device to respond. If the
link is not trained, there is no point waiting for the whole ~60s so
bail out early in that case.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
As discussed in the email thread of the previous version here:

  https://lore.kernel.org/linux-pci/20230404052714.51315-1-mika.westerberg@linux.intel.com/

This adds the last change on top of

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset


 drivers/pci/pci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b4f3b08f780..61bf8a4b2099 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5037,6 +5037,22 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		}
 	}
 
+	/*
+	 * Everything above is handling the delays mandated by the PCIe r6.0
+	 * sec 6.6.1.
+	 *
+	 * If the port supports active link reporting we now check one more
+	 * time if the link is active and if not bail out early with the
+	 * assumption that the device is not present anymore.
+	 */
+	if (dev->link_active_reporting) {
+		u16 status;
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
+		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+			return -ENOTTY;
+	}
+
 	return pci_dev_wait(child, reset_type,
 			    PCIE_RESET_READY_POLL_MS - delay);
 }
-- 
2.39.2

