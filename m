Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59582D497C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 22:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfJKUvp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 16:51:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46503 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbfJKUvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 16:51:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id 89so9081084oth.13;
        Fri, 11 Oct 2019 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0W2EhTeP3FRVRzpbLrE0RJ5tQSqi2OLTlhKGN/4n+c=;
        b=O/uA8/F/YaA3EEcM9kq6B5XMX+2fdJj9e8RuugqEegsxS7o3GoaBynJn9ne1OAuQOI
         bShSgo93/FMbBsVBkIu34yTEOuE/mKEWis7fCUspSMQbQfyxZ9Q9rESmb3DOi/GKGZ49
         G1n3QDzE4Lddb5lJBsVswH2jP0YeFGXxVfopLRGJUsn5I1xPUx+uKSBNscgwFt7bqLgb
         ghYAtvjnld3DEtum3N2IvPAmCUEgVx2o0EygEYJ6FQprv+5yXSX+mGTHXjRzYxYUuCEr
         y4CBUbuoWGbcmsvjoryQDnEbUS8hQpvunD7sxNun7/DQoz2suDU4vsONK55h6+pAyWTq
         +XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q0W2EhTeP3FRVRzpbLrE0RJ5tQSqi2OLTlhKGN/4n+c=;
        b=f//A8tyQFcOpiCSIsyssYI87DWhZvOjjWrFKHqty5nnxJl6thhMGGTxMzScl2HtRsp
         kmXwG3fj88COpgGpHvNSFq2NnECcONUupTyZhNIf8t8QCoiHM7jLT1fLXUng1v6O1vKi
         cFtMFshh5oRx8jI6MSY8C0s1Xyff6RjTHVesp3OAy9cezz1n/lsfqktbZbqDbryg3Dzx
         ybqui8xDsuIm/I4WWJaXJNYyLtGOVun8Z+0sy8Ctx20hJT6SmtwvGPoNjUQZCjZHMF7H
         v9gWHSiIOmq4Msrwe57muR+U+BM4f8/gqY5vB+xTBB4VmkNNv3QPMwfJbvKxaTc/lMuX
         zRPg==
X-Gm-Message-State: APjAAAVof7qSL+5QhzXRFDnm//fMeEWNHUoA1zvPmQllQBCIX/iNfsdR
        6lpnjVnc6pOoudA6KQh6GOw=
X-Google-Smtp-Source: APXvYqzAY6t1Aiw4Ph0I4P49iQ1tN7cY6XScLZ5BRbRkglRC35HT5JeGS8DfKg5X4VvnxU//9hx+RA==
X-Received: by 2002:a9d:3ee:: with SMTP id f101mr14174509otf.126.1570827103808;
        Fri, 11 Oct 2019 13:51:43 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id i5sm2900875otk.10.2019.10.11.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:51:43 -0700 (PDT)
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
Subject: [PATCH v2 3/3] PCI: pciehp: Add dmi table for in-band presence disabled
Date:   Fri, 11 Oct 2019 16:51:27 -0400
Message-Id: <20191011205127.4884-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191011205127.4884-1-stuart.w.hayes@gmail.com>
References: <20191011205127.4884-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some systems have in-band presence detection disabled for hot-plug PCI
slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
On these systems, presence detect can become active well after the link is
reported to be active, which can cause the slots to be disabled after a
device is connected.

Add a dmi table to flag these systems as having in-band presence disabled.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index db5c7b082fda..f864f0875c53 100644
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
+			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
+		},
+	},
+	{}
+};
+
 static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 {
 	return ctrl->pcie->port;
@@ -896,6 +907,9 @@ struct controller *pcie_init(struct pcie_device *dev)
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

