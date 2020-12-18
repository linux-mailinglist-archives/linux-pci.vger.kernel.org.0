Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11172DE86D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgLRRmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:42:33 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38570 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728403AbgLRRmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:42:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5D93D413EB;
        Fri, 18 Dec 2020 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313272; x=1610127673; bh=dvl7cddgkL1y7EPOt3GbUC/MPhpqFWegKCz
        MyctzpO4=; b=aJvfarybsIUaD11NoPW0bAEGLfliM/shA6tNLL7O6eJCEGPBl4f
        hPD1ZnJWT8vKBzVbEMfIe9uBHcIiq3Siy7V2mOEBg85zeNOmjQuNDQRQdki8H1Pv
        hl5V99Gk1Vt1yJ0d+/zvZSlIoQuVR84jjJnSr0/HAEb+ZFIo9iWJO35U=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vaSdaceijxvY; Fri, 18 Dec 2020 20:41:12 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9F94C41393;
        Fri, 18 Dec 2020 20:41:07 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:07 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 08/26] PCI: Reassign BARs if BIOS/bootloader had assigned not all of them
Date:   Fri, 18 Dec 2020 20:39:53 +0300
Message-ID: <20201218174011.340514-9-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some BIOSes don't allocate all requested BARs, leaving some (for example,
SR_IOV) unassigned, without gaps for bridge windows to extend.

If that happens, let the kernel use its own methods of BAR allocating on an
early init stage, when drivers aren't yet bound to their devices, and it is
safe to shuffle BARs that are not yet used.

If the reassignment fails, retry without BARs omitted by BIOS, they have
the IORESOURCE_UNSET flag being set. To use this property, a new bool was
introduced: pci_init_done.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       | 2 ++
 drivers/pci/probe.c     | 3 ++-
 drivers/pci/setup-bus.c | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1668b1f45133..62c3eb146348 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -278,6 +278,8 @@ bool pci_dev_bar_fixed(struct pci_dev *dev, struct resource *res);
 bool pci_dev_bar_enabled(const struct pci_dev *dev, int idx);
 bool pci_bus_check_bars_assigned(struct pci_bus *bus, bool complete_set);
 
+extern bool pci_init_done;
+
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
 	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 294e8f262c7f..f6e2216ce996 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -41,6 +41,7 @@ EXPORT_SYMBOL(pci_root_buses);
  * were assigned before the rescan.
  */
 static bool pci_try_failed_bars = true;
+bool pci_init_done;
 
 static LIST_HEAD(pci_domain_busn_res_list);
 
@@ -3288,7 +3289,7 @@ static unsigned int pci_dev_count_res_mask(struct pci_dev *dev)
 		struct resource *r = &dev->resource[i];
 
 		if (!r->flags || !r->parent ||
-		    (r->flags & IORESOURCE_UNSET))
+		    (pci_init_done && (r->flags & IORESOURCE_UNSET)))
 			continue;
 
 		res_mask |= (1 << i);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e2e253815454..a69415348684 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1919,7 +1919,14 @@ void __init pci_assign_unassigned_resources(void)
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

