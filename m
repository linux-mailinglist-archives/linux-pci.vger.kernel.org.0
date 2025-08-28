Return-Path: <linux-pci+bounces-34976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F2B395A5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CC51718CF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CA2D3A7C;
	Thu, 28 Aug 2025 07:38:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEC029D28B;
	Thu, 28 Aug 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366724; cv=none; b=FOiOiHAUzEaNDbp5+yW7Kj78aFMmqbOEZZCMAYyC48t1kCXtOHlLahUe4NYLXBl56ZpLwqXAcLQlAS+Bq6SrLzvG4d1IoY89J6ddNoIkJIBXxmHGGygZOjqeXViWcURyJS4sq/TJ1f1uNCVcqRhPBu3nKYLFql74E7A8azu5+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366724; c=relaxed/simple;
	bh=1FeGWWkpnViziSe6lc+DKmue88Hh0SsFpGyGy5ESXBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDLWwlHTXAHERnXRk4Zv4uLjpYZYfy7y/pKmRfLRQ3nBAdPZl2Ffaz0iXldkaimAV4fhSMT3vVhmRvrKRAsCS8zC1K7Olit+K+mDWRkXLf7QsYRGEqxDVKttw06ENebi38baog0rKiFy7sNOjxzSm3dP/K36e8soQH0H9Swz4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1urXDA-0001jz-00; Thu, 28 Aug 2025 09:38:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 09775C04FD; Thu, 28 Aug 2025 08:57:33 +0200 (CEST)
Date: Thu, 28 Aug 2025 08:57:33 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <aK_93U_PnpKayqZD@alpha.franken.de>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
 <20250822145605.18172-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822145605.18172-4-ilpo.jarvinen@linux.intel.com>

On Fri, Aug 22, 2025 at 05:55:44PM +0300, Ilpo Järvinen wrote:
> pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
> pcibios_enable_resources(). Having own copy of same functionality could
> lead to inconsistencies in behavior, especially now as
> pci_enable_resources() and the bridge window resource flags behavior
> are going to be altered by upcoming changes.
> 
> The check for !r->start && r->end is already covered by the more
> generic checks done in pci_enable_resources().
> 
> Call pci_enable_resources() from MIPS's pcibios_enable_device() and
> remove pcibios_enable_resources().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/mips/pci/pci-legacy.c | 38 ++------------------------------------
>  1 file changed, 2 insertions(+), 36 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

