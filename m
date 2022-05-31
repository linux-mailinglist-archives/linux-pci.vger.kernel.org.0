Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D481538C51
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243813AbiEaH4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbiEaH4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 03:56:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560977220A;
        Tue, 31 May 2022 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653983771; x=1685519771;
  h=from:to:cc:subject:date:message-id;
  bh=lhnpqbk67ab3C0F5+yqnzu3Jp0YtzFvqnqVGOX76r5A=;
  b=RuiEgKmkl1My0TPDHs2uJVwenmVZSbTCnwIJgaAp0K9e8kO/jLe4aPn/
   p7A/2ENNVplRVRKkd2uJeac4L/e+qXA8LLQRFeGf+Sc7bZSegiCJ2AgE+
   Y+h3JYweZyvZAH3vHhybjvMk2vp+bhSSO7CZn6wgfxk8S4TNG997KhORi
   1kIIQYEBGPngBFhbt9Ywl2+NOb7eqorbxHiOGBAMvA7DYYsiQSLdAwUuA
   GhL1m8J4DSuYNNVdEMJk3Es4PEJI4300H5vwjx2fXm2x8eL6xDXzqDxrs
   67q8ac4KHkwAiSsCkGibX+oRmscsg3zVtHQy0MjguG/qO+Etic2GYVgqJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="272745827"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="272745827"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 00:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="903864531"
Received: from ubuntu-700f5.iind.intel.com ([10.99.115.212])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2022 00:56:08 -0700
From:   subramanian.mohan@intel.com
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com
Subject: [PATCH] PCI: vmd: Use devm_kasprintf instead of simple kasprintf
Date:   Tue, 31 May 2022 18:56:17 +0530
Message-Id: <20220531132617.20517-1-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Subramanian Mohan <subramanian.mohan@intel.com>

Use devm_kasprintf instead of simple kasprintf to free the allocated memory
automatically when the device is freed.

Suggested-by: Srikanth Thokala <srikanth.thokala@intel.com>
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index eb05cceab964..7a72948e001f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -897,7 +897,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->instance < 0)
 		return vmd->instance;
 
-	vmd->name = kasprintf(GFP_KERNEL, "vmd%d", vmd->instance);
+	vmd->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "vmd%d",
+				   vmd->instance);
 	if (!vmd->name) {
 		err = -ENOMEM;
 		goto out_release_instance;
@@ -935,7 +936,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
  out_release_instance:
 	ida_simple_remove(&vmd_instance_ida, vmd->instance);
-	kfree(vmd->name);
 	return err;
 }
 
@@ -958,7 +958,6 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
 	ida_simple_remove(&vmd_instance_ida, vmd->instance);
-	kfree(vmd->name);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.1

