Return-Path: <linux-pci+bounces-41279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5344DC5F9EB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 00:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6411C3BEC91
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 23:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C930F542;
	Fri, 14 Nov 2025 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrngH4Up"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C030F53E
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163945; cv=none; b=tSz8q014BDXtfGbwQHTceyqHWVn4Dfm7b5onckEkT231Z5WBQMLWMYIwtr8CjfYWIfGyl9P+35eTuKm1S1jcb+l8GfU47NzKwzMW3b65ToKMdK6N4//cdsXKVq6Zr6p4cBGv/r5kZH5s+nS866IHeTvLmA8Zqsfqe8Oiaom1H4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163945; c=relaxed/simple;
	bh=VjOUQn2CMnLCK8Ez8KnMoiA++LC+kuNQ89cJ9UDiqgU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lffD8A/dchz+eMcM37epPOPNIbU5KQAuRmK1QHBqx9kvHYrpNgbgNiYwu/TCGhhbhQhHpkWwvp5BRHxePMx0FHN+PzzS25LPOPMwNVYy5mkhjAIxrHEq2bIPpFyYF91HoVfoYNcH1wb8zlE7/zldcbJqE5O0Dr3EAV+9OomD+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrngH4Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C52DC16AAE;
	Fri, 14 Nov 2025 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763163945;
	bh=VjOUQn2CMnLCK8Ez8KnMoiA++LC+kuNQ89cJ9UDiqgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CrngH4UpTSR0l68GfGHGvcRYcsBQPtp5oAgbzGTIck6kdV2BVKE4UD17+nymFyigP
	 Yd0dBrcbgUKB+C96gfivjhJ/xPLHCu17vaOur2/6WZLK2VxV2Fnidy51wc9kLupdd9
	 7fOUfVMuEjtJ18yisyyoBAH1uRSI9wQzYx1y6EDvASg3UabAXcEqsiwA5DEjoYX2jJ
	 kLDMzddbEWwlhyZNyoFZl/eL6QpH1+e8qZdUTtLrRL9baw4dxulV1q8Q9jvO2KiuYj
	 6lLkOuCJSfEtoWdyLU3jfvqOjcYB9zAhCY9YJPSmU34FzBxlzwz3Gqq2RM3ssy505v
	 o45hHW1Hwjk1A==
Date: Fri, 14 Nov 2025 17:45:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Universal error recoverability of devices
Message-ID: <20251114234543.GA2350415@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760274044.git.lukas@wunner.de>

On Sun, Oct 12, 2025 at 03:25:00PM +0200, Lukas Wunner wrote:
> When PCI devices are reset -- either to recover from an error or
> after a D3hot/D3cold transition -- their Config Space needs to be
> restored.
> 
> D3hot/D3cold transitions happen under the control of the kernel,
> hence it is able to save Config Space before and restore it afterwards.
> 
> However errors may occur unexpectedly and it may then be impossible
> to save Config Space because the device may be inaccessible (e.g. DPC)
> or Config Space may be corrupted.  So it must be saved ahead of time.
> 
> This isn't done consistently because the PCI core doesn't take care
> of it and only a subset of drivers do.  The situation is aggravated
> by the behavior of pci_restore_state(), which only allows restoring
> Config Space once and invalidates the saved copy afterwards.
> 
> Solve all these problems by saving an initial copy of Config Space
> on device addition which drivers may update if they change registers.
> Modify pci_restore_state() to allow using the saved copy indefinitely
> and drop all the workarounds for its previous behavior that have
> accumulated in the tree.
> 
> Lukas Wunner (2):
>   PCI: Ensure error recoverability at all times
>   treewide: Drop pci_save_state() after pci_restore_state()
> 
>  drivers/crypto/intel/qat/qat_common/adf_aer.c    | 2 --
>  drivers/dma/ioat/init.c                          | 1 -
>  drivers/net/ethernet/broadcom/bnx2.c             | 2 --
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 1 -
>  drivers/net/ethernet/broadcom/tg3.c              | 1 -
>  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c  | 1 -
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  | 2 --
>  drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 1 -
>  drivers/net/ethernet/intel/e1000e/netdev.c       | 1 -
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 6 ------
>  drivers/net/ethernet/intel/i40e/i40e_main.c      | 1 -
>  drivers/net/ethernet/intel/ice/ice_main.c        | 2 --
>  drivers/net/ethernet/intel/igb/igb_main.c        | 2 --
>  drivers/net/ethernet/intel/igc/igc_main.c        | 2 --
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 1 -
>  drivers/net/ethernet/mellanox/mlx4/main.c        | 1 -
>  drivers/net/ethernet/mellanox/mlx5/core/main.c   | 1 -
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c      | 1 -
>  drivers/net/ethernet/microchip/lan743x_main.c    | 1 -
>  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 4 ----
>  drivers/net/ethernet/neterion/s2io.c             | 1 -
>  drivers/pci/bus.c                                | 7 +++++++
>  drivers/pci/pci.c                                | 3 ---
>  drivers/pci/pcie/portdrv.c                       | 1 -
>  drivers/pci/probe.c                              | 2 --
>  drivers/scsi/bfa/bfad.c                          | 1 -
>  drivers/scsi/csiostor/csio_init.c                | 1 -
>  drivers/scsi/ipr.c                               | 1 -
>  drivers/scsi/lpfc/lpfc_init.c                    | 6 ------
>  drivers/scsi/qla2xxx/qla_os.c                    | 5 -----
>  drivers/scsi/qla4xxx/ql4_os.c                    | 5 -----
>  drivers/tty/serial/8250/8250_pci.c               | 1 -
>  drivers/tty/serial/jsm/jsm_driver.c              | 1 -
>  33 files changed, 7 insertions(+), 62 deletions(-)

Applied to pci/err, maybe for v6.19?

It touches a lot of drivers, so it'd be nice to have more time in
-next, but it is mostly in error recovery paths that aren't going to
be exercised much anyway.

I'll watch for a minor update of comments and update if I see it.

Thanks a lot for your work and description of this.  It's a big step
in my understanding of PM and error recovery.  Which still leaves me
mostly ignorant, just slightly less so.

Bjorn

