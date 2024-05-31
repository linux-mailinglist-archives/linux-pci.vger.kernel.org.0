Return-Path: <linux-pci+bounces-8117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125178D607E
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 13:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B24282BCB
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AC15746A;
	Fri, 31 May 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+tCTTr4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mumtj6s+"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA56155A53;
	Fri, 31 May 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154352; cv=none; b=OM1f7VXOKqHvy/QRUoFDkJTsisoz5QFjuZnNS5CzjQD2myXhs39POKD64236FO1wAGml/tP7wjR8mFtOK4y8DOa6eq9iqezpSzw0lZRKY5iy3rUzw0Br12+8tz6lGIYOoZ1W6N0Byf4zzNKhC1PbhpCuGVZJT83neu1GrDX8ckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154352; c=relaxed/simple;
	bh=pSNqZXR3ptCr47hJi4y3sx1XE5Az6hVVaKrTUaPrsvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIO4L6mkzFXf2517fGBDR3ieBzZlrBEATGJ/+nuvBoK2tlX9jjtjdCB0TjNgE6bjciq6p1JPGiJJDvtszDPmJGTpbwubaiSsWqygO6tikvYq5Hn/CykjHddq7lxNRdFLXlnt4uQFjNoEAczLSeAuc0XFnKUyPgNJCueyEvuhyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+tCTTr4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mumtj6s+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717154349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhOFxtuZRW6McJk35fxGo8aJBPM+ac6u4rfcns9YsC0=;
	b=I+tCTTr4HQPtlV84niLSe6Dp9NKksAbEBTfLcnh0VKoOXbIIcXbByC52ItsfVS0GzjunjK
	xtumrU9+05MR7A4jKoJc2Og9s6Vwyx6kEI9B9ujOJS6rhHvqxmO7SZoo/OGbyjdXkCdEAB
	4li/rPTQrYLJIkqkolYM7cxWgPKlfeTQKk5FqrxKQSibdrQs7kmaS/8pfij8kr3x5ZJuhf
	RNrk7Tk0+NOmV/dpjDe5UQUOSemE8BzHBX5Etj3E2RmAUV0g2Dr0UV+expUF0rm704JYsN
	XeKxyIWJJkP52w0b+TAoB8Ll+0LK558yZ2EWzS1Pl+d4nu5B6fo94pxEa3FkAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717154349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhOFxtuZRW6McJk35fxGo8aJBPM+ac6u4rfcns9YsC0=;
	b=mumtj6s+40M2wsO/GPb2nw1ItxedxrOOkOmRMLcFyGCYym89akvhLxB60gPcApMNnrKi3M
	i/iNFp0OIA6rWcAA==
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: of_property: Fix NULL pointer defererence in of_pci_prop_bus_range()
Date: Fri, 31 May 2024 13:18:59 +0200
Message-Id: <18ae685b655c6c9334cb80bb32e6b4a1b423b0ae.1717154083.git.namcao@linutronix.de>
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
function of_pci_prop_bus_range() deferences this pointer without checking
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
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000088
    [snip]
[<ffffffff804db234>] of_pci_add_properties+0x34c/0x3c6
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
index c2c7334152bc..5fb516807ba2 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -91,6 +91,9 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
 				 struct of_changeset *ocs,
 				 struct device_node *np)
 {
+	if (!pdev->subordinate)
+		return 0;
+
 	u32 bus_range[] = { pdev->subordinate->busn_res.start,
 			    pdev->subordinate->busn_res.end };
 
-- 
2.39.2


