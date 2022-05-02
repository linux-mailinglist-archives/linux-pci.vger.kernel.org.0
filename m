Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81A517359
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbiEBP6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379602AbiEBP6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 11:58:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C8F3F
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651506915; x=1683042915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+sH+KYtpA3FTHJUlkj4OGG4z9G9ace9jIhjOhgviEk=;
  b=jtXJKzgxv6rYc+WDZotjsM1+0QH2kucS7f/IHsGkHc2rbcruRoJTHzpw
   8D6YAKm+2XXumKOgLgeqGgQkTthI3wtCB+oD+VdXZCbs09rXb+d+2oIc+
   nWSzfegb6Moyb8L9kmJuLMaSKzcqC9JsDcxN6QyKHkrXa0OWdjSKHl8v5
   ReFbe+nsarVrRxcha4/RakS/m2aH0hwS00K8u2SJ7CRzs54cJuLBBLPLm
   1XnpiKG0lOaJf/guix+BQhUM3QychaOvjQA/alFQZ5jnWh/ni+s9ccNGI
   E99Lqh5L5Z8Ma24bukpzZqa1oZrq5bq9sRti8sKEbdlloBuoeYPdeJlXR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353676516"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="353676516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:54:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583761672"
Received: from unknown (HELO azvmdlinux1.ch.intel.com) ([10.2.230.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:54:14 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH 2/2] PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
Date:   Mon,  2 May 2022 01:49:00 -0700
Message-Id: <20220502084900.7903-3-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220502084900.7903-1-nirmal.patel@linux.intel.com>
References: <20220502084900.7903-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if
interrupt remapping is enabled by IOMMU.")

The commit 2565e5b69c44 was added as a workaround to enable MSI-X
remapping if IOMMU enables interrupt remapping. VMD does not assign
proper IRQ domain to child devices when MSI-X remapping is disabled.
There is no dependency between MSI-X remapping by VMD and interrupt
remapping by IOMMU.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5015adc04d19..94a14a3d7e55 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -6,7 +6,6 @@
 
 #include <linux/device.h>
 #include <linux/interrupt.h>
-#include <linux/iommu.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -813,8 +812,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
 	 */
-	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
-	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
+	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
 	    offset[0] || offset[1]) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
-- 
2.26.2

