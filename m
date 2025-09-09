Return-Path: <linux-pci+bounces-35751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7061B50605
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364D2174DC4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A92304BC2;
	Tue,  9 Sep 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph09nlnz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C556225415;
	Tue,  9 Sep 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445395; cv=none; b=lHN/9pDIfMstCUoIyK61xmJU1KJxSGLB89iYaiCDjX0W1OmzSW3O41QhITeyhGz9LkVdrOv8wc5vM7zhNTwR5xNEsHtQe3dn7jNSqbiqNCLRFxJFw1Q4a+FfRGG8bIg1JRIsS37tdoWXVBoBZFUqq/xJL2xQPjn1T0ibJJrXaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445395; c=relaxed/simple;
	bh=cvjs2rCwr/swxBfVgyr8t6/tNbruth6PRMQgQt0HV2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yqefw+/brIiHZpbs0LbRce03CnxF8Ix2J9Thia7f3KfQfY99t2hUiSy7xbG0Pt7XjF2nXqqdewEsqZqLJBCYweqQP5WdyxRkc8PGXKuHqmVFyZ31k7/hYlYsr4R8FNR6tSAzIiMKuaNTp7h0Nfj5tuFFpNDOMjqsUHzeJugHkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph09nlnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB41C4CEF4;
	Tue,  9 Sep 2025 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445395;
	bh=cvjs2rCwr/swxBfVgyr8t6/tNbruth6PRMQgQt0HV2o=;
	h=From:To:Cc:Subject:Date:From;
	b=Ph09nlnz48AjrwU0S1msu7S5hr3O+7fKDONrb0Bijxmc3Hfl96BS2wieCUFGV9fc2
	 LrluOAXBbIY66Ri3uJ+1w1sKyPx/FDqxehGF3AlcOOkLOTijudI3PHRb6mNUKauToI
	 pvYM2nxD91T3MkYdFhf1lKJAxdQyKHVF8prjBhojOD+EwX7+anAlSTLBQXz/rZRxyy
	 +a5N/vFrsIobkE/CjU+wkpj+BECOOVN4WxWwQCX2k0to2derBibL5M9+Wi71juUhiq
	 Mx9AsUaJQPypGWH06reV28bBNDgOMRPUkOIdvtyOwlkb8aFAz0GjMx1+81koMTDvwZ
	 LXkyxfJXJs/8w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:TRACING),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 00/12] Improvements to S5 power consumption
Date: Tue,  9 Sep 2025 14:16:07 -0500
Message-ID: <20250909191619.2580169-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A variety of issues both in function and in power consumption have been
raised as a result of devices not being put into a low power state when
the system is powered off.

There have been some localized changes[1] to PCI core to help these issues,
but they have had various downsides.

This series instead uses the driver hibernate flows when the system is
being powered off or halted.  This lines up the behavior with what other
operating systems do as well.  If for some reason that fails or is not
supported, run driver shutdown() callbacks.

Rafael did mention in earlier versions of the series concerns about
regression risk.  He was looking for thoughts from Greg who isn't against
it but also isn't sure about how to maintain it. [1]

This has been validated by me and several others in AMD
on a variety of AMD hardware platforms. It's been validated by some
community members on their Intel hardware. To my knowledge it has not
been validated on non-x86.

On my development laptop I have also contrived failures in the hibernation
callbacks to make sure that the fallback to shutdown callback works.

In order to assist with potential regressions the series also includes
documentation to help with getting a kernel log at shutdown after
the disk is unmounted.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Cc: Eric Naim <dnaim@cachyos.org>
Link: https://lore.kernel.org/linux-usb/2025090852-coma-tycoon-9f37@gregkh/ [1]
---
v6->v7:
 * Add documentation on how to debug a shutdown hang
 * Adjust commit messages per feedback from Bjorn

Mario Limonciello (AMD) (12):
  PM: Introduce new PMSG_POWEROFF event
  scsi: Add PM_EVENT_POWEROFF into suspend callbacks
  usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
  USB: Pass PMSG_POWEROFF event to suspend_common()
  PCI/PM: Disable device wakeups when halting or powering off system
  PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI/PM: Run bridge power up actions as part of restore phase
  PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
  PCI: Put PCIe bridges with downstream devices into D3 at hibernate
  drm/amd: Avoid evicting resources at S5
  PM: Use hibernate flows for system power off
  Documentation: power: Add document on debugging shutdown hangs

 Documentation/power/index.rst              |  1 +
 Documentation/power/shutdown-debugging.rst | 55 ++++++++++++
 drivers/base/power/main.c                  |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +
 drivers/pci/pci-driver.c                   | 99 +++++++++++++++-------
 drivers/scsi/mesh.c                        |  1 +
 drivers/scsi/stex.c                        |  1 +
 drivers/usb/core/hcd-pci.c                 | 11 ++-
 drivers/usb/host/sl811-hcd.c               |  1 +
 include/linux/pm.h                         |  5 +-
 include/trace/events/power.h               |  3 +-
 kernel/reboot.c                            |  6 ++
 12 files changed, 159 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/power/shutdown-debugging.rst


base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
-- 
2.43.0


