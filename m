Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264C517358
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiEBP6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiEBP6g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 11:58:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6687C62F6
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651506907; x=1683042907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kuDzaMktPfohoYY++LU5r69lRzBv+FXY+OwYq58ZVu4=;
  b=B/bg0iS2EhcuOx4h4dXdlqoIxe/P8G5rlaq/mJxg7DyYsiRKuk6Eq+4D
   /JfDalze+9C6oPxCZwPxSGZ0D4UTi1fZibZLXPLjOAA0UnlHw33SyS0Op
   1SVgvqOChAL7NiNtr4Lv0Kq7VmQl/BvMZSUWYmBPvoAa760hI1mNTyg5i
   EdIKBste1gLxmgax63Vfp/5h1SxkT9cP2rj6f6RLcVg1Up4ionSlNuUjc
   4UXKN0C2TVl3h6yJEaB6NP8VZQ6BlByBKReDru/2Fuk+iGy2B2iE2xTdL
   AkHuSP35eyTyRgOsKi2vnA3uVoKKeNV3mHBuTa52BWs+bWrzrzP66PbhC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353676486"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="353676486"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:54:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583761645"
Received: from unknown (HELO azvmdlinux1.ch.intel.com) ([10.2.230.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:54:10 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Date:   Mon,  2 May 2022 01:48:59 -0700
Message-Id: <20220502084900.7903-2-nirmal.patel@linux.intel.com>
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

VMD creates and assigns a separate IRQ domain when MSI-X remapping is
enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
MSI-X remapping is disabled resulting child devices getting default
PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
when VMD create a root bus and configures child devices.

As a result DMAR errors were observed when interrupt remapping was
enabled on Intel Icelake CPUs. For instance:

  DMAR: DRHD: handling fault status reg 2
  DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index eb05cceab964..5015adc04d19 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -853,6 +853,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
+	else
+		dev_set_msi_domain(&vmd->bus->dev,
+				   dev_get_msi_domain(&vmd->dev->dev));
 
 	vmd_acpi_begin();
 
-- 
2.26.2

