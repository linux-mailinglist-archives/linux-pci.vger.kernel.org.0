Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED5505B47
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiDRPkG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbiDRPj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 11:39:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FDB13E1F;
        Mon, 18 Apr 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650294206; x=1681830206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mm1ye/WQVxQp/MY2hRmkn81yEIqLrJ2QUUa96JnW2oA=;
  b=l4B8wogXd/3cWGZJpAo8plb5BY8xuC70Pk9IBneAJwVgeN13dafhxFjR
   jRUN2qKVcw8XaeWact8fofvxf41syTsJ41ZvX1fegiewH7HJgV/Q6ruwe
   IyzOH2XKlekSya/lN3esmq6elEJhbyo7eQLDEo7EVt+QkQv4ojc8QclMr
   lG9oxaRAtRJkaelu9bbeN1tW5VR7Uy0sIyv5cOmzo+eyjG0W+0g/EFCzD
   kYzobdnRt4dCA6xrox5S/99Ri9ZAWmKKjWawJj2v9oPak62ZTEYHx41oR
   0V03IBCda/lmXFiomT6SqlPPfClzn/as9iNiJjSGQWE3BcLZZPolR7Zxb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263293880"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="263293880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:03:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="726670038"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:03:07 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3] PCI/AER: Handle Multi UnCorrectable/Correctable errors properly
Date:   Mon, 18 Apr 2022 15:02:37 +0000
Message-Id: <20220418150237.1021519-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Also note that, for cases with only multi-bit error is set, since this
is not the first occurrence of the error, PCI_ERR_ROOT_ERR_SRC may have
zero or some junk value. So we cannot cleanly process this error
information using aer_isr_one_error(). All we are attempting with this
fix is to make sure error interrupt processing can continue in this
scenario.

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

 # You will get a new IRQ with only multiple ERR_COR bit set
 pcieport <Dev ID>: AER: Root Error Status 0002

Currently, the above issue has been only reproduced in the ICL server
platform.

[Eric: proposed reproducing steps]
Fixes: 4696b828ca37 ("PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/")
Reported-by: Eric Badger <ebadger@purestorage.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Added more details to the commit log.
 * Rebased on v5.18-rc1.

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

