Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DAB9B109
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbfHWNfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 09:35:44 -0400
Received: from foss.arm.com ([217.140.110.172]:34574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfHWNfo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 09:35:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F95D28;
        Fri, 23 Aug 2019 06:35:43 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BBA83F718;
        Fri, 23 Aug 2019 06:35:42 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:35:41 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.co, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 02/10] PCI: designware-ep: Add the doorbell mode of
 MSI-X in EP mode
Message-ID: <20190823133540.GE14582@e119886-lin.cambridge.arm.com>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-2-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822112242.16309-2-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 07:22:34PM +0800, Xiaowei Bao wrote:
> Add the doorbell mode of MSI-X in EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Remove the macro of no used.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 14 ++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h    | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 3e2b740..b8388f8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -480,6 +480,20 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
> +				       u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 msg_data;
> +
> +	msg_data = (func_no << PCIE_MSIX_DOORBELL_PF_SHIFT) |
> +		   (interrupt_num - 1);
> +
> +	dw_pcie_writel_dbi(pci, PCIE_MSIX_DOORBELL, msg_data);
> +
> +	return 0;
> +}
> +
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			      u16 interrupt_num)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index a0fdbf7..895a9ef 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -88,6 +88,9 @@
>  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
>  #define PCIE_DBI_RO_WR_EN		BIT(0)
>  
> +#define PCIE_MSIX_DOORBELL		0x948
> +#define PCIE_MSIX_DOORBELL_PF_SHIFT	24
> +
>  /*
>   * iATU Unroll-specific register definitions
>   * From 4.80 core version the address translation will be made by unroll
> @@ -400,6 +403,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u16 interrupt_num);
> +int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
> +				       u16 interrupt_num);
>  void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
>  #else
>  static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> @@ -432,6 +437,13 @@ static inline int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +static inline int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep,
> +						     u8 func_no,
> +						     u16 interrupt_num)
> +{
> +	return 0;
> +}
> +

Looks OK to me.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

>  static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  {
>  }
> -- 
> 2.9.5
> 
