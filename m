Return-Path: <linux-pci+bounces-11881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417A895885F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D252BB2240E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCBC18CBEF;
	Tue, 20 Aug 2024 14:00:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1F43AB2
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162441; cv=none; b=XmiUaiAkbBDImuuwyOGIoS3a553rMGpZI09ZMm/SDLpoCJCXKcwONWLXcjSTbwEq0L465rjYtRfI+KelDkZQN1g4tioa3vEj9f/AFKbqHANMa5lohvgKMNLxbwmJ45UOPHDL5slLics349uwZAT5c3HHikQUHpUj0wC5X1lDrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162441; c=relaxed/simple;
	bh=0ABJiDxIDABD5Q3QKvdbMfRuaEB7YzfjTXuV8ShdeSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scYvNPVVRs9eskxpHq/EXidfUYyyb3cVPDR78BDVzqgfKpq4EjRlV0YBujqBmq5qOB5azWySPC/K3m11lssW7q5lWco7n9Rrj1QV6l++juGA6vjwlYGvBW9fo2up+mbFOSIuEQMj8lKC0lhE50VaPnJceBuF38qAAB0miv6f1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id DE081300002D8;
	Tue, 20 Aug 2024 15:52:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B34664A830; Tue, 20 Aug 2024 15:52:48 +0200 (CEST)
Date: Tue, 20 Aug 2024 15:52:48 +0200
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
Message-ID: <ZsSfsPfWmrJ6PdWy@wunner.de>
References: <Zr2V5XqTAMSiEDJ-@wunner.de>
 <20240815174248.GA50357@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815174248.GA50357@bhelgaas>

On Thu, Aug 15, 2024 at 12:42:48PM -0500, Bjorn Helgaas wrote:
> The dependency of _DSM on IPMI sounds like a purely ACPI problem.  Is
> there no mechanism in ACPI to express that dependency?

Unfortunately there doesn't seem to be one. :(


> If _DSM claims the function is supported before the IPMI driver is
> ready, that sounds like a BIOS defect to me.
> 
> If we're stuck with this, maybe the comment can be reworded.  "Lazy
> loading" in a paragraph that also mentions initcalls and the
> "ACPI_IPMI" module makes it sound like we're talking about loading the
> *module* lazily, not just (IIUC) reading the LED status lazily.
> 
> Maybe it could also explicitly say that the GET_STATE_DSM function
> depends on IPMI.
> 
> I'm unhappy that we're getting our arm twisted here.  If functionality
> depends on IPMI, there really needs to be a way for OSPM to manage
> that dependency.  If we're working around a firmware defect, we need
> to be clear about that.

AFAICS lazy initialization of active indications was architected
such that it is retried on every LED access until it succeeds:

npem->active_inds_initialized is only set to true once
npem->ops->get_active_indications() returns successfully.
I'm assuming that the DSM method fails as it should on
inaccessibility of the IPMI OpRegion.

So users may see errors in dmesg when they access LEDs if IPMI drivers
have not been loaded yet, but once they're loaded, those errors will
go away and LED access should start working flawlessly.

This way of lazily initializing the cached active_indications bit mask
doesn't cost us much as far as code complexity is concerned, but should
make things work 99.999% of the time on quirky platforms.

Thanks,

Lukas

