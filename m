Return-Path: <linux-pci+bounces-36230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F067FB58F7E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220077AB22E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47946281368;
	Tue, 16 Sep 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltGV8J4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F627E7FC;
	Tue, 16 Sep 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008721; cv=none; b=YzY9Tp3iDaw3/Ooc14x6drW2lvebxw5Bs53QmeGCNZmNVSkbRDKo+wP1po/dQj8nxrW9eY39J+jP90Ib1kH+6sCEE1+WmrShbtFq/TUzJBZ5mt6Q3ms2s7R49T4Xf1x8S89EMI6I3RBpJ/KAmtOrkewDqftahoWV4KwueMyIOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008721; c=relaxed/simple;
	bh=S/SAVcOuL1qr6u1V0slNP0sdoMJObAMYCW0npcEpXBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VvjTLxefMY8BU3dzWXJeUYKQHeymAk7jB6/T4l502bVmvS/mPIDWdwl9yVFB6u+GBZlRkEFM9gAEIvdbEh8RRqf50geC7GbrUgfbm5pmq8RLLbcC3I9xkGx0oSRNVIVoAaL37wY5VA02WtbKxwIUmqBlh+VU9JYwgk9ZbjZGlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltGV8J4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A38C4CEEB;
	Tue, 16 Sep 2025 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008720;
	bh=S/SAVcOuL1qr6u1V0slNP0sdoMJObAMYCW0npcEpXBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ltGV8J4zvBd4mKlAWEM116fuQfCWh8sFGFgitaYemXSNlWf+nJFWFOlWeN/XMgWRW
	 ty3syVGvznfQ2ShFevWf2CSF7ChkCBj3rE7ongw3eZN1OLXsD8LLKE862i2fPM+tyQ
	 4abt64w6NpoZ5iJ3GG9t+oTMWf/FvJUpQM0fc+LbpOQwXTSnB9gMvz6CRAtrHz7fys
	 lbTiMMIAlaFKveziJLKVjZZ86WvuJDCAYi4RbvD6IZCDDpjFUFiYGL1EGfZSexQiQD
	 UFinip2ItQTuWSR6IpwbEpYSnbxJjKZ9NUEufmsVrKZBWEeP3q8udQu2gYPYZ0joe3
	 bsi+euoz9ZIIw==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:15 -0700
Subject: [PATCH v2 07/10] PCI/LUO: Add liveupdate to pcieport driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-7-c494053c3c08@kernel.org>
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
2.51.0.384.g4c02a37b29-goog


