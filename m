Return-Path: <linux-pci+bounces-32405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAFFB08ECA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70451A65BAE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D02EBDFE;
	Thu, 17 Jul 2025 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emQ2UBoJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D21DE4E1;
	Thu, 17 Jul 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761040; cv=none; b=bOqDH3qHpjRLRKwPz3nCc2vpi8KEK+gZeHw6ORzHEbQvYEhq3DHPxc259vuEzab3Gt2xu0AJMbrNF9leksgMeLl1qzcGdXh62ltaQlbunz6CMLiv6qOs3BjkZkldk+vV9r9lxJMbTOlP6QRKRITaCzVfCnFKZ2eAdiv6CMSePss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761040; c=relaxed/simple;
	bh=HrJIUDz1/gSmosfV/HzJVV1oKci8biWIk6gmLw60auQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTh8Gz7OQf9O6x5IN4+MHP6IecdG0OGt8fhI0X87io4fdqQY9uI1CYfViFSx228Bkwq3Vvh7PtOXJBvOPsVcHoEQ8nKn2/vcZbxaAXlqbsN+k8bCpC8bQZZDEhg510DXj229Jan6h3ZPQAgxvH6eSPeMn6QWnxHriuwdCphY+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emQ2UBoJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752761039; x=1784297039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HrJIUDz1/gSmosfV/HzJVV1oKci8biWIk6gmLw60auQ=;
  b=emQ2UBoJAgZiognoA5iuxLU/3F2c6hPV8lOz1rsJF+17a5O8Y6OMWBUN
   zn+j72OSxjlO6mfti9DmizlrbSeLm+crM4XVxFpM+JptxVdix2PNmra8H
   M1jM3SQEwtmK6WzMOGBVhSW9tGUCspaqaJQeY77zU8vs4hVece9tt8EIb
   NrVZm6WPmcGKWpCFPgJelmyJgbFEpoygBmQUpeH8CPItKpewSfiKstqrj
   JTM+V/JrAWl6Zgq+OUMqOYhD3j9AF5QSqijNig3MBUUQpeU5pVxaCK5JD
   HPGgp9vffQF83WFa9WuSsVRbfuHBIZygCyVgPZrg8HzHlsOPt2OTEo1Pq
   w==;
X-CSE-ConnectionGUID: QgF6RgxRRVicVZ+jzMQwvA==
X-CSE-MsgGUID: eLG2i7P2S9iQREX61Gb2MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="72491404"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="72491404"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:03:44 -0700
X-CSE-ConnectionGUID: 03/QImsWRR2VX+pNyYVvfA==
X-CSE-MsgGUID: aYTLMBLmSrKPvInme1Wr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158266085"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO localhost) ([10.124.220.193])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:03:44 -0700
Date: Thu, 17 Jul 2025 07:03:42 -0700
From: David Box <david.e.box@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Kenneth R. Crudup" <kenny@panix.com>, rafael@kernel.org, 
	bhelgaas@google.com, vicamo.yang@canonical.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
Message-ID: <gulatdqqxkdc4oafmqoqiyf2f6gzlk2nfxhy3l5yxx4oyxgppf@mhsmuq4xansa>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
 <7a229e18-fbfd-8652-ec2e-a3a3273f7fac@panix.com>
 <l2rk6omhgysf55ee227ju2z5zyen6mksyl3lu37jwfabg45j3w@4cf7wxehxhv6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l2rk6omhgysf55ee227ju2z5zyen6mksyl3lu37jwfabg45j3w@4cf7wxehxhv6>

On Thu, Jul 17, 2025 at 12:27:47PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 16, 2025 at 11:12:45PM GMT, Kenneth R. Crudup wrote:
> > 
> > Unfortunately, having tested the patch (against Linus' master), it doesn't work.
> > 
> > I don't think the ASPM(?) state is making it to the VMD.
> > 
> 
> Because, the VMD driver is not at all setting the PCI_BUS_FLAGS_NO_ASPM_DEFAULT
> flag.

Correct. I forgot to set the flag in the VMD driver. Other this approach
should have worked.

David

> But I proposed an alternate method [1] to enable ASPM which would avoid
> using the flag.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr/
> 
> > LMK if you need more info.
> > 
> > -Kenny
> > 
> > On Wed, 16 Jul 2025, David E. Box wrote:
> > 
> > > Testing is appreciated as I didn't get a chance to do so yet but plan to.
> > 
> > > Thanks, David
> > >
> > > ---
> > >
> > > David E. Box (2):
> > >   PCI/ASPM: Allow drivers to provide ASPM link state via pci_bus
> > >   PCI: vmd: Provide default ASPM link state for synthetic hierarchy
> > >
> > >  drivers/pci/controller/vmd.c |  7 +++++--
> > >  drivers/pci/pcie/aspm.c      |  5 ++++-
> > >  include/linux/pci.h          | 12 ++++++++----
> > >  3 files changed, 17 insertions(+), 7 deletions(-)
> > >
> > >
> > > base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> > >
> > 
> > -- 
> > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

