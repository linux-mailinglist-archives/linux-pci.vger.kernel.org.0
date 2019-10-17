Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BDDB794
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394566AbfJQTdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:33:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46603 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfJQTdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 15:33:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so3141781oiw.13;
        Thu, 17 Oct 2019 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5z1PSBgdgyQOytDnCk9ConnRnIEa9FCO7qAX4IBOjg=;
        b=Kj7ASfvguY6wBUMecEIYld56+GzdZRax3xSMKjqzbmU7SirW8NlLpRUOXif664zZQj
         vl03f5fkn4Zh5MUZ4s6HyMRa8ranAv63WHWbedumJqElEDC+lAI0l5LUHCIWBYBZWhvg
         qGNCk+IPcOnLb4bO6ENZXpmxbqcUdgWSG9qTCDiETj7WPgJiyPDEP5WwLItUupXXcXTn
         ezGqyNnlxFwCH6y6yqftlsC1I/lSyaPrMG6PptjzjJUqj7b5zF3WOOU3s/Vfosx25mbG
         5qpDIrLNs0Kq3YNSLzEgLYHfOi1eTwir5yeqF4iRpRWo6A/x5FlGOMrtCYS5KHBVsCOg
         XY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5z1PSBgdgyQOytDnCk9ConnRnIEa9FCO7qAX4IBOjg=;
        b=gG5rFX/WBu1Vfrr1QqMODIALLe8B74T2VNT0qylMOR3m/EM40YQ768qHh1qVTIjue+
         vsiT5cZY9KFGqmNEvEfUqVxIdmgmqcPiCiT4dOCn7LpZvWNSoL+fYrgfeLtaRmJEFB6m
         kkoQwxf7dNTPWrzGm8YjJFVNJkKSJRl60eW7KqJDooYViFRXdqXNRSag8szGIXj1Rkhf
         3iXXjqTOktpz0hnnacCPlWjlVwCDT1uo7UfYCl19HrQLB8PMBuTjni6LbBGVIDYMMoXN
         5KkZCXqJ/GrwvS8DKuxaCTsi16qUHUbNfq+m7IZx8gK5TcjFGwho3PWqjWjRqLaqwE1h
         qq5g==
X-Gm-Message-State: APjAAAVcDTV0PO8rtyn2ciOTY9pBxOpOrUvvnguO8l/rIqTKvTGbS5cg
        +8tg60A4Kn7O3rdUrbolYmI=
X-Google-Smtp-Source: APXvYqzq5u6h8Am1mSL0YM+lPW1DwccTDsRQCMbbEyLHkfS2uhmZVfKfFjpLZeucCYJ/dUgdIv2IqQ==
X-Received: by 2002:aca:b503:: with SMTP id e3mr4683557oif.177.1571340784785;
        Thu, 17 Oct 2019 12:33:04 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id z12sm823273oth.71.2019.10.17.12.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:33:04 -0700 (PDT)
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
Subject: [PATCH v3 1/3] PCI: pciehp: Add support for disabling in-band presence
Date:   Thu, 17 Oct 2019 15:32:54 -0400
Message-Id: <20191017193256.3636-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
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

