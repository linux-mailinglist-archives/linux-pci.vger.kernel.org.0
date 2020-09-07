Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2947D25F675
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgIGJ2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 05:28:50 -0400
Received: from foss.arm.com ([217.140.110.172]:58614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgIGJ2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 05:28:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E62B30E;
        Mon,  7 Sep 2020 02:28:45 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24AE93F66E;
        Mon,  7 Sep 2020 02:28:44 -0700 (PDT)
Date:   Mon, 7 Sep 2020 10:28:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        robh@kernel.org, bhelgaas@google.com, amurray@thegoodpenguin.co.uk,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com
Subject: Re: [PATCHv2] PCI: designware-ep: Fix the Header Type check
Message-ID: <20200907092841.GB6428@e121166-lin.cambridge.arm.com>
References: <20200818092746.24366-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818092746.24366-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 18, 2020 at 05:27:46PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The current check will result in the multiple function device
> fails to initialize. So fix the check by masking out the
> multiple function bit.
> 
> Fixes: 0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Add marco PCI_HEADER_TYPE_MASK and print the masked value.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 ++-
>  include/uapi/linux/pci_regs.h                   | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 4680a51c49c0..0634bd3a0b96 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -653,7 +653,8 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  	u32 reg;
>  	int i;
>  
> -	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> +	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> +		   PCI_HEADER_TYPE_MASK;
>  	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
>  		dev_err(pci->dev,
>  			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..57a222014cd2 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -76,6 +76,7 @@
>  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
>  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
>  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
> +#define  PCI_HEADER_TYPE_MASK		0x7f
>  #define  PCI_HEADER_TYPE_NORMAL		0
>  #define  PCI_HEADER_TYPE_BRIDGE		1
>  #define  PCI_HEADER_TYPE_CARDBUS	2
> -- 
> 2.17.1
> 
