Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D684410DC
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 21:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhJaU6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 16:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhJaU6C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Oct 2021 16:58:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E4D360F4C;
        Sun, 31 Oct 2021 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635713730;
        bh=oeU9m32KyPvFqKwG3qk6If06NKojmbJC+GcvF27icTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0OlfTtr4h9Ic9fubr4O7eXo+/0zyom8N0wI7bhtBx2ggB7AYxEGYepcPp6CgVSVr
         ReYxvucliRZaAfo1Euib4ragEZvz98FrriA7B9XkatsOzrevcrEx8mWzT6hYNCfT3Q
         18Al0FrsJhYTw3Jl/wXdPEPu49T7lnTgtBHMtvKx/00kEX6sD/l6dLHS2Ha1/rJQ5k
         IohxXLEL758TI1ks5og3KpyLaBDGSyRjNRb7sSNiJovYPjmYnBiDtwPBITNDxPp4tg
         1M9YpzUZhDYdysq18KIJQTIaV8fTPINGtZbLWmcM8ABlFOqOyjd/VEtSSj1B616SBq
         7XzVXRDzPA+3w==
Received: by pali.im (Postfix)
        id 94322E5D; Sun, 31 Oct 2021 21:55:27 +0100 (CET)
Date:   Sun, 31 Oct 2021 21:55:27 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v15 13/13] PCI: kirin: Allow removing the driver
Message-ID: <20211031205527.ochhi72dfu4uidii@pali>
References: <cover.1634812676.git.mchehab+huawei@kernel.org>
 <53b40494252444a9b830827922c4e3a301b8f863.1634812676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b40494252444a9b830827922c4e3a301b8f863.1634812676.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 21 October 2021 11:45:20 Mauro Carvalho Chehab wrote:
> Now that everything is in place at the poweroff sequence,
> this driver can use module_platform_driver(), which allows
> it to be removed.
> 
> Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v15 00/13] at: https://lore.kernel.org/all/cover.1634812676.git.mchehab+huawei@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index fea4d717fff3..cdf568ea0f68 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -827,7 +827,7 @@ static struct platform_driver kirin_pcie_driver = {
>  		.suppress_bind_attrs	= true,

Hello Mauro! I think that you should not set ".suppress_bind_attrs" to
"true" if you want to bind and unbind driver at runtime.

>  	},
>  };
> -builtin_platform_driver(kirin_pcie_driver);
> +module_platform_driver(kirin_pcie_driver);
>  
>  MODULE_DEVICE_TABLE(of, kirin_pcie_match);
>  MODULE_DESCRIPTION("PCIe host controller driver for Kirin Phone SoCs");
> -- 
> 2.31.1
> 
