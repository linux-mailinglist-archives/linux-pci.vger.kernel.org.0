Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E106756278
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGQMHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 08:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGQMHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 08:07:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9C1710;
        Mon, 17 Jul 2023 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689595634; x=1721131634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAJmAZ+sXj0MECM7XPTmd1pa5VhGBIS57bxBnXZUE7M=;
  b=e4moeCEtKM/OyMXwPwNQWZnQkSS1KjTyGkCYs9QvCSY377wuzxhCI3Sn
   858mLmORVV/PREb9WburAjKpuBhbnD6p/9lBDzOebWxTIHL/As+yX8nrJ
   PkYh2V/XRGluxjpM9bdiNasDVMO3Ua3dt9dAwzNAeH1d7F8FBN6X59e44
   QLzN2wy0058LrJRnSgptxWwrSe5oJ0PaaOISaL5ocOs07bvkYZh7rRh2d
   b6az3VDzPi/dGtrZp9oeavGEhnX20dWGyVCbFCb3XLwUK0z71+tlT2FK+
   7xTBDnBznx8xizcq5vZtbYRnJ4KWxAqCV3t2jrAhllCNZMCx0WOT92ash
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="432081920"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432081920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752876404"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752876404"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:06:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Michal Kazior <michal.kazior@tieto.com>,
        Janusz Dziedzic <janusz.dziedzic@tieto.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 10/11] wifi: ath10k: Use RMW accessors for changing LNKCTL
Date:   Mon, 17 Jul 2023 15:05:02 +0300
Message-Id: <20230717120503.15276-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
References: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Don't assume that only the driver would be accessing LNKCTL. ASPM
policy changes can trigger write to LNKCTL outside of driver's control.

Use RMW capability accessors which does proper locking to avoid losing
concurrent updates to the register value. On restore, clear the ASPMC
field properly.

Fixes: 76d870ed09ab ("ath10k: enable ASPM")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/ath/ath10k/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a7f44f6335fb..9275a672f90c 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1963,8 +1963,9 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 	ath10k_pci_irq_enable(ar);
 	ath10k_pci_rx_post(ar);
 
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl);
+	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
 
 	return 0;
 }
@@ -2821,8 +2822,8 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 
 	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
 				  &ar_pci->link_ctl);
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	/*
 	 * Bring the target up cleanly.
-- 
2.30.2

