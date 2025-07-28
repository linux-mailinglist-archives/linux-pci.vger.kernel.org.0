Return-Path: <linux-pci+bounces-33018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADAB13687
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070C71647FE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE3262FD1;
	Mon, 28 Jul 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTlK3blO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C47262FC5;
	Mon, 28 Jul 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691099; cv=none; b=ZfhVl4bJ6Wdth9aFHeT7Jiu0cYlK/pDRs2O/anUZMiKE5laxrtElOA3j/lmQXWHYu9Z0gqxUOJwl5Zu4p8YmOsfPCWf0Ux9sqn1DDi0ulbwHxd8ueCLpTUSXaEs0femmoPf4SbQ8R46Uu9ibtawjlYOgivv6Nz2kmTdppdYm5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691099; c=relaxed/simple;
	bh=+nVQSt29qRaiE2vOTxUXEh0dQ0wcmiDUnQlsU5hBKZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFtlwnSbXVD/lboZovSJ4npoWYGpJI2SCyom4VhYqAzbOD7VHKRdAikqM5vz/KPUNHGLK8WkX+KlDID7/sQJMoSZK8pJtuRgdi4QIwmvb2Ysd4pImrjj8+ZNSICKPMZ/qRl69gAqF8x8srIAYmYcGpuQfUnIdFXJaGM/jPovbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTlK3blO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2504C4CEF7;
	Mon, 28 Jul 2025 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691099;
	bh=+nVQSt29qRaiE2vOTxUXEh0dQ0wcmiDUnQlsU5hBKZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GTlK3blOKnK+Q1VyGzIXv3UQNSpkRhDLaWigCNBWBd+sfn5ACT1z35OLxZnOJJ8AV
	 vlSwN0kgpUPDtKkCqs61FfuFbasSJMIzdPD7NuXRho7ulp+hE70qeKhUuDdFxWf331
	 x/WlNt9ycdXioMdrnllghMpcQH/T3OxEbT1+oILaGJxe8tpjiSWXKnLQUoHLuBuzZJ
	 DqskcG5VZmdJfOWb4NlmIVQaZBwamH7l/DxcReY9QEjL/spptKgMOq+nhJWsArYkar
	 WJgmGHDK2FTdzP4JKyqS2mZJ8jk22w+LaGYeXFv0u23xpcFtrGN+GYOe76qKnUnZGW
	 Y6e+iE0lklqKQ==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:48 -0700
Subject: [PATCH RFC 18/25] PCI/LUO: Restore pci_dev fields during probe
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-18-955b078dd653@kernel.org>
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

- pci_intx_mask_broken flag:
This is a flag showing the PCI_COMMAND_INTX_DISABLE writability. Some
devices PCI_COMMAND_INTX_DISABLE register is not writable, and this
flag is used to report this capability. This flag is also updated in
the driver/pci/quirks.c for fixing some devices, but those flags are
static as the checking and udpating are being done for each device
model, so we only restore the flag value from liveupdate in the PCI
device setup.

- pref_window and pref_64_window flags:
Restore the pref_window and pref_64_window flags for a bridge
device. These flags are managed by the function
`pci_read_bridge_windows()` during the PCI device setup. Since we
cannot write the PCI_PREF memory after a liveupdate reboot, so we
restore the saved state from liveupdate.

It is expected the following patches will skip the bridge device Pref
window test in a liveupdate boot.

- hotplug_user_indicators flags:
Restore the hotplug_user_indicators flag for a PCI device. This flag
is for managing platform-specific indicators, so during setting up the
PCI device, restore this information from the Liveupdate.

For the flag usage, see more in 576243b3f9ea.

- ignore_hotplug flag:
The flag ignore_hotplug is managed by the function
`pci_ignore_hotplug()`, which is used by PCI drivers during a suspend
operation. We restore this flag when a PCI device is setting up, to
preserve the device state.

Tested: QEMU VM boot test

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/probe.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7dd2cf9f9e110636f8998df22a333638cce25e6b..d8b80e1c4fb35289208d7c953fb5c1e137a5c1a8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2059,7 +2059,24 @@ int pci_setup_device(struct pci_dev *dev)
 		}
 	}
 
-	dev->broken_intx_masking = pci_intx_mask_broken(dev);
+	/*
+	 * Restore PCI device fields:
+	 * - Broken INTx masking and can't be used
+	 * - Ignore hotplug events
+	 * - Have the SlotCtl indicators controlled exclusively by user sysfs
+	 * - Pref mem window availiblity of a bridge device
+	 * - Pref mem window is 64-bit
+	 */
+	dev->broken_intx_masking = PCI_SER_GET(dev, broken_intx_masking,
+					       pci_intx_mask_broken(dev));
+	dev->ignore_hotplug = PCI_SER_GET(dev, ignore_hotplug,
+					  dev->ignore_hotplug);
+	dev->hotplug_user_indicators = PCI_SER_GET(dev, hotplug_user_indicators,
+						   dev->hotplug_user_indicators);
+	dev->pref_window = PCI_SER_GET(dev, pref_window,
+				       dev->pref_window);
+	dev->pref_64_window = PCI_SER_GET(dev, pref_64_window,
+					  dev->pref_64_window);
 
 	switch (dev->hdr_type) {		    /* header type */
 	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */

-- 
2.50.1.487.gc89ff58d15-goog


