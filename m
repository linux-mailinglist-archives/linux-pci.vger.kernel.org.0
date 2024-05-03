Return-Path: <linux-pci+bounces-7054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED768BB3ED
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D284B2460D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4591158D70;
	Fri,  3 May 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeDOZAmj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPxKixfJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DC158207;
	Fri,  3 May 2024 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764210; cv=none; b=frS5MJtPpP8ZnZlZxq80rwRJzm/9kwpPWksju4S3oM+hJ8GS2KC21AiImekUbq6ItejYMDEGOAa0TAUEnjKqqFFfTeCBsRI6dO/4DmphJgm9FWhEV9BpIOZ2Ll7cS1XVVQijwN6zjp36fv/foMQC5vXwDZj6Ua52zPWAqp5CXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764210; c=relaxed/simple;
	bh=EZgwArsC5As5LlGORe/CHEXCKSnJoGIS819EFQm9qjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9FwWkg2woVLE2gN8q7lnur/HjPyYvv97piG4AQ7rXRrUrtvL2LwSYw2J7DYd/qQPOjRuOPrOKyID0DZ+maTjjP544xw4h4WaL24iA46TMi7rXR2hyL63a5FU/IfP/ADV+/dYYMOqs3+XjgJA6j0bKJmK8LvPKxSXXErkFba8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NeDOZAmj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPxKixfJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufiKfNBkmRVUEcnLSYPA5RmeUW8wkmfMWjVab0qBmPM=;
	b=NeDOZAmjfeRDGVvGyg9BDMfEfamyyjqV+zIhaM7Dsd3ikXfinsEwSy/MKbLgEZUokEnOd1
	LLm7pxP+TNLZhY9S2GdZgQzo8VDYDxFyJU61aFKVLr62+hDgVdYy0iJI6scgR5c24P1vme
	3QXTY9G87RJfIleHy92yF0E6ZgVEnP1p9ST2sUN4VoPMh88DIFvKZMc1ID2D+eG1jGznYW
	NcpxWwAnS71sOByS+gGKP9BAGBne+ZbhqMjfetHmT09P6tHfUtoVsmukkd/Ju3vHFIy8f9
	WmEwxfsEHkpaoD2FQvc1xVJWyY3hdGXhSa295By83UIni37ZoS89AHdL3Zhi8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714764207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufiKfNBkmRVUEcnLSYPA5RmeUW8wkmfMWjVab0qBmPM=;
	b=VPxKixfJXauOKep5gVzWa3vFvxUpna+EBpNuFRfMz3J5UEJOk2Z85ZuzT69wyJ3yPd5J+q
	bmqbgveUUtNq8wBw==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Date: Fri,  3 May 2024 21:23:20 +0200
Message-Id: <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
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

Fixes: 0eb3bcfd088e ("[PATCH] pciehp: allow bridged card hotplug")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Rajesh Shah <rajesh.shah@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/hotplug/pciehp_pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..faf4fcf2fbdf 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -58,8 +58,13 @@ int pciehp_configure_device(struct controller *ctrl)
 		goto out;
 	}
 
-	for_each_pci_bridge(dev, parent)
-		pci_hp_add_bridge(dev);
+	for_each_pci_bridge(dev, parent) {
+		if (pci_hp_add_bridge(dev)) {
+			pci_stop_and_remove_bus_device(dev);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
-- 
2.39.2


