Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E00DB792
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436640AbfJQTdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:33:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40433 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436526AbfJQTdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 15:33:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so3173687oib.7;
        Thu, 17 Oct 2019 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/kc+SMypV+pC805s4yI+AQvbHp3a7EeT/I+X+XRBtGo=;
        b=pAQ5G7XDzcnZ/mp1uMSL9Sa/CRRBV+JqURcKMNDrTCP1l6yAAaab6lNJ7P+3WNWwBT
         s9UT4QrGTI/fsMkySKe6ieUXUkMxMpL+88GxZEjvEUkuDYl6fSaM1bC+4UfSweWaCTRt
         /EEHjn7rmsSufZDEbjktWqnrHB4ERKbixYGH81upSwt7beq/kZVBRNE6KvzWWvYqkoeA
         ESUJOhDFBaJ4tnmUuabA6HVXFN2jgQv8BTBCKqimyXhF+k65avR0yL7UT9dFdKIiHdjF
         wa7VRxvcTEwHZUe1jVQxcj7NEn8dlAQEj2/WRCLSlaMkKiqSVEqSRzOaAqEGBbaZpHqB
         R0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/kc+SMypV+pC805s4yI+AQvbHp3a7EeT/I+X+XRBtGo=;
        b=EEiHusxyjkxXQPIQm5AJV1/WX0/+jukSQ+MmAjQ4MHgvJVg3VuP7pV0ocF6nX7lSGO
         daCoDeXHmyIpy9DvCWoCMLPyapgYFv/GMhyk2d6YRir8/HE6C8/VDrSIGXCmNQsmyVFG
         Sj9BrA52pee/YV5fqKgUELIaDP7hsXBSIWVTp3ik/CQkM/RU520lEVHyYIG4tx4wRrJ0
         zh58qxPwxFxdWCUsjnSfDEy1KElD6eJ+lj7j7jkc9hihTFS8oNQFBDF2jrSgeMJmO7oN
         XpSlHhFI4s3MWCKFlKIkV29qxmmoJtXmEPVRh3yZ3Xd1IYrkoniFXC9EjKrPrVD/FvNp
         DJFw==
X-Gm-Message-State: APjAAAU7fuxZX+MK6LlIwxvPE01hc+axdui2bvBzhlijXeAuqW0xuVvl
        Zr40byohiGSH4RiIk00rpFo=
X-Google-Smtp-Source: APXvYqwbOKXhiSCFjbCVSy4my7vj1z6Kp2WpTQm5E37lRrRSClRHZVDMrfIRAuiKQUch8OM8bM+T6A==
X-Received: by 2002:aca:5d8a:: with SMTP id r132mr4480225oib.119.1571340788316;
        Thu, 17 Oct 2019 12:33:08 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id z12sm823273oth.71.2019.10.17.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:33:07 -0700 (PDT)
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
Subject: [PATCH v3 3/3] PCI: pciehp: Add dmi table for in-band presence disabled
Date:   Thu, 17 Oct 2019 15:32:56 -0400
Message-Id: <20191017193256.3636-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
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
index 02eb811a014f..4d377a2a62ce 100644
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
@@ -895,6 +906,9 @@ struct controller *pcie_init(struct pcie_device *dev)
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

