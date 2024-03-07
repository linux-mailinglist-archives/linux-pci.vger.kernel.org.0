Return-Path: <linux-pci+bounces-4599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4F874EF6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 13:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50159B22FEB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9C12A170;
	Thu,  7 Mar 2024 12:25:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4E85295;
	Thu,  7 Mar 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814354; cv=none; b=Sb12sBRu/452HFx090TNB51WpKNYyIZxsLb8BFT7oiax7S6PxsAJRQZgqcoXJdTFnk0e3zlKgSQft0RrfwLQ6lTd8ReV7jyj2p+NiPMRY5pQrhPvxKooAQaANtujxzBvSTtz4syJ1er7XgpfHl5exYpYFhO/QeXVVIKsBLgPEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814354; c=relaxed/simple;
	bh=2sQ6QNZ2K1G2r3QDWhMiXqkpedXGZVYgJ0ezD0rSlJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqV0sICF+dJHuOATG9XOpsufR47Dmxz+uyzSnuy2SjrHOBLqTfYRKxrEdcgQ3Pi4YGvzi1l9oDYbiCiWsVFbJ58MlM5LC+ae9u81LL2ImzimYL1XUwMI/WXCATM7jsfCnpu8xDBZwfNB9CFOrUbNUChgIo/okisc95PGNETjzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AFBE62800BDAF;
	Thu,  7 Mar 2024 13:25:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 86BC5415D5D; Thu,  7 Mar 2024 13:25:42 +0100 (CET)
Date: Thu, 7 Mar 2024 13:25:42 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-leds@vger.kernel.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <ZemyRj63v07Rj4Vu@wunner.de>
References: <20240215142345.6073-3-mariusz.tkaczyk@linux.intel.com>
 <20240306224008.GA554220@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306224008.GA554220@bhelgaas>

On Wed, Mar 06, 2024 at 04:40:08PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 15, 2024 at 03:23:45PM +0100, Mariusz Tkaczyk wrote:
> > The interface is ready to support enclosures where patterns are not
> > mutually exclusive, driver may clear other LEDs if they cannot be enabled
> > together.
> 
> I don't think this code does anything like "clearing other LEDs," does
> it?  I agree that this code doesn't impose any constraints about
> indications being mutually exclusive, etc.  It merely sets or clears
> indication bits, and the hardware implementation is free to interpret
> that as it sees fit.

I guess the paragraph needs to be rephrased.  The point is that
if this NPEM driver sets bit A and another bit B is already set,
and the hardware is incapable of lighting up whatever is controlled
by these two bits *simultaneously*, the hardware might clear bit B
when setting bit A.  The driver can cope with that because
npem_set() reads back the register contents with npem_read_reg()
after calling npem_set_active_patterns().


> > +	/*
> > +	 * For the case where a NPEM command has not completed immediately,
> > +	 * it is recommended that software not continuously ???spin??? on polling
> > +	 * the status register, but rather poll under interrupt at a reduced
> > +	 * rate; for example at 10 ms intervals.
> > +	 *
> > +	 * PCIe r6.1 sec 6.28 "Implementation Note: Software Polling of NPEM
> > +	 * Command Completed"
> 
> The implementation note also recommends reversing the order, i.e.,
> polling for completion of previous command and then writing a new
> command, but it looks like we don't use that strategy?

I think the leds subsystem expects the LED to be lit up by the time
the ->brightness_set_blocking() callback returns.  If the driver waited
for command completion *before* setting a bit instead of afterwards,
it could happen that npem_set() (the ->brightness_set_blocking() callback)
returns even though the command hasn't completed yet and the LED thus
isn't lit up yet.

Thanks,

Lukas

