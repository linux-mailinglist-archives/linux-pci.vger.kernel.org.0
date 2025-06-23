Return-Path: <linux-pci+bounces-30394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFCFAE432A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F7C3BBF8B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01901253939;
	Mon, 23 Jun 2025 13:23:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8D252906
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684995; cv=none; b=Egjai0NhIPIV+Gyoncd9RL42Lyc3rRvLpBqeZoDjDlFlI+CWlWy803rnK3HrxHWhavdbPb7iyeLPFF8v33bryzeJkqIB2Xgt5wph2LxnLhGxFoeWed8WhXvC47PsJoO7YjIDx2aIO2aJJ+5HYxK241meNO+OTfKZIZcYinh+JiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684995; c=relaxed/simple;
	bh=jsGJB2gYtB64/EEF0NwNPB+x58YtlF/52PLvG5n5hj4=;
	h=Message-Id:From:Date:Subject:To:Cc; b=RBP7PoZfYoDwntOtqhmZmf2a+dSThdB0tF14R0n0J5k9uLhat/MTS3PKG2czB/J/svjq2Kxzc+y4wG8xAqXCkmUTLf1W6bH++TOP14+hns9DUHvGEmb3kBJ1U7paMFSn4FcLJUOb9UkFBD8CJVAn7qnQZLnRi01FV9jR6zuSkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0544C2C06655;
	Mon, 23 Jun 2025 15:23:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E4A2021098E; Mon, 23 Jun 2025 15:23:10 +0200 (CEST)
Message-Id: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 23 Jun 2025 15:22:14 +0200
Subject: [PATCH] PCI: Fix link speed calculation on retrain failure
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew <andreasx0@protonmail.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When pcie_failed_link_retrain() fails to retrain, it tries to revert to
the previous link speed.  However it calculates that speed from the Link
Control 2 register without masking out non-speed bits first.

PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
pcie_set_target_speed():

  pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
  pci 0000:00:01.1: retraining failed
  WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target_speed
  RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
  pcie_failed_link_retrain
  pci_device_add
  pci_scan_single_device
  pci_scan_slot
  pci_scan_child_bus_extend
  acpi_pci_root_create
  pci_acpi_scan_root
  acpi_pci_root_add
  acpi_bus_attach
  device_for_each_child
  acpi_dev_for_each_child
  acpi_bus_attach
  device_for_each_child
  acpi_dev_for_each_child
  acpi_bus_attach
  acpi_bus_scan
  acpi_scan_init
  acpi_init

Per the calling convention of the System V AMD64 ABI, the arguments to
pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) are
stored in RDI, RSI, RDX.  As visible above, RSI contains 0xff, i.e.
PCI_SPEED_UNKNOWN.

Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe failed link retraining")
Reported-by: Andrew <andreasx0@protonmail.com>
Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.12+
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee6..deaaf4f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
-		u16 oldlnkctl2 = lnkctl2;
+		u16 oldlnkctl2 = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
 
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
-- 
2.47.2


