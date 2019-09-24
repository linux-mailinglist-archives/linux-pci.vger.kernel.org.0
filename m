Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6DBCF66
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfIXQ4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 12:56:12 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43272 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410116AbfIXQtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 12:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5p3njTKWFRYupYw459OU2KEBGMe4KVPB8kNFlMTX+bc=; b=Pth/OiJMOveJCcFuddDEm0HpW
        4Yh3FrHr8zb6gXGvfKJnx09Z6yIZLxFUFxvLZxhXyJ43W+XdJSPTNF49lQelgnYCVhovfM+5CBXK0
        coDKyxLrfnGpLLi+IStI8D6XraT3hSWV43coFMrvNMKz/DtLfAg6KjVAys1X0f2AeVxU8c652KDLI
        M3BO3+8QY7gMNgeR0nQUa8zb460X1YXJuDx0VK0gpIyXuN0cmjiGNjc59bSn26mUgksRbgJxfhYnz
        +5AacAbswG+2yAq+zxyrjE+5ycvMAVdE2UL9aT9cR8j0aPkdTi3HWcJg0c2BgHOb+rdZfYZJ/Lgp9
        2IBYMkVng==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43574)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iCo0Q-0002zh-1B; Tue, 24 Sep 2019 17:49:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iCo0I-0001QH-GV; Tue, 24 Sep 2019 17:49:30 +0100
Date:   Tue, 24 Sep 2019 17:49:30 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: mobiveil: Add workaround for unsupported
 request error
Message-ID: <20190924164930.GZ25745@shell.armlinux.org.uk>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-5-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916021742.22844-5-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 10:17:40AM +0800, Xiaowei Bao wrote:
> Errata: unsupported request error on inbound posted write
> transaction, PCIe controller reports advisory error instead
> of uncorrectable error message to RC.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c | 13 +++++++++++++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h           |  4 ++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> index 7bfec51..5bc9ed7 100644
> --- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> @@ -49,6 +49,19 @@ static void ls_pcie_g4_ep_init(struct mobiveil_pcie_ep *ep)
>  	struct mobiveil_pcie *mv_pci = to_mobiveil_pcie_from_ep(ep);
>  	int win_idx;
>  	u8 bar;
> +	u32 val;
> +
> +	/*
> +	 * Errata: unsupported request error on inbound posted write
> +	 * transaction, PCIe controller reports advisory error instead
> +	 * of uncorrectable error message to RC.
> +	 * workaround: set the bit20(unsupported_request_Error_severity) with
> +	 * value 1 in uncorrectable_Error_Severity_Register, make the
> +	 * unsupported request error generate the fatal error.
> +	 */
> +	val =  csr_readl(mv_pci, CFG_UNCORRECTABLE_ERROR_SEVERITY);
> +	val |= 1 << UNSUPPORTED_REQUEST_ERROR_SHIFT;

	       BIT(UNSUPPORTED_REQUEST_ERROR_SHIFT) ?

> +	csr_writel(mv_pci, val, CFG_UNCORRECTABLE_ERROR_SEVERITY);
>  
>  	ep->bar_num = PCIE_LX2_BAR_NUM;
>  
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 7308fa4..a40707e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -123,6 +123,10 @@
>  #define GPEX_BAR_SIZE_UDW		0x4DC
>  #define GPEX_BAR_SELECT			0x4E0
>  
> +#define CFG_UNCORRECTABLE_ERROR_SEVERITY	0x10c
> +#define UNSUPPORTED_REQUEST_ERROR_SHIFT		20
> +#define CFG_UNCORRECTABLE_ERROR_MASK		0x108
> +
>  /* starting offset of INTX bits in status register */
>  #define PAB_INTX_START			5
>  
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
