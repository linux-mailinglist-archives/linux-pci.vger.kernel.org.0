Return-Path: <linux-pci+bounces-10905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF0D93E82D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BEB1F214FF
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3770186E24;
	Sun, 28 Jul 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Jj3JV4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78817F4EC;
	Sun, 28 Jul 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182952; cv=none; b=cqNTWqj8FjAUvOUxBQeLfyeqA4i1TExOIJTSF1iQGxbwjuNXgKJmNchve8utPhJ4Do2dOCq0ckgGyC1nSp554t8pI0oG0Sd+ULCu46W7c66/5AU5SupnW7y3G69l+AADxMhh3APp89j5uH0Jkcf9pQNdtVs+FC33gJcGRYJS9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182952; c=relaxed/simple;
	bh=nGUkjWuEh5Nm85GRfEKd8zuBcts9TsNejCHTp9ln6S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqjPUCH7reZYooB8VJTqKXTP1sdoCX7Yuk+5mWGsJr+udH+CWNWbuh38Ev35MbqpsLmQL4VvvvPD9/aOvvAXAzQ1DZMmWJ8PVxqfasv5QCYmUcmBdOkxVYZH41kyPA/C5bjSV+5dYR6mwwhmy3mZeVOfaQmfrikMKFkJ/fw2fTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Jj3JV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E3DC4AF14;
	Sun, 28 Jul 2024 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182952;
	bh=nGUkjWuEh5Nm85GRfEKd8zuBcts9TsNejCHTp9ln6S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+Jj3JV4F5BCXO+W1C9sn9YAp5hVOt+1donRYqJ25ENoAwaAttnfkXCdLB6INC/EN
	 05+VSpmJf6VEwm9xSA67pGx0FiNEmPf8okq6InW3RKgQ4srKIhCrJMqRQDyHgRaJIf
	 3igJWMzDEX3QjkcaNj0nm7L1NlNILWO94dWaN74AeWmdqX0YB9gHsv4i/QIOpXpQyz
	 tcZwEH3n1HUDBr+G4jrPaxZdoO57Z8y2ol/dm9lCEekXfp2Luw+IYEk4pJDbN3iLwn
	 tIelpGLI+s1JwTlXr6bi1XmbZ0vf/bvZ/3AP6FI/I/K9AyZUvEv2Nh1X/G90CgPWoA
	 C+ELEoXMe9h9w==
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
Subject: [PATCH AUTOSEL 5.15 02/13] PCI: Use preserve_config in place of pci_flags
Date: Sun, 28 Jul 2024 12:08:44 -0400
Message-ID: <20240728160907.2053634-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160907.2053634-1-sashal@kernel.org>
References: <20240728160907.2053634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index d3924a44db02f..fd3020a399cf9 100644
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
index d9fc02a71baad..0052d3c83e4a4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3032,20 +3032,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
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


