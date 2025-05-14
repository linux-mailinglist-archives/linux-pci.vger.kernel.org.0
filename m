Return-Path: <linux-pci+bounces-27755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69CAB75F5
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930647A144A
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D528F505;
	Wed, 14 May 2025 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWbJw4Om"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15086156C6F;
	Wed, 14 May 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251276; cv=none; b=d6UZ9mY6A4rFsiMiSJ++x47BD5uGGve9edXGxe7M/i4ZePcy0zRWBKbfM3vIrOsg2p4o7UjZTRZRbK+qZ/SwQi10t+479j4K3mLaXibFyAXo6qU2sikp28t1BrnmsIknCMHDpnclv9DieqLSJeEzZcAH6neg7v+ypNjKBSmUbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251276; c=relaxed/simple;
	bh=6ZhtYL9XJDANrJegpJCXnCuhUS/Ld27H9Ez7xl04a8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2gXdTwNdcazALxjbOuB2cpd7/+9JfJ0/pt0BAFvDFt6WMXA8se+/2nAAm9qUk/nzzWNPvOhgbOBcVhwxx2LHk8CmWSKgL98P8akW3D59OVpoaXfLp5GcW8gxtP3ijKoG4kNxAQ7rVUAhp0l/CzAZcdkoRKzAW2QODqYDlfrX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWbJw4Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB54C4CEE3;
	Wed, 14 May 2025 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747251275;
	bh=6ZhtYL9XJDANrJegpJCXnCuhUS/Ld27H9Ez7xl04a8M=;
	h=From:To:Cc:Subject:Date:From;
	b=XWbJw4Om0t0WHUIGln1+oKO/ad0zLXSHDcPm5ucZlmmPsXD0s4w6kMf9KAmVPpbn3
	 uYaoUhz11UmfPghYeO5mX1Sk2jgp7bRW0FTwI6lmYPhB4waVWyO4nA6azj5hKMXfjE
	 EbKRsT2+U2G3gTBf21D78bvQwKn0LE69LcY5ekk6i9Er0CeA0rjgTnLnEfgCtUgMUk
	 RBBm7SIpNmLaJreBeN2XBOBj8XbQvqD9jUzXH5STBS2EJVVlwumn4KdVyOIfLEy/0I
	 ID0Cuw2dyRA8T87Z7POJVs9S+3pGePi0GiTRXMmod9FADsPRfHfnNOnp4iaXTY2JUO
	 4B7zLsmL1riug==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Improvements to S5 power consumption
Date: Wed, 14 May 2025 14:34:03 -0500
Message-ID: <20250514193406.3998101-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A variety of issues both in function and in power consumption have been
raised as a result of devices not being put into a low power state when
the system is powered off.

There have been some localized changes[1] to PCI core to help these issues,
but they have had various downsides.

This series instead tries to use the S4 flow when the system is being
powered off.  This lines up the behavior with what other operating systems
do as well.  If for some reason that fails or is not supported, unwind and
do the previous S5 flow that will wake all devices and run their shutdown()
callbacks.

Previous submissions [1]:
Link: https://lore.kernel.org/linux-pm/CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcXSYc5kkL=6vtseF+bg@mail.gmail.com/T/#m91e4eae868a7405ae579e89b135085f4906225d2
Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/

Mario Limonciello (3):
  PM: Use hibernate flows for system power off
  PCI: Put PCIe ports with downstream devices into D3 at hibernate
  drm/amd: Avoid evicting resources at S5

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +++
 drivers/pci/pci-driver.c                   | 39 ++++++++++++++++++++--
 kernel/reboot.c                            | 12 +++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.43.0


