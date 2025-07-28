Return-Path: <linux-pci+bounces-33021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B831EB13698
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F400617922B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27EE263F44;
	Mon, 28 Jul 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpxQqHVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74164263F5E;
	Mon, 28 Jul 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691101; cv=none; b=C5u6gmq9XM7k0jnbobKyrvw3KQVOnJVVa436b/X+pafEZfB3dyzp2RrfDGNp83A26JIbzqkkQAbPyO7lSgC4RJLBLyJvTj+CibxIzcYzGSUZZmN7pqZhjId35IY+Mt4J1X3IeHl0H6Uwp0xrKhzWuebZQS2RBRAZA5gfKp99Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691101; c=relaxed/simple;
	bh=li5Q22e4feDbcXIQrk3wPzRkb+BbXFeCCERNZ9GWjto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTSQr3eybmEHDb5vlkN1+s7FagXch6raMhanz9mbfdxkmEfJzozMZAl+Kt+y0+0IccdZ8m+THGzw69EXpZD0ixFUY/LCyxY5LK1xOWJKEkjuyBNHMVS1BhemtSonizLOcupvRp94mqegdDNgzgayr+qHxyy0jDjNXzWPpqp8tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpxQqHVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B06C4CEE7;
	Mon, 28 Jul 2025 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691101;
	bh=li5Q22e4feDbcXIQrk3wPzRkb+BbXFeCCERNZ9GWjto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VpxQqHVdeNn9dKW35pGt9VhlI0tG1Y97OEeSuRy8RRA0NBGtHVnh8HBhrfCKZCOOQ
	 fAqX0ZZi9IK6e3EjbxDB4ASIcYeNlI1rWTV604Kku9rtAVY4tl4kPwSYAdyKpMqf4G
	 30+CZRGImjxpi56PFtyQEKO402lBTnZtsqAIP+SiYQEpzZ2xs2PCKAY+sTHkRVyJVr
	 3mDw+KfQ4wV6BqIFI2h7cjk4viJiP48QFeCL/CmPETm6m8XiRvA0SEfxzkHgeU4Cle
	 nt2Pyc707ui+8tvZ4bQdW8BQud6xCXp+Y+Bor6pDABD06WNqYrDR0g2R56If+l2y4D
	 dtRRNeweMXZ2w==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:51 -0700
Subject: [PATCH RFC 21/25] PCI/LUO: Save and restore the PCI resource
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-21-955b078dd653@kernel.org>
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

Preserve the resource array in pci_dev, in pci_dev_ser with an array
of `struct pci_resource_ser`. This array save all resource regions
claimed by a PCI device in the LUO prepare phase.

When a PCI device is setting up after a liveupdate reboot, normally it
read/write the PCI BARs for probing the available resource regions,
with pci_read_bases() function. We check if liveupdate is enabled and
the preserved resource is preserved. If it does, we restore the
resource data structure instead of accessing the hardware.

Tested:
  - QEMU VM boot test. Save and restore a pf-test driver.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h        | 17 ++++++++++++++++
 drivers/pci/probe.c      | 18 ++++++++++++++---
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index bc2c166ef494fd0b38cc05500bf0817c0f50fd95..7fda7e4d409adce6bf92ef7af1167f7bda302c7e 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -166,10 +166,12 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	const char *name = dev->driver->name;
+	int i;
 
 	if (!name)
 		return -ENXIO;
-	if (strlen(name) > sizeof(s->driver_name) - 1)
+	if ((strlen(name) > sizeof(s->driver_name) - 1) ||
+	    (strlen(name) > sizeof(s->resource[0].name) - 1))
 		return -ENOSPC;
 	strscpy(s->driver_name, name, sizeof(s->driver_name));
 	s->path = pci_get_device_path(pdev);
@@ -190,6 +192,28 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 	s->pref_window = pdev->pref_window;
 	s->pref_64_window = pdev->pref_64_window;
 
+	/*
+	 * Per PCIe r4.0, sec 9.3.4.1.11, the VF BARs are all RO Zero,
+	 * no need to preserve the resource.
+	 */
+	if (pdev->is_virtfn)
+		return 0;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		/* This resource region is not claimed by this device, skip. */
+		if ((pdev->resource[i].name == NULL) ||
+		    (strlen(pdev->resource[i].name) == 0))
+			continue;
+
+		s->resource[i].start = pdev->resource[i].start;
+		s->resource[i].end = pdev->resource[i].end;
+		s->resource[i].flags = pdev->resource[i].flags;
+		s->resource[i].desc = pdev->resource[i].desc;
+
+		strscpy((char *)s->resource[i].name, pci_name(pdev),
+			sizeof(s->resource[i].name));
+	}
+
 	return 0;
 }
 
@@ -502,6 +526,32 @@ void pci_liveupdate_override_driver(struct pci_dev *dev)
 		panic("PCI Liveupdate override driver failed: %s", s->driver_name);
 }
 
+int pci_liveupdate_reclaim_resource(struct pci_dev *dev)
+{
+	const char *name = pci_name(dev);
+	int i;
+
+	if (!dev->dev.lu.dev_state)
+		return -EINVAL;
+
+	if (dev->is_virtfn)
+		return 0;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		/* This resource region was not claimed, skip.  */
+		if (strncmp(PCI_SER_GET(dev, resource[i].name, ""), name,
+				strlen(name)) != 0)
+			continue;
+
+		dev->resource[i].start = PCI_SER_GET(dev, resource[i].start, 0);
+		dev->resource[i].end = PCI_SER_GET(dev, resource[i].end, 0);
+		dev->resource[i].name = pci_name(dev);
+		dev->resource[i].flags = PCI_SER_GET(dev, resource[i].flags, 0);
+		dev->resource[i].desc = PCI_SER_GET(dev, resource[i].desc, 0);
+	}
+
+	return 0;
+}
 
 static int __init pci_liveupdate_init(void)
 {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bd198227ae3cf687f4ddae76c2f53125681ca91d..7af32edb128faef9c5e2665ca5055374f7fd30ea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -489,6 +489,19 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+#define PCI_RESOURCE_SER_NAME_SIZE 64
+struct pci_resource_ser {
+	u64 start;
+	u64 end;
+	const char name[PCI_RESOURCE_SER_NAME_SIZE];
+	u64 flags;
+	u64 desc;
+	/*
+	 * The PCI resource is not nested. We do not need to preserve
+	 * the parent, sibling, child pointers in the original struct resource.
+	 */
+} __packed;
+
 struct pci_dev_ser {
 	u32	path;		/* domain + bus + slot + fn */
 	u8	requested;
@@ -509,6 +522,7 @@ struct pci_dev_ser {
 	u32	hotplug_user_indicators:1;
 	u32	pref_window:1;
 	u32	pref_64_window:1;
+	struct pci_resource_ser resource[DEVICE_COUNT_RESOURCE];
 } __packed;
 
 #ifdef CONFIG_PCI_DOE
@@ -1192,6 +1206,7 @@ static inline struct pci_dev_ser *pci_lu_adopt(struct pci_dev *dev)
 {
 	return dev->dev.lu.requested ? dev->dev.lu.dev_state : NULL;
 }
+int pci_liveupdate_reclaim_resource(struct pci_dev *dev);
 #else
 #define PCI_SER_GET(__dev, __var, __def) __def
 
@@ -1201,5 +1216,7 @@ static inline struct pci_dev_ser *pci_lu_adopt(struct pci_dev *dev)
 {
 	return NULL;
 }
+static inline int pci_liveupdate_reclaim_resource(
+	struct pci_dev *dev) { return -ENXIO; }
 #endif
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5c30d1d52a96b17a92794756cab5db0972548267..a101a44956821e5e81c6b063e6aab7db49a4cf7f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2096,7 +2096,13 @@ int pci_setup_device(struct pci_dev *dev)
 		if (class == PCI_CLASS_BRIDGE_PCI)
 			goto bad;
 		pci_read_irq(dev);
-		pci_read_bases(dev, PCI_STD_NUM_BARS, PCI_ROM_ADDRESS);
+
+		/*
+		 * If we can reclaim the resource from liveupdate preserved data,
+		 * do not access the hardware.
+		 */
+		if (pci_liveupdate_reclaim_resource(dev) < 0)
+			pci_read_bases(dev, PCI_STD_NUM_BARS, PCI_ROM_ADDRESS);
 
 		pci_subsystem_ids(dev, &dev->subsystem_vendor, &dev->subsystem_device);
 
@@ -2152,7 +2158,10 @@ int pci_setup_device(struct pci_dev *dev)
 		 */
 		pci_read_irq(dev);
 		dev->transparent = ((dev->class & 0xff) == 1);
-		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
+
+		if (pci_liveupdate_reclaim_resource(dev) < 0)
+			pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
+
 		pci_read_bridge_windows(dev);
 		set_pcie_hotplug_bridge(dev);
 		pos = pci_find_capability(dev, PCI_CAP_ID_SSVID);
@@ -2166,7 +2175,10 @@ int pci_setup_device(struct pci_dev *dev)
 		if (class != PCI_CLASS_BRIDGE_CARDBUS)
 			goto bad;
 		pci_read_irq(dev);
-		pci_read_bases(dev, 1, 0);
+
+		if (pci_liveupdate_reclaim_resource(dev) < 0)
+			pci_read_bases(dev, 1, 0);
+
 		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_ID, &dev->subsystem_device);
 		break;

-- 
2.50.1.487.gc89ff58d15-goog


