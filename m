Return-Path: <linux-pci+bounces-15656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C69B6E96
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81534B21BEF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E651DF759;
	Wed, 30 Oct 2024 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn30FgKL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C588194C75;
	Wed, 30 Oct 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322932; cv=none; b=NHXChaR6TfwQAu9krlH2O6y3cJf03Odwwj24Wwr/Pu0csuQtws3MZ3N5LELj2N6R4V3SU0r/OExKwd4VLkocnJiTUtTBv7tH0F/JfKjuU0W2FDB3lvdtHQcWY3sTvM5K+Mf79CKQlahug8KeruJMO2HWxnqHJuuCcLQGzAqXKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322932; c=relaxed/simple;
	bh=E/1gsPMYddyGtV5nOIdJOU+wxqCAx3Iy9SGPQsxfff0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GHlJ7tS9ioshbAjm5xbU5l2N7e4nMLci33KkYe6mku49OgOaRW02PvZbYl2AHB6HQKO8phu2wLYT0t+FnoIwRDzCKabU2E1G0ud6jnQtyEHozeoHP6uBPLepW/9oq7J4Ok9Ze3wT0KnRXSpZ6i4WTDkkW3C+dANtQRDJOdK7QiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn30FgKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAABC4CECE;
	Wed, 30 Oct 2024 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322931;
	bh=E/1gsPMYddyGtV5nOIdJOU+wxqCAx3Iy9SGPQsxfff0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Sn30FgKLhEeH/3+fVxl55wltUvnTtRFcf2H+jqIFpQVQhKjYIW2MIjJ3539zvlwQ7
	 aFHSPzV9u60J7nm2OKTcxsIKIW9B/h8TKgg0haIAl5XKebYk2eKrBFum7KN5okpfQS
	 uXBnPEzxTp/daAJBIhPlkPxnSYbkxhb8pli6PVbydIBSkf9C72yj893KtGZjymrKGY
	 eqOWMmvDOxE+IHj+DNztzEWjjZFOM90eLUjBc2Rh+jEkFeSyCIpdXlNy6jy9pBvepb
	 xl7mygLzXHIoY0zrMbCWEXS8poSRxssdex4GamVBZABlQn1T2unvlWdGDlbUQUEoJS
	 lFdm13L90KFiQ==
Date: Wed, 30 Oct 2024 16:15:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 0/6] PCI: Remove most pcim_iounmap_regions() users
Message-ID: <20241030211529.GA1220902@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>

On Wed, Oct 16, 2024 at 11:49:03AM +0200, Philipp Stanner wrote:
> Merge plan for this is the PCI-Tree.
> 
> After this series, only two users (net/ethernet/stmicro and
> vdpa/solidrun) will remain to be ported in the subsequent merge window.
> Doing them right now proved very difficult because of various conflicts
> as they are currently also being reworked.
> 
> Changes in v8:
>   - Patch "gpio: ..": Fix a bug: don't print the wrong error code. (Simon)
>   - Split patch 1 into two patches to make adding of the new public API
>     obvious (Bartosz)
>   - Patch "ethernet: cavium: ...": Remove outdated sentences from the
>     commit message.
> 
> Changes in v7:
>   - Add Paolo's Acked-by.
>   - Rebase on current master; drop patch No.1 which made
>     pcim_request_region() public.
> 
> Changes in v6:
>   - Remove the patches for "vdpa: solidrun" since the maintainer seems
>     unwilling to review and discuss, not to mention approve, anything
>     that is part of a wider patch series across other subsystems.
>   - Change series's name to highlight that not all callers are removed
>     by it.
> 
> Changes in v5:
>   - Patch "ethernet: cavium": Re-add accidentally removed
>     pcim_iounmap_region(). (Me)
>   - Add Jens's Reviewed-by to patch "block: mtip32xx". (Jens)
> 
> Changes in v4:
>   - Drop the "ethernet: stmicro: [...] patch since it doesn't apply to
>     net-next, and making it apply to that prevents it from being
>     applyable to PCI ._. (Serge, me)
>   - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
>     stimicro" as the last user for now.
>   - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
>   - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet" instead of
>     "snet"). (Christophe)
>   - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
>   - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
>   - Apply Reviewed-by's from Andy and Xu Yilun.
> 
> Changes in v3:
>   - fpga/dfl-pci.c: remove now surplus wrapper around
>     pcim_iomap_region(). (Andy)
>   - block: mtip32xx: remove now surplus label. (Andy)
>   - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
>     occurs. (Andy, Christophe)
>   - Some minor wording improvements in commit messages. (Me)
> 
> Changes in v2:
>   - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
>     patch, put stable kernel on CC. (Christophe, Andy).
>   - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
>   - Consequently, drop patch "PCI: Make pcim_release_region() a public
>     function", since there's no user anymore. (obsoletes the squash
>     requested by Damien).
>   - vdap/solidrun:
>     • make 'i' an 'unsigned short' (Andy, me)
>     • Use 'continue' to simplify loop (Andy)
>     • Remove leftover blank line
>   - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)
> 
> 
> Important things first:
> This series is based on [1] and [2] which Bjorn Helgaas has currently
> queued for v6.12 in the PCI tree.
> 
> This series shall remove pcim_iounmap_regions() in order to make way to
> remove its brother, pcim_iomap_regions().
> 
> Regards,
> P.
> 
> [1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
> [2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/
> 
> Philipp Stanner (6):
>   PCI: Make pcim_iounmap_region() a public function
>   PCI: Deprecate pcim_iounmap_regions()
>   fpga/dfl-pci.c: Replace deprecated PCI functions
>   block: mtip32xx: Replace deprecated PCI functions
>   gpio: Replace deprecated PCI functions
>   ethernet: cavium: Replace deprecated PCI functions
> 
>  drivers/block/mtip32xx/mtip32xx.c              | 18 ++++++++----------
>  drivers/fpga/dfl-pci.c                         | 16 ++++------------
>  drivers/gpio/gpio-merrifield.c                 | 15 ++++++++-------
>  .../net/ethernet/cavium/common/cavium_ptp.c    |  7 +++----
>  drivers/pci/devres.c                           |  8 ++++++--
>  include/linux/pci.h                            |  1 +
>  6 files changed, 30 insertions(+), 35 deletions(-)

Applied to pci/devm for v6.13, thanks!

