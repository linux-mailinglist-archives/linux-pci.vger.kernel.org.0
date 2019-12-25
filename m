Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB112A906
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2019 20:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfLYTVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Dec 2019 14:21:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726414AbfLYTVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Dec 2019 14:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577301708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OKuMH7cOPk6Y3exCZSCpC68iVYRRyyM9yHlIxnQYc5Q=;
        b=jR6KPAeLuFiVyr+Fg7kMlA3bx0NvDvsCFHLkA1t2Tlkunfe2D//j2ECqTqa/PN6nUNDA1E
        xpHxos+TZa2lNx2UFLrGj1u7mYfkARb+J568klhCNAdrUoxncQcfdbJvyBmmwMTSsGwY+y
        aV2gRr6KhxLbk7BICAAX11hGcVeEUcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-f0m36YqNNayB1z6IGVRPqw-1; Wed, 25 Dec 2019 14:21:44 -0500
X-MC-Unique: f0m36YqNNayB1z6IGVRPqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 533DD801E70;
        Wed, 25 Dec 2019 19:21:43 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C8AF101F6CF;
        Wed, 25 Dec 2019 19:21:40 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in kdump kernel
Date:   Thu, 26 Dec 2019 03:21:18 +0800
Message-Id: <20191225192118.283637-1-kasong@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are reports about kdump hang upon reboot on some HPE machines,
kernel hanged when trying to shutdown a PCIe port, an uncorrectable
error occurred and crashed the system.

On the machine I can reproduce this issue, part of the topology
looks like this:

[0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
          +-01.0-[02]--
          +-01.1-[05]--
          +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk=
)
          |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk=
)
          +-02.1-[0f]--
          +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array Gen9 C=
ontrollers

When shuting down PCIe port 0000:00:02.2 or 0000:00:02.0, the machine
will hang, depend on which device is reinitialized in kdump kernel.

If force remove unused device then trigger kdump, the problem will never
happen:

    echo 1 > /sys/bus/pci/devices/0000\:00\:02.2/0000\:07\:00.0/remove
    echo c > /proc/sysrq-trigger

    ... Kdump save vmcore through network, the NIC get reinitialized and
    hpsa is untouched. Then reboot with no problem. (If hpsa is used
    instead, shutdown the NIC in first kernel will help)

The cause is that some devices are enabled by the first kernel, but it
don't have the chance to shutdown the device, and kdump kernel is not
aware of it, unless it reinitialize the device.

Upon reboot, kdump kernel will skip downstream device shutdown and
clears its bridge's master bit directly. The downstream device could
error out as it can still send requests but upstream refuses it.

So for kdump, let kernel read the correct hardware power state on boot,
and always clear the bus master bit of PCI device upon shutdown if the
device is on. PCIe port driver will always shutdown all downstream
devices first, so this should ensure all downstream devices have bus
master bit off before clearing the bridge's bus master bit.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/pci/pci-driver.c | 11 ++++++++---
 drivers/pci/quirks.c     | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..84a7fd643b4d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/of_device.h>
 #include <linux/acpi.h>
+#include <linux/crash_dump.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
=20
@@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
 	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
+	 * If this is kdump kernel, also turn off Bus Master, the device
+	 * could be activated by previous crashed kernel and may block
+	 * it's upstream from shutting down.
+	 * Else, firmware will hit the PCI devices with big hammer
+	 * and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <=3D PCI_D3hot))
+	if ((kexec_in_progress || is_kdump_kernel()) &&
+			pci_dev->current_state <=3D PCI_D3hot)
 		pci_clear_master(pci_dev);
 }
=20
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..c65d11ab3939 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/switchtec.h>
+#include <linux/crash_dump.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
=20
@@ -192,6 +193,25 @@ static int __init pci_apply_final_quirks(void)
 }
 fs_initcall_sync(pci_apply_final_quirks);
=20
+/*
+ * Read the device state even if it's not enabled. The device could be
+ * activated by previous crashed kernel, this will read and correct the
+ * cached state.
+ */
+static void quirk_read_pm_state_in_kdump(struct pci_dev *dev)
+{
+	u16 pmcsr;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if (dev->pm_cap) {
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		dev->current_state =3D (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_read_pm_state_in_k=
dump);
+
 /*
  * Decoding should be disabled for a PCI device during BAR sizing to avo=
id
  * conflict. But doing so may cause problems on host bridge and perhaps =
other
--=20
2.24.1

