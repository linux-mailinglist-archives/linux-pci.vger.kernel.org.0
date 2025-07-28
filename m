Return-Path: <linux-pci+bounces-33015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FD3B1367B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A309189A24E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C425CC7A;
	Mon, 28 Jul 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEtkOZ2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792792571B6;
	Mon, 28 Jul 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691097; cv=none; b=hdj8ILzf3eQMuZWQdySNO0tbpp3Wnr8Vi5bdPPLKQXNH2QPATujsRtaM1dLrNNZRvhpz/co/fbSC5cgTXdpPmshOtANPcvNgxa8QYVC4xVwi/F9PRPfX2SrfEdBLGHh5ZsWXVCxcJ3Clb8IlMG6YdrZhJHSkqeRJj8i8BYJgJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691097; c=relaxed/simple;
	bh=G2koSOZg+2R0yt5dOjcepoL7O+CiOzL6QTB1hbD4l0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8pwWrxM42UHs95qzKVGMegACQxhb4ocllhilllFrSoej0C9pPM5Fomw8mNzJMT4zsZ6Uz9G1O7VGeVSS2ahRsHWpbMXR5Q2NKZOkneGu2mPP9gkt9TQ+D1DPCatHLkHQbswnuu+MP1xbI1HpQAgBnYP1jKbxxBl+EDiisg2KZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEtkOZ2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72B3C4CEE7;
	Mon, 28 Jul 2025 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691097;
	bh=G2koSOZg+2R0yt5dOjcepoL7O+CiOzL6QTB1hbD4l0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OEtkOZ2FwFBhE3FpI3rixW89UsRw6p/YPMu8EmS3ux/8imDcLPkJgIKYx7mCGCGn5
	 eXv+SHV2Ek+6CNsOG6K3PPrWX1q7iWyl4vMDAHHmoLnefcBdXEf4Fi3mLmRyDn3g8s
	 lYYb/WxjMttg+LtZMPkiiQuYdaW3mkqkvXlXybpHWWed3NMQNGedMkPv8Xz3fnv6ZY
	 DBurotQZGbMZTEhTawD8IN7wQvWA/DkKcwRCX+pLYnnUOKR843bF7Yp5OkBahB8Tvp
	 inR1dnuy2e39lcYSGWJIVMob3YcBRmBDdJpHLa78iSmQId6UsaRp+vcPW/ATebNn1C
	 Bfu8UJUVMTTww==
From: chrisl@kernel.org
Date: Mon, 28 Jul 2025 01:24:45 -0700
Subject: [PATCH RFC 15/25] PCI/LUO: Restore PM related fields
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-15-955b078dd653@kernel.org>
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

- pm_cap
Restore the liveupdate saved `pm_cap` during the PCI Power Management
initialization.

- skip_bus_pm flag:
The flag skip_bus_pm is used in the PM suspend and resume
operations. Therefore we restore this flag for the device in the PM
init before all the operations.

- wakeup_prepared flag:
Restores the wakeup_prepared flag during the PM initialization.

Tested: QEMU VM boot test.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb108920995ebe34bd2535a0e23fef7fd..e0e730f7bb3932567815c390088088bd5c56f11e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3209,13 +3209,14 @@ void pci_pm_init(struct pci_dev *dev)
 	u16 pmc;
 
 	device_enable_async_suspend(&dev->dev);
-	dev->wakeup_prepared = false;
 
 	dev->pm_cap = 0;
 	dev->pme_support = 0;
 
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	/* Restore PM related fields after live update or find PM capability */
+	pm = PCI_SER_GET(dev, pm_cap, pci_find_capability(dev, PCI_CAP_ID_PM));
+	dev->wakeup_prepared = PCI_SER_GET(dev, wakeup_prepared, false);
+	dev->skip_bus_pm = PCI_SER_GET(dev, skip_bus_pm, dev->skip_bus_pm);
 	if (!pm)
 		goto poweron;
 	/* Check device's ability to generate PME# */

-- 
2.50.1.487.gc89ff58d15-goog


