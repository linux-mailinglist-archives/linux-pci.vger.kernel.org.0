Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F496FAD29
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfKMJk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:40:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMJk6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:40:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so1057102pgn.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2019 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x5Ma/2fYehRTG5ezWaSxGaEsScRbdPNlXvlApAmtyE=;
        b=Z2XOngh2lAHBpwR0Oc1QhMrcpxkGjqXQn/4HTOf7Ps5ckQJ6U4Wf8Vdc70VPHQ4xEa
         AEHwAsw47GYMr2vFITmwNt2eZMkHpmgjrfcdnK1+g8Y69P1Eeq2G0iwYdMlF1WzxO2oQ
         oTgKY7Qpu6kuNX7TXwdc8PD0ZUbcinRYepk127lEDCb8TrMELmKcSJqAaBHGNb0kNVMH
         7mum5jJvv8OGsTnwfxxXPJBRZU+J7ROeSBwsRAExAX7aG3qbGwPaO3JfR8HjOOZdUWO/
         WVA5ifpyELJDGXbKwD4m5XR39PIBtOVK0ntT9o8TS+Yz+pPNJi0vLUqoiMT9FimU8SAK
         qyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6x5Ma/2fYehRTG5ezWaSxGaEsScRbdPNlXvlApAmtyE=;
        b=g0Q8TCN9Gci937afw3/zBnmc73dYFLY7PWkhgQ6dsosMVTEkNu3Hp+QHYQ4pPVuDim
         /XH8sNnnUa1GF8oqcnbN3/f+tRyj8TTSlS5nfEXYZUxI7J3icVjlWtI42u8ooEIrrGtD
         Wx/ESs3pfDZEjgUH03gKirVCQRVU8Q0wxtplwpTI3a9e2O+QdLRHXWXl/KlAj2NR8Uq/
         mJjXdjfYRxXgt8WdNjW/yFmWa1iIXXE4UbLHWabEYbNtyfTm589c5QSxa8qKTNwuFIqd
         2nY0o6xOV8rFsImN1A+H2kJxNfP27EV0vUhrefQae4LhExgnrwIEag21f7+YKaofhXvF
         0BMQ==
X-Gm-Message-State: APjAAAUjmUGyaO09axcZBeDMi4k7++zcHjtjKEKQlrMn5KWxXmGbFHva
        Dras9FeJKar4GydoGr0rKNZlzEAROO0=
X-Google-Smtp-Source: APXvYqwappcsOkJS+WTdmpv81YLqZONxehLVgBUJrsb7Im2JtGAqkgESh0/vFs2XU5d5nuf96yl+Yw==
X-Received: by 2002:a63:3281:: with SMTP id y123mr2671190pgy.252.1573638055898;
        Wed, 13 Nov 2019 01:40:55 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id s202sm2524461pfs.24.2019.11.13.01.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 01:40:55 -0800 (PST)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-pci@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH] powerpc/powernv: Disable native PCIe port management
Date:   Wed, 13 Nov 2019 20:40:35 +1100
Message-Id: <20191113094035.22394-1-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On PowerNV the PCIe topology is (currently) managed the powernv platform
code in cooperation with firmware. The PCIe-native service drivers bypass
both and this can cause problems.

Historically this hasn't been a big deal since the only port service
driver that saw much use was the AER driver. The AER driver relies
a kernel service to report when errors occur rather than acting autonmously
so it's fairly easy to ignore. On PowerNV (and pseries) AER events are
handled through EEH, which ignores the AER service, so it's never been
an issue.

Unfortunately, the hotplug port service driver (pciehp) does act
autonomously and conflicts with the platform specific hotplug
driver (pnv_php). The main issue is that pciehp claims the interrupt
associated with the PCIe capability which in turn prevents pnv_php from
claiming it.

This results in hotplug events being handled by pciehp which does not
notify firmware when the PCIe topology changes, and does not setup/teardown
the arch specific PCI device structures (pci_dn) when the topology changes.
The end result is that hot-added devices cannot be enabled and hot-removed
devices may not be fully torn-down on removal.

We can fix these problems by setting the "pcie_ports_disabled" flag during
platform initialisation. The flag indicates the platform owns the PCIe
ports which stops the portbus driver being registered.

Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
Sergey, just FYI. I'll try sort out the rest of the hotplug
trainwreck in 5.6.

The Fixes: here is for the patch that added pnv_php in 4.8. It's been
a problem since then, but wasn't noticed until people started testing
it after the EEH fixes in commit 799abe283e51 ("powerpc/eeh: Clean up
EEH PEs after recovery finishes") went in earlier in the 5.4 cycle.
---
 arch/powerpc/platforms/powernv/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2825d00..ae62583 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -941,6 +941,23 @@ void __init pnv_pci_init(void)
 
 	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
+#ifdef CONFIG_PCIEPORTBUS
+	/*
+	 * On PowerNV PCIe devices are (currently) managed in cooperation
+	 * with firmware. This isn't *strictly* required, but there's enough
+	 * assumptions baked into both firmware and the platform code that
+	 * it's unwise to allow the portbus services to be used.
+	 *
+	 * We need to fix this eventually, but for now set this flag to disable
+	 * the portbus driver. The AER service isn't required since that AER
+	 * events are handled via EEH. The pciehp hotplug driver can't work
+	 * without kernel changes (and portbus binding breaks pnv_php). The
+	 * other services also require some thinking about how we're going
+	 * to integrate them.
+	 */
+	pcie_ports_disabled = true;
+#endif
+
 	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
 	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return;
-- 
2.9.5

