Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEEFFEE7
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 07:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKRG4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 01:56:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45989 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKRG4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 01:56:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so9883158pfn.12
        for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2019 22:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jh9Xf7UIdPMx7Id72kMrL4Yoelm45a9tP9VAeHLYcMk=;
        b=QO01wbrQ7iqGOHNUo7vjA1kqQMDV3AIlh+4w9cqJV5qSP03TsklDWBavoFXuMjZh5+
         pnlwNXFVW+EzjiT6y/eUkEj9fqO0fDj8Aeu8LpHNjuckt9UAsP0wZbWR08t94L24FGPU
         Ggug1CIBXNxIiSN0+oAOF8mNLUPn0NwNkbtRH/281KleV/BekjbyM5s0GetFRUuI+VC0
         Bnr55O1POhxzJqT9sJh/aXRygVJ4Zos04m5HUANMAll6F7GJNBg5whrVX+TDxjMXVAy8
         xzW+6Q+Y8/WgsEJh0TLMezmrbejyMMGeSTsqA2LwfSW6h/7ffX1foaCdUf8EzjjLHcc8
         +iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jh9Xf7UIdPMx7Id72kMrL4Yoelm45a9tP9VAeHLYcMk=;
        b=ZTVb0rahP5DrlwO0IW3lygUgrdbP4bgmYh0iML3jA/rcMCz97dvb9PAfRh3fBX+M3I
         IixKOgGvj+X4QgFojuVRoyIsifub8bHgWZhj2moFPISE1ScVBLjhvWmjMZG2cWGEnmex
         NMZZKmCx6y48tNPw9PwP7133Yv50hnPfLxWbvs6HrMSNgdOjoiCynQjaiGk4y21Lp2sh
         AeHBcIEq5GpwvFmHSw8tCza0NQY/aTJCvXqorsKQ4IpRQbx/qWL/kWos202Pdij9zfMX
         20DYWAm5Q4UPyr2lLNyvag+p53lBzGKittJNNFWL8hi28nhqCV1dLShB2zDNT9PEv4OV
         dlMQ==
X-Gm-Message-State: APjAAAUci7UeSdsKEq2WXU3tpHiZHTJ01/rptgG7I/Uy8hdRpNnV7a9c
        8caY/oXZWWHrnh0TlC08tc0=
X-Google-Smtp-Source: APXvYqxrGg1jltWZbiXt/dVIjVSTm0P4GAAR2VohfW1A7pgAiWDZW3kVeWLS7kUF+Ruz8RlKraBn1g==
X-Received: by 2002:a63:1057:: with SMTP id 23mr16501207pgq.171.1574060165494;
        Sun, 17 Nov 2019 22:56:05 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id w138sm21131774pfc.68.2019.11.17.22.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 22:56:04 -0800 (PST)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-pci@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v2] powerpc/powernv: Disable native PCIe port management
Date:   Mon, 18 Nov 2019 17:55:53 +1100
Message-Id: <20191118065553.30362-1-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On PowerNV the PCIe topology is (currently) managed by the powernv platform
code in Linux in cooperation with the platform firmware. Linux's native
PCIe port service drivers operate independently of both and this can cause
problems.

The main issue is that the portbus driver will conflict with the platform
specific hotplug driver (pnv_php) over ownership of the MSI used to notify
the host when a hotplug event occurs. The portbus driver claims this MSI on
behalf of the individual port services because the same interrupt is used
for hotplug events, PMEs (on root ports), and link bandwidth change
notifications. The portbus driver will always claim the interrupt even if
the individual port service drivers, such as pciehp, are compiled out.

The second, bigger, problem is that the hotplug port service driver
fundamentally does not work on PowerNV. The platform assumes that all
PCI devices have a corresponding arch-specific handle derived from the DT
node for the device (pci_dn) and without one the platform will not allow
a PCI device to be enabled. This problem is largely due to historical
baggage, but it can't be resolved without significant re-factoring of the
platform PCI support.

We can fix these problems in the interim by setting the
"pcie_ports_disabled" flag during platform initialisation. The flag
indicates the platform owns the PCIe ports which stops the portbus driver
from being registered.

This does have the side effect of disabling all port services drivers
that is: AER, PME, BW notifications, hotplug, and DPC. However, this is
not a huge disadvantage on PowerNV since these services are either unused
or handled through other means.

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
v2: Moved setting the flag until after we check for OPAL support. No
    actual functional change since we've already probed the platform,
    but it looks neater.

    Re-wrote the commit message.
---
 arch/powerpc/platforms/powernv/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2825d00..c0bea75a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -945,6 +945,23 @@ void __init pnv_pci_init(void)
 	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return;
 
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
 	/* Look for IODA IO-Hubs. */
 	for_each_compatible_node(np, NULL, "ibm,ioda-hub") {
 		pnv_pci_init_ioda_hub(np);
-- 
2.9.5

