Return-Path: <linux-pci+bounces-6089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F98A0300
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 00:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075DE1C21FB8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC033184124;
	Wed, 10 Apr 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izJui+a1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C61836E1;
	Wed, 10 Apr 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787196; cv=none; b=dfpeulsTlWsSfFTLW2YD9TriRAEk4Ft5X5lp+GBcW+txC3uHo4tu6vs6lHA2Lpb4t508ssfklywzzr+hmmNKjFGVQaC4+wmSMCXPYyrkBX/trmu/Xr8/angjHbU1c1mqdq+iVsqY7RLxnTlzCO8MMVJQ85crl3imsvzTKIcElcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787196; c=relaxed/simple;
	bh=Inuh6SOkAe0B9b/6nZWABzBrQQ5cUMbAkvImeBVXvkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLfRTra8yZJl4pTkJfMbGTT1rgk1kgpNC3Y6XyYYFvizgoPP/WfT1ZbktTXZxprJLNLrqJ1p3FI7BxbJ3eiRZWBzg8FG5VqUGA90Ki39dFDctvUBTvuIhgFYmH4Jjs9EQUaE2VbleJxuXo8pfGA35NRGhzSq+1tFynB1rj35dyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izJui+a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71D1C43390;
	Wed, 10 Apr 2024 22:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712787196;
	bh=Inuh6SOkAe0B9b/6nZWABzBrQQ5cUMbAkvImeBVXvkc=;
	h=From:To:Cc:Subject:Date:From;
	b=izJui+a1FZNcj3JX3qX81uQKuuQi/gdSgKz+MNJ5lLOwYdu0aMZkC+qZ9piftsVei
	 Yq8tEpuko2dYmvjLefzWOWD//NmKG+YX2CDglgO0RFZCAM2slNotM9G0t+WVtCZMfL
	 knHdprhEmJ9kMnqLrC8HYJgOQfyVzrF4/2AEca+vIaXB5CP+Kv6El2ZjBeZjWJrbuw
	 R8PKt6rwZJdPSAQG0D9SVG7eiLgPEDC4OABbaxaS889oXNHzh5HFuQhjnQjJML3vW4
	 rHGQ9BtPnd+dSFHn9bHcTuTnv4IrV8ij9TGC6HLZXW5gBwB9wyhu1o60sJJTHnnbPH
	 rBlD2ZBx3B3UA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Megha Dey <megha.dey@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/7] PCI/MSI: Remove IMS (Interrupt Message Store) support for now
Date: Wed, 10 Apr 2024 17:13:00 -0500
Message-Id: <20240410221307.2162676-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

IMS (Interrupt Message Store) support appeared in v6.2, but there are no
users yet.

Remove it for now.  We can add it back when a user comes along.

I propose to merge this via the PCI tree unless somebody else wants it.


Changes since v1 (https://lore.kernel.org/linux-pci/20240401232326.1794707-1-helgaas@kernel.org/):
  - Revert other IMS commits in IOMMU, apic, genirq, suggested by Kevin

Bjorn Helgaas (7):
  Revert "PCI/MSI: Provide stubs for IMS functions"
  Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
  Revert "PCI/MSI: Provide IMS (Interrupt Message Store) support"
  Revert "iommu/amd: Enable PCI/IMS"
  Revert "iommu/vt-d: Enable PCI/IMS"
  Revert "x86/apic/msi: Enable PCI/IMS"
  Revert "genirq/msi: Provide constants for PCI/IMS support"

 arch/x86/kernel/apic/msi.c          |  5 ---
 drivers/iommu/amd/iommu.c           | 17 +--------
 drivers/iommu/intel/irq_remapping.c | 19 ++--------
 drivers/pci/msi/api.c               | 50 ------------------------
 drivers/pci/msi/irqdomain.c         | 59 -----------------------------
 include/linux/irqdomain_defs.h      |  1 -
 include/linux/msi.h                 |  2 -
 include/linux/msi_api.h             |  1 -
 include/linux/pci.h                 | 26 -------------
 9 files changed, 5 insertions(+), 175 deletions(-)

-- 
2.34.1


