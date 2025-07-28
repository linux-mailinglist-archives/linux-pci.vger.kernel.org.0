Return-Path: <linux-pci+bounces-33010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F84B1366C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194C77AAC69
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2725743D;
	Mon, 28 Jul 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of7BI/Rk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B052571B6;
	Mon, 28 Jul 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691094; cv=none; b=h1/TVcRSYdMmPjcqRKdTh3vQ64ql+nQ/JNxXqrnty9gcfzfzqiww6ZRvbFVRouf1g6vR7hwmr0vk224LHonH+TdaqFlEXqE8SoSKhZ+Vj88/uBzvQOw5yOjmw2E9XrljDPpt3YC1JTUKa5abmTz+sq8cW4lTQWXz2hh39jYiki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691094; c=relaxed/simple;
	bh=SSBSnIZwzPjnbh6MWdhzmwYgVOcK5tJIU9ImdOnDn3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jvij9V1R46hHLYbgRyw7wl/+1Uk6Ht5XQfZrcNlDXgOcp9PfdkwNww8Flkhoi7TxBDCJTq5x5rsKV259TIyGPEgYczKHl2x84l2lQvDB8eWxIIucfxwzNekiDPqMS+e39p8T+gwIO/JzSYEd8GjSlfKNl2EtJRXkvu2HsIN9fXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of7BI/Rk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C54C4CEF7;
	Mon, 28 Jul 2025 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691093;
	bh=SSBSnIZwzPjnbh6MWdhzmwYgVOcK5tJIU9ImdOnDn3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Of7BI/RkQYaIgLCVa9V/emCUtRYj2XHsWymGSL8JRMrDu9WPihoF/NpokIynJ2JQT
	 NIUAFZ/xHM06qOtXTPIA1Vt8NRkk/Dd8OXqdqsdgslbpJ6epVViRi23mQJ28D4ZLZi
	 /TwYNNMYpHEzHYrn4jQ4uOWEGMgVTphOBqH+ZuTdBkKd+NqZEyXTtxOAv2atAi+jUH
	 GcapBKbUh1acHQEMK7QHkONqa2pigg6Dws91tOZUTDYyxDVXjChL75D1KGsjPtaRIw
	 1iRPn9K0gKdVGLcijgskVwB63crazZv0aEXbunudIhF5dX4Ycxb+ukmkrFYPl5s2or
	 BbzWpUdKJhJbg==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:39 -0700
Subject: [PATCH RFC 09/25] PCI/LUO: Save SR-IOV number of VF
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-9-955b078dd653@kernel.org>
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

During the PCI prepare callback, save the SR-IOV number if the device
is a physical function.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 189827c6111b2c00ebb24404a205cde3f75d33c3..09faba99e9218b443f66060db5142208e22c7dd5 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -21,6 +21,7 @@ static LIST_HEAD(probe_devices);
 struct pci_dev_ser {
 	u32	path;		/* domain + bus + slot + fn */
 	u8	requested;
+	u16	num_vfs;
 	char	driver_name[63];
 	u64	driver_data;	/* driver data */
 };
@@ -153,6 +154,8 @@ static int pci_save_device_state(struct device *dev, struct pci_dev_ser *s)
 	strscpy(s->driver_name, name, sizeof(s->driver_name));
 	s->path = pci_get_device_path(pdev);
 	s->requested = dev->lu.requested;
+	if (pdev->sriov && pdev->is_physfn)
+		s->num_vfs = pdev->sriov->num_VFs;
 	return 0;
 }
 
@@ -381,9 +384,9 @@ static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
 		dev->dev.lu.requested = 1;
 	else
 		dev->dev.lu.depended = 1;
-	pci_info(dev, "liveupdate restore [%s] driver: %s data: [%llx]\n",
+	pci_info(dev, "liveupdate restore [%s] driver: %s data: [%llx] num_vfs: %d\n",
 		 s->requested ? "requested" : "depended",
-		 s->driver_name, s->driver_data);
+		 s->driver_name, s->driver_data, s->num_vfs);
 	list_move_tail(&dev->dev.lu.lu_next, &probe_devices);
 }
 

-- 
2.50.1.487.gc89ff58d15-goog


