Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8ED6D1F53
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCaLlH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCaLlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 07:41:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A17191DC
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680262855; x=1711798855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jjEGGgPz0GbhYtDqC8L4hcYvpxXr/OTr+haqh4WY0n4=;
  b=O40P9UfQUPQsqWsVfB0ljkfttW5FyJOQJmZ0Pvc8aCu1mYo8Kj7vn8/u
   khP/9Vxa/2cvqg+4zNPepkG4k967IsrT4SJory+zVaLmmpavMKAVcijUv
   zx3I637FykWNtf6dcrdx4AUEEU9zwMoohKZjQSrttKcKeeDaGrHewqFQx
   Hy6ypOxirc6Miseit6BkBSZ61Fr/P69gbaquGFLMfTKEoHXJ2JRQFW4Jc
   fpmO7nnU9YvJSfYrzTirqDqkZDDxB+zOH/sgX8Yfvq4gcMqHCThbji1Mf
   kDbO8uSHoU+3M97tnwjO4a9lNAtFcGOyNbG3Cyy20MJr6u22BjlAZXfNP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406442479"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="406442479"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 04:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="754389702"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="754389702"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 04:40:53 -0700
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        linux-pci@vger.kernel.org,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH] accel/ivpu: Remove D3hot delay for Meteorlake
Date:   Fri, 31 Mar 2023 13:40:27 +0200
Message-Id: <20230331114027.2803100-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Karol Wachowski <karol.wachowski@linux.intel.com>

VPU on MTL has hardware optimizations and does not require 10ms
D0 - D3hot transition delay imposed by PCI specification.

The delay removal is traditionally done by adding PCI ID to
quirk_remove_dhot_delay() in drivers/pci/quirks.c . But since
we do not need that optimization before driver probe and we
can better specify in the ivpu driver on what (future) hardware
use the optimization, we do not use quirk_remove_dhot_delay()
for that.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 3be4a5a2b07a..cf9925c0a8ad 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -442,6 +442,10 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
 	/* Clear any pending errors */
 	pcie_capability_clear_word(pdev, PCI_EXP_DEVSTA, 0x3f);
 
+	/* VPU MTL does not require PCI spec 10m D3hot delay */
+	if (ivpu_is_mtl(vdev))
+		pdev->d3hot_delay = 0;
+
 	ret = pcim_enable_device(pdev);
 	if (ret) {
 		ivpu_err(vdev, "Failed to enable PCI device: %d\n", ret);
-- 
2.25.1

