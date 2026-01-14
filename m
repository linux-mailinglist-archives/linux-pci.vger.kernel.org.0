Return-Path: <linux-pci+bounces-44744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEE4D1F989
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9B4A301F002
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09830310627;
	Wed, 14 Jan 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px2xsAto"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339030EF63
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402790; cv=none; b=bAZiGo5d2pEEqvGdLbh+M4HrdxOPctRGsbopQDsfsWiy/m9Q7/S7aySK9gxVy2jQhnoboJZqMSkcryokc7PW4RkdkkQZZ13PPQ+KdTrI8jbI8Yh2pKN5aHhHSTZAhgflJEqD0jCEvPOEOf2E4RdaNFu5SY3PD03vwBIYsxDNo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402790; c=relaxed/simple;
	bh=nhskeqiX7/T8CC2ivhnoBGKXvyqmoOI51D89Di8rLQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooFYtCsO1/hn/jEjXWLhI9pit3sNq1084Wp6cIhyxIlhMsjCZmWBLk1mmHCPdvkDylEXDLkXMH/0tu3QIutkblawQryyDTTF8Uv0zrI1Z4EZyQClC8wb6oCdGTo5GnoVuPjtoVauCLRlfztTGwfPvDLmrM/yCOoLqtyAR9Cu6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px2xsAto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491FC19423;
	Wed, 14 Jan 2026 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768402790;
	bh=nhskeqiX7/T8CC2ivhnoBGKXvyqmoOI51D89Di8rLQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Px2xsAtoCcaw35CbanmeD8VQ1SJDAwYp/DYLskqrUQb8hCPjaYDfb8h6FFEmrCcq5
	 hBs7elZSMRrh++yozf5scok3ZB8pGxyeDbi91fu9oeqYs7i/sfl34CBX+mpa6yLXCQ
	 CoaVB93dlpdsGxyJHJfyCtV1GzCznakPpGbl7i04xvXdqcIuFjhm65AwSDOJpb2W51
	 wJr/K/cUKjGW1j9lMPFUMWEE7r7gz73nUVgdDTictJnih0BzHtm93K/fieGKlW8L8N
	 smIt539wc+5FmHboJJkOXFYugRSBhmeVl2KKlHXF8XTr0KM0x31llgaoWQCSjpVwDA
	 fZSAqKnQmtcGA==
Date: Wed, 14 Jan 2026 20:29:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>, 
	mario.limonciello@amd.com, bhelgaas@google.com, rafael@kernel.org, kengyu@lexical.tw, 
	Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Enable Bus Master in pci_power_up()
Message-ID: <bmkf3rpj3v3kuxiv2zoxlj42izbfoktp2bhlya63nwolm2yker@mc6xguc27ttj>
References: <20260113205626.127337-1-superm1@kernel.org>
 <aWdnWpqWQjNYKfpV@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWdnWpqWQjNYKfpV@wunner.de>

On Wed, Jan 14, 2026 at 10:52:26AM +0100, Lukas Wunner wrote:
> On Tue, Jan 13, 2026 at 02:56:14PM -0600, Mario Limonciello (AMD) wrote:
> > +++ b/drivers/pci/pci.c
> > @@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
> >  		return -EIO;
> >  	}
> >  
> > +	pci_set_master(dev);
> >  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> >  		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
> 
> So any device will be allowed to write to memory from the get-go?
> That sounds like a very bad idea.  For security reasons alone,
> we only want to enable bus mastering when needed.  It's up to
> the driver to enable it, not up to the PCI core.  We've had cases
> in the past where devices corrupted memory because BIOS left
> bus mastering enabled, see abb2bafd295f.  Enabling bus mastering
> for everything anytime will exacerbate such problems or uncover
> new ones.
> 

Indeed and it will pave the way for a big security hole as the PCI core will
then allow the device to perform DMA without setting up the address translation
and so on.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

