Return-Path: <linux-pci+bounces-35610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B1EB470BA
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901CE1C22F7E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472726FDA8;
	Sat,  6 Sep 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD09KgU5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5526FA77;
	Sat,  6 Sep 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169443; cv=none; b=bp0aMyiIll3k2FxGQg4O0uuOiWz87qORMFIzaFq3x85TsJBQ5r2b7ITIsHlAhz/Is/c1tGhZxgxC1V/V9nKtn+luXe4DWTiBgnpTkSsvZq0YD6ULC1u2uI2dH4n2E0zx6LQn6+X/6eeML2TU4OHMPOgIO57VpjIZc026T3C244w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169443; c=relaxed/simple;
	bh=e45GnWdTbpGR5XbbMlWgx0cpqS/IXSsc+dt4fnRje1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8VHdBxlq7zSanQ0APeYgcodLTTSPLpxdV6x4Pz2PpV612rPCm9BSpldg6eWqwm3E+aMULru54icNvGwDAWeGjuE0CT/WFGLUx6dllii0xEffz9uSp8N4CEKYU+HkzYx3rstzDgtt0B3f3b9VtHxnx1e8L+dcY5x0i8S39gQyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD09KgU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CB8C4CEF9;
	Sat,  6 Sep 2025 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757169443;
	bh=e45GnWdTbpGR5XbbMlWgx0cpqS/IXSsc+dt4fnRje1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oD09KgU5b1aNTAyh3zXohPA9+D+bEAdiiDFpdtUF75+tApgwdwUlwlGFmlvTZ8ZH1
	 IO+4mjFdpysiPLG/mG5+TcHV4DohKihMDmIy7v6LihFW02+rvX+fYZJXdEF1UGA+IG
	 mL8X//U20AcW4PM/rHHgGSyMzPNYOahJnRvm/lxu4S/J0BpPIpqgtBtTdC99ufdhAD
	 p8DPKdDD0sxjXF5LOfDqoFfkPP0OQsJD/7FYwcuy59Yk1UT9sBMUZlbUi731Fvy+4M
	 2KTQtTSyNhU4FtC4J13VzyZy5gtzywkVqETICLlWe1hQSx1+k+oxeg1whAKOyuIyyt
	 v5ABlhpW+GB4Q==
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
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v6 RESEND 11/11] PM: Use hibernate flows for system power off
Date: Sat,  6 Sep 2025 09:36:42 -0500
Message-ID: <20250906143642.2590808-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906143642.2590808-1-superm1@kernel.org>
References: <20250906143642.2590808-1-superm1@kernel.org>
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


