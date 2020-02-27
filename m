Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8450C171737
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 13:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgB0Mab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 07:30:31 -0500
Received: from foss.arm.com ([217.140.110.172]:49606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgB0Mab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 07:30:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AD951FB;
        Thu, 27 Feb 2020 04:30:31 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF473F73B;
        Thu, 27 Feb 2020 04:30:29 -0800 (PST)
Date:   Thu, 27 Feb 2020 12:30:24 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH] pci: brcmstb: Fix build on 32bit ARM platforms with
 older compilers
Message-ID: <20200227123024.GA12798@e121166-lin.cambridge.arm.com>
References: <CGME20200227115151eucas1p22ff7409009d917addcc7e20f523c9051@eucas1p2.samsung.com>
 <20200227115146.24515-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227115146.24515-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject should be:

PCI: brcmstb: Fix build on 32bit ARM platforms with older compilers

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

Add a Fixes: tag please.

Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Bjorn,

I think this should be merged in one of the upcoming -rc, given that
it fixes v5.6 material.

Here is my ACK to that end, if you prefer postponing it to v5.7
please let me know.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
