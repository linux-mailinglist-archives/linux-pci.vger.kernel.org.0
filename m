Return-Path: <linux-pci+bounces-16494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E259C4ECD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DCB22585
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9D18BBA2;
	Tue, 12 Nov 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUnVR+oO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D805234;
	Tue, 12 Nov 2024 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393376; cv=none; b=uZNAzfT7CGxNiSonOLfoUQrBQD8Ser99EoHtaAwzW36LXikAqUp8HgbIcVGp13xVPcKwmqBbpjiKE87QxBoMjcaHf4E5vRSEzwQHdYpRx8pf4f9AHRKm9MJRUfpURAh2YdWiqzfImmKpwHTvq0WJIAz7m3TPIbfebv8hg1vnXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393376; c=relaxed/simple;
	bh=Kx/2YcZVw5+1nJRqzUIuKgPpESgjehNlV9sTwiNF6JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlC22TpsQllivod6FAM9kBlgpJhgTK01XOZBOFqlAinZOa93GZTIuGOBqkwByyxlVVJzR3XBaiof+m/QjqMGTlH4nNSOSHxVIO/zW+byb7GLwDD86jqlh4j4B/zmoLOYWC5XNzYIQyXpVll+R02RZC1aEZF2KZmIRG43lzcI7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUnVR+oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3A5C4CECD;
	Tue, 12 Nov 2024 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731393375;
	bh=Kx/2YcZVw5+1nJRqzUIuKgPpESgjehNlV9sTwiNF6JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUnVR+oOFJH8wpxQGXof2oMeLxjYDgxwYUPZGdkB+pofFLVtj7JjD1xGjQdOMy43x
	 DJ8jNt9gB92lH+JtPPV+EM7m4/E4ApVV1rMGJ3ZcWM77mSyzdqVowiKTRQYGKE8RCz
	 SX8GWxzhyDd2LgVivexQeIOeH4LiLCdbUGHKFMCMD0Vz46/4Q+wopq0pG+JELJf9/J
	 +yIIHDQaR8km5NkICjN6UA2wipUaJQ64tNz0H2QQ8w6+rlrHRm40EdrDxmlRoCETr5
	 7RMdmquAu7kEjzDKG/BO0yOdYd5KEl1F+Wr9jrXmzdq7pXp8jzi64n0rADA97p+2qc
	 +5U1d3zHwPKpA==
Date: Tue, 12 Nov 2024 08:36:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?netdev=40vger=2Ekernel=2Eorg_Thomas_Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241112063608.GF71181@unreal>
References: <20241111211738.GD71181@unreal>
 <20241111214804.GA1820183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111214804.GA1820183@bhelgaas>

On Mon, Nov 11, 2024 at 03:48:04PM -0600, Bjorn Helgaas wrote:
> [+cc Thomas]
> 
> On Mon, Nov 11, 2024 at 11:17:38PM +0200, Leon Romanovsky wrote:
> > On Mon, Nov 11, 2024 at 02:41:04PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > The Vital Product Data (VPD) attribute is not readable by regular
> > > > user without root permissions. Such restriction is not really needed
> > > > for many devices in the world, as data presented in that VPD is not
> > > > sensitive and access to the HW is safe and tested.
> > > > 
> > > > This change aligns the permissions of the VPD attribute to be accessible
> > > > for read by all users, while write being restricted to root only.
> > > > 
> > > > For the driver, there is a need to opt-in in order to allow this
> > > > functionality.
> > > 
> > > I don't think the use case is very strong (and not included at all
> > > here).
> > 
> > I will add the use case, which is running monitoring application without
> > need to be root. IMHO reducing number of applications that require
> > privileged access is a very strong case. I personally try to avoid
> > applications with root/setuid privileges.
> 
> Avoiding root/setuid is a very good thing.  I just don't think using
> VPD directly from userspace is a great idea because VPD is so slow and
> sometimes unreliable to read.

This is one time operation during application initialization, which is
fast in our devices. It is used by the NVML https://developer.nvidia.com/management-library-nvml.

> And apparently this is a pretty unusual situation since I haven't heard
> similar requests for other devices.

Maybe they didn't bother to ask.

> 
> Sort of ironic that some vendors, especially Intel and AMD, add new
> Device IDs for devices that work exactly the same as their
> predecessors, so we are continually adding to the pci_device_id
> tables, while here we apparently the same Device ID is used for
> devices that differ in ways we actually want to know about.

I'm not Intel or AMD employee and never worked there, but from what I
heard it is not technical decision but outcome of how their development
process is structured.

> 
> > > If we do need to do this, I think it's a property of the device, not
> > > the driver.
> > 
> > But how will device inform PCI core about safe VPD read?
> > Should I add new field to struct pci_device_id? Add a quirk?
> > Otherwise, I will need to add a line "pci_dev->downgrade_vpd_read=true"
> > to mlx5 probe function and it won't change a lot from current
> > implementation.
> 
> To me it looks like a pci_dev bit, not a pci_driver bit.
> 
> I would set it .probe() so all the code is in one place.  And it's not
> related to a device defect, as most quirks are.

The advantage of quirks is that we will be able to set proper file
permissions from the beginning without need to load/bind driver.

As Thomas suggested, the vpd_attr_is_visible() will be something
like this, which is neat:

if (pdev->downgrade_vpd_read)
	return 644;
else
	return 600;

Thanks

> 
> Bjorn
> 

