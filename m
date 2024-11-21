Return-Path: <linux-pci+bounces-17175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E659D5138
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C164B2AEB0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7819CD1D;
	Thu, 21 Nov 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu6cVkon"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964E157485;
	Thu, 21 Nov 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208427; cv=none; b=E0sUPSFiOcm6MKe+muKll2WF10E/uIEoXHuTm++x69IDi020qv6XcfBGL/fPLwewnraE6IMCEFEmTF7k5qeT4qiy7qA8YrBZ442vicl/UdRACl4m9jiMVEXGb9KkeMVPN7rNPDHC2YJIFGO9P7Uv4JiCh6NY40UsNyqbv5J9/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208427; c=relaxed/simple;
	bh=n8F8RjdeJDVgwm6h9A7zBEWYUMJ5Ij30BUILMFj2NZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p17aEddB2hhCN5vFHk23zIj2mEdlanmZ3ZlX88HYNN5qv7UZmjpI2o5vAnFF0O+lqRy3mMg5/OiDONMX7WOAGobmc8h1fADAn9P4+n9dD5m0mkVm6cthPle1QF4Pd/aKgFemC+Ujv89CjYSl5KrLyfK9lq97S8DMTeJTcHL84Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu6cVkon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51205C4CECC;
	Thu, 21 Nov 2024 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732208427;
	bh=n8F8RjdeJDVgwm6h9A7zBEWYUMJ5Ij30BUILMFj2NZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iu6cVkonxdAz5QGbLucoWatLmqd+WFY0kmsGuRE6cpSQfhDhBf0VaO+MJ2J+izS8K
	 9ajq6P2NTQ8br3KsnnHAzNb+zluBR1G4iPcVCmW/+tDqeIJGqK1rbM3cBAgpKp2n+K
	 IXK5+4RoH8X6kQ01jNo097kLIQdwyHylEUEg3GdrZyXC0N78tgtOFOX9qVe/WDpu7y
	 8x17DlJv/IJGzvIdBDEROAQXpASmU/XaiqzZ2AhxsYtLMeyAxX8iW3yKkSuSq4iyDU
	 UPFCqFl2Dvt8lccQsHIJhO7BUGYXwCO40oAIuAVSPuLczm80d7K3Ody1PYZwrWz2He
	 XOoo9a4kHdETQ==
Date: Thu, 21 Nov 2024 19:00:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
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
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241121170020.GB160612@unreal>
References: <61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org>
 <20241121130127.5df61661@endymion.delvare>
 <20241121121301.GA160612@unreal>
 <20241121151116.4213c144@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121151116.4213c144@endymion.delvare>

On Thu, Nov 21, 2024 at 03:11:16PM +0100, Jean Delvare wrote:
> On Thu, 21 Nov 2024 14:13:01 +0200, Leon Romanovsky wrote:
> > On Thu, Nov 21, 2024 at 01:01:27PM +0100, Jean Delvare wrote:
> > > On Wed, 13 Nov 2024 14:59:58 +0200, Leon Romanovsky wrote:  
> > > > --- a/drivers/pci/vpd.c
> > > > +++ b/drivers/pci/vpd.c
> > > > @@ -332,6 +332,14 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> > > >  	if (!pdev->vpd.cap)
> > > >  		return 0;
> > > >  
> > > > +	/*
> > > > +	 * Mellanox devices have implementation that allows VPD read by
> > > > +	 * unprivileged users, so just add needed bits to allow read.
> > > > +	 */
> > > > +	WARN_ON_ONCE(a->attr.mode != 0600);
> > > > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > > > +		return a->attr.mode + 0044;  
> > > 
> > > When manipulating bitfields, | is preferred. This would make the
> > > operation safe regardless of the initial value, so you can even get rid
> > > of the WARN_ON_ONCE() above.  
> > 
> > The WARN_ON_ONCE() is intended to catch future changes in VPD sysfs
> > attributes. My intention is that once that WARN will trigger, the
> > author will be forced to reevaluate the latter if ( ... PCI_VENDOR_ID_MELLANOX)
> > condition and maybe we won't need it anymore. Without WARN_ON_ONCE, it
> > is easy to miss that code.
> 
> The default permissions are 10 lines above in the same file. Doesn't
> seem that easy to miss to me.
> 
> In my opinion, WARN_ON should be limited to cases where something really
> bad has happened. It's not supposed to be a reminder for developers to
> perform some code clean-up. Remember that WARN_ON has a run-time cost
> and it could be evaluated for a possibly large number of PCI devices
> (although admittedly VPD support seems to be present only in a limited
> number of PCI device).

Sorry about which run-time cost are you referring? This is slow path and
extra if() inside WARN_ON which has unlikely keyword, makes no difference
when accessing HW.

In addition, this check is for devices which already known to have VPD
(see pdev->vpd.cap check above).

> 
> Assuming you properly use | instead of +, then nothing bad will happen
> if the default permissions change, the code will simply become a no-op,
> until someone notices and deletes it. No harm done.
> 
> I'm not maintaining this part of the kernel so I can't speak or decide
> on behalf of the maintainers, but in my opinion, if you really want to
> leave a note for future developers, then a comment in the source code
> is a better way, as it has no run-time cost, and will also be found
> earlier by the developers (no need for run-time testing).

I don't have any strong feelings about this WARN_ON_ONCE, will remove.

Thanks

> 
> Thanks,
> -- 
> Jean Delvare
> SUSE L3 Support

