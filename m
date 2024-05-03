Return-Path: <linux-pci+bounces-7051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9C28BB3E4
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A541F25692
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6D158868;
	Fri,  3 May 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkaadJiX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4plJyvGC"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248F63CF;
	Fri,  3 May 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764209; cv=none; b=u1lIy7K4D0z2ieVKQwwhwY11CGo9mZLY9rYnLYP8TwdrJg1ge/tTKXUBJ9fNweocqOLZJzNhGJpo7h0ZKM7JNIgcMGmKm2ftVAHvM8Bd+tW/zLSN3qTmMjfVUYSeA1dZRBKPX/KFu773BzeBBiSXnxVVCcpw16yDUyjelS/lazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764209; c=relaxed/simple;
	bh=DaxfR4nd3a64EQUQw4NMPaAY0t4XypNnjDLYOANYiX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DahePB4bENspD8oUgYnBcVi53r5p7JSGLRFbNMm9bs3f9j4MOnyetGp4/u8C/7v7dAVd//8kN7CsO4qCN4jE/b+E3JjFYVS6CmtP+Z0hKPXLb7JN7vVUZ9fazwBm5mBfmn0HfLLmPCRBGEmMANeh29dXQDl39b5LiTyJJtVf1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkaadJiX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4plJyvGC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5jIEdIgaqgrxTScZMNamJ/VXpKyySn2wZ02dAazQ0s=;
	b=qkaadJiXro9eyKM9NKF9MwCToGL7taF+8MDW9IJNbl7s9g86wSsxhnNnyaLos85G2f4F03
	XEM9EqPGHsiChm4XX6NMa0TD8G58LDwkZtHqf5pK6P+s8ZzUisN/9GUjdrhpsnMsWqbRyT
	DR5JhUc213j9PF+ww3PpPFwwL4cHTR/Wdo1PkOOI0IQs5dzj1V8WHcuSeK/F8miPsOIEkl
	Op3s6L9RLEBm6lhK4cgT4xnSg5KjDfDFKDK/TSWACphS71lWwbFcoixcDJNjQmwEvCzkJh
	9cftqoFthVUtKV+qhXmuYAqOWnhmh3EhL6wSRmELER5CQlAjsAGj6RInZgfGxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5jIEdIgaqgrxTScZMNamJ/VXpKyySn2wZ02dAazQ0s=;
	b=4plJyvGCzyfpMLlQEcJIOmsoajwdPs9a4JxmXMvg7I0l4o31erdjKmw0/wh6P35kcGlCJ4
	/HIRlHM6JyJx7BDg==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] PCI: shpchp: bail out if pci_hp_add_bridge() fails
Date: Fri,  3 May 2024 21:23:19 +0200
Message-Id: <da60d5a41e8e554ca98d8d9b61e73291495bf820.1714762038.git.namcao@linutronix.de>
In-Reply-To: <cover.1714762038.git.namcao@linutronix.de>
References: <cover.1714762038.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no bus number available for the downstream bus of the
hot-plugged bridge, pci_hp_add_bridge() will fail. The driver proceeds
regardless, and the kernel crashes.

Abort if pci_hp_add_bridge() fails.

Fixes: 7d01f70ac6f4 ("PCI: shpchp: use generic pci_hp_add_bridge()")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/hotplug/shpchp_pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 36db0c3c4ea6..2ac98bdc83d9 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -48,8 +48,13 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	for_each_pci_bridge(dev, parent) {
-		if (PCI_SLOT(dev->devfn) == p_slot->device)
-			pci_hp_add_bridge(dev);
+		if (PCI_SLOT(dev->devfn) == p_slot->device) {
+			if (pci_hp_add_bridge(dev)) {
+				pci_stop_and_remove_bus_device(dev);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-- 
2.39.2


