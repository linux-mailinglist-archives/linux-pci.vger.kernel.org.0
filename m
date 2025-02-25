Return-Path: <linux-pci+bounces-22380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB28A44AFC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 19:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264BA7A818E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017731A0BF1;
	Tue, 25 Feb 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Il4np0V/"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B542A92;
	Tue, 25 Feb 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509986; cv=none; b=QNqaem1urrok93WthTQ84WBnXnHRs+UxSqe6yAD5d4OLqj5qnpg2NP3huT8yWDOJUOym+tEMk2ElPLouReoxBY1YwOjKXrkvrwHGhh6SuyRLCMONdZYyuk10nwUhf6UkTrv9M1G7pY3h6epmlrjG79HYV+m0j3yZkn38VfLekBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509986; c=relaxed/simple;
	bh=Wigl2FsqYmxJyBc4ERn+YB9RjLV0QGo/U0s1vheC0LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovVEUg1HfMkeNpgOgRnG1YYvh/Fd9sU0AnEJapYid5phIzPBoL9mhiXqH6jnaT5ANyW4Lirp7aNf9dJlkaVwH2EvfQ67bsI56hUQpd6BKgdjcl3qKBhDg8h+nSO1fnUEZPDahRcFVGQtRqG6TCcnw8eSN8f9Z0w7hhKTWfvVh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Il4np0V/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AB9ljJU6hupqi5kiFWkkvmg0CJkZV49z0sz6cU7yWuE=; b=Il4np0V/fmJ3czy7biz/1HHg+3
	4vkBKhbzgWJLbglgWGTiUUtaFfnOBjGb6lQUYpvh63i7LQcg6sxnujRsq1XjkmktEhz3xHOGM6KHE
	cktxuCH142ToHRCi2oagzyCfhe9DtZP5KzDVQB8r0S/+b89gEh235WRT56jn88gxDGSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tn09O-0000iL-Dy; Tue, 25 Feb 2025 19:59:26 +0100
Date: Tue, 25 Feb 2025 19:59:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <87c90b88-ea56-4b72-92f9-704cca28ae98@lunn.ch>
References: <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>
 <20250225160542.GA507421@bhelgaas>
 <20250225165746.GH53094@unreal>
 <7ff54e42-a76c-42b1-b95c-1dd2ee47fe93@lunn.ch>
 <354ce060-fc42-4c15-a851-51976aa653ad@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354ce060-fc42-4c15-a851-51976aa653ad@app.fastmail.com>

> Chmod solution is something that I thought, but for now I'm looking
> for the out of the box solution. Chmod still require from
> administrator to run scripts with root permissions.

It is more likely to be a udev rule. systemd already has lots of
examples:

/lib/udev/rules.d/50-udev-default.rules:KERNEL=="rfkill", MODE="0664"

	Andrew

