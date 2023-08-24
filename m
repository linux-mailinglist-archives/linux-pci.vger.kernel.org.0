Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF878708D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjHXNlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbjHXNkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:40:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF117FD;
        Thu, 24 Aug 2023 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884440; x=1724420440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIzH6I89fHcXXY3uRmCZDeB2Y9jdsZHRRgZCynpqYTM=;
  b=a6RWK/PlOhomwS7OIp0vMta4NZMmDMlwl5pcdsN916A89KY7MUcRgH7m
   PelkSdMx460WFwUMdi75lF/wA487BLsytvIyL4lVi0PBOXKKHSi7CRVwS
   kRLpafAu2SX70RMyQi2kewe595Iyl6nxnp2d6cFwOBlCeIl2A0IGGBVsJ
   wc/+gu4P1kDn8n7MBcziBY+jqJKwcpuMX+TudqjfC178KYzf7FBdBY3OE
   cl0TnBHSlhm8iigeU3K3YXbjeOqMbVpFtK5syo4e3PaIdf1/mRNSXPryA
   9W9HXBdeo1EJ3IxbS3dZ3jUwW1arpEWYINReQ0SvP0mt2xHBK+7anpSxl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792096"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539616"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539616"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/14] alpha: Streamline convoluted PCI error handling
Date:   Thu, 24 Aug 2023 16:28:19 +0300
Message-Id: <20230824132832.78705-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
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

miata_map_irq() handles PCI device and read config related errors in a
conditional block that is more complex than necessary.

Streamline the code flow and error handling.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/alpha/kernel/sys_miata.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index e1bee8f84c58..33b2798de8fc 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -183,16 +183,17 @@ miata_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
            the 2nd 8259 controller. So we have to check for it first. */
 
 	if((slot == 7) && (PCI_FUNC(dev->devfn) == 3)) {
-		u8 irq=0;
 		struct pci_dev *pdev = pci_get_slot(dev->bus, dev->devfn & ~7);
-		if(pdev == NULL || pci_read_config_byte(pdev, 0x40,&irq) != PCIBIOS_SUCCESSFUL) {
-			pci_dev_put(pdev);
+		u8 irq = 0;
+		int ret;
+
+		if (!pdev)
 			return -1;
-		}
-		else	{
-			pci_dev_put(pdev);
-			return irq;
-		}
+
+		ret = pci_read_config_byte(pdev, 0x40, &irq);
+		pci_dev_put(pdev);
+
+		return ret == PCIBIOS_SUCCESSFUL ? irq : -1;
 	}
 
 	return COMMON_TABLE_LOOKUP;
-- 
2.30.2

