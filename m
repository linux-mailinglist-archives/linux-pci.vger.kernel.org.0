Return-Path: <linux-pci+bounces-18454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE99F2328
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 11:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3104E1884BA9
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0FF36124;
	Sun, 15 Dec 2024 10:33:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E090814263
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734258809; cv=none; b=NqvN5JLw3q1jrWapRJoJxwp2ho+jiXVq5FOm5yu0nSLA5G3S8f78CxDJPgtZPCZ5371DZhjc40XZwgDf/a/I3EuaWSO5Nvt9I89mYbQ99s6Z7RfVauGdqlekZLjqRCHQScIAxvYCRlKndAuCb20ZiAj80aVPDbjgVmZ8QFqXKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734258809; c=relaxed/simple;
	bh=S++7ZrTlPYNdgzCgM9hV3GVnQFP/LB6nPqC//qTjKh8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=CrUe2DQSGRdoewcLlsXWi3X0WlFdzG5v5XvdF/r5X4avFDTqzkJ7eRCBL20m8biwKCfOQp3IEX4X/anL/nf42NISwfn4EHZ9Bg8Zooi0I7mqBEsmSvlNepiTYCXSWiKPr5FJdaiaL+VJOKeDG4XKop3qefkO/b7b64pp4IKo5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id BCB0B100E2020;
	Sun, 15 Dec 2024 11:33:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 872053D6A2C; Sun, 15 Dec 2024 11:33:19 +0100 (CET)
Message-ID: <2292e75dcf26f1c6d7c1f715edfe0e49f079149d.1734257330.git.lukas@wunner.de>
In-Reply-To: <cover.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Dec 2024 11:20:53 +0100
Subject: [PATCH for-linus v2 3/3] PCI/bwctrl: Enable only if more than one
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
Closes: https://lore.kernel.org/r/db8e457fcd155436449b035e8791a8241b0df400.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/portdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5e10306b6308..02e73099bad0 100644
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


