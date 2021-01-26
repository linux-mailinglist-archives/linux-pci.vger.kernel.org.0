Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC33054E8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317158AbhAZXcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404663AbhAZTve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 14:51:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0DB222B2C;
        Tue, 26 Jan 2021 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611690648;
        bh=/6ngywS810oXL2ZA1A4zcs8uV/FXPP53uDQM5zBbkwM=;
        h=From:To:Cc:Subject:Date:From;
        b=nac9SDFmG9oX4kG01dO+elCsbd182MDOZNKBY25QVfMXGNtTi2SRohLDsEvkXLyLX
         JQeI/D7hch3yS7BQP1yGU5/0ES3eaGXsd7pyXOeJFb7Wq+DdmCxwiGddsUD86o9U29
         ZK5HG0LZSIS27WlJ0ACtqd7CvehtAyqdTUhbHHy8Cw9bvbNBMUXSfVisB1BSrDR0ns
         LsJmwNl32NfluNr+HJiFMIMDe//5g5e1P8MvXgDQGQjT3zko6g26EUb5gha/nLgXGP
         7w0wks0rLmp+9X2RLeETkn7r8M1RVYhknuxWKoqm8Hq0aIgDFK9DMwM87ySNsUXFo6
         OGKZB0giQ1gtw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Fix "ordering" comment typos
Date:   Tue, 26 Jan 2021 13:50:42 -0600
Message-Id: <20210126195042.2909405-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix comment typos in "ordering".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/s390/include/asm/facility.h             | 2 +-
 drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


Unless somebody objects, I'll just merge these typo fixes via the PCI tree.


diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index 68c476b20b57..91b5d714d28f 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -44,7 +44,7 @@ static inline int __test_facility(unsigned long nr, void *facilities)
 }
 
 /*
- * The test_facility function uses the bit odering where the MSB is bit 0.
+ * The test_facility function uses the bit ordering where the MSB is bit 0.
  * That makes it easier to query facility bits with the bit number as
  * documented in the Principles of Operation.
  */
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 6e7f16f4cec7..dab190a547cc 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -141,7 +141,7 @@ static void qxl_drm_release(struct drm_device *dev)
 
 	/*
 	 * TODO: qxl_device_fini() call should be in qxl_pci_remove(),
-	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
+	 * reordering qxl_modeset_fini() + qxl_device_fini() calls is
 	 * non-trivial though.
 	 */
 	qxl_modeset_fini(qdev);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 597bc88479ba..04fbfe5cbeb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -866,7 +866,7 @@ struct iwl_fw_dbg_trigger_time_event {
  * tx_bar: tid bitmap to configure on what tid the trigger should occur
  *	when a BAR is send (for an Rx BlocAck session).
  * frame_timeout: tid bitmap to configure on what tid the trigger should occur
- *	when a frame times out in the reodering buffer.
+ *	when a frame times out in the reordering buffer.
  */
 struct iwl_fw_dbg_trigger_ba {
 	__le16 rx_ba_start;
-- 
2.25.1

