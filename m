Return-Path: <linux-pci+bounces-32026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F3B031B0
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321E4189DCC8
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFF149DF0;
	Sun, 13 Jul 2025 15:11:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C85219E8C
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419518; cv=none; b=aTM5g8QZDC6h2UJQUtd/m7g5lZR0As9rRUwquI74GKQDcTj6mBC82+QpdqKfDhbCTicTOzytPFdscP2wNs4OhngcJPE1Ak+jdJCl9gd9qu35gNM7JK7OeW567PqOqzC+1JrUnL4oitFxMCWR0d03aYXpDV/rqWpAPHktS5VgIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419518; c=relaxed/simple;
	bh=zu4mNjXPAJTbRKRx+S8x3l6DguqC1wF0St6VS2PYzm0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=tWu9J4ftLdGUAfhxKYBQhaT5x+mLXzyA72GaTOKc9kq3Si3R/Fi8hopS4u8CYufw7l+S9Xc+AgxATelnoZmYnLLDq2OiEgHW6/fNPmIGeDwRVL21qicINcyWqNbsNZ4HVXzZn6EAA6b3D6jxQhPqeyhyHDthd0T9YVJVCJ8Z210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id 28BD318D0D;
	Sun, 13 Jul 2025 17:02:26 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id F018961C4D81;
	Sun, 13 Jul 2025 17:02:25 +0200 (CEST)
X-Mailbox-Line: From 59a097376a2bb493da9efd66fb196ae4b66f8a09 Mon Sep 17 00:00:00 2001
Message-ID: <59a097376a2bb493da9efd66fb196ae4b66f8a09.1752390102.git.lukas@wunner.de>
In-Reply-To: <cover.1752390101.git.lukas@wunner.de>
References: <cover.1752390101.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 13 Jul 2025 16:31:03 +0200
Subject: [PATCH v2 3/5] PCI: pciehp: Use is_pciehp instead of
 is_hotplug_bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCIe hotplug driver calculates the depth of a nested hotplug port by
looking at the is_hotplug_bridge flag.  The depth is used as lockdep class
to tell hotplug ports apart.

The is_hotplug_bridge flag encompasses ACPI slots handled by the ACPI
hotplug driver, hence the calculated depth may be too high.  Avoid by
checking the is_pciehp flag instead.

This glitch likely has no user-visible impact:  ACPI slots typically only
exist at the Root Port level, not in nested hotplug hierarchies.  Also,
CONFIG_LOCKDEP is usually only used by developers.  So this is just for
the sake of correctness.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ebd342bda235..d783da1dbd24 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -995,7 +995,7 @@ static inline int pcie_hotplug_depth(struct pci_dev *dev)
 
 	while (bus->parent) {
 		bus = bus->parent;
-		if (bus->self && bus->self->is_hotplug_bridge)
+		if (bus->self && bus->self->is_pciehp)
 			depth++;
 	}
 
-- 
2.47.2


