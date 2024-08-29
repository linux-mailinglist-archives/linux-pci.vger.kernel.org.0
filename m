Return-Path: <linux-pci+bounces-12426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDE964340
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C0C1C245E5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A75191F63;
	Thu, 29 Aug 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Yahnon1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC451BC4E;
	Thu, 29 Aug 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931626; cv=none; b=qZDA3Fn2x3ujQWUtPYxjrP40tXczncJ06h4JdlhWES5gbRgdV6nDxbJU6Xbkdv48WZKmjupAt0gSsFUQnA7OYOrAg0eOWjNGxGxO8v9gDsiA97Og2pDP79qZ3MBQnL1OWHIeYo2W7jfKq0FZ9hL4s+6aYA0z6Nt7VuhlMnC1PcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931626; c=relaxed/simple;
	bh=SFVuAL2kD4CosY9oMHphCuK5CtjbXsRN4j2TZuO5WPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c00j7fuVJGSGAgW22/PEnOiCqFnJLjOcbPVsmjJkmAYdBSSjDSTwDlrrt8uVV8dWt46n4UabBN2W09dafBcVH4beLs/8RSRBGOY48WcoDT2hKPfXMX/ovZG58l4RxDb1VjBdZOJ4ssHdUyxPPE/Xrgb1wlHqh08eH+cd5ZCvH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Yahnon1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2BFC4CEC1;
	Thu, 29 Aug 2024 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724931625;
	bh=SFVuAL2kD4CosY9oMHphCuK5CtjbXsRN4j2TZuO5WPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Yahnon1cwdpHcFslui6nXemu1HsuN1J5l5QGjELumFP+DH5dDvti75Pp36GWcgtV
	 MfZGb9JYzsqJs+IbGl73ztb8nfr+2PTlfieWeSWAeJMUMCiABF8wUCtGzXfjVmWaBg
	 LfToVKb5X4YvTI6rrGgMWhvbUaNjvkFMRVdqVtM8=
Date: Thu, 29 Aug 2024 13:40:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	guanwentao@uniontech.com, Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: Re: [PATCH v2] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
Message-ID: <2024082907-earthy-strategic-bfd5@gregkh>
References: <196A709D168A9A04+20240829095028.345047-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196A709D168A9A04+20240829095028.345047-1-wangyuli@uniontech.com>

On Thu, Aug 29, 2024 at 05:50:28PM +0800, WangYuli wrote:
> The resume operation of Phytium Px210 xHCI host would failed
> to restore state. Use the XHCI_RESET_ON_RESUME quirk to skip
> it and reset the controller after resume.
> 
> Co-developed-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
> Co-developed-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Signed-off-by: Wang Zhimin <wangzhimin1179@phytium.com.cn>
> Co-developed-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
> Signed-off-by: Chen Zhenhua <chenzhenhua@phytium.com.cn>
> Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
> Co-developed-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
> Signed-off-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/usb/host/xhci-pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b5705ed01d83..fabae8420ce9 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -55,6 +55,9 @@
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
>  
> +#define PCI_VENDOR_ID_PHYTIUM		0x1db7
> +#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
> +
>  /* Thunderbolt */
>  #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
> @@ -407,6 +410,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA)
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_PHYTIUM ||
> +	    pdev->device == PCI_DEVICE_ID_PHYTIUM_XHCI)
> +		xhci->quirks |= XHCI_RESET_ON_RESUME;
> +
>  	/* See https://bugzilla.kernel.org/show_bug.cgi?id=79511 */
>  	if (pdev->vendor == PCI_VENDOR_ID_VIA &&
>  			pdev->device == 0x3432)
> -- 
> 2.43.4
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

