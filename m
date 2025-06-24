Return-Path: <linux-pci+bounces-30500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B82DAE64C4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00AF1897BBD
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90428ECD8;
	Tue, 24 Jun 2025 12:19:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0CE291C08
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767578; cv=none; b=P6gRIE0q+pTt5yUshPnroBQWZ9hmsgl34akaUf74mHwu3hlZ1wPY/AOtPG/TOrx20Mxlg+o8MrugUri17hRoLZjRerdK+f0myZCKT6OH1xMWP3ZlYaMGCoF0AoIEkOtKdS2Rttq87eq1O5zp6rBdcjlzmLsg3zTx7qFFsxHUk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767578; c=relaxed/simple;
	bh=YwQs3e7I6ld0fd+x60RDAf8xJdj+0o6jSXZzd5r+roo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ01EQtRouAZnuX8R1FzngVJvq0wzzk/TVQFaAokvwe/qV6PWsODkH6EUgnNNL3Ux2W0204vMOc0iVlqWDE9+R2hbplVXHWn9+5GIxqKWquhjWQRttar4aCKXQOuH0fsvixsc1VpvsdhKa2DPcFR4984XeCGqUUkoB2CHkZ4VEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4DF0220091B9;
	Tue, 24 Jun 2025 14:19:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2E0403B7038; Tue, 24 Jun 2025 14:19:27 +0200 (CEST)
Date: Tue, 24 Jun 2025 14:19:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andrew <andreasx0@protonmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
Message-ID: <aFqXz8llC2gYl5XJ@wunner.de>
References: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>
 <78b87a33-3e46-aabd-3f88-db5c1130c20c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78b87a33-3e46-aabd-3f88-db5c1130c20c@linux.intel.com>

On Tue, Jun 24, 2025 at 02:23:33PM +0300, Ilpo Järvinen wrote:
> On Mon, 23 Jun 2025, Lukas Wunner wrote:
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
> >  	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
> >  	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> >  	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
> > -		u16 oldlnkctl2 = lnkctl2;
> > +		u16 oldlnkctl2 = lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> >  
> >  		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
> 
> IIRC, there was a patch from somebody else which fixed this a bit 
> differently but never got applied (many months ago by now).

Must be this one, still marked "New" in patchwork:

https://patchwork.kernel.org/project/linux-pci/patch/20250123055155.22648-2-sjiwei@163.com/

I don't care which one gets applied, as long as the issue is fixed.

Thanks,

Lukas

