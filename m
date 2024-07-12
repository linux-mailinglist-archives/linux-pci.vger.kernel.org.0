Return-Path: <linux-pci+bounces-10195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF992F58F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5352837D8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D742219E2;
	Fri, 12 Jul 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MsLatVbt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDF13D520;
	Fri, 12 Jul 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765807; cv=none; b=m76PoDcvxscBHzK9BUmxCW0FIfkSNmJcoFvvTjjOqBD2cO05rMJkaYzR7WkGxz6dBsp447Z0OVT6k8OktbxzJMS1VfvmzN30/hg8M/IdZSEKPP6EGRuKoQcLlL8U4ajJ2wXbREYb+0Bca44d1AWo978xkk0J/kFBO1hWzEddJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765807; c=relaxed/simple;
	bh=KuZfxdNvcEKZcB/S7+Dx2Tux/HsIBYp3cDVVxqENwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAR+zCJe+VpFQgU2bGftnnJE97lBNGKfeXb8a9EZ/K47BxpeY/dILQSd59Nqfcxf7Iz7DfYH8xxjFXdXu9J7kk3tOcHNIXJRRUI6FjJu8MHXQn2XSjkfopPuoVAI/GoTifdutDl4KWkVZsaKIJyti6bMEfCZzQzcLyL1kgSpD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MsLatVbt; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (114-136-183-165.emome-ip.hinet.net [114.136.183.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9CEE63F2EF;
	Fri, 12 Jul 2024 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720765459;
	bh=i6hzXoHNLWliF1K00cSPyBGiejHxlcP1pWL+nbbCtIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=MsLatVbtWA+f7aS/jR6sttFvHsfUYQzIbkW21uybxoUDdDSRGZ4jHyW9dhM6bAXMU
	 E8kVQZ9cZAucXN65xTypQUAkbHlAVibOYzXPNBfqnBSTsv2F5YiLP6YX6j8JIqJbPz
	 cazeKJVD4uGSN1nLA0Sn/r4glSK7jPPhGOG/sA3SM+2umRWcXCk3JEHOdpU6IJ6Ik6
	 jUhoN1fXgqK/ZjqJo1IP4cPzxMLkefhel0Rd3MnESo7lA2czTQcrVfvu0xBaKoWd0A
	 74qDWcMNT1114zlXjm+OAb9nmvWYW0V8zua5WYrPmCXU6P30olw1faxZSoLjjQfPUo
	 6mn3C1pKVQU3A==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: mario.limonciello@amd.com,
	mika.westerberg@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI/PM: Put devices to low power state on shutdown
Date: Fri, 12 Jul 2024 14:24:11 +0800
Message-ID: <20240712062411.35732-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
connected.

The following error message can be found during shutdown:
pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
pcieport 0000:09:04.0:    [ 7] BadDLLP

Calling aer_remove() during shutdown can quiesce the error message,
however the spurious wakeup still happens.

The issue won't happen if the device is in D3 before system shutdown, so
putting device to low power state before shutdown to solve the issue.

I don't have a sniffer so this is purely guesswork, however I believe
putting device to low power state it's the right thing to do.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci-driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..4c6f66f3eb54 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+	/*
+	 * If driver already changed device's power state, it can mean the
+	 * wakeup setting is in place, or a workaround is used. Hence keep it
+	 * as is.
+	 */
+	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
+		pci_prepare_to_sleep(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-- 
2.43.0


