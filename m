Return-Path: <linux-pci+bounces-28113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6417ABDCFE
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270E83BC6FF
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E556246789;
	Tue, 20 May 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU5ssl0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DA2907;
	Tue, 20 May 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750876; cv=none; b=MV4m6Ve4WVyM6dTnUOLeDL+p1X7KC/siBvply1Mp/uLdcCvczK9w1cxsbEF33WrD/QnxoOOYl7cgWtkJ1eedLk4SbhcBYSBvcJE3jOkLdi4i8GBRwSTgglmGLcwEFsVFko9I/Lg+QtQjb+A6KaZya+U5t+Bv+yjvKE7hN2aRZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750876; c=relaxed/simple;
	bh=KubO1CN0cU7o39gPvS/zjAe4RGBlujJ7735E92PJluk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rNOqkl2hBmtfUpyG64ObTtPcLF49iRz4eptV4Hya1xKXPtEx11aM5/XSm2J5E40YDOEAyRSSO5pdle0QVmOafedFjxXYXmfFjXipM1Isxnb5U2mo1kBj1KlvE2bNbYp+6LZapYURoow4SAQIDLashVOCnNYrgpbC0YQLULbHzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rU5ssl0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80716C4CEEB;
	Tue, 20 May 2025 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750874;
	bh=KubO1CN0cU7o39gPvS/zjAe4RGBlujJ7735E92PJluk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rU5ssl0o/icooknJ+V0VLF0QrTzQlME5sLQCs6lH/lEu1SNKh9yHPTLxxrIYDnvqG
	 P2ybIatUaHLJ1DIl+pLWpXdeaokUAbBUYS4TM64YZ11s6MnCjOmmTB7mAaVW4H2lDu
	 2+5Nm5bMQkwAgZIlYvcJCrzAF8c97spGVd994c4JAKDBlc3HyGuHexQBN9RYva7R39
	 J13iEjIcZJDkgg1yKOC0lQyr6uTUa+TSRNCkJtJWCsyO+TGoLOQ2sSVSpfPQ7iKvk2
	 bktQXT267hlYsa5UgXfPj/e63H/tO8jwtrMbiWV9No2IK12fUZ/+jnFHEb+nCgv+i9
	 ouNjOFWBVT2NA==
Date: Tue, 20 May 2025 09:21:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 03/16] PCI/AER: Consolidate Error Source ID logging in
 aer_print_port_info()
Message-ID: <20250520142113.GA1292100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac2bb02-974f-4952-b069-1bcc94682d89@linux.intel.com>

On Mon, May 19, 2025 at 04:39:19PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously we decoded the AER Error Source ID in two places.  Consolidate
> > them so both places use aer_print_port_info().  Add a "details" parameter
> > so we can add a note when we didn't find any downstream devices with errors
> > logged in their AER Capability.
> > 
> > When we didn't read any error details from the source device, we logged two
> > messages: one in aer_isr_one_error() and another in find_source_device().
> > Since they both contain the same information, only log the first one when
> > when find_source_device() has found error details.
> /s/when//

Fixed, thanks!

> > -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> > +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
> 
> Instead of relying on the callers, why not add a space before details here?

Could, but I don't like adding an extra space at the end of the line
when the caller passes "".  The extra space could make the line wrap
unnecessarily.

> >   		 info->multi_error_valid ? "Multiple " : "",
> >   		 aer_error_severity_string[info->severity],
> >   		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> > -		 PCI_FUNC(devfn));
> > +		 PCI_FUNC(devfn), details);
> >   }
> >   #ifdef CONFIG_ACPI_APEI_PCIEAER
> > @@ -926,13 +927,13 @@ static bool find_source_device(struct pci_dev *parent,
> >   	else
> >   		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> > +	/*
> > +	 * If we didn't find any devices with errors logged in the AER
> > +	 * Capability, just print the Error Source ID from the Root Port or
> > +	 * RCEC that received an ERR_* Message.
> > +	 */
> >   	if (!e_info->error_dev_num) {
> > -		u8 bus = e_info->id >> 8;
> > -		u8 devfn = e_info->id & 0xff;
> > -
> > -		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> > -			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> > -			 PCI_FUNC(devfn));
> > +		aer_print_port_info(parent, e_info, " (no details found)");
> >   		return false;
> >   	}
> >   	return true;
> > @@ -1297,10 +1298,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
> >   			e_info.multi_error_valid = 1;
> >   		else
> >   			e_info.multi_error_valid = 0;
> > -		aer_print_port_info(pdev, &e_info);
> 
> Instead of printing the error information in find_source_device() (a helper function), I think it be better to print it here (the error handler). source_found = find_source_device(pdev, &e_info); aer_print_port_info(pdev, &e_info, source_found? "" : "(no details found) " );
> 
> if (source_found) aer_process_err_devices(&e_info)

Great idea, thanks!  That looks much nicer.

> > -		if (find_source_device(pdev, &e_info))
> > +		if (find_source_device(pdev, &e_info)) {
> > +			aer_print_port_info(pdev, &e_info, "");
> >   			aer_process_err_devices(&e_info);
> > +		}
> >   	}
> >   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> > @@ -1316,10 +1318,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
> >   		else
> >   			e_info.multi_error_valid = 0;
> > -		aer_print_port_info(pdev, &e_info);
> > -
> > -		if (find_source_device(pdev, &e_info))
> > +		if (find_source_device(pdev, &e_info)) {
> > +			aer_print_port_info(pdev, &e_info, "");
> >   			aer_process_err_devices(&e_info);
> > +		}
> >   	}
> >   }
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

