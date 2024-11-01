Return-Path: <linux-pci+bounces-15799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE59B9349
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D937281DC7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701519D8B7;
	Fri,  1 Nov 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwY1Ij/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CC49620;
	Fri,  1 Nov 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471585; cv=none; b=nlUiVVHIY3YlF8uXKt0oV+Er4VX8V7TzrllDScuvhzS7FVswEDQvKMiFI4nRrDBnn+DBzyMyFwk3FtGBfmPqaIB9NLVfo2lPxS6YjjuZX87AIADG0MQDPsE2hIyq+LncC662xkMKODT7/Ylraf/k/WQIr+504Dp9xs9Bdiw0qKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471585; c=relaxed/simple;
	bh=x1MFIlrq983aA1zhdDdyRFlFPXuG4uelI91cf+CH7U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMnHGzILsG5IoETQxCB6RpnIeaKAnr4Tb+GF+knFJaQS6uEn03bcxoz4/1UeDyVO5CgMufkjTmJyna3RGvc+zqY7qxGPeH/XD79HX8ZaMwaeE8TjXEBglQtm8G1Bm1w1NWdGm9sbzSpXOnMHqveT9N6L/S4EImiZHuzQ+ZqGXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwY1Ij/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5650CC4CECD;
	Fri,  1 Nov 2024 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471585;
	bh=x1MFIlrq983aA1zhdDdyRFlFPXuG4uelI91cf+CH7U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwY1Ij/atUpmiedAf63d4Qkz5Rw2KILs3e85eW5X1ZiKa6RCgFLx2Rvdk9nQro9UZ
	 lxvVIPDczvHWjVsjI0AttYyroeHBxgqL/6pwIjIPXiby1XfLuHEMnXJEmV7J/v3sT1
	 WJ6GdFHrMB8fCFxyL8dCpdiNVbAGOpMfFjt3mu7S0Lzu0M4QuzKmNz3gqsQ0pu16Gi
	 9DRNk6oSw8D9dpVp9AgVBqH1DFuyd9LRtl+ilAYYeKWhyWbcFPaBm2FZEf59hsZOJX
	 OLup2EqnTqk1yPMhniPkD/Stpoi1YA2eu+ijiB1NHX90teMeMIvUcYrGI5AWbSiAE3
	 iU9hx3JhTnZtQ==
Date: Fri, 1 Nov 2024 16:33:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Message-ID: <20241101143300.GA339254@unreal>
References: <20241030000450.GA1180398@bhelgaas>
 <20241031232252.GA1268406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031232252.GA1268406@bhelgaas>

On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
> [+cc LKML etc, should PCI VPD be readable by non-root?]
> 
> On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > The Virtual Product Data (VPD) attribute is not readable by regular
> 
> ("Vital Product Data" is the term in the spec)

Ohh, sorry for the confusion. I relied to much on auto-completion.

> 
> > > user without root permissions. Such restriction is not really needed,
> > > as data presented in that VPD is not sensitive at all.
> > > 
> > > This change aligns the permissions of the VPD attribute to be accessible
> > > for read by all users, while write being restricted to root only.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Applied to pci/vpd for v6.13, thanks!
> 
> I think this deserves a little more consideration than I gave it
> initially.
> 
> Obviously somebody is interested in using this; can we include some
> examples so we know there's an actual user?

I'll provide it after the weekend.

> 
> Are we confident that VPD never contains anything sensitive?  It may
> contain arbitrary vendor-specific information, so we can't know what
> might be in that part.

It depends on the vendor, but I'm pretty confident that any sane vendor who
read the PCI spec will not put sensitive information in the VPD. The
spec is very clear that this open to everyone.

> 
> Reading VPD is fairly complicated and we've had problems in the past
> (we have quirk_blacklist_vpd() for devices that behave
> "unpredictably"), so it's worth considering whether allowing non-root
> to do this could be exploited or could allow DOS attacks.

It is not different from any other PCI field. If you are afraid of DOS,
you should limit to read all other fields too.

> 
> For reference, here are the fields defined in PCIe r6.0, sec 6.27.2
> (although VPD can contain anything a manufacturer wants to put there):
> 
>   PN Add-in Card Part Number
>   EC Engineering Change Level of the Add-in Card
>   FG Fabric Geography
>   LC Location
>   MN Manufacture ID
>   PG PCI Geography
>   SN Serial Number
>   TR Thermal Reporting
>   Vx Vendor Specific
>   CP Extended Capability
>   RV Checksum and Reserved
>   FF Form Factor
>   Yx System Specific
>   YA Asset Tag Identifier
>   RW Remaining Read/Write Area
> 
> The Conventional PCI spec, r3.0, sec 6.4, says:
> 
>   Vital Product Data (VPD) is the information that uniquely defines
>   items such as the hardware, software, and microcode elements of a
>   system. The VPD provides the system with information on various FRUs
>   (Field Replaceable Unit) including Part Number, Serial Number, and
>   other detailed information. VPD also provides a mechanism for
>   storing information such as performance and failure data on the
>   device being monitored. The objective, from a system point of view,
>   is to collect this information by reading it from the hardware,
>   software, and microcode components.
> 
> Some of that, e.g., performance and failure data, might be considered
> sensitive in some environments.

I'm enabling it for modern device which is compliant to PCI spec v6.0.
Do you want me to add quirk_allow_vpd() to allow only specific devices to
read that field?a It is doable but not scalable.

> 
> > > ---
> > > I added stable@ as it was discovered during our hardware ennoblement
> > > and it is important to be picked by distributions too.
> > > ---
> > >  drivers/pci/vpd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > > index e4300f5f304f..2537685cac90 100644
> > > --- a/drivers/pci/vpd.c
> > > +++ b/drivers/pci/vpd.c
> > > @@ -317,7 +317,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> > >  
> > >  	return ret;
> > >  }
> > > -static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> > > +static BIN_ATTR_RW(vpd, 0);
> > >  
> > >  static struct bin_attribute *vpd_attrs[] = {
> > >  	&bin_attr_vpd,
> > > -- 
> > > 2.46.2
> > > 

