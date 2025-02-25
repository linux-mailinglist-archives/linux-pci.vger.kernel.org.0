Return-Path: <linux-pci+bounces-22352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E830A4456F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7630617E396
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B1189912;
	Tue, 25 Feb 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+A2GzTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98215DBB3;
	Tue, 25 Feb 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499545; cv=none; b=DVpyWO7rWtN+g59jbjkWmKCs8bgGOq0eI+L7085hDkOTk+vP/0wmHhO0QtjVa9k7ZjqlLepDeRCpVUQGObNRsWeYL34/v+LcXeYoWBX3N1y7tL47IzsAV+HFBK1u5vY4baLbIGVJXHlHwfSv2HsldJiMnj5TeENz18xpYWUEhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499545; c=relaxed/simple;
	bh=tlTvOMZwj97UVNjSaaTvJei+ugzd5xJk1GS03Pt4Yhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Uved1QGIGLDbIpktCio4NF+dmA65hTCqRjo6NnDQVGftpvMLQdrqQTCegLKGTpRjPKmS9m6xbrd1py1bM3gk0UPZ2emMaTHIhnnsPACyEni+XXbqLKE9DVqXpIukxk/TrqmWWbwvzL0ZkryC/dgCiqHLf4vtFH+F30CWj36lZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+A2GzTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5615C4CEDD;
	Tue, 25 Feb 2025 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740499543;
	bh=tlTvOMZwj97UVNjSaaTvJei+ugzd5xJk1GS03Pt4Yhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g+A2GzTSFFbK4mzi4EkihsKJcLfvmGL2MOcrFjgSVZwq+NsA1SqgBighAyr48AEYv
	 u/2dpAxXLjx2gV+hujvr5fA6iCxr7DCPRYBYwN+Nw0wCrb1skECCvYy5FJVvc4phck
	 JzkHj6J5yooVncOgCMlLffNHBJADthz/UQ97vD16srnbnh5q58AtCiH+uo/mCHFH8V
	 Aa4BFZf7Bw8Kswb4R3lBa1RPZQWn4/LcNiRFUA0IQGyTGYA9SRnXDI/y0Fc4jMZckw
	 /Sm76hNf593+fBfpLQPGzASwx5sD+zBP/CHJ79MbDbBgdN/qkM2gikgF1mXKXe8dfG
	 Lqy7IjqZba8qg==
Date: Tue, 25 Feb 2025 10:05:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
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
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20250225160542.GA507421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93a253b24701513dbeeb307cb2b9e3afd4c74b5.1737271118.git.leon@kernel.org>

On Sun, Jan 19, 2025 at 09:27:54AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The Vital Product Data (VPD) attribute is not readable by regular
> user without root permissions. Such restriction is not needed at
> all for Mellanox devices, as data presented in that VPD is not
> sensitive and access to the HW is safe and well tested.
> 
> This change changes the permissions of the VPD attribute to be accessible
> for read by all users for Mellanox devices, while write continue to be
> restricted to root only.
> 
> The main use case is to remove need to have root/setuid permissions
> while using monitoring library [1].

As far as I can tell, this is basically a device identification
problem, which would be better handled by the Vendor, Device, and
Revision IDs.  If that would solve the problem, it would also make
standard unprivileged lspci output more specific.

VPD has never been user readable, so I assume you have some existing
method for device identification?

Other concerns raised in previous threads include:

  - Potential for sensitive information in VPD, similar to dmesg and
    dmidecode

  - Kernel complexity of reading VPD (mutex, address/data registers)

  - Performance and potential denial of service as a consequence of
    mutex and hardware interaction

  - Missing EEPROMs or defective or incompletely-installed firmware
    breaking VPD read

  - Broken devices that crash when VPD is read

  - Potential for issues with future Mellanox devices, even though all
    current ones work fine

This is basically similar to mmapping a device BAR, for which we also
require root.

> [leonro@vm ~]$ lspci |grep nox
> 00:09.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]
> 
> Before:
> [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> -rw------- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> After:
> [leonro@vm ~]$ ls -al /sys/bus/pci/devices/0000:00:09.0/vpd
> -rw-r--r-- 1 root root 0 Nov 13 12:30 /sys/bus/pci/devices/0000:00:09.0/vpd
> 
> [1] https://developer.nvidia.com/management-library-nvml
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v4:
>  * Change comment to the variant suggested by Stephen
> v3: https://lore.kernel.org/all/18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org
>  * Used | to change file attributes
>  * Remove WARN_ON
> v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
>  * Another implementation to make sure that user is presented with
>    correct permissions without need for driver intervention.
> v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
>  * Changed implementation from open-read-to-everyone to be opt-in
>  * Removed stable and Fixes tags, as it seems like feature now.
> v0: https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> ---
>  drivers/pci/vpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index a469bcbc0da7..c873ab47526b 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -332,6 +332,13 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
>  	if (!pdev->vpd.cap)
>  		return 0;
>  
> +	/*
> +	 * On Mellanox devices reading VPD is safe for unprivileged users,
> +	 * so just add needed bits to allow read.
> +	 */
> +	if (unlikely(pdev->vendor == PCI_VENDOR_ID_MELLANOX))
> +		return a->attr.mode | 0044;
> +
>  	return a->attr.mode;
>  }
>  
> -- 
> 2.47.1
> 

