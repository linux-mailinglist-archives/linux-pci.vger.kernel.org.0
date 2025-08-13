Return-Path: <linux-pci+bounces-33933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E618B242F7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 09:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6861B62D34
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8452E371A;
	Wed, 13 Aug 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0IxHVOp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706B2E3703;
	Wed, 13 Aug 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070934; cv=none; b=Wr8HhXAVkk5J950KfAK6YugOT0lokGTVNtGUfHAn9YPZHX1+kdtBVM1pkqWrXMepYgwWTZ91a9JrtqlQeEQWHhl/dbMHo9+5v9gwme2F9VxjWVtOGdGe6+v+DTLmTt1yPOmk1QM/aSPsZTR3/hYsNa0ogYNx3+GbfMNxZ3/R6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070934; c=relaxed/simple;
	bh=1teJDiO4uRejB10+Bs/ntmOwZj4Z0Z30TX1NfIAGS8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLuFDN/0Ut8EOUzJFve6YX4pXiTWDC/Gb453dEVolzOV0P5BSD8GFhWwktIvpQ9zPQPO/SQR3e5UBOBAjMQJkP454/wJWVOlh0orJzqz5KRwdTHr8CP8TN1VjNcSPwxu185aqvfM/cqlrq0tTDlfRLzWEmjda55RHkmMTRvgCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0IxHVOp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755070932; x=1786606932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1teJDiO4uRejB10+Bs/ntmOwZj4Z0Z30TX1NfIAGS8A=;
  b=Y0IxHVOpv0gbl2ymwO9GL8Ra9oIWMy9Ms5rWNUqy0ZWFCFO3oby4CY1H
   G9q4a3NMBO5tsiv6STTy9WXASaLxH+DlAkuYE3OeElgQdNxXMuTtz13Zt
   KztgzY3wF6ERrGRNx1IPcLyK8EclWp3BXecRvAINrUE4spzl90VdalGOi
   iTKs5PTeQ/ywaTkluS+oHEui7VIrX9vvZk0k7M23RirwlzUOjRmCLgKzu
   PLnoiHy0N3bn5NPAjeSjaSEz6Xuzyh6ukGe9QaygvzZ+rjELKHmahJcN3
   OSpvGoCei3FIMrxoMcjgx5Zz1P4iftPspAGlV8R77GQJG3YvHjjbcOTjt
   w==;
X-CSE-ConnectionGUID: Cf6DatS0TCOH9hUZ3R3HRg==
X-CSE-MsgGUID: z9ICr4OiRdWY68fpDzoGtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57420065"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57420065"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 00:42:12 -0700
X-CSE-ConnectionGUID: iRhExdSiSxGalP/JPemskg==
X-CSE-MsgGUID: kcxWWFbhQdqN3n3uudRQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170612180"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2025 00:42:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1288F95; Wed, 13 Aug 2025 09:42:09 +0200 (CEST)
Date: Wed, 13 Aug 2025 09:42:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <westeri@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Use is_pciehp instead of is_hotplug_bridge
Message-ID: <20250813074209.GX476609@black.igk.intel.com>
References: <5632086b8436bc2f9a43e3573acf7a090615b52f.1755005459.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5632086b8436bc2f9a43e3573acf7a090615b52f.1755005459.git.lukas@wunner.de>

Hi,

On Tue, Aug 12, 2025 at 03:42:29PM +0200, Lukas Wunner wrote:
> The thunderbolt driver sets up device link dependencies from hotplug ports
> to the Host Router (aka Native Host Interface, NHI).  When resuming from
> system sleep, this allows the Host Router to re-establish tunnels to
> attached Thunderbolt devices before the hotplug ports resume.
> 
> To identify the hotplug ports, the driver utilizes the is_hotplug_bridge
> flag which also encompasses ACPI slots handled by the ACPI hotplug driver.
> 
> Thunderbolt hotplug ports are always Hot-Plug Capable PCIe ports, so it is
> more apt to identify them with the is_pciehp flag.
> 
> Similarly, hotplug ports on older Thunderbolt controllers have broken MSI
> support and are quirked to use legacy INTx interrupts instead.  The quirk
> identifies them with is_hotplug_bridge, even though all affected ports are
> also matched by is_pciehp.  So use is_pciehp here as well.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> The is_pciehp flag was introduced by commit 6cff20ce3b92 ("PCI/ACPI: Fix
> runtime PM ref imbalance on Hot-Plug Capable ports"), which appeared in
> v6.17-rc1.  This patch is submitted separately because it is intended
> to be applied through thunderbolt.git instead of pci.git.  Thanks!

Happy to take it, but I think I need an Ack from Bjorn as it touches PCI
too.

>  drivers/pci/quirks.c     | 2 +-
>  drivers/thunderbolt/tb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a..17315a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3829,7 +3829,7 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>   */
>  static void quirk_thunderbolt_hotplug_msi(struct pci_dev *pdev)
>  {
> -	if (pdev->is_hotplug_bridge &&
> +	if (pdev->is_pciehp &&
>  	    (pdev->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
>  	     pdev->revision <= 1))
>  		pdev->no_msi = 1;
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c14ab1f..83a33fc 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3336,7 +3336,7 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
>  		if (!pci_is_pcie(pdev))
>  			continue;
>  		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
> -		    !pdev->is_hotplug_bridge)
> +		    !pdev->is_pciehp)
>  			continue;
>  
>  		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
> -- 
> 2.47.2

