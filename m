Return-Path: <linux-pci+bounces-18452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8ED9F2326
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174E4163D31
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35156B81;
	Sun, 15 Dec 2024 10:25:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5848320E
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734258349; cv=none; b=g9/TSaaceJTprNouksFd7iqNWknWzxbycTyOHOoDbTtkgqQAyATc7itqIGzUjh9OGOC2AG5nxg30RoRoz1vINUici2M8ekvQdL24JH+YXxlFwaSCDsDZ16RIpSb7PMppEJrAXU56lfJci1zCGTz6vex3sfqucJk17k3nrWaIMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734258349; c=relaxed/simple;
	bh=oWpU5prI21m4cP+NKLzxEDgdeezpsvRNbUyd64mu8QQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=coJQC/2Kn1TMIVw99pbD1QiZitVx/NopPZjcgqtGAwyW+x35mfUPd9QB1g7vGzSLE6p2gAzPF2DDUSY77nt5yXJiaPJOL8ybsBQUI+qbPvuQaAJPbPpc9OFfRDf8QB36/WmHH4LCu6Z1Df3Jcp5vs5RYni1waWNjJDMuDHeRH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3140E2800B485;
	Sun, 15 Dec 2024 11:25:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1EAAA440FDE; Sun, 15 Dec 2024 11:25:37 +0100 (CET)
Message-ID: <1a07f35cdfda64ca1d5154cc85ca1dd5f01137d3.1734257330.git.lukas@wunner.de>
In-Reply-To: <cover.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Dec 2024 11:20:51 +0100
Subject: [PATCH for-linus v2 1/3] PCI: Assume 2.5 GT/s if Max Link Speed is
 undefined
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Niklas Schnelle <niks@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Mario Limonciello <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Broken PCIe devices may not set any of the bits in the Link Capabilities
Register's "Max Link Speed" field.  Assume 2.5 GT/s in such a case,
which is the lowest possible PCIe speed.  It must be supported by every
device per PCIe r6.2 sec 8.2.1.

Emit a message informing about the malformed field.  Use KERN_INFO
severity to minimize annoyance.  This will help silicon validation
engineers take note of the issue so that regular users hopefully never
see it.

There is currently no known affected product, but a subsequent commit
will honor the Max Link Speed field when determining supported speeds
and depends on the field being well-formed.  (It uses the Max Link Speed
as highest bit in a GENMASK(highest, lowest) macro and if the field is
zero, that would result in GENMASK(0, lowest).)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35dc9f249b86..ab0ef7b6c798 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6233,6 +6233,13 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
 	u32 lnkcap2, lnkcap;
 	u8 speeds;
 
+	/* A device must support 2.5 GT/s (PCIe r6.2 sec 8.2.1) */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (!(lnkcap & PCI_EXP_LNKCAP_SLS)) {
+		pci_info(dev, "Undefined Max Link Speed; assume 2.5 GT/s\n");
+		return PCI_EXP_LNKCAP2_SLS_2_5GB;
+	}
+
 	/*
 	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
 	 * Speeds Vector to allow using SLS Vector bit defines directly.
@@ -6244,8 +6251,6 @@ u8 pcie_get_supported_speeds(struct pci_dev *dev)
 	if (speeds)
 		return speeds;
 
-	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
-
 	/* Synthesize from the Max Link Speed field */
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
 		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
-- 
2.43.0


