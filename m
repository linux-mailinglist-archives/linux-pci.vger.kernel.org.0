Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE31264D94
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIJSol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 14:44:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35239 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgIJR6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 13:58:08 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so8130070ioa.2;
        Thu, 10 Sep 2020 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxfApMJ0EUmdYdIgNKbi7UhLfWBEbGugyTzK4PjTtv0=;
        b=OhAEFoInHVlFGAUeYSCy8tdSKIM7VX+cZyo0rKGnBbVX3v/fA9wrHEGdg5xGoY1fqQ
         vQdz/l4kXwg0bPDRVGaDevfKr0MLYNyZPka91sYPdzNL8e7gzWsuYEpbmJ4h6HmfPErM
         pk8pLNGI7xmITNQb89TMkJq/tB8NoAiNvIUCfuwwKNggfW3StKKAuiX4fsBanH3ZrHDH
         4beJAXUcLjn+h8GTq9TE5v9ZrKVE/Pax8OBlGH5DAcee5gM6g9k8+DqJN2462E9Ykg+F
         OyP6koppn7QI5x5HnwZEbRSSHHvdKJKa/vptWVCdIPsKs+fvxEk4lIiuBcIDz2kUxNRA
         NZnA==
X-Gm-Message-State: AOAM533RxKR+YeBMrRayGkx4vlY9zfv4EEqIzH+SAPlYjOYleNL0GbF6
        N4W8Q3BJYoDBwRAqBxrtfUDPOzqInl48
X-Google-Smtp-Source: ABdhPJzHuaedQqz87WQhJT7BVc3Tmt6QFnyUykz+EZLkaJGLKC8fc3S8Bjou486WTPNTEl6SJdSQVg==
X-Received: by 2002:a05:6638:2a6:: with SMTP id d6mr9888898jaq.132.1599760686431;
        Thu, 10 Sep 2020 10:58:06 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id h15sm3376285ils.74.2020.09.10.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:58:05 -0700 (PDT)
Received: (nullmailer pid 595458 invoked by uid 1000);
        Thu, 10 Sep 2020 17:58:04 -0000
Date:   Thu, 10 Sep 2020 11:58:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com, mingkai.hu@nxp.com,
        minghuan.Lian@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv7 02/12] PCI: designware-ep: Add the doorbell mode of
 MSI-X in EP mode
Message-ID: <20200910175804.GA592152@bogus>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
 <20200811095441.7636-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811095441.7636-3-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 11, 2020 at 05:54:31PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add the doorbell mode of MSI-X in DWC EP driver.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V7:
>  - Rebase the patch without functionality change.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 14 ++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h    | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index e5bd3a5ef380..e76b504ed465 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -471,6 +471,20 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,

return void. It never has an error.

It could also just be an inline function.

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
> index 89f8271ec5ee..745b4938225a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -97,6 +97,9 @@
>  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
>  #define PCIE_DBI_RO_WR_EN		BIT(0)
>  
> +#define PCIE_MSIX_DOORBELL		0x948
> +#define PCIE_MSIX_DOORBELL_PF_SHIFT	24
> +
>  #define PCIE_PL_CHK_REG_CONTROL_STATUS			0xB20
>  #define PCIE_PL_CHK_REG_CHK_REG_START			BIT(0)
>  #define PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS		BIT(1)
> @@ -434,6 +437,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num);
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u16 interrupt_num);
> +int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
> +				       u16 interrupt_num);
>  void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
>  #else
>  static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> @@ -475,6 +480,13 @@ static inline int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
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
>  static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  {
>  }
> -- 
> 2.17.1
> 
