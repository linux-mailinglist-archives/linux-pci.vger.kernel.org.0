Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE4D497E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 22:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJKUvp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 16:51:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33085 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfJKUvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 16:51:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id a15so9167521oic.0;
        Fri, 11 Oct 2019 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ekvb9hwciZsFblbrWPgDDMrLEPgh+uaA9L5HRYts70w=;
        b=fsMT7Qe/FUAjy53VDOFtKHx66TBDR81g1UuU+qXdOCD67tmpTu1YNVFwRDGTw2cGVi
         aHPTid0mIVA3dGpvXh6Qs5MqWg2MJmKbUEPzDJEibRA5umin1LcEdx5hAWtAWY+uJCsp
         GT7yyR2I3paJnEhdQNkO984z1L+yjAKLAgOtaUkL9fOMws7EiE4yaawHvEZeJxJv38rM
         eEBzsdIMfwKVWu9vKBeQB9J/ig+1sEZbyD9ARmTRcXZETz3SWhsj8es7eMhMIlNQoSlD
         5P8jNnR3ETkAE1sQRR3mDQvNKamEXc5hfip9qMMv7wXy5LwXN5xShqrnKE2p5xeO4kDG
         be8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ekvb9hwciZsFblbrWPgDDMrLEPgh+uaA9L5HRYts70w=;
        b=O9Wcrnyq/8tWwG/4t3YdIHW8V3mM2Dv+81RggW3gTG0N+G0XbB5Jq0T0VvfCseqTKQ
         Wfwlu2PKwRPJIvWak3oh0qZ15K8P29zkwrc/Q8vJu+ve7ZuZBHkd+N9uwn9HA7oFeYGZ
         iS0bQeADMdcTYxo5zTzutnlOfDsqAHMvWhxZa00D//kBhi2pcWEC5JueOJvQbqX3T/5L
         aURLIk0lbfhP8W4wcDGAf9bK+BpXju4UCboeICPIJIjfr+iwKVNFxCa5ydCW3SP8p/Ls
         uPAY/rH9CzYuRBDIbh4x8mTpXkzolYevfzgJrK4sgKZ6hWpvmpFCrmg6rvvUwP4wzXBg
         p9zQ==
X-Gm-Message-State: APjAAAV8h1BFo8ogBiPZN2zn4oi5AmLUR3zjR/hDthv7BtPmhM7pCATK
        IpdyKKUEE9Ci3FY90eW1M+w=
X-Google-Smtp-Source: APXvYqxL+AwebmGoUV7EqKIYhumdybfA4YDxr1/horQ6QpOBL7path94wTLD39lUs+pupDT9CYEaNA==
X-Received: by 2002:aca:d19:: with SMTP id 25mr13134297oin.64.1570827102519;
        Fri, 11 Oct 2019 13:51:42 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id i5sm2900875otk.10.2019.10.11.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:51:42 -0700 (PDT)
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
Subject: [PATCH v2 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
Date:   Fri, 11 Oct 2019 16:51:26 -0400
Message-Id: <20191011205127.4884-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191011205127.4884-1-stuart.w.hayes@gmail.com>
References: <20191011205127.4884-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

When inband presence is disabled, PDS may come up at any time, or not
at all. PDS being low may indicate that the card is still mating, and
we could expect contact bounce to bring down the link as well.

It is reasonable to assume that most cards will mate in a hotplug slot
in about a second. Thus, when we know PDS only reflects out-of-band
presence, it's worthwhile to wait the extra second or so to make sure
the card is properly mated before loading the driver, and to prevent
the hotplug code from disabling a device if the presence detect change
goes active after the device is enabled.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v2:
  replace while(true) loop with do...while

 drivers/pci/hotplug/pciehp_hpc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index dc109d521f30..db5c7b082fda 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -242,6 +242,23 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	return found;
 }
 
+static void pcie_wait_for_presence(struct pci_dev *pdev)
+{
+	int timeout = 1250;
+	bool pds;
+	u16 slot_status;
+
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (!!(slot_status & PCI_EXP_SLTSTA_PDS))
+			return;
+		msleep(10);
+		timeout -= 10;
+	} while (timeout > 0);
+
+	pci_info(pdev, "Presence Detect state not set in 1250 msec\n");
+}
+
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -251,6 +268,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	if (!pcie_wait_for_link(pdev, true))
 		return -1;
 
+	if (ctrl->inband_presence_disabled)
+		pcie_wait_for_presence(pdev);
+
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
2.18.1

