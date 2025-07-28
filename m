Return-Path: <linux-pci+bounces-33006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C690DB13663
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA73BAF0A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BB253F1B;
	Mon, 28 Jul 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDySgVrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EC221704;
	Mon, 28 Jul 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691091; cv=none; b=lSs/1oYWGeVB5djK5Jeyck0pgkwGJyS3JM2EW4vNDJjkBwQqXy3mkwJd8LbTyBEX0E/mDA1HlwFDQnPx2+tdFy2gO0KsryEihBL7XEC8Qkf5s/Q/QPxW85ShQr5V2OW2zQ8YWFjZPdisAyhHUv/N+hPshAzYw3RLogMcSINDDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691091; c=relaxed/simple;
	bh=d9HRv7PUvjY03stbX6fDE0y5GmiBxZpYjtU9wtF6fII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SY4RcVYPZjRW/Ho6zOhmpWj5U8wYRKWAQGRVb3zbOIf5KND+iIzuAgRIE4od/+UMoaPt714Mt9zGhclb/ITfdBnzLao3wsOWWaJGxO3zB4eHNwI7drqEGmsjatrHI38WU85uTNaDIn996XpeCNISWj68LGw5HulTsiDqp7y5Hq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDySgVrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA47C4CEF9;
	Mon, 28 Jul 2025 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691091;
	bh=d9HRv7PUvjY03stbX6fDE0y5GmiBxZpYjtU9wtF6fII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eDySgVrJrlOfO/IOg+RLe1vXwr/cjqZeeeqU9LRTiM3NxD9JCOLYa3mGF5W9UBlz4
	 sAr5+HvrbfxmNrwn1EJO7O0/74CkWeD0l0qbwwlTcPrQE9WfEJWODyGzr1mOJPeHXq
	 88lsa11iMtWs5ZYKPfVDkj5sa9lQV2rmj4F13oLrddjzsOIKL3osRJqE5DL7qj6pEP
	 cufg2WXWM9xb1A4jY8bBiImDaQ2I6p0z7yApjsrrFRVr+6wd4UfqWEQJhiewDbP4Yv
	 +rjitiD6qcS4lHYujSC58InAYC78F7B8gQDFXF8LDQN9tMuPG+DjcaxN9QNuhvOm/A
	 bbzCK02bIer/Q==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:36 -0700
Subject: [PATCH RFC 06/25] PCI/LUO: Forward finish callbacks to drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-6-955b078dd653@kernel.org>
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

When PCI receives the LUO finish callback. The PCI subsystem forwards the
finish callback to the driver with restored dev->lu.dev_state->data.

Tested: In qemu, request a virtio net device as requested.
	Perform luo prepare then kexec. Verify the new kernel boot up
	dmesg shows the requested device has per device live update state
	restored. Perform liveupdate finish and see the device finish
	callback gets invoked.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 4d13071f5edd6520adb64003262f08d1f79e26c4..6b85673f4ec20add7e49b04dc44f1bcd868adbdc 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -268,6 +268,29 @@ static int pci_call_freeze(struct pci_ser *pci_state, struct list_head *devlist)
 	return 0;
 }
 
+static void pci_call_finish(struct list_head *devlist)
+{
+	struct device *dev;
+
+	pci_lock_rescan_remove();
+	down_write(&pci_bus_sem);
+
+	list_for_each_entry(dev, devlist, lu.lu_next) {
+		struct pci_dev_ser *s = dev->lu.dev_state;
+
+		if (!dev->driver)
+			panic("PCI luo finish: dev %s does not have driver", dev_name(dev));
+		if (!dev->driver->lu)
+			panic("PCI luo finish: dev %s does not support liveupdate",
+			      dev_name(dev));
+		if (!dev->driver->lu->finish)
+			continue;
+		dev->driver->lu->finish(dev, s->driver_data);
+	}
+	up_write(&pci_bus_sem);
+	pci_unlock_rescan_remove();
+}
+
 static int pci_liveupdate_freeze(void *arg, u64 *data)
 {
 	struct pci_ser *pci_state = phys_to_virt(*data);
@@ -301,7 +324,12 @@ static void pci_liveupdate_cancel(void *arg, u64 data)
 
 static void pci_liveupdate_finish(void *arg, u64 data)
 {
+	struct pci_ser *pci_state = phys_to_virt(data);
+
 	pr_info("finish data[%llx]\n", data);
+	pci_call_finish(&probe_devices);
+	cleanup_liveupdate_devices(&probe_devices);
+	cleanup_liveupdate_state(pci_state);
 }
 
 struct liveupdate_subsystem pci_liveupdate_ops = {

-- 
2.50.1.487.gc89ff58d15-goog


