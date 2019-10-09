Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF14D195F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 22:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfJIUFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 16:05:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45197 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731581AbfJIUFg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 16:05:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so2844462oib.12;
        Wed, 09 Oct 2019 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+6hFZoHACGNLzXY4zt7VjE/7ALYWlPRw2g+xMBt8zU=;
        b=BXzcJOi0VBbyw8HsGC4b5rLu43Ha89Jm3OU4Lhqj+hlFY9FO6OB5WUp4Mvp6Xq6N2z
         mzl4szDU+BbK4s0ye7Zb0/pw+E9LQKmPajuzUMbP9uaixRU/cWjEmH955wtTjzVZ4lba
         iAYaAOJJYu2xQczpAVxlVjQHcl/+apZwCZO35Jvd2AYvqm1tIOUIKcCMdf9ZxhRh2jpn
         i0Sdp/o7ncNVaxy3Gr3oiz08NMQiWiHcKJvvLXHgKUbGvTGC30Iz+bcwDLJxP+IR1xmn
         cZTNrADoId4wf+RTMpSZIzSabg4RV1k8QhHi+kpnzVnHytlAADEDV1c6w7xu8apdNoLU
         +w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+6hFZoHACGNLzXY4zt7VjE/7ALYWlPRw2g+xMBt8zU=;
        b=SmikYJZGOK8k7X2jq/TIf0cgIA3S6Z6Z1/2NRLNsCuHRXqL+ZCXQh5ADCdkOe9TRei
         R8JttRt1qgjGRs1OhaZL06OVUBlkkwL+7ZC8WE4pvU2HoEn6qnzJbfIHSxXmP4M1JYNg
         AVWTbDCDKrcWLJaAJ8Gx06+3bpqKtBxgmy5XzpraeimvK8k2Iheg7s6KsO8LSIt9GmtZ
         Rwa7P/LVB+kMMim9pIatiYD90rpzXs76oD1c6SGz6VWfGBNjgYSzO+ddfnp90oMdSl6L
         n/Ectj13QIrfhiuPncFTJ9b2dhiBReUZ31hFDJO83FuHHhUGqDq8W2Z2LZ84wY8Yfv6P
         hLXQ==
X-Gm-Message-State: APjAAAVydcfHY+0AcFbvCArMsVBcAcrT/a0JSen0YwRWZhTM7AnnK/Xg
        EjTBRZqD1ARUm6oGULK0mOg=
X-Google-Smtp-Source: APXvYqzg6pDmQSDrh2PPmjHffNPx2FnYSrC8a9qremp6+ETBwyqhP4mJTmI6123FL5xbWuOq7G9PAw==
X-Received: by 2002:aca:b841:: with SMTP id i62mr3884441oif.123.1570651534124;
        Wed, 09 Oct 2019 13:05:34 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b5sm976883oia.20.2019.10.09.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:05:33 -0700 (PDT)
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
Subject: [PATCH 2/3] PCI: pciehp: Wait for PDS if in-band presence is disabled
Date:   Wed,  9 Oct 2019 16:05:22 -0400
Message-Id: <20191009200523.8436-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
References: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
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
 drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index dc109d521f30..1282641c6458 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -242,6 +242,25 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	return found;
 }
 
+static void pcie_wait_for_presence(struct pci_dev *pdev)
+{
+	int timeout = 1250;
+	bool pds;
+	u16 slot_status;
+
+	while (true) {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		pds = !!(slot_status & PCI_EXP_SLTSTA_PDS);
+		if (pds || timeout <= 0)
+			break;
+		msleep(10);
+		timeout -= 10;
+	}
+
+	if (!pds)
+		pci_info(pdev, "Presence Detect state not set in 1250 msec\n");
+}
+
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -251,6 +270,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	if (!pcie_wait_for_link(pdev, true))
 		return -1;
 
+	if (ctrl->inband_presence_disabled)
+		pcie_wait_for_presence(pdev);
+
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
2.18.1

