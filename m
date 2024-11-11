Return-Path: <linux-pci+bounces-16484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B239C4875
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A741F226DD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78D41AC89A;
	Mon, 11 Nov 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qznPYQl3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8238F83;
	Mon, 11 Nov 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361686; cv=none; b=qhTXJcAnvtgG6wVREvMlaXZw0JitCqnJ6DxFemw3cPsQ+nLbVpu1+1tO2iDUGTUPVIRSsAL9Odbv4AocLmXx0i+5iVXv+o1uplWS7kYgPb43qQYRtVUFBMHz5vDmBVgcJqn2MNu0c+WbICBU0TVZwrXV5jv26oPtdYZA9Bp/m0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361686; c=relaxed/simple;
	bh=ZCOvFl3ljOT1d/HT5jzqQ4LIcu2lHhvhGjA+BbuEEmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M5DwxnRotsYw/2cim5RiAbUyR6/xlWP6eQH+HfhfIiz8d7TNaKJECvgEpTlY2tNfuVeTJFuqRAn40EzhXJd/Xt+ELRms0riNIu4Rsiz68AEgB1gMaxtAaG68GkeTPyOnVYLpDJEHilVO9htI8/rT8Bvm6LlcFXyNwwStnuE7BeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qznPYQl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ABCC4CED4;
	Mon, 11 Nov 2024 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731361686;
	bh=ZCOvFl3ljOT1d/HT5jzqQ4LIcu2lHhvhGjA+BbuEEmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qznPYQl3jtziu4z/tj4RY3NOvDxM30kU/1nSyuPM5WES7UoI2HjEZz0M6Mt+h9wZG
	 MUEABE7OsBKVw11hGt/a9b5lrIG3nJTa5AcjkJJGt7cuvTbM7VJu9kMxdMYzKqwzeG
	 qQ/eh9r0V5gT4paWPLU2PkNkvvPbHGMsjTVmjzwg7isERQc2JCfq6rbQFPOiD2asWJ
	 5XWG3WuCDbBajDyiJZpgafmA8bk8T7wMR3abM3YdIlMX8gxQAu3eU9AMWYwLBFVvpj
	 ORUjUVjL4XGSjxy28VRTmkDXI0GGIuH0kH4w3ps9POQiVPpOEXScrygFAYnSYJ5gYr
	 LKEQ4oZdaQlAg==
Date: Mon, 11 Nov 2024 15:48:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
	=?utf-8?Q?netdev=40vger=2Ekernel=2Eorg_Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241111214804.GA1820183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111211738.GD71181@unreal>

[+cc Thomas]

On Mon, Nov 11, 2024 at 11:17:38PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 11, 2024 at 02:41:04PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > The Vital Product Data (VPD) attribute is not readable by regular
> > > user without root permissions. Such restriction is not really needed
> > > for many devices in the world, as data presented in that VPD is not
> > > sensitive and access to the HW is safe and tested.
> > > 
> > > This change aligns the permissions of the VPD attribute to be accessible
> > > for read by all users, while write being restricted to root only.
> > > 
> > > For the driver, there is a need to opt-in in order to allow this
> > > functionality.
> > 
> > I don't think the use case is very strong (and not included at all
> > here).
> 
> I will add the use case, which is running monitoring application without
> need to be root. IMHO reducing number of applications that require
> privileged access is a very strong case. I personally try to avoid
> applications with root/setuid privileges.

Avoiding root/setuid is a very good thing.  I just don't think using
VPD directly from userspace is a great idea because VPD is so slow and
sometimes unreliable to read.  And apparently this is a pretty unusual
situation since I haven't heard similar requests for other devices.

Sort of ironic that some vendors, especially Intel and AMD, add new
Device IDs for devices that work exactly the same as their
predecessors, so we are continually adding to the pci_device_id
tables, while here we apparently the same Device ID is used for
devices that differ in ways we actually want to know about.

> > If we do need to do this, I think it's a property of the device, not
> > the driver.
> 
> But how will device inform PCI core about safe VPD read?
> Should I add new field to struct pci_device_id? Add a quirk?
> Otherwise, I will need to add a line "pci_dev->downgrade_vpd_read=true"
> to mlx5 probe function and it won't change a lot from current
> implementation.

To me it looks like a pci_dev bit, not a pci_driver bit.

I would set it .probe() so all the code is in one place.  And it's not
related to a device defect, as most quirks are.

Bjorn

