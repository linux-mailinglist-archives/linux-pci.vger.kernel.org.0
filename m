Return-Path: <linux-pci+bounces-10678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F297D93A96E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F322841B4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9F143C77;
	Tue, 23 Jul 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4IDhQzr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E31422AB;
	Tue, 23 Jul 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774651; cv=none; b=eDarMjdGPn+WEWCfrz9vTXK2dVD6YNTsySz6YwPPnukVZMQznSGU8TDP7BkjkKHyIhy27F7NXyXuDqF3qP6WkY7ocNqMmmXVvZaDR9MJBbWpkzuUrWTwj+rQqPEcNXu5/892Ows5S98cWhVBzni8GpkxR9V2xzQRQ7SFCmJz5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774651; c=relaxed/simple;
	bh=AQI883Cu7SaB5V4e/b8n1Uo6AlMO7QJgsxnRLVpSvMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tEOIILnGnNX/FJg4mMx+apSyytezKcmnkl6AYJ+0ow2PO59GJc0QfphW3MSRTyPSV+CQq8850SUqBGaHtCduWfX6/wfbjbsf0CdMRH0XX8b8uN0kwDGlET5CXM1P0OVBa6EgklgS+fCw61Pm8STDXoTwvVEU5v/SxolMwSm+cgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4IDhQzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8981AC4AF0A;
	Tue, 23 Jul 2024 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721774650;
	bh=AQI883Cu7SaB5V4e/b8n1Uo6AlMO7QJgsxnRLVpSvMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d4IDhQzrA0CWCB5XyCIQoSnLdwyQUwg+hE2bGAJdsxkH6CuREP5ZfvjKLDC1ZHF4f
	 auFYmN89jfk2+KA/BlzrarrmROYC/t1vvrWuWLUErXGQdj6ZluG2/sqrPYIvtXRV+K
	 3AwpRF1B48turD0JM7y1VZ8PfP8s7ZQjvEI43WH0IY7ccXG7woHffVdXPSHT8G7rYx
	 FIbAlf4qoCRhc6jnN3r6VWWGZKE2y1rPbAdNR5zcUFRNSokxWgsovm3OIb88bvPbDl
	 qwgJgUlyn38DdFm9VvyYWEkwArqIXaytvMZOiar0TAzotXR2q9RW0LstKclDnAQo+7
	 RCqOeHvbcFDIA==
Date: Tue, 23 Jul 2024 17:44:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 04/10] PCI/TPH: Add pci=nostmode to force No ST Mode
Message-ID: <20240723224408.GA779931@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-5-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:05PM -0500, Wei Huang wrote:
> When "No ST mode" is enabled, endpoint devices can generate TPH headers
> but with all steering tags treated as zero. A steering tag of zero is
> interpreted as "using the default policy" by the root complex. This is
> essential to quantify the benefit of steering tags for some given
> workloads.

Capitalize technical terms defined by spec.

> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4656,6 +4656,7 @@
>  		norid		[S390] ignore the RID field and force use of
>  				one PCI domain per PCI function
>  		notph		[PCIE] Do not use PCIe TPH
> +		nostmode	[PCIE] Force TPH to use No ST Mode

Needs a little more context here about what this means.  Users won't
know where to even look for "No ST Mode" unless they have a copy of
the spec.

> +++ b/drivers/pci/pci-driver.c
> @@ -324,8 +324,13 @@ static long local_pci_probe(void *_ddi)
>  	pci_dev->driver = pci_drv;
>  	rc = pci_drv->probe(pci_dev, ddi->id);
>  	if (!rc) {
> -		if (pci_tph_disabled())
> +		if (pci_tph_disabled()) {
>  			pcie_tph_disable(pci_dev);
> +			return rc;
> +		}
> +
> +		if (pci_tph_nostmode())
> +			pcie_tph_set_nostmode(pci_dev);

Same comment here; can we do this outside the probe() path somehow?

>  		return rc;
>  	}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4cbfd5b53be8..8745ce1c4a9a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -160,6 +160,9 @@ static bool pcie_ats_disabled;
>  /* If set, the PCIe TPH capability will not be used. */
>  static bool pcie_tph_disabled;
>  
> +/* If TPH is enabled, "No ST Mode" will be enforced. */
> +static bool pcie_tph_nostmode;
> +
>  /* If set, the PCI config space of each device is printed during boot. */
>  bool pci_early_dump;
>  
> @@ -175,6 +178,12 @@ bool pci_tph_disabled(void)
>  }
>  EXPORT_SYMBOL_GPL(pci_tph_disabled);
>  
> +bool pci_tph_nostmode(void)
> +{
> +	return pcie_tph_nostmode;
> +}
> +EXPORT_SYMBOL_GPL(pci_tph_nostmode);

s/pci/pcie/

Unexport unless it's useful for drivers.

Bjorn

