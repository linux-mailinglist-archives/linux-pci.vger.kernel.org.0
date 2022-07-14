Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B458F5757EF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 01:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiGNXQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbiGNXQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 19:16:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299372EEC;
        Thu, 14 Jul 2022 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657840572; x=1689376572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AJL06bd9lQh2AmUSTEF0Un/ArSUeAQHW+QlFFAbUKbo=;
  b=k6cf54BXfmyUyXnLvxzvQIMmUCAA9P7qep2Nzj0eosegfx7L8TlZjyZK
   TvRmWDFMr332dgM6yF+yh3P3bqUa9SvIiqi77RqQM8kBlTcfkx+dbwa85
   wNOonP9KmMqpcZxGtop2W0ZCCdTyYgdncC81W4rK1WXOpdnhnjVBi6laa
   xb6nfTX8Ft0CqHl7f/m78vlgc42bhDrOQX4jiJ6YeYPRaO1hV/JollrVj
   C/L1gf8Sq5v1rwVXbT1lmt0JVNZq8HalMbcn4vahKHVgLq8LwsV2hySEQ
   idGtPmBY3DD/z63sgHkV61k6TWtE0pPhu+YocudLxtX5diydMb9dj7+Wi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268676967"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268676967"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 16:16:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="738449838"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jul 2022 16:16:11 -0700
Received: from rjingar-desk5.amr.corp.intel.com (vicentes-mobl.amr.corp.intel.com [10.209.132.117])
        by linux.intel.com (Postfix) with ESMTP id 20D9958092F;
        Thu, 14 Jul 2022 16:16:11 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
Date:   Thu, 14 Jul 2022 16:16:09 -0700
Message-Id: <20220714231609.3962051-2-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714231609.3962051-1-rajvi.jingar@linux.intel.com>
References: <20220714231609.3962051-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
state of the device. In pci_ptm_disable(), clear ptm_enabled from
'struct pci_dev' on disabling PTM state for the device.
In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
PTM state of the device.

Also, perform ptm_enabled check in pci_ptm_disable() to avoid config
space access in case if PTM is already disabled for the device.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 v1->v2:
   - add ptm_enabled check in pci_ptm_disable().
   - set the dev->ptm_enabled value in pci_restore_ptm_state().
---
 drivers/pci/pcie/ptm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..8dc7d2285a0d 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -34,6 +34,9 @@ void pci_disable_ptm(struct pci_dev *dev)
 	int ptm;
 	u16 ctrl;
 
+	if (!dev->ptm_enabled)
+		return;
+
 	if (!pci_is_pcie(dev))
 		return;
 
@@ -44,6 +47,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
 	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 0;
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -83,6 +87,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+	dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
 }
 
 void pci_ptm_init(struct pci_dev *dev)
-- 
2.25.1

