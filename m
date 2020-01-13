Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D213901F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMLbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 06:31:38 -0500
Received: from foss.arm.com ([217.140.110.172]:38102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgAMLbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 06:31:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C6113D5;
        Mon, 13 Jan 2020 03:31:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA5453F6C4;
        Mon, 13 Jan 2020 03:31:36 -0800 (PST)
Date:   Mon, 13 Jan 2020 11:31:35 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 08/12] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Message-ID: <20200113113135.GN42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-9-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-9-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:46:10AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> There are some 8-bit and 16-bit registers in PCIe configuration
> space, so add these accessors accordingly.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V9:
>  - No change
> 
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 37116c2a19fe..750a7fd95bc1 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -182,10 +182,33 @@ static inline u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
>  	return mobiveil_csr_read(pcie, off, 0x4);
>  }
>  
> +static inline u32 mobiveil_csr_readw(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return mobiveil_csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u32 mobiveil_csr_readb(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return mobiveil_csr_read(pcie, off, 0x1);
> +}

Do you think the above two return types should reflect the size of the access?

Thanks,

Andrew Murray

> +
> +
>  static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val,
>  				       u32 off)
>  {
>  	mobiveil_csr_write(pcie, val, off, 0x4);
>  }
>  
> +static inline void mobiveil_csr_writew(struct mobiveil_pcie *pcie, u32 val,
> +				       u32 off)
> +{
> +	mobiveil_csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void mobiveil_csr_writeb(struct mobiveil_pcie *pcie, u32 val,
> +				       u32 off)
> +{
> +	mobiveil_csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> -- 
> 2.17.1
> 
