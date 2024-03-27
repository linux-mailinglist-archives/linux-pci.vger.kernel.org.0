Return-Path: <linux-pci+bounces-5252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABD88E2DE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6061F28448
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C924177A9A;
	Wed, 27 Mar 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cje0nW1r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166B177A96;
	Wed, 27 Mar 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542202; cv=none; b=rgCxhzjRcq5MMhtgS9ogKvhBoJ/1zkfEe+yXgGobrD7fTqKVHbWr69H1f9AvRT+nLv//HmACzRxVMo96XeN4mTtDDTiPL/sKADrN7KCIspFkzhDmNkZyq/7KHLExXoNz/e0KTbkKT01ylCORwpiYslklGUxxJ1ik1KetMt05IDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542202; c=relaxed/simple;
	bh=92r58BbZAW6FjwKhCT465uK7/szSb+Dp1ruccGx2vIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQZA9Cn8xBVOC7dnifq82FEOPYZuW5XCo5Xa1kUG4WQAxkcdDDht3NTW1RhdIMTuOLnXTOiDO2LoZlMAvtZah/nWY9tr+S1ZW3lzMaZjmdiC24lATNPuE4fn0ACrFjHvdiDsdCVAL40OJd20hWNpBgPwh+ZldSYGBszXEj5SEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cje0nW1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B91C433C7;
	Wed, 27 Mar 2024 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542202;
	bh=92r58BbZAW6FjwKhCT465uK7/szSb+Dp1ruccGx2vIo=;
	h=From:To:Cc:Subject:Date:From;
	b=Cje0nW1rixMxBFCvYGCtcX+AgMK1fMDWSRoTnlvZWAcKR8vM3Sf0awi8XUsxVmh7U
	 RqG66fg8znfK6q1qjzmfmjWbuD3kHjnh0jybtFVOBQDAH85idaDqawDZ5Xz0bfq/0A
	 3GKRkt9LU2vlljNDUvxLabNqppFPmv0JEIDIXTycro/Jb1x81aMe6gy9SGM3tiZu/w
	 4dfUAsqxSrN4RJpY6rVYC1hYXFwTitE64UoYjpQnD0F0vOPGOx/kNWhuMPdn8+ydIC
	 /cgCuZqulZGrAEzdHFKaE+qP3w9t8ntdshT3hlfaWAQiKPOu44dw1qOV15zBrqD/2Z
	 TKCzaR0XnrHWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: Niels van Aert <nvaert1986@hotmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:20 -0400
Message-ID: <20240327122320.2838443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 627c6db20703b5d18d928464f411d0d4ec327508 Mon Sep 17 00:00:00 2001
From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 5 Mar 2024 12:30:56 +0100
Subject: [PATCH] PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
Ports") and commit 3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel Ice
Lake Root Ports") add quirks for Ice, Tiger and Alder Lake Root Ports.
System firmware for Raptor Lake still has the bug, so Linux logs the
warning below on several Raptor Lake systems like Dell Precision 3581 with
Intel Raptor Lake processor (0W18NX) system firmware/BIOS version 1.10.1.

  pci 0000:00:07.0: [8086:a76e] type 01 class 0x060400
  pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
  pci 0000:00:07.1: [8086:a73f] type 01 class 0x060400
  pci 0000:00:07.1: DPC: RP PIO log size 0 is invalid

Apply the quirk for Raptor Lake Root Ports as well.

This also enables the DPC driver to dump the RP PIO Log registers when DPC
is triggered.

Link: https://lore.kernel.org/r/20240305113057.56468-1-pmenzel@molgen.mpg.de
Reported-by: Niels van Aert <nvaert1986@hotmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218560
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Niels van Aert <nvaert1986@hotmail.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d797df6e5f3e9..663d838fa861d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6225,6 +6225,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
 
 /*
-- 
2.43.0





