Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390F6105D9B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 01:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKVAWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 19:22:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbfKVAWI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 19:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574382126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rUekpHztE4Y/AJCnx5fkeLUBunhkT4upfB7DGt7EVwQ=;
        b=Wl9bPyXBOdzMKxcAAiAhA8X1sZozUZxdLAssRoqazZfpvBTKm2HIyjvxJSnvLDyuJSyOR8
        s8XbUPDdDZFXl5o2MvE+MboW5gCGIjT7xJbRd/Q9dJz0oUHpvdEJpoQo2ypAlwRqnyw1B/
        jdyTvKUbI7TQBtER6gIspNJgEmpz5/8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Pnahy1_BO-6KWN3u5agVog-1; Thu, 21 Nov 2019 19:22:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so2988302wrr.5
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2019 16:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W1fJRPx8jNVd2/thMPiixkjKvF9zObui3jPum3g5eVQ=;
        b=I9DtWSfGLjaSX6o7Sr5s70F1cy1hZhcTCoSbrGR78hTFScilZLtfegX2ZtPtuVgLon
         +AOgjxu3upAce3HLCwpyekWtadLhlYJkeI/oigPgHP9fyMIVuoS764EZPqaQYBJ35MG+
         u/JWNxVeSx36FykXTL+oSBbMyHGZKvYOEH0tarCmpGyWEwfODSYEjKDbFC+brbu+o8Eo
         ROFH0MD46BPiFOJ6h10LBGR91wztYP8kvWpbKrrZAqTnRfdfuUvpC+eGBmJVcF8C5u54
         Rv2HXdPnmykEf6xE+kxeMJ5hal01lJRjj06oHY4AmEWVR9Aocwg3hMrHE3O1iVkv3IDd
         roWw==
X-Gm-Message-State: APjAAAWap0uaOwKZOBoUpi64Dhtm6wcuSojVsuPN5bDsLTY5fN+UV8DU
        whbUwVqtHtX69eCeJDVsR2hBNjClovqf/U2PNN28Gy28iIk9PapJDnR1VTwEs1QUuIofqkYWyRI
        0hYRPm57K+PAy3LdopLR/
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr14748011wra.246.1574382123125;
        Thu, 21 Nov 2019 16:22:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoJAmffZuZMuES1MgzeSD7DVWMT78Ozvsm2ZLIe1GjyavVRSTTjvnluR6Q46fXQRM4NmNd1A==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr14747987wra.246.1574382122838;
        Thu, 21 Nov 2019 16:22:02 -0800 (PST)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:f836:f331:d633:a9f0])
        by smtp.gmail.com with ESMTPSA id d16sm3510565wrg.27.2019.11.21.16.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 16:22:01 -0800 (PST)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v5] pci: prevent putting nvidia GPUs into lower device states on certain intel bridges
Date:   Fri, 22 Nov 2019 01:21:59 +0100
Message-Id: <20191122002159.4159-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: Pnahy1_BO-6KWN3u5agVog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher devic=
e
states.

v2: convert to pci_dev quirk
    put a proper technical explanation of the issue as a in-code comment
v3: disable it only for certain combinations of intel and nvidia hardware
v4: simplify quirk by setting flag on the GPU itself
v5: restructure quirk to make it easier to add new IDs
    fix whitespace issues
    fix potential NULL pointer access
    update the quirk documentation

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D205623
---
 drivers/pci/pci.c    |  7 ++++++
 drivers/pci/quirks.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 59 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 57f15a7e6f0b..e08db2daa924 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev=
, pci_power_t state)
 =09   || (state =3D=3D PCI_D2 && !dev->d2_support))
 =09=09return -EIO;
=20
+=09/*
+=09 * Check if we have a bad combination of bridge controller and nvidia
+=09 * GPU, see quirk_broken_nv_runpm for more info
+=09 */
+=09if (state !=3D PCI_D0 && dev->broken_nv_runpm)
+=09=09return 0;
+
 =09pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
=20
 =09/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44c4ae1abd00..24e3f247d291 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5268,3 +5268,54 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(st=
ruct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 =09=09=09      PCI_CLASS_DISPLAY_VGA, 8,
 =09=09=09      quirk_reset_lenovo_thinkpad_p50_nvgpu);
+
+/*
+ * Some Intel PCIe bridge controllers cause devices to not reappear doing =
a
+ * D0 -> D3hot -> D3cold -> D0 sequence. Skipping the intermediate D3hot s=
tep
+ * seems to make it work again.
+ *
+ * This leads to various manifestations of this issue:
+ *  - AIML code execution hits an infinite loop (as the coe waits on devic=
e
+ *    memory to change).
+ *  - kernel crashes, as all PCI reads return -1, which most code isn't ab=
le
+ *    to handle well enough.
+ *  - sudden shutdowns, as the kernel identified an unrecoverable error af=
ter
+ *    userspace tries to access the GPU.
+ *
+ * In all cases dmesg will contain at least one line like this:
+ * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
+ * followed by a lot of nouveau timeouts.
+ *
+ * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of t=
he
+ * Intel PCIe bridge controller (0x1901) in order to power down the GPU.
+ * Nonetheless, there are other code paths inside the ACPI firmware which =
use
+ * other registers, which seem to work fine:
+ *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
+ *  - 0xb0 bit 0x10 (link disable)
+ * Changing the conditions inside the firmware by poking into the relevant
+ * addresses does resolve the issue, but it seemed to be ACPI private memo=
ry
+ * and not any device accessible memory at all, so there is no portable wa=
y of
+ * changing the conditions.
+ *
+ * The only systems where this behavior can be seen are hybrid graphics la=
ptops
+ * with a secondary Nvidia Maxwell, Pascal or Turing GPU. It cannot be rul=
ed
+ * out that this issue only occurs in combination with listed Intel PCIe
+ * bridge controllers and the mentioned GPUs or if it's only a hw bug in t=
he
+ * bridge controller.
+ */
+
+static void quirk_broken_nv_runpm(struct pci_dev *dev)
+{
+=09struct pci_dev *bridge =3D pci_upstream_bridge(dev);
+
+=09if (!bridge || bridge->vendor !=3D PCI_VENDOR_ID_INTEL)
+=09=09return;
+
+=09switch (bridge->device) {
+=09case 0x1901:
+=09=09dev->broken_nv_runpm =3D 1;
+=09}
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+=09=09=09      PCI_BASE_CLASS_DISPLAY, 16,
+=09=09=09      quirk_broken_nv_runpm);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ac8a6c4e1792..903a0b3a39ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -416,6 +416,7 @@ struct pci_dev {
 =09unsigned int=09__aer_firmware_first_valid:1;
 =09unsigned int=09__aer_firmware_first:1;
 =09unsigned int=09broken_intx_masking:1;=09/* INTx masking can't be used *=
/
+=09unsigned int=09broken_nv_runpm:1;=09/* some combinations of intel bridg=
e controller and nvidia GPUs break rtd3 */
 =09unsigned int=09io_window_1k:1;=09=09/* Intel bridge 1K I/O windows */
 =09unsigned int=09irq_managed:1;
 =09unsigned int=09has_secondary_link:1;
--=20
2.23.0

