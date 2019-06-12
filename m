Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D842816
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409151AbfFLNyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 09:54:06 -0400
Received: from foss.arm.com ([217.140.110.172]:53604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409112AbfFLNyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 09:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9224228;
        Wed, 12 Jun 2019 06:54:04 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EDE13F557;
        Wed, 12 Jun 2019 06:54:02 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:54:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 19/20] PCI: mobiveil: Add 8-bit and 16-bit register
 accessors
Message-ID: <20190612135400.GB15747@redmoon>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-20-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412083635.33626-20-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:37:05AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> There are some 8-bit and 16-bit registers in PCIe
> configuration space, so add accessors for them.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V5:
>  - Corrected and retouched the subject and changelog.
>  - No functionality change.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 411e9779da12..456adfee393c 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -268,11 +268,31 @@ static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
>  	return csr_read(pcie, off, 0x4);
>  }
>  
> +static u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return csr_read(pcie, off, 0x2);
> +}
> +
> +static u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return csr_read(pcie, off, 0x1);
> +}
> +
>  static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
>  {
>  	csr_write(pcie, val, off, 0x4);
>  }
>  
> +static void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +	csr_write(pcie, val, off, 0x2);
> +}
> +
> +static void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +	csr_write(pcie, val, off, 0x1);
> +}
> +

They are not used so you should drop this patch.

Lorenzo

>  static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
>  {
>  	return (csr_readl(pcie, LTSSM_STATUS) &
> -- 
> 2.17.1
> 
