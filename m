Return-Path: <linux-pci+bounces-37512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CFBB5F8F
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 08:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FB123441A6
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F181F5617;
	Fri,  3 Oct 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMqz2Nn+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA2158DAC;
	Fri,  3 Oct 2025 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759472343; cv=none; b=mmkzXXTUZu7IPBag6L7v7kRkx925DywXrcCIU+/R5XGnMzkNIQIO6dCsp1OujqtW7NQDvnK0AGhwyP42DmYal4TBg9YEemukTv1OtSW1DLh2E2LJYRsb90Rdepr+E/9N8Cf6sBGldYym23jqBYEsAmg8W/Z5ezMZAjVluAgSxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759472343; c=relaxed/simple;
	bh=oPZnpLhd0eTHGu0EKAIm4qHKPQRG1JVI8tF3iuEdlj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUyfrOth8e6/yealrxTSnXPxRB4ufRoSr3AL3/Bo9MPtflr7Q0B0i9Zpfdc4xjOp52vlgOSnU2KJZ67/jDJ/Ipp1lH1HcgixTL+m9Ds9HzBUmuBFf4nrAaeBc9A3BSYsx5Xkz8Ny3fVQ/0icZDecTbTfpJ+NKESBZqocnxtVOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMqz2Nn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D67BC4CEF5;
	Fri,  3 Oct 2025 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759472342;
	bh=oPZnpLhd0eTHGu0EKAIm4qHKPQRG1JVI8tF3iuEdlj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMqz2Nn+ATNZEYG3EMxNEJMUyEp+w45V1za9eJSHnZMlExCO1q2302hHcjiATNf2U
	 H928pcWh2P1vq0qhR6k5YavR7LPArVbGWBRlxJmCZ2FtBOwOEvoFA7LpZNsD2sct2n
	 sbk+zi1E6+uOcgL9BXe9dqd5Khswe/aXyjK77Ve0=
Date: Fri, 3 Oct 2025 08:18:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <2025100323-sneer-perennial-55e1@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <2025093044-icky-treat-e1c3@gregkh>
 <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>

On Thu, Oct 02, 2025 at 01:38:56PM -0700, Chris Li wrote:
> On Tue, Sep 30, 2025 at 8:30 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > >  include/linux/dev_liveupdate.h |  23 +++++
> > >  include/linux/device/driver.h  |   6 ++
> >
> > Driver core changes under the guise of only PCI changes?  Please no.
> 
> There is a reason why I use the device struct rather than the pci_dev
> struct even though liveupdate currently only works with PCI devices.
> It comes down to the fact that the pci_bus and pci_host_bridge are not
> pci_dev struct. We need something that is common across all those
> three types of PCI related struct I care about(pci_dev, pci_bus,
> pci_host_bridge). The device struct is just common around those. I can
> move the dev_liveupdate struct into pci_bus, pci_host_bridge and
> pci_dev independently. That will be more contained inside PCI, not
> touching the device struct. The patch would be bigger because the data
> structure is spread into different structs. Do you have a preference
> which way to go?

If you only are caring about one single driver, don't mess with a
subsystem or the driver core, just change the driver.  My objection here
was that you were claiming it was a PCI change, yet it was actually only
touching the driver core which means that all devices in the systems for
all Linux users will be affected.

> > Break this series out properly, get the driver core stuff working FIRST,
> > then show how multiple busses will work with them (i.e. you usually need
> > 3 to know if you got it right).
> 
> Multiple buses you mean different types of bus, e.g. USB, PCI and
> others or 3 pci_bus is good enough? Right now we have no intention to
> support bus types other than PCI devices. The liveupdate is about
> preserving the GPU context cross kernel upgrade. Suggestion welcome.

So all of this is just for one single driver.  Ugh.  Just do it in the
single driver then, don't mess with the driver core, or even the PCI
core.  Just make it specific to the driver and then none of us will even
notice the mess that this all creates :)

thanks,

greg k-h

