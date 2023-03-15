Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577576BC1D1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjCOXy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjCOXy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 19:54:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051458C10;
        Wed, 15 Mar 2023 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678924494; x=1710460494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CPOicFX3g6LyA9PwhC25oLE2FTHHo3dXXFz0BxDfhzg=;
  b=cIaovLBIsYbh4Yc5Bo3tV+7RQjtx4uo6n5pqwE3KONJyhp4xGAKy7zae
   lhi32ysguUfVW9eNiWYMqsNgxohpHnJ8NKxZ5btAQ0ZZUFA5iiOjsFDLQ
   7ui7yLdRCJRBUwDLuC0567TKzfE5dPYn71mmylH2WsZpU36j08HhAtfPM
   asmIUIRLftVHT19P+OC3kxgZec2O8UnaXVZEz+uvZvZEF6sSfwTHVJ/Pr
   I4avK9zvYeVmX/Km9igq1pVFJnBOumjKQPDpfYwMnOUids4nkT0yrxTVG
   Fz6YgZBw+otPyPnvNGCBpXO6uQcKmXCApGO9YyvPsokLANpHBfw9JW5cg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321688108"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321688108"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="853793286"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="853793286"
Received: from kaliving-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.158.22])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:54:53 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR error recovery
Date:   Wed, 15 Mar 2023 16:54:49 -0700
Message-Id: <20230315235449.1279209-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
OS owns AER") adds support to clear error status in the Device Status
Register(DEVSTA) only if OS owns the AER support. But this change
breaks the requirement of the EDR feature which requires OS to cleanup
the error registers even if firmware owns the control of AER support.

More details about this requirement can be found in PCIe Firmware
specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
If the OS supports the Error Disconnect Recover (EDR) feature and
firmware sends the EDR event, then during the EDR recovery window, OS
is responsible for the device error recovery and holds the ownership of
the following error registers.

• Device Status Register
• Uncorrectable Error Status Register
• Correctable Error Status Register
• Root Error Status Register
• RP PIO Status Register

So call pcie_clear_device_status() in edr_handle_event() if the error
recovery is successful.

Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Rebased on top of v6.3-rc1.
 * Fixed a typo in pcie_clear_device_status().

 drivers/pci/pcie/edr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97a..87734e4c3c20 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 */
 	if (estate == PCI_ERS_RESULT_RECOVERED) {
 		pci_dbg(edev, "DPC port successfully recovered\n");
+		pcie_clear_device_status(edev);
 		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
 	} else {
 		pci_dbg(edev, "DPC port recovery failed\n");
-- 
2.34.1

