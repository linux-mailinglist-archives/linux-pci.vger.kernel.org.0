Return-Path: <linux-pci+bounces-15805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E701C9B95D6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154C81C2104B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E8613777F;
	Fri,  1 Nov 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQUY/eVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC0381BA;
	Fri,  1 Nov 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479661; cv=none; b=eMzIklZVkacAGvJs/hiHlNSgkWeyuoTYvYQNofrRZkJEWigod2EtmCdlGRtmSgIbAcnXaQrGXj3+x7fsKT99d2We/Pi7GMGTw8P8idn4qPfc5T9qOk4Z8tDMaIxwOEO+qn2+vN5+3O0SbV/CZuEITIvty9YlRiNH0lcU8H4QBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479661; c=relaxed/simple;
	bh=UzFU9/m7+8m26UU31xEOtmbcL1H29397cR78nXzZvQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oLMAb4+TmRSZ0opEP+cb/jYhLTRXQoYl6hxuE5i2mBEUoo5aNIAxpLOH5j1rWLoaLaMiUW5ziT2P+768la6HfucfMPaYvkMjfJjQ/sxa397eTQ3PzYmfnPpX/oNRmudAIPqiuh51dYppuyIXenAk2G/A7s67djwL7+IW+u2EhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQUY/eVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6410DC4CED2;
	Fri,  1 Nov 2024 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730479659;
	bh=UzFU9/m7+8m26UU31xEOtmbcL1H29397cR78nXzZvQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dQUY/eVdkZdoqqzYoThHXl3YdvB1WliybufHtqpun53iymC8wnsYleFG/dYrHLVcv
	 JDMmglYDYLLKS2nR1yVTkxDCCA5X4TZJaGVdDVo/KYU9obJCGGlwlsQTV0QRYnv+PP
	 NVESXti4uuHF+LltBtN7MPl5lxFQKnGpqp14A/OqkbDTi0/TDSOHqwEwcdyvpH05ZP
	 PKZjzrBB0+3pY0p4n+Ae9oqVw8AER9zE5J+ZyAX0t9vwhRRQihCrlmgTEqff7Qf91v
	 wAGOYP+WYepPCmY5+/b7eE+smKHzYfUUt/oo461qAJkWICHMl92px6AKdJbWv8hc3n
	 L+5WPPTcbBoxw==
Date: Fri, 1 Nov 2024 11:47:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20241101164737.GA1308861@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101143300.GA339254@unreal>

On Fri, Nov 01, 2024 at 04:33:00PM +0200, Leon Romanovsky wrote:
> On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > The Virtual Product Data (VPD) attribute is not readable by regular
> > > > user without root permissions. Such restriction is not really needed,
> > > > as data presented in that VPD is not sensitive at all.
> > > > 
> > > > This change aligns the permissions of the VPD attribute to be accessible
> > > > for read by all users, while write being restricted to root only.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Applied to pci/vpd for v6.13, thanks!
> > 
> > I think this deserves a little more consideration than I gave it
> > initially.
> > 
> > Obviously somebody is interested in using this; can we include some
> > examples so we know there's an actual user?
> 
> I'll provide it after the weekend.
> 
> > Are we confident that VPD never contains anything sensitive?  It may
> > contain arbitrary vendor-specific information, so we can't know what
> > might be in that part.
> 
> It depends on the vendor, but I'm pretty confident that any sane vendor who
> read the PCI spec will not put sensitive information in the VPD. The
> spec is very clear that this open to everyone.

I don't think the spec really defines "everyone" in this context, does
it?  The concept of privileged vs unprivileged users is an OS
construct, not really something the PCIe spec covers.

> > Reading VPD is fairly complicated and we've had problems in the past
> > (we have quirk_blacklist_vpd() for devices that behave
> > "unpredictably"), so it's worth considering whether allowing non-root
> > to do this could be exploited or could allow DOS attacks.
> 
> It is not different from any other PCI field. If you are afraid of DOS,
> you should limit to read all other fields too.

Reading VPD is much different than reading things from config space.

To read VPD, software needs to:

  - Mutex with any other read/write path

  - Write the VPD address to read to the VPD Address register, with F
    bit clear

  - Wait (with timeout) for hardware to set the F bit of VPD Address
    register

  - Read VPD information from the VPD Data register

  - Repeat as necessary

The address is 15 bits wide, so there may be up to 32KB of VPD data.
The only way to determine the actual length is to read the data and
parse the data items, which is vulnerable to corrupted EEPROMs and
hardware issues if we read beyond the implemented size.

The PCI core currently doesn't touch VPD until a driver or userspace
(via sysfs) reads or writes it, so this path is not tested on most
devices.

> > For reference, here are the fields defined in PCIe r6.0, sec 6.27.2
> > (although VPD can contain anything a manufacturer wants to put there):
> > 
> >   PN Add-in Card Part Number
> >   EC Engineering Change Level of the Add-in Card
> >   FG Fabric Geography
> >   LC Location
> >   MN Manufacture ID
> >   PG PCI Geography
> >   SN Serial Number
> >   TR Thermal Reporting
> >   Vx Vendor Specific
> >   CP Extended Capability
> >   RV Checksum and Reserved
> >   FF Form Factor
> >   Yx System Specific
> >   YA Asset Tag Identifier
> >   RW Remaining Read/Write Area
> > 
> > The Conventional PCI spec, r3.0, sec 6.4, says:
> > 
> >   Vital Product Data (VPD) is the information that uniquely defines
> >   items such as the hardware, software, and microcode elements of a
> >   system. The VPD provides the system with information on various FRUs
> >   (Field Replaceable Unit) including Part Number, Serial Number, and
> >   other detailed information. VPD also provides a mechanism for
> >   storing information such as performance and failure data on the
> >   device being monitored. The objective, from a system point of view,
> >   is to collect this information by reading it from the hardware,
> >   software, and microcode components.
> > 
> > Some of that, e.g., performance and failure data, might be considered
> > sensitive in some environments.
> 
> I'm enabling it for modern device which is compliant to PCI spec v6.0.
> Do you want me to add quirk_allow_vpd() to allow only specific devices to
> read that field? It is doable but not scalable.

None of these questions really has to do with old vs new devices.  An
"allow-list" quirk is possible, but I agree it would be a maintenance
headache.  To me it feels like VPD is kind of in the same category as
dmesg logs.  We try to avoid putting secret stuff in dmesg, but
generally distros still don't make it completely public.

> > > > ---
> > > > I added stable@ as it was discovered during our hardware ennoblement
> > > > and it is important to be picked by distributions too.
> > > > ---
> > > >  drivers/pci/vpd.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > > > index e4300f5f304f..2537685cac90 100644
> > > > --- a/drivers/pci/vpd.c
> > > > +++ b/drivers/pci/vpd.c
> > > > @@ -317,7 +317,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> > > >  
> > > >  	return ret;
> > > >  }
> > > > -static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> > > > +static BIN_ATTR_RW(vpd, 0);
> > > >  
> > > >  static struct bin_attribute *vpd_attrs[] = {
> > > >  	&bin_attr_vpd,
> > > > -- 
> > > > 2.46.2
> > > > 

