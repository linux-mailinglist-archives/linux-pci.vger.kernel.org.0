Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11D789F87
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjH0Nhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjH0Nh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 09:37:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2256EEB;
        Sun, 27 Aug 2023 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693143443; x=1724679443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIzH6I89fHcXXY3uRmCZDeB2Y9jdsZHRRgZCynpqYTM=;
  b=GUNmTWfUnQ3USJ2i76sdpcu2Z5viK76MZf3bg4btBT6emCFd7cy4cXvb
   3iaOh5um5DJ4cuRPMVyOKx5ptiom3dofpLdUPFhe64XWI6bT278HS/8D8
   nbwZ7/tyboK4lJrhL0LNq/2Fl7HDoY8puPx/jAnH51uRkf6CSu4lCH5/j
   ZGDxSgrUkjgt50rHe7AP50GmSVnk06AIk416P+QgTLgHKem0fi+P3VmkF
   e1yOQiSyidL/MKLMbiJdsGaE63yweeDxH8q7rWGsBBpLRvt8b3b+Fvtvt
   FhSuBhS+SNQPfZBtQnbUTdjWMyjZKjfKy9Ec4oXMcZLTIIeKbsMfMvToR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="354470982"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="354470982"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068752085"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="1068752085"
Received: from dplotkin-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.41.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:37:19 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/8] alpha: Streamline convoluted PCI error handling
Date:   Sun, 27 Aug 2023 16:36:58 +0300
Message-Id: <20230827133705.12991-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com>
References: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com>
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

