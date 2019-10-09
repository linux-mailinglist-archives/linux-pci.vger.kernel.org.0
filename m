Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36ED195E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfJIUFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 16:05:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40703 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfJIUFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 16:05:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so2863334oib.7;
        Wed, 09 Oct 2019 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Uxm0TX5vGTMd3DyNdjqMCnLsY8aWV4rFP4cSXY0jjU=;
        b=aJ7iUfQLOJZ1J/TZtBsydyKqUMJpk15S9ecWVwtjcdXfsZ3gZjKWZBDOs1CXHE7+Uq
         jRHL+7ARH92CB+F1izM5UXSJjf363b2JMOQk+n/qhdn9eozVrZjaLWyI/RnAd43FBNed
         kRqc9xej9yhtatMZWs29YLeJlH3lWouNmF8ztA44L7qX1XXwKXShb8WMohU13x8yB6jL
         5xCoTKwUzPIpNG1afGvryKuugbwKy1AsdCukooJudEW6vtYNYmfCSRZRoOYwRSYsUbgl
         Da1r68IiYRFoDhL0LFsW4Jeht/i8wsAZZHKNBusBTnFDgfqp82LlnVApNV194XSx2E6i
         r0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Uxm0TX5vGTMd3DyNdjqMCnLsY8aWV4rFP4cSXY0jjU=;
        b=tDHcrjkXjYMe3CGJSqM/ElBrdLsAMIqPAeJIaO1o145Xu5h4dd/QfuC/e5PBVxTLBk
         s8UG8lX9Rl2kw1fxmVvMW4q9iPI1VVsbJoVC8uoif27cvOOm5E0a+bLq/lG2M5/o9ULb
         nlZb+tJrexcWq6HzqRL1QU6Sg5idqGKPyJ0ONa5oKZLiMfRQ0nEkw5jCdGGUlS9/W1mx
         dIvyt0Y+ux+yqADySF0BtNwP5PNCTaIaBbq02Ry+cLFgpk7nbtNwcDTbuJ2texsU6rJN
         CKSEWVNXyV59mmY6ZEtgPeTrE2T1cDWLU5TePCQ0DJovXMCi1QkPcXJDoF3tDD7cy4vg
         ksrg==
X-Gm-Message-State: APjAAAVxNFVkq37uzELvemFIwz9ohE1HUkgOKzGGyogAg7VDRNYfgdoT
        isi4Z9oNwe1ZgZHrR89reTzsYun1SlfJxA==
X-Google-Smtp-Source: APXvYqxbWsgq7cVNGUpBi4KQ4X/R9gCkTZmXY55Lvl0IKTG9RxuBrUlkvhwbEZu7nqFq5xDAwTxROw==
X-Received: by 2002:a54:4483:: with SMTP id v3mr1208620oiv.111.1570651535411;
        Wed, 09 Oct 2019 13:05:35 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b5sm976883oia.20.2019.10.09.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:05:34 -0700 (PDT)
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
Date:   Wed,  9 Oct 2019 16:05:23 -0400
Message-Id: <20191009200523.8436-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
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
index 1282641c6458..cabd745b844e 100644
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

