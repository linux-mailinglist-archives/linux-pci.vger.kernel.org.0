Return-Path: <linux-pci+bounces-33265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F81B17C6E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 07:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029EF1C2181A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 05:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01101917E3;
	Fri,  1 Aug 2025 05:44:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4CAD4B;
	Fri,  1 Aug 2025 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754027076; cv=none; b=BjHCnOItPiUIRn8VtFvZXSsTSTKGloYomGdbfasYjl9uUkcYir8dkL332YkmdNyBOjf7KaSzywd/XkhKfIZctFTg18EHL8I8d1pC4nTi1HRXpOlwDiLW8x1ViEG06Lo4EqcbbfMm7S93ToQiIkz33ISeiW4m4dlb8HG5hMUil+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754027076; c=relaxed/simple;
	bh=RkCsCxuwv0+qxSCr9cyr4vDB1+qbUwftbbBFarELzfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqjVnaFQxa1pLyJxX9mdnl8giyo1GJxDrQohZX1bmimKxVW17qjKeJQYGgOLISHoqSk9eZilhRWgX/0EAMPsuHRFOKoWbFRuH68ZnbSSlUKL00MUZLhhBMdlcwN/5albZWXDw7llrueyDXHeDcGtXQ3ncwxVQ3wDdiqRNKBfL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 69F252012A16;
	Fri,  1 Aug 2025 07:44:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3BF1B38CA21; Fri,  1 Aug 2025 07:44:14 +0200 (CEST)
Date: Fri, 1 Aug 2025 07:44:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI/AER: Fix missing uevent on recovery when a
 reset is requested
Message-ID: <aIxULlDfQw4yhFDv@wunner.de>
References: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
 <20250730-add_err_uevents-v3-1-540b158c070f@linux.ibm.com>
 <aIp6LiKJor9KLVpv@wunner.de>
 <aIp_Z9IdwSjMtDho@wunner.de>
 <aItpKIhYr0T8jf7A@wunner.de>
 <4969c441-fe2a-470f-9efd-4661efca56ec@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4969c441-fe2a-470f-9efd-4661efca56ec@linux.intel.com>

On Thu, Jul 31, 2025 at 10:04:38AM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 7/31/25 6:01 AM, Lukas Wunner wrote:
> > +++ b/drivers/pci/pcie/err.c
> > @@ -165,6 +165,12 @@ static int report_resume(struct pci_dev *dev, void *data)
> >   	return 0;
> >   }
> > +static int report_disconnect(struct pci_dev *dev, void *data)
> > +{
> > +	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> > +	return 0;
> > +}
> 
> Since you are notifying the user space, I am wondering whether the drivers
> should be notified about the recovery failure?

The drivers are usually *causing* the recovery failure by returning
PCI_ERS_RESULT_DISCONNECT from their pci_error_handlers callbacks
(or by lacking pci_error_handlers, in particular ->error_detected()).

So in principle the drivers should be aware of recovery failure.

There are cases where multiple drivers are involved.  E.g. on GPUs,
there's often a PCIe switch with a graphics device and various sound
or telemetry devices.  Typically errors are reported by the Upstream
Port, so the Secondary Bus Reset occurs at the Root or Downstream Port
above the Upstream Port and affects the switch and all subordinate
devices.  In cases like this, recovery failure may be caused by a
single driver (e.g. GPU) and the other drivers (e.g. telemetry) may
be unaware of it.

The recovery flow documented in Documentation/PCI/pci-error-recovery.rst
was originally conceived for EEH and indeed EEH does notify all drivers
of recovery failures by invoking the ->error_detected() callback with
channel_state pci_channel_io_perm_failure.  See this call ...

	eeh_pe_report("error_detected(permanent failure)", pe,
		      eeh_report_failure, NULL);

... in arch/powerpc/kernel/eeh_driver.c below the recover_failed label
in eeh_handle_normal_event().

I don't know why pcie_do_recovery() doesn't do the same on recovery
failure.  This is one of several annoying deviations between AER and
EEH.  Ideally the behavior should be the same across all platforms
so that drivers don't have to cope with platform-specific quirks.

However I think that's orthogonal to the pci_uevent_ers() invocation
in pcie_do_recovery().

Thanks,

Lukas

