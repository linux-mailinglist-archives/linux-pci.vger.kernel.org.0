Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C76D57F4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 07:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDDF1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 01:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjDDF1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 01:27:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1B1FC7
        for <linux-pci@vger.kernel.org>; Mon,  3 Apr 2023 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680586038; x=1712122038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzkNmauiFoXRxsSr7U6DxMZY4WbvPf7Qb7TJPHxd42o=;
  b=LJ9Q7lgf+23YoD4yJKtmaGOi3iHuPvA4I2pYjIkM9x/E1d3cFKmcMnfE
   Ou4zK9Wv2Fbxh3mo/Nm79wUFpRO5aZMmFxeZszIBxBCUP6W9zEv/ptP+5
   yGPooQ5aGyCsBL+wHMK17uIbkCh85AlTGJluBPB8dIFI3mZbDNRVbUoms
   4CDj8COSwJWoEIMyHfii3TxtGjkcd3Tq0phDJwdV4L3rFof4PAgJRnJPp
   Yt2ByFjCFGBkFNdCZpO0pU/GlNZmi9yzcCkBqzWsgBtj6eMorUUzgMFRs
   64kae6v9GSaXLH82vOdFbDqF7PH1nNNf1cZASaU0tEhc7vlOV2n2FA44u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="342116196"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="342116196"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 22:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775501973"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="775501973"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2023 22:27:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7AF8694; Tue,  4 Apr 2023 08:27:14 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI/PM: Increase wait time after resume
Date:   Tue,  4 Apr 2023 08:27:13 +0300
Message-Id: <20230404052714.51315-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
References: <20230404052714.51315-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe spec prescribes that a device may take up to 1 second to
recover from reset and this same delay is prescribed when coming out of
D3cold (as that involves reset too). The device may extend this 1 second
delay through Request Retry Status completions and we accommondate for
that in Linux with 60 second cap, only in reset code path, not in resume
code path.

However, a device has surfaced, namely Intel Titan Ridge xHCI, which
requires longer delay also in the resume code path. For this reason make
the resume code path to use this same extended delay than with the reset
path.

Reported-by: Chris Chiu <chris.chiu@canonical.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216728
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 57ddcc59af30..6b5b2a818e65 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -572,7 +572,8 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
-	pci_bridge_wait_for_secondary_bus(pci_dev, "resume", PCI_RESET_WAIT);
+	pci_bridge_wait_for_secondary_bus(pci_dev, "resume",
+					  PCIE_RESET_READY_POLL_MS);
 	/*
 	 * When powering on a bridge from D3cold, the whole hierarchy may be
 	 * powered on into D0uninitialized state, resume them to give them a
-- 
2.39.2

