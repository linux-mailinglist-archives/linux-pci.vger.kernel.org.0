Return-Path: <linux-pci+bounces-4517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F299E871DDD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 12:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187C31C237D6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD658138;
	Tue,  5 Mar 2024 11:31:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB85810B;
	Tue,  5 Mar 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638303; cv=none; b=b4eZ4N3aVnhKB2DQuaebdrzUpIrAqAyvAl1FQib/BnioAtFIgur5IraUOFxssUMf6Q7Vhp8Xiavt1PQF9rZqK6zCaAdpfJIk08B3urfpDvG/OOmvEJUm36fFrOClwx6EtNIKrpxZ1d5PC9GzgPcxX/z0vCRquJqP0rIwKUrNA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638303; c=relaxed/simple;
	bh=UqGd1ri4gTlEkvaN2aOBK9y3ML5BPpaqHWx1c43uktk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCFlU2MuIlqwA9hLh8acFF2Ji9B3VdV4OpDp6ICEJgralc0/0OR7UpJh64WMWAcjUM/Tnnp27anyGAKWPybiTOD03U0Z7p/xwptBApYN01D/Dp10SOL3+bN6q/zoik8mvSi3yqTHi8ZeiBVN9GC53yw0tenPqvFTcMmqvzOa8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C5E4961E5FE3E;
	Tue,  5 Mar 2024 12:31:09 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	nvaert1986@hotmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports
Date: Tue,  5 Mar 2024 12:30:56 +0100
Message-ID: <20240305113057.56468-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
Ports") and commit 3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel Ice
Lake Root Ports") add quirks for Ice, Tiger and Alder Lake Root Ports.
System firmware for Raptor Lake still has the bug, so Linux logs the
warning below on several Raptor Lake systems like Dell Precision 3581 with
Intel Raptor Lake processor (0W18NX) system firmware/BIOS version 1.10.1.

    pci 0000:00:07.0: [8086:a76e] type 01 class 0x060400
    pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
    pci 0000:00:07.0: PTM enabled (root), 4ns granularity
    pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
    pci 0000:00:07.1: [8086:a73f] type 01 class 0x060400
    pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
    pci 0000:00:07.1: PTM enabled (root), 4ns granularity
    pci 0000:00:07.1: DPC: RP PIO log size 0 is invalid

So, apply the quirk for Raptor Lake Root Ports as well.

This also enables the DPC driver to dump the RP PIO Log registers when DPC
is triggered.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218560
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: nvaert1986@hotmail.com
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d797df6e5f3e..663d838fa861 100644
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


