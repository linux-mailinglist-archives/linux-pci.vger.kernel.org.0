Return-Path: <linux-pci+bounces-8118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5C78D6082
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 13:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5081C21527
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F72157488;
	Fri, 31 May 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HAsPEDLs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRgLpBmX"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF27156F5B;
	Fri, 31 May 2024 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154352; cv=none; b=rz9xoCxQFiYRh3h4uUp/JjgSoGqrlGDUV8eFvWyxMT0O5gXOCMomsdaeq7oo0kA/zxrSazcZmJUdGZvZie52DOtEPUby4ZPXF57Sl/8WHAcW8Op+wiojGfqtjiilbOFQtmxSQPEHpPeBh+XGdx8h1Y/wsAU1hUaKn53NKq1uLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154352; c=relaxed/simple;
	bh=Q/k0ZuJgDxU64Fg7EXSjwr3Af/BGVhb3gFxOmobhEZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xqo86MTy7x0nadnIl2KtobHJtMw3O2hSmdkJcw0IOII7fuxVLirrfWy6UAiuRQvJgGnN1jLFDmE7oHbCfA6m6hQoM1NBbwDmlnkK741WUWPL3upMKOkDYrrPymsLMFICzASprclpozUlRWoRnAbzHE7skrSL8XO71KS2Oeqh938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HAsPEDLs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRgLpBmX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717154349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaI3CFwEe6RD74mHpEKGILiAvt58PIOSoSNwjACCcVc=;
	b=HAsPEDLsyQ6bOu4ZuP/CmWhMQTJp+F+P8iX5d3ZgKBjfO2jt/goXI1G1L6t0k1uPH8Y1Pr
	+9YjzxNc6NsNZL+W7T1XabiFHZY74hn9teFhfU5v0ug/mXeB8eHpUZJJV5sPZnVLD6/C86
	klkNa3qstqzvLjHXZHqZTlknALpJa/vcyNBakUHPTW/IyIwcfmk8aj/5t4uGSp8ExgUs8+
	7rLxCKrQYs0jAlh0leV/jz4Kz+X8gpawrCdBksYGT/KKEEwM+BdITe1BDqGTj48PGCgbyb
	RCvYSybNz5zoWHp9trR4v8wqNfufHh04bN/CoGi92YdL7zz+F12f7kOEHrCa8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717154349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaI3CFwEe6RD74mHpEKGILiAvt58PIOSoSNwjACCcVc=;
	b=XRgLpBmXmSQF7EgKpoWN14dFoPzhYEM7IklIj+SAeJxShIvWMcV1sUWtHaBW3UufgQfep7
	W9wJogk9URdh7ZDQ==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: of_property: Fix NULL pointer defererence in of_pci_prop_intr_map()
Date: Fri, 31 May 2024 13:19:00 +0200
Message-Id: <52dd5a634cb6b490c6a49170abdde4f1070c2ad6.1717154083.git.namcao@linutronix.de>
In-Reply-To: <cover.1717154083.git.namcao@linutronix.de>
References: <cover.1717154083.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subordinate pointer can be null if we are out of bus number. The
function of_pci_prop_intr_map() deferences this pointer without checking
and may crashes the kernel.

This crash can be reproduced by starting a QEMU instance:
    qemu-system-riscv64 -machine virt \
    -kernel ../build-pci-riscv/arch/riscv/boot/Image \
    -append "console=ttyS0 root=/dev/vda" \
    -nographic \
    -drive "file=root.img,format=raw,id=hd0" \
    -device virtio-blk-device,drive=hd0 \
    -device pcie-root-port,bus=pcie.0,slot=1,id=rp1,bus-reserve=0 \
    -device pcie-pci-bridge,id=br1,bus=rp1

Then hot-add a bridge with
    device_add pci-bridge,id=br2,bus=br1,chassis_nr=1,addr=1

Then the kernel crashes:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
    [snip]
[<ffffffff804dac82>] of_pci_prop_intr_map+0x104/0x362
[<ffffffff804db262>] of_pci_add_properties+0x382/0x3ca
[<ffffffff804c8228>] of_pci_make_dev_node+0xb6/0x116
[<ffffffff804a6b72>] pci_bus_add_device+0xa8/0xaa
[<ffffffff804a6ba4>] pci_bus_add_devices+0x30/0x6a
[<ffffffff804d3b5c>] shpchp_configure_device+0xa0/0x112
[<ffffffff804d2b3a>] board_added+0xce/0x354
[<ffffffff804d2e9a>] shpchp_enable_slot+0xda/0x30c
[<ffffffff804d336c>] shpchp_pushbutton_thread+0x84/0xa0

NULL check this pointer first before proceeding.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/of_property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 5fb516807ba2..c405978a0b7e 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -199,6 +199,9 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 	int ret;
 	u8 pin;
 
+	if (!pdev->subordinate)
+		return 0;
+
 	pnode = pci_device_to_OF_node(pdev->bus->self);
 	if (!pnode)
 		pnode = pci_bus_to_OF_node(pdev->bus);
-- 
2.39.2


