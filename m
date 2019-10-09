Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94541D195B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 22:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJIUFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 16:05:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40204 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIUFd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 16:05:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so2824285ota.7;
        Wed, 09 Oct 2019 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r5z1PSBgdgyQOytDnCk9ConnRnIEa9FCO7qAX4IBOjg=;
        b=nW5uqekjnVCwaOAn53as+jJbYKXf1215vQ6bDEYRlNR06ISI0A/xz/Ca+2kx1URXjs
         ba7Onb/y/XpcQz48a8DgrjyZ3xdHMclaY3dKw9/cjNfjb13F3dovOLrOsGsfJVGYJWcD
         pVXlOP6DTfpolDGlYuY0GwrVJtHd6AUsUZ7kCNmYXabpOZHRD19uYguLZvcG38v5IsV9
         sm3OXePYPH9Ur6F0aBmJppQKsoMu7q4BCkEulG2rEfErrgtr+03xK28sKNHNXb9BIZsM
         wrDWSfv6QHbK4Rn8lfy8/AeDpt9JRXEd5QoASn0DliTwTz+6Y5qMk6LlHKGnQEEiVe95
         AAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r5z1PSBgdgyQOytDnCk9ConnRnIEa9FCO7qAX4IBOjg=;
        b=MYr4XCMDH6VTAnqdek0teUal2PWKt1qVkJ+F2SunQEVZH1OGCHJrnoPKwAFLkV05F6
         NzKye5RGlfxW2VNe1Q+P6gcSwHKe2g5o389k+WrMoOCr654fPpTvTr0ygCol86oiXCYL
         sE4KdHpBTJpG/YGUMnotVjLwAb31Tokt0/5W40HpzuapM6Li7yAHt+X+b66kxJAIBD0/
         mkyTt+m1zVjc+mahhIFD1LuWxWzIMH353f/G9lzryKTQIGJ9Rc5s4rRGlaPgZ9Ow4SAK
         LHdBtxsvfA3agfiXdbjwfTr/anLYaCdYpwZrw/NoLP3/Pkubef5f7GyuHRlmh0sqY0Fw
         1Nag==
X-Gm-Message-State: APjAAAXgwjMDNgQ7iAvcJHxLNy/KXA+wtaZdkdY0W1ZdCrhRnieqqrr8
        mBfFV9El4R4vVVnNZcocNcw=
X-Google-Smtp-Source: APXvYqxneQvrhHl9r9dkG0qDmr02zqr41ae9tsZ7LdANEKWgISkTN8P89x3xZaVQtXxVUHlKA1tgzQ==
X-Received: by 2002:a05:6830:1be3:: with SMTP id k3mr4703396otb.180.1570651532778;
        Wed, 09 Oct 2019 13:05:32 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b5sm976883oia.20.2019.10.09.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:05:32 -0700 (PDT)
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
Subject: [PATCH 1/3] PCI: pciehp: Add support for disabling in-band presence
Date:   Wed,  9 Oct 2019 16:05:21 -0400
Message-Id: <20191009200523.8436-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
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

