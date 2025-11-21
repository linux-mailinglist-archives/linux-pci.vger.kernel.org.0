Return-Path: <linux-pci+bounces-41892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D8C7B19C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C18FD4E27D0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2826B760;
	Fri, 21 Nov 2025 17:40:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96942868B5
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746834; cv=none; b=PvRZcSfsw9TYqcX7zF3i13SzhBpXr/gPJq7XE82VVwnSFit+1Hatf61xAIhaaZlc71lMccHGf4pgGmG+I2hWhn8Mj/BSjnwgvOr2Iyzovp4t1t2+qmqBSmCEVJiXj2SnvfUNpxgF9dFiRgGezxesZGmqeRIfkvOOI7s7rQvyL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746834; c=relaxed/simple;
	bh=eIgQ2sCjHmzq6/Mwz4d8kiDvX/ykxlghO4JCe5wh9Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OamOU+e6cbYMWuQKbx6aJdOBsT3Clp+pydRwQYgFCYlAN0xqvle2hcfBD02NRLmtuvP02KLC7ocnGJMHgEfDZlNqpUVHqP2N+Mec84YdMpIfQgpNRMBJAO+PpjUxBBa49mDo+epRGA546aqIA+SZdPh+lwAN8NajxPdk1rS/xSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 00D7D2C051EB;
	Fri, 21 Nov 2025 18:40:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CE5EF17677; Fri, 21 Nov 2025 18:40:23 +0100 (CET)
Date: Fri, 21 Nov 2025 18:40:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] PCI: Ensure error recoverability at all times
Message-ID: <aSCkB7C5EF2BVdfM@wunner.de>
References: <aRWnAd-PZuHMqBwd@wunner.de>
 <20251113161556.GA2284238@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113161556.GA2284238@bhelgaas>

On Thu, Nov 13, 2025 at 10:15:56AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 13, 2025 at 10:38:09AM +0100, Lukas Wunner wrote:
> > On Wed, Nov 12, 2025 at 04:38:31PM -0600, Bjorn Helgaas wrote:
> > > On Sun, Oct 12, 2025 at 03:25:01PM +0200, Lukas Wunner wrote:
> > > It would be nice if there were a few more
> > > words about pci_save_state() and pci_restore_state() in
> > > Documentation/.
> > > 
> > > pci_save_state() isn't mentioned at all in Documentation/PCI
> > 
> > Right, it's documented in the Documentation/power directory. :)
> 
> Yes, in the pci.rst I mentioned, but it mostly uses the "saves the
> device's standard configuration registers" wording.
> 
> I'm just wishing for a more concrete mention of "pci_save_state()",
> since that's where the critical "state_saved" flag is updated.

Hm, Documentation/power/pci.rst does contain this:

   "Then, pci_save_state(), pci_prepare_to_sleep(), and
    pci_set_power_state() should be used to save the device’s
    standard configuration registers, to prepare it for system wakeup
    (if necessary), and to put it into a low-power state, respectively."

I'm struggling to find a better way to phrase it.

> And I'm not sure Documentation/ includes anything about the idea of
> a driver using pci_save_state() to capture the state it wants to
> restore after an error.

Right, while pci_save_state() usage is mentioned in the PCI power
management documentation, it's not mentioned at all in the error
recovery context.  So I'm proposing this amendment:

https://lore.kernel.org/r/077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de/

Thanks,

Lukas

