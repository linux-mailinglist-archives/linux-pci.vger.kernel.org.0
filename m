Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AB787097
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjHXNln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbjHXNll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:41:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32AC1BC2;
        Thu, 24 Aug 2023 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884487; x=1724420487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3hVT+3Q+qhJXpA3mqa+G4AIW0hE0M8d7E0Jcjpc3hU=;
  b=ETxk7GQ3o1ufHw9BJ3egR3f7lWWnUNZ7u1i8T7SNyCrSDbIhmGdxqj3f
   +c9C1YIPlYqfiUxM/GYsJNGAv1K4JkMlanwPAHySOeihbkyOz3KqdCyV5
   vZ6uhUo0TQhCGYQgkfnNY4EuVjrKqVVVzSMlaWU8h6J4pkdUMTV3xZdAB
   63v7qoo85Em9//6wvZil2hY7JLz2Sbi8g9fomlwxqBMxKDW/L1U3BqKU5
   6DCNC3tbbCT86y41dMi3oBjcGu+dhCBeMsJMph8xNTPJlsuDIQhWNnfh8
   DPdaCpGsYckmgPgCXwTglewwtjb0BdDdN6pL1sbtfqvtmvnE2a+WVQvjS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792326"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792326"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539801"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539801"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:04 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Roger Lucas <vt8231@hiddenengine.co.uk>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/14] hwmon: (vt8231) Do PCI error checks on own line
Date:   Thu, 24 Aug 2023 16:28:24 +0300
Message-Id: <20230824132832.78705-7-ilpo.jarvinen@linux.intel.com>
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

Instead of if conditions with line splits, use the usual error handling
pattern with a separate variable to improve readability.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/hwmon/vt8231.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index b7c6392ba673..16bc16d33cd1 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -971,13 +971,15 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	u16 address, val;
+	int ret;
+
 	if (force_addr) {
 		address = force_addr & 0xff00;
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n",
 			 address);
 
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_write_config_word(dev, VT8231_BASE_REG, address | 1))
+		ret = pci_write_config_word(dev, VT8231_BASE_REG, address | 1);
+		if (ret != PCIBIOS_SUCCESSFUL)
 			return -ENODEV;
 	}
 
@@ -997,9 +999,8 @@ static int vt8231_pci_probe(struct pci_dev *dev,
 
 	if (!(val & 0x0001)) {
 		dev_warn(&dev->dev, "enabling sensors\n");
-		if (PCIBIOS_SUCCESSFUL !=
-			pci_write_config_word(dev, VT8231_ENABLE_REG,
-							val | 0x0001))
+		ret = pci_write_config_word(dev, VT8231_ENABLE_REG, val | 0x1);
+		if (ret != PCIBIOS_SUCCESSFUL)
 			return -ENODEV;
 	}
 
-- 
2.30.2

