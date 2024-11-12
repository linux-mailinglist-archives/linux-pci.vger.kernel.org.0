Return-Path: <linux-pci+bounces-16605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A279C6591
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428E0B267D8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AB205ABD;
	Tue, 12 Nov 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+BKtKOS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F61531C4;
	Tue, 12 Nov 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448101; cv=none; b=JQ+0rsT/4Xcmgk4u3033hiTusMjFj7lXstYtcWwuzEzErTYJ3KbcPkPxErjqiLxeZKTkgVeDiqveQuPqz4VxaDbTvjUZT5NBVK12X+Vu0dKMSQQG6E0TTSgEXDgf5+B1JKXeRbxX0wSoOOi0nbjpLJ5ZzcpaZ5EbtXxrMkJ0kAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448101; c=relaxed/simple;
	bh=lw8zICoswkgeMSGHN3Ubcpal3X9B8IwqRNZ1wT7ecpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rMeCJG0yRVmIUfFyt2POfZy0IgEK7dx35py88Cbnt0UFduAnvcYnFEN1bVfgDuQTw3kKjbmP+8yWiC2C6yGxV7xfFgNOaTvdlGim7Sg5JeWo2OMbIeJExcJyL10s3H5HTvGjakfyw0/MSsmseHm/BgHP1tmjP5YJMteikle9o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+BKtKOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFFDC4CECD;
	Tue, 12 Nov 2024 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731448100;
	bh=lw8zICoswkgeMSGHN3Ubcpal3X9B8IwqRNZ1wT7ecpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q+BKtKOSVQGX0Wy7XL5gB0l1an6/h1w0RDoCqOhLdPTNgWrZVTcPaCw7HdjoxOP2y
	 H2+xkH9RpaBqyyQxmOPLIny93E1Rby0bF5eX/cEHHsLqW7frT43ztNiDaDxAxSCBU/
	 s6KV7vX+HB6o0uA4hDi4Bfb1g/n+Bt+bh0C0D/EnI0TDBE/mssNimGcb0KXRWTKpB/
	 qzIv9nBXtsdHoJVRE76ZUw4MoWcBW73s6p5A91kcwJ0BCcRKmiVpNiZvcg83g+shrj
	 d1ySqhkmJZM14SeFwaWvV/VeQXSMYM2hErkoP2y2Z/vbOTZVLxdCYZ+UEvY3VeD8W9
	 x5DcbIBHmQqIA==
Date: Tue, 12 Nov 2024 15:48:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>, Arun Easi <aeasi@marvell.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
Message-ID: <20241112214819.GA1862173@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112072604.GH71181@unreal>

On Tue, Nov 12, 2024 at 09:26:04AM +0200, Leon Romanovsky wrote:
> On Tue, Nov 12, 2024 at 07:44:09AM +0100, Heiner Kallweit wrote:
> > On 12.11.2024 01:34, Stephen Hemminger wrote:
> > > On Mon, 11 Nov 2024 14:41:04 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > 
> > >> On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> > >>> From: Leon Romanovsky <leonro@nvidia.com>
> > >>>
> > >>> The Vital Product Data (VPD) attribute is not readable by regular
> > >>> user without root permissions. Such restriction is not really needed
> > >>> for many devices in the world, as data presented in that VPD is not
> > >>> sensitive and access to the HW is safe and tested.
> > >>>
> > >>> This change aligns the permissions of the VPD attribute to be accessible
> > >>> for read by all users, while write being restricted to root only.
> > >>>
> > >>> For the driver, there is a need to opt-in in order to allow this
> > >>> functionality.  
> > >>
> > >> I don't think the use case is very strong (and not included at all
> > >> here).
> > >>
> > >> If we do need to do this, I think it's a property of the device, not
> > >> the driver.
> > > 
> > > I remember some broken PCI devices, which will crash if VPD is read.
> > > Probably not worth opening this can of worms.
> > 
> > These crashes shouldn't occur any longer. There are two problematic cases:
> > 1. Reading past end of VPD
> >    This used to crash certain devices and was fixed by stop reading at
> >    the VPD end tag.
> > 2. Accessing VPD if device firmware isn't correctly loaded and initialized
> >    This affects certain LSI devices, which are blacklisted so that PCI core
> >    prevents VPD access.
> 
> Thanks for the information.
> 
> Bjorn,
> 
> After this response, do you still think that v0 [1] is not the right way
> to change the read permission?
> 
> [1] https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/

Yes, I still think it's unnecessarily risky to make VPD readable
by ordinary users.  This is a pretty niche use case.

Bjorn

