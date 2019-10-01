Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9BC426F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 23:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfJAVOp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 17:14:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44013 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfJAVOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 17:14:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so15763461oih.10;
        Tue, 01 Oct 2019 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UuDNbF2gV+LyjceU1ngZXA4KGi6dXJs2jlZxsWh+OEI=;
        b=hUhiEEan53w6H4qCylahOlh68Y/6FTlzXiyUXL38GW2ImrNRlt85H5bsyoTypqcFPC
         tZoV2eLEzT5JhF0LGucRd2IB7gyXRisY89ojgTvPKvaVVd5NY0QLu4LPjZmyT2g4blkX
         JXcVsQD0R6XFLo0mHao90lPSTX8KBhb43JjPTeEi5bayheyYk03d13q+Mog4XbH1bZEe
         /Pf7ipEzL0V9wzJ3gTkEZyEW9F6VxEm3wahswlsBHctZh9Z/b4OhSe7FmqnnRoCzxKH7
         2gOdo5HsFIcYpX/SJWkXLJTQDsUqHPu1c5o9bsRyfGiAugfuuQ3/4Ly4JTC1Qwa3P2t9
         maMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UuDNbF2gV+LyjceU1ngZXA4KGi6dXJs2jlZxsWh+OEI=;
        b=Xigc6/xmRMDT4PdfvQ8Q/6ZPOIopZrx55gfG/xWpwwuZAXex3wTdYmJwvNWOumeIqM
         5eQzLBz526tHx2qXWbGJOVgkHndbgfjUJHLuYzUpNZlV6c7PQxa6F6JoMFI5ogxeIJ2v
         fl6f4AdTVYOyy3CYTe2aN1wBUOAapO7c0GCRYPSz9dnKI2flny0k+A4jnpM4IRfbmPx1
         TZwuyvKLNHh6q2RFqyv/smN4Cq/aLsfzjMnndimt68DTfPvXfoieJJTVCLREF0mnC25w
         ThfqZRaF5r6yEkqD3YyDAEULy4b2w2sGII6mvhESHHyGppTSeZq4NdPbw5O/Sn/6XM2G
         7Q4w==
X-Gm-Message-State: APjAAAWM4lmqFyc9hK2w/TvTxOrndOEmL5qlONXUB0ee0QHHwBG/cuon
        F58VPIvMNfSjBRhTLEd/qUU=
X-Google-Smtp-Source: APXvYqxY4xV2qaLo44Gs/pIGdkALaTbOx+2OXshNup2CFbBS3INHp8CbSpMts6Vr58CuN0Ay+mba5g==
X-Received: by 2002:aca:538a:: with SMTP id h132mr58946oib.66.1569964481652;
        Tue, 01 Oct 2019 14:14:41 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id o23sm5220073ote.67.2019.10.01.14.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:14:41 -0700 (PDT)
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
Subject: [PATCH 3/3] PCI: pciehp: Add dmi table for in-band presence disabled
Date:   Tue,  1 Oct 2019 17:14:19 -0400
Message-Id: <20191001211419.11245-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some systems have in-band presence detection disabled for hot-plug PCI slots,
but do not report this in the slot capabilities 2 (SLTCAP2) register.  On
these systems, presence detect can become active well after the link is
reported to be active, which can cause the slots to be disabled after a
device is connected.

Add a dmi table to flag these systems as having in-band presence disabled.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1282641c6458..1dd01e752587 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -14,6 +14,7 @@
 
 #define dev_fmt(fmt) "pciehp: " fmt
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
@@ -26,6 +27,16 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
+	{
+		.ident = "Dell System",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+		},
+	},
+	{}
+};
+
 static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 {
 	return ctrl->pcie->port;
@@ -898,6 +909,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 		ctrl->inband_presence_disabled = 1;
 	}
 
+	if (dmi_first_match(inband_presence_disabled_dmi_table))
+		ctrl->inband_presence_disabled = 1;
+
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
 	 * requested yet, so avoid triggering a notification with this command.
-- 
2.18.1

