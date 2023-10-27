Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1342C7D91CD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjJ0Iia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjJ0IiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 04:38:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F3106;
        Fri, 27 Oct 2023 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698395901; x=1729931901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SBl7gvq5bTKZ2qBWsxuRcqwqbwBEKeoZL83t6kWoQH4=;
  b=SFzFPe7mCYj6XvD3S4cNgadIpsou6aR/MziGFT3HHEF8QeUNr1L+xast
   GJgKzbrNQKZICUtEzJZNu1vFskr8/sN92HOgFDA8qX9UZQVoNIn1EPGsM
   RqX1cEHT2e+lou2pLm7XazRsg5aMT5EkckdC7mSWbN/dV2oWKzCzhbVvH
   SGktee8bnaijwEBeb1H9nc/94zl42YJGUTp0Uxlz7lmbsO4K8DDwnm0uN
   8ylsuBlZbhLk0LNFWc7TQ9cWIDa/Zn6gTCCkyZ+hP4mgu7PTLk/FxUDnl
   YRj6Yp/z6aUo02Cjv0EXaj5XCYKqm/vAk31WPbcP3cV/WXkNXkjzvxBZ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="391609777"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="391609777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="753056267"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="753056267"
Received: from amyachev-mobl3.ccr.corp.intel.com (HELO localhost) ([10.252.49.46])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:38:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Use FIELD_PREP() and remove *_SHIFT defines
Date:   Fri, 27 Oct 2023 11:38:11 +0300
Message-Id: <20231027083811.9200-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of open-coded masking and shifting with PCI_CONF1_* bitfields,
use GENMASK() and FIELD_PREP(), and then remove the *_SHIFT defines
that are no longer needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

 drivers/pci/pci.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 39a8932dc340..31da9fde8aca 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,8 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/pci.h>
 
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
@@ -797,19 +799,15 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * Section 3.2.2.3.2, Figure 3-2, p. 50.
  */
 
-#define PCI_CONF1_BUS_SHIFT	16 /* Bus number */
-#define PCI_CONF1_DEV_SHIFT	11 /* Device number */
-#define PCI_CONF1_FUNC_SHIFT	8  /* Function number */
-
-#define PCI_CONF1_BUS_MASK	0xff
-#define PCI_CONF1_DEV_MASK	0x1f
-#define PCI_CONF1_FUNC_MASK	0x7
+#define PCI_CONF1_BUS_MASK	GENMASK(23, 16)
+#define PCI_CONF1_DEV_MASK	GENMASK(15, 11)
+#define PCI_CONF1_FUNC_MASK	GENMASK(10, 8)
 #define PCI_CONF1_REG_MASK	0xfc /* Limit aligned offset to a maximum of 256B */
 
 #define PCI_CONF1_ENABLE	BIT(31)
-#define PCI_CONF1_BUS(x)	(((x) & PCI_CONF1_BUS_MASK) << PCI_CONF1_BUS_SHIFT)
-#define PCI_CONF1_DEV(x)	(((x) & PCI_CONF1_DEV_MASK) << PCI_CONF1_DEV_SHIFT)
-#define PCI_CONF1_FUNC(x)	(((x) & PCI_CONF1_FUNC_MASK) << PCI_CONF1_FUNC_SHIFT)
+#define PCI_CONF1_BUS(x)	FIELD_PREP(PCI_CONF1_BUS_MASK, (x))
+#define PCI_CONF1_DEV(x)	FIELD_PREP(PCI_CONF1_DEV_MASK, (x))
+#define PCI_CONF1_FUNC(x)	FIELD_PREP(PCI_CONF1_FUNC_MASK, (x))
 #define PCI_CONF1_REG(x)	((x) & PCI_CONF1_REG_MASK)
 
 #define PCI_CONF1_ADDRESS(bus, dev, func, reg) \
@@ -827,9 +825,8 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * are used for specifying additional 4 high bits of PCI Express register.
  */
 
-#define PCI_CONF1_EXT_REG_SHIFT	16
-#define PCI_CONF1_EXT_REG_MASK	0xf00
-#define PCI_CONF1_EXT_REG(x)	(((x) & PCI_CONF1_EXT_REG_MASK) << PCI_CONF1_EXT_REG_SHIFT)
+#define PCI_CONF1_EXT_REG_MASK	GENMASK(27, 24)
+#define PCI_CONF1_EXT_REG(x)	FIELD_PREP(PCI_CONF1_EXT_REG_MASK, (x) >> 8)
 
 #define PCI_CONF1_EXT_ADDRESS(bus, dev, func, reg) \
 	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
-- 
2.30.2

