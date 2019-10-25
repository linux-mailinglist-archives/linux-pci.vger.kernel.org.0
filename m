Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D3E540E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfJYTBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 15:01:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46478 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfJYTBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:01:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so2727741oth.13;
        Fri, 25 Oct 2019 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5z1PSBgdgyQOytDnCk9ConnRnIEa9FCO7qAX4IBOjg=;
        b=PJR6qPoJhGzD2iY34kYY2aCojvTvVyGGQ50jdgZUn3ZWdcE6A+Bq4nxX1ey0iQOvCm
         k1IiGP8UVGMbLRj09YCC5P+gVcMmVd8qVz9iSY3AbeUYby2k5RLVBrWGtelp6g0wuk7L
         caXzDPXA4dfUvqHq67kHVLK/mgVYsWGU0YCwIlf06jOr1DUVKE3J+XbLQPSawV80U70o
         bmXOfpRE83yNsvYpDXP87ID8C7c2EtvOX/cQyu2ufMITPsehwrs510mM63N6ddfjJaTb
         ExOUWHfz4wrxGXmdYoVyeyqhjvCtutqI9CtyLFlkngyu7PxZdwTj+iGsezzx36otsmiM
         aiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5z1PSBgdgyQOytDnCk9ConnRnIEa9FCO7qAX4IBOjg=;
        b=nO9mtlf3xsXTQ/wvmIDVYjsZWmZqtvn4NDShCAD8kJh0cQ1bmLTWvewZoL/Fec2Fft
         nHxlYWpmpuIFfhn4tk9p8RSPzeteaQPzjKziwyFsRGLEyjfyFu30rB6GUVwhBeOgEDRv
         pokHVg24KD5l/AtWOkMcID1AbCoe3fRyETv0c9XNG/Vz7PIzBMCke0CgwF3ZKJsJGWqD
         j+9Ucg673cEALkGlcnj2juivOIE0sb9jfijm0mmY+O27QAYLTnZRuFmfiGZuflWna/a6
         Tj27KroNMo+mPz3yOvlidTzzHHhVyUj1qcOAZw+l9s02rTJ2DohbLW0px+3zptHSdEfd
         IKBg==
X-Gm-Message-State: APjAAAV5YnNCgzlc4tmYvwBoHriAcJ7ywBt1XHHdt0qFFdxzF4gQrUFe
        zHloZLs+b78XcoJzMSj5ZDw=
X-Google-Smtp-Source: APXvYqyYI2FCmpbwrV8en3o5cAVW75P2iFcW/IIx9WlZoL3aDgy86caMX+nc0W8oCfX0RavqTYMGvw==
X-Received: by 2002:a05:6830:18f7:: with SMTP id d23mr4022608otf.205.1572030058176;
        Fri, 25 Oct 2019 12:00:58 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 21sm748039oix.31.2019.10.25.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:00:57 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: [PATCH v4 1/3] PCI: pciehp: Add support for disabling in-band presence
Date:   Fri, 25 Oct 2019 15:00:45 -0400
Message-Id: <20191025190047.38130-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

The presence detect state (PDS) is normally a logical or of in-band and
out-of-band presence. As of PCIe 4.0, there is the option to disable
in-band presence so that the PDS bit always reflects the state of the
out-of-band presence.

The recommendation of the PCIe spec is to disable in-band presence
whenever supported.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp.h     | 1 +
 drivers/pci/hotplug/pciehp_hpc.c | 9 ++++++++-
 include/uapi/linux/pci_regs.h    | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 654c972b8ea0..27e4cd6529b0 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -83,6 +83,7 @@ struct controller {
 	struct pcie_device *pcie;
 
 	u32 slot_cap;				/* capabilities and quirks */
+	unsigned int inband_presence_disabled:1;
 
 	u16 slot_ctrl;				/* control register access */
 	struct mutex ctrl_lock;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1a522c1c4177..dc109d521f30 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -811,7 +811,7 @@ static inline void dbg_ctrl(struct controller *ctrl)
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
-	u32 slot_cap, link_cap;
+	u32 slot_cap, slot_cap2, link_cap;
 	u8 poweron;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -869,6 +869,13 @@ struct controller *pcie_init(struct pcie_device *dev)
 		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
 		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
+	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
+	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
+		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
+				      PCI_EXP_SLTCTL_IBPD_DISABLE);
+		ctrl->inband_presence_disabled = 1;
+	}
+
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
 	 * requested yet, so avoid triggering a notification with this command.
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 29d6e93fd15e..ea1cf9546e4d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -604,6 +604,7 @@
 #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
 #define  PCI_EXP_SLTCTL_EIC	0x0800	/* Electromechanical Interlock Control */
 #define  PCI_EXP_SLTCTL_DLLSCE	0x1000	/* Data Link Layer State Changed Enable */
+#define  PCI_EXP_SLTCTL_IBPD_DISABLE	0x4000 /* In-band PD disable */
 #define PCI_EXP_SLTSTA		26	/* Slot Status */
 #define  PCI_EXP_SLTSTA_ABP	0x0001	/* Attention Button Pressed */
 #define  PCI_EXP_SLTSTA_PFD	0x0002	/* Power Fault Detected */
@@ -676,6 +677,7 @@
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
+#define  PCI_EXP_SLTCAP2_IBPD	0x0001	/* In-band PD Disable Supported */
 #define PCI_EXP_SLTCTL2		56	/* Slot Control 2 */
 #define PCI_EXP_SLTSTA2		58	/* Slot Status 2 */
 
-- 
2.18.1

