Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229DA1FC160
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 00:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFPWFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 18:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgFPWFP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 18:05:15 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBECB212CC;
        Tue, 16 Jun 2020 22:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592345114;
        bh=hv4wPFyEJRd4xzxF/vGpJzArF+FF4asaZjnXJFSaXAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pN5SkitGCKCS+Mw9K8Zik3vNpfxrZdM1jl+uXR1ciXvPJnFlnB3yP53tqSYPbeOz0
         d0/kRrFurOBuvMgPzdUG8On6/wDy2XoCjDE3/AawEKqdrMVF3EgWJ0uWNdenDgocZt
         GzGxSMdsavN5Uxaa793zchM9Tt4TzTKMm7i8FXe8=
Date:   Tue, 16 Jun 2020 17:05:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 06/12] PCI: brcmstb: Add bcm7278 PERST support
Message-ID: <20200616220511.GA1984089@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616205533.3513-7-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 04:55:13PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> The PERST bit was moved to a different register in 7278-type STB chips.  In
> addition, the polarity of the bit was also changed; for other chips writing
> a 1 specified assert; for 7278-type chips, writing a 0 specifies assert.
> 
> Signal-wise, PERST is an asserted-low signal.

s/PERST/PERST#/ to match usage of the signal name in spec.

The PERST bit above is the name of a register bit, so use whatever
matches the STB spec.

> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 7c148eb65170..d0e256d8578a 100644
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
> @@ -685,9 +686,16 @@ static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp;
>  
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	if (pcie->type == BCM7278) {
> +		/* Perst bit has moved and assert value is 0 */

s/Perst/PERST/ or PERST# so it doesn't look like an English word and
to match the STB spec.

> +		tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
> +		u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
> +		writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
> +	} else {
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	}
>  }
>  
>  static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> -- 
> 2.17.1
> 
