Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08964F842
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 23:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFVVDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 17:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfFVVDn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jun 2019 17:03:43 -0400
Received: from localhost (173.sub-174-234-4.myvzw.com [174.234.4.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9632420820;
        Sat, 22 Jun 2019 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561237423;
        bh=ZBHeAKYOzJ563zqzeZHaIQUy51yxP6J6xXlhK4Es36g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJf3rW6bzBUWONchlG5rcB9Rttd1wn9iYe0eWS/OleF1wnIeQV7DMQi+Gud9AV5TN
         yMlrkq3ks1xeoizRRnvhQKGZ5sAUCRzGEeM6buwetSMGtFFTZZMV5iz49xBqtmuZE3
         GQyiJW12IfskfsoY3z727RGjfmMs6CsogHersSu8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: Skip resource distribution when no hotplug bridges
Date:   Sat, 22 Jun 2019 16:03:11 -0500
Message-Id: <20190622210310.180905-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190622210310.180905-1-helgaas@kernel.org>
References: <20190622210310.180905-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

If "hotplug_bridges == 0", "!dev->is_hotplug_bridge" is always true, so the
loop that divides the remaining resources among hotplug-capable bridges
does nothing.

Check for "hotplug_bridges == 0" earlier, so we don't even have to compute
the amount of remaining resources.  No functional change intended.

---

I'm pretty sure this patch preserves the previous behavior of
pci_bus_distribute_available_resources(), but I'm not sure that
behavior is what we want.

For example, in the following topology, when we process bus 10, we
find two non-hotplug bridges and no hotplug bridges, so IIUC we return
without distributing any resources to them.  But I would think we
should try to give 10:1c.0 more space if possible because it has a
hotplug bridge below it.

  00:1c.0: hotplug bridge to [bus 10-2f]
    10:1c.0: non-hotplug bridge to [bus 11-2e]
      11:00.0: hotplug bridge to [bus 12-2e]
    10:1c.1: non-hotplug bridge to [bus 2f]
---
 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index af28af898e42..04adeebe8866 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1887,6 +1887,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		return;
 	}
 
+	if (hotplug_bridges == 0)
+		return;
+
 	/*
 	 * Calculate the total amount of extra resource space we can
 	 * pass to bridges below this one.  This is basically the
@@ -1936,8 +1939,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * Distribute available extra resources equally between
 		 * hotplug-capable downstream ports taking alignment into
 		 * account.
-		 *
-		 * Here hotplug_bridges is always != 0.
 		 */
 		align = pci_resource_alignment(bridge, io_res);
 		io = div64_ul(available_io, hotplug_bridges);
-- 
2.22.0.410.gd8fdbe21b5-goog

