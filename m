Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2915656A96F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiGGRWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiGGRWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 13:22:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDD3334E;
        Thu,  7 Jul 2022 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657214532; x=1688750532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUimZf7HoEWGh+Aq/BPcPg5jvGhcXWpO39wKqcUuszU=;
  b=a30fx40e2eSDksIjpXvqz2eNyBuxP03GkyjnzjyNJOAhKoZG6OfMvRjz
   SjbI2b58w3FM3mKS9IzEegS+4g3fVnVXHPw9LYuZRCmzvo1fBY86piEX8
   9NzOkW0RktC15oEGJ6hq3E6HcquwTtVudEW98TguOGYN9ShSWL5mWVv/a
   qtb3BiPh7WYeoAUCiIEFjoN61f/aQMRf8R7fwW97PCqTwPrR//wP5XVvI
   4F/tjH3yGtJ+mTYlNY8KbTJQ05kGGEUbBmEnr9Si2c851JicoMY+39CYZ
   yiLZZinhWMGmT9dKElxfdeANbYSHxj3IfFNpHhd1cIwmxvgc6sgjW2Ah7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="348063772"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="348063772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 10:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="626393546"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2022 10:22:11 -0700
Received: from rjingar-desk5.amr.corp.intel.com (bodunhu-mobl2.amr.corp.intel.com [10.212.24.246])
        by linux.intel.com (Postfix) with ESMTP id C7A81580BE9;
        Thu,  7 Jul 2022 10:22:10 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] PCI/PTM: fix in pci_disable_ptm()
Date:   Thu,  7 Jul 2022 10:22:05 -0700
Message-Id: <20220707172205.3205110-2-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707172205.3205110-1-rajvi.jingar@linux.intel.com>
References: <20220707172205.3205110-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set ptm_enabled from 'struct pci_dev' to 0 in pci_ptm_disable() to
save the disabled PTM state for the device.

Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/pci/pcie/ptm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..746e29779c27 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
 	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 0;
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
-- 
2.25.1

