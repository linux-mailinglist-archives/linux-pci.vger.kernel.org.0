Return-Path: <linux-pci+bounces-18235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB189EE207
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A751884C2A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44C20DD79;
	Thu, 12 Dec 2024 08:56:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1D204C1D
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993793; cv=none; b=cYDojVRt5q+L8DoMweg7OxnNc4tCYDJrw8Y1Kd6SjWTw6LXMv34i852wjbVjYAkNtYvKnaFAPjyI6dqk3gs5NpBjhY1ywlRvEOO171k5VF2vPqmaZnQDymIMMoV5dAhmernbfHGMMbM3/CLnJajMsLUy1UZ0BvjdK28fLoihDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993793; c=relaxed/simple;
	bh=IO0SigIFCBzXuHMTL80sEiwxTi5KnGe3hHVUMrHcDiE=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=H7fychkZO041k6+sRHrZAemsC8hjb/eU9rDyC/YYxEN1B9qT7BX7g/Z3zgI/+no0AdR+pgAt8akVQKxrg8/XFgRbMKI5V1AUQh8B6zOmV9mqwqBjvlWx7pM4K3vZC8MUHUP5rge6BWFEVaC+hCkCgZ2/p8yO37KZkP2zSBWYtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 99A47100DCEFD;
	Thu, 12 Dec 2024 09:56:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6457B3CAFF0; Thu, 12 Dec 2024 09:56:19 +0100 (CET)
Message-Id: <e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 12 Dec 2024 09:56:16 +0100
Subject: [PATCH for-linus] PCI: Honor Max Link Speed when determining
 supported speeds
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>

The Supported Link Speeds Vector in the Link Capabilities 2 Register
indicates the *supported* link speeds.  The Max Link Speed field in
the Link Capabilities Register indicates the *maximum* of those speeds.

Niklas reports that the Intel JHL7540 "Titan Ridge 2018" Thunderbolt
controller supports 2.5-8 GT/s speeds, but indicates 2.5 GT/s as maximum.
Ilpo recalls seeing this inconsistency on more devices.

pcie_get_supported_speeds() neglects to honor the Max Link Speed field
and will thus incorrectly deem higher speeds as supported.  Fix it.

Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
Reported-by: Niklas Schnelle <niks@kernel.org>
Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35dc9f2..b730560 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6240,12 +6240,14 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
 
+	/* Ignore speeds higher than Max Link Speed */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS, 0);
+
 	/* PCIe r3.0-compliant */
 	if (speeds)
 		return speeds;
 
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-
 	/* Synthesize from the Max Link Speed field */
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
 		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
-- 
2.43.0


