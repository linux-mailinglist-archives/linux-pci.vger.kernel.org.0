Return-Path: <linux-pci+bounces-33019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF64B1368C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87FD16A826
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD66262FFC;
	Mon, 28 Jul 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SITaB+tS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65F25F96D;
	Mon, 28 Jul 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691100; cv=none; b=RBD371joOq1+cu2BBloHQolU7vKyDAMAik6UlRryN4aCbcJthVl1BkTbyAmKZHLSAHZmwkQ0Gl6mL4YPwKsCUu471K44pLy+avqYCr+J2gV3XYMfVHTC9vvMrj/NvDX8OfnbYycik94YrTEHhqw30bbWMurAVCkmiRSbe9QeFWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691100; c=relaxed/simple;
	bh=juCljX7oHTMXLTvjtJv/ixWHfPDAWKS0NAoRAc5DtFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7mcSAXbMCB2/02hYpYenL+/rQ0KGc4hcXBJbXM25QHBBTex68is0lPXBORD0Q/Ik6RUU583FCT1y+ZfRgYQm+FnCrDscx3d2BA8xBR2J7CdINcN5WFvMjC6ljoUfKfx3cK0vIrVFEk0OCSs0JYDToAT4J08RuSe7E82ZQdjyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SITaB+tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1C1C4CEF9;
	Mon, 28 Jul 2025 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691100;
	bh=juCljX7oHTMXLTvjtJv/ixWHfPDAWKS0NAoRAc5DtFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SITaB+tSQu01TEAH8k5m46jzeXHXflq47YJ+VHQNx/d8JCBiAfxLkHs0MCjnWDRcu
	 1eybZESHcc28/Jjxjga/ms7TolsMNMD8rdGAGcnZ1HFuu8Y63WhBC8owgldFPhH+7y
	 VZkJYXbMsjVbxEJjHcCNZgUb2lziBu7CuaouozpvdYzr8Z34dA9LBYo4XaOG2Z40AJ
	 7jy3vcChu4jnmLWH4+3DgZddNwBOjKmiBlzqXP+dmbmL3UU8bcF7N09PR8tbG9m5r7
	 PcQSNQ/Zd6oQA+Tr429+d6vudwySn4p97oJLgXfF7rhJopXQ94lmEesEYZa2velpCQ
	 icNkaqL1hwWrw==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:49 -0700
Subject: [PATCH RFC 19/25] PCI/LUO: Track liveupdate buses
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-19-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Add the bus state to PCI state, after the devs[] array.

Currently for each bus only save the domain and bus number.

Tested: In QEMU, perform liveupdate prepare. Check dmesg for "collect
	liveupdate bus" matching to the liveupdate device's bus.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 68 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index ec2d7917441ceb4e3d7cd8becae41ca215cba7c3..bc2c166ef494fd0b38cc05500bf0817c0f50fd95 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -16,11 +16,20 @@
 #define PCI_SUBSYSTEM_NAME "pci"
 
 static LIST_HEAD(preserved_devices);
+static LIST_HEAD(preserved_buses);
 static LIST_HEAD(probe_devices);
+static LIST_HEAD(probe_buses);
+
+struct pci_bus_ser {
+	u16	domain;
+	u8	number;
+};
 
 struct pci_ser {
-	u32 count;
+	u32 dev_count;
+	u32 bus_count;
 	struct pci_dev_ser devs[];
+	/* struct pci_bus_ser buses[] */
 };
 
 static void stack_push_buses(struct list_head *stack, struct list_head *buses)
@@ -39,7 +48,7 @@ static void requested_devices_add(struct device *dev, struct list_head *head)
 	list_move_tail(&dev->lu.lu_next, head);
 }
 
-static int collect_bus_devices_reverse(struct pci_bus *bus, struct list_head *head)
+static int collect_buses_and_devices(struct pci_bus *bus, struct list_head *head)
 {
 	struct pci_dev *pdev;
 	int count = 0;
@@ -54,6 +63,13 @@ static int collect_bus_devices_reverse(struct pci_bus *bus, struct list_head *he
 			count++;
 		}
 	}
+	if (count || bus->dev.lu.depended) {
+		if (bus->parent)
+			bus->parent->dev.lu.depended = 1;
+		dev_info(&bus->dev, "collect liveupdate bus %s\n",
+			 dev_name(&bus->dev));
+		list_move_tail(&bus->dev.lu.lu_next, &preserved_buses);
+	}
 	return count;
 }
 
@@ -76,9 +92,11 @@ static int build_liveupdate_devices(struct list_head *head)
 			continue;
 		}
 
-		count += collect_bus_devices_reverse(bus, head);
-		busdev->lu.visited = 0;
+		/* Pop from bus_stack */
 		list_del_init(&busdev->lu.lu_next);
+
+		count += collect_buses_and_devices(bus, head);
+		busdev->lu.visited = 0;
 	}
 	return count;
 }
@@ -102,6 +120,16 @@ static void cleanup_liveupdate_devices(struct list_head *head)
 		dev_cleanup_liveupdate(d);
 }
 
+static void cleanup_liveupdate_buses(struct list_head *head)
+{
+	struct device *b, *n;
+
+	list_for_each_entry_safe(b, n, head, lu.lu_next) {
+		b->lu.depended = 0;
+		list_del_init(&b->lu.lu_next);
+	}
+}
+
 static void cleanup_liveupdate_state(struct pci_ser *pci_state)
 {
 	struct folio *folio = virt_to_folio(pci_state);
@@ -165,16 +193,24 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 	return 0;
 }
 
+static void pci_save_bus_state(struct pci_bus *bus, struct pci_bus_ser *s)
+{
+	s->number = bus->number;
+	s->domain = pci_domain_nr(bus);
+}
+
 static int pci_call_prepare(struct pci_ser *pci_state,
 			    struct list_head *devices)
 {
-	struct pci_dev_ser *pdev_state_current = pci_state->devs;
+	struct pci_dev_ser *dev_state = pci_state->devs;
+	struct pci_bus_ser *bus_state = (struct pci_bus_ser *)
+			(dev_state + pci_state->dev_count);
 	struct device *dev, *next;
 	int ret;
 	char *reason;
 
 	list_for_each_entry_safe(dev, next, devices, lu.lu_next) {
-		struct pci_dev_ser *s = pdev_state_current++;
+		struct pci_dev_ser *s = dev_state++;
 
 		if (!dev->driver) {
 			reason = "no driver";
@@ -200,6 +236,8 @@ static int pci_call_prepare(struct pci_ser *pci_state,
 		}
 		list_move_tail(&dev->lu.lu_next, &preserved_devices);
 	}
+	list_for_each_entry(dev, &preserved_buses, lu.lu_next)
+		pci_save_bus_state(to_pci_bus(dev), bus_state++);
 	return 0;
 
 cancel:
@@ -213,8 +251,10 @@ static int __pci_liveupdate_prepare(void *arg, u64 *data)
 	LIST_HEAD(requested_devices);
 	struct pci_ser *pci_state;
 	int ret;
-	int count = build_liveupdate_devices(&requested_devices);
-	int size = sizeof(*pci_state) + sizeof(pci_state->devs[0]) * count;
+	int devcnt = build_liveupdate_devices(&requested_devices);
+	int buscnt = list_count_nodes(&preserved_buses);
+	int size = sizeof(*pci_state) + sizeof(pci_state->devs[0]) * devcnt
+			+ sizeof(struct pci_bus_ser) * buscnt;
 	int order = get_order(size);
 	struct folio *folio;
 
@@ -225,7 +265,8 @@ static int __pci_liveupdate_prepare(void *arg, u64 *data)
 	}
 
 	pci_state = folio_address(folio);
-	pci_state->count = count;
+	pci_state->dev_count = devcnt;
+	pci_state->bus_count = buscnt;
 
 	ret = kho_preserve_folio(folio);
 	if (ret) {
@@ -247,6 +288,7 @@ static int __pci_liveupdate_prepare(void *arg, u64 *data)
 	folio_put(folio);
 cleanup_device:
 	cleanup_liveupdate_devices(&requested_devices);
+	cleanup_liveupdate_buses(&preserved_buses);
 	return ret;
 }
 
@@ -336,6 +378,7 @@ static void pci_liveupdate_cancel(void *arg, u64 data)
 	down_write(&pci_bus_sem);
 
 	pci_call_cancel(pci_state);
+	cleanup_liveupdate_buses(&preserved_buses);
 	cleanup_liveupdate_state(pci_state);
 
 	up_write(&pci_bus_sem);
@@ -349,6 +392,7 @@ static void pci_liveupdate_finish(void *arg, u64 data)
 	pr_info("finish data[%llx]\n", data);
 	pci_call_finish(&probe_devices);
 	cleanup_liveupdate_devices(&probe_devices);
+	cleanup_liveupdate_buses(&probe_buses);
 	cleanup_liveupdate_state(pci_state);
 }
 
@@ -408,14 +452,16 @@ static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
 void pci_liveupdate_restore(struct pci_dev *dev)
 {
 	int path;
+	struct pci_ser *pci_state;
 	struct pci_dev_ser *s, *end;
 
 	if (!liveupdate_state_updated())
 		return;
 
 	path = pci_get_device_path(dev);
-	s = pci_state_get()->devs;
-	end = s + pci_state_get()->count;
+	pci_state = pci_state_get();
+	s = pci_state->devs;
+	end = s + pci_state->dev_count;
 	for (; s < end; s++)
 		if (s->path == path)
 			return pci_dev_do_restore(dev, s);

-- 
2.50.1.487.gc89ff58d15-goog


