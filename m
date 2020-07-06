Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237BB215621
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgGFLMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 07:12:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgGFLME (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 07:12:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B84830E;
        Mon,  6 Jul 2020 04:12:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33E2A3F68F;
        Mon,  6 Jul 2020 04:12:03 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:12:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: fix runtime pm imbalance on error
Message-ID: <20200706111200.GE26377@e121166-lin.cambridge.arm.com>
References: <20200520090253.2761-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520090253.2761-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 05:02:53PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index f5c6bf6dfcb8..33c3868e6dbd 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -115,9 +115,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	}
>  
>   err_init:
> -	pm_runtime_put_sync(dev);
> -
>   err_get_sync:
> +	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
>  	phy_count = cdns_plat_pcie->pcie->phy_count;

Applied to pci/runtime-pm, thanks.

Lorenzo
