Return-Path: <linux-pci+bounces-30383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4EAE3FB0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890AA17C40B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE72512DE;
	Mon, 23 Jun 2025 12:13:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE402512C6
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680814; cv=none; b=icxo29b1teoOVcEXPmHPAFrbdWSSqJE2WgAOANudaw0a7V5jpijPFXxy4UZ7hToN2PIAkfP6SEjbGKHvKiaz0TA1XIY11/Bo8IBpx20By/wQGIYcEn22abwURadI/5El8JkT3Bf/dq59yTdBhv/atVT+7F4YifkPcgtt2HX/Gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680814; c=relaxed/simple;
	bh=3/GOAOJT8rpo10Olmg+Wib42M2iciJWGXEkXgWgrVOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuBqbo6JAowJ52nUxn8M+CC60p729VwNn1wsAyQwhkMNKxRaVmJLyr5DKA4Ej8VNnIXMYYVE/CPfs+AKvy35XnrvMVeq4QxPNOjF+f0K955FnMm5PcpP3Mw+4Xkne7wmp+SIhrrtklQEOWo4P+LsHI/gEw9XIjYzObCeV5O4w04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 43B75200918A;
	Mon, 23 Jun 2025 14:13:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3C83A1311A; Mon, 23 Jun 2025 14:13:29 +0200 (CEST)
Date: Mon, 23 Jun 2025 14:13:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: andreasx0 <andreasx0@protonmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [BUG] PCIe bwctrl warning on Lenovo 82XT with AMD Phoenix GPP
 Bridge
Message-ID: <aFlE6WkVZFP_jdSe@wunner.de>
References: <7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com>

[cc += Ilpo, Maciej; start of thread:
https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfppz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=@protonmail.com/
]

On Mon, Jun 23, 2025 at 11:54:02AM +0000, andreasx0 wrote:
> I am encountering a PCIe bandwidth control warning on my Lenovo 82XT
> laptop during boot with kernel version 6.15.3. The warning occurs
> inside the `pcie_set_target_speed()` function in the PCIe bwctrl
> driver and appears related to setting link speeds on AMD Phoenix
> GPP Bridge devices.

Thanks for the report.  If you apply the patch below, does the issue
go away?

-- >8 --

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
 

