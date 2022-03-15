Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1109A4D938A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 06:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344809AbiCOFKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 01:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344813AbiCOFKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 01:10:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9645ACE;
        Mon, 14 Mar 2022 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647320937; x=1678856937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oJuv0Z8dvZxqgVY1+X5D78/R17rRg7H8XXZJ/5nQQ3A=;
  b=XYo7iZfLk/t91ZJu5cLak395/UVXlaDrecuqsBD32+9SNeu92zSgY+P2
   WLkKgXLxmovLTZ7zH9tfxhx3U8xDr5HQnEJ4pCvGqc2Ce3OVFbjeiSNng
   jI61tYzweN4W9+yTsOybrBeXK2AJqirPxxl80SfAhhbx99xdvXSWFENc7
   IEeRSX5G6yNiVt78bULuWimxYwkdvlSmquLkiGU+naT/6Dp3RRatPAwHG
   xLgZis33RASBC9yGAH0guLp4yCyYbtUfkhN60F6jL/6Ahj4lyjZO5YzXW
   9nI379GHGV1LYcVEO4bao/yKXeyDpEC/j5Wv6xg4gIJBfHRhqgN7Ywo4A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253774485"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="253774485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:08:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580384681"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:08:55 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2] PCI/AER: Handle Multi UnCorrectable/Correctable errors properly
Date:   Tue, 15 Mar 2022 05:08:42 +0000
Message-Id: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the aer_irq() handler returns IRQ_NONE for cases without bits
PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
assumption is incorrect.

Consider a scenario where aer_irq() is triggered for a correctable
error, and while we process the error and before we clear the error
status in "Root Error Status" register, if the same kind of error
is triggered again, since aer_irq() only clears events it saw, the
multi-bit error is left in tact. This will cause the interrupt to fire
again, resulting in entering aer_irq() with just the multi-bit error
logged in the "Root Error Status" register.

Repeated AER recovery test has revealed this condition does happen
and this prevents any new interrupt from being triggered. Allow to
process interrupt even if only multi-correctable (BIT 1) or
multi-uncorrectable bit (BIT 3) is set.

This error can be reproduced by making following changes to the
aer_irq() function and by executing the given test commands.

 static irqreturn_t aer_irq(int irq, void *context)
         struct aer_err_source e_src = {};

         pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS,
				&e_src.status);
 +       pci_dbg(pdev->port, "Root Error Status: %04x\n",
 +		e_src.status);
         if (!(e_src.status & AER_ERR_STATUS_MASK))
                 return IRQ_NONE;

 +       mdelay(5000);

 # Prep injection data for a correctable error.
 $ cd /sys/kernel/debug/apei/einj
 $ echo 0x00000040 > error_type
 $ echo 0x4 > flags
 $ echo 0x891000 > param4

 # Root Error Status is initially clear
 $ setpci -s <Dev ID> ECAP0001+0x30.w
 0000

 # Inject one error
 $ echo 1 > error_inject

 # Interrupt received
 pcieport <Dev ID>: AER: Root Error Status 0001

 # Inject another error (within 5 seconds)
 $ echo 1 > error_inject

 # No interrupt received, but "multiple ERR_COR" is now set
 $ setpci -s <Dev ID> ECAP0001+0x30.w
 0003

 # Wait for a while, then clear ERR_COR. A new interrupt immediately
   fires.
 $ setpci -s <Dev ID> ECAP0001+0x30.w=0x1
 pcieport <Dev ID>: AER: Root Error Status 0002

Currently, the above issue has been only reproduced in the ICL server
platform.

[Eric: proposed reproducing steps]
Fixes: 4696b828ca37 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")
Reported-by: Eric Badger <ebadger@purestorage.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Added Fixes tag.
 * Included reproducing steps proposed by Eric.

 drivers/pci/pcie/aer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..7952e5efd6cf 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -101,6 +101,11 @@ struct aer_stats {
 #define ERR_COR_ID(d)			(d & 0xffff)
 #define ERR_UNCOR_ID(d)			(d >> 16)
 
+#define AER_ERR_STATUS_MASK		(PCI_ERR_ROOT_UNCOR_RCV |	\
+					PCI_ERR_ROOT_COR_RCV |		\
+					PCI_ERR_ROOT_MULTI_COR_RCV |	\
+					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
+
 static int pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
@@ -1196,7 +1201,7 @@ static irqreturn_t aer_irq(int irq, void *context)
 	struct aer_err_source e_src = {};
 
 	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, &e_src.status);
-	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
+	if (!(e_src.status & AER_ERR_STATUS_MASK))
 		return IRQ_NONE;
 
 	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
-- 
2.25.1

