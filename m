Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8779BF43
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjIKVkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjIKMy1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:54:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C3E4B;
        Mon, 11 Sep 2023 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436863; x=1725972863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnx7Bflw7Y/aVGaG8EH0QBwqdgCKqxJb3mqsR3QL2Es=;
  b=ipEenqZC/TbR4sspeEDz6DPiQH7eglzBAWTy0KtnvVno1wIb3IcZwGVF
   DKpIwFdkeEE69H+yFAS/CCiPo+fo1RBXedZLPzxwoGljadGaS1+6X7nww
   pqgxpsAGh1lsefVbii/JgN+YTZrl9yHpx2nsOxHk1lKG0P4ZOwHejMRog
   3PSLllKj9S8VP/FRe0uNvWmbRQ0XQGlXKdodzbxGwnJVCp4xdH+EPRaf0
   vYflbBgSCp/6FI68vcXa0nag3ewDsJ30f3BpYwscO3fOXBaEqYHtA5sGY
   18ZMdCGXNe3RLXARK4SowECS1R+TFL+vPVr3HCwSLAA8gbDIprvj/c8kJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357511201"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357511201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858304223"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858304223"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     3chas3@gmail.com, brking@us.ibm.com, ink@jurassic.park.msu.ru,
        jejb@linux.ibm.com, kw@linux.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, lpieralisi@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com,
        netdev@vger.kernel.org, richard.henderson@linaro.org,
        toan@os.amperecomputing.com,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/6] sh: pci: Do PCI error check on own line
Date:   Mon, 11 Sep 2023 15:53:50 +0300
Message-Id: <20230911125354.25501-3-ilpo.jarvinen@linux.intel.com>
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

Instead of a if condition with a line split, use the usual error
handling pattern with a separate variable to improve readability.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/drivers/pci/common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index 2fd2b77e12ce..f59e5b9a6a80 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -53,15 +53,16 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 	unsigned short vid;
 	int cap66 = -1;
 	u16 stat;
+	int ret;
 
 	pr_info("PCI: Checking 66MHz capabilities...\n");
 
 	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
 		if (PCI_FUNC(pci_devfn))
 			continue;
-		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID, &vid) !=
-		    PCIBIOS_SUCCESSFUL)
+		ret = early_read_config_word(hose, top_bus, current_bus,
+					     pci_devfn, PCI_VENDOR_ID, &vid);
+		if (ret != PCIBIOS_SUCCESSFUL)
 			continue;
 		if (vid == 0xffff)
 			continue;
-- 
2.30.2

