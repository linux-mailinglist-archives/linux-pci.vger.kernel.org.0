Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E040E4737
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408769AbfJYJaO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 05:30:14 -0400
Received: from foss.arm.com ([217.140.110.172]:37738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408067AbfJYJaO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 05:30:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D17831F;
        Fri, 25 Oct 2019 02:30:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2A2B3F71F;
        Fri, 25 Oct 2019 02:30:12 -0700 (PDT)
Date:   Fri, 25 Oct 2019 10:30:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Abhishek Shah <abhishek.shah@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/1] PCI: iproc: Invalidate PAXB address mapping before
 programming it
Message-ID: <20191025093008.GA8852@e121166-lin.cambridge.arm.com>
References: <20190906035813.24046-1-abhishek.shah@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906035813.24046-1-abhishek.shah@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 09:28:13AM +0530, Abhishek Shah wrote:
> Invalidate PAXB inbound/outbound address mapping each time before
> programming it. This is helpful for the cases where we need to
> reprogram inbound/outbound address mapping without resetting PAXB.
> kexec kernel is one such example.
> 
> Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vikram Mysore Prakash <vikram.prakash@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Merged in pci/iproc (rewrote commit log), thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index e3ca46497470..99a9521ba7ab 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1245,6 +1245,32 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
>  	return ret;
>  }
>  
> +static void iproc_pcie_invalidate_mapping(struct iproc_pcie *pcie)
> +{
> +	struct iproc_pcie_ib *ib = &pcie->ib;
> +	struct iproc_pcie_ob *ob = &pcie->ob;
> +	int idx;
> +
> +	if (pcie->ep_is_internal)
> +		return;
> +
> +	if (pcie->need_ob_cfg) {
> +		/* iterate through all OARR mapping regions */
> +		for (idx = ob->nr_windows - 1; idx >= 0; idx--) {
> +			iproc_pcie_write_reg(pcie,
> +					     MAP_REG(IPROC_PCIE_OARR0, idx), 0);
> +		}
> +	}
> +
> +	if (pcie->need_ib_cfg) {
> +		/* iterate through all IARR mapping regions */
> +		for (idx = 0; idx < ib->nr_regions; idx++) {
> +			iproc_pcie_write_reg(pcie,
> +					     MAP_REG(IPROC_PCIE_IARR0, idx), 0);
> +		}
> +	}
> +}
> +
>  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
>  			       struct device_node *msi_node,
>  			       u64 *msi_addr)
> @@ -1517,6 +1543,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  	iproc_pcie_perst_ctrl(pcie, true);
>  	iproc_pcie_perst_ctrl(pcie, false);
>  
> +	iproc_pcie_invalidate_mapping(pcie);
> +
>  	if (pcie->need_ob_cfg) {
>  		ret = iproc_pcie_map_ranges(pcie, res);
>  		if (ret) {
> -- 
> 2.17.1
> 
