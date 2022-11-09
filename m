Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04896622E0A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiKIOfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 09:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKIOfm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 09:35:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4517A99
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 06:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668004541; x=1699540541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7zhCo0nD6Nq7zaErN4PpSSjux/957EltFabPqb+1+Q4=;
  b=gXhXia4P9aRAW1ymzcKD41iFrgp4rFu6R1k4nqP2UmogIVG0WRxPxYED
   lM7r0AG60Ddqxo9RF+3+iCIfN/8YVp2iForzS219AlNxTN/8OQ8fHKehC
   wJbE6fRQpYO6D6ylquua/Kh6dCsy3a/F2U4wEfwriaRJYQnNY8srZZ+PQ
   fxe4Ap9CvrgOrG1wd5uRylQ8R4ZzsfcDa6dHuv6lPUO6TBv3MT1MHV9k9
   6cXecQKT2AZ9d4kp9ueqkwGvw13mbkkPSG6k7mc7+mv/Tb7HThFIh1eYy
   7VA4NWDUmjld3OkYR4bH33QwgLwLDHegPygUcXUeN8Eqs0rpLe679neBe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375266568"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="375266568"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 06:35:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="631267449"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="631267449"
Received: from unknown (HELO ocsbesrhlrepo01.amr.corp.intel.com) ([10.2.230.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 06:35:40 -0800
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Liang_Xiao1@Dell.com, acelan.kao@canonical.com,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: [PATCH v2] PCI: vmd: Disable MSI remapping after suspend
Date:   Wed,  9 Nov 2022 07:26:52 -0700
Message-Id: <20221109142652.450998-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI remapping is disabled by VMD driver for Intel's Icelake and
newer systems in order to improve performance by setting
VMCONFIG_MSI_REMAP. By design VMCONFIG_MSI_REMAP register is cleared
by firmware during boot. The same register gets cleared when system
is put in S3 power state. VMD driver needs to set this register again
in order to avoid interrupt issues with devices behind VMD if MSI
remapping was disabled before.

Fixes: ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
---
v1->v2: Updating commit log and removing firmware dependency.
---
 drivers/pci/controller/vmd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..98e0746e681c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -980,6 +980,11 @@ static int vmd_resume(struct device *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(pdev);
 	int err, i;
 
+       if (vmd->irq_domain)
+               vmd_set_msi_remapping(vmd, true);
+       else
+               vmd_set_msi_remapping(vmd, false);
+
 	for (i = 0; i < vmd->msix_count; i++) {
 		err = devm_request_irq(dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
-- 
2.27.0

