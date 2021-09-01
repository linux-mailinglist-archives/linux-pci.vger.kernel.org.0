Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E93FDD02
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 15:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbhIANC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347203AbhIANBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 09:01:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4B9C014DCD
        for <linux-pci@vger.kernel.org>; Wed,  1 Sep 2021 05:41:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x16so1434144pll.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Sep 2021 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IhNTlkGHdrjxCeYNOPElSJ3gqKI6hv7bM76gTgtFoCs=;
        b=DSpR7dGFMQff9Dfh/sqPdzhuU7c7MPCQSw2LgS30p9RThKLbe2707xOxPOMzeMwGWN
         EIlQVHmVDPsyOaa7IRz54vknDC2dpF/LDLme0Pe5nsx8Xq1G2KNeeuLwwgrsjY+SM2hK
         IpA+3kGethmMYlFeesu4EzZY9nARzGMt+IOm1k2NXWLrUCd5beDyXQP0L7DlTUWrzkHF
         WwOyKozZodHu0dBaVeHodYuRxPPUavyvJkJeg+C8tNYR/RtWHTxjotIj+qHZ96JUSekm
         vJxqAV8acpJX9VSZffQd5tahE9MBu8c9aFv40vjOhdtySJq5sg1wVti8FrPnD+2Ylt9u
         y+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IhNTlkGHdrjxCeYNOPElSJ3gqKI6hv7bM76gTgtFoCs=;
        b=Z58JHHaekh5oNh0CV2dTH/lr6Sfm6PezoTA71luOv4MdZ1iwYT8vmzi/EW7KFpuK9v
         GZgD99UUboj/NSgw5142xwsWjHJFFEt9AdyfzvJiwctjIx6FOHEVzIbzOr1w8u5zqCfK
         vO9ux2QMFo+dH/fkF0qsRXNaqG+OVi5qlAy1m9DkbTQNqpydzUxb/g1zJb26sINKGUYn
         m9vCR7AUNyXBhmzMV2h3HXUU6ytvWV9bI2VwTliImKZX8VH1ZoevqK1dAfiTp3ZdZQz8
         68XdXKfUvQqFNMp36PyA22vxJ9GMeJ1UXzyLOi3qlMiB95UirFOV5rxr6Ii+ipXMfPqM
         wpfA==
X-Gm-Message-State: AOAM530tbV1PJwg/iUVKxRRCpgVndJpwyJdkS5+YyIE6HqStclt+/Wc8
        oOud8DXiNJW50lMte6ksOPn4JAtkQSTfFQ==
X-Google-Smtp-Source: ABdhPJwL42Bjxa3WEBckNPTM9XJJ5BYHMm/Tca4KPAevtlU7F+QwRHMOEbNFJQeDrYGIlizmB3HT7w==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr11417521pjg.202.1630500113465;
        Wed, 01 Sep 2021 05:41:53 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (1-174-53-39.dynamic-ip.hinet.net. [1.174.53.39])
        by smtp.gmail.com with ESMTPSA id u24sm22613783pfm.27.2021.09.01.05.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 05:41:53 -0700 (PDT)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU
Date:   Wed,  1 Sep 2021 20:40:47 +0800
Message-Id: <20210901124047.1615-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

When enabling VMD in BIOS setup (Ice Lake Processor: Whitley platform),
the host OS cannot boot successfully with the following error message:

  nvme nvme0: I/O 12 QID 0 timeout, completion polled
  nvme nvme0: Shutdown timeout set to 6 seconds
  DMAR: DRHD: handling fault status reg 2
  DMAR: [INTR-REMAP] Request device [0x00:0x00.5] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request

The request device is the VMD controller:
  # lspci -s 0000:00.5 -nn
  0000:00:00.5 RAID bus controller [0104]: Intel Corporation Volume
  Management Device NVMe RAID Controller [8086:28c0] (rev 04)

`git bisect` points to this offending commit ee81ee84f873 ("PCI:
vmd: Disable MSI-X remapping when possible"), which disables VMD MSI
remapping. The IOMMU hardware blocks the compatibility format
interrupt request because Interrupt Remapping Enable Status (IRES) and
Extended Interrupt Mode Enable (EIME) are enabled. Please refer to
section "5.1.4 Interrupt-Remapping Hardware Operation" in Intel VT-d
spec.

To fix the issue, VMD driver still enables the interrupt remapping
irrespective of VMD_FEAT_CAN_BYPASS_MSI_REMAP if the IOMMU subsystem
enables the interrupt remapping.

Test configuration is shown as follows:
  * Two VMD controllers
    1. 8086:28c0 (Whitley's VMD)
    2. 8086:201d (Purley's VMD: The issue does not appear in this
       controller. Just make sure if any side effect occurs.)
  * w/wo intremap=off

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214219
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/pci/controller/vmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e3fcdfec58b3..db72932d049f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -6,6 +6,7 @@
 
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -710,7 +711,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
 	 */
-	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
+	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
+	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
 	    offset[0] || offset[1]) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
-- 
2.27.0

