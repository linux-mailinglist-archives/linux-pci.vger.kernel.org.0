Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BFB69852A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBOUFk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 15:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBOUFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 15:05:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9443A842;
        Wed, 15 Feb 2023 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676491539; x=1708027539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=42e2UJ+iAsNqiNqS5lhTz8+flRIvdRigNev83/sdLZM=;
  b=M/yRUw1WugA6FUPlZumlxN8gY5+JJ26ssslNXUU2mIC2+zWVHJ3ko6/Y
   qSuokorPINyIYICADNnarsWMdegNrLrSETtGxvLvvE+ei23CcwkuEEtRE
   4yqsIW3NAvbavWfWZwNdQslzATymZ6PD2D9LQGMkZQnbJP+D5aD/079wf
   25GXjvdqVR0qEPCXTPm4FuCQj15cgUeoQYw07oS2m1w4i0xqGdDtWUozi
   2qy/grXLcI0XRmMjnxFR0lqLWlansGCW4WjMcuGZnRIXgl05Dvrmp1Nij
   N/IQNMJI0dgg8rmbizsJP/cgij5PKxGyh/dt4FjmAqcZUmeVcbbIN2q/i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="331528151"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="331528151"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 12:05:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="663152992"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="663152992"
Received: from amanjini-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.48.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 12:05:38 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1] PCI/EDR: Clear PCIe Device Status errors after EDR error recovery
Date:   Wed, 15 Feb 2023 12:05:32 -0800
Message-Id: <20230215200532.3126937-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/pcie/edr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97a..33d7776ea748 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 */
 	if (estate == PCI_ERS_RESULT_RECOVERED) {
 		pci_dbg(edev, "DPC port successfully recovered\n");
+		pcie_clear_device_status(dev);
 		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
 	} else {
 		pci_dbg(edev, "DPC port recovery failed\n");
-- 
2.25.1

