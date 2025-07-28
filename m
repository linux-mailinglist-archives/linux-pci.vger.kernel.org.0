Return-Path: <linux-pci+bounces-33023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D74DB136A1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6562716788F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0926560C;
	Mon, 28 Jul 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um6HWGYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE132652BD;
	Mon, 28 Jul 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691103; cv=none; b=nP61zWO7Xkr5IzTiNAFdUwbPLbwWAAhTXwXQjaCGTYW7sz/A7GvWXxAM9y7NXbzJF5uVhaHeAmqSuNFBqlqkMrH5WADxG21H/cbmoY7C/lhGdzxgKHgzSc9Xx5jg40WSiNME2GWsZJwA+3YUdkJ56WL+PBSrlopuR1JRotxHZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691103; c=relaxed/simple;
	bh=LRhBZ85o77YrbZBA8G2KDhGK7PyUYIQNe7/MgVZxEpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rf5gQHi4+1HSYQvkAN/hqeF1LG5902aVPVuVWX1BDA9AaHWyhG9s7QsV2q6DhjRXSG83PHeRmQDrV7Xjmf84Tyk20QZ2nHLUC5JTa3Gt2N07lqNGlPHGJZA6hXByvIjiIY71wtK/sBf9+iInL/SPSWu9Chu4z500v7xh2uAaLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um6HWGYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22398C4CEFA;
	Mon, 28 Jul 2025 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691102;
	bh=LRhBZ85o77YrbZBA8G2KDhGK7PyUYIQNe7/MgVZxEpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Um6HWGYnXC8m4qLyKp7uH5NnjfodshSZ1YA039nEFBDiIY4Tk/Aqb1RutElNqP7pl
	 wcgL0XKZXdjKYWFuUxW5nD22mqkqL6UFevyrqbegG36Ais0CJcjAcJdkdJAbqXNMow
	 LDs97p8KNXsL4mXaT9jZnFy8MTeuPwSjekKt/7BY6WWG4t/VJeJifVGSDBapcSy25u
	 Uj6+AGiI8ucrIApbUhk15Nfc3Uo1r3gbDWaAHJbd3yiwmNx6uN8r8cpD9t/f7Cq5Hy
	 PJR6H1BoiGkR9a+ARPWz3DfNtIO5aUH4u00RbLNY4Ic4lLKJTF6DszeiEqs9x4w3x+
	 WRXYQp0jCfGnw==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:53 -0700
Subject: [PATCH RFC 23/25] PCI/LUO: Check the PCI bus state after
 restoration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-23-955b078dd653@kernel.org>
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

From: Jason Miu <jasonmiu@google.com>

After the LUO reboot, check if the bus topology assoicated with the
current PCI device is matching with the bus states saved in LUO. We like
to verify:
- The domain and bus numbers.
- The parent bus domain and number.
- The bus type, which can be PCI-PCI bridge, host bridge, or virtual bus.
- PCI bridge resource of host bridge, as different from PCI-PCI bridge
which the resource is restorated from the PCI bridge device, we check
if the host bridge resource is changed from the last boot.

Tested:
  - QEMU VM liveupdate boot test with pci-lu-stub

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 123 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 110 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index be22af7a2db3a9bb06d8e100603a59f11b7fa5f8..739de5f655dba04024c9cf8db2bf6ea5e136cf5f 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -43,6 +43,45 @@ struct pci_ser {
 	/* struct pci_bus_ser buses[] */
 };
 
+static struct pci_bus_ser *get_saved_pci_bus_state(struct pci_ser *state,
+						   u16 domain, u8 number)
+{
+	int i;
+	struct pci_bus_ser *bus_state =
+		(struct pci_bus_ser *)(state->devs + state->dev_count);
+
+	for (i = 0; i < state->bus_count; i++, bus_state++) {
+		if (bus_state->domain == domain  &&
+		    bus_state->number == number)
+			return bus_state;
+	}
+
+	return NULL;
+}
+
+static enum pci_bus_ser_bridge_type get_bus_ser_bridge_type(struct pci_bus *bus)
+{
+	/* This bus is a virtual bus if no physical bridge is being referred. */
+	if (!bus->bridge)
+		return  PCI_BUS_SER_NULL_BRIDGE;
+
+	return pci_is_root_bus(bus) ?
+		PCI_BUS_SER_PCI_HOST_BRIDGE : PCI_BUS_SER_PCI_BRIDGE;
+}
+
+static char *bus_ser_bridge_type_to_string(enum pci_bus_ser_bridge_type bt)
+{
+	switch (bt) {
+	case PCI_BUS_SER_NULL_BRIDGE:
+		return "PCI_BUS_SER_NULL_BRIDGE";
+	case PCI_BUS_SER_PCI_BRIDGE:
+		return "PCI_BUS_SER_PCI_BRIDGE";
+	case PCI_BUS_SER_PCI_HOST_BRIDGE:
+		return "PCI_BUS_SER_PCI_HOST_BRIDGE";
+	}
+	return "PCI_BUS_SER_INVALID";
+}
+
 static void stack_push_buses(struct list_head *stack, struct list_head *buses)
 {
 	struct pci_bus *bus;
@@ -183,6 +222,71 @@ static void save_device_resource(struct pci_resource_ser *dest,
 	dest->desc = src->desc;
 }
 
+static void check_saved_bus_state(struct pci_dev *dev, struct pci_ser *pci_state)
+{
+	int i;
+	const struct resource *res;
+	const struct pci_resource_ser *saved_res;
+	const struct pci_bus_ser *bus_state =
+		get_saved_pci_bus_state(pci_state,
+					pci_domain_nr(dev->bus),
+					dev->bus->number);
+	struct pci_bus *bus = dev->bus;
+
+	if (!bus_state) {
+		panic("The bus of PCI device %s was not preserved by Liveupdate",
+		      pci_name(dev));
+	}
+
+	if (get_bus_ser_bridge_type(bus) != bus_state->bridge_type) {
+		panic("The bus (%04x:%02x) bridge type (%s) of PCI device (%s) is changed. "
+		      "Liveupdate preserved %s",
+		      pci_domain_nr(bus), bus->number,
+		      bus_ser_bridge_type_to_string(get_bus_ser_bridge_type(bus)),
+		      pci_name(dev),
+		      bus_ser_bridge_type_to_string(bus_state->bridge_type));
+	}
+
+	if (bus->parent) {
+		if (pci_domain_nr(bus->parent) != bus_state->parent_domain ||
+		    bus->parent->number != bus_state->parent_number) {
+			panic("The parent bus (%04x:%02x) of PCI device (%s) is changed. "
+			      "Liveupdate preserved %04x:%02x",
+			      pci_domain_nr(bus->parent), bus->parent->number,
+			      pci_name(dev),
+			      bus_state->parent_domain, bus_state->parent_number);
+		}
+
+		/* Checkings of PCI-PCI bridge and Virtual bus ends. */
+		return;
+	}
+
+	/* This is a host bridge device */
+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+
+		res = bus->resource[i];
+		if (res == NULL ||
+		    res->name == NULL ||
+		    strlen(res->name) == 0)
+			continue;
+
+		/* check its PCI bridge resource */
+		saved_res = &bus_state->resource[i];
+		if (res->start != saved_res->start ||
+		    res->end != saved_res->end ||
+		    res->flags != saved_res->flags ||
+		    res->desc != saved_res->desc ||
+		    strncmp(res->name, saved_res->name, sizeof(saved_res->name)) != 0) {
+			panic("Host bridge resource %pr is changed. "
+			      "Liveupdate preserved "
+			      "[mem 0x%016llx-0x%016llx flags 0x%016llx desc 0x%016llx name %s]",
+			      res,
+			      saved_res->start, saved_res->end,
+			      saved_res->flags, saved_res->desc, saved_res->name);
+		}
+	}
+}
+
 static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -238,22 +342,13 @@ static void pci_save_bus_state(struct pci_bus *bus, struct pci_bus_ser *s)
 
 	s->domain = pci_domain_nr(bus);
 	s->number = bus->number;
+	s->bridge_type = get_bus_ser_bridge_type(bus);
+
 	if (bus->parent) {
 		s->parent_domain = pci_domain_nr(bus->parent);
 		s->parent_number = bus->parent->number;
 	}
 
-	/* This bus is a virtual bus if no physical bridge is being referred. */
-	if (!bus->bridge) {
-		s->bridge_type = PCI_BUS_SER_NULL_BRIDGE;
-		return;
-	}
-
-	if (!pci_is_root_bus(bus)) {
-		s->bridge_type = PCI_BUS_SER_PCI_BRIDGE;
-		return;
-	}
-
 	/* This bridge is a PCI host bridge. Saves its resource. */
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
 		/* This resource region is not claimed, skip. */
@@ -264,7 +359,6 @@ static void pci_save_bus_state(struct pci_bus *bus, struct pci_bus_ser *s)
 
 		save_device_resource(s->resource + i, bus->resource[i]);
 	}
-	s->bridge_type = PCI_BUS_SER_PCI_HOST_BRIDGE;
 }
 
 static int pci_call_prepare(struct pci_ser *pci_state,
@@ -531,8 +625,11 @@ void pci_liveupdate_restore(struct pci_dev *dev)
 	s = pci_state->devs;
 	end = s + pci_state->dev_count;
 	for (; s < end; s++)
-		if (s->path == path)
+		if (s->path == path) {
+			/* If the bus state checking fails, kernel panics */
+			check_saved_bus_state(dev, pci_state);
 			return pci_dev_do_restore(dev, s);
+		}
 }
 
 int pci_liveupdate_get_driver_data(struct pci_dev *pdev, u64 *data)

-- 
2.50.1.487.gc89ff58d15-goog


