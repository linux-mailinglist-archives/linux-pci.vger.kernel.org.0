Return-Path: <linux-pci+bounces-33008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6243B13668
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDBD1899E2F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561CD255F4C;
	Mon, 28 Jul 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQX56eWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD225524D;
	Mon, 28 Jul 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691093; cv=none; b=Fg5JHzLIfAEHidiomhZ30N5UYVmf2KohNNcMwsiGLznG76c4rPS5fZhhaL/5PptaNxH/dB7wK1F7jizAPuVIyJ05uip09IfRPL0v2hStCKTwruX4NUF9Ps3dSGrd5iDl6FsSaDNOAmfb67wJDtYYeh1A8fpf6iKMW7VXGjdo3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691093; c=relaxed/simple;
	bh=5MJjhbKurh9H3wo8pggfA7BuVWDa3XXOmJlG/RO2c/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CyyooCDdHcpiqClnBmHmR2DK5AoSEWiGUWjNEoM68zkFOM0hBWfln0ns8uc7NT0JEVWKSM1LYs6GHIssggWhc+2BZG9J1zbt71NIIfbfKvJlIOwkZ6zpLCQp9SCHx6i04uXmKMouy5P2aM/KSI1eSTorVu4uAo63eFyWIPAMt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQX56eWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36133C4CEFC;
	Mon, 28 Jul 2025 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691092;
	bh=5MJjhbKurh9H3wo8pggfA7BuVWDa3XXOmJlG/RO2c/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WQX56eWjBRHu/4oZURg5khPQ9g81kL/wxaBS5BnhTuCxGb7JINyxKFzzuOwVaehYM
	 f2WF1u+wFE6XF7hE6cHNlzk2vk+VbRp7OlwN7HPD2xyl0DPSmWozeHMTf6AO0rSMyR
	 AmVUXW/KD+BXCREtvieJPY01XZtHT8zHhtwSp0COVPmsAbqO9tTLNPR7m6wadWjAO4
	 wg+lulwCMzGb1bBZ3aQsHI6K5KlB6QdFsLojJlnoHA2RYmDqaEdJIXquYi8U30BLx5
	 /WVAtxfGPyW4Sdw2ICl+Xm93/w3QSo38vTpxmngh81ayk1+VOtK/jzwy+m3h0/gJIJ
	 QzBgC+UAa0ATg==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:38 -0700
Subject: [PATCH RFC 08/25] PCI/LUO: Add liveupdate to pcieport driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-8-955b078dd653@kernel.org>
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

The PCIe port driver is the driver bound to the PCI-PCI bridge.
The PCIe port device is depended on by its PCI children devices.

Add the empty liveupdate callback to the pcieport driver to indicate
this driver supports liveupdate. Otherwise it can fail the liveupdate
operation if the PCI-PCI bridge is depended..

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/pcie/portdrv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 0e9ef387182856771d857181d88f376632b46f0d..fd43c1ebfb9d2852fbc460b0390dd7fb016226d2 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -789,6 +789,15 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.mmio_enabled = pcie_portdrv_mmio_enabled,
 };
 
+#ifdef CONFIG_LIVEUPDATE
+
+/*
+ * Empty pcie_port_lu_ops to indicate this driver support liveupdate.
+ */
+static struct dev_liveupdate_ops pcie_port_lu_ops;
+
+#endif /* CONFIG_LIVEUPDATE */
+
 static struct pci_driver pcie_portdriver = {
 	.name		= "pcieport",
 	.id_table	= port_pci_ids,
@@ -802,6 +811,9 @@ static struct pci_driver pcie_portdriver = {
 	.driver_managed_dma = true,
 
 	.driver.pm	= PCIE_PORTDRV_PM_OPS,
+#ifdef CONFIG_LIVEUPDATE
+	.driver.lu	= &pcie_port_lu_ops,
+#endif
 };
 
 static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)

-- 
2.50.1.487.gc89ff58d15-goog


