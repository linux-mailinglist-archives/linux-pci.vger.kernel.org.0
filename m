Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13546D4437
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjDCMQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 08:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDCMQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 08:16:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE031041C
        for <linux-pci@vger.kernel.org>; Mon,  3 Apr 2023 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680524189; x=1712060189;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=whNP+0koM8deNDJey5OeUVBeeth6de3kWBBSNYmIzFA=;
  b=JkoYkMahciA3PwIfvEgA4vkUn7eqgCCoj34tLF7yt/u70k1h0KcntN8q
   y/dYdZDoUT3H+1NEkciLFxLkrdQGeZI6CLMWphG+95NB396JpSvpmDDGY
   bkFSTix0IYZ+cjn4wGsDxL665ZmcN+1mc5xh9Xo7sP9o/yRWi1/++iK2/
   N9Q5C0ykwVCjxZ9NVIlZ2eXjTG/+SYq5aObNX/078sAzJXacdcAg/7ml5
   i7CiGwNk7HTyPOWzexS5KdaHR+5K4nP8Rms+jOfueKUAWVbDthKPoxsym
   VrDI+aTlBtIznQO6eeXRF8Y7zdOQ/8g2k/w8wsCsWTqCuxzLt3LfqX3xB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="330452333"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="330452333"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 05:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="718529676"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="718529676"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 05:16:26 -0700
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v2] accel/ivpu: Remove D3hot delay for Meteorlake
Date:   Mon,  3 Apr 2023 14:15:45 +0200
Message-Id: <20230403121545.2995279-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Karol Wachowski <karol.wachowski@linux.intel.com>

VPU on MTL has hardware optimizations and does not require 10ms
D0 - D3hot transition delay imposed by PCI specification (PCIe
r6.0, sec 5.9.) .

The delay removal is traditionally done by adding PCI ID to
quirk_remove_d3hot_delay() in drivers/pci/quirks.c . But since
we do not need that optimization before driver probe and we
can better specify in the ivpu driver on what (future) hardware
use the optimization, we do not use quirk_remove_d3hot_delay()
for that.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
v2: improve commit log message

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

