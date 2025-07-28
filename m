Return-Path: <linux-pci+bounces-33016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796EB1367F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9741795F6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900625E814;
	Mon, 28 Jul 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG7bzTNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F80F25DB1C;
	Mon, 28 Jul 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691098; cv=none; b=aCfCcQxOPci1Yx6KtS8zk1Rp0obUhJBN1mMLOK4GIEKULAQ7ZmbG5v1LxbZufQFcDMwW5pKhY/pPVKIbxGcGI4mbU5UWvQO1s1jvSqMRhhI1Ik0uLTTgXIQxLIy2DS75tHHPhUwQJg+jmVjoqZgfSzl8G17Uvgu44ZEjGRD3wcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691098; c=relaxed/simple;
	bh=5C9Pr2eXeTa+JJsCGkVhE97Ue0QvTrQypy6NAqhUBow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhuUNE4QFsGKSpLCkAzDilaCCaHNVlbGiNzA8Y5qC3WQCy2kcHYwILSId2VEiMeprjiRLz5NeSCCztOcHEPTbu19b6E4UXT7yaHkh0RkedDOcb20fOh0RfdGZ/B0dRoFs1dHsxLX3t43+GD1x5oD7sGtIUKW4a4uUQYsLtIqhyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG7bzTNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E85C4CEF8;
	Mon, 28 Jul 2025 08:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691098;
	bh=5C9Pr2eXeTa+JJsCGkVhE97Ue0QvTrQypy6NAqhUBow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sG7bzTNIWDrzalHZWBXzEuko67k3yvGI5OSZxkemHiMszIgNdlh9ylOBy+US81QZA
	 kLXBYz0HXG+3LE6BhSUnLyHlKs9euhblf0bY9SFMOhkmDDx31O0Llur8dFd1xSjMYw
	 Zch/F3LAUScFGya7LQvZYF9o0LBa/tQ27kH5RDKwVBt07Z4QwdsrXIGmYPCpPx6sPq
	 AumBAPqLMR9wJD4Qzw807GmAvGx1bYMYuS4s1xXzzcNxSy3NdJii7ukkYpqNUrI0S+
	 +lI1c5rJzIx6TQWkLmFJjHKAQbeWi6laNCnjdv2qvtm+ZhndpDhDpq3Bs2OJohR7Ck
	 Nt1m+8pSidf7A==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:46 -0700
Subject: [PATCH RFC 16/25] PCI/LUO: Restore the pme_poll flag
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-16-955b078dd653@kernel.org>
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

Restore the pci_dev pme_poll flag from liveupdate. If the restored
flag is false, the device is in an active state (was not being PME
polled before liveupdate reboot), we do not touch the PCI PME register
of the device.

Tested: QEMU VM liveupdate reboot, put liveupdate in to finish phase.
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e0e730f7bb3932567815c390088088bd5c56f11e..46fb80dbca590c251fcad3bf2f011a16f6898810 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3263,8 +3263,17 @@ void pci_pm_init(struct pci_dev *dev)
 		 * let the user space enable it to wake up the system as needed.
 		 */
 		device_set_wakeup_capable(&dev->dev, true);
-		/* Disable the PME# generation functionality */
-		pci_pme_active(dev, false);
+
+		dev->pme_poll = PCI_SER_GET(dev, pme_poll, true);
+		/*
+		 * If the restored pme_poll is false, do not
+		 * set disable to pci_pme_active(), as the device should be in
+		 * an active state, we do not update the device's
+		 * PCI_PM_CTRL_PME_ENABLE flag and disable the PME# generation
+		 * functionality
+		 */
+		if (dev->pme_poll)
+			pci_pme_active(dev, false);
 	}
 
 	pci_read_config_word(dev, PCI_STATUS, &status);

-- 
2.50.1.487.gc89ff58d15-goog


