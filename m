Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24159171E45
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbgB0OJw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 09:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbgB0OJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 09:09:50 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06EB20578;
        Thu, 27 Feb 2020 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812590;
        bh=X9rl3ZGCnjqX0Ce24td4V97fsDt8ivYeM1csu23KtbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LFdE44vcMhziqC8vsqlprJou46T1FdXaTAU/cTGFMoy+JuvwXVnfxZvhShBpXVo9/
         Ejhv5CEdeoWe0x4rO3WB6EcngNXFybpnYhP+JD2koCrpknOOJ7hjlr6e3SwMwZqf6O
         tGDeNshu3lujRonV6asb77lm++OB/Rz3dhevOyAw=
Date:   Thu, 27 Feb 2020 08:09:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH] pci: brcmstb: Fix build on 32bit ARM platforms with
 older compilers
Message-ID: <20200227140948.GA78063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227115146.24515-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 27, 2020 at 12:51:46PM +0100, Marek Szyprowski wrote:
> Some older compilers have no implementation for the helper for 64-bit
> unsigned division/modulo, so linking pcie-brcmstb driver causes the
> "undefined reference to `__aeabi_uldivmod'" error.
> 
> *rc_bar2_size is always a power of two, because it is calculated as:
> "1ULL << fls64(entry->res->end - entry->res->start)", so the modulo
> operation in the subsequent check can be replaced by a simple logical
> AND with a proper mask.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied to for-linus for v5.6, thanks!  I added acks from Nicolas and
Lorenzo and also the Fixes: tag from Lorenzo.

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index d20aabc26273..3a10e678c7f4 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -670,7 +670,7 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  	 *   outbound memory @ 3GB). So instead it will  start at the 1x
>  	 *   multiple of its size
>  	 */
> -	if (!*rc_bar2_size || *rc_bar2_offset % *rc_bar2_size ||
> +	if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
>  	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
>  		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
>  			*rc_bar2_size, *rc_bar2_offset);
> -- 
> 2.17.1
> 
