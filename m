Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C21E540A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfJYTBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 15:01:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46481 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfJYTBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:01:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so2727793oth.13;
        Fri, 25 Oct 2019 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEsox1ODtKv8Vrlc6BNsE12nHs0ccD3hxpe8yokF4wM=;
        b=pARAWLm0M5sQSPyXpSBp1aKJpaYGYmgBgBiNGp//Z+eBRlbEF6ZOsz5efNozGt7Ox9
         Y4vNw21HdlHGzUJFugvx3xHDkayLdB94JjFB8QJ6fXYV9SbhaQPJlwTzazk6qC6JzH1a
         /KKKiJLf/JAa3oCEMYkyUQ11bLMO476uW9Nz4++Oc4Ke5iz6bFQmYQosU6HF5Z+aaAvS
         9S4a64ctgIvStJPjsGZPPZJF0Vaa4HPSg2L+I5BuIYoVCAmWb89tzO3E42oP9WM2kgLT
         EP76XzizBBxZZxn6TxvhjbmPcTkclcqDR5wAGmiMH6MJQ+9YkpZn5GwxnnZW5aeJ92qd
         ePOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HEsox1ODtKv8Vrlc6BNsE12nHs0ccD3hxpe8yokF4wM=;
        b=qX1gBOg8i1tsLgpH8ZzfQOedIJq1kmVh+EjdPgU11SUjxDx+RkZbmm1pGR25gr1ZMz
         RbIOGfe4UP9AubORZ2bCfYGvop86SK/EFNxHvxD1ER3lmWT9oerSYASJL2yKfQ7Sbqw1
         WcZpOxRTwW42Z/PTg+1nySvM5idwfiU0Q8Kc+c9CAFW4EavghJAuE3RE3ziHYgsuPJvo
         aWRnx8b0VuAq+UGxR8zX2TPWTxHxx3RAHUROgN0P7K2IOjfLDbns/sCxr/3j/dgO7pUE
         NfH9hPXtaJbY+A865AlfE8FHiwL69CpC5K/Wk6eu3DrTAiNhnD6mzAXvmejt+GgfJzGR
         NA9A==
X-Gm-Message-State: APjAAAURBHLj/0/j0smqrpd94vDVK9cQ1KbPge0wWvJHw4CvMltg8hXd
        Or41GmLxAAW46QBejnzDSA8=
X-Google-Smtp-Source: APXvYqwraZgeHx1X/HB9iDZhvDY9EzbRyTobcWAcgN3Fds1pc5DwTgwdnk1aw6tiESlm9gY1KxVCAg==
X-Received: by 2002:a9d:7a46:: with SMTP id z6mr4096899otm.40.1572030059367;
        Fri, 25 Oct 2019 12:00:59 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 21sm748039oix.31.2019.10.25.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:00:58 -0700 (PDT)
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
Subject: [PATCH v4 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
Date:   Fri, 25 Oct 2019 15:00:46 -0400
Message-Id: <20191025190047.38130-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
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
v3
  remove unused variable declaration (pds)
  modify text of warning message
v4
  remove "!!" boolean conversion from "if" condition for readability

 drivers/pci/hotplug/pciehp_hpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index dc109d521f30..02d95ab27a12 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -242,6 +242,22 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	return found;
 }
 
+static void pcie_wait_for_presence(struct pci_dev *pdev)
+{
+	int timeout = 1250;
+	u16 slot_status;
+
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (slot_status & PCI_EXP_SLTSTA_PDS)
+			return;
+		msleep(10);
+		timeout -= 10;
+	} while (timeout > 0);
+
+	pci_info(pdev, "Timeout waiting for Presence Detect state to be set\n");
+}
+
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -251,6 +267,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	if (!pcie_wait_for_link(pdev, true))
 		return -1;
 
+	if (ctrl->inband_presence_disabled)
+		pcie_wait_for_presence(pdev);
+
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
2.18.1

