Return-Path: <linux-pci+bounces-18453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A809F2327
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2463918865B2
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A956B81;
	Sun, 15 Dec 2024 10:28:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAF320E
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734258527; cv=none; b=ME6CN0hibBj106bG0wQLENTUVYzLgAlsZrI6tnWWSbabe61bESGsbOJ7ZA4MfXLdh+jMjKjHDS1ElL1h1tSjfbF487eQh+ir8CDbWBOBstMt5lqkJ/9Jn6at3YqsIWHcDAWBce8oMPjqv9osAT7it2aKs9ypMKp6M/aAkUlQiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734258527; c=relaxed/simple;
	bh=9ehiABYxiI4eRXAS6TyK6068SM12XaHvZ1mG3J+trpg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=IfPQkeu3z2HlQH7N3YlAzEqru34vpP3uHYLwBb4Nv8EGryu3X9+UqrAyE9py5otNJatlj5HRkzu8Bx+GqDXX8pI7uCjN3mT71xg6gpRW7gk789oJZ6TfrXcisdZGKbHAvlIxxPYy4ndp6RIdMiODFvq0qSuZWI89c1i3tvp3tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7F8383000D7A4;
	Sun, 15 Dec 2024 11:28:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 665F7356243; Sun, 15 Dec 2024 11:28:42 +0100 (CET)
Message-ID: <0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
In-Reply-To: <cover.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Dec 2024 11:20:52 +0100
Subject: [PATCH for-linus v2 2/3] PCI: Honor Max Link Speed when determining
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
indicates the *supported* link speeds.  The Max Link Speed field in
the Link Capabilities Register indicates the *maximum* of those speeds.

pcie_get_supported_speeds() neglects to honor the Max Link Speed field
and will thus incorrectly deem higher speeds as supported.  Fix it.

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
but it is a prerequisite.

Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
Reported-by: Niklas Schnelle <niks@kernel.org>
Closes: https://lore.kernel.org/r/70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ab0ef7b6c798..9f672399e688 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6247,6 +6247,10 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
 
+	/* Ignore speeds higher than Max Link Speed */
+	speeds &= GENMASK(lnkcap & PCI_EXP_LNKCAP_SLS,
+			  PCI_EXP_LNKCAP2_SLS_2_5GB);
+
 	/* PCIe r3.0-compliant */
 	if (speeds)
 		return speeds;
-- 
2.43.0


