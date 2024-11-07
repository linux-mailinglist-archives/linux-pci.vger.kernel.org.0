Return-Path: <linux-pci+bounces-16233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C69C052C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094C61C2254E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0220B1FC;
	Thu,  7 Nov 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BflWPUhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057A1E1043;
	Thu,  7 Nov 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981044; cv=none; b=prssGHZoGga3PNqzeQkyet3K0ryYBnIbxyJIRgtucaIY2o1l5FbBvYwAyQHxAGR/mBBcnX8B53wveCNcheEvurisEJZg6kSQMRc29nFBqwysXB+zCzmCBPxaGHQ2ctWlY//S71sHqg2KKx/hgJdv2UkVBOgkQVZac8+REqUm62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981044; c=relaxed/simple;
	bh=sArRfQxYfZMbU4cikQr6WIkfm8lZA8u6rZoXTALLxCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWPRgcPKScDm7udAKx3HwQGRZOkHPYWfMEqB1OdV1vDN0fRNB8s3SHudb5uC7U6nRoYTA9Xd5osD7pXeeGxAgD1YHcSqkkZWzQpFuO80K5bvxFkViE/N4OuV7VE/SEq9L1FyAf65NDm+7u6CbUheF2HJWmzHZBS5JFSl0jbiFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BflWPUhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC72C4CECE;
	Thu,  7 Nov 2024 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981044;
	bh=sArRfQxYfZMbU4cikQr6WIkfm8lZA8u6rZoXTALLxCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BflWPUhJYIFqeW3zSsVxyh0NT3DMX3jnwUuFKmhROEuiSvm8X6O4VsSDqT3oSQpC6
	 ieHY4miugx3sANh939P2rMLcQh6SyRa4hUS3CZRhSsGYF+KilCSElqSBppi6vQgzj/
	 WLv4zGAWrqNgJjwbL3G4JNNVNH2Q20Uc3NpSZch15jvegKLxr+vHPx/h8Q/A/ySzHX
	 FOc7GB2fKWgr2gf7ASFsVPtfY/RGtFuVHb/IkzXNxsooYsqy62v/MVSgP5Mp7Z9MuD
	 +LVOGXjXv2VVVtNurR999VgxrrpleHCzK8eajIVsxJCj+lzpG+KPy/xqXTY5udzjrz
	 q9wG6gAta9gUQ==
Date: Thu, 7 Nov 2024 14:03:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kernel-team@meta.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241107120357.GL5006@unreal>
References: <20241106122251.GC5006@unreal>
 <20241106171257.GA1529850@bhelgaas>
 <76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
 <20241106160958.6d287fd8@kernel.org>
 <20241107082327.GI5006@unreal>
 <b35f536e-1eb0-4b7b-85f4-df94d76927d6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35f536e-1eb0-4b7b-85f4-df94d76927d6@linux.dev>

On Thu, Nov 07, 2024 at 11:30:23AM +0000, Vadim Fedorenko wrote:
> On 07/11/2024 08:23, Leon Romanovsky wrote:
> > On Wed, Nov 06, 2024 at 04:09:58PM -0800, Jakub Kicinski wrote:
> > > On Wed, 6 Nov 2024 18:36:16 +0100 Andrew Lunn wrote:
> > > > > How would this be done in the PCI core?  As far as I can tell, all
> > > > > these registers are device-specific and live in some device BAR.
> > > > 
> > > > Is this a licences PCIe core?
> > > > 
> > > > Could the same statistics appear in other devices which licence the
> > > > same core? Maybe this needs pulling out into a helper?
> > > 
> > > The core is licensed but I believe the _USER in the defines names means
> > > the stats sit in the integration logic not the licensed IP. I could be
> > > wrong.
> > > 
> > > > If this is true, other uses of this core might not be networking
> > > > hardware, so ethtool -S would not be the best interfaces. Then they
> > > > should appear in debugfs?
> > > 
> > > I tried to push back on adding PCIe config to network tooling,
> > > and nobody listened. Look at all the PCI stuff in devlink params.
> > > Some vendors dump PCIe signal integrity into ethtool -S
> > 
> > Can you please give an example? I grepped various keywords and didn't
> > find anything suspicious.
> 
> Hmm...

Ohh, I looked in some other place.

> 
> [root@host ~]# ethtool -i eth0 | grep driver
> driver: mlx5_core
> [root@host ~]# ethtool -S eth0 | grep pci
>      rx_pci_signal_integrity: 1
>      tx_pci_signal_integrity: 1471
>      outbound_pci_stalled_rd: 0
>      outbound_pci_stalled_wr: 0
>      outbound_pci_stalled_rd_events: 0
>      outbound_pci_stalled_wr_events: 0
> 
> Isn't it a PCIe statistics?

I didn't do full archaeological research and stopped at 2017 there these
counters were updated to use new API, but it looks like they there from
stone age.

It was a mistake to put it there and they should be moved to PCI core
together with other hundreds debug counters which ConnectX devices have
but don't expose yet.

Thanks

