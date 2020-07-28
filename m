Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C372307C1
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgG1Kgo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 06:36:44 -0400
Received: from foss.arm.com ([217.140.110.172]:60560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgG1Kgo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 06:36:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0231FB;
        Tue, 28 Jul 2020 03:36:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E872B3F66E;
        Tue, 28 Jul 2020 03:36:42 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:36:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: cadence: Fix unused-but-set-variable warning
Message-ID: <20200728103622.GA905@e121166-lin.cambridge.arm.com>
References: <20200725091945.75176-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725091945.75176-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 25, 2020 at 05:19:45PM +0800, Wei Yongjun wrote:
> Gcc report warning as followings:
> 
> drivers/pci/controller/cadence/pcie-cadence-ep.c:390:33: warning:
>  variable 'vec_ctrl' set but not used [-Wunused-but-set-variable]
>   390 |  u32 tbl_offset, msg_data, reg, vec_ctrl;
>       |                                 ^~~~~~~~
> 
> This variable is not used so this commit removing it.
> 
> Fixes: dae15ff2c7a9 ("PCI: cadence: Add MSI-X support to Endpoint driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Squashed in the original commit, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 87c76341eab4..ec1306da301f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -387,7 +387,7 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
>  				      u16 interrupt_num)
>  {
>  	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> -	u32 tbl_offset, msg_data, reg, vec_ctrl;
> +	u32 tbl_offset, msg_data, reg;
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct pci_epf_msix_tbl *msix_tbl;
>  	struct cdns_pcie_epf *epf;
> @@ -410,7 +410,6 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
>  	msix_tbl = epf->epf_bar[bir]->addr + tbl_offset;
>  	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
>  	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
> -	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
>  
>  	/* Set the outbound region if needed. */
>  	if (ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
> 
