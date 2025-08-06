Return-Path: <linux-pci+bounces-33493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC7B1CEFD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 00:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA6917A042
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43D23505F;
	Wed,  6 Aug 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWGQg/wR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D32233D9C;
	Wed,  6 Aug 2025 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754518017; cv=none; b=YgRrK2TJw6QerOFKwIENpnl7RD88W4i2gfc1iKjW7rHFcoRUZhtrtilciLQZei65CR2vEf0yZ/tyqU68l1pZ5/J6uaDI19PxU0t+7Xzd0ek7MFqybDIeitDLDJwXeH2tC9uA67Z1V8ib74ZlGZAtd62bLSxXrSvwfphgOn/Qm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754518017; c=relaxed/simple;
	bh=W5KDX1Oo+lZSX0tbOFKjtk+FjaBNv9Ve/X9SznlVBBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DiozhFH5rcxvmGYI/2LU/vg/jKza7gR6QxDpCG8o/AdmcHMdKRn07Ol6khf7yXJRibAmdWtwvnS27O2RoKQ/6BLadsdOZeBeDKZQQB0pZ7atFdmUld+cg2/+br9OrsyDtkvvrN0aqtNhK1IrhP6+/RHcwoLI0lRIQhkEJEqd2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWGQg/wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80E5C4CEE7;
	Wed,  6 Aug 2025 22:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754518014;
	bh=W5KDX1Oo+lZSX0tbOFKjtk+FjaBNv9Ve/X9SznlVBBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fWGQg/wRiMFXJBoaCDiw2bEI6tPeGVH4K/WgBmVH6Gyz07KICeFO95Pwuxid2uO2m
	 uzvybAuw9CB/waZUM42423hArIR2wbjWKdRmMPJ4jAQt4bYmGljl1/0CYuebizzaPR
	 z1wTYm51FKbj/Tdv4gX9whVVTaCuRoYnHxAhvDHXkvUMwO7enbcAPGFiga+vWrI+50
	 rFl2rvyk5ydK8lGDZRtuSQzxTEElfrPSNolj7qhucLVaR7TQSfRXSeoGDtEeE4LaDa
	 7GRM+nqDePC3a+kbAhyMoxsfnfHDWBEZb4QdlthJN+qT1q+MHZU3ipX6JD/Tbl1nTr
	 PA3xWDHuoNb5Q==
Date: Wed, 6 Aug 2025 17:06:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: grwhyte@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Add flr_delay parameter to pci_dev struct
Message-ID: <20250806220653.GA20136@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611000552.1989795-2-grwhyte@linux.microsoft.com>

On Wed, Jun 11, 2025 at 12:05:51AM +0000, grwhyte@linux.microsoft.com wrote:
> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a new flr_delay member of the pci_dev struct to allow customization of
> the delay after FLR for devices that do not support immediate readiness.
> 
> Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
> ---
>  drivers/pci/pci.c   | 8 ++++++--
>  drivers/pci/pci.h   | 2 ++
>  include/linux/pci.h | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..04f2660df7c4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3233,6 +3233,8 @@ void pci_pm_init(struct pci_dev *dev)
>  	dev->bridge_d3 = pci_bridge_d3_possible(dev);
>  	dev->d3cold_allowed = true;
>  
> +	dev->flr_delay = PCI_FLR_DELAY;

There are some delays mentioned in pci_pm_init(), but I don't think
this one has anything to do with the PM Capability, so it should go
elsewhere.  Maybe somewhere related to this recent change:
https://git.kernel.org/linus/5c0d0ee36f16 ("PCI: Support Immediate
Readiness on devices without PM cap abilities").

This would be more attractive if we actually added support for the
Readiness Time Reporting Capability (PCIe r7.0, sec 7.9.16).  Then
devices that implement that would get actual benefit from this.

I'm not committing to merging a quirk just for the Microsoft devices,
but I definitely wouldn't merge it unless devices that did the work of
supporting the standard mechanism also got the benefit.  The hardest
part might be *finding* a device that supports Readiness Time
Reporting so we could test it.

>  	dev->d1_support = false;
>  	dev->d2_support = false;
>  	if (!pci_no_d1d2(dev)) {
> @@ -4529,9 +4531,11 @@ int pcie_flr(struct pci_dev *dev)
>  	/*
>  	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
>  	 * 100ms, but may silently discard requests while the FLR is in
> -	 * progress.  Wait 100ms before trying to access the device.
> +	 * progress.  Wait 100ms before trying to access the device, unless
> +	 * otherwise modified if the device supports a faster reset.
> +	 * Use usleep_range to support delays under 20ms.
>  	 */
> -	msleep(100);
> +	usleep_range(dev->flr_delay, dev->flr_delay+1);

As Ilpo suggested, I think fsleep() is the right thing for this.
Readiness Time Reporting supports values down to 1ns, but I suspect we
can live with microsecond resolution for now.

>  	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..abc1cf6e6d9b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -135,6 +135,8 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
>  #define PCI_PM_D3HOT_WAIT       10	/* msec */
>  #define PCI_PM_D3COLD_WAIT      100	/* msec */
>  
> +#define PCI_FLR_DELAY           100000 /* usec */

Isn't PCIE_RESET_CONFIG_WAIT_MS the right value for the default delay?
(I think that name was probably settled on after you posted this.)

Maybe it's not; I see that Readiness Time Reporting includes separate
values for Reset Time, DL_Up Time, FLR Time, and D3Hot to D0 Time.
I'm not sure Linux comprehends those differences yet.

>  void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
>  void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..4c9989037ed1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -402,6 +402,7 @@ struct pci_dev {
>  						   bit manually */
>  	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
> +	unsigned int    flr_delay;      /* pci post flr sleep time in us */

I think this should be named to correspond with the Readiness Time
Reporting Capability.  

>  	u16		l1ss;		/* L1SS Capability pointer */
>  #ifdef CONFIG_PCIEASPM
> -- 
> 2.25.1
> 

