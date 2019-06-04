Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9102B34EBA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfFDR0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 13:26:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfFDR0u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 13:26:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5618813AA9;
        Tue,  4 Jun 2019 17:26:45 +0000 (UTC)
Received: from gimli.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0890607C5;
        Tue,  4 Jun 2019 17:26:42 +0000 (UTC)
Subject: [PATCH] PCI/IOV: Fix VF cfg_size
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Jun 2019 11:26:42 -0600
Message-ID: <155966918965.10361.16228304474160813310.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 04 Jun 2019 17:26:50 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
other VFs") attempts to cache the config space size of VF0 to re-use
for all other VFs, but the cache is setup before the call to
pci_setup_device(), where we use set_pcie_port_type() to setup the
pcie_cap field on the struct pci_dev.  Without pcie_cap configured,
pci_cfg_space_size() returns PCI_CFG_SPACE_SIZE for the size.  VF0
has a bypass through pci_cfg_space_size(), so its size is reported
correctly, but all subsequent VFs incorrectly report 256 bytes of
config space.

Resolve by delaying pci_read_vf_config_common() until after
pci_setup_device().

Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for other VFs")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1714978
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/iov.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3aa115ed3a65..34b1f78f4d31 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -161,13 +161,13 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	virtfn->is_virtfn = 1;
 	virtfn->physfn = pci_dev_get(dev);
 
-	if (id == 0)
-		pci_read_vf_config_common(virtfn);
-
 	rc = pci_setup_device(virtfn);
 	if (rc)
 		goto failed1;
 
+	if (id == 0)
+		pci_read_vf_config_common(virtfn);
+
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->multifunction = 0;
 

