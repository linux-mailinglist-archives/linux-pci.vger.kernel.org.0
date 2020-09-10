Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E7264E36
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgIJTF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:05:57 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45252 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731490AbgIJQES (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 12:04:18 -0400
Received: by mail-il1-f195.google.com with SMTP id q6so6107072ild.12;
        Thu, 10 Sep 2020 09:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ebp5z+46rHgEspLwslVPrPQpZSFjnRSho3Me2D+xH8o=;
        b=T/eCReFLd2aPNzyT7ZHj2N/pB6N+N6GsdfSCtpIWCA3oUUPXT/XTzBRZVziCM/4kch
         oHxZYl9M9GcuoYdluXs+n1lzdBPVIFlWK3H+RPXl20yYfbT2YqNbhHtEFCUzHBDWlOOU
         VyAOlUbFkhs8E682dQf9xUfjGvZw9ZdzXk7rz9pwn96YpMZTtUoRr7eLN0R8+WNb5EaG
         ZvW3rzaeDQzP5pG+2gb/Iw5AdzLuXi9vQE0O0DZ6Tp+eUpHOBnIo1lhtBYloN7WnbSZa
         XqvODt5lH7QxmwEbXc8EpssNy3FY8sOkG0LUo/adr0CdXoLDs3kCOpqzICtTd+3tJr3b
         +nnA==
X-Gm-Message-State: AOAM531y4ZlgwRMDnUmdhd3YnXE+z5iw6r9pFvwOYkAIUq+bH78t2G1y
        nm9zJ4LyjF2O8Hj9KsfBLI3AT9Im1uYL
X-Google-Smtp-Source: ABdhPJwEriHzybxiHldBLmDpi2mvi2cZg5tHwCiO7MmmEqZLF4YSjxhJdd6BIxqEmm2n29ddo/Nobg==
X-Received: by 2002:a92:906:: with SMTP id y6mr8750650ilg.106.1599753852523;
        Thu, 10 Sep 2020 09:04:12 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e22sm3035082ioc.43.2020.09.10.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:04:12 -0700 (PDT)
Received: (nullmailer pid 449332 invoked by uid 1000);
        Thu, 10 Sep 2020 16:04:11 -0000
Date:   Thu, 10 Sep 2020 10:04:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 05/11] PCI: brcmstb: Add bcm7278 PERST# support
Message-ID: <20200910160411.GA439527@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-6-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-6-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 03:30:18PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> The PERST# bit was moved to a different register in 7278-type STB chips.
> In addition, the polarity of the bit was also changed; for other chips
> writing a 1 specified assert; for 7278-type chips, writing a 0 specifies
> assert.
> 
> Of course, PERST# is a PCIe asserted-low signal.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 3d588ab7a6dd..acf2239b0251 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -83,6 +83,7 @@
>  
>  #define PCIE_MISC_PCIE_CTRL				0x4064
>  #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
> +#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
>  
>  #define PCIE_MISC_PCIE_STATUS				0x4068
>  #define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK		0x80
> @@ -684,9 +685,16 @@ static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp;
>  
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	if (pcie->type == BCM7278) {
> +		/* Perst bit has moved and assert value is 0 */
> +		tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
> +		u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
> +		writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
> +	} else {
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));

Humm, now we have a mixture of a code path based on the chip and 
variables to abstract the register details. Just do a function per chip.

I have some notion to abstract out the PERST# handling from the host 
bridges. We have several cases of GPIO based handling and random 
assertion times. So having an ops function here will move in that 
direction.

> +	}
>  }
>  
>  static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> @@ -771,7 +779,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  
>  	/* Reset the bridge */
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
> -	brcm_pcie_perst_set(pcie, 1);

If these 2 functions are always called together, then you just need 1 
per chip function.

> +
> +	/* BCM7278 fails when PERST# is set here */
> +	if (pcie->type != BCM7278)
> +		brcm_pcie_perst_set(pcie, 1);
>  
>  	usleep_range(100, 200);
>  
> -- 
> 2.17.1
> 
