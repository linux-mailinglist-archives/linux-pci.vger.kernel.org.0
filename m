Return-Path: <linux-pci+bounces-44124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34901CFB050
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 21:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE773112F14
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 20:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CCF33B6CB;
	Tue,  6 Jan 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKN5WRT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C02F1FDB;
	Tue,  6 Jan 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732485; cv=none; b=GnBrC8vdco/1xj5P+h38tTVYBut2e8E9NEbK7KKzZ4W3KgaAJhGTqnAjxnveoi7I48lJpETkXeY0dFRib4S0YpMJtMjvi4G9J+bwYnae+6n9jJhZUjebSmSXlgG+0s19YBNs8EgEWtHw63/0hIF5wOGsZcrUbM8zG0VD7A51z+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732485; c=relaxed/simple;
	bh=dDCYYxwCjnTp5eJKpZJFdL+PT+QIhoffKeRpn0jgZx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PB+u2AHsY/3Qg/LvS0bzet9xRXtok5EaKyosMIvbu07olU1Wj1ysoaXoQPrdVaZgl2Nd6iYEv5LdXG4Mo4TQaqoIATnSRi0p6uRZxf1sDDKYqQjxNs0Mtr821XwI5puuvwMWN7dGXBvO7b2ut3fwMfR/HwMAiQLTV4+eo+QRCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKN5WRT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDF8C116C6;
	Tue,  6 Jan 2026 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767732483;
	bh=dDCYYxwCjnTp5eJKpZJFdL+PT+QIhoffKeRpn0jgZx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZKN5WRT3Y6rEglJ3quEO/IH/pvID2xTrmAoaB2INSEQsHXScd92S1QqQt2BRpkrrc
	 5MOYOguOZ5HSFIK3co3iD0MyWGeCmEaecb9UD9Vbw2qanrRnpB0l+3SzurBSODd7tD
	 R9e7k5LblzpyAQJ69/bpXm0SA98K87Pqv6lv8eXNM5LHwG9Q1HuyFapSq7TwOGXziO
	 wce/pMqWwmWC9J6B64qfUwdb/druLFcPZIA27yzgN7G3bl5801vjE2pldf4v6jdtp9
	 pV8uS6hQaCPM45AZpE8DZZ2qIXwJAbXGP7+nXU5QWPd3epij2UfunXM7lxzCiKRivC
	 7+B1p7yMGlS3Q==
Date: Tue, 6 Jan 2026 14:48:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <20260106204801.GA374317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>

[+cc Thunderbolt folks]

On Tue, Jan 06, 2026 at 11:00:52AM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 1/6/2026 10:20 AM, Atharva Tiwari wrote:
> > Disable AER for Intel Titan Ridge 4C 2018
> > (used in T2 iMacs, where the warnings appear)
> > that generates continuous pcieport warnings. such as:
> > 
> > pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
> > pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> > pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
> > pcieport 0000:07:00.0:    [ 7] BadDLLP
> > 
> > (see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)
> > 
> > macOS also disables AER for Thunderbolt devices and controllers in
> > their drivers.
> 
> Why not disable it in BIOS or use noaer command line option?

If the kernel can figure this out by itself, we should do that so
users don't have to debug issues and figure out how to disable in BIOS
or use a command line option.

But if this is really a hardware issue, I would expect to see some
reports on the web, and I can't find AER reports that mention these
devices except this problem report.

Adding Thunderbolt folks in case they know about any errata.

> > Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> > ---
> >  drivers/pci/pcie/portdrv.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 38a41ccf79b9..5330a679fcff 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -240,7 +240,9 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> >  	    dev->aer_cap && pci_aer_available() &&
> > -	    (pcie_ports_native || host->native_aer))
> > +	    (pcie_ports_native || host->native_aer) &&
> > +	    !(dev->vendor == PCI_VENDOR_ID_INTEL &&
> > +		    (dev->device >= 0x15EA && dev->device <= 0x15EC)))
> >  		services |= PCIE_PORT_SERVICE_AER;
> >  #endif
> >  
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

