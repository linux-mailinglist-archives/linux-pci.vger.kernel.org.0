Return-Path: <linux-pci+bounces-33013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10325B13676
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245AF17981D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A425B311;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqxJCwnw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17825B1E0;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691096; cv=none; b=V5p1E9bKWKQXf3n8VMVbgllKU+Bpm3CzzdOZX/jw6xcdS4V2rxJ12chHnH+CbrtnZA4m04k6hy0KQ0JJj0oZXOANY3YDhSfDtYk7GfWZzyFu7HUfPpnJFqheGm7wBLmVfMFEDlthyZ8hH05ydOmguu076C7rDKzns+AMT5LIGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691096; c=relaxed/simple;
	bh=QcznKEuszye5dtHBV31dISysk6MANWZ4HW7p32rLwHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoA26RnXgOlg/MHR4G1wDdP1gxgoQ8pnRhl9SwvODRmPI9ei62FvqtPahxxfjjRUt0g40PJiH3YrlPltA8RLs1tTd6nSiQ89TE6Fh/nOewhwFYX2OhORlbZPI3lVpjEcikvAuyX6xeHkZrhMDMxrnZajaY4KadKEyqVLkb2tQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqxJCwnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8AFC4CEE7;
	Mon, 28 Jul 2025 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691096;
	bh=QcznKEuszye5dtHBV31dISysk6MANWZ4HW7p32rLwHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZqxJCwnwJUY279kA8YTDm6LWaHcSToHBvaWJMS+C1bqK0Hligu9ydLD5XJ1hEePfV
	 32WO9WiV92M2ZIyN/5kLS4ZeF6EGqvxqP2XzgNFywdiQikjfRGoS3aimADNQd1h76y
	 XI63NBPTKXCcw94tFr7RdcFNACh7OFck4/E//zVQISMtIUJ7gyEn30VewikS9Cscos
	 9xP9yzlS7cPXj0c3Y4LWjJrd3MezqV17JStnlCP6zLJHfCG3yzVS8XAElMYpVnMF6P
	 KxLB05ZUp2hYjCxcgGyYJAuHJtFSN2Sgp88hjCdiGsTJd9NUtj2uoh87XZx+Ybox8j
	 +Exj7kMpyjjtg==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:43 -0700
Subject: [PATCH RFC 13/25] PCI/LUO: Check the device function numbers in
 restoration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-13-955b078dd653@kernel.org>
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

From: Jason Miu <jasonmiu@google.com>

After liveupdate reboot, the device BDF shouldn't be changed from the
previous kernel. If this happens, the saved LUO device state cannot be
used, and panic the kernel.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6b1c14d70fd16b0919ca22faae788069f3743708..ec2d7917441ceb4e3d7cd8becae41ca215cba7c3 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -393,6 +393,15 @@ static void pci_dev_do_restore(struct pci_dev *dev, struct pci_dev_ser *s)
 	pci_info(dev, "liveupdate restore [%s] driver: %s data: [%llx] num_vfs: %d\n",
 		 s->requested ? "requested" : "depended",
 		 s->driver_name, s->driver_data, s->num_vfs);
+
+	/*
+	 * The devfn got changed since reboot. We cannot restore device
+	 * info preserved by liveupdate
+	 */
+	if (s->devfn != dev->devfn)
+		panic("%s: Device and function numbers are changed from 0x%40x to 0x%40x\n",
+		      __func__, s->devfn, dev->devfn);
+
 	list_move_tail(&dev->dev.lu.lu_next, &probe_devices);
 }
 

-- 
2.50.1.487.gc89ff58d15-goog


