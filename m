Return-Path: <linux-pci+bounces-18589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B98E9F4820
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA611881E38
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA11DE891;
	Tue, 17 Dec 2024 09:55:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17181DB52D
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429342; cv=none; b=A08QJX2tA8YVrLYxIACBdMnXysWL9zaT7lUTBUqQn/ccK8JjJNy1ELuF5hZOjy9p4+hHhTtcs3mo1iafEaM7u51rXPsk8n5CbVsy97Ze+ffvFCFEeOG5C/AKntAXxud7NxKhVkBAvPO4TRv1oDtsFK+Ayl8Fg6sEqfWkVBqUtHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429342; c=relaxed/simple;
	bh=979Kl1IbLFtR3YNXGoL/h6/ny1vxH6uQFv6zBPO8PL4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rtH8yyhkzTt5mTP42wi1ijoHJ+Ixpqu8D6CHTh3vXD0JNmRF+jC/9owMBw6RGmaDqJG+IIssEko/CF2pKLuei/dueCm1abeUkWWP5jXfEhk/VxEODpcjQzdTcQnpb1w8bqr5orOOevAnlWAJjWKMsIcp2doDwsaipbjANbiDMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id F3B9F3000035F;
	Tue, 17 Dec 2024 10:55:36 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DF17010AA; Tue, 17 Dec 2024 10:55:36 +0100 (CET)
Message-Id: <fe03941e3e1cc42fb9bf4395e302bff53ee2198b.1734428762.git.lukas@wunner.de>
In-Reply-To: <cover.1734428762.git.lukas@wunner.de>
References: <cover.1734428762.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 17 Dec 2024 10:51:01 +0100
Subject: [PATCH for-linus v3 1/2] PCI: Honor Max Link Speed when determining
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
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>

The Supported Link Speeds Vector in the Link Capabilities 2 Register
indicates the *supported* link speeds.  The Max Link Speed field in the
Link Capabilities Register indicates the *maximum* of those speeds.

pcie_get_supported_speeds() neglects to honor the Max Link Speed field and
will thus incorrectly deem higher speeds as supported.  Fix it.

One user-visible issue addressed here is an incorrect value in the sysfs
attribute "max_link_speed".

But the main motivation is a boot hang reported by Niklas:  Intel JHL7540
"Titan Ridge 2018" Thunderbolt controllers supports 2.5-8 GT/s speeds,
but indicate 2.5 GT/s as maximum.  Ilpo recalls seeing this on more
devices.  It can be explained by the controller's Downstream Ports
supporting 8 GT/s if an Endpoint is attached, but limiting to 2.5 GT/s
if the port interfaces to a PCIe Adapter, in accordance with USB4 v2
sec 11.2.1:

   "This section defines the functionality of an Internal PCIe Port that
    interfaces to a PCIe Adapter. [...]
    The Logical sub-block shall update the PCIe configuration registers
    with the following characteristics: [...]
    Max Link Speed field in the Link Capabilities Register set to 0001b
    (data rate of 2.5 GT/s only).
    Note: These settings do not represent actual throughput. Throughput
    is implementation specific and based on the USB4 Fabric performance."

The present commit is not sufficient on its own to fix Niklas' boot hang,
but it is a prerequisite:  A subsequent commit will fix the boot hang by
enabling bandwidth control only if more than one speed is supported.

The GENMASK() macro used herein specifies 0 as lowest bit, even though
the Supported Link Speeds Vector ends at bit 1.  This is done on purpose
to avoid a GENMASK(0, 1) macro if Max Link Speed is zero.  That macro
would be invalid as the lowest bit is greater than the highest bit.
Ilpo has witnessed a zero Max Link Speed on Root Complex Integrated
Endpoints in particular, so it does occur in practice.

Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
Reported-by: Niklas Schnelle <niks@kernel.org>
Tested-by: Niklas Schnelle <niks@kernel.org>
Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


