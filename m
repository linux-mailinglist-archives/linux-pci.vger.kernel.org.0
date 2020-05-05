Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82E1C5240
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgEEJ51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 05:57:27 -0400
Received: from foss.arm.com ([217.140.110.172]:35894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEJ51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 05:57:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D177A30E;
        Tue,  5 May 2020 02:57:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B66C83F305;
        Tue,  5 May 2020 02:57:25 -0700 (PDT)
Date:   Tue, 5 May 2020 10:57:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: dwc: clean up computing of msix_tbl
Message-ID: <20200505095723.GB12543@e121166-lin.cambridge.arm.com>
References: <20200420065227.4920-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420065227.4920-1-jslaby@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 20, 2020 at 08:52:27AM +0200, Jiri Slaby wrote:
> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> correct MSI-X table address") overcomplicated the computation of the
> msix_tbl address. Simplify it as it's simply the addr + offset. Provided
> addr is (void *) already.
> 
> objdump -d shows no difference after this patch.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied to pci/dwc, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1cdcbd102ce8..c815d36905b6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -433,7 +433,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct pci_epf_msix_tbl *msix_tbl;
>  	struct pci_epc *epc = ep->epc;
> -	struct pci_epf_bar *epf_bar;
>  	u32 reg, msg_data, vec_ctrl;
>  	unsigned int aligned_offset;
>  	u32 tbl_offset;
> @@ -446,10 +445,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>  
> -	epf_bar = ep->epf_bar[bir];
> -	msix_tbl = epf_bar->addr;
> -	msix_tbl = (struct pci_epf_msix_tbl *)((char *)msix_tbl + tbl_offset);
> -
> +	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
>  	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
>  	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
>  	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
> -- 
> 2.26.1
> 
