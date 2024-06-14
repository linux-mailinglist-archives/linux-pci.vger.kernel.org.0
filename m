Return-Path: <linux-pci+bounces-8851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE0909271
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 20:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9228DA83
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563419E7E9;
	Fri, 14 Jun 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdoRubii"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410A19ADB3;
	Fri, 14 Jun 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390482; cv=none; b=Qud8rzLRbJ0DFPMgo4xZPy0ZWvMkItSIhzsrwQaktIMdR2lXUeMOWA7H6P55d6GBrxVAuWva9OEEF3foXlOZFa2TzHuMZybKFXqd9EVTJq4PqNS56YuGj8hE3uvc09Z8DbYVGt+kkpXMm5GHgCdD9HRKtrEzZKodm+FxsX1RovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390482; c=relaxed/simple;
	bh=P07/BQZkPkF9FnxI2OX1PtX5RC9VyYSc7T71VMYgMcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OH2uI5hForYbX9TANndk4asfqnUBDEe3cXGkKpV9MWSQHMSNseAS9AH2FiY2JMQJwr5SDQWJV9w17vbJxwwgUnR1LRFLVDgPgv6SXGaLJbFfFws/c50K+Mx7aw2nUkVk7gwbkg5zj2WnxCd6oTh1l1AbmxTWoWZnzOzjd/3w1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdoRubii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0A7C2BD10;
	Fri, 14 Jun 2024 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718390482;
	bh=P07/BQZkPkF9FnxI2OX1PtX5RC9VyYSc7T71VMYgMcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BdoRubiiBTPh3kWCbiUfJTealstQfX+M3ros81e9pRS4bWcO1u4UH5oJkQoueNjAk
	 UIZBn+eHPrP1aZwRJiRZc2w986CW3lIE+V8Db9VyIiwKhLR8M8gxpER/TPPsTnq6S+
	 dlPc//PQq5/SdiwK+UThju0jWRSWv8BWBd6lZ/aOLRkjEJ8D4aRcvfkPXE9gYOCUFl
	 KmOavAwFesaD6ieQ0QizHInuU417KLSFiAZ9v04aJNHkkrgoNDIv2vKiMZ27RKOUED
	 ZxoTU+C6/sYNf/fqRZdduQfOEeW31dyF/VBML+xWgifSrmmtcNTOGxIkzxc2/J79F5
	 bGQ2Em5i8J6pg==
Date: Fri, 14 Jun 2024 13:41:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: lukas@wunner.de, bhelgaas@google.com, weirongguang@kylinos.cn,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kanie@linux.alibaba.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv2] PCI: pciehp: Use appropriate conditions to check the
 hotplug controller status
Message-ID: <20240614184120.GA1121063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528064200.87762-1-yaoma@linux.alibaba.com>

[+cc Ilpo]

On Tue, May 28, 2024 at 02:42:00PM +0800, Bitao Hu wrote:
> "present" and "link_active" can be 1 if the status is ready, and 0 if
> it is not. Both of them can be -ENODEV if reading the config space
> of the hotplug port failed. That's typically the case if the hotplug
> port itself was hot-removed. Therefore, this situation can occur:
> pciehp_card_present() may return 1 and pciehp_check_link_active()
> may return -ENODEV because the hotplug port was hot-removed in-between
> the two function calls. In that case we'll emit both "Card present"
> *and* "Link Up" since both 1 and -ENODEV are considered "true". This
> is not the expected behavior. Those messages should be emited when
> "present" and "link_active" are positive.
> 
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> v1 -> v2:
> 1. Explain the rationale of the code change in the commit message
> more clearly.
> 2. Add the "Reviewed-by" tag of Lukas.
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index dcdbfcf404dd..6adfdbb70150 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -276,10 +276,10 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	case OFF_STATE:
>  		ctrl->state = POWERON_STATE;
>  		mutex_unlock(&ctrl->state_lock);
> -		if (present)
> +		if (present > 0)

I completely agree that this is a problem and this patch addresses it.
But ...

It seems a little bit weird to me that we even get to this switch
statement if we got -ENODEV from either pciehp_card_present() or
pciehp_check_link_active().  If that happens, a config read failed,
but we're going to go ahead and call pciehp_enable_slot(), which is
going to do a bunch more config accesses, potentially try to power up
the slot, etc.

If a config read failed, it seems like we might want to avoid doing
some of this stuff.

>  			ctrl_info(ctrl, "Slot(%s): Card present\n",
>  				  slot_name(ctrl));
> -		if (link_active)
> +		if (link_active > 0)
>  			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>  				  slot_name(ctrl));

These are cases where we misinterpreted -ENODEV as "device is present"
or "link is active".

pciehp_ignore_dpc_link_change() and pciehp_slot_reset() also call
pciehp_check_link_active(), and I think they also interpret -ENODEV as
"link is active".

Do we need similar changes there?

>  		ctrl->request_result = pciehp_enable_slot(ctrl);
> -- 
> 2.37.1 (Apple Git-137.1)
> 

