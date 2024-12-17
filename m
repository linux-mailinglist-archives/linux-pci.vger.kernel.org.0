Return-Path: <linux-pci+bounces-18625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310D9F4C21
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C252D7A7082
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218171F3D44;
	Tue, 17 Dec 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8dBlWzz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DB1D1730;
	Tue, 17 Dec 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441748; cv=none; b=u3oVng2v2kf+MccfJA5819nfC62doYFr3MXdI0vIW4NaKRFwPRnNqros4KWNVlpXzJcW0wW7TR67mZfvAvyk+PGxmW2xDa3/yrC6il9ZbJgf1xSnT2s+Iw6gI5duxAvtXph886PSFhShuMHE+EBFJ3ztiAdbpuLlnzj1mEch96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441748; c=relaxed/simple;
	bh=weqUtistC/j/aUBCf8HRH1GcWzJ9pgObt2tpCXoIBzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIFTVin98KiLo/IBKfSRMU500kyFXM/0Da0mPUSjx8kzK+3IEecbveVofHWOYdLw/evdbVeTsowAdXcY25UI+CHGxvuAihjG0psKQ/slJT214YVx55oM0l4Nmqzlt4u1hVmQl9UqO8yGcJgfHPkkg+6+wM+ZU6kZslfJjiGD8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8dBlWzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8002DC4CED4;
	Tue, 17 Dec 2024 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734441747;
	bh=weqUtistC/j/aUBCf8HRH1GcWzJ9pgObt2tpCXoIBzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8dBlWzzU3fl8z0UBorZZGsKSLPdtKmczs5kfCDcNl7HzvRahSRsrJrdLkhU8rr+G
	 Sup9OwsfraUjuVpFYpbxhyddIFsBZERbepnkHoCYcqEk2ZQUoCcW1eN/iY5NSGXt0O
	 vC2zxxYN4wO+FRcCCrY4silnU3diePleRkMQsv4hKVLPcvL3bR+d8eaTLK/RQGPbP3
	 qXklhF/Ztq2s838TVaSar5ZuXSsPAeDO7p88NplEZjbfGxggqVTcSD1PtbuzgLyK4G
	 JjxpfBtFLBzB4uzrFOQ+g79fBJXN0d756ZAuRRjqBFh7JdcwP0JWug/t3yICfC3Sot
	 d8eeG8oaozdUQ==
Date: Tue, 17 Dec 2024 15:22:22 +0200
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
Subject: Re: [PATCH v3] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20241217132222.GK1245331@unreal>
References: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f36b3cbe2b7e67eed876337f8ba85afbc12e73.1733227737.git.leon@kernel.org>

On Tue, Dec 03, 2024 at 02:15:28PM +0200, Leon Romanovsky wrote:
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
> 
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
> v3:
>  * Used | to change file attributes
>  * Remove WARN_ON
> v2: https://lore.kernel.org/all/61a0fa74461c15edfae76222522fa445c28bec34.1731502431.git.leon@kernel.org
>  * Another implementation to make sure that user is presented with
>    correct permissions without need for driver intervention.
> v1: https://lore.kernel.org/all/cover.1731005223.git.leonro@nvidia.com
>  * Changed implementation from open-read-to-everyone to be opt-in
>  * Removed stable and Fixes tags, as it seems like feature now.
> v0:
> https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> ---
>  drivers/pci/vpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Bjorn,

Kind reminder.

Thanks

