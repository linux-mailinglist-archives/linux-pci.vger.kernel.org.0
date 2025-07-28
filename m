Return-Path: <linux-pci+bounces-33022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBBAB1369C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F99E17A3DE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC2264A7F;
	Mon, 28 Jul 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZdrC8Fv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9A264638;
	Mon, 28 Jul 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691102; cv=none; b=nBSfjq7Lm+nWve54j/rVPycBDuS2FwrPqbxXmhwrKArepX5yfrfLg+gbo7lNwzqk2rEiAz6gLACC8ZvU7A6F0XxO6TzSeF9a/PzK9kSrmwTkpjTQSqEkLeLLRvi/j8I7KF5F6IIt5eIebOzoQCszs4KKzI/4nmhVWoarspjPibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691102; c=relaxed/simple;
	bh=903NuybbYnxSHrFX0vEqTNoJB/Kj4NeieaFb+MTU0mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COZD//JHkFJkO9t4DRLexT0wUih+hGkQLwRbcNAdYjm8gzrr9zz3NyBDrd3sPZBOwSXBmP1Gn3eHOuYBHslCOotuAQa1vTcCvxhyzKgxNwfgxd2aRAsCSLGv8hFf9SL5EoAESer/wJlmh3mLat2Geo1HenlRNOFHovmeHncxRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZdrC8Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7552BC4CEFB;
	Mon, 28 Jul 2025 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691102;
	bh=903NuybbYnxSHrFX0vEqTNoJB/Kj4NeieaFb+MTU0mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aZdrC8Fv2tLqZr6YNNoEx/xvn92aW1MWReV4sFxFXCZEVUtmr2l7GNztDWakURsZ2
	 ahVRaUdvhp8zJ0e2W3UOdEyNBePFaReCM6nw6X4bTRzQ1dLZu675I6V6QEbNPjBmbx
	 h9+dxjQAZAGvgkKRJ9P6qRzCaLTnoUAU6nOvl7JPnvQ0+7DMy+SWfXk1cjfgf9vnz8
	 U4NGTuiDBIkD6K0Xok/FUeWuo8YAMM+x2G07pII3/v8IMDkWZkum8r5LAZZieyxMUT
	 0M6ZUemexwzcPAs/cbqx8JPL+ayQ02auqmBFMAPJ2H8bLoZy8tqQnqtXurJwsyhDoj
	 yms/YAh4F4N1g==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:52 -0700
Subject: [PATCH RFC 22/25] PCI/LUO: Save PCI bus and host bridge states
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-22-955b078dd653@kernel.org>
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

In the LUO prepare phase, saves the PCI bus and host bridge states.

For a PCI bus, save the domain and bus numbers. Save the bridge types.
Save the upstream bus domain and bus numbers so we can verify the
relationship in the later restoration phase.

If the current bridge is a host bridge, save also the PCI bridge
resource. This is not needed by other PCI bridges as the resource is
already preserved by its associated struct pci_dev.

Tested:
  - QEMU VM boot test, preserve device with pci-lu-stub

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 7fda7e4d409adce6bf92ef7af1167f7bda302c7e..be22af7a2db3a9bb06d8e100603a59f11b7fa5f8 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -20,9 +20,20 @@ static LIST_HEAD(preserved_buses);
 static LIST_HEAD(probe_devices);
 static LIST_HEAD(probe_buses);
 
+enum pci_bus_ser_bridge_type {
+	PCI_BUS_SER_NULL_BRIDGE, /* virtual bus */
+	PCI_BUS_SER_PCI_HOST_BRIDGE,
+	PCI_BUS_SER_PCI_BRIDGE,
+};
+
 struct pci_bus_ser {
 	u16	domain;
 	u8	number;
+	u16	parent_domain;
+	u8	parent_number;
+	enum pci_bus_ser_bridge_type bridge_type;
+	/* For a root bus, saves the host bridge PCI bridge resource */
+	struct pci_resource_ser resource[PCI_BRIDGE_RESOURCE_NUM];
 };
 
 struct pci_ser {
@@ -162,6 +173,16 @@ static int pci_get_device_path(struct pci_dev *pdev)
 	return (pci_domain_nr(pdev->bus) << 16) | pci_dev_id(pdev);
 }
 
+static void save_device_resource(struct pci_resource_ser *dest,
+				 struct resource *src)
+{
+	strscpy((char *)dest->name, src->name, sizeof(dest->name));
+	dest->start = src->start;
+	dest->end = src->end;
+	dest->flags = src->flags;
+	dest->desc = src->desc;
+}
+
 static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -205,13 +226,7 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 		    (strlen(pdev->resource[i].name) == 0))
 			continue;
 
-		s->resource[i].start = pdev->resource[i].start;
-		s->resource[i].end = pdev->resource[i].end;
-		s->resource[i].flags = pdev->resource[i].flags;
-		s->resource[i].desc = pdev->resource[i].desc;
-
-		strscpy((char *)s->resource[i].name, pci_name(pdev),
-			sizeof(s->resource[i].name));
+		save_device_resource(s->resource + i, pdev->resource + i);
 	}
 
 	return 0;
@@ -219,8 +234,37 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 
 static void pci_save_bus_state(struct pci_bus *bus, struct pci_bus_ser *s)
 {
-	s->number = bus->number;
+	int i;
+
 	s->domain = pci_domain_nr(bus);
+	s->number = bus->number;
+	if (bus->parent) {
+		s->parent_domain = pci_domain_nr(bus->parent);
+		s->parent_number = bus->parent->number;
+	}
+
+	/* This bus is a virtual bus if no physical bridge is being referred. */
+	if (!bus->bridge) {
+		s->bridge_type = PCI_BUS_SER_NULL_BRIDGE;
+		return;
+	}
+
+	if (!pci_is_root_bus(bus)) {
+		s->bridge_type = PCI_BUS_SER_PCI_BRIDGE;
+		return;
+	}
+
+	/* This bridge is a PCI host bridge. Saves its resource. */
+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+		/* This resource region is not claimed, skip. */
+		if ((bus->resource[i] == NULL) ||
+		    (bus->resource[i]->name == NULL) ||
+		    (strlen(bus->resource[i]->name) == 0))
+			continue;
+
+		save_device_resource(s->resource + i, bus->resource[i]);
+	}
+	s->bridge_type = PCI_BUS_SER_PCI_HOST_BRIDGE;
 }
 
 static int pci_call_prepare(struct pci_ser *pci_state,

-- 
2.50.1.487.gc89ff58d15-goog


