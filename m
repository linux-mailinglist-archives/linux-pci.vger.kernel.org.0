Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC6A79E811
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjIMMbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbjIMMbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:31:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBB1FC0;
        Wed, 13 Sep 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608300; x=1726144300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wo7umevM4e5cancbBmuxKjkF/sAUzuBzzYDYja1futw=;
  b=BZA1AfNZyKA8S0EMrOjr4K59DEX2wqVsBFYjQTUmK4NioBFHXH2NNVu6
   f05aQivLAmnNLjgUeWuMh/wiwSDy5F5tpjl5+JmMndk3NtGloAxkcyuOn
   mZ5JebhiPzIiGr4zxOweBRNZ0t6L3WS3NsCb0jrGkSGk/AZ7aLMotMrQt
   MW8tG+sV9ay0OtK6sfwjbA2+61HvQUMHxEf1o01c76SSJ0ee3/KZCRR5j
   5HZJc1qw53UVLys6e6KFm0PTP0XXwKKZBHAJhXQIUAnpKon4rypcdgRWR
   Ey96mSupFVXJQcB2xQQ3PdYt0VSxgft3QLmNZOVPVOhVbH3Uqw317iCA5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912686"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368912686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836724"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693836724"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:38 -0700
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
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/10] e1000e: Use pcie_capability_read_word() for reading LNKSTA
Date:   Wed, 13 Sep 2023 15:27:48 +0300
Message-Id: <20230913122748.29530-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pcie_capability_read_word() for reading LNKSTA and remove the
custom define that matches to PCI_EXP_LNKSTA.

As only single user for cap_offset remains, remove it too and use
adapter->pdev->pcie_cap directly in the if condition.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h |  1 -
 drivers/net/ethernet/intel/e1000e/mac.c     | 10 ++++------
 2 files changed, 4 insertions(+), 7 deletions(-)

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
index 5340cf73778d..e86652a30069 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -18,15 +18,13 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 	struct e1000_mac_info *mac = &hw->mac;
 	struct e1000_bus_info *bus = &hw->bus;
 	struct e1000_adapter *adapter = hw->adapter;
-	u16 pcie_link_status, cap_offset;
+	u16 pcie_link_status;
 
-	cap_offset = adapter->pdev->pcie_cap;
-	if (!cap_offset) {
+	if (!adapter->pdev->pcie_cap) {
 		bus->width = e1000_bus_width_unknown;
 	} else {
-		pci_read_config_word(adapter->pdev,
-				     cap_offset + PCIE_LINK_STATUS,
-				     &pcie_link_status);
+		pcie_capability_read_word(adapter->pdev, PCI_EXP_LNKSTA,
+					  &pcie_link_status);
 		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
 							     pcie_link_status);
 	}
-- 
2.30.2

