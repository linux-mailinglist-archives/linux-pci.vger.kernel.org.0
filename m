Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438956FF27E
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbjEKNR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbjEKNRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 09:17:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC441106FD;
        Thu, 11 May 2023 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683810970; x=1715346970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KJEqc9zquHSi/5eWbL8pGz0gttsldrrPx96rTLeTqbQ=;
  b=D4rZk0Ou6cxktpD2Q0qDG53sIfjIfwcxz509/ATegj/rudsFZcOfHBEh
   B4T7iP2kHqUQeK3HUXhJzBZtgXSbwG1fz/hq+uhQ352SRwlurwQ8EVeyD
   NMalNN/IdiwFK3lCbG6iPfyDKZirBLKaI/6hOD0RnUBxzhOD5dGHOrvHE
   iZsIOK36zD5WWWy5tqLxeL1wxiiOfV/LdJVHBdr34gXhnMaincbxE9mVc
   lGQ8jSHk844kgln3kr3Hy87xlvBlTdi+2d/wRP/SnHCJ2GHvVA8MF1dLm
   f1N/K5HcTY4tlCAIwR3skUg8XBrJ5x06/w5XxiKgzpaW5AvhCy8qJpQWg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378619700"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378619700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="650170074"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="650170074"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 06:15:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 14/17] r8169: Use pcie_lnkctl_clear_and_set() for changing LNKCTL
Date:   Thu, 11 May 2023 16:14:38 +0300
Message-Id: <20230511131441.45704-15-ilpo.jarvinen@linux.intel.com>
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

Don't assume that only the driver would be accessing LNKCTL. ASPM
policy changes can trigger write to LNKCTL outside of driver's control.

Use pcie_lnkctl_clear_and_set() which does proper locking to avoid
losing concurrent updates to the register value.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a7e376e7e689..c0294a833681 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2686,14 +2686,12 @@ static void __rtl_ephy_init(struct rtl8169_private *tp,
 
 static void rtl_disable_clock_request(struct rtl8169_private *tp)
 {
-	pcie_capability_clear_word(tp->pci_dev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_CLKREQ_EN);
+	pcie_lnkctl_clear_and_set(tp->pci_dev, PCI_EXP_LNKCTL_CLKREQ_EN, 0);
 }
 
 static void rtl_enable_clock_request(struct rtl8169_private *tp)
 {
-	pcie_capability_set_word(tp->pci_dev, PCI_EXP_LNKCTL,
-				 PCI_EXP_LNKCTL_CLKREQ_EN);
+	pcie_lnkctl_clear_and_set(tp->pci_dev, 0, PCI_EXP_LNKCTL_CLKREQ_EN);
 }
 
 static void rtl_pcie_state_l2l3_disable(struct rtl8169_private *tp)
-- 
2.30.2

