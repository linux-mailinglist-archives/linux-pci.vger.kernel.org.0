Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603117A6414
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjISM62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjISM6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:58:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E871AB;
        Tue, 19 Sep 2023 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695128281; x=1726664281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wybvJEwkKu9h7qtl+C0LlmYtIk8v3lXqyQYeuG0CfZU=;
  b=eEYsWEHt9Do6GBf/16Gq4r8MZMz34VTVNvOJlsIcmr4qmkqRNdUWN6BN
   /Pp3ZGJTbhVS2KWnVfCw27UM5PHTvBjnDINF7/iZVIvcAYZxS27MMsncm
   snrDbMickYQ8lOkd1LY+p6gvLOjuv013EK+DUNu4LUzNctQnzihxDOu37
   AB7g7VfBrFotS/jqBDzXZHBBDgWCXywIqOBKPlTMzQ5A17VxE9aDZWWuH
   ZOWjjjYdASDkqhb0wowGyCjOiCWP/ajY3lZpRNtnb9hii+d6eUcjtdUuc
   qdcqGMZq41JV/AlprzKAr5KTL+rBm4J+IRSpYRPOALLyXJblySWDl1TZs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359324748"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359324748"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746228994"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746228994"
Received: from vdesserx-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 8/8] e1000e: Use pcie_capability_read_word() for reading LNKSTA
Date:   Tue, 19 Sep 2023 15:56:48 +0300
Message-Id: <20230919125648.1920-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pcie_capability_read_word() for reading LNKSTA and remove the
custom define that matches to PCI_EXP_LNKSTA.

As only single user for cap_offset remains, replace it with a call to
pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
pci_dev because both users are interested in it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h |  1 -
 drivers/net/ethernet/intel/e1000e/mac.c     | 11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index a4d29c9e03a6..23a58cada43a 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -678,7 +678,6 @@
 
 /* PCI/PCI-X/PCI-EX Config space */
 #define PCI_HEADER_TYPE_REGISTER     0x0E
-#define PCIE_LINK_STATUS             0x12
 
 #define PCI_HEADER_TYPE_MULTIFUNC    0x80
 
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 5340cf73778d..694a779e718d 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -17,16 +17,13 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 {
 	struct e1000_mac_info *mac = &hw->mac;
 	struct e1000_bus_info *bus = &hw->bus;
-	struct e1000_adapter *adapter = hw->adapter;
-	u16 pcie_link_status, cap_offset;
+	struct pci_dev *pdev = hw->adapter->pdev;
+	u16 pcie_link_status;
 
-	cap_offset = adapter->pdev->pcie_cap;
-	if (!cap_offset) {
+	if (!pci_pcie_cap(pdev)) {
 		bus->width = e1000_bus_width_unknown;
 	} else {
-		pci_read_config_word(adapter->pdev,
-				     cap_offset + PCIE_LINK_STATUS,
-				     &pcie_link_status);
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &pcie_link_status);
 		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
 							     pcie_link_status);
 	}
-- 
2.30.2

