Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C5DB78F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394468AbfJQTdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:33:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40430 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394412AbfJQTdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 15:33:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so3173622oib.7;
        Thu, 17 Oct 2019 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=76iHHEqG+0CI32ACRZLZ+F0kTpO3F1ob+KjYzdlorVM=;
        b=hdC93QzOcuW7+cnj2wrHbq4Pkd9VsZ5k9rpGhEiBOdM8j7lmLAuh1kRpCyUKAh2giU
         3OXlEHGLN4S1sfeQEn5Gu3oZRoezXGMeDDDUtNaZ+mwzY9DCETk7Tjz3gjXau82joPCc
         YYrnTpq+KPPAGO/Ba3F7AeHoA5Dn6fYY5JVTsu42xj17d535IIVWMLylRiXOETRdjSAW
         Sr99dLDBNxmB0v8rlKJAUcfwnHx2ozllVkT9i2X7y0KTPKjz2J85APUiOo1uhwqx6hFr
         Op0aeBdZVA6vLYOd/VOq0ANpdhHG0ASR7MaGnxeBisO3lSeR2UUoRnn8HE4RyuKpuRak
         avpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=76iHHEqG+0CI32ACRZLZ+F0kTpO3F1ob+KjYzdlorVM=;
        b=b2RfHkEBVG9NBe8NITf28Ou0Dt+BwjuRClPF8GaH+v2TJQmlJJpj3AKyCjbFovl1Nt
         i9SlHJsIGFrU67DXFoi6CFhgldoJ1jivTh5VH4p2RVra+QEhh0BhauxTxozaLuAbS1GZ
         rmCLr3BswsANLXSXVtBae6flmN1DKpKyXXp8PbbMOE7U7GpWgp1SFhMGnrf1EX5py+TT
         GCqiXa4Qoc/1hZCL3LFYWsOuMsoRJAhtJ5MZ4rexE69xtqUrCIVmpFSm/QRHyZ1W6Pz3
         pEg8sTaM0K5EMRpgvwIxnv57ZHbnznNNN7AdunlK/WvFN+V/CVUU46iMqYVwANopzwH+
         7q6Q==
X-Gm-Message-State: APjAAAX/RsQORRZNlMbrwwkahHL9EKIg/UT2Z/NJrGHKF7jg1dlKr4NH
        0J9rHLMTafE5xRm6PmZIRCA=
X-Google-Smtp-Source: APXvYqzTgK3cVvxOv/1OIsVlLID/7VEM3Z+UpjnCAl0Tx/F52J7k7t0IVizf66bQO+qKbBDD75Al1Q==
X-Received: by 2002:aca:30ce:: with SMTP id w197mr4616144oiw.82.1571340786681;
        Thu, 17 Oct 2019 12:33:06 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id z12sm823273oth.71.2019.10.17.12.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:33:06 -0700 (PDT)
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
Subject: [PATCH v3 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
Date:   Thu, 17 Oct 2019 15:32:55 -0400
Message-Id: <20191017193256.3636-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
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

 drivers/pci/hotplug/pciehp_hpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index dc109d521f30..02eb811a014f 100644
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
+		if (!!(slot_status & PCI_EXP_SLTSTA_PDS))
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

