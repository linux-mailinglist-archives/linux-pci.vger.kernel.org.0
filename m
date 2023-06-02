Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE47E7200E2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjFBLu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjFBLuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:50:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF310CE;
        Fri,  2 Jun 2023 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706609; x=1717242609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1epCMyqe0p5e2ZAw49HzHho1aAoWMp3axRI3i6r+rD4=;
  b=BYzsTCrHWnr/7WA7k8em/tkgw0bq6uhUzMgJSF/FSFjb8ZFUds7E/1Cn
   z6hn0Y0YcVJD4HPgMTze/yDE5UmK9XvHrukUtR8dWDnnbCL3Mpq8kxv8Q
   gj0mIXtIPpfutmQJwcU84bElHzf/od45QI6nzd70AT3p6wVzVsCE05Ury
   G5/jo2bCZFQfXDDgq1PxHNBNDqmgRGMCcbgMPhcDomCcivbPbPauQDJJA
   857v65hExapQPErpXpct/Rv0jxhxqO927FTcD9B7BqWlrEcqTzwvT8nDT
   1M135Xf556FgmPqRTYgfXsxxUIfE8UosZNWCW7BBS/dGh9sAQwF+jfkTb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279807"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819560"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819560"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:49:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 13/13] misc: rtsx: Use pci_disable/enable_link_state()
Date:   Fri,  2 Jun 2023 14:47:50 +0300
Message-Id: <20230602114751.19671-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

rtsx driver adjusts ASPM state itself which leaves ASPM service
driver in PCI core unaware of the link state changes the driver
implemented.

Call pci_disable_link_state() and pci_enable_link_state() instead of
adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
handle the ASPM state management.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/misc/cardreader/rts5228.c  | 6 ++----
 drivers/misc/cardreader/rts5261.c  | 6 ++----
 drivers/misc/cardreader/rtsx_pcr.c | 8 +++++---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index cfebad51d1d8..74a2651b5550 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -515,8 +515,7 @@ static void rts5228_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	val |= (pcr->aspm_en & 0x02);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pci_enable_link_state(pcr->pci, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 }
 
@@ -527,8 +526,7 @@ static void rts5228_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+	pci_disable_link_state(pcr->pci, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 	mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index b1e76030cafd..03221db00b86 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -596,8 +596,7 @@ static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 
 	val |= (pcr->aspm_en & 0x02);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
+	pci_enable_link_state(pcr->pci, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
 }
 
@@ -609,8 +608,7 @@ static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+	pci_disable_link_state(pcr->pci, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 32b7783e9d4f..3c3edbb9c837 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -86,9 +86,11 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 		return;
 
 	if (pcr->aspm_mode == ASPM_MODE_CFG) {
-		pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-						PCI_EXP_LNKCTL_ASPMC,
-						enable ? pcr->aspm_en : 0);
+		if (enable)
+			pci_enable_link_state(pcr->pci, pcr->aspm_en);
+		else
+			pci_disable_link_state(pcr->pci, PCIE_LINK_STATE_L0S |
+							 PCIE_LINK_STATE_L1);
 	} else if (pcr->aspm_mode == ASPM_MODE_REG) {
 		if (pcr->aspm_en & 0x02)
 			rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
-- 
2.30.2

