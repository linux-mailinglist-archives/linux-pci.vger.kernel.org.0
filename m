Return-Path: <linux-pci+bounces-38471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A00BE8C5A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73CFD4EE638
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0571345725;
	Fri, 17 Oct 2025 13:13:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A97F346A11;
	Fri, 17 Oct 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706823; cv=none; b=RjH8HzFz/ODdwVIUizEZgiDz2Yt0RYeh+jHAPGGgMnT1lcV8lTcrQp23CLyNFyXrP/wlVxDtTuF93KQWXCxpBbtoiQl55lgqLCXFi/1l08mbfrTrBeWODahtxI08CwGwyJuAKti/YByXoY2U9ZdX3THOqiTRmSjE8zlpqhp7DL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706823; c=relaxed/simple;
	bh=QN+FTil0OtW06PC1H5D6pXDm5/rYU8ei/m/tw8aCc/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly4DXYYVwvRwwa2ele3IOEPySa4LHmn5JHQ+q9Hr4uuZThgJN4lESA9M/orCN8663HYvYNWa35PH6OWNbcqogOO4MOCIoql5ulU0UURin+D6N1GeBjq70fb9B0uzOcvyy9SJQ4dSoBfQbt9jrPdX31xeWK1CubbT6Z20EQ2WbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1v9kH3-000599-00; Fri, 17 Oct 2025 15:13:37 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id A624EC0256; Fri, 17 Oct 2025 14:11:20 +0200 (CEST)
Date: Fri, 17 Oct 2025 14:11:20 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <aPIyaPuTXEfBPHme@alpha.franken.de>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
 <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com>
 <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net>
 <aO1sWdliSd03a2WC@alpha.franken.de>
 <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com>
 <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk>
 <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com>
 <aPIfSvhqhc9wxzGi@alpha.franken.de>
 <21079c94-cd49-bcd7-6f5d-7d5cd9d61432@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21079c94-cd49-bcd7-6f5d-7d5cd9d61432@linux.intel.com>

On Fri, Oct 17, 2025 at 01:58:13PM +0300, Ilpo Järvinen wrote:
> On Fri, 17 Oct 2025, Thomas Bogendoerfer wrote:
> 
> > On Tue, Oct 14, 2025 at 03:41:42PM +0300, Ilpo Järvinen wrote:
> > > [...]
> > > It was "good enough" only because the arch specific 
> > > pcibios_enable_resources() was lacking the check for whether the resource 
> > > truly got assigned or not. The PIIX4 driver must worked just fine without 
> > > those IO resources which is what most drivers do despite using 
> > > pci(m)_enable_device() and not pci_enable_device_mem() (the latter 
> > > doesn't even seem to come with m variant).
> > 
> > will you send a v2 of the patch ?
> 
> Without the the if ()? I can do that, I was unsure how people wanted to 
> progress with this.

yes without the if(), thank you

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

