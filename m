Return-Path: <linux-pci+bounces-16475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3D9C46E3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74BB1F27D64
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC21AB6CD;
	Mon, 11 Nov 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDqWnnkX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099A8468;
	Mon, 11 Nov 2024 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357126; cv=none; b=Ku6uV4yRD8+FTFj8JJqiJCWyKRPtoY4QFBpZ84qmqnpeauUN8GIzu56B7B8SCXxLAJCHT+kRmoTIXVD/R6CzxPexV+ardhjdCr27/fGResBO/S/mld+YOGiJQH9OIIKt66KqzT3pUh1WqFxoRU3VAxbTEwe/EcDJUMepvbtKYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357126; c=relaxed/simple;
	bh=1JKreAiXrQHyGt4F0i/ifIUcZwMi9FkZdg60KkL1b10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpY6TWCm8F9is+wplhr2vWarv/cEEKRoBbnjqgf6Vlm5fS4CBOlQbmv9meyP26GIaRDkG/oYSTW2NTdPIJ5p+EOPuvPhO9mC55ndFdFwZZnFJOqYdbiHT8KFiE+kQ14dOLSQyGj0Zur8ZOATolXvqGb+RKjp+d8iVwSLfwHylAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDqWnnkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1636DC4CECF;
	Mon, 11 Nov 2024 20:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357125;
	bh=1JKreAiXrQHyGt4F0i/ifIUcZwMi9FkZdg60KkL1b10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDqWnnkXcGVQUzu9ZfIxBV1kHCrZBa2nPgUoEGSNfkjS7+fSm0La7JIWCEl1lYwj5
	 hjmEBxTZ4QYYIOFJ5Lrd2plVwFtO5rrG/RDcBVI4n9HH9rWvl/vrZAvKzKRQNNIpFR
	 C2/c57j4OTO6JBWbAHnUWmu5B8Mi02SUsw9QnQ2e65wMMfXTLzK5AP05fSDUkNZBe8
	 hbHjZaLV+K1Tcl21YuElk/zwz0CddvB4ZIOrY87gFSJYTQV5Ht65/e9SJvH3DzFev0
	 QpjiQ8lrVpcojcTrghkadqaGTjU9roZbwGNxKrsNIH5J3mzvzuEzr3MuOoLasU8tQU
	 K5RJSEU/2SM2w==
Date: Mon, 11 Nov 2024 22:31:58 +0200
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
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fix read permissions for VPD attributes
Message-ID: <20241111203158.GC71181@unreal>
References: <cover.1731005223.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731005223.git.leonro@nvidia.com>

On Thu, Nov 07, 2024 at 08:56:55PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1: 
>  * Changed implementation from open-read-to-everyone to be opt-in
>  * Removed stable and Fixes tags, as it seems like feature now.
> v0: https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/
> 
> --------------------------------------------------------------------------
> Hi,
> 
> The Vital Product Data (VPD) sysfs file is not readable by unprivileged
> users. This limitation is not necessary and can be removed at least for
> devices which are known as safe.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   PCI/sysfs: Change read permissions for VPD attributes
>   net/mlx5: Enable unprivileged read of PCI VPD file
> 
>  drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
>  drivers/pci/vpd.c                              | 9 ++++++++-
>  include/linux/pci.h                            | 7 ++++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)

Bjorn,

Does this version resolve your concerns about broken devices in the field?

Thanks

> 
> -- 
> 2.47.0
> 
> 

