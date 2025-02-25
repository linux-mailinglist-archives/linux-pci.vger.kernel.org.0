Return-Path: <linux-pci+bounces-22358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F1A4474A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523F03A712F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B373433A0;
	Tue, 25 Feb 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkMW0v+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBE21ABC4;
	Tue, 25 Feb 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502672; cv=none; b=AWRMq7MsnYKhaekt+U1Pls1X7hhUBvto1osx0/JUQ90DTipWeeiiNkqk9H5PHGaHdbXXhsYTcbDwiaFO2To2XKgKJZCipin3K5ws5Q6kp7QvqONBxoY8l48/PT9Jr7LU/MXeZsbJNqAklJwGywASb21oZtvS/tcQa547TaQPpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502672; c=relaxed/simple;
	bh=qadF+V0pCnFQNycLz+FvUseJRs1YmaEo0AdSamAZ7zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxmgXXy3yIrjnXVmpOZ9Qxc/MBswewwXIgYpdIq/5vOFQgq38CsizEdhbHctWhydRfkLHjal65fLVualib7rtF8aIMjCkUqsZIbrcF3tsAP8DNbxn03UggHGxUXR0urceGVXmFoNH+CaK/ew0h7SYnj2vey39CgKK7lQknysd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkMW0v+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0296CC4CEDD;
	Tue, 25 Feb 2025 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740502671;
	bh=qadF+V0pCnFQNycLz+FvUseJRs1YmaEo0AdSamAZ7zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkMW0v+iW9ctHfiu3Qcq3SQLpY+OEbUio/MjSX4deqcR6Bpb87ooZrB7Y68V22dxG
	 dZWzG9Zwfh6lhxscJsRHGaoivs+A6QRXF1cJYH3uolKkA1X3dhc97KkH0RdAuAAgTc
	 DxRVBFCGdY4IxaAYv6LVoFpU2r7Xr8KxMoaT44tXGbW/GPJAV016sGnFxWZDmLHBpw
	 jyedUAZIzFE2Dm4We9hmaY5F02LucYFBFcwgXSHxhEPF1rdk4CY2bmoXE/aSrq5a4t
	 vvis4/fewAytbGhaOO9fIAxwmvRbs4RGxRhglxoUay349tnmAzfIEEkhbCK1ZrQG9l
	 mkUTAPEtDa75g==
Date: Tue, 25 Feb 2025 18:57:46 +0200
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
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20250225165746.GH53094@unreal>
References: <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>
 <20250225160542.GA507421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225160542.GA507421@bhelgaas>

On Tue, Feb 25, 2025 at 10:05:42AM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 19, 2025 at 09:27:54AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The Vital Product Data (VPD) attribute is not readable by regular
> > user without root permissions. Such restriction is not needed at
> > all for Mellanox devices, as data presented in that VPD is not
> > sensitive and access to the HW is safe and well tested.
> > 
> > This change changes the permissions of the VPD attribute to be accessible
> > for read by all users for Mellanox devices, while write continue to be
> > restricted to root only.
> > 
> > The main use case is to remove need to have root/setuid permissions
> > while using monitoring library [1].
> 
> As far as I can tell, this is basically a device identification
> problem, which would be better handled by the Vendor, Device, and
> Revision IDs.  If that would solve the problem, it would also make
> standard unprivileged lspci output more specific.

Yes, unfortunately these devices have same IDs as "regular" NICs and the
difference in some FW configuration.

> 
> VPD has never been user readable, so I assume you have some existing
> method for device identification?

We always read VPD by using "sudo ..." command, until one of our customers
requested to provide a way to run monitoring library without any root access.
It runs on hypervisor and being non-root there is super important for them.

> 
> Other concerns raised in previous threads include:
> 
>   - Potential for sensitive information in VPD, similar to dmesg and
>     dmidecode
> 
>   - Kernel complexity of reading VPD (mutex, address/data registers)
> 
>   - Performance and potential denial of service as a consequence of
>     mutex and hardware interaction
> 
>   - Missing EEPROMs or defective or incompletely-installed firmware
>     breaking VPD read
> 
>   - Broken devices that crash when VPD is read

This patch allows non-root read for Mellanox (NICs) devices only and
such access is going to be used only once during library initiation
flow. So nothing from above is applicable in our case.

In general case, all devices in the world were accessed at least once
with "sudo lspci ....", during their bringup, installation, daily use
e.t.c. Broken devices are filtered by kernel and have limited access
to VPD.

So if it is broken, it will be broken with sudo too.

> 
>   - Potential for issues with future Mellanox devices, even though all
>     current ones work fine

It is not different from any other feature. MLNX devices exist for more
than 25 years already and we never exposed anything sensitive through VPD.

I'm confident that we have no plans to change this policy in the future
either.

> 
> This is basically similar to mmapping a device BAR, for which we also
> require root.

It is kernel controlled exposure, through well defined sysfs file and
in-kernel API for very specific PCI section. Device BAR is much more
than that.

Thanks

> 
> > [leonro@vm ~]$ lspci |grep nox
> > 00:09.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]
> > 
> > Before:
> > [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> > -rw------- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> > After:
> > [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> > -rw-r--r-- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> > 
> > [1] https://developer.nvidia.com/management-library-nvml
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v4:
> >  * Change comment to the variant suggested by Stephen
> > v3: https://lore.kernel.org/all/18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org
> >  * Used | to change file attributes
> >  * Remove WARN_ON
> > v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
> >  * Another implementation to make sure that user is presented with
> >    correct permissions without need for driver intervention.
> > v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
> >  * Changed implementation from open-read-to-everyone to be opt-in
> >  * Removed stable and Fixes tags, as it seems like feature now.
> > v0: https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> > ---
> >  drivers/pci/vpd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index a469bcbc0da7..c873ab47526b 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> >  	if (!pdev->vpd.cap)
> >  		return 0;
> >  
> > +	/*
> > +	 * On Mellanox devices reading VPD is safe for unprivileged users,
> > +	 * so just add needed bits to allow read.
> > +	 */
> > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > +		return a->attr.mode | 0044;
> > +
> >  	return a->attr.mode;
> >  }
> >  
> > -- 
> > 2.47.1
> > 

