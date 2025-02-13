Return-Path: <linux-pci+bounces-21399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830BA3524F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 00:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265411889DE0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C51C84CF;
	Thu, 13 Feb 2025 23:49:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3878275419;
	Thu, 13 Feb 2025 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490560; cv=none; b=ju4+l3cpUkoIWUgBozNBsLibgcaxDXS9pM/bKCzQS2fCsehidGB7zfzH9D6BxZwGWBWRopDI4+LPnroG2mGj1c+Tuilnn095ucHutYrlls3U6WLmB+QP9Llj5SieuYYFA7y4yeDzC2d5gBCxMaKi093/Chpao/auJQwwOr4m/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490560; c=relaxed/simple;
	bh=G937Fjrr8kTIvV25mecSAT2DDc5acNTz01lSZNZNB1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnjXNSAwvs8uhqu4ojeK5Fmyh6wwnycSBp0qLHHnc8wqPAZoIrNAHHwBRFwxXBKNhEJtMfHFlA7/VwOoLzC8M39m8rzQComgNzK85MVTm8yxp4+Nh5HQ9/Z0LCwgpjGijwtf7J4ipXpw9+pbQV8ZuHUhwnrgYRjRivSaKKJYOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E1B0113E;
	Thu, 13 Feb 2025 15:49:36 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2282E3F5A1;
	Thu, 13 Feb 2025 15:49:12 -0800 (PST)
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
Subject: [PATCH 0/2] iommu: Fix the longstanding probe issues
Date: Thu, 13 Feb 2025 23:48:58 +0000
Message-Id: <cover.1739486121.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Finally, it's that thing I've been mentioning on and off for the last 5
years or so! After far too much thinking about "clean" ways to refactor
everything towards an eventual goal of working properly, I finally gave
up and decided to see how bad it would be to just get it working, then
worry about cleaning up afterwards. Frankly I still can't quiet believe
how small the patch turned out to be...

Patch #1 is a fix for what I think is the only "expected" race in the
core API design - we knew we had that window where a default domain is
NULL, but the potential consequences weren't clear until Charan figured
it out the hard way. That should be good to go already, and it's not
strictly a dependency for patch #2, but it seemed worth posting them
together on the common theme.

Patch #2 is then the first big bite out of the problem I feel compelled
to fix because it's my name on d7b0558230e4 ("iommu/of: Prepare for
deferred IOMMU configuration") which, in hindsight, started it. I hope
this will be the only patch which has to touch absolutely everything all
at once. I've not got very far with the follow-up patches yet, but I do
foresee being able to tackle the driver core, firmware subsystems and
bus drivers more independently. I don't expect anyone to love it, but I
hope you can at least see where I'm going and give a bit of leeway for
now :)

I also do rather expect that WARN_ON to be hit, but the intent is that
I'd like to get the attention of any of_dma_configure() abusers so they
can help me figure out what the heck their code *should* be doing...

Thanks,
Robin.


Robin Murphy (2):
  iommu: Handle race with default domain setup
  iommu: Get DT/ACPI parsing into the proper probe path

 drivers/acpi/arm64/dma.c        |  5 ++++
 drivers/acpi/scan.c             | 10 +++----
 drivers/amba/bus.c              |  2 +-
 drivers/base/platform.c         |  2 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c |  2 +-
 drivers/cdx/cdx.c               |  2 +-
 drivers/iommu/iommu.c           | 48 +++++++++++++++++++++++++--------
 drivers/iommu/of_iommu.c        | 10 ++++++-
 drivers/of/device.c             |  7 ++++-
 drivers/pci/pci-driver.c        |  2 +-
 10 files changed, 65 insertions(+), 25 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


