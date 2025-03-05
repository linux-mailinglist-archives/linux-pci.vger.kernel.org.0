Return-Path: <linux-pci+bounces-22977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705B5A50304
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481913A8CEF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC924E4A0;
	Wed,  5 Mar 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSnB5a7A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA4221F29;
	Wed,  5 Mar 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186726; cv=none; b=YIe6wAdsxdiYZGO+TaBnJvbH8VZzr6GR0ixnJfj1yCW0lsw8x5hcn+UaDQExPn/rvy9jb9nBN3zwf/bG3biW7msijH8YoWMYRw7pXgn3TJM+lVHSP0GL9rsNvrX/DIMtdyuwFHk0ap2hhOEGRIWIEqLcIUbEHCYlLk/yu07tR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186726; c=relaxed/simple;
	bh=Nd9LKiZdEmzhIpVHrWH7DXwsIOp8YfTpIO06tWiWmHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoL7u9YUsjKZh/GP9nUPbgP2dedHBM9nvoy3ZP4FbLp+51nDHTi2HPOKAeTj7uzILCdfbNsm1K/qpjlntZnn+uyCFM9gQzwItzMp9AVvKOxuhY7qCBXz/g8LgWzoBhElmCtrUVJ4F0WpTF4k/nGgx7Nnhs/8NkXRVBFZP3HQw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSnB5a7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7628C4CEE2;
	Wed,  5 Mar 2025 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186726;
	bh=Nd9LKiZdEmzhIpVHrWH7DXwsIOp8YfTpIO06tWiWmHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSnB5a7AcB+xE7+u6TalfWP85FtxWwaylB6xPoIplMqdiTBP5ZOMMmqvc8E4wosHA
	 8ijS4ytl6En+13X78HQSl/HJqXufHgffaj7l8hD2mjkuyPVOUyqEpm0FwxBgTW0xys
	 ghH1Ieuh74LfpqozvOOEnw5SikVo1bImN0RHc13jzMbNyFykNu3s7Hqw9v77F/FTKO
	 lQUIc6LfCGQww7GNw6t3wh11xSyOWHjn25wcwQEyCVpVENrHjl+EomA2XSzCsCWMH6
	 FV1lA1LYhKEhyxe0ay7REq0olIL3TBP2Ag1Pc6d9wINlTUvBdOy3tQyfh2nGywAej3
	 exxiYwuTqtlhQ==
Date: Wed, 5 Mar 2025 16:58:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20250305145841.GL1955273@unreal>
References: <e9943382-8d53-4e28-b600-066ef470f889@app.fastmail.com>
 <20250303211755.GA200634@bhelgaas>
 <20250304074512.GC1955273@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304074512.GC1955273@unreal>

On Tue, Mar 04, 2025 at 09:45:12AM +0200, Leon Romanovsky wrote:
> On Mon, Mar 03, 2025 at 03:17:55PM -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 25, 2025 at 10:05:49PM +0200, Leon Romanovsky wrote:
> > > On Tue, Feb 25, 2025, at 20:59, Andrew Lunn wrote:
> > > >> Chmod solution is something that I thought, but for now I'm looking
> > > >> for the out of the box solution. Chmod still require from
> > > >> administrator to run scripts with root permissions.
> > > >
> > > > It is more likely to be a udev rule. 
> > > 
> > > Udev rule is one of the ways to run such script.
> > > 
> > > > systemd already has lots of examples:
> > > >
> > > > /lib/udev/rules.d/50-udev-default.rules:KERNEL=="rfkill", MODE="0664"
> > 
> > Where are we at with this?  Is a udev rule a feasible solution?
> 
> We asked customer if this can work for him and still didn't get answer.
> I don't know if they have systemd/udev in their hypervisors.

We still didn't get any update, so let's drop this patch for now.

Thanks

> 
> Thanks
> 

