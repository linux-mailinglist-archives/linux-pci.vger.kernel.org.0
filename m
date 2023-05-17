Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0B7065DF
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEQK6m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjEQK6l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 06:58:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE4B61AD;
        Wed, 17 May 2023 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684321090; x=1715857090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuFXzjOd8Jq9CElj4g5CQDGQFvJ4smZ3IyuF6JWPb+E=;
  b=kQSZsMOP7zbF5CIsF2HnMdNXkYQo4aP36Lu9xtRHy9xYKfeyHhzjwgkl
   3oAILAs6t+0q6cUuUzN1UNqt6GBKKZ89XWP8DjVBFVbJUeh78oh9XiRYr
   uZ1AKfjKnv+/aHUXdMIrDHZMRE0iVEIsU8llkpPwlkcOCziLj/AdKrtHo
   +50FeaZEfiLfpsIjamNihbBv7t9comLqJxJ+MdVbIiXet2paXZnSWr0bK
   I7b9I1KiJ5tBNBw9OcZsszAQ2Kamo0dfTzJ0o7twnXBDtLodgndiB60wr
   jzGuB9p6j5QPcA6Ia8eYhOjC3TH32lEOHVHOy6D4o63EZZDHqurwFw2mz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="438071923"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="438071923"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="734651392"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="734651392"
Received: from lnstern-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.221.185])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 03:53:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Janusz Dziedzic <janusz.dziedzic@tieto.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 9/9] wifi: ath10k: Use RMW accessors for changing LNKCTL
Date:   Wed, 17 May 2023 13:52:35 +0300
Message-Id: <20230517105235.29176-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

