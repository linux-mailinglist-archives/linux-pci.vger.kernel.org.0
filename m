Return-Path: <linux-pci+bounces-14433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A447699C547
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DA1B2A315
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25768158555;
	Mon, 14 Oct 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te8x9fNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC215667B;
	Mon, 14 Oct 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896805; cv=none; b=P265ywHm4RJwfcyL5kbY4OKIlmQwpv+2MFYFZ0pfN3d/rd28qkAaFfiU2NjX3HuULgC5unyeHE5k6Q+8S7TwglB+Q+RFvVGXWM/RGn7g/FlRmkfPUOdZoG3WyBQnB8d0egkz3cqvkMgYMUgODGIsvYiUB7C/flS3naU/GZ7St1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896805; c=relaxed/simple;
	bh=+arRMI4oQdev8xohI0seqIw/A02usyfTpyh9Hsbvkr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utRK7T6zAehxpefp9BcnxSjtLU2i0xMtDbNgoE7au9XqT5htDTCwnVMqZHASVNV/fbiIptRwQVWhUoq2RDqtfDBEpFoWN4jtyOevMlrg2vI2bTxMXgTZGE4TzgnP6IBD7Qr/BFbYQD/Foz6mI0+z9VIcq8D4eTlV+HZVRbpwR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te8x9fNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75E6C4CEC3;
	Mon, 14 Oct 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728896804;
	bh=+arRMI4oQdev8xohI0seqIw/A02usyfTpyh9Hsbvkr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=te8x9fNI3KAT1D6jE9pbMiNDNHsraRIIfzZoigMAw+OnWrlxyNQ1r1CcDQsaMjFIY
	 t3CAvebnHa6mgNmrkyJ8pggylF265Pc/JW9fpx5lmzDrhhXClafwNtqU5zMFXcIyLs
	 y128HlSiks0G9YaUa5usg8FAd6k8qHhBTVUvcqYt3N4b0/SzVGeFdLbVUPLqD1tC2Y
	 Qb74m0thhPIXj0aT7yN8myX+jMz0Vx/ibjh5oOhmau1WLg/tj2ZM+jPwuPGLE65kyv
	 6e/SRF854M7PD2kue6PIH/gtbYV0tzE/Ao3vzdno9H5k4hg1OXU1qAZfKtsIrAW9Kv
	 Ki2zfpXhuJ4/w==
Date: Mon, 14 Oct 2024 10:06:38 +0100
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
Subject: Re: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Message-ID: <20241014090638.GP77519@kernel.org>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-11-wei.fang@nxp.com>

On Wed, Oct 09, 2024 at 05:51:15PM +0800, Wei Fang wrote:
> The i.MX95 ENETC has been upgraded to revision 4.1, which is very
> different from the LS1028A ENETC (revision 1.0) except for the SI
> part. Therefore, the fsl-enetc driver is incompatible with i.MX95
> ENETC PF. So we developed the nxp-enetc4 driver for i.MX95 ENETC
> PF, and this driver will be used to support the ENETC PF with major
> revision 4 in the future.
> 
> Currently, the nxp-enetc4 driver only supports basic transmission
> feature for i.MX95 ENETC PF, the more basic and advanced features
> will be added in the subsequent patches.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

...

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

...

> +static void enetc4_pf_remove(struct pci_dev *pdev)
> +{
> +	struct enetc_si *si;
> +	struct enetc_pf *pf;
> +
> +	si = pci_get_drvdata(pdev);
> +	pf = enetc_si_priv(si);

Hi Wei Fang,

pf is set but otherwise unused in this function.  So I think that it, and
the call to enetc_si_priv() should probably be removed. They can be added
back if and when they are needed in subsequent patches.

> +
> +	enetc4_pf_netdev_destroy(si);
> +	enetc_pci_remove(pdev);
> +}

...

