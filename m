Return-Path: <linux-pci+bounces-10911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E525E93E859
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229871C20AC9
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBE18E74D;
	Sun, 28 Jul 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAiGEkeo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0418E746;
	Sun, 28 Jul 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183004; cv=none; b=W1vmN94DoSAc1KZJAUUtiCkxwb5Gs26gfaKaOUYhEyF/TSdqNc1U+PDWQkOp/HuBMcRjQeKAsQnQJrr7TO4hiAjWTC34nHiMLr80OKlID8DCUBqD2gKRPM3fw8cifUmpJoMiNcyYa/kOIHLYx9f4qwOts6pCaAjj7BcXCwNYRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183004; c=relaxed/simple;
	bh=tMvgnZby+dAE+pK25M1ZIY1oQJT7T/0HB2onJQ+C2eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0G+rzU2/J+iQSEFna1VP0bOTmaVmunPbCAbrH7sQJmzFiBb80TDFqWXwYxrBU70Onmvf6MsR8MaXxC5Up3LI/HyN2Er13XJ040efLK5KedxzDkfJlznrzNg8737hBh80IFYJIvgNNJB3o3IF1EPVuDy4KNxy/64SJ1VhUZVpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAiGEkeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A67C116B1;
	Sun, 28 Jul 2024 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183003;
	bh=tMvgnZby+dAE+pK25M1ZIY1oQJT7T/0HB2onJQ+C2eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAiGEkeozj/g9FRaOzmRmUfH91rB8VZIeGCYYpmmt8Yv481YZ3y9K0JcJbtPtQAH6
	 NBpIPmPWTY8NfYo+t2nsaBgl5LaPo4wmlnlb/d5cf36qG6FeG6LARJgq1PyoXLdpDK
	 aiWeEuPajjf9IDUI+7SDbQ28Y+5W/8D+76NwfYxmCjihbSz8GKXiHsZopf5KrR9gmo
	 BfY351eBJeN25KsVDSZFc2tKsiSC9LWZapenm4Vmto27KnnjbhY6QQheFXFsB5Vor0
	 bNv5qMLfC/wXOygTpQj250T53/3d4K7C2YGicSxVA2zY/inNuvuXuS6Mpy87XzQFkH
	 DeUnlZuSD0aXQ==
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
Subject: [PATCH AUTOSEL 5.10 03/11] PCI: Use preserve_config in place of pci_flags
Date: Sun, 28 Jul 2024 12:09:36 -0400
Message-ID: <20240728160954.2054068-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 6ce34a1deecb2..2525bd0432616 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -71,10 +71,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 02a75f3b59208..b0ac721e047db 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3018,20 +3018,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
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


