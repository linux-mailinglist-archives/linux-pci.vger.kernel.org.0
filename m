Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57079E7FE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjIMMao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjIMMak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 08:30:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776B11BDD;
        Wed, 13 Sep 2023 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694608235; x=1726144235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQpj7OaTDonluY2E3OGQf5kVh3FqltWnatkxOc0duHk=;
  b=eDfgN0MfyQUdB5ZYrBp0kmgE5KJ/Hn6imRmwhkLYeSWBAMDQO4Qwdbx9
   RAFTBcjqI6eZwr0LlRJoTP/iom81QI1Wfhr/NPMjkKv8tnvm8/PmXVtOy
   48iCNCzjUXeHnf1iQDrStnH3EbPKmltJHNSmbgiX818BqcrzeeC6YuRF8
   WurnHQwNdY25crh9NlxWu/g00Ef/uFSA0m87I/T/EUIMKUo8C3rSFYQeW
   VLwGKBgYadRL1NFtp7veXPXV6fdFVyuzEYe6pja4I4MA+FACELjyQApeu
   30uy+1Td5n5XuVKpt0qXkjuLmp9o0ZJ1hXKgxPNdqj4W1kJq+FR6KIj2F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="368912417"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="368912417"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="693836628"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="693836628"
Received: from pakurapo-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.45.213])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:28:08 -0700
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
Subject: [PATCH v2 03/10] igb: Use FIELD_GET() to extract Link Width
Date:   Wed, 13 Sep 2023 15:27:41 +0300
Message-Id: <20230913122748.29530-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/intel/igb/e1000_mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index caf91c6f52b4..5a23b9cfec6c 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2007 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/if_ether.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
@@ -50,9 +51,8 @@ s32 igb_get_bus_info_pcie(struct e1000_hw *hw)
 			break;
 		}
 
-		bus->width = (enum e1000_bus_width)((pcie_link_status &
-						     PCI_EXP_LNKSTA_NLW) >>
-						     PCI_EXP_LNKSTA_NLW_SHIFT);
+		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
+							     pcie_link_status);
 	}
 
 	reg = rd32(E1000_STATUS);
-- 
2.30.2

