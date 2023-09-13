Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4067B79E80E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjIMMbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjIMMbf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:31:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE11BC7;
        Wed, 13 Sep 2023 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608291; x=1726144291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h23ccGE5WuEhEsJ1piAqm7UfKXwPFLCCzGvyJoEQsXM=;
  b=bWkO0aC09I1gdaes/RX+cM0ugVa/3UYNJWcHpRnDBJKOQIggO0mMpZSL
   9aH6LMHEBeBF/X+qbgwtb5ie3XarYzwXvcOV8sUe1l/mCcKxIFGWWDgUG
   YtcgF4bJMVBI9xz6Iy5ImddTm4Vxn2dROICi4XOfa5JFDRfXOOum/+t0K
   4YVjX+mVXhTto/PF/EmqzNhOzko70nB0r9PM9Eq3kTNCvk5iStdwKUQXe
   g2aRXGFMd7uicibFe61R6BgSF6oSRwZDjNfJTDdGRz/T1RyCWHVLpd8TA
   UZdLdAmLh/zebxSN21vmYj6S3EWxKKF/CqQcDiKABsI64lKDzTTobVUIn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912633"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368912633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836688"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693836688"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/10] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom defines/code
Date:   Wed, 13 Sep 2023 15:27:47 +0300
Message-Id: <20230913122748.29530-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

e1000e has own copy of PCI Negotiated Link Width field defines. Use the
one from include/uapi/linux/pci_regs.h instead of the custom ones and
remove the custom ones. Also convert to use FIELD_GET().

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h | 2 --
 drivers/net/ethernet/intel/e1000e/mac.c     | 7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 63c3c79380a1..a4d29c9e03a6 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -681,8 +681,6 @@
 #define PCIE_LINK_STATUS             0x12
 
 #define PCI_HEADER_TYPE_MULTIFUNC    0x80
-#define PCIE_LINK_WIDTH_MASK         0x3F0
-#define PCIE_LINK_WIDTH_SHIFT        4
 
 #define PHY_REVISION_MASK      0xFFFFFFF0
 #define MAX_PHY_REG_ADDRESS    0x1F  /* 5 bit address bus (0-0x1F) */
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 5df7ad93f3d7..5340cf73778d 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
+
 #include "e1000.h"
 
 /**
@@ -25,9 +27,8 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 		pci_read_config_word(adapter->pdev,
 				     cap_offset + PCIE_LINK_STATUS,
 				     &pcie_link_status);
-		bus->width = (enum e1000_bus_width)((pcie_link_status &
-						     PCIE_LINK_WIDTH_MASK) >>
-						    PCIE_LINK_WIDTH_SHIFT);
+		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
+							     pcie_link_status);
 	}
 
 	mac->ops.set_lan_id(hw);
-- 
2.30.2

