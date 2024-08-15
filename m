Return-Path: <linux-pci+bounces-11689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93495290A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 07:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5B91C21897
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0017625C;
	Thu, 15 Aug 2024 05:50:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EC43A1DB
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701043; cv=none; b=jfip07QD9SbijntmCWz4Xajhh52sL8xycHpdlz2eYXKn8I4NcF6/OzGx7SEWB2tV2EtGIf+8jrjMEufFJ2Z+1T6IaLgjTpDc1cHZ7FH/ppNmfWkypJijJDjtL98KGqWF6+zxdNg5Nd1x+NDr0E8OEA/DU1DfB9Ct5OphGiQvMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701043; c=relaxed/simple;
	bh=35pYZWUPg0zh7krYU5OW0G1XRRT/6XzgLNFiX45CMac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN9FO4WaC+rMkHM0hFtGzecqWIxo5uvnSgAaRGpKA1jgGZFFgOAEmqNNwOrYwLdBszstXbA05HZ7XUK2DuU7AGYVVGC1azsoYLZEvtZ7oKWhF9C7mEUXqUp1PJangBiG3D9wyx3uKlfUbXLOFfg+Jr09HZGxdFtzaySzwNV31wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 18F03100DECB7;
	Thu, 15 Aug 2024 07:45:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D0CFD31BB10; Thu, 15 Aug 2024 07:45:09 +0200 (CEST)
Date: Thu, 15 Aug 2024 07:45:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zr2V5XqTAMSiEDJ-@wunner.de>
References: <20240814122900.13525-3-mariusz.tkaczyk@linux.intel.com>
 <20240814214930.GA5507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814214930.GA5507@bhelgaas>

On Wed, Aug 14, 2024 at 04:49:30PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 14, 2024 at 02:28:59PM +0200, Mariusz Tkaczyk wrote:
> > +	/*
> > +	 * Use lazy loading for active_indications to not play with initcalls.
> > +	 * It is needed to allow _DSM initialization on DELL platforms, where
> > +	 * ACPI_IPMI must be loaded first.
> > +	 */
> > +	unsigned int active_inds_initialized:1;
> 
> What's going on here?  I hope we can at least move this to the _DSM
> patch since it seems related to that, not to the NPEM capability.  I
> don't understand the initcall reference or what "lazy loading" means.

In previous iterations of this series, the status of all LEDs was
read on PCI device enumeration.  That was done so that when user space
reads the brightness is sysfs, it gets the correct value.  The value
is cached, it's not re-read from the register on every brightness read.

(It's not guaranteed that all LEDs are off on enumeration.  E.g. boot
firmware may have fiddled with them, or the enclosure itself may have
turned some of them on by itself, typically the "ok" LED.)

However Stuart reported issues when the _DSM interface is used on
Dell servers, because the _DSM requires IPMI drivers to access the
NPEM registers.  He got a ton of errors when LED status was read on
enumeration because that was simply too early.  Start of thread:

https://lore.kernel.org/all/05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com/

The solution is to read LED status lazily, when brightness is read
or written for the first time through sysfs.  At that point, IPMI
drivers are typically loaded.  Stuart reported success with this
approach.  There is still a possibility that users may see issues
if they access brightness before IPMI drivers are loaded.  Those
drivers may be modules and user space might overzealously try to
access brightness before they're loaded.  Or user space may prevent
them from loading by blacklisting or not installing them.  In which
case users get to keep the pieces.

We discussed various alternative approaches in the above-linked thread
but concluded that this pragmatic solution is the simplest that does
the job for all but the most pathological use cases.

We wanted to make this work on Dell servers, but at the same time
minimize the contortions that we need to go through to accommodate
their quirky implementation.

The code uses lazy initialization of LED status even in the native
NPEM case because it would make the code more complex to use early
initialization for direct NPEM register access and lazy initialization
for _DSM-mediated register access.


> Is there some existing ACPI ordering that guarantees ACPI_IPMI happens
> first?  Why do we need some Dell-specific thing here?
> 
> What is ACPI_IPMI?  I guess it refers to the "acpi_ipmi" module,
> acpi_ipmi.c?

As it turned out in the above-linked thread, just forcing ACPI_IPMI=y
for NPEM is not sufficient because additional (Dell-specific) IPMI
drivers need to be loaded as well for NPEM register access to work
through _DSM.


> > +void pci_npem_create(struct pci_dev *dev)
> > +{
> > +	const struct npem_ops *ops = &npem_ops;
> > +	int pos = 0, ret;
> > +	u32 cap;
> > +
> > +	if (!npem_has_dsm(dev)) {
> > +		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> > +		if (pos == 0)
> > +			return;
> > +
> > +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> > +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> > +			return;
> > +	} else {
> > +		/*
> > +		 * OS should use the DSM for LED control if it is available
> > +		 * PCI Firmware Spec r3.3 sec 4.7.
> > +		 */
> > +		return;
> > +	}
> 
> I know this is sort of a transient state since the next patch adds
> full _DSM support, but I do think (a) the fact that NPEM will stop
> working simply because firmware adds _DSM support is unexpected
> behavior, and (b) npem_has_dsm() and the other ACPI-related stuff
> would fit better in the next patch.  It's a little strange to have
> them mixed here.

PCI Firmware Spec r3.3 sec 4.7 says:

   "OSPM should use this _DSM when available. If this _DSM is not
    available, OSPM should use Native PCIe Enclosure Management (NPEM)
    or SCSI Enclosure Services (SES) instead, if available."

I realize that a "should" is not a "must", so Linux would in principle
be allowed to use direct register access despite presence of the _DSM.

However that doesn't feel safe.  If the _DSM is present, I think it's
fair to assume that the platform firmware wants to control at least
a portion of the LEDs itself.  Accessing those LEDs directly, behind the
platform firmware's back, may cause issues.  Not exposing the LEDs
to the user in the _DSM case therefore seems safer.

Which is why the ACPI stuff to query for _DSM presence is already in
this patch instead of the succeeding one.

Thanks,

Lukas

