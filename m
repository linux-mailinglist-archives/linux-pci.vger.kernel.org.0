Return-Path: <linux-pci+bounces-37540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB69BB6A7E
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D58C428652
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D62DE700;
	Fri,  3 Oct 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJrORMrM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C62EC08B;
	Fri,  3 Oct 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494415; cv=none; b=GTcjSfNwoVwjImymFbGVKYdHnEvqj6VK1eYnIu6eL8X2JnXUrq4njKvBSISyjIdRnrMZpC3klsZd0JQq4ziz/p7NQt7NYr7sZQ9rPS3T1gxAX0ogbY3mYPgDZuZdGUrtLaRO+S0B3Y0xmZlwA4emfkiIWoPyWhVm8j9xUsIRaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494415; c=relaxed/simple;
	bh=E50tYDM8gx3UL88zFxIT0tdZnck8P/wORg9Z1QAH7NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGbwCeqeH6FJip9IebWO++ieyOK4oaqYVNhv2Z8jljjB0cJygHV5Hs8XDXziseVZeC6wUgvzZsztNWJEM6INWjTnx3QTIQXqUfb90N576QextNmPVsOnMwrB20lu0/ZYWG6kwjexvkx4mL7z/sacCgyDs1UWBEHvJSOYluyhukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJrORMrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD10C4CEF5;
	Fri,  3 Oct 2025 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759494414;
	bh=E50tYDM8gx3UL88zFxIT0tdZnck8P/wORg9Z1QAH7NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJrORMrMKsahcSf+ABvPJxYuR649yPV6EPT6kk/nl5ydKl+Dq/9x6kmRRIruXWl8V
	 K+wEm8s52EL6acpxIiMyfD7ge4JfCd1Ueqo6eECnk2sAqxOQ+N6cmQL0gQDS8QOm+E
	 Hix9M8xQdZnnqFgUo6LmEH5rpAs2703I2/LQrBSM=
Date: Fri, 3 Oct 2025 14:26:51 +0200
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
Message-ID: <2025100317-backroom-upside-c788@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <2025093044-icky-treat-e1c3@gregkh>
 <CACePvbUr42mj0kbcaw4cgKnd7v1f8z8Jhq4+_QN7Z5Nvicd1cw@mail.gmail.com>
 <2025100323-sneer-perennial-55e1@gregkh>
 <CAF8kJuNPFbSJezynwXWpMx0ihV32YvAgdfygj7bx1nhxtmB8-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNPFbSJezynwXWpMx0ihV32YvAgdfygj7bx1nhxtmB8-w@mail.gmail.com>

On Fri, Oct 03, 2025 at 12:26:01AM -0700, Chris Li wrote:
> On Thu, Oct 2, 2025 at 11:19 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 02, 2025 at 01:38:56PM -0700, Chris Li wrote:
> > > On Tue, Sep 30, 2025 at 8:30 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 12:45:11AM -0700, Chris Li wrote:
> > > > >  include/linux/dev_liveupdate.h |  23 +++++
> > > > >  include/linux/device/driver.h  |   6 ++
> > > >
> > > > Driver core changes under the guise of only PCI changes?  Please no.
> > >
> > > There is a reason why I use the device struct rather than the pci_dev
> > > struct even though liveupdate currently only works with PCI devices.
> > > It comes down to the fact that the pci_bus and pci_host_bridge are not
> > > pci_dev struct. We need something that is common across all those
> > > three types of PCI related struct I care about(pci_dev, pci_bus,
> > > pci_host_bridge). The device struct is just common around those. I can
> > > move the dev_liveupdate struct into pci_bus, pci_host_bridge and
> > > pci_dev independently. That will be more contained inside PCI, not
> > > touching the device struct. The patch would be bigger because the data
> > > structure is spread into different structs. Do you have a preference
> > > which way to go?
> >
> > If you only are caring about one single driver, don't mess with a
> > subsystem or the driver core, just change the driver.  My objection here
> 
> It is more than just one driver, we have vfio-pci, idpf, pci-pf-stub
> and possible nvme driver.

Why is nvme considered a "GPU" that needs context saved?

> The change needs to happen in the PCI enumeration and probing as well,
> that is outside of the driver code.

So all just PCI drivers?  Then keep this in PCI-only please, and don't
touch the driver core.

> > was that you were claiming it was a PCI change, yet it was actually only
> > touching the driver core which means that all devices in the systems for
> 
> In theory all the devices can be liveupdate preserved. But now we only
> support PCI.

Then for now, only focus on PCI.

thanks,

greg k-h

