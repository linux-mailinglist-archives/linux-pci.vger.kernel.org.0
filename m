Return-Path: <linux-pci+bounces-14619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F99A0291
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 09:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88448282834
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 07:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62841B6D16;
	Wed, 16 Oct 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCajMOzJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401F1B218C;
	Wed, 16 Oct 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063775; cv=none; b=aEmwfO/2xD7QeA9jX/O3Ff7z+KNbwpXPhkWpO3k2SaXQDowdciQ+c4iSN1V1OdwZ9c1cSmpt77vSy298Nq6NKgbsX+ciGA2VOGgqT+UGVP0bMOn+1orjPF5SOMiNqsTpxsjzoLDiBITRQLJYFUs8kRkFtGel13JiDTZyIeNws6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063775; c=relaxed/simple;
	bh=oyVzPIXWh8SgdGYhhreMtS6eYl9vpvKp3W4abajSFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZluyWsNofpRHuDMcjBE9cs/8Xhme6SfsLvV+w+MARSejgDTHC6m889HwTN3hKOjb/5+nbZSmQ8LRa71ECSNZJ0GTF/n4JmrHbDJ1sAXSF2TQadqxOfMD5OTknh/3CvfrYHwPPTJwWRUfQJSlkt1grEel3VYCfqHrKmdtA2gxHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCajMOzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786DDC4CEC5;
	Wed, 16 Oct 2024 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729063775;
	bh=oyVzPIXWh8SgdGYhhreMtS6eYl9vpvKp3W4abajSFNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCajMOzJ5QkaGdE00N+57EHtenrZH62UzIrz+faKKQeXbgc+P3/jr+O8TSYkNMJT2
	 R1uQa+XGPMhByFtVyS93U6NHUqHPWdwn9H+/XA2OGXcmT0ApWvTAftOknkvBhjfQne
	 C8UGvVlEf0COyvCcC0MvxVVPRv6S3m8Ydw8k2OPkohVJuD4lw7MeCqcbT3DIfKWA4e
	 C7avxFd1Q+hIYO5M/GX7iKtkZVWEVYboWtOEnb/YmWxVeItdldNhi/UvbtibzJiIiX
	 osiiCFubzdWIv7RAbY86oxffRW3ir9zX5rEefcsHixkDcWzuQ/wMwksbB9Zb0ZjFRu
	 DNTBbn0Vg6f9w==
Date: Wed, 16 Oct 2024 08:29:29 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Message-ID: <20241016072929.GD2162@kernel.org>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-11-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-11-wei.fang@nxp.com>

On Tue, Oct 15, 2024 at 08:58:38PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> enetc_alloc_msix() so that the code is more concise and readable.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 9 ("net: enetc: optimize the
> allocation of tx_bdr"). Separate enetc_int_vector_init() from the
> original patch. In addition, add new help function
> enetc_int_vector_destroy().
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 174 +++++++++----------
>  1 file changed, 87 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 032d8eadd003..d36af3f8ba31 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>  }
>  EXPORT_SYMBOL_GPL(enetc_ioctl);
>  
> +static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
> +				 int v_tx_rings)
> +{
> +	struct enetc_int_vector *v __free(kfree);
> +	struct enetc_bdr *bdr;
> +	int j, err;
> +
> +	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> +	if (!v)
> +		return -ENOMEM;

...

>  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->si->pdev;

...

> @@ -2986,64 +3067,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  	/* # of tx rings per int vector */
>  	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
>  
> -	for (i = 0; i < priv->bdr_int_num; i++) {
> -		struct enetc_int_vector *v;
> -		struct enetc_bdr *bdr;
> -		int j;
> -
> -		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> -		if (!v) {
> -			err = -ENOMEM;
> +	for (i = 0; i < priv->bdr_int_num; i++)
> +		if (enetc_int_vector_init(priv, i, v_tx_rings))
>  			goto fail;

Hi Wei Fang,

It looks like, if we reach this error handling during the first iteration
of the for loop then err, which will be return value returned by the function,
is ininitialised. Perhaps this would be better expressed as follows?
(Completely untested!)

		err = enetc_int_vector_init(priv, i, v_tx_rings);
		if (err)
			goto fail;

Flagged by Smatch.

...

