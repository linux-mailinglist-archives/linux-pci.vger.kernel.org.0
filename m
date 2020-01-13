Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC98138BA2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 07:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAMGIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 01:08:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:47086 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgAMGIk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 01:08:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 22:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,427,1571727600"; 
   d="scan'208";a="304750793"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga001.jf.intel.com with ESMTP; 12 Jan 2020 22:08:38 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pci@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/PM: Print the pci config space of devices before suspend
Date:   Mon, 13 Jan 2020 14:07:24 +0800
Message-Id: <20200113060724.19571-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci config space was found to be insane during resume
from hibernation(S4, or suspend to disk) on a VM:

 serial 0000:00:16.3: restoring config space at offset 0x14
 (was 0x9104e000, writing 0xffffffff)

Either the snapshot on the disk has been scribbled or the pci
config space becomes invalid before suspend. To narrow down
and benefit future debugging, print the pci config space
being saved before suspend, which is symmetric to the log
in pci_restore_config_dword().

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/pci/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1a7f..34cde70440c3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1372,8 +1372,11 @@ int pci_save_state(struct pci_dev *dev)
 {
 	int i;
 	/* XXX: 100% dword access ok here? */
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
+		pci_dbg(dev, "saving config space at offset %#x (reading %#x)\n",
+			i * 4, dev->saved_config_space[i]);
+	}
 	dev->state_saved = true;
 
 	i = pci_save_pcie_state(dev);
-- 
2.17.1

