Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255A624B02
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKJTxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resdmta-h1p-028598.sys.comcast.net (resdmta-h1p-028598.sys.comcast.net [IPv6:2001:558:fd02:2446::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0B48770
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resdmta-h1p-028598.sys.comcast.net with ESMTP
        id tC1fo6ojOpchHtDZYoLN1D; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=NLTClUwuOqPb+DvZnmkPWSVY7cPj58FgQv8QIi+tOjY=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=kAyw+IFh8QzXJh/D8lEvh5kTU9KLSZ9sd88a2FE5QRToVPVeC3zvTpav5/+TTuOBZ
         rYHNyRVNziuwpmr+2XSQKxLjlJ+qq71P97i4izyad/0/MsCUo189Q0WD11mZuch4Iq
         PgT9AKTf0xdOAhSBfwuyAt11rKUeZCpsGAfTU2mS1CxniLSwrA/aYpaMZZC4h/I9ha
         d3dkTcHXVPIqa3MZ/jT5Ybvd6dB8FT4bjOHlyjiVY0ROKd8ffNhc+nbEP+KuAs0C4I
         Tg/O353UDIXTyYc6geY28fOBhN4k7Y5vzpQR8ewMr+6FcBmWja02okYVEq35Pd5xfZ
         3eXf3sqvIjmag==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZEoklhz; Thu, 10 Nov 2022 19:50:29 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
 hugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 2/7] PCI: Add pcie_port_slot_emulated stub
Date:   Thu, 10 Nov 2022 12:50:10 -0700
Message-Id: <20221110195015.207-3-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110195015.207-1-jonathan.derrick@linux.dev>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the checks to allow an emulated slot. An emulated slot will use
native Hotplug, AER, and PME services. It also needs to specify itself
as a hotplug bridge in order for bridge sizing to account for hotplug
reserved windows.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/pci-acpi.c          | 3 +++
 drivers/pci/pcie/portdrv_core.c | 9 ++++++---
 drivers/pci/probe.c             | 2 +-
 include/linux/pci.h             | 2 ++
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a46fec776ad7..77a3c9e39966 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -798,6 +798,9 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
+	if (pcie_port_slot_emulated(bridge))
+		return true;
+
 	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
 	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1ac7fec47d6f..b3c1e7d4ff10 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -209,7 +209,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0;
 
 	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
+	    (pcie_ports_native || pcie_port_slot_emulated(dev) ||
+	     host->native_pcie_hotplug)) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
@@ -222,14 +223,16 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 #ifdef CONFIG_PCIEAER
 	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	    (pcie_ports_native || pcie_port_slot_emulated(dev) ||
+	     host->native_aer))
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
 	/* Root Ports and Root Complex Event Collectors may generate PMEs */
 	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
-	    (pcie_ports_native || host->native_pme)) {
+	    (pcie_ports_native || pcie_port_slot_emulated(dev) ||
+	     host->native_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
 		/*
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b66fa42c4b1f..86ac4d223eba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1574,7 +1574,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 	u32 reg32;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
-	if (reg32 & PCI_EXP_SLTCAP_HPC)
+	if (reg32 & PCI_EXP_SLTCAP_HPC || pcie_port_slot_emulated(pdev))
 		pdev->is_hotplug_bridge = 1;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ff47ef83ab38..09f704337955 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1655,6 +1655,8 @@ extern bool pcie_ports_native;
 #define pcie_ports_native	false
 #endif
 
+#define pcie_port_slot_emulated(dev) false
+
 #define PCIE_LINK_STATE_L0S		BIT(0)
 #define PCIE_LINK_STATE_L1		BIT(1)
 #define PCIE_LINK_STATE_CLKPM		BIT(2)
-- 
2.30.2

