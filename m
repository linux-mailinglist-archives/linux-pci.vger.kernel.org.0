Return-Path: <linux-pci+bounces-12413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E819963EF8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 10:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE861F2311E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0918C935;
	Thu, 29 Aug 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4uwt5hF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6E18C92A;
	Thu, 29 Aug 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921181; cv=none; b=GEpkbXbGvXxgHFS3s/vYRG2SAxB0Eu4n6U1YfeJqppX0Vix4DvWdC+2LUqEs4aWFFt6HJoPTMhW5swsssIA55UiVv4ZSUYjhK3DM0VqqdE+BSISJQ+bsC6XpxW7FmybDWf0UIP3Ta+Y4bInGIF8HVUUYDoPshmnykyGST4tjLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921181; c=relaxed/simple;
	bh=OLl/1jU4e+tqJCGyCkirUu2FQkqljjU6DWCAmTRuB4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MokVjl62SIrEHqsYPmpO5V2KwDc3s404GoYx5sMRnMplAx3ttdFaprEsY+44Z8BLSueWFS4g0mJlVa3aIx1NPmWlysbnzA4qRcwAMKXuQFbXA9Lq55STyTJQoVrjGHm/gWjzSiNZc6utpgsB1D9Oe69GZFPiG+UFG181M5Oka8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4uwt5hF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96D0C4CEC1;
	Thu, 29 Aug 2024 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724921181;
	bh=OLl/1jU4e+tqJCGyCkirUu2FQkqljjU6DWCAmTRuB4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4uwt5hFg1NzB+XhviMkhy/MYnklTjHRG9BqEoOGm5XWaXuJuL7WyXvLnhguxGER0
	 PMNSxBpTz6y/MchvnIMm3dK/EwaXJ2ULr2/DzEkLpjlU0sX9v4nNqOrc2T894ETSr7
	 rMnElVcsKC/qnkTNA9gwJL6VAUmPlgJgMvpNnHK8=
Date: Thu, 29 Aug 2024 10:46:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: mathias.nyman@intel.com, bhelgaas@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	guanwentao@uniontech.com, zhanjun@uniontech.com,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: Re: [PATCH] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
Message-ID: <2024082944-say-caution-befe@gregkh>
References: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>

On Thu, Aug 29, 2024 at 03:30:05PM +0800, WangYuli wrote:
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
>  drivers/usb/host/xhci-pci.c | 6 ++++++
>  include/linux/pci_ids.h     | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b5705ed01d83..af967644489c 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -55,6 +55,8 @@
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
>  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
>  
> +#define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
> +
>  /* Thunderbolt */
>  #define PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI		0x1138
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_XHCI	0x15b5
> @@ -407,6 +409,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
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
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e388c8b1cbc2..25fff4130503 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2605,6 +2605,8 @@
>  
>  #define PCI_VENDOR_ID_FUNGIBLE		0x1dad
>  
> +#define PCI_VENDOR_ID_PHYTIUM		0x1db7

Please read the top of this file, there's no need to add this id to this
file as you are only using it in one .c file.

thanks,

greg k-h

