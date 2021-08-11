Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF093E9822
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHKTAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 15:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKTAW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 15:00:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7FAD6105A;
        Wed, 11 Aug 2021 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708398;
        bh=BQRXln0y6wLV4k20ZkRVhlrdc9dZr9XLxCyyaete1k4=;
        h=From:To:Cc:Subject:Date:From;
        b=GVvpQ0CX8hNGBPrqpSr+5l80BNRx37rM7dymVXPCW9zbgQ0TepkJ2+Mm9H/7PiSr+
         jIqHCXqAydrzSlxnlzxc+D0PLUmWkgLH0N8gPAphMKdr/yUXVl8wMYSGPzUah8S54a
         xzM1w42SseuB5ClgU7b/8PNpkn1ZTPEfJ9tqFxizPfMsalxn39Gq04t4jUOItedUlU
         v3KziQyttx8Enf7YA+Do/kw+x+l8oRo9IuUBF+wZ/ySfnH+5Rnz0kphVqRkUTitrmT
         r4y/f1fEmpH3sG8RWdTU92QTgXXf/AP0vQ8gEiNKwe04Dar25ZqYZy3PyBX03XYMti
         3I42RsgPbmrOg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     bhelgaas@google.com
Cc:     david.e.box@linux.intel.com, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] pci: ptm: remove error message at boot
Date:   Wed, 11 Aug 2021 11:59:55 -0700
Message-Id: <20210811185955.3112534-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 39850ed51062 ("PCI/PTM: Save/restore Precision
Time Measurement Capability for suspend/resume") devices
which have PTM capability but don't enable it see this
message on calls to pci_save_state():

  "no suspend buffer for PTM"

Drop the message, it's perfectly fine not to use a capability.

Fixes: 39850ed51062 ("PCI/PTM: Save/restore Precision Time Measurement Capability for suspend/resume")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/pci/pcie/ptm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 95d4eef2c9e8..4810faa67f52 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -60,10 +60,8 @@ void pci_save_ptm_state(struct pci_dev *dev)
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for PTM\n");
+	if (!save_state)
 		return;
-	}
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
-- 
2.31.1

