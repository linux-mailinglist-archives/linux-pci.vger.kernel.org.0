Return-Path: <linux-pci+bounces-17591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4719E2D3A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA3616547F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28191F76AB;
	Tue,  3 Dec 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx8u7IQs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B247189F56;
	Tue,  3 Dec 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258188; cv=none; b=pjEMiyK+XF3IOBAw4Iueg02OH+LU7Eb9zKgQcH8LfPuVe0cITuvkOKiNuuqyooRX4tdXCNaQAn+eXhjXKpHMSfBsiM4siAB11Qp8seWfk4V18Pl2n/zARBDmnOaO3O0JI/Vd+5HEiP8wGpKVkEUxu26aB1aBdG2f5udSLzPxeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258188; c=relaxed/simple;
	bh=17n+30ZBIWgyF8htSH+MQyV80Cpmpdms+2b9MZp8W6w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FvmfP7PRgVh3qGGqIsvuJhWQu1GBEBO2n5re63nI1bcoW/sRQBvyehOzyJou/qvCa1nELFJQA2fNv0NbNEXUhBBYqTpw+jp+ziuIlTtdxVfNsn8MuHLISyW5OougHgqYHmHY2nEo8rBj5yeQfTsvb15Ks2opdObVXVwDS21+QxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx8u7IQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8254C4CECF;
	Tue,  3 Dec 2024 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733258186;
	bh=17n+30ZBIWgyF8htSH+MQyV80Cpmpdms+2b9MZp8W6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bx8u7IQsui8vgTpontKGnOc1xgkxrU9jNRBiW19ZR+F0zzrV9qAzhWEQkdfevQpcC
	 GGJZtmXg8M7WUBDZEdj8nu71/IW6Uu8MofGX+T4a+7nNYYfZCmRLgFTFwmExU68Pdw
	 AfheFcEJQED0g6qtlI7W5vU/zQHo7PtspouzIaLDz15eDh4NsiwEgybCRBmD6+VW74
	 kE2ON7+OBfo3y3MzNkzpoTypw/QjfnjLE+5heiNm7iRMn9f9ZdByChUPauzZQmtfi3
	 QJYQ9PoVcLzbDGDU7Zm/5uKzpRbgx4JaDQpgAzMdEhBo4SbjG/Kbp7XM011EBR3jLM
	 9/5VaCaYGYG4g==
Date: Tue, 3 Dec 2024 14:36:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
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
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241203203625.GA2962643@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203174027.GK1245331@unreal>

[+cc Linux hardening folks for any security/reliability concerns]

On Tue, Dec 03, 2024 at 07:40:27PM +0200, Leon Romanovsky wrote:
> On Tue, Dec 03, 2024 at 09:24:56AM -0800, Stephen Hemminger wrote:
> > On Tue,  3 Dec 2024 14:15:28 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > > The Vital Product Data (VPD) attribute is not readable by regular
> > > user without root permissions. Such restriction is not needed at
> > > all for Mellanox devices, as data presented in that VPD is not
> > > sensitive and access to the HW is safe and well tested.
> > > 
> > > This change changes the permissions of the VPD attribute to be accessible
> > > for read by all users for Mellanox devices, while write continue to be
> > > restricted to root only.
> > > 
> > > The main use case is to remove need to have root/setuid permissions
> > > while using monitoring library [1].
> > > 
> > > [leonro@vm ~]$ lspci |grep nox
> > > 00:09.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]
> > > 
> > > Before:
> > > [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> > > -rw------- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> > > After:
> > > [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> > > -rw-r--r-- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> > > 
> > > [1] https://developer.nvidia.com/management-library-nvml
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > > Changelog:
> > > v3:
> > >  * Used | to change file attributes
> > >  * Remove WARN_ON
> > > v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
> > >  * Another implementation to make sure that user is presented with
> > >    correct permissions without need for driver intervention.
> > > v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
> > >  * Changed implementation from open-read-to-everyone to be opt-in
> > >  * Removed stable and Fixes tags, as it seems like feature now.
> > > v0:
> > > https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> > > ---
> > >  drivers/pci/vpd.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > > index a469bcbc0da7..a7aa54203321 100644
> > > --- a/drivers/pci/vpd.c
> > > +++ b/drivers/pci/vpd.c
> > > @@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
> > >  	if (!pdev->vpd.cap)
> > >  		return 0;
> > >  
> > > +	/*
> > > +	 * Mellanox devices have implementation that allows VPD read by
> > > +	 * unprivileged users, so just add needed bits to allow read.
> > > +	 */
> > > +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> > > +		return a->attr.mode | 0044;
> > > +
> > >  	return a->attr.mode;
> > >  }
> > 
> > Could this be with other vendor specific quirks instead?
> 
> In previous versions, I asked Bjorn about using quirks and the answer
> was that quirks are mainly to fix HW defects fixes and this change doesn't
> belong to that category.
> 
> https://lore.kernel.org/linux-pci/20241111214804.GA1820183@bhelgaas/

That previous proposal was driver-based, so VPD would only be readable
by unprivileged users after mlx5 was loaded.  VPD would be readable at
any time with either a quirk or the current patch.  The quirk would
require a new bit in pci_dev but has the advantage of getting the
Mellanox grunge out of the generic code.

My biggest concerns are that this exposes VPD data of unknown
sensitivity and exercises the sometimes-problematic device VPD
protocol for very little user benefit.  IIUC, the monitoring library
only wants this to identify the specific device variant in the user
interface; it doesn't need it to actually *use* the device.

We think these concerns are minimal for these devices (and I guess for
*all* present and future Mellanox devices), but I don't think it's a
great precedent.

Bjorn

