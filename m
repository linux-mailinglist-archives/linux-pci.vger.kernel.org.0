Return-Path: <linux-pci+bounces-33793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB6B215CC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D07C624706
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF32E4275;
	Mon, 11 Aug 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMSXi/mf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085B2D9ECA;
	Mon, 11 Aug 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941293; cv=none; b=lfnkLX0jHci8PpGiwz9zedmfjmoPIp4glbVY1SCNz4UGYnGifnJUu2pTTS6ms9MYxOX2/SgwS3Q6ScUL/GozhG3ELpcwoHxX6686RIPTYPrlvzCdZxnCRAyppxAYCJipL4XuAmgLHjq6D0bNrnj4cIkfH/gymN5RX55Q6WTxZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941293; c=relaxed/simple;
	bh=3S7JR1J0KLdyO8pzE3T0jrrcCJZbmsNBb/5yq5sNZ4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu98+OPiWdabN2V1jPPPOb95r/OfZRVPPB2umadkXV6CYKeDswgzf/LAGfkNWoOYzcgNrzjHgOu/HIphQ7x7f1HUQSqKjWnRTkkPmlgJysiq3nKK1K51uXJaHUdMur82gnHZvPzOVGyED2Ef9BPB9MJS9te4T0VMxBQPzHtAR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMSXi/mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49EAC4CEF1;
	Mon, 11 Aug 2025 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941292;
	bh=3S7JR1J0KLdyO8pzE3T0jrrcCJZbmsNBb/5yq5sNZ4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMSXi/mfXO9CULm95AGcxq1StyiIAEhXKxWqrjQpgVDdbBMjE7DIHk6hXNu1KG0UG
	 AIBF8QgPqxTpfO4qMGtfD3I8/HLw+/N1zJD35KCfg8lg1AuL4sKQjtFzYHCPPiC4D3
	 UMeLVNBgvlNksicJH9YKA0je3B9gZLcD0IvtOxOa+3tJF4Q1kG1SIJ8HcXjG2UHgPA
	 zWqlLr8Q6kCpAOHRG5TgV+IiRFaA6AqyFQ282E1puyJGL/5V/od9WVffWXLKGAN1De
	 jfC4YnZQhGNe8rOSvJemtW1qfKm8zoUwO2wVEvJQhDdbQ+vGGZ4jMUSRXGEI9MIdgq
	 sgC0tFy9K3d/w==
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
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v5 11/11] PM: Use hibernate flows for system power off
Date: Mon, 11 Aug 2025 14:41:02 -0500
Message-ID: <20250811194102.864225-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811194102.864225-1-superm1@kernel.org>
References: <20250811194102.864225-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the system is powered off the kernel will call device_shutdown()
which will issue callbacks into PCI core to wake up a device and call
it's shutdown() callback.  This will leave devices in ACPI D0 which can
cause some devices to misbehave with spurious wakeups and also leave some
devices on which will consume power needlessly.

The issue won't happen if the device is in D3 before system shutdown, so
putting device to low power state before shutdown solves the issue.

ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
compatible with the current Power Resource states. In other words, all
devices are in the D3 state when the system state is S4."

The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
state is similar to the S4 state except that OSPM does not save any
context." so it's safe to assume devices should be at D3 for S5.

To accomplish this, use the PMSG_POWEROFF event to call all the device
hibernate callbacks when the kernel is compiled with hibernate support.
If compiled without hibernate support or hibernate fails fall back into
the previous shutdown flow.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Tested-by: Denis Benato <benato.denis96@gmail.com>
Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * split to multiple commits, re-order
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
v3:
 * Add new PMSG_POWEROFF and PM_EVENT_POWEROFF which alias to poweroff
   callbacks
 * Don't try to cleanup on dpm_suspend_start() or dpm_suspend_end() failures
   Jump right into normal shutdown flow instead.
 * https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
---
 kernel/reboot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85cd..c8835f8e5f271 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -305,6 +306,11 @@ static void kernel_shutdown_prepare(enum system_states state)
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
 	usermodehelper_disable();
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+	if (!dpm_suspend_start(PMSG_POWEROFF) && !dpm_suspend_end(PMSG_POWEROFF))
+		return;
+	pr_emerg("Failed to power off devices, using shutdown instead.\n");
+#endif
 	device_shutdown();
 }
 /**
-- 
2.43.0


