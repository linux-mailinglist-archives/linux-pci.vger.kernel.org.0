Return-Path: <linux-pci+bounces-25595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA65A83078
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 21:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73781B66731
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFF11EF36E;
	Wed,  9 Apr 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMY0d9sQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90E1DFDB8;
	Wed,  9 Apr 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226613; cv=none; b=HwgD+Akb61K+GXs/HGKkZZIKhmKlWHUAAILFXcQZEZE6Ul3zCKiGAo06+SeuBsqLccvK+X3E+K7Wp9LQXuCgS+E7YAoujn43myA0qKL2+dScL57JoGUXxS5gZK2ND5SL86NlHovfNqHpBqzmhoWfidfhxDoYMruxtnMC/M5D8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226613; c=relaxed/simple;
	bh=wbZBWZPCrLHSWfbKDSWK04xVRpg9kPi7xGRc5wGJiss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CiM1kho0IE6vfizTLN8Zfv7k63ABwo0Rt5JD+smEsPnlHFv4wAVIGk87ggdb0/ir2scL51XoqK8zs4f/M4ltFBjuHMU2eBjoN3RbZrGfIQ7d1e4ILYviDSSuyZREETOLtizjeqrO15ZPUHD0XlRYG0FhsqCKdVWUjBP3mh6neBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMY0d9sQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC47C4CEE2;
	Wed,  9 Apr 2025 19:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744226612;
	bh=wbZBWZPCrLHSWfbKDSWK04xVRpg9kPi7xGRc5wGJiss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IMY0d9sQSe0X9Zj3ZUJwKF0hn9S+k7W5NAWQU6jHagnk4NFPOniKWJpbI6s2OzBE8
	 GPKs2AkvIqDjqp076uOnIXDu206cN5b1LSRabyRs2OymGvDTNwC2kpmkR8YK7YScw+
	 YYkBlvcuGBKAHlfOs3DE9jywbAZXGA3iu5P9tJ5pB9Bp7oElPpQfT1My6cGIlNhfG0
	 tCVismGnLdKI4IF2YPW06vsM7N8EiskYUFMEV/zXEmXDhKX5rh0fyGpELDbnHBRrRj
	 KqCq+hE3xfEzWV4MSclEcm7nfKfQ8XVVsZ2H2rrz2NEjlF4H4i0NwcvA0RQbU3tZCf
	 1LCj2cRta7m/w==
Date: Wed, 9 Apr 2025 14:23:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
Message-ID: <20250409192330.GA292795@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327110707.20025-2-phasta@kernel.org>

On Thu, Mar 27, 2025 at 12:07:06PM +0100, Philipp Stanner wrote:
> The last remaining user of pcim_iounmap_regions() is mtip32 (in Linus's
> current master)
> 
> So we could finally remove this deprecated API. I suggest that this gets
> merged through the PCI tree. (I also suggest we watch with an eagle's
> eyes for folks who want to re-add calls to that function before the next
> merge window opens).
> 
> P.
> 
> Philipp Stanner (2):
>   mtip32xx: Remove unnecessary PCI function calls
>   PCI: Remove pcim_iounmap_regions()

Updated mtip32xx subject to:

  mtip32xx: Remove unnecessary pcim_iounmap_regions() calls

and applied to pci/devres for v6.16, thanks!

>  .../driver-api/driver-model/devres.rst        |  1 -
>  drivers/block/mtip32xx/mtip32xx.c             |  7 ++----
>  drivers/pci/devres.c                          | 24 -------------------
>  include/linux/pci.h                           |  1 -
>  4 files changed, 2 insertions(+), 31 deletions(-)
> 
> -- 
> 2.48.1
> 

