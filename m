Return-Path: <linux-pci+bounces-7201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0FF8BEEE3
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544C21C2216D
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216773539;
	Tue,  7 May 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwtIJR2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974978B60
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117495; cv=none; b=DZmidrE+GzKgPibjm39FUoGZJ4HHS27oV0uh8/JdHcNcWqaxhtLGxxyPDMpW/wHxhn5iCC0rtOjFrt7LoMoynVZkQdcRPdzZHjQA+JObfyUngxtdpYf0HJq1HPZCtwZFZ1gp2QrzJt0KklfSYmsGMm7uip73m0sw5zLLEP72jVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117495; c=relaxed/simple;
	bh=sjrdv1XLidMo+wpAqC8GpU0xTWm4LYLBAYG/j+0Lyqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGnzRunV95JVS2VudK+s9VQulsWxa356QXyY6q+xTzvzv8+uc9K9XqIN2E6oamyH/0+jwufLE5SaT28VBnMBHKo/rTmtdd1BXGlr36BnNzAv4X2gnSfFZgsA8uwkrkcykdgFlT8q41tPlp0MeqRBgYcu6a9J+3kYzkRBcbGBtbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwtIJR2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715117491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YA5B7MO1zxdrqYf+1AOVcXTM57uu9eZh4pf9l6wIlOs=;
	b=gwtIJR2duak1jA4yTIbowad9jnO7BBuKvcy1eTX3NJd7dRdM2O6ynt3+wGWY48f/GBkoCI
	DwVvvEkC7Lhk9qSBmq5eYDDmtBbhM9rT+G4Y1m08kjtiLWGDz6iJw5eEkz0hug3fp0zEX8
	wfsq6n+Oj3aOQFa+r08ZCDM8R4FCZYw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-oPz8aqjNPl2zeVHSK8TJKQ-1; Tue,
 07 May 2024 17:31:29 -0400
X-MC-Unique: oPz8aqjNPl2zeVHSK8TJKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39CE11C00049;
	Tue,  7 May 2024 21:31:28 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.32.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 959E6492CAB;
	Tue,  7 May 2024 21:31:27 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	geoff@hostfission.com
Subject: [PATCH] PCI: Release unused bridge resources during resize
Date: Tue,  7 May 2024 15:31:23 -0600
Message-ID: <20240507213125.804474-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Resizing BARs can be blocked when a device in the bridge hierarchy
itself consumes resources from the resized range.  This scenario is
common with Intel Arc DG2 GPUs where the following is a typical
topology:

 +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
                                             \-04.0-[61]----00.0  Intel Corporation DG2 Audio Controller

Here the system BIOS has provided a large 64bit, prefetchable window:

pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window]

But only a small portion is programmed into the root port aperture:

pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]

The upstream port then provides the following aperture:

pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]

With the missing range found to be consumed by the switch port itself:

pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]

The downstream port above the GPU provides the same aperture as upstream:

pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]

Which is entirely consumed by the GPU:

pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]

In summary, iomem reports the following:

b000000000-bfffffffff : PCI Bus 0000:5d
  bfe0000000-bff07fffff : PCI Bus 0000:5e
    bfe0000000-bfefffffff : PCI Bus 0000:5f
      bfe0000000-bfefffffff : PCI Bus 0000:60
        bfe0000000-bfefffffff : 0000:60:00.0
    bff0000000-bff07fffff : 0000:5e:00.0

The GPU at 0000:60:00.0 supports a Resizable BAR:

	Capabilities: [420 v1] Physical Resizable BAR
		BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB

However when attempting a resize we get -ENOSPC:

pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
pcieport 0000:5f:01.0: PCI bridge to [bus 60]
pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: assigned

In this example we need to resize all the way up to the root port
aperture, but we refuse to change the root port aperture while resources
are allocated for the upstream port BAR.

The solution proposed here builds on the idea in commit 91fa127794ac
("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR can
be resized while there is no driver attached.  In this case, when there
is no driver bound to the upstream switch port we'll release resources
of the bridge which match the reallocation.  Therefore we can achieve
the below successful resize operation by unbinding 0000:5e:00.0 from the
pcieport driver before invoking the resource2_resize interface on the
GPU at 0000:60:00.0.

pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: releasing
pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]: releasing
pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]: assigned
pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: assigned
pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]
pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
pcieport 0000:5f:01.0: PCI bridge to [bus 60]
pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/setup-bus.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 909e6a7c3cc3..15fc8e4e84c9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
+static void pci_release_resource_type(struct pci_dev *pdev, unsigned long type)
+{
+	int i;
+
+	if (!device_trylock(&pdev->dev))
+		return;
+
+	if (pdev->dev.driver)
+		goto unlock;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (pci_resource_len(pdev, i) &&
+		    !((pci_resource_flags(pdev, i) ^ type) & PCI_RES_TYPE_MASK))
+			pci_release_resource(pdev, i);
+	}
+
+unlock:
+	device_unlock(&pdev->dev);
+}
+
 int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 {
 	struct pci_dev_resource *dev_res;
@@ -2260,8 +2280,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 
 			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
 
-			if (res->parent)
+			if (res->parent) {
 				release_resource(res);
+				pci_release_resource_type(bridge, type);
+			}
 			res->start = 0;
 			res->end = 0;
 			break;
-- 
2.44.0


