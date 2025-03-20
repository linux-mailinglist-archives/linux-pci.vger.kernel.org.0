Return-Path: <linux-pci+bounces-24260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65651A6AF9B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29923BA315
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19AF22A7F4;
	Thu, 20 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf3sZD96"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DC22687B;
	Thu, 20 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504819; cv=none; b=TBBMYeoklDcfpFS2c1Fx0I+zuiLfSstxOsjLwMtNS2S+NTVsIFtaC/G6JF7hPmkKNitwwfh1wX6u5owU/3/iuQJqSTOHEYHSmsmQp+mPviUTn/xiNtnodnihfCpvv5S2t7ZzJZr/LjHzlxI5eAp1nT6InJBxDVfxQ50t/HXTyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504819; c=relaxed/simple;
	bh=HJwmsuBl4GXsCQaTwFacbejN4+pW0Ti4oR/v22e/4ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ioyHTXaUbrKDZ2/ooYYf4MloHZlwlFF9LzXnnaN26zlBQcoXygRYd8OmyaSJmPGh5+kbmpcIQl6FUzwzjF/EsmJt9NLfJBcopKq3Yzt5tm8SbFbkNSbg2n9lBaJkkvIoFkB4qNjJPxsAWmBvznyBGbsr1u3HrXqbqZv4xNFSTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf3sZD96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E3DC4CEDD;
	Thu, 20 Mar 2025 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742504819;
	bh=HJwmsuBl4GXsCQaTwFacbejN4+pW0Ti4oR/v22e/4ZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cf3sZD96OvC1io70X3978viKdgFIwJoj1vBnbZvWwXaz+Q3yxvcE4qwgMPEA9tqwA
	 NwX14JIWitf/STv86rzIW2Y4ulqHCAIJoysCRoaNq7GZwcMoxoxR8PPdEqLstK9g5p
	 tgzHfymTSJZ9K0mddPgC731UpiRo212EkyMtnKAHXJmF6RWHzUqWmHAMaxCALWY/KB
	 SgW4Bjdk3W2zN7Pw72+bl/0B887JFrYKqOHmpWum7CNflwj0hFPItGJckd9I1So/oX
	 NU6vEMSFRQWqujdjFvbi/0+hXONOdkul2aLYo6XSafsmyWfwb+W6dVcS3dnpuO6txk
	 kJ6HN4vUTJLyQ==
Date: Thu, 20 Mar 2025 16:06:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/3] PCI: vmd: Disable MSI remapping bypass under Xen
Message-ID: <20250320210657.GA1099656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219092059.90850-3-roger.pau@citrix.com>

On Wed, Feb 19, 2025 at 10:20:56AM +0100, Roger Pau Monne wrote:
> MSI remapping bypass (directly configuring MSI entries for devices on the
> VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
> and hence cannot configure the entries using the pIRQ interface in the PV
> case, and in the PVH case traps won't be setup for MSI entries for such
> devices.
> 
> Until Xen is aware of devices in the VMD bus prevent the
> VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
> any kind of Xen guest.
> 
> The MSI remapping bypass is an optional feature of VMD bridges, and hence
> when running under Xen it will be masked and devices will be forced to
> redirect its interrupts from the VMD bridge.  That mode of operation must
> always be supported by VMD bridges and works when Xen is not aware of
> devices behind the VMD bridge.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changes since v2:
>  - Adjust patch subject.
>  - Adjust code comment.
> 
> Changes since v1:
>  - Add xen header.
>  - Expand comment.
> ---
>  drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947350..e619accca49d 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -17,6 +17,8 @@
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
>  
> +#include <xen/xen.h>
> +
>  #include <asm/irqdomain.h>
>  
>  #define VMD_CFGBAR	0
> @@ -970,6 +972,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int err;
>  
> +	if (xen_domain()) {
> +		/*
> +		 * Xen doesn't have knowledge about devices in the VMD bus
> +		 * because the config space of devices behind the VMD bridge is
> +		 * not known to Xen, and hence Xen cannot discover or configure
> +		 * them in any way.
> +		 *
> +		 * Bypass of MSI remapping won't work in that case as direct
> +		 * write by Linux to the MSI entries won't result in functional
> +		 * interrupts, as Xen is the entity that manages the host
> +		 * interrupt controller and must configure interrupts.  However
> +		 * multiplexing of interrupts by the VMD bridge will work under
> +		 * Xen, so force the usage of that mode which must always be
> +		 * supported by VMD bridges.
> +		 */
> +		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
> +	}
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> -- 
> 2.46.0
> 

