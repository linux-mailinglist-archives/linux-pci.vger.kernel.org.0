Return-Path: <linux-pci+bounces-20362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35413A1C6A8
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F5E18881A9
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4AA86323;
	Sun, 26 Jan 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDMhzUy4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA403FBA5;
	Sun, 26 Jan 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877041; cv=none; b=uXMuIzLPLGwAVbzfD34hLgElyM27kGzWnzyBLp3AXi9tudBoLvMYfOTC7bJXK0HhKuTij7GwUpBrT9T19t6yNOnBZ4oIfbLgwqxp0dFe16yZ1kJfUL6BhVl0bEbLjgnpfmDKqftdQwgxPI5Guzn+sUnTdi/06gsOm4BAgowfToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877041; c=relaxed/simple;
	bh=hsuP3lMHAHCIvgNzl5etaHwARXM+wLd5H8eaZyn3jdA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oIsLUPPl1gTcaA4xAqPfNl+4SDG0QkT62w1qaTtizkkJZaxRVBFzbe0wFEnhmGpH9OPrUbyvv3hG6tUmng74bWKyZfrpucEj5l2arZhasTHpiMkYnSy274Tgfjr333lrdYzrPZFb10e//wZlgoyy9JqaMY0lhSyeoKKJ8m20FsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDMhzUy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD0FC4CED3;
	Sun, 26 Jan 2025 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877040;
	bh=hsuP3lMHAHCIvgNzl5etaHwARXM+wLd5H8eaZyn3jdA=;
	h=Date:From:To:Subject:From;
	b=fDMhzUy4tr9ykNJ+11no0dn0dMRe1yr+C5qEJPczzjkksnlIv9py90OUALZ8dEI2L
	 kWwl6gPuJqaiESpJdsxdEcYYjUkOQekuUBZ1fRpHUdsmh5tdDwRlS1cFJOvXlT1w+e
	 UwyYfHxtj4SIP+sM1yJGB2Qcpl2HgPVr/pDLexCnX9vJOgEojhNgR4MCsl5lNkAqqi
	 si7/fd07oIg1Klz3AcDpY9fdy5wP5uPvkCGsKsm8jkenvSv+bb28saYS9Ltcm3s1UP
	 Hn4dXLQOqsu650PPya3O6ShsOa65tfz1vtl5CMvMCTiTiylzODIU0AhlsmnpUafj5e
	 FK8HZlgHHmgpw==
Date: Sun, 26 Jan 2025 08:37:16 +0100
From: Helge Deller <deller@kernel.org>
To: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] serial: 8250_pci: Fix Warning at drivers/pci/devres.c:603
 pcim_add_mapping_to_legacy_table
Message-ID: <Z5XmLKzhKpLAlzHt@p100>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some PA-RISC servers have BMC management cards (Diva) with up to 5 serial
UARTS per memory PCI bar. This triggers since at least kernel 6.12 for each of
the UARTS (beside the first one) the following warning in devres.c:

 0000:00:02.0: ttyS2 at MMIO 0xf0822000 (irq = 21, base_baud = 115200) is a 16550A
 0000:00:02.0: ttyS3 at MMIO 0xf0822010 (irq = 21, base_baud = 115200) is a 16550A
 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 1 at drivers/pci/devres.c:603 pcim_add_mapping_to_legacy_table+0x5c/0x8c
 CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.11+ #2621
 Hardware name: 9000/778/B160L
 
  IAOQ[0]: pcim_add_mapping_to_legacy_table+0x5c/0x8c
  IAOQ[1]: pcim_add_mapping_to_legacy_table+0x60/0x8c
  RP(r2): pcim_add_mapping_to_legacy_table+0x4c/0x8c
 Backtrace:
  [<10c1eb10>] pcim_iomap+0xd4/0x10c
  [<10ca8784>] serial8250_pci_setup_port+0xa8/0x11c
  [<10ca9a34>] pci_hp_diva_setup+0x6c/0xc4
  [<10cab134>] pciserial_init_ports+0x150/0x324
  [<10cab470>] pciserial_init_one+0xfc/0x20c
  [<10c14780>] pci_device_probe+0xc0/0x190
  ...
 ---[ end trace 0000000000000000 ]---

I see three options to avoid this warning:
a) drop the WARNING() from devrec.c,
b) modify pcim_iomap() to return an existing mapping if it exists
   instead of creating a new mapping, or
c) change serial8250_pci_setup_port() to only create a new mapping
   if none exists yet.

This patch implements option c).

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.12+


diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
index ea906d721b2c..fc024bf86c1f 100644
--- a/drivers/tty/serial/8250/8250_pcilib.c
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -19,7 +19,9 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
 		return -EINVAL;
 
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
-		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
+		/* might have been mapped already with other offset */
+		if (!pcim_iomap_table(dev) || !pcim_iomap_table(dev)[bar] ||
+			!pcim_iomap(dev, bar, 0))
 			return -ENOMEM;
 
 		port->port.iotype = UPIO_MEM;

