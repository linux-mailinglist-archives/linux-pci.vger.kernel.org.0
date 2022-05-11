Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C28523B19
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiEKRDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiEKRDo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 13:03:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE14C9ED2
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652288623; x=1683824623;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gzu1Y4DQFge3Rz3e1+l9bKTSqic9Fb1Uc/g71Fnzx8g=;
  b=HdRmMylUIvrO0p69e7stJvkOkv8ydDT0D4J6nMuMsWHq9SOITIlMJnll
   WylZ3dyo2+pSglzF4syOgb5gGzzSA31dxrnGErGvrBAgDAmMKQv826E3L
   4FRxtqe8v5RfXKW+6E0IhkhZ6OvSPNpd9+/6QM5UBwRcbuAy0QFGFW35J
   B/Ipd6Xe7iLWO7FCFQNQQdyUBJTD+e4tevkbUVlfCbBwRYEkAxdvhQ6mP
   L+jLT7zEg9VHJeDLgEogRnFtIX7wRmDuwe9ULIDI/vyCK4vc28HDBLvSn
   Pzy33v6lBbBAzJivNEljvEJMGmtFbihC9FTKFKSE937ua4XCKXgKe1sYQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257304503"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="257304503"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:03:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="542391592"
Received: from azvmdlinux1.ch.intel.com ([10.2.230.15])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:03:31 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: vmd: Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
Date:   Wed, 11 May 2022 02:57:07 -0700
Message-Id: <20220511095707.25403-3-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
References: <20220511095707.25403-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Revert 2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if
interrupt remapping is enabled by IOMMU.")

The commit 2565e5b69c44 was added as a workaround to keep MSI-X
remapping enabled if IOMMU enables interrupt remapping. VMD would keep
running in low performance mode. There is no dependency between MSI-X
remapping by VMD and interrupt remapping by IOMMU.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
v1->v2: Add more information to the commit log.
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

