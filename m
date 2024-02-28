Return-Path: <linux-pci+bounces-4188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D186B2FB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8A21F24160
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335015B96C;
	Wed, 28 Feb 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt3WeIhs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8F015B112;
	Wed, 28 Feb 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133745; cv=none; b=q3ZyUzZygHr0J5XX/K/ufOuhK8IVs7IfJU9QdifX7QF6VBKagGBRfgaWa48GYeRVw4HK4JrtRhn1/xFSqYut9tk9Bc18ptAjoPUnzyDb7WYS+3lQsTrwSo3J9VEB5C51R4K/K8XytxmkDviSwBgEr9NioScAoWAT+L5ZY3hOnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133745; c=relaxed/simple;
	bh=nBvL+ug5h09avX9lyMoju+Baf9hhu66dKZQsdi83ohc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CKIwmnMXcuBS7BAS+AXQ7v7uOUKygdadsFBRNpZ4U5VZn3HyxAvFwgTQ1vV2i5s2URvaIVJQIX+arqW/fSnLOHshYrtPo1oxaf9QQYSy4Bob9SZw5vBRHBmEfFUfgU45CeYKuSHH/90cnC2cnCwiOZVoJuqnlNsLWrDVSXvFO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt3WeIhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED9DC43390;
	Wed, 28 Feb 2024 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133744;
	bh=nBvL+ug5h09avX9lyMoju+Baf9hhu66dKZQsdi83ohc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Bt3WeIhs5Z0E08Xv8KSiFvHKfyCOHc+f58WMxvZJ7Upm6UPzX4+casSgucNRWzqXJ
	 0BYOyn7+JINjVAakhETw7VTbKCKwEjzN9Dxf/6fk9fNLfMw5lhiale9PxFBaqzaFrl
	 I27iL0O7BDWLfg2gJ/KCa9L4IPS3ZxUqyQFBrVEJ5BZSTJtpDZQ2vNZO+Q3MzCWAsA
	 v3zcrUkn8oey11AlzqXND46YZ5lOE/KlC0/CIOiYjuGv7RQpHHOWEBXserQKqFWo1A
	 omGS1KdY8/k9vr7Ok6LDlmGJ9JKakgfQRz6n4rfsmw5wrEb4ggXha3cV+iShi17/mo
	 SiLSUHB3bhngw==
Date: Wed, 28 Feb 2024 09:22:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexander.stein@ew.tq-group.com,
	decui@microsoft.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20240228152222.GA272403@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227171458.GA16664@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Feb 27, 2024 at 09:14:58AM -0800, Saurabh Singh Sengar wrote:
> On Wed, Feb 07, 2024 at 08:30:27AM -0800, Saurabh Singh Sengar wrote:
> > On Tue, Feb 06, 2024 at 04:07:15PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Dec 08, 2023 at 07:46:16PM -0800, Saurabh Sengar wrote:
> > > > Currently there is a race in calling pci_create_resource_files function
> > > > from two different therads, first therad is triggered by pci_sysfs_init
> > > > from the late initcall where as the second thread is initiated by
> > > > pci_bus_add_devices from the respective PCI drivers probe.
> ...

> > > Krzysztof has done a ton of work to convert these files to static
> > > attributes, where the device model prevents most of these races:
> > > 
> > >   506140f9c06b ("PCI/sysfs: Convert "index", "acpi_index", "label" to static attributes")
> > >   d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > >   f42c35ea3b13 ("PCI/sysfs: Convert "reset" to static attribute")
> > >   527139d738d7 ("PCI/sysfs: Convert "rom" to static attribute")
> > >   e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute")
> > > 
> > > and he even posted a series to do the same for the resource files:
> > > 
> > >   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/
> > > 
> > > I can't remember why we didn't apply that at the time, and it no
> > > longer applies cleanly, but I think that's the direction we should go.
> > 
> > Thanks for you review.
> > 
> > Please inform me if there's existing feedback explaining why this
> > series hasn't been merged yet. I am willing to further improve it
> > if necessary.
> 
> Let us know your opinion so that we can move ahead in fixing this
> long pending bug.

There's no feedback on the mailing list (I checked the link above), so
the way forward is to update the series so it applies cleanly again
and post it as a v3.

There's no need to wait for Krzysztof to refresh it, and if you have
time to do it, it would be very welcomed!  The best base would be
v6.8-rc1.

Bjorn

