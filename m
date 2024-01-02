Return-Path: <linux-pci+bounces-1612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249B78224FC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EA1F22EA0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C26171DB;
	Tue,  2 Jan 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM9f7rxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1F17725;
	Tue,  2 Jan 2024 22:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09423C433C8;
	Tue,  2 Jan 2024 22:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704236009;
	bh=y3QfViECwSvCP5PWgn4nsZ+h/meHzbUW3g8chYX9B0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gM9f7rxmbf2g4oOEk1jl2tI131isEWELUlX7/IufEKlJuj1ctmz2DmV49+mQkbav7
	 vSmBOFtfgQIqB0bEK177Rnhyv+OULwu5PTMKXyuyAFRnoFq/QovTzreVkhlfsjrXLO
	 FZQSLgfHwaHqRy8yPBddoekFb4bGYM0suXf9R5XEmbUIAgQ3R65oaKrLljFn0ENrG7
	 3ukR9SjQZzl87BzqPYHaaTnlpm8x7Btiq5eT6LQj9kYr4uBg2t8YagZ2bLdQRBWpzF
	 ZIj0Bq3WCa5cIx3YJ8/HYQE9kkmWqdR/XLyuwxLd3S/RnjVqcPcuNlhX+JNz8fkf/G
	 0Fs/sQpdYeaFg==
Date: Tue, 2 Jan 2024 16:53:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/AER: Decode Requester ID when no error info found
Message-ID: <20240102225327.GA1739520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc6adf0-e82d-4429-9e76-5fef7dda2d95@linux.intel.com>

On Tue, Jan 02, 2024 at 11:22:53AM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 12/6/2023 2:42 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > When a device with AER detects an error, it logs error information in its
> > own AER Error Status registers.  It may send an Error Message to the Root
> > Port (RCEC in the case of an RCiEP), which logs the fact that an Error
> > Message was received (Root Error Status) and the Requester ID of the
> > message source (Error Source Identification).
> > 
> > aer_print_port_info() prints the Requester ID from the Root Port Error
> > Source in the usual Linux "bb:dd.f" format, but when find_source_device()
> > finds no error details in the hierarchy below the Root Port, it printed the
> > raw Requester ID without decoding it.
> > 
> > Decode the Requester ID in the usual Linux format so it matches other
> > messages.
> > 
> > Sample message changes:
> > 
> >   - pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
> >   - pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> >   + pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
> >   + pcieport 0000:00:1c.5: AER: found no error details for 0000:00:1c.5
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Except for the suggestion given below, it looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks for taking a look!

> > @@ -740,7 +740,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> >  	u8 bus = info->id >> 8;
> >  	u8 devfn = info->id & 0xff;
> >  
> > -	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> > +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> >  		 info->multi_error_valid ? "Multiple " : "",
> >  		 aer_error_severity_string[info->severity],
> >  		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> > @@ -929,7 +929,12 @@ static bool find_source_device(struct pci_dev *parent,
> >  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> >  
> >  	if (!e_info->error_dev_num) {
> > -		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
> > +		u8 bus = e_info->id >> 8;
> > +		u8 devfn = e_info->id & 0xff;
> 
> You can use PCI_BUS_NUM(e_info->id) for getting bus number.  Since
> you are extracting this info in more than one place, maybe you can
> also define a macro PCI_DEVFN(id) (following PCI_BUS_NUM()).

Thanks, both good ideas.

We already have a PCI_DEVFN() that *combines* slot + func into devfn,
so we'd have to come up with a different name.

I'll add a patch to use PCI_BUS_NUM() in the two places here and in
pme.c.

I think I'll wait with these until after the v6.7 release.

> > +		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> > +			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> > +			 PCI_FUNC(devfn));
> >  		return false;
> >  	}
> >  	return true;
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

