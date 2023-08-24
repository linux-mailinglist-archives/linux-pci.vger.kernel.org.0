Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA2787092
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbjHXNlO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbjHXNlD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:41:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A9EFD;
        Thu, 24 Aug 2023 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884458; x=1724420458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QF9WYjRCYEocjFKjFt7O8L0RbM4oz6QXvkcLujSKND8=;
  b=DM6b84Qeiby0QQXkkEuLsMC37lXtL2D++ZWiH9hl3q026wo1fgmYkNWc
   QPxIbExCCiltJ+MAf30mp2wuHUiTE1k5hFuLXW0JosX4z1Fj7XrmDz7X0
   DfAKOe2J7CqSbOEZ7QO/RUGRwN7tvxdSGd24xhUKRmmUwm8j20uZTwZPp
   85EDMANvlaOC47ZjYmc2OeOA51qXBFlJKYTSQenjGGQP70+yn/xuPZDxs
   c8fU5WcB2z+1HtB00PrA+7CAJAUl0DosEmT1R5+4Cxz6Q5Mnuop13Hyms
   /gwql4RwEjuKOG5TKOXqXNd0ueDpvKgyAXB7HU4V+zDYEA0iA6X8ECeer
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440792282"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440792282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802539770"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802539770"
Received: from abedekar-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.213.29])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:29:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/14] hwmon: (via686a) Do PCI error checks on own line
Date:   Thu, 24 Aug 2023 16:28:23 +0300
Message-Id: <20230824132832.78705-6-ilpo.jarvinen@linux.intel.com>
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
 drivers/hwmon/via686a.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 37d7374896f6..407933d6e425 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -855,16 +855,17 @@ static int via686a_pci_probe(struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
 	u16 address, val;
+	int ret;
 
 	if (force_addr) {
 		address = force_addr & ~(VIA686A_EXTENT - 1);
 		dev_warn(&dev->dev, "Forcing ISA address 0x%x\n", address);
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_write_config_word(dev, VIA686A_BASE_REG, address | 1))
+		ret = pci_write_config_word(dev, VIA686A_BASE_REG, address | 1);
+		if (ret != PCIBIOS_SUCCESSFUL)
 			return -ENODEV;
 	}
-	if (PCIBIOS_SUCCESSFUL !=
-	    pci_read_config_word(dev, VIA686A_BASE_REG, &val))
+	ret = pci_read_config_word(dev, VIA686A_BASE_REG, &val);
+	if (ret != PCIBIOS_SUCCESSFUL)
 		return -ENODEV;
 
 	address = val & ~(VIA686A_EXTENT - 1);
@@ -874,8 +875,8 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	if (PCIBIOS_SUCCESSFUL !=
-	    pci_read_config_word(dev, VIA686A_ENABLE_REG, &val))
+	ret = pci_read_config_word(dev, VIA686A_ENABLE_REG, &val);
+	if (ret != PCIBIOS_SUCCESSFUL)
 		return -ENODEV;
 	if (!(val & 0x0001)) {
 		if (!force_addr) {
@@ -886,9 +887,8 @@ static int via686a_pci_probe(struct pci_dev *dev,
 		}
 
 		dev_warn(&dev->dev, "Enabling sensors\n");
-		if (PCIBIOS_SUCCESSFUL !=
-		    pci_write_config_word(dev, VIA686A_ENABLE_REG,
-					  val | 0x0001))
+		ret = pci_write_config_word(dev, VIA686A_ENABLE_REG, val | 0x1);
+		if (ret != PCIBIOS_SUCCESSFUL)
 			return -ENODEV;
 	}
 
-- 
2.30.2

