Return-Path: <linux-pci+bounces-2489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04264839468
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B521F21774
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B761670;
	Tue, 23 Jan 2024 16:12:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE25F54F;
	Tue, 23 Jan 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026365; cv=none; b=bJU5PeG/RtNF44nSeuG92Y0yirNJKsBN8pidyOubCn2BEM0aL8Ss/IN4Y6uHMOR42eAf4uXidFyKBg5HXKCq4poaH+SGNpYA6eK4Wu0cvzl8voadEenIk6AX/4BzPsHPoTClDvL1EC8Thj0NRkfTYgYC5vJbZCUspn5FYx8A84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026365; c=relaxed/simple;
	bh=hAHznUzSv6dTrsoCKG1BmoIFAUP2Qu7H99Ld4q6fwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4Nik8/hx18X7wHwe36BVBDuTtZf4FA8e5k5GdshI1phvhO8kjvpU9hYxBgdSGWC30dOU1yPwSw3zB4Eu08XSpb+XdJnfJmVb4/MiJnl9/twDHUhtXU/uVPzMuoL0wiQenwaXSfxu1utuxm3zbxNY7y3g7UIv6rSOZ+Vxy5VMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D493630000625;
	Tue, 23 Jan 2024 17:12:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C39B37AB23; Tue, 23 Jan 2024 17:12:39 +0100 (CET)
Date: Tue, 23 Jan 2024 17:12:39 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, eric.auger@redhat.com,
	mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com,
	Sanath.S@amd.com
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
Message-ID: <20240123161239.GA1386@wunner.de>
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
 <20230803171233.3810944-3-alex.williamson@redhat.com>
 <20240118115049.3b5efef0.alex.williamson@redhat.com>
 <20240122221730.GA16831@wunner.de>
 <20240122155003.587225aa.alex.williamson@redhat.com>
 <20240123104519.GA21747@wunner.de>
 <20240123085521.07e2b978.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123085521.07e2b978.alex.williamson@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jan 23, 2024 at 08:55:21AM -0700, Alex Williamson wrote:
> On Tue, 23 Jan 2024 11:45:19 +0100 Lukas Wunner <lukas@wunner.de> wrote:
> > If the device is RPM_SUSPENDING, why immediately resume it for polling?
> > It's sufficient to poll it the next time around, i.e. 1 second later.
> > 
> > Likewise, if it's already RPM_RESUMING or RPM_ACTIVE anyway, no need
> > to poll PME.
> 
> I'm clearly not an expert on PME, but this is not obvious to me and
> before the commit that went in through this thread, PME wakeup was
> triggered regardless of the PM state.  I was trying to restore the
> behavior of not requiring a specific PM state other than deferring
> polling across transition states.

There are broken devices which are incapable of signaling PME.
As a workaround, the kernel polls these devices once per second.
The first time the device signals PME, the kernel stops polling
that particular device because PME is clearly working.

So this is just a best-effort way to support PME for broken devices.
If it takes a little longer to detect that PME was signaled, it's not
a big deal.


> The issue I'm trying to address is that config space of the device can
> become inaccessible while calling pci_pme_wakeup() on it, causing a
> system fault on some hardware.  So a gratuitous pci_pme_wakeup() can be
> detrimental.
> 
> We require the device config space to remain accessible, therefore the
> instantaneous test against D3cold and that the parent bridge is in D0
> is not sufficient.  I see traces where the parent bridge is in D0, but
> the PM state is RPM_SUSPENDING and the endpoint device transitions to
> D3cold while we're executing pci_pme_wakeup().

We have pci_config_pm_runtime_{get,put}() helpers to ensure the parent
of a device is in D0 so that the device's config space is accessible.
So you may need to use that in pci_pme_wakeup().

Thanks,

Lukas

