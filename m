Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3A1BAC72
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD0SYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:21 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53048 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbgD0SYV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C6CD04C859;
        Mon, 27 Apr 2020 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011856; x=1589826257; bh=JZFEuRZ4Olei8kVKOpa2v13cbjpCm2nfCBn
        EgOI0pW8=; b=crgcQN/zsW5haUkaV9r/j7tRvZGM2vKUnWSBNBApf81/A5szMWX
        lGpGKEORbxNCd9LBuka23EQ2wnucDnHqgI2c2kHB4NZS8PwXVYGrLIzwZicqbwAi
        OgW0ZvTIaAzN+cZl8g5RnT1Kc9B4T2sEZlzF3sG55Sz0Sre8Z5ccSsR8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4NQ11Dg6VM46; Mon, 27 Apr 2020 21:24:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B5DA24C840;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:11 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 08/24] PCI: Reassign BARs if BIOS/bootloader had assigned not all of them
Date:   Mon, 27 Apr 2020 21:23:42 +0300
Message-ID: <20200427182358.2067702-9-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some BIOSes don't allocate all requested BARs, leaving some (for example,
SR_IOV) unassigned, without gaps for bridge windows to extend.

If that happens, let the kernel use its own methods of BAR allocating on an
early init stage, when drivers aren't yet bound to their devices, and it is
safe to shuffle BARs that are not yet used.

Not every BAR can be safely moved: some framebuffer drivers (efifb) don't
act as a PCI driver (like nouveau), taking BAR locations indirectly - via
ACPI for example. Until every such driver is aware of movable BARs, mark
every VGA BAR as fixed. Perhaps this is also useful for splash screens, so
they don't flicker.

If this reassignment fails, fall back to the BAR layout proposed by BIOS,
working around the fact that they are marked with IORESOURCE_UNSET during
init, so the new flag pci_init_done was introduced.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       | 2 ++
 drivers/pci/probe.c     | 8 +++++++-
 drivers/pci/setup-bus.c | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7483a5716317..2ef72741e8e5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -297,6 +297,8 @@ bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res);
 bool pci_dev_bar_enabled(const struct pci_dev *dev, int idx);
 bool pci_bus_check_bars_assigned(struct pci_bus *bus, bool complete_set);
 
+extern bool pci_init_done;
+
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
 	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5ca6e5887326..0c681bb767cc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -41,6 +41,7 @@ EXPORT_SYMBOL(pci_root_buses);
  * were assigned before the rescan.
  */
 static bool pci_try_failed_bars = true;
+bool pci_init_done;
 
 static LIST_HEAD(pci_domain_busn_res_list);
 
@@ -3240,6 +3241,11 @@ bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res)
 	if (region.start == 0xa0000)
 		return true;
 
+	if (res->start &&
+	    !(res->flags & IORESOURCE_IO) &&
+	    (dev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+		return true;
+
 	if (!dev->driver && !res->child)
 		return false;
 
@@ -3255,7 +3261,7 @@ static unsigned int pci_dev_count_res_mask(struct pci_dev *dev)
 		struct resource *r = &dev->resource[i];
 
 		if (!r->flags || !r->parent ||
-		    (r->flags & IORESOURCE_UNSET))
+		    (pci_init_done && (r->flags & IORESOURCE_UNSET)))
 			continue;
 
 		res_mask |= (1 << i);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3bde8fdb9aa0..d265db4c746d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1909,7 +1909,14 @@ void __init pci_assign_unassigned_resources(void)
 		/* Make sure the root bridge has a companion ACPI device */
 		if (ACPI_HANDLE(root_bus->bridge))
 			acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
+
+		if (pci_can_move_bars && !pci_bus_check_bars_assigned(root_bus, true)) {
+			dev_err(&root_bus->dev, "Not all requested BARs are assigned, triggering a rescan with movable BARs");
+			pci_rescan_bus(root_bus);
+		}
 	}
+
+	pci_init_done = true;
 }
 
 static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
-- 
2.24.1

