Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABC787091
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbjHXNlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjHXNkw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004919A5;
        Thu, 24 Aug 2023 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884449; x=1724420449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cES7ePU5BGjB28LtnW6RTcai5kBpmKXPePQ4GMYMWeo=;
  b=ZZ/32UhlOB5oZeLDB7m+TCORTJ/SZCrvXFuqz8LKD5XrFc1lvvEbDDw8
   wMuSZHO9+alfGxHt3xMoYjKM4zZjKW+b6hA9H6fS6VKUw9RATJgGCOXpc
   1d4HoL+L655eqPumOp30vQZaogZT/IuVyeqA4KOTZwVAvnmEzuUKrPc+G
   bfsOVMkZF1eLVNtlPpbj80CPUGympQqO/nJCHoILQ6yIk0RalkKjSGdco
   fmdkvmKn87prqLwNdhR2+dvrcSMfLbwslwxQelfGacicWzr3MwwV3y+AI
   cKVC58yfJKiWBwQPNd7h+Vg/gNljoVbtNYCn0BBNiQB/CITsbQsg6zgK8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792203"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539698"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539698"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:28:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/14] sh: pci: Do PCI error check on own line
Date:   Thu, 24 Aug 2023 16:28:21 +0300
Message-Id: <20230824132832.78705-4-ilpo.jarvinen@linux.intel.com>
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

Instead of a if condition with a line split, use the usual error
handling pattern with a separate variable to improve readability.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

