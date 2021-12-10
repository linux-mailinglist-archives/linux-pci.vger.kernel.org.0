Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4606B47057D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbhLJQX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 11:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbhLJQX6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 11:23:58 -0500
X-Greylist: delayed 583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Dec 2021 08:20:23 PST
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C07C061746
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 08:20:23 -0800 (PST)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4J9bV547lpzQjwn;
        Fri, 10 Dec 2021 17:10:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Marek Vasut <marex@denx.de>
Subject: [RFC PATCH] PCI/MSI: Only mask all MSI-X entries when MSI-X is used
Date:   Fri, 10 Dec 2021 17:10:25 +0100
Message-Id: <20211210161025.3287927-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch moves the masking of the MSI-X entries to a later stage in
msix_capability_init(), which is not reached on platforms not
supporting MSI-X. Without this, MSI interrupts from a NVMe drive are not
received at all on this ZynqMP based platform, only supporting legacy
and MSI interrupts.

Background:
This patch fixes a problem on our ZynqMP based system working with newer
NVMe drives which support MSI & MSI-X. Running v5.4 all is fine and
these drives correctly configure an MSI interrupt and this IRQ is
received just fine in the ZynqMP rootport. But when updating to v5.10
or later (I also tested with v5.15 and v5.16-rc4) the MSI interrupt
gets assigned but no interrupts are received by the NVMe driver at all.

Note: The ZynqMP PCIe rootport driver only supports legacy and MSI
interrupts, not MSI-X (yet).

I've debugged the MSI integration of the ZynqMP PCIe rootport driver
(pcie-xilinx-nwl.c) and found no issues there. Also the MSI framework
in the Kernel did not reveal any problems - at least for me. Looking
a bit deeper into the lspci output, I found an interesting difference
between v5.4 and v5.10 (or later).

v5.4:
04:00.0 Non-Volatile memory controller: Marvell Technology Group Ltd. Device 1321 (rev 02) (prog-if 02 [NVM Express])
        ...
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
		Address: 00000000fd480000  Data: 0004
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
	...
	Capabilities: [b0] MSI-X: Enable- Count=67 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	...

v5.10:
04:00.0 Non-Volatile memory controller: Marvell Technology Group Ltd. Device 1321 (rev 02) (prog-if 02 [NVM Express])
        ...
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
                Address: 00000000fd480000  Data: 0004
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
        ...
        Capabilities: [b0] MSI-X: Enable- Count=67 Masked+
                Vector table: BAR=0 offset=00002000
                PBA: BAR=0 offset=00003000
        ...

So the only difference here being the "Masked+" compared to the
"Masked-" in the working v5.4 Kernel. Testing in this area has shown,
that the root cause for the masked bit being set was the call to
msix_mask_all() in msix_capability_init(). Without this, all works just
fine and the MSI interrupts are received again by the NVMe driver.

BTW: I've also tested this problem with the latest version of Thomas's
PCI/MSI Spring cleaning on top of v5.16-rc4. No change - the masked bit
is still set and the MSI interrupt are note received by the NVMe driver.

I'm open to other ideas to fix this issue. So please review and comment.

Fixes: aa8092c1d1f1 ("PCI/MSI: Mask all unused MSI-X entries")
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/pci/msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a7a1c7411348..25b659dd5e2b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -825,9 +825,6 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 		goto out_disable;
 	}
 
-	/* Ensure that all table entries are masked. */
-	msix_mask_all(base, tsize);
-
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
 		goto out_disable;
@@ -836,6 +833,9 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	if (ret)
 		goto out_avail;
 
+	/* Ensure that all table entries are masked. */
+	msix_mask_all(base, tsize);
+
 	/* Check if all MSI entries honor device restrictions */
 	ret = msi_verify_entries(dev);
 	if (ret)
-- 
2.34.1

