Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDA3C82E5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhGNKcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbhGNKc2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 06:32:28 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF2C061760;
        Wed, 14 Jul 2021 03:29:36 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g12so1498781qtb.2;
        Wed, 14 Jul 2021 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7T8kluK9mrgjF1VL3wmEJkksUgHPqtjRUdZS+e7HPjk=;
        b=gXYRNgjJLsjDdmmJe9iOGZBO8mjLGjgBskUvLAJT3oh9/AXiLK+5EBTNbusbsc0hk1
         1Ug0itXWz1I5TwpflvJli/ud+N2S6DnKNrsu98yurtpEzzESNqi0udvSkPAHQMKIefMw
         +riYKR6JB4Ck7pZfZuyv9OZT2JEoqd9LaccM0gK6/1yhptbLznkp/ynd+Qor3yMiiSbf
         m5lFzycSrcSX15vdM1CFKYBjDrc8a1GMgkgHBkbTMprOWNsKaAmKWoNWZNwoMPtUZLFC
         Ivrx7FIv1EbQxWSGIaW/NaFzbW9wbqc7Cj7FQs5JA4Ry/mp+I3EjHsdRgEoIN7sToCOa
         2jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7T8kluK9mrgjF1VL3wmEJkksUgHPqtjRUdZS+e7HPjk=;
        b=cISPdwV+FCkEzrX5BK5S3eRF6v2ljSypAf/2Gre1GwCvHQ4DWET5F8jyCV3J07GxbV
         cg6SHN9TUsD2DDO7CR/RRFtAerBRGQ6m0i5sdr69tLgAE1jPktvwksB+/WAMicMIPy/B
         jIRt4CT5tW7VKhgFPciNi2OBFArhZaZYu+7l6tmpmL5VUwCu84fed8vshUgSWmgYdSKe
         jY5dWf7kIk21OWcJusjqYT/fgqkQ1B7uvdAzh+UhGvDb1zsrC4Zy3jIi34jHwX4hvR85
         9ln14ZqV5rHx4c7/bpK0bf5vS10jKeSaqpXWM4YOG4WGkAIEweO56ybXhOt4Es6mBoQp
         XX5w==
X-Gm-Message-State: AOAM531eIuA7THjrMfa1JALuWel/p0eeY09jDEICclV0PxIDS2zvMpjj
        yR2OaMLRbU8ybc3ppqgUerU=
X-Google-Smtp-Source: ABdhPJzfGAWdhaO6Zch+2QrHy+0Z89DSZTFfVwzExnf+zJeUUziYuFXw9a5ngBIDRRm3/kXCGlKMLQ==
X-Received: by 2002:ac8:5f48:: with SMTP id y8mr8669818qta.191.1626258575283;
        Wed, 14 Jul 2021 03:29:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h2sm853239qkf.106.2021.07.14.03.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:29:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id E54C927C0054;
        Wed, 14 Jul 2021 06:29:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 14 Jul 2021 06:29:33 -0400
X-ME-Sender: <xms:jbzuYHWM5o0_U-a91Fi1YsB9_iTbJsy7dKZs2icQR61y7XmSV0ZGRw>
    <xme:jbzuYPkHLccYDuxCZOtVBZWF8SVpWDtLFW6OvkOx-7-_cxbnPPuaAr4-9yDjqP8Va
    pZHwkujjAZ1uf4scw>
X-ME-Received: <xmr:jbzuYDZzQoLMdq_w7ZP1BENc4_4wZWOG6HdqeQnj1LbDlFWY9ZuEr6olW49ylw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:jbzuYCX-eHiCw4idDTZFJfIAWAyDuoqWtGpmheAdJJnDG-qbyZwCtQ>
    <xmx:jbzuYBk4OZxi6RhyF1KZg8HpwwOrjep4gpEPJrfi3oVJVSnhkXFmdQ>
    <xmx:jbzuYPf0tdLSewLgHdcy5nTQe5RuVZwBi3TmVDRkJxky2m5FeLqyOg>
    <xmx:jbzuYAcCgJrDGTamiODu_a0kmVSraI46boKJ2BQF_bimrIY9hmjOi4nj9Os>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jul 2021 06:29:33 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [RFC v4 4/7] PCI: hv: Generify PCI probing
Date:   Wed, 14 Jul 2021 18:27:34 +0800
Message-Id: <20210714102737.198432-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714102737.198432-1-boqun.feng@gmail.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In order to support ARM64 Hyper-V PCI, we need to set up the bridge at
probing time because ARM64 is a PCI_DOMAIN_GENERIC arch and we don't
have pci_config_window (ARM64 sysdata) for a PCI root bus on Hyper-V, so
it's impossible to retrieve the information (e.g. PCI domains, irq
domains) from bus sysdata on ARM64 after creation.

Originally in create_root_hv_pci_bus(), pci_create_root_bus() is used to
create the root bus and the corresponding bridge based on x86 sysdata.
Now we create a bridge first and then call pci_scan_root_bus_bridge(),
which allows us to do the necessary set-ups for the bridge.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Please note that the whole commit message is from me (Boqun), and most
of the code is from Arnd, and I believe the initial purpose of the
changes is for clean-up and code unification.

I added Hyper-V related rationale in the commit message because I use it
to support Hyper-V virtual PCI on ARM64. If the SoB tags should be
adjusted, please let me know.

 drivers/pci/controller/pci-hyperv.c | 57 +++++++++++++++--------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index a53bd8728d0d..8d42da5dd1d4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -449,6 +449,7 @@ enum hv_pcibus_state {
 
 struct hv_pcibus_device {
 	struct pci_sysdata sysdata;
+	struct pci_host_bridge *bridge;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
 	enum hv_pcibus_state state;
@@ -464,8 +465,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	struct list_head resources_for_children;
-
 	struct list_head children;
 	struct list_head dr_list;
 
@@ -1797,7 +1796,7 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
 
 		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
 		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
-		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
+		hpdev->pci_slot = pci_create_slot(hbus->bridge->bus, slot_nr,
 					  name, NULL);
 		if (IS_ERR(hpdev->pci_slot)) {
 			pr_warn("pci_create slot %s failed\n", name);
@@ -1827,7 +1826,7 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 {
 	struct pci_dev *dev;
-	struct pci_bus *bus = hbus->pci_bus;
+	struct pci_bus *bus = hbus->bridge->bus;
 	struct hv_pci_dev *hv_dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -1850,21 +1849,22 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
  */
 static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 {
-	/* Register the device */
-	hbus->pci_bus = pci_create_root_bus(&hbus->hdev->device,
-					    0, /* bus number is always zero */
-					    &hv_pcifront_ops,
-					    &hbus->sysdata,
-					    &hbus->resources_for_children);
-	if (!hbus->pci_bus)
-		return -ENODEV;
+	int error;
+	struct pci_host_bridge *bridge = hbus->bridge;
+
+	bridge->dev.parent = &hbus->hdev->device;
+	bridge->sysdata = &hbus->sysdata;
+	bridge->ops = &hv_pcifront_ops;
+
+	error = pci_scan_root_bus_bridge(bridge);
+	if (error)
+		return error;
 
 	pci_lock_rescan_remove();
-	pci_scan_child_bus(hbus->pci_bus);
 	hv_pci_assign_numa_node(hbus);
-	pci_bus_assign_resources(hbus->pci_bus);
+	pci_bus_assign_resources(bridge->bus);
 	hv_pci_assign_slots(hbus);
-	pci_bus_add_devices(hbus->pci_bus);
+	pci_bus_add_devices(bridge->bus);
 	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
 	return 0;
@@ -2127,7 +2127,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 * because there may have been changes.
 		 */
 		pci_lock_rescan_remove();
-		pci_scan_child_bus(hbus->pci_bus);
+		pci_scan_child_bus(hbus->bridge->bus);
 		hv_pci_assign_numa_node(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
@@ -2295,8 +2295,8 @@ static void hv_eject_device_work(struct work_struct *work)
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
 	 * attempt to find it and tear down the bus state, if it exists.  This
-	 * must be done without constructs like pci_domain_nr(hbus->pci_bus)
-	 * because hbus->pci_bus may not exist yet.
+	 * must be done without constructs like pci_domain_nr(hbus->bridge->bus)
+	 * because hbus->bridge->bus may not exist yet.
 	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
 	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
@@ -2662,8 +2662,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->low_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->low_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->low_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->low_mmio_res);
 	}
 
 	if (hbus->high_mmio_space) {
@@ -2682,8 +2681,7 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 		/* Modify this resource to become a bridge window. */
 		hbus->high_mmio_res->flags |= IORESOURCE_WINDOW;
 		hbus->high_mmio_res->flags &= ~IORESOURCE_BUSY;
-		pci_add_resource(&hbus->resources_for_children,
-				 hbus->high_mmio_res);
+		pci_add_resource(&hbus->bridge->windows, hbus->high_mmio_res);
 	}
 
 	return 0;
@@ -3002,6 +3000,7 @@ static void hv_put_dom_num(u16 dom)
 static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
+	struct pci_host_bridge *bridge;
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
@@ -3014,6 +3013,10 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 */
 	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
 
+	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
+	if (!bridge)
+		return -ENOMEM;
+
 	/*
 	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
 	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
@@ -3035,6 +3038,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+
+	hbus->bridge = bridge;
 	hbus->state = hv_pcibus_init;
 	hbus->wslot_res_allocated = -1;
 
@@ -3071,7 +3076,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus->hdev = hdev;
 	INIT_LIST_HEAD(&hbus->children);
 	INIT_LIST_HEAD(&hbus->dr_list);
-	INIT_LIST_HEAD(&hbus->resources_for_children);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
@@ -3295,9 +3299,9 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
-		pci_stop_root_bus(hbus->pci_bus);
+		pci_stop_root_bus(hbus->bridge->bus);
 		hv_pci_remove_slots(hbus);
-		pci_remove_root_bus(hbus->pci_bus);
+		pci_remove_root_bus(hbus->bridge->bus);
 		pci_unlock_rescan_remove();
 	}
 
@@ -3307,7 +3311,6 @@ static int hv_pci_remove(struct hv_device *hdev)
 
 	iounmap(hbus->cfg_addr);
 	hv_free_config_window(hbus);
-	pci_free_resource_list(&hbus->resources_for_children);
 	hv_pci_free_bridge_windows(hbus);
 	irq_domain_remove(hbus->irq_domain);
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
@@ -3390,7 +3393,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
  */
 static void hv_pci_restore_msi_state(struct hv_pcibus_device *hbus)
 {
-	pci_walk_bus(hbus->pci_bus, hv_pci_restore_msi_msg, NULL);
+	pci_walk_bus(hbus->bridge->bus, hv_pci_restore_msi_msg, NULL);
 }
 
 static int hv_pci_resume(struct hv_device *hdev)
-- 
2.30.2

