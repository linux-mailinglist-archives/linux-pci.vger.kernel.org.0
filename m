Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C06C426E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfJAVOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 17:14:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36825 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfJAVOl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 17:14:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so15811496oih.3;
        Tue, 01 Oct 2019 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K1zrq8nG75RI+IGXt6RF0ionKO3pnPXpbdwWKZg3yRg=;
        b=U6KOA9Lav3pCY4HYTF4MRg2UDw5Eh7a3H6lnHWgCCxGO3UaDL7P8Wt6UdZMhfEXSbF
         qBvNQPTWtN3e5tGgY3h1oiNDc7YR2Wc1cZvl2YiPQq0eUoLPAYTinQ2QyqVfHwf46mjL
         HfGMNUZyhPyyHTiPBFF19X7VwKkPn+QL4QwGNVZa0xTP5TN5tXUd3+J3FSVAKJXSunN/
         ttjeUqVIJjqWvkD2yIR6QT7K4WS+oGkYioEk5uKoDwPPq5M+iOITtctyjd89uXJlBpap
         MxuSV0TxEFv4kx8ZRF5sbGwywryYaBYYICU/IbsrIV7Kln7AxRyCq5Fb+P09x1v6inF4
         w8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K1zrq8nG75RI+IGXt6RF0ionKO3pnPXpbdwWKZg3yRg=;
        b=gLWbO/jaVHf70XRYS47mFNrj2byKTrTJ2oDo2RLkA8hd+0QRbxMXPs6MsePD3aSxKL
         PbvaLUm6j0EZp9wzx7vjQStOqGNs+diuOD9CwBWu/cGeun7GDPHsiZVikDWE9aMcs1pA
         OyaFcQSLMgyq4lo6OgHquwNTS8To7a1mVpCxqOMoizSrczOcRqD9+tBAUgx/SoFb5eap
         j28dCfe9onWSCvfLRa6j5NYW9ayO1DYs/MOzZwE6lBFNf3UR9ldEQRiu12ZGx4n4LQJH
         ik4AuZbwnPCnc8Y32SgttKeX4fEEU1wKFaIbTmgmwHMlDWzWlrThcZ3A98mOMqYBrsIM
         RuDw==
X-Gm-Message-State: APjAAAXyCpvCX7hBUH6OXwSeJu9yRrwEIwa+5uZv5albcbxkA7BPMu99
        k49LLGOvf3grTyTxblDu4Pw=
X-Google-Smtp-Source: APXvYqzCNrBEiC4vUKrbClH9/cmjYbM5sjQlB93sQYcGzbUXBVY/ukOeteqN2JF/PN38CrqceYSEPA==
X-Received: by 2002:a05:6808:b07:: with SMTP id s7mr51715oij.134.1569964480229;
        Tue, 01 Oct 2019 14:14:40 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id o23sm5220073ote.67.2019.10.01.14.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:14:39 -0700 (PDT)
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
Date:   Tue,  1 Oct 2019 17:14:18 -0400
Message-Id: <20191001211419.11245-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When inband presence is disabled, PDS may come up at any time, or not
at all. PDS being low may indicate that the card is still mating, and
we could expect contact bounce to bring down the link as well.

It is reasonable to assume that most cards will mate in a hotplug slot
in about a second. Thus, when we know PDS only reflects out-of-band
presence, it's worthwhile to wait the extra second or so to make sure
the card is properly mated before loading the driver, and to prevent
the hotplug code from disabling a device if the presence detect change
goes active after the device is enabled.

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

