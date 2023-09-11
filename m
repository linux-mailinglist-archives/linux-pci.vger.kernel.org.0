Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF779BA5D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbjIKVhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjIKMyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:54:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86CE40;
        Mon, 11 Sep 2023 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436859; x=1725972859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIzH6I89fHcXXY3uRmCZDeB2Y9jdsZHRRgZCynpqYTM=;
  b=JuPSEvYIB+mM2lBRXxT7OwqrRO6ynrEoIGnior6iD3Zg9K0yqd3ivFuX
   d5mWodOT3ThLbjXpxwfvMKUjwpOVHBcyKLOzbMdN//AO0Bg6HH50h6BXe
   sNGZwt2hOW/zWca6n5BcKR57CRMM+GEp8O++Wdakx68G0qQLXYnG24l3Z
   iexVdpZtzVkOMq+pUMcppi7f6qefJ/XBP6IHqAdlzPXNj4cKwGyGxhoGP
   riCEEGvTjMmYNLaSIelvjYdVCUbkV+egVcHg5UiCiZkrBiT7+TYNTwSev
   7vZA2RswbgW1pjtYpJ7IrHJldXlhqiBi2bM2xrinlvk10qktjikfrgF9X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357511174"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357511174"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858304167"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858304167"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     3chas3@gmail.com, brking@us.ibm.com, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, jejb@linux.ibm.com, kw@linux.com,
        linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org,
        lpieralisi@kernel.org, martin.petersen@oracle.com,
        netdev@vger.kernel.org, toan@os.amperecomputing.com,
        ysato@users.sourceforge.jp,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/6] alpha: Streamline convoluted PCI error handling
Date:   Mon, 11 Sep 2023 15:53:49 +0300
Message-Id: <20230911125354.25501-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
References: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
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

