Return-Path: <linux-pci+bounces-17585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2469E2987
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 18:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763AA1689C5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920651FBC9E;
	Tue,  3 Dec 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIF0xXaJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1B1F8AD2;
	Tue,  3 Dec 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247633; cv=none; b=IwY8YHy277/AbM3CHyMns6pgJyfSlYMvT8tLfutuyuDzAmjfa2+Qn2xUYqXU666ztn5CVFrHT8bizNklb0TwaM6uxfXjo48agUJjYtUoei9hOAd6dA8Ehj29QdDz6F7iMAqdAbsPqELHVgc3BhWKgo/DHGeeK9wdmWb7JIsrYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247633; c=relaxed/simple;
	bh=JVxnQB3YiNFwYmPRcTY5PbfjrO33ScuIbRHk2z9VhNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtJnL+90cXtwNDZHkH/K5MytV5TZdjk2yUBCa4Us3VVWLG68ZSRrYJyXlPo/+engOP2UV2CEY01APFBO1KUwxz4uFnQEkN1hy1h2jXjktTpQQ/WXIw7Izsd0MPxDnUY5oHao//kKohr4GiJbg8CM/InTgfV5fFQgM+BpY4dChvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIF0xXaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9EEC4CECF;
	Tue,  3 Dec 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733247632;
	bh=JVxnQB3YiNFwYmPRcTY5PbfjrO33ScuIbRHk2z9VhNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIF0xXaJUWSDV3HPcTEmBBjCCzzuroPOVgBSWktcnaRWOSOrebfBkWSEK+oS02taX
	 f8z4mnuUAOhk+Zx8Oz72U90HVCGv9aDIxylHJFX7t60xEANNf/zB9EKHYr19QxQiMc
	 fFAT8AYlWWBAZWrdvk+oPHaZ2DP1/6B0TcPOaG1czg8XrixMcN4CW9VtlBBNn3xFug
	 S3UcRfyDUFNKY6LHYnzVcmZ08Mh43tnGBtOCLrUxVz+DIH034iEOR82tPfol6+GKw8
	 ibli5PkOAQpF5RivOoj7u75bNlMzb0X1kBYlIAPEr3pG5Kk0oab/ocOw2YZbm7Zc4t
	 izODEXmjxK+Ew==
Date: Tue, 3 Dec 2024 19:40:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
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
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v3] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241203174027.GK1245331@unreal>
References: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
 <20241203092456.5dde2476@hermes.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203092456.5dde2476@hermes.local>

On Tue, Dec 03, 2024 at 09:24:56AM -0800, Stephen Hemminger wrote:
> On Tue,  3 Dec 2024 14:15:28 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
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
> > 
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
> > v3:
> >  * Used | to change file attributes
> >  * Remove WARN_ON
> > v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
> >  * Another implementation to make sure that user is presented with
> >    correct permissions without need for driver intervention.
> > v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
> >  * Changed implementation from open-read-to-everyone to be opt-in
> >  * Removed stable and Fixes tags, as it seems like feature now.
> > v0:
> > https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> > ---
> >  drivers/pci/vpd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index a469bcbc0da7..a7aa54203321 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> >  	if (!pdev->vpd.cap)
> >  		return 0;
> >  
> > +	/*
> > +	 * Mellanox devices have implementation that allows VPD read by
> > +	 * unprivileged users, so just add needed bits to allow read.
> > +	 */
> > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > +		return a->attr.mode | 0044;
> > +
> >  	return a->attr.mode;
> >  }
> >  
> 
> Could this be with other vendor specific quirks instead?

In previous versions, I asked Bjorn about using quirks and the answer
was that quirks are mainly to fix HW defects fixes and this change doesn't
belong to that category.

https://lore.kernel.org/linux-pci/20241111214804.GA1820183@bhelgaas/

> 
> Also, the wording of the comment is awkward. Suggest:
> 	On Mellanox devices reading VPD is safe for unprivileged users.

Thanks

