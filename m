Return-Path: <linux-pci+bounces-10884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8993E780
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61617B2282A
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4977BAFF;
	Sun, 28 Jul 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7wpxkto"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E07B3FE;
	Sun, 28 Jul 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182747; cv=none; b=e24AkosAat12bRfXUE6UuJ0SoJAS3Xj42XVYyQtthwrU+m1eYHF/kaBFfvTlP6XToEnhISqQ1p7meLJnpv+MC5wxH/hh2J6L1Apr0RLGUtTF91quMo/SXhPcpoXbqMAYLR0Wsavt+BUjH8PVrVsz4aUjSO10OpaspsHIM/f/7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182747; c=relaxed/simple;
	bh=sJOLhP/nI8VoAxe5q6q1ZR1U0neuW6NevOPuSZcmXyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxM8LlWkoPCDQ6mCWWROrXQ67lvuf5KjYxMBwCaDZ0gIU+bcogw2W7f/EPoxrtxNS298+8wkPUtEpcpFs7qng0IVhpXa2M29L5T+Igr8qqWHaEMwnmcIOZ9+K7Ly2Ns2WoSls3JooFng7cyVnKHNqM459ezEphVgB9NbHP8zcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7wpxkto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B2AC32782;
	Sun, 28 Jul 2024 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182747;
	bh=sJOLhP/nI8VoAxe5q6q1ZR1U0neuW6NevOPuSZcmXyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7wpxktohCtgZGEr9/v/ULHS9M+rW0QRz0u8uanpSUraQaEf3rSbU4B40GHMcY3kr
	 UPJp9i40PQwrnvs1DKrplthq+j9Py+PUgD4Dngmntq10hW4P5CDXfCpe9b2GzUIsbr
	 7tFBSA4rRYn5wXcf2JELsobQx/2X8Mc+D8+WSPzu9Bs8Q00a3B2tR8sirA9vyiY3io
	 QUT/x7wjtW3cPpzH62WauNIBcd8D9M+NFVf456+pKvg6f4tbJPhVMw4ZxgfxUP5Ddj
	 /RHH65Fq/InlaHFJg1nEvqh01/jn1rTIpifjXAQqI+Ulw+3Hv5U3SiRDn6X0FCwP/E
	 kKZcAxV0+jMVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vidya Sagar <vidyas@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 03/23] PCI: Use preserve_config in place of pci_flags
Date: Sun, 28 Jul 2024 12:04:44 -0400
Message-ID: <20240728160538.2051879-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Vidya Sagar <vidyas@nvidia.com>

[ Upstream commit 7246a4520b4bf1494d7d030166a11b5226f6d508 ]

Use preserve_config in place of checking for PCI_PROBE_ONLY flag to enable
support for "linux,pci-probe-only" on a per host bridge basis.

This also obviates the use of adding PCI_REASSIGN_ALL_BUS flag if
!PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources() takes care
of reassigning the resources that are not already claimed.

Link: https://lore.kernel.org/r/20240508174138.3630283-5-vidyas@nvidia.com
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-host-common.c |  4 ----
 drivers/pci/probe.c                      | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 45b71806182d2..c96b2de163b5a 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5fbabb4e3425f..2ceaad6c312a0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3077,20 +3077,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* If we must preserve the resource configuration, claim now */
+	if (bridge->preserve_config)
+		pci_bus_claim_resources(bus);
+
 	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
-- 
2.43.0


