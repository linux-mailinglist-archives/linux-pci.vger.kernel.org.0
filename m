Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC829B40
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbfEXPi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 11:38:26 -0400
Received: from libmpq.org ([85.25.94.4]:51036 "EHLO mail.libmpq.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389385AbfEXPi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 11:38:26 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 11:38:26 EDT
Received: from libmpq.org (homer.theraso.int [172.16.50.110])
        by mail.libmpq.org (Postfix) with ESMTPSA id BD655395A52;
        Fri, 24 May 2019 17:31:18 +0200 (CEST)
Date:   Fri, 24 May 2019 17:31:18 +0200
From:   Maik Broemme <mbroemme@libmpq.org>
To:     linux-pci <linux-pci@vger.kernel.org>
Cc:     vfio-users <vfio-users@redhat.com>
Subject: [PATCH] PCI: Mark Intel bridge on SuperMicro Atom C3xxx motherboards
 to avoid bus reset
Message-ID: <20190524153118.GA12862@libmpq.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux homer.theraso.int 5.1.4-arch1-1-ARCH 
X-PGP-Key-FingerPrint: 109D 0AC6 86CF 06BD 4890  17B0 8FB9 9971 4EEB 31F1
Organization: Personal
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Intel PCI bridge on SuperMicro Atom C3xxx motherboards do not
successfully complete a bus reset when used with certain child devices.
After the reset, config accesses to the child may fail. If assigning
such device via VFIO it will immediately fail with:

  vfio-pci 0000:01:00.0: Failed to return from FLR
  vfio-pci 0000:01:00.0: timed out waiting for pending transaction;
  performing function level reset anyway

Device will disappear from PCI device list:

  !!! Unknown header type 7f
  Kernel driver in use: vfio-pci
  Kernel modules: ddbridge

The attached patch will mark the root port as incapable of doing a
bus level reset. After that all my tested devices survive a VFIO
assignment and several VM reboot cycles.

Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
---
 drivers/pci/quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f16acc323c6..86cd42872708 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3433,6 +3433,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
 
+/*
+ * Root port on some SuperMicro Atom C3xxx motherboards do not successfully
+ * complete a bus reset when used with certain child devices. After the
+ * reset, config accesses to the child may fail.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19a4, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.21.0
