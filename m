Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FF7D8278
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjJZMTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjJZMTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 08:19:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A4B9;
        Thu, 26 Oct 2023 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322776; x=1729858776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p+Gb2snRIkAb2gO0jCgy4vPKw4QvuWg0X9Z+93KecFo=;
  b=fQ+ZZTTQnEOa5jU+7y8nGh0eo3MZVlZiPd+W8XaaY5G4YQEQTyQGCR30
   TB3nGW1J0lCafhLzlJFJ1a70hIef/37o3DP0yuCXT9mQ7XnnBhAuVZ1Vs
   Jxu5gTYiq+ld8zjvnEzOIBIOMpPZK5arirKnBrVI1ws27v3BPAm3Waf91
   EyMAVQe83NcCznNG/K9oI6eYyWpOHQHnx2pS4qLTnQG6p7Do8eJ0A1TIr
   ve9qetSdLuASy9+TiHSqemCdKV7v8t2q2faAniRFz1ncWgc59eqw+OojZ
   qy0t6ZpL38j7mmHMkUPymIXdJZ1VCwQHPKNRVa+qw/gXxo+B/mhlHISD6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390390969"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="390390969"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090589448"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1090589448"
Received: from ialvarez-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.120])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:19:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] PCI/ASPM: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()
Date:   Thu, 26 Oct 2023 15:19:23 +0300
Message-Id: <20231026121924.2164-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When set parameter is 0, pcie_capability_clear_and_set_word() can be
turned into pcie_capability_clear_word() which makes the intent of the
code slightly more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1bf630059264..3b0508b47472 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -689,10 +689,10 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 * in pcie_config_aspm_link().
 	 */
 	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPM_L1, 0);
-		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPM_L1, 0);
+		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPM_L1);
+		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPM_L1);
 	}
 
 	val = 0;
-- 
2.30.2

