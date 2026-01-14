Return-Path: <linux-pci+bounces-44724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FDCD1DCFC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 476A330051B5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6438737F;
	Wed, 14 Jan 2026 10:02:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5A343D7D
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384953; cv=none; b=O/nPwVuoW8TPnVjn+WCStCpZG/8TGUCOVADuJqWt9jzbBg4uAMVC9rRgNqUMkjFZiJt2t7UjUphGgLb2gbicIIfh7uIi1S2Qd09Gvm7rwZadDt9VaqF3Qszn6M3YJTJlrb8rbYcTaVhroIGn0F1Cvga+5bKYZQIQIdOLBdOF9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384953; c=relaxed/simple;
	bh=jTDeLIMk9eFOo9dCqHZ6se8hfrqn1AuttHelHiT5gss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP01xxtg/G59xidD+TiAHyNEkBqHqmt48D9gjwba4i2g3xvq+9G1p1Xltem46ZBO5XVJw+7vQuaN+/Ma855UPXsiK3j8QxHugObUcgL+IFI6W48rI/INSkcvb/uDS8qc7eglkmP0iBGvdHR607BPPedAMM48enzrMmZ0oHr71ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D5E8F2C000AD;
	Wed, 14 Jan 2026 10:52:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B14431928; Wed, 14 Jan 2026 10:52:26 +0100 (CET)
Date: Wed, 14 Jan 2026 10:52:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org,
	kengyu@lexical.tw, Matthew Ruffell <matthew.ruffell@canonical.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Enable Bus Master in pci_power_up()
Message-ID: <aWdnWpqWQjNYKfpV@wunner.de>
References: <20260113205626.127337-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113205626.127337-1-superm1@kernel.org>

On Tue, Jan 13, 2026 at 02:56:14PM -0600, Mario Limonciello (AMD) wrote:
> +++ b/drivers/pci/pci.c
> @@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
>  		return -EIO;
>  	}
>  
> +	pci_set_master(dev);
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>  		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",

So any device will be allowed to write to memory from the get-go?
That sounds like a very bad idea.  For security reasons alone,
we only want to enable bus mastering when needed.  It's up to
the driver to enable it, not up to the PCI core.  We've had cases
in the past where devices corrupted memory because BIOS left
bus mastering enabled, see abb2bafd295f.  Enabling bus mastering
for everything anytime will exacerbate such problems or uncover
new ones.

Thanks,

Lukas

