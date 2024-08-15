Return-Path: <linux-pci+bounces-11710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 520AC953960
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5091F2624F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838325B5D6;
	Thu, 15 Aug 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chzg5T9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B35B1FB
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743771; cv=none; b=fCHjtlL1aGc9z5pHlZTfFJ3qQL/kjk4EwkL+X7pCepmEz7EZWR+gndIyvQ0Ns15t3W1uYu+F2LTvMqn2RXllnUw51qsYogIpUyZm3Ynjbi+ws4dEgfR4JKjTDgS+KAGoJNC/WDdFFTYz53sUNsk1U5Z2HjKfT1mJ3LLRHBw4ZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743771; c=relaxed/simple;
	bh=TIouDW0iBsflImz5Mpqqfug+3ObO1p3gDPeG41aKX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QpWHPNcG3z/F/Xr/GS9msW+tNwdZki7TcD92h8LUPItOLOIqwg3tK2CtQaSM/o9wV+xBfbGGzsJEmLK3m7vHbswGl1wPNOwiRXd6zyi7yMU/nOK2LYKYgDVRMYOJYhpDb4hb7IyCiFI7Hs9u/Qjn/goF2xjkhrL8VEAh8kulL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chzg5T9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7CBC32786;
	Thu, 15 Aug 2024 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723743771;
	bh=TIouDW0iBsflImz5Mpqqfug+3ObO1p3gDPeG41aKX+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Chzg5T9ocudvvjzvr0f6CmOMMIIXDfLIcWo6ru3qLuJr/t834RzakY7GL9nmL5Tzu
	 TGrnfn9bDINPQ5JM6AKRHXemGLdr4jL3bKxgaglkuhab2/s+PCp6I1VymzEI/8tt6I
	 /eRY0SYnAIFC/AffxqoAw5paWuBXmr6Ruq+jw9y6MHOCkypdc2xetCE/AXSrJRQ346
	 Y8acGIy3ZcHftEw2tStScXih9CfVMPYhlIkX1/Gp70QV1v/MdDIxwyNFonOQFmTiSV
	 5RBMrGS+02vUAWndU8TAK6GTN+3wZVuxLUMwgnbcPEtc/xSjN2ANbET+IW72WrWFA2
	 GNcAmqfSTKEWQ==
Date: Thu, 15 Aug 2024 12:42:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240815174248.GA50357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr2V5XqTAMSiEDJ-@wunner.de>

On Thu, Aug 15, 2024 at 07:45:09AM +0200, Lukas Wunner wrote:
> On Wed, Aug 14, 2024 at 04:49:30PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 14, 2024 at 02:28:59PM +0200, Mariusz Tkaczyk wrote:
> > > +	/*
> > > +	 * Use lazy loading for active_indications to not play with initcalls.
> > > +	 * It is needed to allow _DSM initialization on DELL platforms, where
> > > +	 * ACPI_IPMI must be loaded first.
> > > +	 */
> > > +	unsigned int active_inds_initialized:1;
> > 
> > What's going on here?  I hope we can at least move this to the _DSM
> > patch since it seems related to that, not to the NPEM capability.  I
> > don't understand the initcall reference or what "lazy loading" means.
> 
> In previous iterations of this series, the status of all LEDs was
> read on PCI device enumeration.  That was done so that when user space
> reads the brightness is sysfs, it gets the correct value.  The value
> is cached, it's not re-read from the register on every brightness read.
> 
> (It's not guaranteed that all LEDs are off on enumeration.  E.g. boot
> firmware may have fiddled with them, or the enclosure itself may have
> turned some of them on by itself, typically the "ok" LED.)
> 
> However Stuart reported issues when the _DSM interface is used on
> Dell servers, because the _DSM requires IPMI drivers to access the
> NPEM registers.  He got a ton of errors when LED status was read on
> enumeration because that was simply too early.  

The dependency of _DSM on IPMI sounds like a purely ACPI problem.  Is
there no mechanism in ACPI to express that dependency?

If _DSM claims the function is supported before the IPMI driver is
ready, that sounds like a BIOS defect to me.

If we're stuck with this, maybe the comment can be reworded.  "Lazy
loading" in a paragraph that also mentions initcalls and the
"ACPI_IPMI" module makes it sound like we're talking about loading the
*module* lazily, not just (IIUC) reading the LED status lazily.

Maybe it could also explicitly say that the GET_STATE_DSM function
depends on IPMI.

I'm unhappy that we're getting our arm twisted here.  If functionality
depends on IPMI, there really needs to be a way for OSPM to manage
that dependency.  If we're working around a firmware defect, we need
to be clear about that.

> > > +void pci_npem_create(struct pci_dev *dev)
> > > +{
> > > +	const struct npem_ops *ops = &npem_ops;
> > > +	int pos = 0, ret;
> > > +	u32 cap;
> > > +
> > > +	if (!npem_has_dsm(dev)) {
> > > +		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_NPEM);
> > > +		if (pos == 0)
> > > +			return;
> > > +
> > > +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP, &cap) != 0 ||
> > > +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> > > +			return;
> > > +	} else {
> > > +		/*
> > > +		 * OS should use the DSM for LED control if it is available
> > > +		 * PCI Firmware Spec r3.3 sec 4.7.
> > > +		 */
> > > +		return;
> > > +	}
> > 
> > I know this is sort of a transient state since the next patch adds
> > full _DSM support, but I do think (a) the fact that NPEM will stop
> > working simply because firmware adds _DSM support is unexpected
> > behavior, and (b) npem_has_dsm() and the other ACPI-related stuff
> > would fit better in the next patch.  It's a little strange to have
> > them mixed here.
> 
> PCI Firmware Spec r3.3 sec 4.7 says:
> 
>    "OSPM should use this _DSM when available. If this _DSM is not
>     available, OSPM should use Native PCIe Enclosure Management (NPEM)
>     or SCSI Enclosure Services (SES) instead, if available."
> 
> I realize that a "should" is not a "must", so Linux would in principle
> be allowed to use direct register access despite presence of the _DSM.
> 
> However that doesn't feel safe.  If the _DSM is present, I think it's
> fair to assume that the platform firmware wants to control at least
> a portion of the LEDs itself.  Accessing those LEDs directly, behind the
> platform firmware's back, may cause issues.  Not exposing the LEDs
> to the user in the _DSM case therefore seems safer.
> 
> Which is why the ACPI stuff to query for _DSM presence is already in
> this patch instead of the succeeding one.

The spec is regrettably vague about this, but that assumption isn't
unreasonable.  It does deserve a more explicit callout in the commit
log and probably a dmesg note about why NPEM used to work but no
longer does.

Bjorn

