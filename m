Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3776610CE71
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfK1SSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 13:18:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK1SSP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2019 13:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cDy8YEZHHQmJPDc+EtKXEJdfo3JTJLKwxHKLfb+ViwU=; b=ZN8V4dvOPLqlflxCXO62fyjqu
        /JNAVPtRgb/p4jkc6iKWAA8MbwttszW6pcWbFitQbGl7ffc9zGnmj+l0TWLX5C9Cy30cRgXpCZ8Ph
        dFnP4lPi/EG15cJ98hozwbm9782WXxlzfNbbaayriHNKr1tkKH7da85T7h+i2aOAgjNX5hODEVrTC
        rAhSATZXaTdSif87D7gnPrRmoJV4jGJuxehSYe4Ngd9YA6ouP+rQ+MxO0TexcDhqGFTGnUpUc2bS/
        iSP5v0JWhmn5yAYWQz253IRnLusVZd81/1PuEDamZfQHPLbrqCGFmuUhzkP3KP/hEMtUfyYTyAdMY
        6R2VfRSzA==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaOMm-0000aD-8b; Thu, 28 Nov 2019 18:18:12 +0000
Subject: Re: [PATCH v1 1/1] PCI: dwc: Kconfig: Mark intel PCIe driver depends
 on MSI IRQ Domain
To:     Dilip Kota <eswara.kota@linux.intel.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1574929426.git.eswara.kota@linux.intel.com>
 <96078df4bfb6bb252e9a0a447a65a47c70d1fe7d.1574929426.git.eswara.kota@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5418463a-a212-07a6-1762-c76a48f8e069@infradead.org>
Date:   Thu, 28 Nov 2019 10:18:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <96078df4bfb6bb252e9a0a447a65a47c70d1fe7d.1574929426.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/28/19 12:31 AM, Dilip Kota wrote:
> Kernel compilation fails for i386 architecture as PCI_MSI_IRQ_DOMAIN
> is not set.
> 
> Synopsys DesignWare framework depends on the PCI_MSI_IRQ_DOMAIN.
> So mark the Intel PCIe controller driver dependency on PCI_MSI_IRQ_DOMAIN
> as it uses the Synopsys DesignWare framework.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>

Passes my previously failing kernel configs.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index e580ae036d77..d8116ed7f3a4 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -212,6 +212,7 @@ config PCIE_ARTPEC6_EP
>  config PCIE_INTEL_GW
>  	bool "Intel Gateway PCIe host controller support"
>  	depends on OF && (X86 || COMPILE_TEST)
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	help
>  	  Say 'Y' here to enable PCIe Host controller support on Intel
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
