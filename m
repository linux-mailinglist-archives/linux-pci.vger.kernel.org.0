Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80BC61FD80
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 19:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiKGS1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 13:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiKGS1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 13:27:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317ED95
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 10:27:43 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312272308"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312272308"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:27:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="965268085"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="965268085"
Received: from ykhasin-mobl.amr.corp.intel.com (HELO fmmunozr-desk.intel.com) ([10.212.16.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:27:39 -0800
From:   Francisco@vger.kernel.org, Munoz@vger.kernel.org,
        Ruiz@vger.kernel.org
To:     helgaas@kernel.org
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Subject: [PATCH] PCI: vmd: Disable MSI remapping after suspend
Date:   Mon,  7 Nov 2022 10:27:35 -0800
Message-Id: <20221107182735.381552-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,FROM_ADDR_WS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Nirmal Patel <nirmal.patel@linux.intel.com>

MSI remapping is disbaled by VMD driver for intel's icelake and
newer systems in order to improve performance by setting MSI_RMP_DIS
bit. By design MSI_RMP_DIS bit of VMCONFIG registers is cleared.
The same register gets cleared when system is put in S3 power state.
VMD driver needs to set this register again in order to avoid
interrupt issues with devices behind VMD if MSI remapping was
disabled before.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e06e9f4fc50f..247012b343fd 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -980,6 +980,9 @@ static int vmd_resume(struct device *dev)
 	struct vmd_dev *vmd = pci_get_drvdata(pdev);
 	int err, i;
 
+	if (!vmd->irq_domain)
+		vmd_set_msi_remapping(vmd, false);
+
 	for (i = 0; i < vmd->msix_count; i++) {
 		err = devm_request_irq(dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
-- 
2.34.1

