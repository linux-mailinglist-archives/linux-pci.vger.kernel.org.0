Return-Path: <linux-pci+bounces-22645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1BA49DFF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574EF3BCD91
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539B27126A;
	Fri, 28 Feb 2025 15:46:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818DB270EA9;
	Fri, 28 Feb 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757608; cv=none; b=cc2wkubdfUiE3BX0N7iaCSMdnWeUgpUh94yDIv2z8igKDJewsawuwkDHH9VEzxy9BeuGNJRuwCqM/4So+nXFiZq5WZuYY6e/JBpkFIkAA6z7RJrJuX8ifGSxxnjAB4AmHtNde1c1tN3Teo9PMqgQN2H0tMSKTpoOc7+KLhcKSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757608; c=relaxed/simple;
	bh=Co92DQrOkxarOUPPnw+47Twq9u95xJbT1q0NnKciIpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kiDscLZqspgA0aPVSxIXVrdyJ3FL+s3E5WINoskNRx9DQCHBVRwtykixJekmH7YRtLNNoS/SDr53fUOdFrU8R5KIZllZHbIJDa1Ztn3zVEA2FikjgG298mIbCaIT70W40MjW5ZfajArX0i1DInoTmj5lW8sDGxykesuDBGjN0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF239150C;
	Fri, 28 Feb 2025 07:46:59 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64CB43F5A1;
	Fri, 28 Feb 2025 07:46:41 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH v2 0/4] iommu: Fix the longstanding probe issues
Date: Fri, 28 Feb 2025 15:46:29 +0000
Message-Id: <cover.1740753261.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-iommu/cover.1739486121.git.robin.murphy@arm.com/

Hi all,

This spin irons out a couple of issues which v1 had. Firstly there
should now be no change in behaviour for the weird of_dma_configure()
calls, other than possibly getting the warning if they deserve it.
Secondly I think there was still a possibility for probe to run via
the replay path while its "real" probe was waiting to reacquire the
lock; this is now solved by making dev->iommu a reliable indicator of
the probe lifecycle, with a couple more prep patches.

Thanks,
Robin.


Robin Murphy (4):
  iommu: Handle race with default domain setup
  iommu: Resolve ops in iommu_init_device()
  iommu: Keep dev->iommu state consistent
  iommu: Get DT/ACPI parsing into the proper probe path

 drivers/acpi/arm64/dma.c        |  5 +++
 drivers/acpi/scan.c             |  7 -----
 drivers/amba/bus.c              |  3 +-
 drivers/base/platform.c         |  3 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c |  3 +-
 drivers/cdx/cdx.c               |  3 +-
 drivers/iommu/iommu-priv.h      |  2 ++
 drivers/iommu/iommu.c           | 55 ++++++++++++++++++++++++---------
 drivers/iommu/of_iommu.c        | 13 ++++++--
 drivers/of/device.c             |  7 ++++-
 drivers/pci/pci-driver.c        |  3 +-
 11 files changed, 74 insertions(+), 30 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


