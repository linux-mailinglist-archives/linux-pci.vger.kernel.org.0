Return-Path: <linux-pci+bounces-15763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E819B870F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 00:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901E31F21B6A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D041DFD81;
	Thu, 31 Oct 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYKxfh4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55011CCB27;
	Thu, 31 Oct 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416975; cv=none; b=XdVl7gOntH2bMiA0X7/+QBiuSdbFyncLNPmucqzCY+I5DDPm0vM95PSg3NIl2t2EUpBU9xLkRJeIaBsN88ez4krzN9GS+NK48dtAF2h+4V6CbPV6uZAh82ovNLCyemzUqB3VYH3H0dB/YsyNNWtSsv+2m+t9UslH0Cr7B6Koz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416975; c=relaxed/simple;
	bh=asZM7vDHeArgA2yrx4dv6iD1NBcGk2IAAZr0BMlUTAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WT6D2HDItk53FPe0OvY6N8/yj+fWeSjkjugEvAQqk+BChxj4cnetyN2ljlyvPN1Pfozxn5/xJ5pEVdUEQtbadlSJriWFFN1XB7piT+TZKef+5t6A3UPwu+o0KSBzf8s4GXfdoFXPTjW9i6paXTsXf9ZSBqRsDWPG+51ewth7nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYKxfh4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7005C4CEC3;
	Thu, 31 Oct 2024 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730416974;
	bh=asZM7vDHeArgA2yrx4dv6iD1NBcGk2IAAZr0BMlUTAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OYKxfh4sBbe89S9W1hTXqjGFqBeNgcbnilwzgb5GtKLDDHlrm99ZBD0j1LXbFdCoq
	 nM2aXnxNRDTeFmO9WdTbvfh7fzkTjSWKHkYIt1T1mc0BxZJEDzxmzJaUNh8hhb4FTK
	 nSscXi2E7vQO8eKkUuRdQ7xZHwuptW+wutLwyp13IS6hcWn1/7gjQs1X30RZ7NBe3e
	 alIPRCNd9d85VKLWtKx8trYAHeAKZYBLXtsLsz41thxafIJOw4mspQXiJgMOk9cHPF
	 Og0PH+cDf7yUiIZ+S5CJJe9IdHuAulz1z9hhYzxIdOMzzFIVzzMiQpLg7hil/6EXxA
	 wvAqVMBRqrxpg==
Date: Thu, 31 Oct 2024 18:22:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Leon Romanovsky <leonro@nvidia.com>,
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
Message-ID: <20241031232252.GA1268406@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030000450.GA1180398@bhelgaas>

[+cc LKML etc, should PCI VPD be readable by non-root?]

On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The Virtual Product Data (VPD) attribute is not readable by regular

("Vital Product Data" is the term in the spec)

> > user without root permissions. Such restriction is not really needed,
> > as data presented in that VPD is not sensitive at all.
> > 
> > This change aligns the permissions of the VPD attribute to be accessible
> > for read by all users, while write being restricted to root only.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Applied to pci/vpd for v6.13, thanks!

I think this deserves a little more consideration than I gave it
initially.

Obviously somebody is interested in using this; can we include some
examples so we know there's an actual user?

Are we confident that VPD never contains anything sensitive?  It may
contain arbitrary vendor-specific information, so we can't know what
might be in that part.

Reading VPD is fairly complicated and we've had problems in the past
(we have quirk_blacklist_vpd() for devices that behave
"unpredictably"), so it's worth considering whether allowing non-root
to do this could be exploited or could allow DOS attacks.

For reference, here are the fields defined in PCIe r6.0, sec 6.27.2
(although VPD can contain anything a manufacturer wants to put there):

  PN Add-in Card Part Number
  EC Engineering Change Level of the Add-in Card
  FG Fabric Geography
  LC Location
  MN Manufacture ID
  PG PCI Geography
  SN Serial Number
  TR Thermal Reporting
  Vx Vendor Specific
  CP Extended Capability
  RV Checksum and Reserved
  FF Form Factor
  Yx System Specific
  YA Asset Tag Identifier
  RW Remaining Read/Write Area

The Conventional PCI spec, r3.0, sec 6.4, says:

  Vital Product Data (VPD) is the information that uniquely defines
  items such as the hardware, software, and microcode elements of a
  system. The VPD provides the system with information on various FRUs
  (Field Replaceable Unit) including Part Number, Serial Number, and
  other detailed information. VPD also provides a mechanism for
  storing information such as performance and failure data on the
  device being monitored. The objective, from a system point of view,
  is to collect this information by reading it from the hardware,
  software, and microcode components.

Some of that, e.g., performance and failure data, might be considered
sensitive in some environments.

> > ---
> > I added stable@ as it was discovered during our hardware ennoblement
> > and it is important to be picked by distributions too.
> > ---
> >  drivers/pci/vpd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index e4300f5f304f..2537685cac90 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -317,7 +317,7 @@ static ssize_t vpd_write(struct file *filp, struct kobject *kobj,
> >  
> >  	return ret;
> >  }
> > -static BIN_ATTR(vpd, 0600, vpd_read, vpd_write, 0);
> > +static BIN_ATTR_RW(vpd, 0);
> >  
> >  static struct bin_attribute *vpd_attrs[] = {
> >  	&bin_attr_vpd,
> > -- 
> > 2.46.2
> > 

