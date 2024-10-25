Return-Path: <linux-pci+bounces-15332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D069B084E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AFA1C2164A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE413E40F;
	Fri, 25 Oct 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0YhvipQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3F6F099;
	Fri, 25 Oct 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870301; cv=none; b=SKeC+xIBEFTcx1UizrEgvMJvZ7Jv24kML6KqAi0+BDWhGyH+wfGnaIehPMZb1EkE1JOnyjwpINxqqd8GGeiBxegVgp4cKd6s/m8K4lTa0WtnR/CdK3/qzMoHHVuwz+nvktMuSZpKoPjSOLTu+V+2JRXkJdtSjSayWgv6179a5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870301; c=relaxed/simple;
	bh=/2J1GjARnQin8IDRVr7yEGcvHtYaMVqYqN1depWkivw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gHq8xaX/BxZrg/KaWWnWLpM/06+gFIiZfGGe4jgQ17IyI4VBB/kbiUVYsJGg9KNp8VWTBwHdQIL1tuxPysvbnjcpERy1ntJom+ltWjyQ+xUHui9CaUZp8Zq/l1sMOdXYK59eNh4mCPbCdIvxxkgQb0VVG2/dEzI859tEkjUpohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0YhvipQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729870300; x=1761406300;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/2J1GjARnQin8IDRVr7yEGcvHtYaMVqYqN1depWkivw=;
  b=j0YhvipQwr+avgKEPWAj6YhHi9R/9alz4VKeifNqdeE2AGDoPENP/24D
   tP3UT9ZGMljKYCCRKonb6XIsUyMKQIo9mJKkxPu1xGSHQgAICWc2CcU/Z
   DK+QP0P3uDUzrMGcPEd48I3e1v6gWIOS3i4VFGWq2/V/LZeSqBn/CkmEn
   aDVeI8tlDxmEETa24zDg5q0WXsyQRsIx/3rdt9/XEp3E/fnQt54xhSpmX
   Uj5OfqPqnVspqkgZTcttdZzDLUK11Xx4AgrnX8sBGTnKZOb83M7meNPO/
   yL096LqSZ3NwROb9suc4s2DtLVbPEq/kHYqd7iC9/aeQ3eewZh51WcMB7
   A==;
X-CSE-ConnectionGUID: 8hmX+HC5QxmKoiux1pZIYQ==
X-CSE-MsgGUID: RY1L4P91Tbqzb/CMUmcnlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40935920"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="40935920"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:31:38 -0700
X-CSE-ConnectionGUID: R52BphinSZOxfUkm8HgmHg==
X-CSE-MsgGUID: LI6dv1k3QkeHmZVNhcth6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="84901931"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:31:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 18:31:21 +0300 (EEST)
To: Philipp Stanner <pstanner@redhat.com>
cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, 
    Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, 
    "David S. Miller" <davem@davemloft.net>, 
    Boris Brezillon <bbrezillon@kernel.org>, 
    Arnaud Ebalard <arno@natisbad.org>, Srujana Challa <schalla@marvell.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
    Kalle Valo <kvalo@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
    Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
    Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Kevin Cernekee <cernekee@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
    Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, 
    David Lechner <dlechner@baylibre.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Jie Wang <jie.wang@intel.com>, Tero Kristo <tero.kristo@linux.intel.com>, 
    Adam Guerin <adam.guerin@intel.com>, 
    Shashank Gupta <shashank.gupta@intel.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Bharat Bhushan <bbhushan2@marvell.com>, 
    Nithin Dabilpuram <ndabilpuram@marvell.com>, 
    Johannes Berg <johannes.berg@intel.com>, 
    Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
    Gregory Greenman <gregory.greenman@intel.com>, 
    Benjamin Berg <benjamin.berg@intel.com>, 
    Yedidya Benshimol <yedidya.ben.shimol@intel.com>, 
    Breno Leitao <leitao@debian.org>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-ide@vger.kernel.org, qat-linux@intel.com, 
    linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org, 
    ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, linux-sound@vger.kernel.org
Subject: Re: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
In-Reply-To: <20241025145959.185373-7-pstanner@redhat.com>
Message-ID: <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com> <20241025145959.185373-7-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Philipp Stanner wrote:

> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Acked-by: Kalle Valo <kvalo@kernel.org>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index 3b9943eb6934..4b41613ad89d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
>  	struct iwl_trans_pcie *trans_pcie, **priv;
>  	struct iwl_trans *trans;
>  	int ret, addr_size;
> -	void __iomem * const *table;
>  	u32 bar0;
>  
>  	/* reassign our BAR 0 if invalid due to possible runtime PM races */
> @@ -3659,22 +3658,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
>  		}
>  	}
>  
> -	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
> +	ret = pcim_request_all_regions(pdev, DRV_NAME);
>  	if (ret) {
> -		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
> +		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
>  		goto out_no_pci;
>  	}
>  
> -	table = pcim_iomap_table(pdev);
> -	if (!table) {
> -		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
> -		ret = -ENOMEM;
> -		goto out_no_pci;
> -	}
> -
> -	trans_pcie->hw_base = table[0];
> +	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
>  	if (!trans_pcie->hw_base) {
> -		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
> +		dev_err(&pdev->dev, "pcim_iomap failed\n");

This seems a step backwards as a human readable English error message was 
replaced with a reference to a function name.

-- 
 i.

>  		ret = -ENODEV;
>  		goto out_no_pci;
>  	}
> 

