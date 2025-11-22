Return-Path: <linux-pci+bounces-41906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0CDC7CCA9
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0C604E46AF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E62FA0F5;
	Sat, 22 Nov 2025 10:25:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7672F9DB0;
	Sat, 22 Nov 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763807105; cv=none; b=O960V+UNQwmaDqerROsQ56PzRo7SWPN2TqCkRZKNg6Q3XBmCW+yC0kKh0Cll5FGNHbaU269ilUWBZ20PpIy5pbQCzLcy402HNeWj1ORYLKp5zhR1+JIdWRfvUkpWO/4j1DDaaQ9CK+Gltf6tzmeBZJX4tNFeZI6AKv65APVRrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763807105; c=relaxed/simple;
	bh=hR7oyl5iFs+wgbVb4sHkOvNmkCEqJ4QQX8TMyjpZcm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb7rs4LZqyotvsmd4hCFxOVfP//1AB8FUZP7SHHbwxDwKyt0y0rqLFUK8eLInNncSDbflYKg6+9BJL53IAvXSR2w/VEsqmdICFSahxOlYJpriZ2iGo313UvZ/o772LAOzw7hpFtpckkGZ2ZSeeCvfh5lRcFcadyckx9tJTlQpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A58282006F59;
	Sat, 22 Nov 2025 11:24:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8E32C1BF15; Sat, 22 Nov 2025 11:24:51 +0100 (CET)
Date: Sat, 22 Nov 2025 11:24:51 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Linas Vepstas <linasvepstas@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: Amend error recovery doc with
 pci_save_state() rules
Message-ID: <aSGPc2qQGgdjp7iV@wunner.de>
References: <077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de>
 <ab3158f0-7954-4a89-88da-6d7d69111e3b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3158f0-7954-4a89-88da-6d7d69111e3b@linux.ibm.com>

On Fri, Nov 21, 2025 at 10:57:24AM -0800, Farhan Ali wrote:
> On 11/21/2025 9:31 AM, Lukas Wunner wrote:
> > +++ b/Documentation/PCI/pci-error-recovery.rst
> > @@ -326,6 +326,21 @@ be recovered, there is nothing more that can be done;  the platform
> >   will typically report a "permanent failure" in such a case.  The
> >   device will be considered "dead" in this case.
> > +Drivers typically need to call pci_restore_state() after reset to
> > +re-initialize the device's config space registers and thereby
> > +bring it from D0\ :sub:`uninitialized` into D0\ :sub:`active` state
> > +(PCIe r7.0 sec 5.3.1.1).  The PCI core invokes pci_save_state()
> > +on enumeration after initializing config space to ensure that a
> > +saved state is available for subsequent error recovery.
> > +Drivers which modify config space on probe may need to invoke
> > +pci_save_state() afterwards to record those changes for later
> > +error recovery.  When going into system suspend, pci_save_state()
> > +is called for every PCI device and that state will be restored
> > +not only on resume, but also on any subsequent error recovery.
> 
> Nit: Should we clarify in the above sentence on what calls the
> pci_save_state() when going into suspend? My assumption is the
> pci_save_state() is called by the PCI core and not the drivers?

Per section 3.1.2 of Documentation/power/pci.rst, pci_save_state()
may be called by either the driver or the PCI core.  Normally it's
the PCI core's responsibility, but a driver may choose to call it
and bring the device into a low power state itself.  The PCI core
recognizes that by looking at the state_saved flag in struct pci_dev
and will then neither call pci_save_state() nor transition the device
to a low power state.  That is the (only) purpose of the flag.

I could maybe add a cross-reference pointing to Documentation/power/pci.rst.
And/or that document could be moved to Documentation/PCI/.

> What should the PCI core do if the saved state recorded is bad? should we
> continue to restore the device with the recorded bad state?

Basically the answer is, it should never happen and if it does,
we've got a bug somewhere.

> On s390 restoring the device with the bad state can break the device
> put into error again.

My (limited) understanding is that you may end up with a bad
saved state on s390 virtualization scenarios because you're
telling the PCI core in the ->error_detected phase() that the
device has recovered and then you try to reset and recover the
device on your own.  I think the solution is to enhance qemu
to integrate better with error recovery on the host.

Thanks,

Lukas

