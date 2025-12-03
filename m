Return-Path: <linux-pci+bounces-42566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E3C9F3B8
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC0764E1554
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A9238159;
	Wed,  3 Dec 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MCZeIICS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891B1E3DF2;
	Wed,  3 Dec 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770885; cv=none; b=FrmP4ElJ21HR9bydk8ZLr17Ky0Wkkksk5SOeo5+tK07sapp66LM8eZuD8GNzuoUcGbOXoDowTHmXJYtm5aDqUfR83j7xtO9Xl96I9/PptRys6JCC4WjUFoeAmsIJUFo0F86QvBKrpKaWxoZS2p6x6cwF3Sycrfc2kewT4ZMSlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770885; c=relaxed/simple;
	bh=PSSOQbiuoMFwbBWEEMiiUUq96LEP5YutIhssCZGMHV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/C2ssMyWtTTXzDmjwB2w0Ba3MaeJ/EGW7X0gAzX3MpDqcoRV8+GPeZHDepWjHZdSms3qKrIwW62MoD6OtarRjRVsFd97RaAAPxUU0Yvy1LG8VZ5/oVNZOw+ftSj9RnPyfWvZFnUSeZjA+r6ShHv7ZLQesaKL5Ithi2f0wS9aKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MCZeIICS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6v
	jPMbJovrzsBMLAUkTTVNnF0FnwAzcF2LJIGzth/x0=; b=MCZeIICSWkmguaZOjQ
	MsTQY966D9U+FZn+7rnjgEOJ32tZ2opgdJPQr0CZwgiRXs2avSoiN+jLOeUsQZey
	jycrIv+tOqm5FtTW6En7e2Vu7KtpUQYEuvb9ZJm7d/Dnd4saTASTlREb3qqomepW
	HJ5FDvldz1BKOBpmKmIcFQ2D8=
Received: from emily-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnJEcWRDBpRx7lDg--.2028S2;
	Wed, 03 Dec 2025 22:07:20 +0800 (CST)
From: huyuye <huyuye812@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn,
	hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn,
	zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn,
	huyuye <huyuye812@163.com>
Subject: [PATCH] ACPI: pci_root: Clear the acpi dependencies after PCI root bridge initialization on RISC-V
Date: Wed,  3 Dec 2025 22:07:15 +0800
Message-ID: <20251203140716.3065-1-huyuye812@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnJEcWRDBpRx7lDg--.2028S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8tr18JFy5JrWUCw45Jrb_yoW8Zr45pF
	4jg3W5KrykXw1qkrnxAw18try5Xan5u3y5GrZrCw1S9a1ku3WjvF92ya4jyFy3JFs7AF43
	XrZFqF1kCF1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFfO5UUUUU=
X-CM-SenderInfo: 5kx135bhyrjqqrwthudrp/xtbBzxAZCGkwQ7AJ6AAAsF

On RISC-V platforms with multiple PCI root bridges, the enumeration
order varies randomly across reboots due to APLIC driver initialization
occurring after ACPI device scanning. This defers PCI probing to a
unbound workqueue, resulting in non-deterministic device discovery
sequences.

Such random enumeration leads to changes in device naming across each
boot, which disrupts storage configurations, network settings, and
severely impacts the stability of server maintenance.

By adding the acpi_dev_clear_dependencies() call in acpi_pci_root_add(),
this patch enables the firmware to actively control the enumeration order
of multiple PCI root bridges through the ACPI _DEP method, providing the
firmware with the opportunity to initialize devices in the intended order,
thereby ensuring consistent enumeration results across multiple boots.

Signed-off-by: huyuye <huyuye812@163.com>
---
 drivers/acpi/pci_root.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..f5b5aa7d5f93 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -760,6 +760,20 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	pci_lock_rescan_remove();
 	pci_bus_add_devices(root->bus);
 	pci_unlock_rescan_remove();
+#ifdef CONFIG_RISCV
+    /*
+     * Clear dependencies to allow dependent devices to be enumerated.
+     * This is particularly important for RISC-V platforms where multiple
+     * PCIe host bridges may have initialization order dependencies defined
+     * via ACPI _DEP method in DSDT. If a host bridge B depends on host
+     * bridge A (via _DEP), this call allows bridge B to proceed with
+     * enumeration after bridge A is fully initialized.
+     */
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_dev_clear_dependencies(device);
+#endif
+#endif
 	return 1;
 
 remove_dmar:
-- 
2.43.0


