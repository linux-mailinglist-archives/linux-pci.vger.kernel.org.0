Return-Path: <linux-pci+bounces-18590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AA69F4827
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CE41690C7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC611DBB35;
	Tue, 17 Dec 2024 09:57:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B291DDA17
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429425; cv=none; b=q3w4HqCQwFur+mw3//waKnHHIYi0b268SAK+P/8NRVLW+l0LCj//AhZiYFtbYCyLPTCet+qOM5jg5NfaN0L93bF7W6X4zvlKfomWGTrsiLV59TvChJPEZ9q9dtykaqot539rSj2iT6HkFMDTUXYeN/EOu7UbvlIcjJ+/fvB7fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429425; c=relaxed/simple;
	bh=cgYaB+LcRZhW8+LNr0YorzWyLKv4yQpMtJ5kt85W8N4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=mQh9CQWH8uGKAYNUVp3HuMQAV5Wl/NA30F6xSeBkeHc1L1MFopqutT5teLOyaxFlPKGYe9PDX6t2ySefLQWjFIC9QFAXtCbCMXEVYBRETeZOCIEdCq8ByZD2lykzGnBdXwNYHTGA9+lkg3+BNyta7E3RLjECDwYgf3oORjGgUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5C8A1100DA1D6;
	Tue, 17 Dec 2024 10:56:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 41B785FFC19; Tue, 17 Dec 2024 10:56:55 +0100 (CET)
Message-Id: <3564908a9c99fc0d2a292473af7a94ebfc8f5820.1734428762.git.lukas@wunner.de>
In-Reply-To: <cover.1734428762.git.lukas@wunner.de>
References: <cover.1734428762.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 17 Dec 2024 10:51:02 +0100
Subject: [PATCH for-linus v3 2/2] PCI/bwctrl: Enable only if more than one
 speed is supported
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

If a PCIe port only supports a single speed, enabling bandwidth control
is pointless:  There's no need to monitor autonomous speed changes, nor
can the speed be changed.

Not enabling it saves a small amount of memory and compute resources,
but also fixes a boot hang reported by Niklas:  It occurs when enabling
bandwidth control on Downstream Ports of Intel JHL7540 "Titan Ridge 2018"
Thunderbolt controllers.  The ports only support 2.5 GT/s in accordance
with USB4 v2 sec 11.2.1, so the present commit works around the issue.

PCIe r6.2 sec 8.2.1 prescribes that:

   "A device must support 2.5 GT/s and is not permitted to skip support
    for any data rates between 2.5 GT/s and the highest supported rate."

Consequently, bandwidth control is currently only disabled if a port
doesn't support higher speeds than 2.5 GT/s.  However the Implementation
Note in PCIe r6.2 sec 7.5.3.18 cautions:

   "It is strongly encouraged that software primarily utilize the
    Supported Link Speeds Vector instead of the Max Link Speed field,
    so that software can determine the exact set of supported speeds on
    current and future hardware.  This can avoid software being confused
    if a future specification defines Links that do not require support
    for all slower speeds."

In other words, future revisions of the PCIe Base Spec may allow gaps
in the Supported Link Speeds Vector.  To be future-proof, don't just
check whether speeds above 2.5 GT/s are supported, but rather check
whether *more than one* speed is supported.

Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Reported-by: Niklas Schnelle <niks@kernel.org>
Tested-by: Niklas Schnelle <niks@kernel.org>
Closes: https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonthan.Cameron@huawei.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/portdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5e10306..02e7309 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -265,12 +265,14 @@ static int get_port_device_capability(struct pci_dev *dev)
 	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
+	/* Enable bandwidth control if more than one speed is supported. */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
 	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
 		u32 linkcap;
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
-		if (linkcap & PCI_EXP_LNKCAP_LBNC)
+		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
+		    hweight8(dev->supported_speeds) > 1)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 
-- 
2.43.0


