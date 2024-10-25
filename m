Return-Path: <linux-pci+bounces-15334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E799B08F6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DBC282A0D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A3175D20;
	Fri, 25 Oct 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSvkOaGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAB21A4D1;
	Fri, 25 Oct 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871759; cv=none; b=TcXRea3k0DBg+Se4qXnyCcF490q8L815dI5cMfY8LsCLUcmEt+UqgnTTeZViJ+/2sHPLgxjelfsRimBpulYkbYB5eQGSOf6pv3z3Pxrc4ggJg8oJ6LJJCwfoyZqC1pvNdQ/RJKJMLJzlu7mgtbwOw359FQVCj5x34haOSlC5Dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871759; c=relaxed/simple;
	bh=DaMt0huU4SsMQ4gyRkKRhmgOiXOiXExV8wbhN/2DR6o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XUYFmkq5bqcfFDTAwqbfmFkGJUksuRvhPKQZhUN0yRLXLc8Z1xTRkD+ibZXPacpzUgkhR1bZsDvUBnHIPbOcQorg8dzJKJ6DpBeXU6A7c8PVP3GRSFidREWzmNjbKBdkPJh9yL1wC9x4e21meCl1LOxFr6mMPPM5iwLF+k/he2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSvkOaGf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729871757; x=1761407757;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DaMt0huU4SsMQ4gyRkKRhmgOiXOiXExV8wbhN/2DR6o=;
  b=jSvkOaGfWHtRIKPLy5Bg3zybzszpVco2ZOgvEaN3jsws3+GXTqhEnHoq
   151nfUbgbnX5FzQoce7LNrAnR1isRj30JBFkoCieoe6du16wqWVeeAzec
   dLCPIe6bea9qNybIgtsdTdaAAljdo6XT/c3Y13RhfGYnMspU4E3WQXBFg
   /j5rx+WNXRrX0L/LfW5DyllqT2LadREeEnKtyM8+7/6ebwhSyBgx4R2dn
   sC8smA8aD05anXAtVCuxnM9yeyjTwmRJEznNCYF49Yx5m/mVzbuy13KCW
   Vq+7t83dJ7iJphhdCQth/f1WuLvRkYwwytBmVtiDf6i+KSND4Ysypx1lK
   A==;
X-CSE-ConnectionGUID: io4rN/cmQWOo22ah0IgAnw==
X-CSE-MsgGUID: RcEDt4TxQbWfrV7pj29gKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40097883"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40097883"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:55:56 -0700
X-CSE-ConnectionGUID: Q/1oAimYRtS5BH6V/FKA8g==
X-CSE-MsgGUID: 1+Ve4Ha3Qu6UfDGm2Qn9IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81250468"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.225])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:55:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Oct 2024 18:55:38 +0300 (EEST)
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
Subject: Re: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
In-Reply-To: <20241025145959.185373-3-pstanner@redhat.com>
Message-ID: <282ba5d4-cdad-a6f4-8ee0-1936c532dbc5@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com> <20241025145959.185373-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Philipp Stanner wrote:

> pcim_iomap_regions_request_all() and pcim_iomap_table() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/acard-ahci.c | 6 ++++--
>  drivers/ata/ahci.c       | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> index 547f56341705..3999305b5356 100644
> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -370,7 +370,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>  	/* AHCI controllers often implement SFF compatible interface.
>  	 * Grab all PCI BARs just in case.
>  	 */
> -	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
> +	rc = pcim_request_all_regions(pdev, DRV_NAME);
>  	if (rc == -EBUSY)
>  		pcim_pin_device(pdev);
>  	if (rc)
> @@ -386,7 +386,9 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
>  	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
>  		pci_enable_msi(pdev);
>  
> -	hpriv->mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
> +	hpriv->mmio = pcim_iomap(pdev, AHCI_PCI_BAR, 0);
> +	if (!hpriv->mmio)
> +		return -ENOMEM;
>  
>  	/* save initial config */
>  	ahci_save_initial_config(&pdev->dev, hpriv);
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 45f63b09828a..2043dfb52ae8 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1869,7 +1869,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* AHCI controllers often implement SFF compatible interface.
>  	 * Grab all PCI BARs just in case.
>  	 */
> -	rc = pcim_iomap_regions_request_all(pdev, 1 << ahci_pci_bar, DRV_NAME);
> +	rc = pcim_request_all_regions(pdev, DRV_NAME);
>  	if (rc == -EBUSY)
>  		pcim_pin_device(pdev);
>  	if (rc)
> @@ -1893,7 +1893,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ahci_sb600_enable_64bit(pdev))
>  		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;
>  
> -	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
> +	hpriv->mmio = pcim_iomap(pdev, ahci_pci_bar, 0);
> +	if (!hpriv->mmio)
> +		return -ENOMEM;

Hi,

I've probably lost the big picture somewhere and the coverletter wasn't 
helpful focusing only the most immediate goal of getting rid of the 
deprecated function.

These seem to only pcim_iomap() a single BAR. So my question is, what is 
the reason for using pcim_request_all_regions() and not 
pcim_request_region() as mentioned in the commit message of the commit 
e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(), 
pcim_iomap_regions_request_all()")?

I understand it's strictly not wrong to use pcim_request_all_regions()
but I'm just trying to understand the logic behind the selection.
I'm sorry if this is a stupid question, it's just what I couldn't figure 
out on my own while trying to review these patches.

(I admit not reading all the related discussions in the earlier versions.)

-- 
 i.


