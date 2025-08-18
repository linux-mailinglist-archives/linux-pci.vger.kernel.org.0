Return-Path: <linux-pci+bounces-34149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A770B29667
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988407AF6BD
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60127211A28;
	Mon, 18 Aug 2025 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8fzKtHa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AE15E97;
	Mon, 18 Aug 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482472; cv=none; b=Q2MfLuNFJdc1xdc4pQCA8JZ7h2jqbgH8fMaHyPl7dEND1tJ5DzMSDHFulO+aU0frg2D7M8qJN3tBFeeIir4rFE2Hats+yEsrHnUJfYZuRZ2lqrjuLSNJ6GFv0KAgGYh/Q9hjH3dqZ7m2uJAmWslEjE6HFtzS1e5p+PuvuDx8Y0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482472; c=relaxed/simple;
	bh=kWIIgPr6HtDstdyS7iA7DZu7CzISPaHw3M5QTz15zF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fREhbobel9gpWk2Elaac4pkfq3tPW3z8brjT6B6AZGOtt3ceeMdWXASK1tIWwTwLxFHZtU1ioGB6x7kFahz5SFGW6xWbmMWZOj/vIc9GjpZfjhve2pV5eXbwVAPzid0VsZlJrIZDKcr/U3jaDkDgWSQtkjmaq3iQQVjQa38bmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8fzKtHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57CAC4CEEB;
	Mon, 18 Aug 2025 02:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755482471;
	bh=kWIIgPr6HtDstdyS7iA7DZu7CzISPaHw3M5QTz15zF0=;
	h=From:To:Cc:Subject:Date:From;
	b=n8fzKtHawP+yHdqrWYRAbcQfHs8/nRt/40I/lJ6P+5i7uTKDs8H7Oi4D9r6fHsMfI
	 yKKzjaLO1n0pNHI1lpWgMb3J3OmshIK/26SmO5ibk5AaGpZ8Zy17CAP7r8R7TBA4jG
	 v/6RrbADCP2EeliDuzl8J1bdP2FQEJnHRSPxmt0tSvkHAFGimoikfDxaDXxVfKdh1n
	 vcZ+JjXR+Ro7ZZf27jXi4qgYxD4ZMQewKnofBaWBi9RtmXp/iPNfQPcr/XHDYD8D0B
	 D4MZO5SSJWRTZjkHZB42+iL9x2a0B6hFdnuN/hlC7JvRwtXiV+/9jcstzwa/DmEpn0
	 M+csMxo90Bx6Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v6 00/11] Improvements to S5 power consumption
Date: Sun, 17 Aug 2025 21:00:50 -0500
Message-ID: <20250818020101.3619237-1-superm1@kernel.org>
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

This series instead tries to use the S4 flow when the system is being
powered off.  This lines up the behavior with what other operating systems
do as well.  If for some reason that fails or is not supported, run their
shutdown() callbacks.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Cc: Eric Naim <dnaim@cachyos.org>
---
v5->v6:
 * Fix for LKP robot issue
 * Some commit message changes
 * Rebase on 6.17-rc2

Mario Limonciello (AMD) (11):
  PM: Introduce new PMSG_POWEROFF event
  scsi: Add PM_EVENT_POWEROFF into suspend callbacks
  usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
  USB: Pass PMSG_POWEROFF event to suspend_common() for poweroff with S4
    flow
  PCI: PM: Disable device wakeups when halting system through S4 flow
  PCI: PM: Split out code from pci_pm_suspend_noirq() into helper
  PCI: PM: Run bridge power up actions as part of restore phase
  PCI: PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
  PCI: Put PCIe bridges with downstream devices into D3 at hibernate
  drm/amd: Avoid evicting resources at S5
  PM: Use hibernate flows for system power off

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
 10 files changed, 103 insertions(+), 35 deletions(-)

-- 
2.43.0


