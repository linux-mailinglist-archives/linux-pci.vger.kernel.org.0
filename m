Return-Path: <linux-pci+bounces-16506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1119C4F67
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17B41F21AE6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584120ADE9;
	Tue, 12 Nov 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLCqXjqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63D20A5E1;
	Tue, 12 Nov 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396372; cv=none; b=rwZrWqMrqTpWmO0j44kIutwWcZKZaky6M3KM/pshyJJtqtyPDnicD21I5KXenilhQjcdmCuK0+2KIF2agMM7tAnlUIBqHksed5gaOypRUGshcJjBXFf5U+IJkz31a8hTcwvtg1H+bEfVCKwyWfxlXNxmzYpNP7pmrTKO9o6Vkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396372; c=relaxed/simple;
	bh=q939O7A3qiW+xOn2fPn2cBuGqkR5Gzeo6xoDVmbknmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C81AlQb8xBxm3yLJwPIdvWRaLbCJc6ODapbcSGI6LgsHa3wGysqfZbDhiQqYEfq1d0Ue44xjzgd++bmdJtLvPK1Iltf6unPXs056ssvJB8MtecXY/ntacEn3db49XH4kNJRTexfwm1Ut8URluwqf22blCmEgchn1AFkQO5fys68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLCqXjqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C782C4CECD;
	Tue, 12 Nov 2024 07:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731396371;
	bh=q939O7A3qiW+xOn2fPn2cBuGqkR5Gzeo6xoDVmbknmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLCqXjqIQFFw+fpLIsIXG+N+Xguv9JMHBtrDOPEYvW4911mX9wP6en3uCaEKs0mdX
	 zZ/EkPJmMxhaes7WqdCH1RvAbJaTKg6PA06WG4dNXyfZz/Vh9TY6i2TsQv93S8F9kk
	 PI3bgMw4pb+rouT12YM6GlWXsAjOK8MMgiXH11XLlAFAv4zWkZ9/tJezTgdTEf3dWY
	 /ByujXynDnG/6/1YI+yGh7K682iZRbSr3aoPzZ/QgDEicUJ0at8HvCy6/dkYzOKwT2
	 f8XZSXQ3aSM3D6GZwbvOKl3PPZXNey/x49VKlHTt1aCiW1HKhrJpfxObJHHW5IKP0C
	 VgVbQ+ZqTv9yQ==
Date: Tue, 12 Nov 2024 09:26:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
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
Message-ID: <20241112072604.GH71181@unreal>
References: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
 <20241111204104.GA1817395@bhelgaas>
 <20241111163430.7fad2a2a@hermes.local>
 <18463054-abcf-4809-870c-051b16234e9c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18463054-abcf-4809-870c-051b16234e9c@gmail.com>

On Tue, Nov 12, 2024 at 07:44:09AM +0100, Heiner Kallweit wrote:
> On 12.11.2024 01:34, Stephen Hemminger wrote:
> > On Mon, 11 Nov 2024 14:41:04 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> >> On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>> The Vital Product Data (VPD) attribute is not readable by regular
> >>> user without root permissions. Such restriction is not really needed
> >>> for many devices in the world, as data presented in that VPD is not
> >>> sensitive and access to the HW is safe and tested.
> >>>
> >>> This change aligns the permissions of the VPD attribute to be accessible
> >>> for read by all users, while write being restricted to root only.
> >>>
> >>> For the driver, there is a need to opt-in in order to allow this
> >>> functionality.  
> >>
> >> I don't think the use case is very strong (and not included at all
> >> here).
> >>
> >> If we do need to do this, I think it's a property of the device, not
> >> the driver.
> > 
> > I remember some broken PCI devices, which will crash if VPD is read.
> > Probably not worth opening this can of worms.
> 
> These crashes shouldn't occur any longer. There are two problematic cases:
> 1. Reading past end of VPD
>    This used to crash certain devices and was fixed by stop reading at
>    the VPD end tag.
> 2. Accessing VPD if device firmware isn't correctly loaded and initialized
>    This affects certain LSI devices, which are blacklisted so that PCI core
>    prevents VPD access.

Thanks for the information.

Bjorn,

After this response, do you still think that v0 [1] is not the right way
to change the read permission?

[1] https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/

> 

