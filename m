Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA36311FA
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaQKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 12:10:01 -0400
Received: from foss.arm.com ([217.140.101.70]:53860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaQKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 12:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CA07341;
        Fri, 31 May 2019 09:10:00 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459BB3F59C;
        Fri, 31 May 2019 09:09:59 -0700 (PDT)
Date:   Fri, 31 May 2019 17:09:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rgummal@xilinx.com, marc.zyngier@arm.com
Subject: Re: [PATCH v3] PCI: xilinx-nwl: Fix Multi MSI data programming
Message-ID: <20190531160956.GB9356@redmoon>
References: <1559133469-11981-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559133469-11981-1-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Marc]

On Wed, May 29, 2019 at 06:07:49PM +0530, Bharat Kumar Gogada wrote:
> The current Multi MSI data programming fails if multiple end points
> requesting MSI and multi MSI are connected with switch, i.e the current
> multi MSI data being given is not considering the number of vectors
> being requested in case of multi MSI.
> Ex: Two EP's connected via switch, EP1 requesting single MSI first,
> EP2 requesting Multi MSI of count four. The current code gives
> MSI data 0x0 to EP1 and 0x1 to EP2, but EP2 can modify lower two bits
> due to which EP2 also sends interrupt with MSI data 0x0 which results
> in always invoking virq of EP1 due to which EP2 MSI interrupt never
> gets handled.

If this is a problem it is not the only driver where it should be fixed
it seems. CC'ed Marc in case I have missed something in relation to MSI
IRQs but AFAIU it looks like HW is allowed to toggled bits (according to
bits[6:4] in Message Control for MSI) in the MSI data, given that the
data written is the hwirq number (in this specific MSI controller)
it ought to be fixed.

The commit log and patch should be rewritten (I will do that) but
first I would like to understand if there are more drivers to be
updated.

Lorenzo

> Fix Multi MSI data programming with required alignment by
> using number of vectors being requested.
> 
> Fixes: ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe
> Host Controller")
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
> V3:
>  - Added example description of the issue
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 81538d7..8efcb8a 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -483,7 +483,16 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	int i;
>  
>  	mutex_lock(&msi->lock);
> -	bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> +
> +	/*
> +	 * Multi MSI count is requested in power of two
> +	 * Check if multi msi is requested
> +	 */
> +	if (nr_irqs % 2 == 0)
> +		bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
> +					 nr_irqs, nr_irqs - 1);
> +	else
> +		bit = bitmap_find_next_zero_area(msi->bitmap, INT_PCI_MSI_NR, 0,
>  					 nr_irqs, 0);
>  	if (bit >= INT_PCI_MSI_NR) {
>  		mutex_unlock(&msi->lock);
> -- 
> 2.7.4
> 
