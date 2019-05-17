Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8316721DC5
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfEQSs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 14:48:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 14:48:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 572B061911; Fri, 17 May 2019 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118906;
        bh=kxktoBS1pRxC6RjcDvLlbVi5FujSN7tU1/fCwkp4N1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+cBD/wgAuji8x3DM3EBuaUZIY74LTVd8UmahTFAPQDK3FEGlH2cXK7czD4W0Gnhy
         DyBvMOrF3nRa8HX9sjA+En4r8VaoFjYC9T97CUg0WbgOVzfFTeAJXusuDDcXgc5EcF
         GH1k9jCs5Pc+wf19rMhQb+Tgc3FMlTZFaVsI6DRs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 130DC619B4;
        Fri, 17 May 2019 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118903;
        bh=kxktoBS1pRxC6RjcDvLlbVi5FujSN7tU1/fCwkp4N1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oah+MUC4XK/B7pkRpWFBUR815EF6RciVl3rKTJKJxLWkgViTrFFKNgKx3dI9zv8jd
         39XErz3TKn2EA0vsInFzFBttxOm1NSEbxOfXYfDNb733H3WVCmr2iEWe4ToGQiS3FK
         S03hvzJMeM+iyTlN2SnGp1vtCSZigZqMzf3s435g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 130DC619B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, joro@8bytes.org,
        robin.murphy@arm.com, will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: [RFC/PATCH 3/4] iommu: Export core IOMMU functions to kernel modules
Date:   Fri, 17 May 2019 11:47:36 -0700
Message-Id: <1558118857-16912-4-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IOMMU drivers that can be compiled as modules need to use
some of the IOMMU core functions, so expose them.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/iommu-sysfs.c | 3 +++
 drivers/iommu/iommu.c       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 44127d5..b3dadb8 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -90,6 +90,7 @@ int iommu_device_sysfs_add(struct iommu_device *iommu,
 	put_device(iommu->dev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_sysfs_add);
 
 void iommu_device_sysfs_remove(struct iommu_device *iommu)
 {
@@ -122,6 +123,7 @@ int iommu_device_link(struct iommu_device *iommu, struct device *link)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_link);
 
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 {
@@ -131,3 +133,4 @@ void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 	sysfs_remove_link(&link->kobj, "iommu");
 	sysfs_remove_link_from_group(&iommu->dev->kobj, "devices", dev_name(link));
 }
+EXPORT_SYMBOL_GPL(iommu_device_unlink);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 109de67..2b92f35 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -103,6 +103,7 @@ int iommu_device_register(struct iommu_device *iommu)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_device_register);
 
 void iommu_device_unregister(struct iommu_device *iommu)
 {
@@ -813,6 +814,7 @@ struct iommu_group *iommu_group_ref_get(struct iommu_group *group)
 	kobject_get(group->devices_kobj);
 	return group;
 }
+EXPORT_SYMBOL_GPL(iommu_group_ref_get);
 
 /**
  * iommu_group_put - Decrement group reference
@@ -986,6 +988,7 @@ struct iommu_group *generic_device_group(struct device *dev)
 {
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(generic_device_group);
 
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
@@ -1053,6 +1056,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 	/* No shared group found, allocate new */
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(pci_device_group);
 
 /* Get the IOMMU group for device on fsl-mc bus */
 struct iommu_group *fsl_mc_device_group(struct device *dev)
@@ -1133,6 +1137,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	return group;
 }
+EXPORT_SYMBOL_GPL(iommu_group_get_for_dev);
 
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
@@ -1913,6 +1918,7 @@ struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 	region->type = type;
 	return region;
 }
+EXPORT_SYMBOL_GPL(iommu_alloc_resv_region);
 
 /* Request that a device is direct mapped by the IOMMU */
 int iommu_request_dm_for_dev(struct device *dev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

