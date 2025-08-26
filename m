Return-Path: <linux-pci+bounces-34717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA61B3549D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240F11B65ADE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1352F60C1;
	Tue, 26 Aug 2025 06:27:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D882F549D;
	Tue, 26 Aug 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189671; cv=none; b=F0lG6GjQM3Lwtx1ZchWnw3DUrc+CH/FmsEgeNAAIOAhcqPeLRccmofN5tEcV1p/ABCqufIB4XItBqnj8a4KzlCBWTGYzGyH10jEzYMpfOJpzqphAy/dakhnLWV9cuDqpDU5TLFMiCiXAtALrL2zjG4qQl/g/krQQo1nZzFbainE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189671; c=relaxed/simple;
	bh=eJdhr9QAnQbhJigRdWkMkHg67d1ZyhomMniXPLkN5oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU9PlcVP/9Xa6AexRQzmjyghMkq5HNyD9U2LiI1qL/bV4oykxEf91i/uf0iNah7fMuJsTA/N6dofhAZ53M8mlx5bIgxwIj+wt6ZppcwnKeUtTau6p0OP5kzNTFeKWpxFH+bmU3DKTsXPCKV2cF4ufTk+oh8OekftWI1k9K8VT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4063C2C05262;
	Tue, 26 Aug 2025 08:21:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 16EC962C37; Tue, 26 Aug 2025 08:21:24 +0200 (CEST)
Date: Tue, 26 Aug 2025 08:21:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
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
Subject: Re: [PATCH v5 0/3] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Message-ID: <aK1SZGJBjrOx0s6y@wunner.de>
References: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
 <20250814210201.GA348169@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814210201.GA348169@bhelgaas>

On Thu, Aug 14, 2025 at 04:02:01PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 07, 2025 at 03:55:37PM +0200, Niklas Schnelle wrote:
> > Niklas Schnelle (3):
> >       PCI/AER: Fix missing uevent on recovery when a reset is requested
> >       PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI recovery
> >       powerpc/eeh: Use result of error_detected() in uevent
> > 
> >  arch/powerpc/kernel/eeh_driver.c | 2 +-
> >  arch/s390/pci/pci_event.c        | 3 +++
> >  drivers/pci/pci-driver.c         | 3 ++-
> >  include/linux/pci.h              | 2 +-
> >  4 files changed, 7 insertions(+), 3 deletions(-)
> 
> Applied on pci/aer for v6.18, thanks!  This on top of Lukas's series:
> 
>   https://lore.kernel.org/all/cover.1755008151.git.lukas@wunner.de/
> 
> Expect the whole branch to be rebased to add Reviewed-by, etc.

In case it helps, these are all the tags that were offered for my series
and that haven't been added to the pci/aer branch yet:

d0a2dee7d458 PCI/AER: Allow drivers to opt in to Bus Reset on Non-Fatal Errors
  Reviewed-by: Linas Vepstas <linasvepstas@gmail.com>
  https://lore.kernel.org/r/CAHrUA34fVV48MShC4CrXSmveR9i8MC4KAQxtM+XQY_Ao8joBQw@mail.gmail.com/
  Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
  https://lore.kernel.org/r/8491adbd-d8e8-465a-971e-3fe50e2561b1@linux.intel.com/

1cbc5e25fb70 PCI/ERR: Fix uevent on failure to recover
  Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
  https://lore.kernel.org/r/f0b59604-ae4d-4afe-8522-a8fbe5568e96@linux.intel.com/
  Reviewed-by: Linas Vepstas <linasvepstas@gmail.com>
  https://lore.kernel.org/r/CAHrUA34fVV48MShC4CrXSmveR9i8MC4KAQxtM+XQY_Ao8joBQw@mail.gmail.com/
  Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
  https://lore.kernel.org/r/a4419480c3d494a5940e87fea0c7b9864dc3e85b.camel@linux.ibm.com/

9011f0667c93 PCI/ERR: Notify drivers on failure to recover
  Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
  https://lore.kernel.org/r/fa9f42ab-bced-4c7f-9977-c0b611e92e2e@linux.intel.com/
  Reviewed-by: Linas Vepstas <linasvepstas@gmail.com>
  https://lore.kernel.org/r/CAHrUA34fVV48MShC4CrXSmveR9i8MC4KAQxtM+XQY_Ao8joBQw@mail.gmail.com/

45bc82563d55 PCI/ERR: Update device error_state already after reset
  Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
  https://lore.kernel.org/r/004298f7-ae08-428e-9b98-995fc56e55b1@linux.intel.com/
  Reviewed-by: Linas Vepstas <linasvepstas@gmail.com>
  https://lore.kernel.org/r/CAHrUA34fVV48MShC4CrXSmveR9i8MC4KAQxtM+XQY_Ao8joBQw@mail.gmail.com/

cc4a7a21e815 PCI/ERR: Remove remnants of .link_reset() callback
  Reviewed-by: Linas Vepstas <linasvepstas@gmail.com>
  https://lore.kernel.org/r/CAHrUA34fVV48MShC4CrXSmveR9i8MC4KAQxtM+XQY_Ao8joBQw@mail.gmail.com/
  Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
  https://lore.kernel.org/r/59308229-24ed-4b8a-b398-cc47c61dfc47@linux.intel.com/
  Reviewed-by: Justin Tee <justin.tee@broadcom.com>
  https://lore.kernel.org/r/CABPRKS_Ut8Z+rvM4+-E0YvEwUKbMb0SDpLBdH+g1sYEh+YcxFA@mail.gmail.com/

Thanks!

Lukas

