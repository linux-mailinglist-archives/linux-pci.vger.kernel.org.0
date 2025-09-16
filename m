Return-Path: <linux-pci+bounces-36229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF3B58F83
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AD952603D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FC1FDA61;
	Tue, 16 Sep 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHMQCVS9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444061D555;
	Tue, 16 Sep 2025 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008720; cv=none; b=sc82zGTJu3ke9Ne2i55W2ShWLeayjz6LZWYyHebhNpVgLBBJvML7NICmeVXHwWKVwU7DTOi7L74PzDPLzpRojh1Tw35NisQKoWzTTfUCH8uRYqe0sEkWI4APqo12pR44sWN+qi9sCFo113cTxAd8bLJegVJKIat3sVT0ZND20xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008720; c=relaxed/simple;
	bh=65rvMZdqXLBpj1Exfk5pfS+Pgfc+xgvPUvlb1n7tdnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQKIYhCGmjF/i83xjFTKsBllPkpytQ8VGLA1uTyYFCs6+HNwYM6g4vyj/ZKVh0tlda42Evf5ocGvhwY7VsXKfq8PY118rpaSZBCZ5yX9P8lnZhB/C9SEH2S8VbVTXuLvy7f/Wr6exbVi7DDOeYwDzbEjlQEHCdNaXhZx/wqqNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHMQCVS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24529C116D0;
	Tue, 16 Sep 2025 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008719;
	bh=65rvMZdqXLBpj1Exfk5pfS+Pgfc+xgvPUvlb1n7tdnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RHMQCVS9DCY11dGc5jbT0rNwEips3RlTFz5Cy50elxzpxpEHsFtjjHvoriHkaSDw7
	 VJjuPNY57tIq3J5xu2yhnJOAnDPTgDxFg7jmeARwKhxN7XCHLK/xBN7OK4H6kV318P
	 DQFSurbywiNtJ+RsSLa0a8Y3SEXbQ76iXRlLOhIDybLGfUatvloR4A5NdIckXoeL/B
	 pLI5KFvW64faYB19Z7Eqc4bR69KggbXl635xKT0hOP/u+VQ5UIo7546stdlqjvb7PW
	 fOIP6D7TyV9IXy4YnpHkA8nq09mO4RZEGA396YeFc8NOe2Y2hDNitEcNyI+eGFUOj6
	 I9RdeyZHgmCLQ==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:14 -0700
Subject: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Save the PCI driver name into "struct pci_dev_ser" during the PCI
prepare callback.

After kexec, use driver_set_override() to ensure the device is
bound only to the saved driver.

Clear the override after the finish callback.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 36 ++++++++++++++++++++++++++++++++++--
 drivers/pci/pci.h        |  2 ++
 drivers/pci/probe.c      |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 41606df346f751c78f6c69caa275b4a76be72510..ae8f4dc5cf92577a4da83743c3b80bc72974a43e 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -21,6 +21,7 @@ static LIST_HEAD(probe_devices);
 struct pci_dev_ser {
 	u32	path;		/* domain + bus + slot + fn */
 	u32	flags;
+	char	driver_name[63];
 	u64	driver_data;	/* driver data */
 };
 
@@ -87,6 +88,10 @@ static int build_liveupdate_devices(struct list_head *head)
 
 static void dev_cleanup_liveupdate(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (liveupdate_state_updated())
+		WARN_ON(driver_set_override(dev, &pdev->driver_override, "", 0));
 	dev->lu.flags &= ~LU_DEPENDED;
 	dev->lu.dev_state = NULL;
 	list_del_init(&dev->lu.lu_next);
@@ -135,7 +140,13 @@ static int pci_get_device_path(struct pci_dev *pdev)
 static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	const char *name = dev->driver->name;
 
+	if (!name)
+		return -ENXIO;
+	if (strlen(name) > sizeof(s->driver_name) - 1)
+		return -ENOSPC;
+	strscpy(s->driver_name, name, sizeof(s->driver_name));
 	s->path = pci_get_device_path(pdev);
 	s->flags = dev->lu.flags;
 	return 0;
@@ -363,8 +374,8 @@ static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
 {
 	dev->dev.lu.dev_state = s;
 	dev->dev.lu.flags = s->flags;
-	pci_info(dev, "liveupdate restore flags %x data: [%llx]\n",
-		 s->flags, s->driver_data);
+	pci_info(dev, "liveupdate restore flags %x driver: %s data: [%llx]\n",
+		 s->flags, s->driver_name, s->driver_data);
 	list_move_tail(&dev->dev.lu.lu_next, &probe_devices);
 }
 
@@ -384,6 +395,27 @@ void pci_liveupdate_restore(struct pci_dev *dev)
 			return pci_dev_do_restore(dev, s);
 }
 
+void pci_liveupdate_override_driver(struct pci_dev *dev)
+{
+	struct pci_dev_ser *s = dev->dev.lu.dev_state;
+	int ret;
+	int len;
+
+	if (!s)
+		return;
+
+	len = strlen(s->driver_name);
+	if (!len)
+		return;
+
+	ret = driver_set_override(&dev->dev,
+				  &dev->driver_override,
+				  s->driver_name, len);
+	if (ret)
+		panic("PCI Liveupdate override driver failed: %s", s->driver_name);
+}
+
+
 static int __init pci_liveupdate_init(void)
 {
 	int ret;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c9a7383753949994e031dc362920286a475fe2ab..b79a18c5e948980fe2ef3f0a10e0d795b1eee6d7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1161,8 +1161,10 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
 
 #ifdef CONFIG_LIVEUPDATE
 void pci_liveupdate_restore(struct pci_dev *dev);
+void pci_liveupdate_override_driver(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_restore(struct pci_dev *dev) {}
+static inline void pci_liveupdate_override_driver(struct pci_dev *dev) {}
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a0605af1a699cd07b09897172803dcba1d2da9f9..e41a1bef2083aa9184fd1c894d5de964f19d5c01 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2714,6 +2714,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
 
+	pci_liveupdate_override_driver(dev);
+
 	/* Notifier could use PCI capabilities */
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);

-- 
2.51.0.384.g4c02a37b29-goog


