Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CEAC426C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfJAVOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 17:14:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41575 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfJAVOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 17:14:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id w65so2971277oiw.8;
        Tue, 01 Oct 2019 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7zBxPIpqei6RdhutEMOr6Bfy8yNZwbOVfBFiC5FcV0=;
        b=r+k0uy4N/G3hyn8ODXlnf5E3CNecPYE9A9kudrJdUoiV4IgjmpqflGQIMBS01s9dR3
         1twN9XGw6Gbss/oYW0TrYcx6nuYNc7ate0o58JaMsx4kBJmYPLwftLSpFYHdyFZnWhg7
         h8KwKVEM1HHduF0Z/p2DyD5zj183m741wI/XTksmQ3XJpRPO7Ehm99P0Bs/imhYRao3x
         XFdMlnuIYZvzjVzaORr7UFjzOiSmcuo17apX/9nkLVjMwSslQ7DUfnhkSpfKfBZ+7fWC
         2oJLWafDDG6vlsyFlRf9dtHh3dNaon0RkBzspBRpAibf06w9pZE3XGRWfwS/hwxHjKBy
         Ds7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7zBxPIpqei6RdhutEMOr6Bfy8yNZwbOVfBFiC5FcV0=;
        b=gJDgXztKoz4MCtcj6wzbyQ+hBfL/83jzpPG1LYVaAaXUKyYLUONUXJ/R6fT4OD+6mq
         UUeK6PFKfhMc28VS1qExpoNFyFHQflh0tnVPqFl9Nm4APCx8nT1V6XyYUVDnj6X0zhQQ
         rX0oyuwVplPg3dS++dPAPEZbO1gOaxOEVVWtMP/pH7T8yErV0sMchAImMJxmFeCffVV1
         2METORrVodAdvnEUXmAFbxKHX/yyEI6cMD2GRELNB3dWzjl64j6ek5PiBYG/gqgmvpnp
         KS9sDCTYAe9/OrdrvZH08cO1BoVbfvQt0+kIhVlvPCqrc5JklroMPjfXlb+GqHDdvEMd
         cS2g==
X-Gm-Message-State: APjAAAUm9a/nxxnrqLOio8P3v03jakxRvP8sxZth5QH6sTyr8twiI7d+
        YRRl/KdagNWmx5kAE+fqwko=
X-Google-Smtp-Source: APXvYqyzT9eUf0Gqpxg8KLfWlbsD4oPd46TsvpMArK83phhdmdFM9F7MUdFsHV+Z0rPGe9ScRkFF1Q==
X-Received: by 2002:aca:dcd6:: with SMTP id t205mr38480oig.11.1569964478702;
        Tue, 01 Oct 2019 14:14:38 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id o23sm5220073ote.67.2019.10.01.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:14:38 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 1/3] PCI: pciehp: Add support for disabling in-band presence
Date:   Tue,  1 Oct 2019 17:14:17 -0400
Message-Id: <20191001211419.11245-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The presence detect state (PDS) is normally a logical or of in-band and
out-of-band presence. As of PCIe 4.0, there is the option to disable
in-band presence so that the PDS bit always reflects the state of the
out-of-band presence.

The recommendation of the PCIe spec is to disable in-band presence
whenever supported.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
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

