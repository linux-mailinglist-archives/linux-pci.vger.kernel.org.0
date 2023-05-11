Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5346FF252
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjEKNPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbjEKNPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:15:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137286B6;
        Thu, 11 May 2023 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810899; x=1715346899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2mH7twU8xcKQ+ibOA7cifbNNveZqlGmmYNV0ZHAcVE=;
  b=eeK4O2yGfVOf+BvkAaNQkzqMkwSVTBKzTBFc+yutTiWBwm4pGrqmbd2Z
   1krvOInYRUkzaW5oQpYDsqt0gRBeiBSmmQkc6Q6ThQJpbDfWi7hrimfry
   E41TVxeB2QobzlBMpljZDD7Jwz5rFb9lZBrUwbVGi7Qo0mO5H0WnRPi3h
   fdx2OfWanIolAsDegiUfFTmEwi9DaXoqrBpWdtyuReP4bBhnPhE6WLs0m
   BXiw4pocLGqJxiHD2enbwjoeyx91jKrf+9xQfCP7TO1nzSH7O+9Go4pFR
   vJnau8tQRqJEoKwxtrxeoUfgYhI2zXnJJrHOOKrPaB5JCw9xUu0Mag3e0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619339"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650169475"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650169475"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:14:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/17] PCI: pciehp: Protect LNKCTL changes
Date:   Thu, 11 May 2023 16:14:26 +0300
Message-Id: <20230511131441.45704-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As hotplug is not the only driver touching LNKCTL, use the
pcie_lnkctl_clear_and_set() helper which handles concurrent changes
correctly.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f8c70115b691..14ffbb27957c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -332,17 +332,10 @@ int pciehp_check_link_status(struct controller *ctrl)
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	pcie_lnkctl_clear_and_set(pdev, PCI_EXP_LNKCTL_LD,
+				  !enable ? PCI_EXP_LNKCTL_LD : 0);
 
-	if (enable)
-		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
-	else
-		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
-
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
 	return 0;
 }
 
-- 
2.30.2

