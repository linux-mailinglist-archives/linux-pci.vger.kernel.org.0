Return-Path: <linux-pci+bounces-22794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92536A4CD60
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3DC1734F6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C71C198A2F;
	Mon,  3 Mar 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRiilDaJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70788208A9;
	Mon,  3 Mar 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036677; cv=none; b=OJGezBG7IOEBgc8T8hrlXIYig4mbUQJYrbo4PQK+d/BNyEwBqGR6h5FQfeu02XrPautXDVh7zXPbvgGYx1raJiB9yCNEKWz0IjbafoyQaGZKkz+RVLrNgJxWAc8dEqkaKp7769GbVIc3JDkt7upnMcJ1bkmtagQq27JJrvSN77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036677; c=relaxed/simple;
	bh=AszVorE/EkhZ3+7Ol3HRuPVkQBoS4dyx8wSxtua6IrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mss27iTELHRY3HhBAuopWvhrUNUMrIOjsZWlywwnlq1IbHeIn7Xf4zlwH8/lXKJ3dRNKA4wPhz66sd3Xo0xD3AoOtKBRt8yRTxjg3XFluRrLTuHvFugEIfhdxosb36GlFO370qM5YbrAjJTfPNmd3nMMSMPGM3IaxzYPdRKiNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRiilDaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23BDC4CEE5;
	Mon,  3 Mar 2025 21:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741036676;
	bh=AszVorE/EkhZ3+7Ol3HRuPVkQBoS4dyx8wSxtua6IrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KRiilDaJbPT1FK63z1QwEwQrmw9dooZeXCICmsN3P4teawCAbeZ1m711+i6p5X7QD
	 eVJi8KTTCkxxqSNgC32BU3dotW/95ZM3Uo9eg8Cx9Bjj1yeh7vwHc9rT4z9ZeTjq9L
	 lghRj06gPac1pEY6rmbMk4VvSnQE7Yw/cdSWOHqP530Cq2X+gTb1uL4jsZVcCXh+FU
	 4+KNo/Zn4KyEZUiQb3fMgp/dgRrLY26v6+TKkCNu+Bzvp+8BLFmf8YM2v9A2noTjJ/
	 xJGP2sRcqeIKzfPK5nfkBresmYKnWMVkrmPj0k5ha2vnpxd7ZdaCoitIIHQU1FlwId
	 polAyf+ckX1Gg==
Date: Mon, 3 Mar 2025 15:17:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20250303211755.GA200634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9943382-8d53-4e28-b600-066ef470f889@app.fastmail.com>

On Tue, Feb 25, 2025 at 10:05:49PM +0200, Leon Romanovsky wrote:
> On Tue, Feb 25, 2025, at 20:59, Andrew Lunn wrote:
> >> Chmod solution is something that I thought, but for now I'm looking
> >> for the out of the box solution. Chmod still require from
> >> administrator to run scripts with root permissions.
> >
> > It is more likely to be a udev rule. 
> 
> Udev rule is one of the ways to run such script.
> 
> > systemd already has lots of examples:
> >
> > /lib/udev/rules.d/50-udev-default.rules:KERNEL=="rfkill", MODE="0664"

Where are we at with this?  Is a udev rule a feasible solution?

