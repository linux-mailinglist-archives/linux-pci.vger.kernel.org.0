Return-Path: <linux-pci+bounces-36232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE99B58F8C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FC1B22189
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5F2848A4;
	Tue, 16 Sep 2025 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfJj6eYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FB284886;
	Tue, 16 Sep 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008722; cv=none; b=aEBBy1XxK3VHUNgVPK25JFjyfCF9chtUykDkJG6gpx+O7bJ5au9y58wX5dytJpbm6WZuddbR/rSziRhZZKFA1r4d69QUleF9uwQL2zmrl4+iSH6TZB/tLRTtr9EZ5shAcOJ5ZomzJ9PFZEYRztZ62AqUPKqQ5Dq4W0SZwH2qsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008722; c=relaxed/simple;
	bh=dUcb/BZPkxNt0dROS5Ezcx5T/Q+ckLs6aaqzBb/B6HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/gx6pRPLKGscUhfKSU62IGhgAzKdoGQFRM4wKOZ/WEsVHOKPd/eg4MJ6uKRr+vAHG4ooznwco9iNLmNQ1xsNJ6KfxiP2TyGGnR7IZ6p/2Q8QAzBSqu8US1Di2b7hdfzWo4Z3BX9cGS9hTwHzzsIDo0jKYsGwaTQLk/pb8CzMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfJj6eYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4ECC4CEF7;
	Tue, 16 Sep 2025 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008722;
	bh=dUcb/BZPkxNt0dROS5Ezcx5T/Q+ckLs6aaqzBb/B6HE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kfJj6eYA+tLSMezqd0KiYus0yp3bie9xOgk+GfPWahtZRQvZjgZlTcjGn/STIxTD8
	 0qwJRe49489Bv10hjZG1jWCMpipFrp4T0qezlYe6jhf3fbhLF1a4ftx9zFUJwUsXKo
	 dq7b9zG92b11RYPw1/JHI365Joe5UU1QEL9e2yxm/DDdsR7zOvG8NzY/E+suCeuTJU
	 9+1eBMUs+NJbiQBAzf6uEE84/7KSApMQ9xImInIfzTbs5nz+W/+hxTdQDYEMyty8HK
	 FiZkx2TXltr/gN0FwX9kasawVXXyTY1Ew4Rhx94XU8gP9rvlQq7efSHgl3XybxUmZH
	 LtoW8YDnzSXRA==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:17 -0700
Subject: [PATCH v2 09/10] PCI/LUO: Avoid write to bus master at boot
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-9-c494053c3c08@kernel.org>
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

If the liveupdate flag has LU_BUSMASTER or LU_BUSMASTER_BRIDGE, the
device is participating in the liveupdate preserving bus master bit in the
PCI config space command register.

Avoid writing to the PCI command register for the bus master bit during
boot up.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 6 ++++++
 drivers/pci/pci.c        | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 1b12fc0649f479c6f45ffb26e6e3754f41054ea8..a09a166b6ee271b96bce763716c3b62b24f3edbb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -377,6 +377,12 @@ static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
 	pci_info(dev, "liveupdate restore flags %x driver: %s data: [%llx]\n",
 		 s->flags, s->driver_name, s->driver_data);
 	list_move_tail(&dev->dev.lu.lu_next, &probe_devices);
+	if (s->flags & (LU_BUSMASTER | LU_BUSMASTER_BRIDGE)) {
+		u16 pci_command;
+
+		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+		WARN_ON(!(pci_command & PCI_COMMAND_MASTER));
+	}
 }
 
 void pci_liveupdate_restore(struct pci_dev *dev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb108920995ebe34bd2535a0e23fef7fd..2339ac1bd57616a78d2105ba3a4fc72bbf49973e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2248,7 +2248,8 @@ static void do_pci_disable_device(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
 	if (pci_command & PCI_COMMAND_MASTER) {
 		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+		if (!(dev->dev.lu.flags & (LU_BUSMASTER | LU_BUSMASTER_BRIDGE)))
+			pci_write_config_word(dev, PCI_COMMAND, pci_command);
 	}
 
 	pcibios_disable_device(dev);
@@ -4276,7 +4277,9 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 	if (cmd != old_cmd) {
 		pci_dbg(dev, "%s bus mastering\n",
 			enable ? "enabling" : "disabling");
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+		if (!(dev->dev.lu.flags & (LU_BUSMASTER | LU_BUSMASTER_BRIDGE)))
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
 	dev->is_busmaster = enable;
 }

-- 
2.51.0.384.g4c02a37b29-goog


