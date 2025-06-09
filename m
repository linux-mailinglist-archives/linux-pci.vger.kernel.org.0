Return-Path: <linux-pci+bounces-29189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D021AD1711
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42ACF16932E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794E224254;
	Mon,  9 Jun 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ6X/3HY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F471459F6;
	Mon,  9 Jun 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437196; cv=none; b=im9st3VKZK9bxxjJepu1VoA3LFqAiD6FiZ3vIu61K2X29Q6D0vpnRGmbrDEno7dwcQJGoiGu1BdvXo8YHeb/DC0RDNhF45eIPQvCjEs9eAnSeAba3gycbIbUNGxR3WE6Pm+BB0kA0MN/lvzLte8jlPZsT7p8NzKeOtJxi0hIpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437196; c=relaxed/simple;
	bh=jM8wdEwNXLFrk2Eu5Cqxd8tWg9JnaEJ9FmQA4RrL0lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/2Fp4Yk4BSph4QdKGzjyfojqNdQfs2EP3ej1Ue6cXRsZeM4IQuFnHI7TOnndUiCetqx4KwXmYVlPPAyBxFJixtKmdIycGXB1TQhfonM6lYxeYz7zN4DrHgusWxxQqRNESakeEcJmNKlQXSe6qhqsTQ9yob0ymE5zF2G/gK4axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ6X/3HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D56C113CF;
	Mon,  9 Jun 2025 02:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749437196;
	bh=jM8wdEwNXLFrk2Eu5Cqxd8tWg9JnaEJ9FmQA4RrL0lg=;
	h=From:To:Cc:Subject:Date:From;
	b=fQ6X/3HYQ36F34pys39KIOh3hRdYubeC8dJnN6E3MgHSdrz6VAAMLBeuG52nFdRC6
	 ClXEk2iN+NY7tneTNnsxl38Mn60H1ailCD797tocWFSQdvQvDA+WQTK2QAGFBnLhwM
	 CKs6zwhpgqB3SoqPKYoCc/jJILf50jUnLIfbjpd7Nmge9axRvzjes/EJ4kSjbOWNJl
	 r06GlIIgDkWhUqg10E4Vk4Kvr64uFkEJsFPcwCnucdna0PXkvJpxhpNn6x+13jeoMi
	 T/iB3idBZeMypjeF79wn52M8iqkRbKF4pSauFlSjket1PcUu4V+43BLIWCI2mbRefP
	 uv9OPfuRYqbiQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/5] Improvements to S5 power consumption
Date: Sun,  8 Jun 2025 21:46:14 -0500
Message-ID: <20250609024619.407257-1-superm1@kernel.org>
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
Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/ (v1)
Link: https://lore.kernel.org/linux-pm/20250514193406.3998101-1-superm1@kernel.org/ (v2)

Mario Limonciello (5):
  PM: Use hibernate flows for system power off
  PCI: Put PCIe ports with downstream devices into D3 at hibernate
  drm/amd: Avoid evicting resources at S5
  scsi: Add PM_EVENT_POWEROFF into suspend callbacks
  usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks

 drivers/base/power/main.c                  |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +
 drivers/pci/pci-driver.c                   | 92 ++++++++++++++--------
 drivers/scsi/mesh.c                        |  1 +
 drivers/scsi/stex.c                        |  1 +
 drivers/usb/host/sl811-hcd.c               |  1 +
 include/linux/pm.h                         |  3 +
 include/trace/events/power.h               |  3 +-
 kernel/reboot.c                            |  6 ++
 9 files changed, 84 insertions(+), 34 deletions(-)

-- 
2.43.0


