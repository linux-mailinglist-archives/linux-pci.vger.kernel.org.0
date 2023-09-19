Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4D7A6401
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjISM52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 08:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjISM5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 08:57:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB63119;
        Tue, 19 Sep 2023 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695128235; x=1726664235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQpj7OaTDonluY2E3OGQf5kVh3FqltWnatkxOc0duHk=;
  b=Ga3v3AHrnWTbQgTYua4B+ALHhCO9p6CandAqD/iOUTsSBv/2DwM7iiKK
   h8pElWQYTDZgjU2d9dZ36HVxdYOxD2EU7QtYbYuI2oOyMZ9AC6FskiKGs
   p9YvTY0nhKBuVXKFCXZXIidmjbVrFLZCg8kNqRz8wjCj0MuK00PyJEucw
   v1T8cjEio0BSVJ0YxNo+92IsDyLI1I1S66S4hgT1EqaheWMSg1vUa3/vh
   0WcKVPA4tRwmHFtdU//cyByIRp/bTdXpjYnF0QlMk+q/+Iqb9NaqysBhP
   uur3oI3Br5+qssSMsK+782B0EouVQ6uCGr5kCjsY9ifrsSR6POXTJO+J4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="359324655"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359324655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746228767"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="746228767"
Received: from vdesserx-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.31])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:57:10 -0700
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
Subject: [PATCH v3 3/8] igb: Use FIELD_GET() to extract Link Width
Date:   Tue, 19 Sep 2023 15:56:43 +0300
Message-Id: <20230919125648.1920-4-ilpo.jarvinen@linux.intel.com>
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

